Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1203D2E70E5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2Ned (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 08:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2Nec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 08:34:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8277BC061793
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 05:33:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so14667794wrc.5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 05:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JJ31qAaOux6oBOLChDqe1gAELuNi/j30DzJV4H9Vz8I=;
        b=WBe/wvcfSRhnfNgdhGWQ+U0QyxMxz4O2w30gmWcKOP95+Zgo4BYpvcV3rWHwmOom4h
         qMjUsLiW4L3B69BOh/YL0ZBNLrRUg8iI/DtEnrDiAfwV4BDg1+UOumtg0NiMCVvvMm9i
         hdNbhSOHqRK0+s/537jusVfKqjJlmUY5hs9PvpcVn2XJp9UBaXjRR3cHCY7YMoGTAMzM
         RIL9ZGJYUmZ3VyaqD/ID7bdwIBl1Pa+5fBGyBXdlf0O4D2febw+iwSTi9wEYfWCV6m7c
         ErJqsSM/vVGRqCMX/CbN6Ughuoer3AZPFBcDpHHutcTEkgXHXF/Fhmqk/2iGbXAc1va8
         deOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JJ31qAaOux6oBOLChDqe1gAELuNi/j30DzJV4H9Vz8I=;
        b=ffoOAAfvrUjQzCTk1x6UPgytzs73h+EQk9E/hX03WdYxaM3PoB1RLc2OiM5RlQyqIM
         a5XPuGDwjyRun505tE6FMmHD8g2WJiHxuakaTol8vvTl6791VX6i4KB3cb0p2GPL7usn
         FNYxBiADGLHzGPZYBgc+s6Nr3d+gCzLw3Wyk385xbssud3QfpJrYULI5GPzTIeq5tuwc
         h/+uKF/e6cwIshdNx4V9biidipCr3LzOeVvlU2hHE9vZqFIHFzX+8eXDvAuaOCDzhavQ
         ATT1m2IFqG12tkJMzGAgVdV+WhuULni9qkufz2lrmvEgw/0FoYcAKcts6DSNu2+zMJtI
         Cdsg==
X-Gm-Message-State: AOAM5333vWe0QyNXlIar9vYhhuN9RMvI6Dd3ct5USSkR6OUchXWd2krD
        ARUsRFYM3HlVD2DQjxBBRXHI0Qi3I6MUUphL
X-Google-Smtp-Source: ABdhPJzyDsiukEFJP2unVBAmWlncHExu7B1t+j3ZAnktomtnfnEV4DTAVTqfjL5MWTYHu19Mxoep5A==
X-Received: by 2002:a5d:6983:: with SMTP id g3mr19956415wru.168.1609248830018;
        Tue, 29 Dec 2020 05:33:50 -0800 (PST)
Received: from t2b3 ([134.3.116.174])
        by smtp.gmail.com with ESMTPSA id l1sm63162708wrq.64.2020.12.29.05.33.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 05:33:49 -0800 (PST)
Date:   Tue, 29 Dec 2020 14:33:47 +0100
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: Re: WARNING in 5.11 rc1 for Intel Wireless AC 9260
Message-ID: <X+swO1R3BPqEEDvA@t2b3>
References: <X+sudMxoAfvo+6Sx@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X+sudMxoAfvo+6Sx@t2b3>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tobias S. Predel <tobias.predel@gmail.com> schrieb / wrote / a écrit / ha escrito / je pisao / је писао: 

> Hello,
> 
> I'd like to share that following WARNING occurs in the kernel ring buffer when 
> I use 5.11 rc 1 with iwd 1.10 and Intel Wireless-AC 9260. I assume it is non-
> critical as Wifi works nevertheless.
> 
> [    6.070543] ------------[ cut here ]------------
> [    6.070547] WARNING: CPU: 5 PID: 565 at net/wireless/nl80211.c:7652 nl80211_get_reg_do+0x228/0x290 [cfg80211]
> [    6.070654] Modules linked in: snd_soc_sst_dsp(+) snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi snd_hda_intel snd_intel_dspcfg iTCO_wdt iptable_filter iwlmvm intel_pmc
> _bxt hp_wmi hid_multitouch mei_hdcp iTCO_vendor_support intel_rapl_msr wmi_bmof sparse_keymap mac80211 ee1004 soundwire_intel x86_pkg_temp_thermal intel_powerclamp soundwire_gener
> ic_allocation soundwire_cadence coretemp libarc4 snd_hda_codec kvm_intel snd_hda_core snd_hwdep kvm soundwire_bus iwlwifi irqbypass joydev mousedev snd_soc_core rapl snd_compress
> intel_cstate ac97_bus intel_uncore i915 snd_pcm_dmaengine vfat cfg80211 fat snd_pcm snd_timer r8169 snd mei_me i2c_algo_bit realtek i2c_i801 mdio_devres soundcore i2c_smbus rfkill
>  libphy drm_kms_helper mei intel_lpss_pci intel_lpss idma64 processor_thermal_device cec processor_thermal_rfim processor_thermal_mbox intel_pch_thermal intel_xhci_usb_role_switch
>  processor_thermal_rapl intel_rapl_common intel_gtt roles syscopyarea intel_soc_dts_iosf sysfillrect
> [    6.070765]  sysimgblt fb_sys_fops wmi i2c_hid hp_accel(+) tpm_crb int3403_thermal int340x_thermal_zone int3400_thermal lis3lv02d video tpm_tis tpm_tis_core acpi_thermal_rel tp
> m acpi_pad drm pkcs8_key_parser fuse agpgart ip_tables x_tables ext4 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci serio_raw rtsx_pci xhci_pci_renesas
> [    6.070810] CPU: 5 PID: 565 Comm: iwd Not tainted 5.11.0-rc1-1-mainline #1
> [    6.070817] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85 Ver. 01.14.01 10/19/2020
> [    6.070819] RIP: 0010:nl80211_get_reg_do+0x228/0x290 [cfg80211]
> [    6.070900] Code: 89 ef c7 44 24 0c 01 00 00 00 e8 13 40 1f eb 85 c0 74 cc e9 ff fe ff ff 48 89 ef 48 89 04 24 e8 de 54 57 eb 48 8b 04 24 eb 89 <0f> 0b 48 89 ef e8 ce 54 57 eb
> b8 ea ff ff ff e9 75 ff ff ff b8 97
> [    6.070906] RSP: 0018:ffffa5af40c87b48 EFLAGS: 00010202
> [    6.070911] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [    6.070914] RDX: ffff9164d9ba8008 RSI: 0000000000000000 RDI: ffff9164d9ba8300
> [    6.070918] RBP: ffff9164c4af6b00 R08: 0000000000000014 R09: ffff9164cd028014
> [    6.070921] R10: 0000000000000021 R11: ffff9164c4421fc0 R12: ffffa5af40c87ba8
> [    6.070924] R13: ffff9164cd028014 R14: 0000000000000000 R15: ffff9164d9ba8300
> [    6.070927] FS:  00007fba1fe14740(0000) GS:ffff9167d8340000(0000) knlGS:0000000000000000
> [    6.070932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.070936] CR2: 00007fba1f98a090 CR3: 000000010c5f0006 CR4: 00000000003706e0
> [    6.070940] Call Trace:
> [    6.070951]  genl_family_rcv_msg_doit+0xfd/0x160
> [    6.070974]  genl_rcv_msg+0xef/0x1e0
> [    6.070984]  ? nl80211_vendor_cmd_dump+0x5e0/0x5e0 [cfg80211]
> [    6.071129]  ? nl80211_send_regdom.constprop.0+0x1b0/0x1b0 [cfg80211]
> [    6.071222]  ? genl_get_cmd+0xd0/0xd0
> [    6.071233]  netlink_rcv_skb+0x5b/0x100
> [    6.071244]  genl_rcv+0x24/0x40
> [    6.071253]  netlink_unicast+0x242/0x340
> [    6.071263]  netlink_sendmsg+0x243/0x480
> [    6.071274]  sock_sendmsg+0x5e/0x60
> [    6.071286]  __sys_sendto+0x120/0x180
> [    6.071299]  __x64_sys_sendto+0x25/0x30
> [    6.071305]  do_syscall_64+0x33/0x40
> [    6.071317]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    6.071326] RIP: 0033:0x7fba1ff18730
>     6.071333] Code: c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 1d 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 68 c3 0f
> 1f 80 00 00 00 00 55 48 83 ec 20 48
> [    6.071338] RSP: 002b:00007ffeedee66a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [    6.071346] RAX: ffffffffffffffda RBX: 0000557ba5088a00 RCX: 00007fba1ff18730
> [    6.071349] RDX: 000000000000001c RSI: 0000557ba5093da0 RDI: 0000000000000004
> [    6.071353] RBP: 0000557ba509d5e0 R08: 0000000000000000 R09: 0000000000000000
> [    6.071356] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeedee6710
> [    6.071360] R13: 00007ffeedee670c R14: 0000557ba5092690 R15: 0000000000000000
> [    6.071367] ---[ end trace 952135a67533f157 ]---
> 
> lspci:
> 
> 02:00.0 Network controller: Intel Corporation Wireless-AC 9260 (rev 29)                                                                                                  [155/1014]
>         Subsystem: Intel Corporation Device 0010
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 17
>         Region 0: Memory at f0200000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [c8] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [40] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <8us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s (ok), Width x1 (ok)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+ OBFF Disabled,
>                          AtomicOpsCtl: ReqEn-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>                         Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
>                 Vector table: BAR=0 offset=00002000
>                 PBA: BAR=0 offset=00003000
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [14c v1] Latency Tolerance Reporting
>                 Max snoop latency: 3145728ns
>                 Max no snoop latency: 3145728ns
>         Capabilities: [154 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=30us PortTPowerOnTime=18us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=65536ns
>                 L1SubCtl2: T_PwrOn=44us
>         Kernel driver in use: iwlwifi
>         Kernel modules: iwlwifi
> 
[...] 
> uname -a:
> Linux t2b3 5.11.0-rc1-1-mainline #1 SMP PREEMPT Tue, 29 Dec 2020 11:17:55 +0000 x86_64 GNU/Linux
> 
> Regards,
> Tobias

... and
ethtool -i wlan0

driver: iwlwifi
version: 5.11.0-rc1-1-mainline
firmware-version: 46.4d093a30.0 9260-th-b0-jf-b0-
expansion-rom-version:
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no

and

/etc/iwd/main.conf

[General]
EnableNetworkConfiguration=true
AddressRandomization=network

> -- 
> La perfection est atteinte, non pas lorsqu'il n'y a plus rien à ajouter, 
> mais lorsqu'il n'y a plus rien à retirer. — Antoine de Saint-Exupéry
