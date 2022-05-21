# CocktailDB.jl

[![](https://img.shields.io/github/v/tag/thechampagne/CocktailDB.jl?label=version)](https://github.com/thechampagne/CocktailDB.jl/releases/latest) [![](https://img.shields.io/github/license/thechampagne/CocktailDB.jl)](https://github.com/thechampagne/CocktailDB.jl/blob/main/LICENSE)

CocktailDB API client for **Julia**.

### Download

**Julia pkg REPL**

write `]` to enter the pkg repl 

```
add CocktailDB
```
**Julia REPL**
```
using Pkg; Pkg.add("CocktailDB")
```

### Example

```julia
using CocktailDB

for i in search("Vodka")
    println(i["strDrink"])
end
```

### License

CocktailDB API client is released under the [Apache License 2.0](https://github.com/thechampagne/CocktailDB.jl/blob/main/LICENSE).

```
 Copyright 2022 XXIV

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
```