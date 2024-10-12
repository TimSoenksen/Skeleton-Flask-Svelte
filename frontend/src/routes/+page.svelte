<script lang="ts">
    import { Button } from "$lib/components/ui/button";
    import { Input } from "$lib/components/ui/input";
    import { Search } from "lucide-svelte";
    import { Accordion, AccordionItem } from "$lib/components/ui/accordion";
  
    let projectName = "Skeleton-Flask-Svelte";
    let searchQuery = "";
  </script>
  
  <main class="container mx-auto p-4">
    <h1 class="text-3xl font-bold mb-4">{projectName}</h1>
    
    <section class="mb-8">
      <h2 class="text-2xl font-semibold mb-2">Project Overview</h2>
      <p>This is a skeleton project designed for quick Docker container setup. It combines a Flask backend with a Svelte frontend, utilizing the shadcn-svelte component library.</p>
    </section>
  
    <section class="mb-8">
      <h2 class="text-2xl font-semibold mb-2">Quick Start</h2>
      <code class="block bg-gray-100 p-2 rounded">docker-compose up --build</code>
    </section>
  
    <section class="mb-8">
      <h2 class="text-2xl font-semibold mb-2">Component Examples</h2>
      
      <div class="flex gap-2 mb-4">
        <Button variant="default">Default Button</Button>
        <Button variant="destructive">Destructive Button</Button>
      </div>
  
      <div class="flex gap-2 mb-4">
        <Input type="text" placeholder="Regular input" />
        <div class="relative">
          <Search class="absolute left-2 top-1/2 transform -translate-y-1/2 text-gray-500" size={20} />
          <Input type="search" placeholder="Search..." class="pl-8" bind:value={searchQuery} />
        </div>
      </div>
  
      <Accordion type="single" collapsible class="w-full">
        <AccordionItem value="item-1">
          <svelte:fragment slot="trigger">Backend Information</svelte:fragment>
          <svelte:fragment slot="content">
            <p>The backend runs on Flask. Currently using SQLite for database storage, but consider Azure SQL Server for multi-container setups.</p>
          </svelte:fragment>
        </AccordionItem>
        <AccordionItem value="item-2">
          <svelte:fragment slot="trigger">Frontend Information</svelte:fragment>
          <svelte:fragment slot="content">
            <p>The frontend is built with Svelte, utilizing the shadcn-svelte component library for pre-made, accessible components.</p>
          </svelte:fragment>
        </AccordionItem>
      </Accordion>
    </section>
  
    <footer class="text-sm text-gray-600">
      <p>Note: Remember to change the port in the Dockerfile and app.py to suit your needs.</p>
    </footer>
  </main>