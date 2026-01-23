import scala.collection.mutable
import scala.io.Source.fromFile
import scala.util.matching.Regex

@main
def part2() = 
  var replace: List[(String, String)] = List()
  var mole = ""
  var ans = Set[String]()
  val path = "../input"
  val source = fromFile(path)
  for line <- source.getLines() do
    val reg: Regex = """(\w+) => (\w+)""".r
    reg.findFirstMatchIn(line) match 
      case Some(pair) => 
        replace = (pair.group(2), pair.group(1)) :: replace
      case None => 
        if line != "" then
          mole = line

  val visited = mutable.Set[String]()
  var minSteps = Int.MaxValue
  replace = replace.sortBy(-_._1.length)

  def dfs(current: String, steps: Int): Option[Int] = 
    if current == "e" then return Some(steps)
    if visited.contains(current) then return None
    visited.add(current) 

    for (to, from) <- replace do
      var index = current.indexOf(to)
      while index >= 0 do
        val nextMolecule = current.substring(0, index) + from + current.substring(index + to.length)
        val result = dfs(nextMolecule, steps + 1)
        if result.isDefined then return result
        index = current.indexOf(to, index + 1)

    None
  val res = dfs(mole, 0)
  res match
    case Some(steps) => println(s"Part 2 Answer: $steps")
    case None => println("none")
  


