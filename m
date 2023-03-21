Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A56C375B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 17:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCUQtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCUQtO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 12:49:14 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2E2799B;
        Tue, 21 Mar 2023 09:48:55 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 136A5200408;
        Tue, 21 Mar 2023 17:48:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1679417333;
        bh=jXQPyojAoD+l4poV3Lz0FBrihFtgka9KFyhxR+nKzUE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mJztBaJQPszW29g/Axq0mN3Cglj/T2Ke0ObAs3Vm+HH94VnoigkPaN2iPbQorDfyF
         T++2/TPJg5wDqfQOZ1f1nN/KyOpM9KPI4ycL2CJz4LoCpBHPdxT+trhDGyY0K22UxJ
         0sHX356cxHF2QqrgzvOgyjgC/o6jVRIx5iLqM0rVuCOrV3fqS1UJDMVjF3ahfuSG35
         u8Axfa7vP5bwnDD6Y8pUgCD+lp8h0451iE7xzL/05SmRm7gGVqTS3TES1KxhbaGg/u
         RYnotG2z8lcekx+rkAnsRc5UzwcEV0DUQtSwxf+dVyDLpjy0LsKLYE0U/N1o/zWvip
         CZlO9IFBQha/Q==
Message-ID: <2c4c99da-00c6-ff75-7763-16c75cb7872d@free.fr>
Date:   Tue, 21 Mar 2023 17:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Performance lower than expected with BCM4359/9 on S905X2
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-wireless@vger.kernel.org, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
 <ce0bd9a5-e44d-b30b-3434-9d5fd36e251a@free.fr>
 <1jcz526w53.fsf@starbuckisacylon.baylibre.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <1jcz526w53.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/03/2023 14:54, Jerome Brunet wrote:

> High-speed MMC modes are usually defined/limited per boards.
> Check the different  DTs in arch/arm64/boot/dts/amlogic, you'll see
> that not all have the same configs.

Some of my confusion came from the fact that the device trees for
"amlogic,g12a" boards in mainline did share sd_emmc_a configuration.
Hence my (likely flawed) meson-g12a-ref-design-brcm-rf.dtsi proposal.

> Yes the S905X2 has the bounce buffer work-around which plays a role on
> the overall performance. MMC high-speed modes is critical just has well.
> 
> The Amlogic 4.9 downstream does all kinds of fancy (and unsafe) things
> to enable higher modes.
> 
> So there is no assumption here, merely a tentative to get a clearer
> picture.

It looks like you were right, and I was wrong:

I have 2 g12a boards that are supposed to be "strictly equivalent".
One has an AP6398SR3 WiFi module.
The other has an AP6398SR32 WiFi module.

I booted both boards 10 times.

AP6398SR3  board mmc2 probes: 10 OK
AP6398SR32 board mmc2 probes:  1 OK + 9 KO

Therefore, the mmc2 issue is /indeed/ board-specific.

Thanks for steering me in the right direction.

For reference, the 3 kernel logs.
AP6398SR3-OK, AP6398SR32-OK, AP6398SR32-KO


AP6398SR3-OK
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.2.0-rc8 (mgonzalez@venus) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #424 SMP PREEMPT Tue Mar 21 16:20:06 CET 2023
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
[    0.000000] percpu: Embedded 19 pages/cpu s37480 r8192 d32152 u77824
[    0.000000] pcpu-alloc: s37480 r8192 d32152 u77824 alloc=19*4096
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
[    0.000000] Memory: 1628496K/2097152K available (7872K kernel code, 1004K rwdata, 2512K rodata, 18688K init, 396K bss, 75440K reserved, 393216K cma-reserved)
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
[    0.000195] Console: colour dummy device 80x25
[    0.000229] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000242] pid_max: default: 32768 minimum: 301
[    0.000395] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000413] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.001747] cblist_init_generic: Setting adjustable number of callback queues.
[    0.001760] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001827] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001976] rcu: Hierarchical SRCU implementation.
[    0.001983] rcu:     Max phase no-delay instances is 1000.
[    0.002645] smp: Bringing up secondary CPUs ...
[    0.003171] Detected VIPT I-cache on CPU1
[    0.003306] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.003867] Detected VIPT I-cache on CPU2
[    0.003947] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.004440] Detected VIPT I-cache on CPU3
[    0.004531] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.004587] smp: Brought up 1 node, 4 CPUs
[    0.004595] SMP: Total of 4 processors activated.
[    0.004602] CPU features: detected: 32-bit EL0 Support
[    0.004608] CPU features: detected: CRC32 instructions
[    0.004678] CPU: All CPU(s) started at EL2
[    0.004683] alternatives: applying system-wide alternatives
[    0.005822] devtmpfs: initialized
[    0.015522] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.015554] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.025214] pinctrl core: initialized pinctrl subsystem
[    0.026216] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.027384] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.027572] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.027696] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.027757] audit: initializing netlink subsys (disabled)
[    0.027875] audit: type=2000 audit(0.024:1): state=initialized audit_enabled=0 res=1
[    0.028213] thermal_sys: Registered thermal governor 'step_wise'
[    0.028247] cpuidle: using governor menu
[    0.028313] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.028395] ASID allocator initialised with 32768 entries
[    0.042700] platform ff900000.vpu: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.047042] platform hdmi-connector: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.049047] KASLR enabled
[    0.051425] iommu: Default domain type: Translated 
[    0.051436] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.051705] SCSI subsystem initialized
[    0.051836] usbcore: registered new interface driver usbfs
[    0.051869] usbcore: registered new interface driver hub
[    0.051898] usbcore: registered new device driver usb
[    0.053583] clocksource: Switched to clocksource arch_sys_counter
[    0.059559] NET: Registered PF_INET protocol family
[    0.059755] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.061272] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.061326] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.061340] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.061452] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.061894] TCP: Hash tables configured (established 16384 bind 16384)
[    0.062001] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.062050] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.062205] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.064800] Initialise system trusted keyrings
[    0.065051] workingset: timestamp_bits=62 max_order=19 bucket_order=0
[    0.100654] Key type asymmetric registered
[    0.100674] Asymmetric key parser 'x509' registered
[    0.100786] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.100794] io scheduler mq-deadline registered
[    0.100798] io scheduler kyber registered
[    0.101273] irq_meson_gpio: 100 to 8 gpio interrupt mux initialized
[    0.113373] soc soc0: Amlogic Meson G12A (S905X2) Revision 28:b (40:2) Detected
[    0.115274] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.115338] printk: console [ttyAML0] enabled
[    0.835236] loop: module loaded
[    0.838397] usbcore: registered new interface driver usb-storage
[    0.839137] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    0.847591] meson-vrtc ff8000a8.rtc: registered as rtc0
[    0.851823] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    0.859924] i2c_dev: i2c /dev entries driver
[    0.870974] meson-sm: secure-monitor enabled
[    0.871157] hid: raw HID events driver (C) Jiri Kosina
[    0.875025] usbcore: registered new interface driver usbhid
[    0.880236] usbhid: USB HID core driver
[    0.884898] optee: probing for conduit method.
[    0.888446] optee: revision 2.4
[    0.889281] optee: initialized driver
[    0.895375] NET: Registered PF_PACKET protocol family
[    0.900178] Key type dns_resolver registered
[    0.907179] registered taskstats version 1
[    0.908487] Loading compiled-in X.509 certificates
[    0.980332] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[    0.981306] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[    0.987523] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[    0.993843] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[    1.000491] meson8b-dwmac ff3f0000.ethernet:         DWMAC1000
[    1.005635] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[    1.013048] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[    1.020464] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[    1.025638] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[    1.032626] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[    1.039058] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[    1.044875] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[    1.050651] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    1.059842] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    1.063770] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
[    1.071897] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.074384] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    1.082065] xhci-hcd xhci-hcd.1.auto: hcc params 0x0228fe6c hci version 0x110 quirks 0x0000000000010010
[    1.091305] xhci-hcd xhci-hcd.1.auto: irq 18, io mem 0xff500000
[    1.097253] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.102580] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    1.110173] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.117049] hub 1-0:1.0: USB hub found
[    1.120360] hub 1-0:1.0: 2 ports detected
[    1.124568] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.132610] hub 2-0:1.0: USB hub found
[    1.136053] hub 2-0:1.0: 1 port detected
[    1.140946] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    1.141078] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.146373] P+
[    1.151742] P+
[    1.156022] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.167086] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.180636] Q
[    1.183274] Freeing unused kernel memory: 18688K
[    1.184986] Q
[    1.197631] Run /init as init process
[    1.197655]   with arguments:
[    1.200143]     /init
[    1.202440]   with environment:
[    1.205492]     HOME=/
[    1.207827]     TERM=linux
[    1.303713] sdio_read_cis: vendor=2d0 dev=4359
[    1.304138] sdio_read_cis: vendor=2d0 dev=4359
[    1.304612] sdio_read_cis: vendor=2d0 dev=4359
[    1.307367] mmc2: new ultra high speed SDR50 SDIO card at address 0001
[    1.318871] brcmfmac: F1 signature read @0x18000000=0x17294359
[    1.324182] brcmfmac: BCM4359/9: chip=4359 rev=9
[    1.326441] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4359-sdio for chip BCM4359/9
[    1.337248] brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac4359-sdio.seirobotics,sei510.bin failed with error -2
[    1.343842] mmc1: new HS200 MMC card at address 0001
[    1.349665] brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac4359-sdio.clm_blob failed with error -2
[    1.354229] mmcblk1: mmc1:0001 8GTF4R 7.28 GiB 
[    1.369374] mmcblk1boot0: mmc1:0001 8GTF4R 4.00 MiB 
[    1.373776] mmcblk1boot1: mmc1:0001 8GTF4R 4.00 MiB 
[    1.378461] mmcblk1rpmb: mmc1:0001 8GTF4R 512 KiB, chardev (247:0)
[    1.613594] random: crng init done
[    1.705196] brcmfmac: brcmf_wcc_attach: executing
[    1.706001] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[    1.715478] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4359/9 wl0: Dec  3 2021 10:19:31 version 9.87.51.11.79 (g6ac4dbb) FWID 01-154df7ac



AP6398SR32-OK
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.2.0-rc8 (mgonzalez@venus) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #424 SMP PREEMPT Tue Mar 21 16:20:06 CET 2023
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
[    0.000000] percpu: Embedded 19 pages/cpu s37480 r8192 d32152 u77824
[    0.000000] pcpu-alloc: s37480 r8192 d32152 u77824 alloc=19*4096
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
[    0.000000] Memory: 1628496K/2097152K available (7872K kernel code, 1004K rwdata, 2512K rodata, 18688K init, 396K bss, 75440K reserved, 393216K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000174] Console: colour dummy device 80x25
[    0.000205] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000216] pid_max: default: 32768 minimum: 301
[    0.000345] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000360] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.001526] cblist_init_generic: Setting adjustable number of callback queues.
[    0.001540] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001601] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001733] rcu: Hierarchical SRCU implementation.
[    0.001737] rcu: 	Max phase no-delay instances is 1000.
[    0.002324] smp: Bringing up secondary CPUs ...
[    0.002793] Detected VIPT I-cache on CPU1
[    0.002912] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.003421] Detected VIPT I-cache on CPU2
[    0.003494] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.003952] Detected VIPT I-cache on CPU3
[    0.004024] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.004080] smp: Brought up 1 node, 4 CPUs
[    0.004087] SMP: Total of 4 processors activated.
[    0.004092] CPU features: detected: 32-bit EL0 Support
[    0.004095] CPU features: detected: CRC32 instructions
[    0.004155] CPU: All CPU(s) started at EL2
[    0.004158] alternatives: applying system-wide alternatives
[    0.005157] devtmpfs: initialized
[    0.013190] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.013214] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.023485] pinctrl core: initialized pinctrl subsystem
[    0.024410] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.025514] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.025709] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.025838] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.025895] audit: initializing netlink subsys (disabled)
[    0.026000] audit: type=2000 audit(0.024:1): state=initialized audit_enabled=0 res=1
[    0.026261] thermal_sys: Registered thermal governor 'step_wise'
[    0.026290] cpuidle: using governor menu
[    0.026350] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.026424] ASID allocator initialised with 32768 entries
[    0.039069] platform ff900000.vpu: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.042533] platform hdmi-connector: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.044677] KASLR enabled
[    0.046673] iommu: Default domain type: Translated 
[    0.046682] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.046898] SCSI subsystem initialized
[    0.047002] usbcore: registered new interface driver usbfs
[    0.047029] usbcore: registered new interface driver hub
[    0.047053] usbcore: registered new device driver usb
[    0.048399] clocksource: Switched to clocksource arch_sys_counter
[    0.053637] NET: Registered PF_INET protocol family
[    0.053807] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.055319] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.055372] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.055383] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.055492] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.055909] TCP: Hash tables configured (established 16384 bind 16384)
[    0.056007] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.056053] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.056186] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.065884] Initialise system trusted keyrings
[    0.066162] workingset: timestamp_bits=62 max_order=19 bucket_order=0
[    0.101480] Key type asymmetric registered
[    0.101498] Asymmetric key parser 'x509' registered
[    0.101595] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.101601] io scheduler mq-deadline registered
[    0.101606] io scheduler kyber registered
[    0.101970] irq_meson_gpio: 100 to 8 gpio interrupt mux initialized
[    0.111655] soc soc0: Amlogic Meson G12A (S905X2) Revision 28:e (40:2) Detected
[    0.113290] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.113335] printk: console [ttyAML0] enabled
[    0.832228] loop: module loaded
[    0.834940] usbcore: registered new interface driver usb-storage
[    0.837072] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    0.845544] meson-vrtc ff8000a8.rtc: registered as rtc0
[    0.849784] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    0.857876] i2c_dev: i2c /dev entries driver
[    0.867915] meson-sm: secure-monitor enabled
[    0.868087] hid: raw HID events driver (C) Jiri Kosina
[    0.868186] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    0.871951] usbcore: registered new interface driver usbhid
[    0.877784] P+
[    0.882617] usbhid: USB HID core driver
[    0.888861] optee: probing for conduit method.
[    0.892457] optee: revision 2.4
[    0.893286] optee: initialized driver
[    0.899359] NET: Registered PF_PACKET protocol family
[    0.904193] Key type dns_resolver registered
[    0.911118] registered taskstats version 1
[    0.912554] Loading compiled-in X.509 certificates
[    0.917269] Q
[    0.997019] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[    0.999667] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[    1.005847] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[    1.012308] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[    1.018736] meson8b-dwmac ff3f0000.ethernet: 	DWMAC1000
[    1.023904] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[    1.031342] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[    1.038735] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[    1.043910] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[    1.050914] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[    1.057452] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[    1.058833] sdio_read_cis: vendor=2d0 dev=aae7
[    1.063146] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[    1.063636] sdio_read_cis: vendor=2d0 dev=aae7
[    1.067547] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    1.073334] mmc2: new ultra high speed SDR50 SDIO card at address 0001
[    1.079039] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    1.086249] brcmfmac: F1 signature read @0x18000000=0x1042aae8
[    1.092128] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
[    1.097443] brcmfmac: BCM43752/2: chip=aae8 rev=2
[    1.106166] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.111064] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43752-sdio for chip BCM43752/2
[    1.112927] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    1.118463] brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac43752-sdio.seirobotics,sei510.bin failed with error -2
[    1.127083] xhci-hcd xhci-hcd.1.auto: hcc params 0x0228fe6c hci version 0x110 quirks 0x0000000000010010
[    1.134594] brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac43752-sdio.bin failed with error -2
[    1.145899] xhci-hcd xhci-hcd.1.auto: irq 19, io mem 0xff500000
[    1.170789] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.176141] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    1.183728] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.190555] hub 1-0:1.0: USB hub found
[    1.193915] hub 1-0:1.0: 2 ports detected
[    1.198083] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.206131] hub 2-0:1.0: USB hub found
[    1.209610] hub 2-0:1.0: 1 port detected
[    1.214428] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.219973] P+
[    1.228847] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.237314] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.249695] Freeing unused kernel memory: 18688K
[    1.251742] Q
[    1.276446] Run /init as init process
[    1.276468]   with arguments:
[    1.278955]     /init
[    1.281206]   with environment:
[    1.284303]     HOME=/
[    1.286638]     TERM=linux
[    1.360426] mmc1: new HS200 MMC card at address 0001
[    1.360953] mmcblk1: mmc1:0001 SCA16G 14.7 GiB 
[    1.366211] mmcblk1boot0: mmc1:0001 SCA16G 4.00 MiB 
[    1.370050] mmcblk1boot1: mmc1:0001 SCA16G 4.00 MiB 
[    1.374843] mmcblk1rpmb: mmc1:0001 SCA16G 4.00 MiB, chardev (247:0)



AP6398SR32-KO
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.2.0-rc8 (mgonzalez@venus) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #424 SMP PREEMPT Tue Mar 21 16:20:06 CET 2023
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
[    0.000000] percpu: Embedded 19 pages/cpu s37480 r8192 d32152 u77824
[    0.000000] pcpu-alloc: s37480 r8192 d32152 u77824 alloc=19*4096
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
[    0.000000] Memory: 1628496K/2097152K available (7872K kernel code, 1004K rwdata, 2512K rodata, 18688K init, 396K bss, 75440K reserved, 393216K cma-reserved)
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
[    0.000172] Console: colour dummy device 80x25
[    0.000202] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000212] pid_max: default: 32768 minimum: 301
[    0.000342] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000358] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.001523] cblist_init_generic: Setting adjustable number of callback queues.
[    0.001538] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001598] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.001730] rcu: Hierarchical SRCU implementation.
[    0.001734] rcu:     Max phase no-delay instances is 1000.
[    0.002334] smp: Bringing up secondary CPUs ...
[    0.002807] Detected VIPT I-cache on CPU1
[    0.002926] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.003437] Detected VIPT I-cache on CPU2
[    0.003510] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.003967] Detected VIPT I-cache on CPU3
[    0.004041] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.004093] smp: Brought up 1 node, 4 CPUs
[    0.004101] SMP: Total of 4 processors activated.
[    0.004106] CPU features: detected: 32-bit EL0 Support
[    0.004110] CPU features: detected: CRC32 instructions
[    0.004172] CPU: All CPU(s) started at EL2
[    0.004175] alternatives: applying system-wide alternatives
[    0.005177] devtmpfs: initialized
[    0.013200] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.013223] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.022587] pinctrl core: initialized pinctrl subsystem
[    0.023479] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.024593] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.024790] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.024918] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.024979] audit: initializing netlink subsys (disabled)
[    0.025087] audit: type=2000 audit(0.024:1): state=initialized audit_enabled=0 res=1
[    0.025366] thermal_sys: Registered thermal governor 'step_wise'
[    0.025397] cpuidle: using governor menu
[    0.025463] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.025541] ASID allocator initialised with 32768 entries
[    0.038212] platform ff900000.vpu: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.041691] platform hdmi-connector: Fixing up cyclic dependency with ff600000.hdmi-tx
[    0.043821] KASLR enabled
[    0.045868] iommu: Default domain type: Translated 
[    0.045878] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.046105] SCSI subsystem initialized
[    0.046213] usbcore: registered new interface driver usbfs
[    0.046240] usbcore: registered new interface driver hub
[    0.046265] usbcore: registered new device driver usb
[    0.047672] clocksource: Switched to clocksource arch_sys_counter
[    0.052977] NET: Registered PF_INET protocol family
[    0.053176] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.054711] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.054738] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.054749] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.054858] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.055273] TCP: Hash tables configured (established 16384 bind 16384)
[    0.055372] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.055418] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.055556] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.065089] Initialise system trusted keyrings
[    0.065389] workingset: timestamp_bits=62 max_order=19 bucket_order=0
[    0.101516] Key type asymmetric registered
[    0.101533] Asymmetric key parser 'x509' registered
[    0.101630] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.101636] io scheduler mq-deadline registered
[    0.101640] io scheduler kyber registered
[    0.102007] irq_meson_gpio: 100 to 8 gpio interrupt mux initialized
[    0.111807] soc soc0: Amlogic Meson G12A (S905X2) Revision 28:e (40:2) Detected
[    0.113377] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.113418] printk: console [ttyAML0] enabled
[    0.832379] loop: module loaded
[    0.834988] usbcore: registered new interface driver usb-storage
[    0.837163] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    0.845615] meson-vrtc ff8000a8.rtc: registered as rtc0
[    0.849864] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    0.857954] i2c_dev: i2c /dev entries driver
[    0.868202] meson-sm: secure-monitor enabled
[    0.868376] hid: raw HID events driver (C) Jiri Kosina
[    0.868462] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    0.872218] usbcore: registered new interface driver usbhid
[    0.878104] P+
[    0.882897] usbhid: USB HID core driver
[    0.883872] optee: probing for conduit method.
[    0.892740] optee: revision 2.4
[    0.893557] optee: initialized driver
[    0.899640] NET: Registered PF_PACKET protocol family
[    0.904482] Key type dns_resolver registered
[    0.911296] registered taskstats version 1
[    0.912803] Loading compiled-in X.509 certificates
[    0.916613] Q
[    0.927087] mmc2: YO no device WTF
[    0.981471] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[    0.985842] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[    0.991982] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[    0.998301] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[    1.004964] meson8b-dwmac ff3f0000.ethernet:         DWMAC1000
[    1.010153] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[    1.017549] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[    1.024965] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[    1.030139] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[    1.037126] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[    1.043549] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[    1.049375] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[    1.055152] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    1.064180] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    1.068265] dwc3-meson-g12a ffe09000.usb: USB3 ports: 1
[    1.076318] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.078876] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    1.086557] xhci-hcd xhci-hcd.1.auto: hcc params 0x0228fe6c hci version 0x110 quirks 0x0000000000010010
[    1.095823] xhci-hcd xhci-hcd.1.auto: irq 19, io mem 0xff500000
[    1.101720] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.107079] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    1.114669] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.121487] hub 1-0:1.0: USB hub found
[    1.124857] hub 1-0:1.0: 2 ports detected
[    1.129029] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.137077] hub 2-0:1.0: USB hub found
[    1.140556] hub 2-0:1.0: 1 port detected
[    1.145341] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.150927] P+
[    1.159710] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.168371] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.180963] Freeing unused kernel memory: 18688K
[    1.182942] Q
[    1.199720] Run /init as init process
[    1.199743]   with arguments:
[    1.202229]     /init
[    1.204484]   with environment:
[    1.207577]     HOME=/
[    1.209911]     TERM=linux
[    1.291656] mmc1: new HS200 MMC card at address 0001
[    1.292148] mmcblk1: mmc1:0001 SCA16G 14.7 GiB 
[    1.297426] mmcblk1boot0: mmc1:0001 SCA16G 4.00 MiB 
[    1.301292] mmcblk1boot1: mmc1:0001 SCA16G 4.00 MiB 
[    1.306056] mmcblk1rpmb: mmc1:0001 SCA16G 4.00 MiB, chardev (247:0)


