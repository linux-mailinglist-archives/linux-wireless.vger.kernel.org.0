Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6F4B0626
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 07:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiBJGQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 01:16:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiBJGP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 01:15:59 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2893FB03
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 22:16:01 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c6so12480718ybk.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Feb 2022 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qC6GOFEhrM2pNJfHGdh8wsdzp1JIaqoLLn9kawOTMWM=;
        b=WXbfecf9B13g+Gb5K0F467Nv+PxyZQfOhKamrAM8K/GkExIf3STfqybHFFAYiUvXsN
         /n6LYAxnAWDt7nvAN+BzQPLJVIMCebXhkV91zI8woUlEgEnhwp/XTp4Ea/5YFXultd+4
         KPB+09pHs6af72Mrshm3l7Pih3B1IRCZPnwXM6ZVUzQTpfV7QUs8YY5/qf+1Lr4t4+Mj
         vjcjAlvnNmrRk6rhEWJgeqFTzriQs4O6ZEEmnFiAFHMr64dCXxQHzdV2c4ZCvBkWtp5p
         i2xkrJWAtg1tl7j5bYuy9DGuhQjGqfE4sACK+6cZfNpwqanufNWzCq0ykPcRVXQunJA+
         P5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qC6GOFEhrM2pNJfHGdh8wsdzp1JIaqoLLn9kawOTMWM=;
        b=RKzA2g89gR/qIeaJCiAOSESJoGAnxo11n5tPGcLthEfSjnDUUpB+0rVuxhIGCcJgk+
         XiR18q4nBYhGCdJSqRsRp76wL7qGaGrSw2ST+gmzD+LWyyLzC+FsrlVVhKxkG8NUJFEM
         phOWANbe6PrLSvHj3WCnBPfmsNrAT1hbmbgPdNc6KrUaa4ESGEa2UgWj+eOB0PfOYhH8
         DxHVL/stkghD3WcnvY8e84lBqk7yIupKROMWdcgktTVNYhv7eeqkPZdEIRMjVElwt4YP
         ZhnSR7IhbYnOFQptm8CuBecumzw0nvQiCXpDV0wfP/VKvnovXHg8oF0vzsSrkB9FlxEK
         VBGA==
X-Gm-Message-State: AOAM532ikSxym6ZLLE5E/meC27Mh3H7c84hIyOL6jJEQ/5k9P+p/1dQn
        TfNyIorsuUdoNO3HvAonK4je/7UVbgyCdE8C9ri3h48+sb2EgvEI
X-Google-Smtp-Source: ABdhPJxPxmUHnTliNpeXURtPLTI6WxX5oxVXXnG+Cub6KTirPio5DFNUCzkSaBWWCUv8ApplQQUSjTd3CFH3XuAUw9Q=
X-Received: by 2002:a81:9f0c:: with SMTP id s12mr6366522ywn.190.1644473760099;
 Wed, 09 Feb 2022 22:16:00 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 9 Feb 2022 23:15:44 -0700
Message-ID: <CAJCQCtQsvWMzVPDdLeGOwMWtZgfS3qLvFkPOtUbuFT640emW4w@mail.gmail.com>
Subject: netconsole fail, iwlwifi, WARNING: at net/mac80211/tx.c:3638 ieee80211_tx_dequeue
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patient has
00:14.3 Network controller [0280]: Intel Corporation Cannon Point-LP
CNVi [Wireless-AC] [8086:9df0] (rev 11)

Patient and doctor computers are running kernel 5.16.8-200.fc35.x86_64

Command is
# modprobe netconsole
netconsole=4444@10.0.0.85/wlp0s20f3,6666@10.0.0.249/b8:ae:ed:77:ea:51

And I get a WARNING on the patient, and no messages are received on
the doctor. Reverse direction works OK.

[15937.049105] netpoll: netconsole: local port 4444
[15937.049120] netpoll: netconsole: local IPv4 address 10.0.0.85
[15937.049127] netpoll: netconsole: interface 'wlp0s20f3'
[15937.049131] netpoll: netconsole: remote port 6666
[15937.049135] netpoll: netconsole: remote IPv4 address 10.0.0.249
[15937.049139] netpoll: netconsole: remote ethernet address b8:ae:ed:77:ea:51
[15937.049360] ------------[ cut here ]------------
[15937.049363] WARNING: CPU: 7 PID: 12965 at net/mac80211/tx.c:3638
ieee80211_tx_dequeue+0xc91/0xcf0 [mac80211]
[15937.049487] Modules linked in: netconsole(+) loop vhost_net vhost
vhost_iotlb tap tun xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
nf_nat_tftp nf_conntrack_tftp bridge stp llc uinput rfcomm
snd_seq_dummy snd_hrtimer nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set
nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter qrtr
bnep vfat fat snd_ctl_led snd_soc_skl_hda_dsp
snd_soc_intel_hda_dsp_common snd_soc_hdac_hdmi snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic
snd_sof_pci_intel_cnl snd_sof_intel_hda_common soundwire_intel
soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda
snd_sof_pci snd_sof_xtensa_dsp snd_sof soundwire_bus
[15937.049574]  snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core
snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi
snd_soc_core intel_tcc_cooling snd_compress x86_pkg_temp_thermal
intel_powerclamp ac97_bus coretemp snd_pcm_dmaengine kvm_intel mei_wdt
iTCO_wdt intel_pmc_bxt iTCO_vendor_support mei_hdcp snd_hda_intel
iwlmvm mei_pxp intel_rapl_msr snd_intel_dspcfg snd_intel_sdw_acpi
mac80211 snd_hda_codec kvm snd_hda_core libarc4 irqbypass snd_hwdep
rapl btusb snd_seq intel_cstate btrtl intel_uncore uvcvideo
snd_seq_device iwlwifi btbcm videobuf2_vmalloc snd_pcm btintel
videobuf2_memops think_lmi wmi_bmof intel_wmi_thunderbolt i2c_i801
videobuf2_v4l2 firmware_attributes_class
processor_thermal_device_pci_legacy bluetooth i2c_smbus snd_timer
thunderbolt videobuf2_common cfg80211 processor_thermal_device
processor_thermal_rfim processor_thermal_mbox videodev thinkpad_acpi
processor_thermal_rapl mei_me ledtrig_audio intel_rapl_common
platform_profile ecdh_generic joydev mei
[15937.049656]  idma64 mc rfkill intel_soc_dts_iosf intel_pch_thermal
snd int3403_thermal soundcore int340x_thermal_zone int3400_thermal
acpi_tad acpi_thermal_rel acpi_pad zram ip_tables i915 hid_multitouch
i2c_algo_bit ttm drm_kms_helper cec crct10dif_pclmul crc32_pclmul drm
nvme e1000e crc32c_intel ghash_clmulni_intel nvme_core serio_raw
ucsi_acpi typec_ucsi typec wmi i2c_hid_acpi i2c_hid video
pinctrl_cannonlake ipmi_devintf ipmi_msghandler fuse
[15937.049703] CPU: 7 PID: 12965 Comm: modprobe Not tainted
5.16.8-200.fc35.x86_64 #1
[15937.049711] Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET66W (1.49 ) 11/10/2021
[15937.049714] RIP: 0010:ieee80211_tx_dequeue+0xc91/0xcf0 [mac80211]
[15937.049809] Code: d6 e8 83 28 3a d1 48 85 c0 0f 84 f1 f7 ff ff 41
0f b7 87 b4 00 00 00 49 03 87 c0 00 00 00 e9 9e fc ff ff 0f 0b e9 da
f7 ff ff <0f> 0b e9 a5 f3 ff ff f0 41 80 4e f8 08 e9 70 f8 ff ff 4d 89
fc e9
[15937.049814] RSP: 0018:ffff95f305ee3938 EFLAGS: 00010046
[15937.049820] RAX: 0000000080000002 RBX: ffff8a2d81a5e0f0 RCX: 0000000000000001
[15937.049824] RDX: ffff8a2f67ae0000 RSI: ffff8a2d81a5e0f0 RDI: ffff8a2c9dde8840
[15937.049827] RBP: ffff8a2d81a5e000 R08: 0000000000000000 R09: ffff8a2c9dde8900
[15937.049830] R10: ffff8a2d91d06060 R11: ffff8a2c9dde8840 R12: ffff8a2c9dde8840
[15937.049833] R13: ffff8a2c9ddea040 R14: ffff8a2d81a5e0f0 R15: ffff8a2c9ddea048
[15937.049837] FS:  00007f870ac1f740(0000) GS:ffff8a2fee9c0000(0000)
knlGS:0000000000000000
[15937.049842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15937.049846] CR2: 00005612d88a5000 CR3: 000000010ad14002 CR4: 00000000003706e0
[15937.049850] Call Trace:
[15937.049856]  <TASK>
[15937.049863]  ? get_partial_node.part.0+0x1a2/0x200
[15937.049875]  ? ktime_get_with_offset+0x4c/0xc0
[15937.049885]  ? _raw_spin_lock_bh+0x13/0x30
[15937.049894]  iwl_mvm_mac_itxq_xmit+0x65/0xe0 [iwlmvm]
[15937.049930]  ieee80211_queue_skb+0x4a6/0x710 [mac80211]
[15937.050025]  __ieee80211_subif_start_xmit+0xbde/0xe70 [mac80211]
[15937.050120]  ieee80211_subif_start_xmit+0x3b/0x2e0 [mac80211]
[15937.050204]  ? __kmalloc_node_track_caller+0x177/0x390
[15937.050212]  ? netpoll_send_udp+0x99/0x3f0
[15937.050221]  netpoll_start_xmit+0x111/0x1a0
[15937.050227]  netpoll_send_skb+0x16b/0x280
[15937.050234]  write_msg+0xd8/0xf0 [netconsole]
[15937.050246]  console_unlock+0x329/0x4b0
[15937.050260]  register_console+0x148/0x220
[15937.050268]  init_netconsole+0x20e/0x1000 [netconsole]
[15937.050279]  ? 0xffffffffc15e6000
[15937.050283]  do_one_initcall+0x41/0x200
[15937.050294]  ? kmem_cache_alloc_trace+0x163/0x2c0
[15937.050302]  do_init_module+0x5c/0x280
[15937.050308]  __do_sys_init_module+0x11d/0x180
[15937.050318]  do_syscall_64+0x38/0x90
[15937.050326]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[15937.050333] RIP: 0033:0x7f870ad3692e
[15937.050339] Code: 48 8b 0d fd 74 0e 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ca 74 0e 00 f7 d8 64 89
01 48
[15937.050343] RSP: 002b:00007ffcb68727a8 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[15937.050350] RAX: ffffffffffffffda RBX: 00005612d888dda0 RCX: 00007f870ad3692e
[15937.050353] RDX: 00005612d888db50 RSI: 0000000000009c66 RDI: 00005612d889c510
[15937.050357] RBP: 00005612d889c510 R08: 00005612d888e050 R09: 0000000000008010
[15937.050360] R10: 0000000000000005 R11: 0000000000000246 R12: 00005612d888db50
[15937.050363] R13: 00005612d888deb0 R14: 00005612d888dda0 R15: 00005612d888e000
[15937.050371]  </TASK>
[15937.050372] ---[ end trace bd15abbb81b882d3 ]---
[15937.103862] printk: console [netcon0] enabled
[15937.103881] netconsole: network logging started


Downstream bug
https://bugzilla.redhat.com/show_bug.cgi?id=2052823


-- 
Chris Murphy
