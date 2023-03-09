Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751136B2C5C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCIRwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 12:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCIRwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 12:52:01 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7809FC237;
        Thu,  9 Mar 2023 09:51:57 -0800 (PST)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0BBE92003DA;
        Thu,  9 Mar 2023 18:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678384316;
        bh=oiG5QTeOG4JEYe8yz03UTYdCgQo5fx/1qKqq5k2xfEw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jxwlNPLF1AQrWuoXg57cVzFaOvLmmqzF8C9dJMC58wlFAMBGqPtpUXvub+hkOyg6c
         Zj3HRgHOCS/L9fz3Jw25idB24V1DGMnNguZ6cA9gsIZj41uAAYCGAUIYsjrMfDKeTo
         vQH0vICNzYV7yMX5dDToONOIWjNlUF687PT86OarrZfAtO4b1/oeYEXMgFz2h39Opw
         NwEJ44ifljonRdaXsrczuJKepY5CEuuUXSiaf4a2UQN6uo+mTChSYs8ti7bEt/q1QJ
         ntwGpl4oH4Q7ed8O67nfUoVtexOJJV9GYOEMbP6aFgqEq5iQKpbTG9e8FFPJ3C1Q4b
         tC4cME+TK7uDA==
Message-ID: <0450e34e-7190-104c-832a-150f15f7c825@free.fr>
Date:   Thu, 9 Mar 2023 18:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
 <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09/03/2023 15:29, Ulf Hansson wrote:

> To narrow down the problem, I would start by preventing the WiFi
> driver from being insmoded. To make sure it doesn't affect the SDIO
> card detection process.
> 
> The point is, the SDIO card should be detected properly, no matter
> whether there is a corresponding SDIO func driver (WiFi driver)
> available for it. For a detected SDIO/eMMC/SD card, mmc_add_card()
> prints a message about the card in the log during initialization. It
> could look like the below print, for example:
> 
> "mmc2: new ultra high speed SDR104 SDIO card at address 0001".

OK, I built the WiFi driver as a module which is NOT loaded at boot time.



Here is a kernel log where mmc2 probing went WRONG
(no "mmc2: new ultra high speed SDR50 SDIO card at address 0001")


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.2.0-rc8 (mgonzalez@venus) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #247 SMP PREEMPT Thu Mar  9 18:23:56 CET 2023
[    0.000000] Machine model: SEI Robotics SEI510
[    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
[    0.000000] Reserved memory: created CMA memory pool at 0x0000000068000000, size 384 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000004ffffff]
[    0.000000]   node   0: [mem 0x0000000005000000-0x00000000053fffff]
[    0.000000]   node   0: [mem 0x0000000005400000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 19 pages/cpu s38632 r8192 d31000 u77824
[    0.000000] pcpu-alloc: s38632 r8192 d31000 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 516096
[    0.000000] Kernel command line: console=ttyAML0 debug
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1623888K/2097152K available (8384K kernel code, 1062K rwdata, 2656K rodata, 22592K init, 411K bss, 80048K reserved, 393216K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000188] Console: colour dummy device 80x25
[    0.000219] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000231] pid_max: default: 32768 minimum: 301
[    0.000366] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000382] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.001822] cblist_init_generic: Setting adjustable number of callback queues.
[    0.001837] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001903] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.002042] rcu: Hierarchical SRCU implementation.
[    0.002046] rcu:     Max phase no-delay instances is 1000.
[    0.002709] smp: Bringing up secondary CPUs ...
[    0.003212] Detected VIPT I-cache on CPU1
[    0.003329] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.003862] Detected VIPT I-cache on CPU2
[    0.003936] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.004413] Detected VIPT I-cache on CPU3
[    0.004486] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.004541] smp: Brought up 1 node, 4 CPUs
[    0.004547] SMP: Total of 4 processors activated.
[    0.004551] CPU features: detected: 32-bit EL0 Support
[    0.004555] CPU features: detected: CRC32 instructions
[    0.004612] CPU: All CPU(s) started at EL2
[    0.004615] alternatives: applying system-wide alternatives
[    0.005677] devtmpfs: initialized
[    0.014358] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.014382] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.023672] pinctrl core: initialized pinctrl subsystem
[    0.024497] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.025626] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.025826] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.025959] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.026022] audit: initializing netlink subsys (disabled)
[    0.026131] audit: type=2000 audit(0.024:1): state=initialized audit_enabled=0 res=1
[    0.026425] thermal_sys: Registered thermal governor 'step_wise'
[    0.026457] cpuidle: using governor menu
[    0.026528] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.026606] ASID allocator initialised with 32768 entries
[    0.039376] platform ff900000.vpu: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.042947] platform hdmi-connector: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.045156] KASLR enabled
[    0.047484] iommu: Default domain type: Translated 
[    0.047494] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.047738] SCSI subsystem initialized
[    0.047842] usbcore: registered new interface driver usbfs
[    0.047871] usbcore: registered new interface driver hub
[    0.047897] usbcore: registered new device driver usb
[    0.048551] FPGA manager framework
[    0.049473] clocksource: Switched to clocksource arch_sys_counter
[    0.055073] NET: Registered PF_INET protocol family
[    0.055266] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.056810] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.056859] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.056873] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.056985] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.057400] TCP: Hash tables configured (established 16384 bind 16384)
[    0.057537] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.057591] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.057737] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.066871] Initialise system trusted keyrings
[    0.067114] workingset: timestamp_bits=46 max_order=19 bucket_order=0
[    0.103569] Key type asymmetric registered
[    0.103587] Asymmetric key parser 'x509' registered
[    0.103692] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    0.103699] io scheduler mq-deadline registered
[    0.103703] io scheduler kyber registered
[    0.104140] irq_meson_gpio: 100 to 8 gpio interrupt mux initialized
[    0.104681] simple-pm-bus: probe of ff63c000.system-controller rejects match -19
[    0.105299] simple-pm-bus: probe of ff800000.sys-ctrl rejects match -19
[    0.115611] soc soc0: Amlogic Meson G12A (S905X2) Revision 28:e (40:2) Detected
[    0.117430] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.117503] printk: console [ttyAML0] enabled
[    0.854455] loop: module loaded
[    0.855954] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    0.862491] usbcore: registered new interface driver usb-storage
[    0.867279] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    0.875824] meson-vrtc ff8000a8.rtc: registered as rtc0
[    0.880002] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    0.888109] i2c_dev: i2c /dev entries driver
[    0.894735] psci-cpuidle: probe of psci-cpuidle rejects match -19
[    0.899022] YO: meson_mmc_probe: ffe03000.sd
[    0.899350] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    0.907943] ledtrig-cpu: registered to indicate activity on CPUs
[    0.914215] meson-sm: secure-monitor enabled
[    0.918257] hid: raw HID events driver (C) Jiri Kosina
[    0.923603] usbcore: registered new interface driver usbhid
[    0.928717] usbhid: USB HID core driver
[    0.934114] YO: meson_mmc_probe: ffe03000.sd ALL OK
[    0.935084] optee: probing for conduit method.
[    0.941807] optee: revision 2.4
[    0.942796] optee: initialized driver
[    0.949566] NET: Registered PF_PACKET protocol family
[    0.953499] Key type dns_resolver registered
[    0.961849] registered taskstats version 1
[    0.961962] Loading compiled-in X.509 certificates
[    1.059493] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    1.063406] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[    1.069301] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[    1.075465] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[    1.081970] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[    1.088462] meson8b-dwmac ff3f0000.ethernet:         DWMAC1000
[    1.093599] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[    1.101016] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[    1.108431] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[    1.113610] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[    1.120592] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[    1.127036] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[    1.132841] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[    1.138620] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    1.148085] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    1.151738] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
[    1.160071] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.162353] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    1.170044] xhci-hcd xhci-hcd.1.auto: hcc params 0x0228fe6c hci version 0x110 quirks 0x0000000000010010
[    1.179281] xhci-hcd xhci-hcd.1.auto: irq 20, io mem 0xff500000
[    1.185228] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.190548] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    1.198137] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.205117] hub 1-0:1.0: USB hub found
[    1.208336] hub 1-0:1.0: 2 ports detected
[    1.212595] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.220667] hub 2-0:1.0: USB hub found
[    1.224026] hub 2-0:1.0: 1 port detected
[    1.228908] YO: meson_mmc_probe: ffe07000.mmc
[    1.229222] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.245361] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.255085] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.261508] YO: meson_mmc_probe: ffe07000.mmc ALL OK
[    1.265592] platform regulatory.0: loading /lib/firmware/updates/6.2.0-rc8/regulatory.db failed for no such file or directory.
[    1.271080] Freeing unused kernel memory: 22592K
[    1.276338] platform regulatory.0: loading /lib/firmware/updates/regulatory.db failed for no such file or directory.
[    1.291323] platform regulatory.0: loading /lib/firmware/6.2.0-rc8/regulatory.db failed for no such file or directory.
[    1.301921] platform regulatory.0: Loading firmware from /lib/firmware/regulatory.db
[    1.309555] platform regulatory.0: loading /lib/firmware/updates/6.2.0-rc8/regulatory.db.p7s failed for no such file or directory.
[    1.321185] platform regulatory.0: loading /lib/firmware/updates/regulatory.db.p7s failed for no such file or directory.
[    1.331965] platform regulatory.0: loading /lib/firmware/6.2.0-rc8/regulatory.db.p7s failed for no such file or directory.
[    1.342932] platform regulatory.0: Loading firmware from /lib/firmware/regulatory.db.p7s
[    1.389536] Run /init as init process
[    1.389557]   with arguments:
[    1.390496]     /init
[    1.392826]   with environment:
[    1.395946]     HOME=/
[    1.398258]     TERM=linux
[    1.406077] mmc1: new HS200 MMC card at address 0001
[    1.406841] mmcblk1: mmc1:0001 SCA16G 14.7 GiB 
[    1.413262] mmcblk1boot0: mmc1:0001 SCA16G 4.00 MiB 
[    1.416665] mmcblk1boot1: mmc1:0001 SCA16G 4.00 MiB 
[    1.421334] mmcblk1rpmb: mmc1:0001 SCA16G 4.00 MiB, chardev (246:0)
[    4.041482] random: crng init done




Here is a kernel log where mmc2 probing went RIGHT
(the added printk's changed some timings, I assume)


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.2.0-rc8 (mgonzalez@venus) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #249 SMP PREEMPT Thu Mar  9 18:37:17 CET 2023
[    0.000000] Machine model: SEI Robotics SEI510
[    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
[    0.000000] Reserved memory: created CMA memory pool at 0x0000000068000000, size 384 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000004ffffff]
[    0.000000]   node   0: [mem 0x0000000005000000-0x00000000053fffff]
[    0.000000]   node   0: [mem 0x0000000005400000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 19 pages/cpu s38632 r8192 d31000 u77824
[    0.000000] pcpu-alloc: s38632 r8192 d31000 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 516096
[    0.000000] Kernel command line: console=ttyAML0 debug
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1623888K/2097152K available (8384K kernel code, 1062K rwdata, 2656K rodata, 22592K init, 411K bss, 80048K reserved, 393216K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000189] Console: colour dummy device 80x25
[    0.000220] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000231] pid_max: default: 32768 minimum: 301
[    0.000366] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000381] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.001831] cblist_init_generic: Setting adjustable number of callback queues.
[    0.001844] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001910] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.002053] rcu: Hierarchical SRCU implementation.
[    0.002056] rcu:     Max phase no-delay instances is 1000.
[    0.002710] smp: Bringing up secondary CPUs ...
[    0.003214] Detected VIPT I-cache on CPU1
[    0.003334] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.003869] Detected VIPT I-cache on CPU2
[    0.003947] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.004433] Detected VIPT I-cache on CPU3
[    0.004505] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.004556] smp: Brought up 1 node, 4 CPUs
[    0.004563] SMP: Total of 4 processors activated.
[    0.004567] CPU features: detected: 32-bit EL0 Support
[    0.004571] CPU features: detected: CRC32 instructions
[    0.004634] CPU: All CPU(s) started at EL2
[    0.004636] alternatives: applying system-wide alternatives
[    0.005697] devtmpfs: initialized
[    0.014641] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.014665] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.023935] pinctrl core: initialized pinctrl subsystem
[    0.024793] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.025930] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.026129] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.026260] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.026323] audit: initializing netlink subsys (disabled)
[    0.026432] audit: type=2000 audit(0.024:1): state=initialized audit_enabled=0 res=1
[    0.026732] thermal_sys: Registered thermal governor 'step_wise'
[    0.026765] cpuidle: using governor menu
[    0.026840] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.026919] ASID allocator initialised with 32768 entries
[    0.039724] platform ff900000.vpu: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.043299] platform hdmi-connector: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.045533] KASLR enabled
[    0.047864] iommu: Default domain type: Translated 
[    0.047874] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.048146] SCSI subsystem initialized
[    0.048255] usbcore: registered new interface driver usbfs
[    0.048283] usbcore: registered new interface driver hub
[    0.048310] usbcore: registered new device driver usb
[    0.048941] FPGA manager framework
[    0.049867] clocksource: Switched to clocksource arch_sys_counter
[    0.055483] NET: Registered PF_INET protocol family
[    0.055675] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.057226] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.057278] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.057292] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.057403] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.057814] TCP: Hash tables configured (established 16384 bind 16384)
[    0.057943] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.057997] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.058139] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.067289] Initialise system trusted keyrings
[    0.067550] workingset: timestamp_bits=46 max_order=19 bucket_order=0
[    0.102639] Key type asymmetric registered
[    0.102658] Asymmetric key parser 'x509' registered
[    0.102771] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    0.102778] io scheduler mq-deadline registered
[    0.102782] io scheduler kyber registered
[    0.103224] irq_meson_gpio: 100 to 8 gpio interrupt mux initialized
[    0.103782] simple-pm-bus: probe of ff63c000.system-controller rejects match -19
[    0.104417] simple-pm-bus: probe of ff800000.sys-ctrl rejects match -19
[    0.114877] soc soc0: Amlogic Meson G12A (S905X2) Revision 28:e (40:2) Detected
[    0.116692] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.116739] printk: console [ttyAML0] enabled
[    0.853697] loop: module loaded
[    0.855199] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    0.861696] usbcore: registered new interface driver usb-storage
[    0.866517] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    0.875019] meson-vrtc ff8000a8.rtc: registered as rtc0
[    0.879234] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    0.887343] i2c_dev: i2c /dev entries driver
[    0.893907] psci-cpuidle: probe of psci-cpuidle rejects match -19
[    0.898254] YO: meson_mmc_probe: ffe03000.sd
[    0.898582] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    0.907186] ledtrig-cpu: registered to indicate activity on CPUs
[    0.913444] meson-sm: secure-monitor enabled
[    0.917494] hid: raw HID events driver (C) Jiri Kosina
[    0.922837] usbcore: registered new interface driver usbhid
[    0.927953] usbhid: USB HID core driver
[    0.933271] YO mmc_rescan: mmc2
[    0.933361] YO: meson_mmc_probe: ffe03000.sd ALL OK
[    0.934415] optee: probing for conduit method.
[    0.940795] YO mmc_attach_sdio: mmc2
[    0.944118] optee: revision 2.4
[    0.948523] optee: initialized driver
[    0.955324] NET: Registered PF_PACKET protocol family
[    0.959391] Key type dns_resolver registered
[    0.968932] registered taskstats version 1
[    0.969166] Loading compiled-in X.509 certificates
[    1.078067] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    1.082159] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[    1.087852] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[    1.089252] sdio_read_cis: vendor=2d0 dev=aae7
[    1.094043] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[    1.094607] sdio_read_cis: vendor=2d0 dev=aae7
[    1.099105] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[    1.104334] mmc2: new ultra high speed SDR50 SDIO card at address 0001
[    1.108761] meson8b-dwmac ff3f0000.ethernet:         DWMAC1000
[    1.115947] mmcblk: probe of mmc2:0001 rejects match -19
[    1.122260] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[    1.127571] YO mmc_attach_sdio mmc2=0
[    1.132695] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[    1.151152] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[    1.156327] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[    1.163313] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[    1.169746] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[    1.175564] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[    1.181340] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    1.190835] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    1.194456] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
[    1.202810] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.205064] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    1.212772] xhci-hcd xhci-hcd.1.auto: hcc params 0x0228fe6c hci version 0x110 quirks 0x0000000000010010
[    1.222000] xhci-hcd xhci-hcd.1.auto: irq 20, io mem 0xff500000
[    1.227940] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.233270] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    1.240858] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.247839] hub 1-0:1.0: USB hub found
[    1.251053] hub 1-0:1.0: 2 ports detected
[    1.255315] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.263393] hub 2-0:1.0: USB hub found
[    1.266747] hub 2-0:1.0: 1 port detected
[    1.271625] YO: meson_mmc_probe: ffe07000.mmc
[    1.271940] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.288191] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.297735] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.304321] platform regulatory.0: loading /lib/firmware/updates/6.2.0-rc8/regulatory.db failed for no such file or directory.
[    1.310070] platform regulatory.0: loading /lib/firmware/updates/regulatory.db failed for no such file or directory.
[    1.310072] YO mmc_rescan: mmc1
[    1.310372] YO: meson_mmc_probe: ffe07000.mmc ALL OK
[    1.320590] platform regulatory.0: loading /lib/firmware/6.2.0-rc8/regulatory.db failed for no such file or directory.
[    1.332130] Freeing unused kernel memory: 22592K
[    1.339285] platform regulatory.0: Loading firmware from /lib/firmware/regulatory.db
[    1.351444] YO mmc_attach_sdio: mmc1
[    1.351545] platform regulatory.0: loading /lib/firmware/updates/6.2.0-rc8/regulatory.db.p7s failed for no such file or directory.
[    1.366588] platform regulatory.0: loading /lib/firmware/updates/regulatory.db.p7s failed for no such file or directory.
[    1.377411] platform regulatory.0: loading /lib/firmware/6.2.0-rc8/regulatory.db.p7s failed for no such file or directory.
[    1.377952] Run /init as init process
[    1.388447] platform regulatory.0: Loading firmware from /lib/firmware/regulatory.db.p7s
[    1.391974]   with arguments:
[    1.402862]     /init
[    1.402869] YO mmc_attach_sdio mmc1=-110
[    1.405082]   with environment:
[    1.412076]     HOME=/
[    1.414403]     TERM=linux
[    1.509991] mmc1: new HS200 MMC card at address 0001
[    1.510678] mmcblk1: mmc1:0001 SCA16G 14.7 GiB 
[    1.516496] mmcblk1boot0: mmc1:0001 SCA16G 4.00 MiB 
[    1.520045] mmcblk1boot1: mmc1:0001 SCA16G 4.00 MiB 
[    1.524705] mmcblk1rpmb: mmc1:0001 SCA16G 4.00 MiB, chardev (246:0)
[    4.081875] random: crng init done


I don't think it's enough to pinpoint the issue though?

Regards

