Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8716224F1C4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 06:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHXESo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgHXESn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 00:18:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86FC061573
        for <linux-wireless@vger.kernel.org>; Sun, 23 Aug 2020 21:18:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l23so6783204edv.11
        for <linux-wireless@vger.kernel.org>; Sun, 23 Aug 2020 21:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WH3QHHsw4xw6mDC6fNyhlE+BuqcYXX0QNSVeL+dps6E=;
        b=SXI01djbW/WOXlvPwVw1tGMlSSWRsdaEsBdgiOQ7/GdNWT2HxvuYEnQREGFeu3BKQu
         fGGVdgpzR5scAmafE+K1UlALh2yFWiUFkygH7CNNcqCLU2hxIyvVw+J62XYk7E9mDbsU
         Ictb6L6L6yMxCr31rA5AfKkKBUSCwBRbQsMD/hPVvf6MWO1uTIgNl45rfZS5TPujW1eu
         C5p+mKKscWjS7k+ibmtE6tFByh3wdjp2bTJZ9UD66Z3oG0owKyQvLyNZ7Cjyf5uGIGx/
         O66xcNDCpCU94fEGyU41sMLCNublFdNfxCojh/ohu5y1xeHvQLodRFD92/u1dZaEsymA
         oWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WH3QHHsw4xw6mDC6fNyhlE+BuqcYXX0QNSVeL+dps6E=;
        b=DRKUWcyyiem/Q+q8VVjdjwKNsiJI4fo+8daw4UdImCZ0hWhQPvyjAdmlb9H3kJIqbJ
         my2bVDlxK78WDbUEohC2ss7ytUUk54kUcIHtunCO2zlTqCoI5dP6YLfeejqgOCKW/4v0
         iS8rygqxsdF/XdtXaNMgug3P5qWDJ1LNntuhNTbjL2Wkn2a/yZGopalim/tn6uLVKc0b
         9rlLFgoOeLcMWH1uG8qBrdUvvTO96mS1WexOzH5h/+HmU3hYR0AuXMTslhMCDbrOeQsV
         f5KqcFIKs74pz4D1+L80JnCzhV1vqNA3q2UKrjnPMCHLJM3hh2p8kYaoaKCI71RYr1Bd
         td6Q==
X-Gm-Message-State: AOAM532fE/pq1TE7zoZNYWad+kGiCuSUNGPze18XCqn+yiOhnbwfmFje
        GFeCLxjCeTVaEhqaq6ZuBkFq4zQRo5ioijTyzs5R6PAFZpc=
X-Google-Smtp-Source: ABdhPJyONY71Fb5HPSS9tn4DTkwoqupzrR59fefpBLKju93dPVmeAlIOkWTwx4n4KVV2hDg2EzlipAaoRUdjCfHnJ/s=
X-Received: by 2002:a05:6402:6d9:: with SMTP id n25mr3615183edy.304.1598242721060;
 Sun, 23 Aug 2020 21:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPWex-BT-cTFv-zWBLGkZUV72eRsV9WP0PAN8GT0m-1RA5NTxQ@mail.gmail.com>
In-Reply-To: <CAPWex-BT-cTFv-zWBLGkZUV72eRsV9WP0PAN8GT0m-1RA5NTxQ@mail.gmail.com>
From:   sdnlabs Janakaraj <wsuprabhu@gmail.com>
Date:   Mon, 24 Aug 2020 00:18:29 -0400
Message-ID: <CAPWex-Aan+kQmD=1WZbjFZUW2WAOEyUwU5jwEN8obJZbTh8X8g@mail.gmail.com>
Subject: Fwd: Ath10k mesh mode - Kernel Panic
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
I am having issues in operating mesh mode on QCA9888 chipset. When I
bring up the mesh interface, my links are not established.

I have tried iw and wpa_supplicant tools for creating mesh, but all
end up at the same issue.

dmesg command output showed there was panic on kernel as shown below:

Aug 23 23:41:41 mydev kernel: [ 1384.897186] ath10k_pci 0000:05:00.0:
unsupported HTC service id: 1536
Aug 23 23:41:41 mydev kernel: [ 1384.918285] ath10k_pci 0000:05:00.0:
pdev param 0 not supported by firmware
Aug 23 23:41:41 mydev kernel: [ 1384.944568] IPv6:
ADDRCONF(NETDEV_CHANGE): mesh2: link becomes ready
Aug 23 23:41:46 mydev kernel: [ 1389.253229] ath10k_pci 0000:04:00.0:
unsupported HTC service id: 1536
Aug 23 23:41:46 mydev kernel: [ 1389.273405] ath10k_pci 0000:04:00.0:
pdev param 0 not supported by firmware
Aug 23 23:41:46 mydev kernel: [ 1389.298658] IPv6:
ADDRCONF(NETDEV_CHANGE): mesh1: link becomes ready
Aug 23 23:41:47 mydev kernel: [ 1390.129916] ------------[ cut here
]------------
Aug 23 23:41:47 mydev kernel: [ 1390.129931] WARNING: CPU: 7 PID: 0 at
net/core/flow_dissector.c:958 __skb_flow_dissect+0x3ba/0x1590
Aug 23 23:41:47 mydev kernel: [ 1390.129932] Modules linked in:
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4
xt_tcpudp ip6table_mangle ip6table_nat iptable_mangle iptable_nat
nf_tables nfnetlink ip6table_filter bridge ip6_tables stp llc
iptable_filter bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic intel_rapl_msr intel_rapl_common
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
snd_sof_pci snd_sof_intel_hda_common snd_soc_hdac_hda
snd_sof_intel_hda snd_sof_intel_byt snd_sof_intel_ipc snd_sof
snd_sof_xtensa_dsp snd_hda_ext_core snd_soc_acpi_intel_match
snd_soc_acpi ledtrig_audio snd_soc_core mei_hdcp snd_compress ac97_bus
snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg snd_hda_codec
snd_hda_core snd_hwdep nls_iso8859_1 snd_pcm crct10dif_pclmul
ghash_clmulni_intel ath10k_pci ath10k_core snd_seq_midi
snd_seq_midi_event ath snd_rawmidi mac80211 snd_seq aesni_intel
dell_wmi crypto_simd dell_smbios snd_seq_device cryptd dcdbas
glue_helper snd_timer joydev intel_cstate
Aug 23 23:41:47 mydev kernel: [ 1390.129986]  dell_wmi_aio i915
dell_wmi_descriptor input_leds intel_rapl_perf sparse_keymap cfg80211
intel_wmi_thunderbolt wmi_bmof snd openvswitch nsh drm_kms_helper
soundcore nf_conncount libarc4 i2c_algo_bit nf_nat mei_me fb_sys_fops
syscopyarea nf_conntrack mei sysfillrect sysimgblt intel_pch_thermal
nf_defrag_ipv6 ie31200_edac nf_defrag_ipv4 libcrc32c mac_hid acpi_pad
sch_fq_codel parport_pc ppdev lp parport drm ip_tables x_tables
autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid
crc32_pclmul e1000e nvme intel_lpss_pci ahci i2c_i801 intel_lpss
nvme_core idma64 libahci virt_dma wmi pinctrl_cannonlake video
pinctrl_intel
Aug 23 23:41:47 mydev kernel: [ 1390.130034] CPU: 7 PID: 0 Comm:
swapper/7 Not tainted 5.4.0-42-generic #46-Ubuntu
Aug 23 23:41:47 mydev kernel: [ 1390.130036] Hardware name: Dell Inc.
OptiPlex 7071/097YXY, BIOS 1.1.2 08/29/2019
Aug 23 23:41:47 mydev kernel: [ 1390.130040] RIP:
0010:__skb_flow_dissect+0x3ba/0x1590
Aug 23 23:41:47 mydev kernel: [ 1390.130044] Code: 65 d8 5b 41 5c 41
5d 41 5e 41 5f 5d c3 48 8b 53 10 48 85 d2 0f 84 bd 05 00 00 4c 8b ba
e8 04 00 00 4d 85 ff 0f 85 bf fc ff ff <0f> 0b e9 bf fd ff ff 66 41 81
ff 08 06 0f 84 3a fe ff ff 31 c0 e9
Aug 23 23:41:47 mydev kernel: [ 1390.130046] RSP:
0018:ffffbeb1002c0c30 EFLAGS: 00010246
Aug 23 23:41:47 mydev kernel: [ 1390.130050] RAX: 0000000000000000
RBX: ffff9a6b3dfb4f00 RCX: 000000000000fe58
Aug 23 23:41:47 mydev kernel: [ 1390.130051] RDX: 0000000000000000
RSI: ffff9a6b3dfb4f00 RDI: 0000000000000008
Aug 23 23:41:47 mydev kernel: [ 1390.130053] RBP: ffffbeb1002c0d18
R08: 0000000000000070 R09: 0000000000000000
Aug 23 23:41:47 mydev kernel: [ 1390.130055] R10: ffff9a6bd8c1e818
R11: ffff9a6bdebba8c0 R12: ffffffffb6a53140
Aug 23 23:41:47 mydev kernel: [ 1390.130057] R13: 000000000000fe58
R14: ffffbeb1002c0d40 R15: 0000000000000000
Aug 23 23:41:47 mydev kernel: [ 1390.130060] FS:
0000000000000000(0000) GS:ffff9a6c1c1c0000(0000)
knlGS:0000000000000000
Aug 23 23:41:47 mydev kernel: [ 1390.130062] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Aug 23 23:41:47 mydev kernel: [ 1390.130064] CR2: 00007f563df2b000
CR3: 000000024b20a004 CR4: 00000000003606e0
Aug 23 23:41:47 mydev kernel: [ 1390.130066] DR0: 0000000000000000
DR1: 0000000000000000 DR2: 0000000000000000
Aug 23 23:41:47 mydev kernel: [ 1390.130068] DR3: 0000000000000000
DR6: 00000000fffe0ff0 DR7: 0000000000000400
Aug 23 23:41:47 mydev kernel: [ 1390.130069] Call Trace:
Aug 23 23:41:47 mydev kernel: [ 1390.130072]  <IRQ>
Aug 23 23:41:47 mydev kernel: [ 1390.130082]  ? swiotlb_map+0x6c/0x1c0
Aug 23 23:41:47 mydev kernel: [ 1390.130087]  skb_get_hash_perturb+0x56/0x160
Aug 23 23:41:47 mydev kernel: [ 1390.130142]
ieee80211_queue_skb+0xd7/0x420 [mac80211]
Aug 23 23:41:47 mydev kernel: [ 1390.130185]  ieee80211_tx+0xe1/0x140 [mac80211]
Aug 23 23:41:47 mydev kernel: [ 1390.130224]
ieee80211_tx_pending+0xa5/0x210 [mac80211]
Aug 23 23:41:47 mydev kernel: [ 1390.130231]  ?
ath10k_pci_napi_poll+0xc8/0x120 [ath10k_pci]
Aug 23 23:41:47 mydev kernel: [ 1390.130238]
tasklet_action_common.isra.0+0x60/0x110
Aug 23 23:41:47 mydev kernel: [ 1390.130242]  tasklet_action+0x22/0x30
Aug 23 23:41:47 mydev kernel: [ 1390.130246]  __do_softirq+0xe1/0x2d6
Aug 23 23:41:47 mydev kernel: [ 1390.130251]  irq_exit+0xae/0xb0
Aug 23 23:41:47 mydev kernel: [ 1390.130253]  do_IRQ+0x5a/0xf0
Aug 23 23:41:47 mydev kernel: [ 1390.130259]  common_interrupt+0xf/0xf
Aug 23 23:41:47 mydev kernel: [ 1390.130260]  </IRQ>
Aug 23 23:41:47 mydev kernel: [ 1390.130266] RIP:
0010:cpuidle_enter_state+0xc5/0x450
Aug 23 23:41:47 mydev kernel: [ 1390.130270] Code: ff e8 bf 08 81 ff
80 7d c7 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 65 03 00 00 31
ff e8 12 6c 87 ff fb 66 0f 1f 44 00 00 <45> 85 ed 0f 88 8f 02 00 00 49
63 cd 4c 8b 7d d0 4c 2b 7d c8 48 8d
Aug 23 23:41:47 mydev kernel: [ 1390.130272] RSP:
0018:ffffbeb10010be38 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
Aug 23 23:41:47 mydev kernel: [ 1390.130275] RAX: ffff9a6c1c1ead00
RBX: ffffffffb6959c00 RCX: 000000000000001f
Aug 23 23:41:47 mydev kernel: [ 1390.130277] RDX: 0000000000000000
RSI: 0000000029580295 RDI: 0000000000000000
Aug 23 23:41:47 mydev kernel: [ 1390.130278] RBP: ffffbeb10010be78
R08: 00000143aa30f14e R09: 0000016b9fd179ba
Aug 23 23:41:47 mydev kernel: [ 1390.130280] R10: ffff9a6c1c1e9a00
R11: ffff9a6c1c1e99e0 R12: ffffdeb0ffbc0000
Aug 23 23:41:47 mydev kernel: [ 1390.130282] R13: 0000000000000008
R14: 0000000000000008 R15: ffffdeb0ffbc0000
Aug 23 23:41:47 mydev kernel: [ 1390.130287]  ? cpuidle_enter_state+0xa1/0x450
Aug 23 23:41:47 mydev kernel: [ 1390.130291]  cpuidle_enter+0x2e/0x40
Aug 23 23:41:47 mydev kernel: [ 1390.130295]  call_cpuidle+0x23/0x40
Aug 23 23:41:47 mydev kernel: [ 1390.130299]  do_idle+0x1dd/0x270
Aug 23 23:41:47 mydev kernel: [ 1390.130303]  cpu_startup_entry+0x20/0x30
Aug 23 23:41:47 mydev kernel: [ 1390.130309]  start_secondary+0x167/0x1c0
Aug 23 23:41:47 mydev kernel: [ 1390.130314]  secondary_startup_64+0xa4/0xb0
Aug 23 23:41:47 mydev kernel: [ 1390.130318] ---[ end trace
4b178e9a3daab927 ]---


I am using Ubuntu 20.04 with 5.4.0-42-generic kernel.
