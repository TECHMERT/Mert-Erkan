import Nat32 "mo:base/nat32";
import Trie "mo:base/trie";
import Option "mo:base/option"; 
import List "mo:base/list";
import Text "morbase/text";
import Result "mo:base/result";

actor {

  public type SuperHero={
    name:Text;
    superpowers:List.List<Text>
  };

 public type SuperHeroId = Nat32;

 private stable var next:SuperHeroId=0;

  private stable var superheroes : Trie.Trie<SuperHeroId,SuperHero> = Trie.empty();
  public func createHero(newHero:SuperHero):async Nat32 {
  let id=next;
  next+=1;
  
  superheroes := Trie.replace(
  superheroes,
  key(id),
  Nat32.equal,
  ?newHero
 ).0;

 return id;
};

public func getHero(id:SuperHeroId):async ?SuperHero{
  let result = Trie.find(
    superheroes,
    key(id),
    Nat32.equal
    );
    return result;
};

public func updateHero(id:SuperHeroId,newHero:SuperHero):async Nat32{

  let result=Trie.find(
    superheroes,
    key(id),
    Nat32.equal
  );
  let exists =Options.isSome(result);

  if(exists){
  superheroes:=Trie.replace(
    superheroes,
    key(id)
    Nat32.equal,
    null
  ).0;
  };
  };

 private func key(x:SuperHeroId):Trie.Key<SuperHeroId>{
  {hash =x; key=x;}
 };


};

