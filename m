Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBD61F1F3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 12:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiKGLhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 06:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKGLhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 06:37:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF81D40
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 03:37:20 -0800 (PST)
Received: from [IPv6:2804:431:c7c2:1b4f:3c23:4bb6:e920:86e] (unknown [IPv6:2804:431:c7c2:1b4f:3c23:4bb6:e920:86e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E88036601FAA;
        Mon,  7 Nov 2022 11:37:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667821039;
        bh=gNC1tfly6QsHeoWCQfsuRm/5GK99lv7chf7mmdYziZY=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=D++L3LCk3kC47z5H4ieY9HEAgKvkT5ZPyraAT97irnn1IXheAHa00Pc+4Cvj3WmbA
         gEB0Xuq2X4zzhTFsu1qsB3I1hN8EjyNj3gcPqbZtOfbhCRwjYLPGcCeuo+0a5JOPws
         iujXuQbZk14s31xc8ikryDIBofDzR5do519fEXBWa3mEJYBF+h806knogLW96egl5L
         2MzP7hY0EEg1sfkqIikC3kffMSObFOb1hzFKcoYk8czvDKqDZ4TyioxE2PzFrLcNYH
         iGIuOxWFfhwThDVo+/ZgFbCUPZV/UWeMiIIwFomE1B8/adTux7uq+RW/dhN/JHj3Ky
         Z6Q8/nuWyx1KA==
Date:   Mon, 07 Nov 2022 08:36:54 -0300
From:   Collabora <daniel.almeida@collabora.com>
Subject: Re: Bug while resuming from suspend on mt7921e
To:     nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Message-Id: <IX6ZKR.JVEB9NE4EDIF3@collabora.com>
In-Reply-To: <GJ9YKR.V6918C76FSX2@collabora.com>
References: <GJ9YKR.V6918C76FSX2@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sending this again because the first email was rejected by the mailing=20
lists

On Sun, Nov 6 2022 at 08:35:40 PM -03:00:00, Collabora=20
<daniel.almeida@collabora.com> wrote:
> Hi,
>=20
> I have been having some issues with wifi on a beelink gtr5. This=20
> comes with the AMD RZ608, which apparently is just a rebrand on=20
> MT7921K. Pardon/correct me if I am wrong.
>=20
> After suspending,  wi-fi just does not work.
>=20
> modprobe -r mt7921e && modprobe mt7921e works though, i.e. wifi works=20
> again.
>=20
> Dmesg has a few pointers on the issue:
>=20
> [ 8898.932739] mt7921e 0000:03:00.0: Message 000046ed (seq 7) timeout
> [ 8899.011186] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8902.129421] mt7921e 0000:03:00.0: Message 00000010 (seq 8) timeout
> [ 8902.129427] mt7921e 0000:03:00.0: Failed to get patch semaphore
> [ 8902.208409] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8905.329413] mt7921e 0000:03:00.0: Message 00000010 (seq 9) timeout
> [ 8905.329422] mt7921e 0000:03:00.0: Failed to get patch semaphore
> [ 8905.329524] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8908.529746] mt7921e 0000:03:00.0: Message 000046ed (seq 10) timeout
> [ 8908.608858] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8911.729628] mt7921e 0000:03:00.0: Message 00000010 (seq 11) timeout
> [ 8911.729640] mt7921e 0000:03:00.0: Failed to get patch semaphore
> [ 8911.808033] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8914.929423] mt7921e 0000:03:00.0: Message 00000010 (seq 12) timeout
> [ 8914.929431] mt7921e 0000:03:00.0: Failed to get patch semaphore
>=20
>=20
> There's also this oops:
>=20
> [ 9099.559190] ------------[ cut here ]------------
> [ 9099.559192] tasklet SCHED state not set: func 0x0
> [ 9099.559200] WARNING: CPU: 12 PID: 91 at kernel/softirq.c:769=20
> tasklet_clear_sched+0x64/0x70
> [ 9099.559207] Modules linked in: mt7921e mt7921_common tls rfcomm=20
> ccm intel_rapl_msr intel_rapl_common uhid snd_sof_amd_renoir=20
> snd_sof_amd_acp snd_sof_pci cmac snd_sof algif_hash snd_sof_utils=20
> algif_skcipher snd_soc_core af_alg snd_hda_codec_realtek snd_compress=20
> snd_hda_codec_generic bnep ledtrig_audio snd_hda_codec_hdmi ac97_bus=20
> snd_pcm_dmaengine snd_hda_intel mt76_connac_lib snd_rpl_pci_acp6x=20
> btusb snd_intel_dspcfg mt76 snd_intel_sdw_acpi amdgpu snd_acp_pci=20
> btrtl edac_mce_amd snd_pci_acp6x btbcm vfat snd_hda_codec=20
> snd_pci_acp5x btintel fat wmi_bmof mac80211 snd_hda_core gpu_sched=20
> snd_rn_pci_acp3x btmtk kvm_amd snd_hwdep libarc4 bluetooth drm_buddy=20
> r8169 snd_pcm drm_ttm_helper joydev snd_acp_config mousedev=20
> ecdh_generic ttm snd_timer realtek cfg80211 apple_mfi_fastcharge kvm=20
> snd_soc_acpi drm_display_helper snd mdio_devres irqbypass soundcore=20
> rfkill snd_pci_acp3x cec sp5100_tco libphy rapl pcspkr i2c_piix4=20
> k10temp wmi tpm_crb video tpm_tis mac_hid tpm_tis_core crypto_user=20
> amd_pstate fuse
> [ 9099.559253]  bpf_preload ip_tables x_tables ext4 crc32c_generic=20
> crc16 mbcache jbd2 hid_apple usbhid dm_crypt cbc encrypted_keys=20
> trusted asn1_encoder tee tpm dm_mod crct10dif_pclmul crc32_pclmul=20
> crc32c_intel polyval_clmulni polyval_generic gf128mul=20
> ghash_clmulni_intel aesni_intel nvme crypto_simd ccp nvme_core=20
> xhci_pci cryptd rng_core nvme_common xhci_pci_renesas [last unloaded:=20
> mt7921_common]
> [ 9099.559271] CPU: 12 PID: 91 Comm: ksoftirqd/12 Tainted: G        W=20
>          6.0.7-arch1-1 #1 54734d35253fb4c526adcfdfa2e7225be9ec4a9a
> [ 9099.559274] Hardware name: AZW GTR/GTR, BIOS=20
> GTR_V1.24_bLink_P4C5M43 06/08/2022
> [ 9099.559275] RIP: 0010:tasklet_clear_sched+0x64/0x70
> [ 9099.559277] Code: 00 48 c7 c0 5f 90 ea bb 48 8b 57 18 48 c7 c6 73=20
> 7c ea bb 48 0f 45 f0 48 c7 c7 88 b9 f1 bb c6 05 8f b4 d1 01 01 e8 cc=20
> f8 ae 00 <0f> 0b eb b3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44=20
> 00 00 41
> [ 9099.559279] RSP: 0018:ffffbfed40463e58 EFLAGS: 00010282
> [ 9099.559280] RAX: 0000000000000000 RBX: ffff9cad439e8900 RCX:=20
> 0000000000000027
> [ 9099.559281] RDX: ffff9cb3ee921668 RSI: 0000000000000001 RDI:=20
> ffff9cb3ee921660
> [ 9099.559282] RBP: 0000000000000000 R08: 0000000000000000 R09:=20
> ffffbfed40463ce0
> [ 9099.559283] R10: 0000000000000003 R11: ffffffffbc6cb508 R12:=20
> ffff9cb3ee9211d0
> [ 9099.559283] R13: ffff9cad439e89a8 R14: 0000000000000040 R15:=20
> 0000000000000006
> [ 9099.559285] FS:  0000000000000000(0000) GS:ffff9cb3ee900000(0000)=20
> knlGS:0000000000000000
> [ 9099.559286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9099.559287] CR2: 000055da8b0ee558 CR3: 000000028d410000 CR4:=20
> 0000000000750ee0
> [ 9099.559288] PKRU: 55555554
> [ 9099.559289] Call Trace:
> [ 9099.559291]  <TASK>
> [ 9099.559293]  tasklet_action_common.constprop.0+0xa5/0x140
> [ 9099.559296]  __do_softirq+0xd3/0x2ca
> [ 9099.559301]  ? sort_range+0x20/0x20
> [ 9099.559302]  run_ksoftirqd+0x2c/0x40
> [ 9099.559304]  smpboot_thread_fn+0xdc/0x1d0
> [ 9099.559305]  kthread+0xde/0x110
> [ 9099.559308]  ? kthread_complete_and_exit+0x20/0x20
> [ 9099.559309]  ret_from_fork+0x22/0x30
> [ 9099.559315]  </TASK>
>=20
>=20
> Lastly, maybe this helps:
>=20
> [ 9099.563431] mt7921e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build=20
> Time: 20220608210839a
> [ 9099.834344] mt7921e 0000:03:00.0: WM Firmware Version: ____010000,=20
> Build Time: 20220608210922
>=20
> =E2=9D=AF uname -a
> Linux dwls-gtr5 6.0.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 03 Nov 2022=20
> 18:01:58 +0000 x86_64 GNU/Linux
>=20
> Here's some other errors that show up while the system is trying to=20
> suspend:
>=20
> [ 8825.286896] PM: suspend entry (deep)
> [ 8825.291609] Filesystems sync: 0.004 seconds
> [ 8825.311418] Freezing user space processes ... (elapsed 0.001=20
> seconds) done.
> [ 8825.312771] OOM killer disabled.
> [ 8825.312772] Freezing remaining freezable tasks ... (elapsed 0.001=20
> seconds) done.
> [ 8825.313877] printk: Suspending console(s) (use no_console_suspend=20
> to debug)
> [ 8825.335938] queueing ieee80211 work while going to suspend
> [ 8825.347356] [drm] free PSP TMR buffer
> [ 8825.499466] perf: interrupt took too long (3839 > 2500), lowering=20
> kernel.perf_event_max_sample_rate to 51900
> [ 8825.543172] ACPI: PM: Preparing to enter system sleep state S3
> [ 8825.863331] ACPI: PM: Saving platform NVS memory
> [ 8825.863440] Disabling non-boot CPUs ...
> [ 8825.865645] smpboot: CPU 1 is now offline
> [ 8825.868994] smpboot: CPU 2 is now offline
> [ 8825.871466] smpboot: CPU 3 is now offline
> [ 8825.873805] smpboot: CPU 4 is now offline
> [ 8825.875961] smpboot: CPU 5 is now offline
> [ 8825.878234] smpboot: CPU 6 is now offline
> [ 8825.880319] smpboot: CPU 7 is now offline
> [ 8825.882530] smpboot: CPU 8 is now offline
> [ 8825.884557] smpboot: CPU 9 is now offline
> [ 8825.886797] smpboot: CPU 10 is now offline
> [ 8825.888727] smpboot: CPU 11 is now offline
> [ 8825.890893] smpboot: CPU 12 is now offline
> [ 8825.892759] smpboot: CPU 13 is now offline
> [ 8825.894957] smpboot: CPU 14 is now offline
> [ 8825.895397] Spectre V2 : Update user space SMT mitigation: STIBP=20
> off
> [ 8825.897254] smpboot: CPU 15 is now offline
> [ 8825.897630] ACPI: PM: Low-level resume complete
> [ 8825.897630] ACPI: PM: Restoring platform NVS memory
> [ 8825.897630] AMD-Vi: Virtual APIC enabled
> [ 8825.897630] AMD-Vi: Virtual APIC enabled
> [ 8825.897630] LVT offset 0 assigned for vector 0x400
> [ 8825.897630] Enabling non-boot CPUs ...
> [ 8825.897630] x86: Booting SMP configuration:
> [ 8825.897630] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 8825.865540] microcode: CPU1: patch_level=3D0x0a50000c
> [ 8825.898370] ACPI: \_SB_.PLTF.P001: Found 3 idle states
> [ 8825.898516] Spectre V2 : Update user space SMT mitigation: STIBP=20
> always-on
> [ 8825.898528] CPU1 is up
> [ 8825.898559] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 8825.898269] microcode: CPU2: patch_level=3D0x0a50000c
> [ 8825.898897] ACPI: \_SB_.PLTF.P002: Found 3 idle states
> [ 8825.899073] CPU2 is up
> [ 8825.899095] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 8825.898706] microcode: CPU3: patch_level=3D0x0a50000c
> [ 8825.899409] ACPI: \_SB_.PLTF.P003: Found 3 idle states
> [ 8825.899600] CPU3 is up
> [ 8825.899635] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 8825.899245] microcode: CPU4: patch_level=3D0x0a50000c
> [ 8825.900273] ACPI: \_SB_.PLTF.P004: Found 3 idle states
> [ 8825.900488] CPU4 is up
> [ 8825.900508] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 8825.900098] microcode: CPU5: patch_level=3D0x0a50000c
> [ 8825.900813] ACPI: \_SB_.PLTF.P005: Found 3 idle states
> [ 8825.901099] CPU5 is up
> [ 8825.901117] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 8825.900660] microcode: CPU6: patch_level=3D0x0a50000c
> [ 8825.901432] ACPI: \_SB_.PLTF.P006: Found 3 idle states
> [ 8825.901699] CPU6 is up
> [ 8825.901726] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 8825.901270] microcode: CPU7: patch_level=3D0x0a50000c
> [ 8825.902037] ACPI: \_SB_.PLTF.P007: Found 3 idle states
> [ 8825.902377] CPU7 is up
> [ 8825.902394] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 8825.901871] microcode: CPU8: patch_level=3D0x0a50000c
> [ 8825.902714] ACPI: \_SB_.PLTF.P008: Found 3 idle states
> [ 8825.903043] CPU8 is up
> [ 8825.903067] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 8825.902541] microcode: CPU9: patch_level=3D0x0a50000c
> [ 8825.903374] ACPI: \_SB_.PLTF.P009: Found 3 idle states
> [ 8825.903742] CPU9 is up
> [ 8825.903765] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 8825.903211] microcode: CPU10: patch_level=3D0x0a50000c
> [ 8825.904088] ACPI: \_SB_.PLTF.P00A: Found 3 idle states
> [ 8825.904482] CPU10 is up
> [ 8825.904503] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 8825.903906] microcode: CPU11: patch_level=3D0x0a50000c
> [ 8825.904820] ACPI: \_SB_.PLTF.P00B: Found 3 idle states
> [ 8825.905295] CPU11 is up
> [ 8825.905315] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 8825.904650] microcode: CPU12: patch_level=3D0x0a50000c
> [ 8825.905644] ACPI: \_SB_.PLTF.P00C: Found 3 idle states
> [ 8825.906100] CPU12 is up
> [ 8825.906117] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 8825.905461] microcode: CPU13: patch_level=3D0x0a50000c
> [ 8825.906458] ACPI: \_SB_.PLTF.P00D: Found 3 idle states
> [ 8825.906949] CPU13 is up
> [ 8825.906973] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 8825.906283] microcode: CPU14: patch_level=3D0x0a50000c
> [ 8825.907318] ACPI: \_SB_.PLTF.P00E: Found 3 idle states
> [ 8825.907819] CPU14 is up
> [ 8825.907837] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 8825.907134] microcode: CPU15: patch_level=3D0x0a50000c
> [ 8825.908151] ACPI: \_SB_.PLTF.P00F: Found 3 idle states
> [ 8825.908711] CPU15 is up
> [ 8825.909733] ACPI: PM: Waking up from system sleep state S3
> [ 8827.436514] mt7921e 0000:03:00.0: Unable to change power state=20
> from D3hot to D0, device inaccessible
> [ 8827.439626] ACPI Error: No handler for Region [ECRM]=20
> (00000000f92718d8) [EmbeddedControl] (20220331/evregion-130)
> [ 8827.439632] ACPI Error: Region EmbeddedControl (ID=3D3) has no=20
> handler (20220331/exfldio-261)
> [ 8827.439635] ACPI Error: Aborting method \_SB.GPIO._EVT due to=20
> previous error (AE_NOT_EXIST) (20220331/psparse-529)
> [ 8827.440130] pci 0000:00:00.2: can't derive routing for PCI INT A
> [ 8827.440132] pci 0000:00:00.2: PCI INT A: no GSI
> [ 8827.440437] [drm] PCIE GART of 1024M enabled.
> [ 8827.440441] [drm] PTB located at 0x000000F41FC00000
> [ 8827.440473] [drm] PSP is resuming...
> [ 8827.460495] [drm] reserve 0x400000 from 0xf41f400000 for PSP TMR
> [ 8827.461689] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8827.461695] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8827.463949] nvme nvme0: 8/0/0 default/read/poll queues
> [ 8827.542950] amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta=20
> ucode is not available
> [ 8827.551453] amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta=20
> ucode is not available
> [ 8827.551454] amdgpu 0000:05:00.0: amdgpu: SECUREDISPLAY:=20
> securedisplay ta ucode is not available
> [ 8827.551456] amdgpu 0000:05:00.0: amdgpu: SMU is resuming...
> [ 8827.551582] amdgpu 0000:05:00.0: amdgpu: dpm has been disabled
> [ 8827.553533] amdgpu 0000:05:00.0: amdgpu: SMU is resumed=20
> successfully!
> [ 8827.554099] [drm] DMUB hardware initialized: version=3D0x0101001F
> [ 8827.583859] [drm] kiq ring mec 2 pipe 1 q 0
> [ 8827.588663] [drm] VCN decode and encode initialized=20
> successfully(under DPG Mode).
> [ 8827.588737] [drm] JPEG decode initialized successfully.
> [ 8827.588743] amdgpu 0000:05:00.0: amdgpu: ring gfx uses VM inv eng=20
> 0 on hub 0
> [ 8827.588744] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM=20
> inv eng 1 on hub 0
> [ 8827.588745] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM=20
> inv eng 4 on hub 0
> [ 8827.588746] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM=20
> inv eng 5 on hub 0
> [ 8827.588746] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM=20
> inv eng 6 on hub 0
> [ 8827.588747] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM=20
> inv eng 7 on hub 0
> [ 8827.588747] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM=20
> inv eng 8 on hub 0
> [ 8827.588747] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM=20
> inv eng 9 on hub 0
> [ 8827.588748] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM=20
> inv eng 10 on hub 0
> [ 8827.588749] amdgpu 0000:05:00.0: amdgpu: ring kiq_2.1.0 uses VM=20
> inv eng 11 on hub 0
> [ 8827.588749] amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv=20
> eng 0 on hub 1
> [ 8827.588750] amdgpu 0000:05:00.0: amdgpu: ring vcn_dec uses VM inv=20
> eng 1 on hub 1
> [ 8827.588750] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc0 uses VM inv=20
> eng 4 on hub 1
> [ 8827.588751] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc1 uses VM inv=20
> eng 5 on hub 1
> [ 8827.588751] amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv=20
> eng 6 on hub 1
> [ 8827.712592] usb 3-3: reset high-speed USB device number 3 using=20
> xhci_hcd
> [ 8827.752961] ata2: SATA link down (SStatus 0 SControl 300)
> [ 8827.752961] ata1: SATA link down (SStatus 0 SControl 300)
> [ 8827.984644] usb 3-4: reset high-speed USB device number 4 using=20
> xhci_hcd
> [ 8828.476344] mt7921e 0000:03:00.0: Message 00020007 (seq 15) timeout
> [ 8828.476357] mt7921e 0000:03:00.0: PM: dpm_run_callback():=20
> pci_pm_resume+0x0/0xe0 returns -110
> [ 8828.476370] mt7921e 0000:03:00.0: PM: failed to resume async:=20
> error -110
> [ 8828.555395] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8831.729553] mt7921e 0000:03:00.0: Message 00000010 (seq 1) timeout
> [ 8831.729565] mt7921e 0000:03:00.0: Failed to get patch semaphore
> [ 8831.809114] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8834.929686] mt7921e 0000:03:00.0: Message 00000010 (seq 2) timeout
> [ 8834.929697] mt7921e 0000:03:00.0: Failed to get patch semaphore
> [ 8834.929878] mt7921e 0000:03:00.0: AMD-Vi: Event logged=20
> [IO_PAGE_FAULT domain=3D0x000c address=3D0x0 flags=3D0x0020]
> [ 8838.129831] mt7921e 0000:03:00.0: Message 000046ed (seq 3) timeout
> [ 8838.129849] ------------[ cut here ]------------
> [ 8838.129851] Hardware became unavailable upon resume. This could be=20
> a software issue prior to suspend or a hardware issue.
> [ 8838.129887] WARNING: CPU: 13 PID: 45173 at=20
> net/mac80211/util.c:2436 ieee80211_reconfig+0x9c/0x1570 [mac80211]
> [ 8838.129961] Modules linked in: tls rfcomm ccm intel_rapl_msr=20
> intel_rapl_common uhid snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci=20
> cmac snd_sof algif_hash snd_sof_utils algif_skcipher snd_soc_core=20
> af_alg snd_hda_codec_realtek mt7921e snd_compress=20
> snd_hda_codec_generic bnep ledtrig_audio snd_hda_codec_hdmi=20
> mt7921_common ac97_bus snd_pcm_dmaengine snd_hda_intel=20
> mt76_connac_lib snd_rpl_pci_acp6x btusb snd_intel_dspcfg mt76=20
> snd_intel_sdw_acpi amdgpu snd_acp_pci btrtl edac_mce_amd=20
> snd_pci_acp6x btbcm vfat snd_hda_codec snd_pci_acp5x btintel fat=20
> wmi_bmof mac80211 snd_hda_core gpu_sched snd_rn_pci_acp3x btmtk=20
> kvm_amd snd_hwdep libarc4 bluetooth drm_buddy r8169 snd_pcm=20
> drm_ttm_helper joydev snd_acp_config mousedev ecdh_generic ttm=20
> snd_timer realtek cfg80211 apple_mfi_fastcharge kvm snd_soc_acpi=20
> drm_display_helper snd mdio_devres irqbypass soundcore rfkill=20
> snd_pci_acp3x cec sp5100_tco libphy rapl pcspkr i2c_piix4 k10temp wmi=20
> tpm_crb video tpm_tis mac_hid tpm_tis_core crypto_user amd_pstate fuse
> [ 8838.130052]  bpf_preload ip_tables x_tables ext4 crc32c_generic=20
> crc16 mbcache jbd2 hid_apple usbhid dm_crypt cbc encrypted_keys=20
> trusted asn1_encoder tee tpm dm_mod crct10dif_pclmul crc32_pclmul=20
> crc32c_intel polyval_clmulni polyval_generic gf128mul=20
> ghash_clmulni_intel aesni_intel nvme crypto_simd ccp nvme_core=20
> xhci_pci cryptd rng_core nvme_common xhci_pci_renesas
> [ 8838.130085] CPU: 13 PID: 45173 Comm: kworker/u32:6 Not tainted=20
> 6.0.7-arch1-1 #1 54734d35253fb4c526adcfdfa2e7225be9ec4a9a
> [ 8838.130091] Hardware name: AZW GTR/GTR, BIOS=20
> GTR_V1.24_bLink_P4C5M43 06/08/2022
> [ 8838.130094] Workqueue: events_unbound async_run_entry_fn
> [ 8838.130104] RIP: 0010:ieee80211_reconfig+0x9c/0x1570 [mac80211]
> [ 8838.130153] Code: 84 24 8d 05 00 00 00 4c 89 e7 e8 df ea fb ff 41=20
> 89 c0 85 c0 0f 84 fd 02 00 00 48 c7 c7 c8 53 03 c1 44 89 04 24 e8 b4=20
> 93 5c fa <0f> 0b 44 8b 04 24 eb 35 84 c0 0f 85 76 01 00 00 c6 87 8d=20
> 05 00 00
> [ 8838.130156] RSP: 0018:ffffbfed54e2fd88 EFLAGS: 00010282
> [ 8838.130159] RAX: 0000000000000000 RBX: ffff9cad439e0518 RCX:=20
> 0000000000000027
> [ 8838.130161] RDX: ffff9cb3ee961668 RSI: 0000000000000001 RDI:=20
> ffff9cb3ee961660
> [ 8838.130163] RBP: ffff9cad439e03a0 R08: ffffffffbc65b4c0 R09:=20
> ffffbfed54e2fd18
> [ 8838.130164] R10: 0000000000000002 R11: ffffffffbc6b37d8 R12:=20
> ffff9cad439e08e0
> [ 8838.130166] R13: 0000000000000010 R14: 0000000000000000 R15:=20
> ffff9cad4f51a208
> [ 8838.130168] FS:  0000000000000000(0000) GS:ffff9cb3ee940000(0000)=20
> knlGS:0000000000000000
> [ 8838.130170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8838.130172] CR2: 0000000000000000 CR3: 000000028d410000 CR4:=20
> 0000000000750ee0
> [ 8838.130174] PKRU: 55555554
> [ 8838.130176] Call Trace:
> [ 8838.130180]  <TASK>
> [ 8838.130185]  ? wait_for_completion+0x95/0x160
> [ 8838.130194]  wiphy_resume+0x80/0x150 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.130244]  ? wiphy_suspend+0x2b0/0x2b0 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.130285]  dpm_run_callback+0x4a/0x150
> [ 8838.130294]  device_resume+0xa2/0x1f0
> [ 8838.130298]  async_resume+0x1d/0x30
> [ 8838.130302]  async_run_entry_fn+0x34/0x130
> [ 8838.130308]  process_one_work+0x1c7/0x380
> [ 8838.130313]  worker_thread+0x51/0x390
> [ 8838.130317]  ? rescuer_thread+0x3b0/0x3b0
> [ 8838.130320]  kthread+0xde/0x110
> [ 8838.130323]  ? kthread_complete_and_exit+0x20/0x20
> [ 8838.130327]  ret_from_fork+0x22/0x30
> [ 8838.130335]  </TASK>
> [ 8838.130336] ---[ end trace 0000000000000000 ]---
> [ 8838.130950] ------------[ cut here ]------------
> [ 8838.130950] wlp3s0: Failed check-sdata-in-driver check, flags: 0x0
> [ 8838.130956] WARNING: CPU: 13 PID: 45173 at=20
> net/mac80211/driver-ops.c:98 drv_remove_interface+0x114/0x120=20
> [mac80211]
> [ 8838.130973] Modules linked in: tls rfcomm ccm intel_rapl_msr=20
> intel_rapl_common uhid snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci=20
> cmac snd_sof algif_hash snd_sof_utils algif_skcipher snd_soc_core=20
> af_alg snd_hda_codec_realtek mt7921e snd_compress=20
> snd_hda_codec_generic bnep ledtrig_audio snd_hda_codec_hdmi=20
> mt7921_common ac97_bus snd_pcm_dmaengine snd_hda_intel=20
> mt76_connac_lib snd_rpl_pci_acp6x btusb snd_intel_dspcfg mt76=20
> snd_intel_sdw_acpi amdgpu snd_acp_pci btrtl edac_mce_amd=20
> snd_pci_acp6x btbcm vfat snd_hda_codec snd_pci_acp5x btintel fat=20
> wmi_bmof mac80211 snd_hda_core gpu_sched snd_rn_pci_acp3x btmtk=20
> kvm_amd snd_hwdep libarc4 bluetooth drm_buddy r8169 snd_pcm=20
> drm_ttm_helper joydev snd_acp_config mousedev ecdh_generic ttm=20
> snd_timer realtek cfg80211 apple_mfi_fastcharge kvm snd_soc_acpi=20
> drm_display_helper snd mdio_devres irqbypass soundcore rfkill=20
> snd_pci_acp3x cec sp5100_tco libphy rapl pcspkr i2c_piix4 k10temp wmi=20
> tpm_crb video tpm_tis mac_hid tpm_tis_core crypto_user amd_pstate fuse
> [ 8838.130990]  bpf_preload ip_tables x_tables ext4 crc32c_generic=20
> crc16 mbcache jbd2 hid_apple usbhid dm_crypt cbc encrypted_keys=20
> trusted asn1_encoder tee tpm dm_mod crct10dif_pclmul crc32_pclmul=20
> crc32c_intel polyval_clmulni polyval_generic gf128mul=20
> ghash_clmulni_intel aesni_intel nvme crypto_simd ccp nvme_core=20
> xhci_pci cryptd rng_core nvme_common xhci_pci_renesas
> [ 8838.130997] CPU: 13 PID: 45173 Comm: kworker/u32:6 Tainted: G     =20
>   W          6.0.7-arch1-1 #1 54734d35253fb4c526adcfdfa2e7225be9ec4a9a
> [ 8838.130998] Hardware name: AZW GTR/GTR, BIOS=20
> GTR_V1.24_bLink_P4C5M43 06/08/2022
> [ 8838.130999] Workqueue: events_unbound async_run_entry_fn
> [ 8838.131001] RIP: 0010:drv_remove_interface+0x114/0x120 [mac80211]
> [ 8838.131015] Code: ff ff 48 8b 83 80 07 00 00 48 8d b3 a0 07 00 00=20
> 48 c7 c7 68 44 03 c1 c6 05 58 41 0f 00 01 48 85 c0 48 0f 45 f0 e8 5c=20
> a3 60 fa <0f> 0b 5b 5d c3 cc cc cc cc 0f 1f 00 66 0f 1f 00 0f 1f 44=20
> 00 00 41
> [ 8838.131016] RSP: 0018:ffffbfed54e2fc50 EFLAGS: 00010286
> [ 8838.131016] RAX: 0000000000000000 RBX: ffff9cad431889c0 RCX:=20
> 0000000000000027
> [ 8838.131017] RDX: ffff9cb3ee961668 RSI: 0000000000000001 RDI:=20
> ffff9cb3ee961660
> [ 8838.131018] RBP: ffff9cad439e08e0 R08: ffffffffbc65b4c0 R09:=20
> 0000000000000000
> [ 8838.131018] R10: ffffffffffffffff R11: ffffffffbceb6a9e R12:=20
> ffff9cad439e08e0
> [ 8838.131019] R13: ffff9cad43189b80 R14: ffff9cad439e11e0 R15:=20
> 0000000000000000
> [ 8838.131019] FS:  0000000000000000(0000) GS:ffff9cb3ee940000(0000)=20
> knlGS:0000000000000000
> [ 8838.131020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8838.131020] CR2: 0000000000000000 CR3: 000000028d410000 CR4:=20
> 0000000000750ee0
> [ 8838.131021] PKRU: 55555554
> [ 8838.131021] Call Trace:
> [ 8838.131022]  <TASK>
> [ 8838.131023]  ieee80211_do_stop+0x673/0x8b0 [mac80211=20
> 413b373032165e62b73c5ea709856cb11f187fe5]
> [ 8838.131041]  ieee80211_stop+0x41/0x170 [mac80211=20
> 413b373032165e62b73c5ea709856cb11f187fe5]
> [ 8838.131055]  __dev_close_many+0x9e/0x110
> [ 8838.131060]  dev_close_many+0x8f/0x140
> [ 8838.131062]  ? ieee80211_sched_scan_end+0x1d/0x60 [mac80211=20
> 413b373032165e62b73c5ea709856cb11f187fe5]
> [ 8838.131077]  dev_close+0x83/0xb0
> [ 8838.131079]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.131093]  wiphy_resume+0x98/0x150 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.131105]  ? wiphy_suspend+0x2b0/0x2b0 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.131118]  dpm_run_callback+0x4a/0x150
> [ 8838.131119]  device_resume+0xa2/0x1f0
> [ 8838.131120]  async_resume+0x1d/0x30
> [ 8838.131122]  async_run_entry_fn+0x34/0x130
> [ 8838.131123]  process_one_work+0x1c7/0x380
> [ 8838.131124]  worker_thread+0x51/0x390
> [ 8838.131125]  ? rescuer_thread+0x3b0/0x3b0
> [ 8838.131126]  kthread+0xde/0x110
> [ 8838.131127]  ? kthread_complete_and_exit+0x20/0x20
> [ 8838.131128]  ret_from_fork+0x22/0x30
> [ 8838.131130]  </TASK>
> [ 8838.131130] ---[ end trace 0000000000000000 ]---
> [ 8838.131137] ------------[ cut here ]------------
> [ 8838.131138] WARNING: CPU: 13 PID: 45173 at=20
> net/mac80211/driver-ops.c:37 drv_stop+0xf5/0x100 [mac80211]
> [ 8838.131152] Modules linked in: tls rfcomm ccm intel_rapl_msr=20
> intel_rapl_common uhid snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci=20
> cmac snd_sof algif_hash snd_sof_utils algif_skcipher snd_soc_core=20
> af_alg snd_hda_codec_realtek mt7921e snd_compress=20
> snd_hda_codec_generic bnep ledtrig_audio snd_hda_codec_hdmi=20
> mt7921_common ac97_bus snd_pcm_dmaengine snd_hda_intel=20
> mt76_connac_lib snd_rpl_pci_acp6x btusb snd_intel_dspcfg mt76=20
> snd_intel_sdw_acpi amdgpu snd_acp_pci btrtl edac_mce_amd=20
> snd_pci_acp6x btbcm vfat snd_hda_codec snd_pci_acp5x btintel fat=20
> wmi_bmof mac80211 snd_hda_core gpu_sched snd_rn_pci_acp3x btmtk=20
> kvm_amd snd_hwdep libarc4 bluetooth drm_buddy r8169 snd_pcm=20
> drm_ttm_helper joydev snd_acp_config mousedev ecdh_generic ttm=20
> snd_timer realtek cfg80211 apple_mfi_fastcharge kvm snd_soc_acpi=20
> drm_display_helper snd mdio_devres irqbypass soundcore rfkill=20
> snd_pci_acp3x cec sp5100_tco libphy rapl pcspkr i2c_piix4 k10temp wmi=20
> tpm_crb video tpm_tis mac_hid tpm_tis_core crypto_user amd_pstate fuse
> [ 8838.131168]  bpf_preload ip_tables x_tables ext4 crc32c_generic=20
> crc16 mbcache jbd2 hid_apple usbhid dm_crypt cbc encrypted_keys=20
> trusted asn1_encoder tee tpm dm_mod crct10dif_pclmul crc32_pclmul=20
> crc32c_intel polyval_clmulni polyval_generic gf128mul=20
> ghash_clmulni_intel aesni_intel nvme crypto_simd ccp nvme_core=20
> xhci_pci cryptd rng_core nvme_common xhci_pci_renesas
> [ 8838.131174] CPU: 13 PID: 45173 Comm: kworker/u32:6 Tainted: G     =20
>   W          6.0.7-arch1-1 #1 54734d35253fb4c526adcfdfa2e7225be9ec4a9a
> [ 8838.131176] Hardware name: AZW GTR/GTR, BIOS=20
> GTR_V1.24_bLink_P4C5M43 06/08/2022
> [ 8838.131176] Workqueue: events_unbound async_run_entry_fn
> [ 8838.131178] RIP: 0010:drv_stop+0xf5/0x100 [mac80211]
> [ 8838.131191] Code: 0f 00 48 85 c0 74 0c 48 8b 78 08 48 89 de e8 e2=20
> 9f 04 00 65 ff 0d eb 84 09 3f 0f 85 39 ff ff ff e8 a8 bf a7 f9 e9 2f=20
> ff ff ff <0f> 0b 5b c3 cc cc cc cc 0f 1f 00 66 0f 1f 00 0f 1f 44 00=20
> 00 41 54
> [ 8838.131192] RSP: 0018:ffffbfed54e2fc58 EFLAGS: 00010246
> [ 8838.131193] RAX: 0000000000000000 RBX: ffff9cad439e08e0 RCX:=20
> ffff9cad06593068
> [ 8838.131193] RDX: 0000000000000000 RSI: 0000000000000282 RDI:=20
> ffff9cad439e08e0
> [ 8838.131193] RBP: ffff9cad439e1b10 R08: ffffffffbc65b4c0 R09:=20
> 0000000000000000
> [ 8838.131194] R10: ffffffffffffffff R11: ffffffffbceb6a9e R12:=20
> ffff9cad439e08e0
> [ 8838.131194] R13: ffff9cad43189b80 R14: ffff9cad439e11e0 R15:=20
> 0000000000000000
> [ 8838.131195] FS:  0000000000000000(0000) GS:ffff9cb3ee940000(0000)=20
> knlGS:0000000000000000
> [ 8838.131195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8838.131196] CR2: 0000000000000000 CR3: 000000028d410000 CR4:=20
> 0000000000750ee0
> [ 8838.131197] PKRU: 55555554
> [ 8838.131197] Call Trace:
> [ 8838.131197]  <TASK>
> [ 8838.131198]  ieee80211_do_stop+0x6a5/0x8b0 [mac80211=20
> 413b373032165e62b73c5ea709856cb11f187fe5]
> [ 8838.131213]  ieee80211_stop+0x41/0x170 [mac80211=20
> 413b373032165e62b73c5ea709856cb11f187fe5]
> [ 8838.131227]  __dev_close_many+0x9e/0x110
> [ 8838.131228]  dev_close_many+0x8f/0x140
> [ 8838.131230]  ? ieee80211_sched_scan_end+0x1d/0x60 [mac80211=20
> 413b373032165e62b73c5ea709856cb11f187fe5]
> [ 8838.131244]  dev_close+0x83/0xb0
> [ 8838.131246]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.131258]  wiphy_resume+0x98/0x150 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.131271]  ? wiphy_suspend+0x2b0/0x2b0 [cfg80211=20
> 3bc9c89fdd1a86213882b8cd88cb8dca2477ddbe]
> [ 8838.131283]  dpm_run_callback+0x4a/0x150
> [ 8838.131285]  device_resume+0xa2/0x1f0
> [ 8838.131286]  async_resume+0x1d/0x30
> [ 8838.131287]  async_run_entry_fn+0x34/0x130
> [ 8838.131289]  process_one_work+0x1c7/0x380
> [ 8838.131290]  worker_thread+0x51/0x390
> [ 8838.131291]  ? rescuer_thread+0x3b0/0x3b0
> [ 8838.131292]  kthread+0xde/0x110
> [ 8838.131293]  ? kthread_complete_and_exit+0x20/0x20
> [ 8838.131294]  ret_from_fork+0x22/0x30
> [ 8838.131295]  </TASK>
> [ 8838.131296] ---[ end trace 0000000000000000 ]---
> [ 8838.131361] ieee80211 phy0: PM: dpm_run_callback():=20
> wiphy_resume+0x0/0x150 [cfg80211] returns -110
> [ 8838.131376] ieee80211 phy0: PM: failed to resume async: error -110
> [ 8838.131894] OOM killer enabled.
> [ 8838.131895] Restarting tasks ...
> [ 8838.131958] usb 3-1: USB disconnect, device number 2
>=20
>=20
> Let me know if I can be of further help.
>=20
> -- Daniel


