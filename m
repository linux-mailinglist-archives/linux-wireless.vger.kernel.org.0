Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD27D3E6D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjJWR7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjJWR7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 13:59:33 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA900DA
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 10:59:29 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6C5619C007A
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 17:59:27 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D0F2213C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 10:59:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D0F2213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698083966;
        bh=aTti2JDdyvZp1PGJXnWGiu57xwxjEh3fd1fvA4pcpGU=;
        h=Date:To:From:Subject:From;
        b=ltJQu/SAOjcutof/CKmVt+xNYFglTPQcK376fXkpF0WH+rWwq8KyjUQt+gdEheBLX
         7wH/Uxhkj0ba8z4wpMqAyyIGQ+gszknNbZV3NNGs3txElR+Ou6HNb9uchG3RfeC4Qr
         5oST4dCFxIJsfF7f0vCCQDWjJkjqZBhVKq/khTMc=
Message-ID: <e40d7c53-e2f1-f550-bacf-b17c45236db0@candelatech.com>
Date:   Mon, 23 Oct 2023 10:59:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Details on wireless-next mlme crash.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698083968-qTwvf8vaupPG
X-MDID-O: us5;at1;1698083968;qTwvf8vaupPG;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I posted a patch to work around a crash I was seeing.  Here are kernel logs of
that warning happening, and a bit of code before that.

Oct 23 10:45:32 ct523c-2103 kernel: sta09001: deauthenticating from 40:ed:00:14:f5:f3 by local choice (Reason: 3=DEAUTH_LEAVING)
Oct 23 10:45:32 ct523c-2103 kernel: sta09001: do_stop, canceling dfs-cac-timer-work.
Oct 23 10:45:32 ct523c-2103 kernel: sta09001: 84:3e:1d:8d:70:3a authenticate with 40:ed:00:14:f5:f3 (local address=84:3e:1d:8d:70:3a)
Oct 23 10:45:32 ct523c-2103 kernel: sta09001: send auth to 40:ed:00:14:f5:f3 (try 1/4)
Oct 23 10:45:32 ct523c-2103 kernel: sta09001: aborting authentication with 40:ed:00:14:f5:f3 by local choice (Reason: 3=DEAUTH_LEAVING)
Oct 23 10:45:32 ct523c-2103 kernel: ------------[ cut here ]------------
Oct 23 10:45:32 ct523c-2103 kernel: WARNING: CPU: 3 PID: 7805 at net/mac80211/mlme.c:8188 ieee80211_mgd_deauth+0x348/0x520 [mac80211]
Oct 23 10:45:32 ct523c-2103 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 bpfilter vrf 8021q garp mrp stp 
llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg iTCO_wdt intel_pmc_bxt ee1004 intel_rapl_msr iTCO_vendor_support snd_hda_codec_hdmi 
coretemp intel_rapl_common snd_hda_codec_realtek intel_tcc_cooling snd_hda_codec_generic ledtrig_audio iwlmvm x86_pkg_temp_thermal intel_powerclamp mt7921e 
mt7921_common snd_hda_intel kvm_intel mt792x_lib snd_intel_dspcfg mt76_connac_lib mt76 snd_hda_codec kvm mac80211 snd_hda_core snd_hwdep iwlwifi snd_seq 
irqbypass snd_seq_device snd_pcm intel_wmi_thunderbolt pcspkr snd_timer cfg80211 snd tpm_crb bfq i2c_i801 soundcore i2c_smbus mei_pxp mei_hdcp tpm_tis 
tpm_tis_core intel_pch_thermal tpm acpi_pad nfsd auth_rpcgss nfs_acl lockd grace sch_fq_codel sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov 
async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt igb drm_display_helper i2c_algo_bit
Oct 23 10:45:32 ct523c-2103 kernel:  drm_kms_helper cec rc_core ttm drm agpgart ixgbe mdio dca xhci_pci mei_wdt xhci_pci_renesas i2c_core hwmon video wmi [last 
unloaded: nfnetlink]
Oct 23 10:45:32 ct523c-2103 kernel: CPU: 3 PID: 7805 Comm: wpa_supplicant Tainted: G        W          6.6.0-rc5+ #13
Oct 23 10:45:32 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Oct 23 10:45:32 ct523c-2103 kernel: RIP: 0010:ieee80211_mgd_deauth+0x348/0x520 [mac80211]
Oct 23 10:45:32 ct523c-2103 kernel: Code: 01 00 00 00 c7 44 24 18 03 00 00 00 e8 21 b1 d7 ff 48 8b bb 60 0f 00 00 48 89 de 48 8d 54 24 10 e8 2d 28 ff ff e9 4a 
fe ff ff <0f> 0b 48 c7 c7 08 20 e7 a0 4c 89 ea 4c 89 f6 e8 24 0b ff ff 4c 8d
Oct 23 10:45:32 ct523c-2103 kernel: RSP: 0018:ffffc90009287948 EFLAGS: 00010293
Oct 23 10:45:32 ct523c-2103 kernel: RAX: 0000000000000000 RBX: ffff888123094a00 RCX: 0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: RDX: 0000000000000000 RSI: ffff88845dcdc480 RDI: ffff88845dcdc480
Oct 23 10:45:32 ct523c-2103 kernel: RBP: ffffc900092879c8 R08: 0000000000000000 R09: ffffc90009287790
Oct 23 10:45:32 ct523c-2103 kernel: R10: 0000000000000003 R11: ffffffff8274aa28 R12: 0000000000000001
Oct 23 10:45:32 ct523c-2103 kernel: R13: ffff888123095d50 R14: ffff888123095978 R15: ffffffffa0a81a60
Oct 23 10:45:32 ct523c-2103 kernel: FS:  00007f92d2ed3780(0000) GS:ffff88845dcc0000(0000) knlGS:0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 23 10:45:32 ct523c-2103 kernel: CR2: 00007f3107008edc CR3: 000000012af39006 CR4: 00000000003706e0
Oct 23 10:45:32 ct523c-2103 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Oct 23 10:45:32 ct523c-2103 kernel: Call Trace:
Oct 23 10:45:32 ct523c-2103 kernel:  <TASK>
Oct 23 10:45:32 ct523c-2103 kernel:  ? ieee80211_mgd_deauth+0x348/0x520 [mac80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? __warn+0x78/0x130
Oct 23 10:45:32 ct523c-2103 kernel:  ? ieee80211_mgd_deauth+0x348/0x520 [mac80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? report_bug+0x169/0x1a0
Oct 23 10:45:32 ct523c-2103 kernel:  ? handle_bug+0x41/0x70
Oct 23 10:45:32 ct523c-2103 kernel:  ? exc_invalid_op+0x13/0x60
Oct 23 10:45:32 ct523c-2103 kernel:  ? asm_exc_invalid_op+0x16/0x20
Oct 23 10:45:32 ct523c-2103 kernel:  ? ieee80211_mgd_deauth+0x348/0x520 [mac80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? ieee80211_mgd_deauth+0x1f8/0x520 [mac80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? percpu_counter_destroy_many+0x88/0xc0
Oct 23 10:45:32 ct523c-2103 kernel:  ? __kmem_cache_alloc_node+0x42/0x1e0
Oct 23 10:45:32 ct523c-2103 kernel:  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x41/0xe0
Oct 23 10:45:32 ct523c-2103 kernel:  ? __rtnl_unlock+0x2e/0x60
Oct 23 10:45:32 ct523c-2103 kernel:  cfg80211_mlme_deauth+0x9a/0x1b0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  nl80211_deauthenticate+0x96/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  genl_family_rcv_msg_doit+0xd1/0x120
Oct 23 10:45:32 ct523c-2103 kernel:  genl_rcv_msg+0x17b/0x290
Oct 23 10:45:32 ct523c-2103 kernel:  ? __cfg80211_wdev_from_attrs+0x290/0x290 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? nl80211_disassociate+0xc0/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? nlmsg_trim+0x20/0x20 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
Oct 23 10:45:32 ct523c-2103 kernel:  netlink_rcv_skb+0x4f/0x100
Oct 23 10:45:32 ct523c-2103 kernel:  genl_rcv+0x1f/0x30
Oct 23 10:45:32 ct523c-2103 kernel:  netlink_unicast+0x18b/0x280
Oct 23 10:45:32 ct523c-2103 kernel:  netlink_sendmsg+0x24b/0x4c0
Oct 23 10:45:32 ct523c-2103 kernel:  __sock_sendmsg+0x33/0x60
Oct 23 10:45:32 ct523c-2103 kernel:  ____sys_sendmsg+0x229/0x2a0
Oct 23 10:45:32 ct523c-2103 kernel:  ? copy_msghdr_from_user+0x68/0xa0
Oct 23 10:45:32 ct523c-2103 kernel:  ___sys_sendmsg+0x81/0xc0
Oct 23 10:45:32 ct523c-2103 kernel:  ? generic_perform_write+0x14b/0x220
Oct 23 10:45:32 ct523c-2103 kernel:  __sys_sendmsg+0x52/0xa0
Oct 23 10:45:32 ct523c-2103 kernel:  do_syscall_64+0x34/0xb0
Oct 23 10:45:32 ct523c-2103 kernel:  entry_SYSCALL_64_after_hwframe+0x46/0xb0
Oct 23 10:45:32 ct523c-2103 kernel: RIP: 0033:0x7f92d2713737
Oct 23 10:45:32 ct523c-2103 kernel: Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
Oct 23 10:45:32 ct523c-2103 kernel: RSP: 002b:00007ffdf0343958 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
Oct 23 10:45:32 ct523c-2103 kernel: RAX: ffffffffffffffda RBX: 000000000268b0b0 RCX: 00007f92d2713737
Oct 23 10:45:32 ct523c-2103 kernel: RDX: 0000000000000000 RSI: 00007ffdf03439b0 RDI: 0000000000000010
Oct 23 10:45:32 ct523c-2103 kernel: RBP: 000000000269b8a0 R08: 0000000000000004 R09: 00000000000000f0
Oct 23 10:45:32 ct523c-2103 kernel: R10: 00007ffdf0343a74 R11: 0000000000000246 R12: 0000000002677a40
Oct 23 10:45:32 ct523c-2103 kernel: R13: 00007ffdf03439b0 R14: 00000000000000f3 R15: 0000000000000003
Oct 23 10:45:32 ct523c-2103 kernel:  </TASK>
Oct 23 10:45:32 ct523c-2103 kernel: ---[ end trace 0000000000000000 ]---
Oct 23 10:45:32 ct523c-2103 kernel: sta09001: ieee80211-mgd-auth abort auth, bad memory: ifmgd: 000000000ca587c2  ifmgd->assoc_data: 0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: ------------[ cut here ]------------
Oct 23 10:45:32 ct523c-2103 kernel: WARNING: CPU: 7 PID: 7805 at net/wireless/mlme.c:141 cfg80211_process_disassoc+0xa9/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 bpfilter vrf 8021q garp mrp stp 
llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg iTCO_wdt intel_pmc_bxt ee1004 intel_rapl_msr iTCO_vendor_support snd_hda_codec_hdmi 
coretemp intel_rapl_common snd_hda_codec_realtek intel_tcc_cooling snd_hda_codec_generic ledtrig_audio iwlmvm x86_pkg_temp_thermal intel_powerclamp mt7921e 
mt7921_common snd_hda_intel kvm_intel mt792x_lib snd_intel_dspcfg mt76_connac_lib mt76 snd_hda_codec kvm mac80211 snd_hda_core snd_hwdep iwlwifi snd_seq 
irqbypass snd_seq_device snd_pcm intel_wmi_thunderbolt pcspkr snd_timer cfg80211 snd tpm_crb bfq i2c_i801 soundcore i2c_smbus mei_pxp mei_hdcp tpm_tis 
tpm_tis_core intel_pch_thermal tpm acpi_pad nfsd auth_rpcgss nfs_acl lockd grace sch_fq_codel sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov 
async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt igb drm_display_helper i2c_algo_bit
Oct 23 10:45:32 ct523c-2103 kernel:  drm_kms_helper cec rc_core ttm drm agpgart ixgbe mdio dca xhci_pci mei_wdt xhci_pci_renesas i2c_core hwmon video wmi [last 
unloaded: nfnetlink]
Oct 23 10:45:32 ct523c-2103 kernel: CPU: 7 PID: 7805 Comm: wpa_supplicant Tainted: G        W          6.6.0-rc5+ #13
Oct 23 10:45:32 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Oct 23 10:45:32 ct523c-2103 kernel: RIP: 0010:cfg80211_process_disassoc+0xa9/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel: Code: c0 33 55 10 09 c2 75 22 48 8b 7b 20 41 0f b7 cc 45 89 e8 31 d2 31 f6 e8 a5 64 00 00 48 89 df 5b 5d 41 5c 41 5d e9 17 
53 00 00 <0f> 0b 5b 5d 41 5c 41 5d c3 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00
Oct 23 10:45:32 ct523c-2103 kernel: RSP: 0018:ffffc90009287920 EFLAGS: 00010246
Oct 23 10:45:32 ct523c-2103 kernel: RAX: 0000000000000000 RBX: ffff888123095218 RCX: 0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: RBP: ffffc90009287976 R08: 0000000000000000 R09: ffffc90009287818
Oct 23 10:45:32 ct523c-2103 kernel: R10: ffff888110eac110 R11: 0000000000000000 R12: 000000000000ffff
Oct 23 10:45:32 ct523c-2103 kernel: R13: 0000000000000001 R14: ffffc9000928794c R15: ffffffffa0a81a60
Oct 23 10:45:32 ct523c-2103 kernel: FS:  00007f92d2ed3780(0000) GS:ffff88845ddc0000(0000) knlGS:0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 23 10:45:32 ct523c-2103 kernel: CR2: 00007fb68900fe00 CR3: 000000012af39002 CR4: 00000000003706e0
Oct 23 10:45:32 ct523c-2103 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Oct 23 10:45:32 ct523c-2103 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Oct 23 10:45:32 ct523c-2103 kernel: Call Trace:
Oct 23 10:45:32 ct523c-2103 kernel:  <TASK>
Oct 23 10:45:32 ct523c-2103 kernel:  ? cfg80211_process_disassoc+0xa9/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? __warn+0x78/0x130
Oct 23 10:45:32 ct523c-2103 kernel:  ? cfg80211_process_disassoc+0xa9/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? report_bug+0x169/0x1a0
Oct 23 10:45:32 ct523c-2103 kernel:  ? handle_bug+0x41/0x70
Oct 23 10:45:32 ct523c-2103 kernel:  ? exc_invalid_op+0x13/0x60
Oct 23 10:45:32 ct523c-2103 kernel:  ? asm_exc_invalid_op+0x16/0x20
Oct 23 10:45:32 ct523c-2103 kernel:  ? cfg80211_process_disassoc+0xa9/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ieee80211_mgd_deauth+0x3b9/0x520 [mac80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x41/0xe0
Oct 23 10:45:32 ct523c-2103 kernel:  ? __rtnl_unlock+0x2e/0x60
Oct 23 10:45:32 ct523c-2103 kernel:  cfg80211_mlme_deauth+0x9a/0x1b0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  nl80211_deauthenticate+0x96/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  genl_family_rcv_msg_doit+0xd1/0x120
Oct 23 10:45:32 ct523c-2103 kernel:  genl_rcv_msg+0x17b/0x290
Oct 23 10:45:32 ct523c-2103 kernel:  ? __cfg80211_wdev_from_attrs+0x290/0x290 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? nl80211_disassociate+0xc0/0xc0 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? nlmsg_trim+0x20/0x20 [cfg80211]
Oct 23 10:45:32 ct523c-2103 kernel:  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
Oct 23 10:45:32 ct523c-2103 kernel:  netlink_rcv_skb+0x4f/0x100
Oct 23 10:45:32 ct523c-2103 kernel:  genl_rcv+0x1f/0x30
Oct 23 10:45:32 ct523c-2103 kernel:  netlink_unicast+0x18b/0x280
Oct 23 10:45:32 ct523c-2103 kernel:  netlink_sendmsg+0x24b/0x4c0
Oct 23 10:45:32 ct523c-2103 kernel:  __sock_sendmsg+0x33/0x60
Oct 23 10:45:32 ct523c-2103 kernel:  ____sys_sendmsg+0x229/0x2a0
Oct 23 10:45:32 ct523c-2103 kernel:  ? copy_msghdr_from_user+0x68/0xa0
Oct 23 10:45:32 ct523c-2103 kernel:  ___sys_sendmsg+0x81/0xc0
Oct 23 10:45:32 ct523c-2103 kernel:  ? generic_perform_write+0x14b/0x220
Oct 23 10:45:32 ct523c-2103 kernel:  __sys_sendmsg+0x52/0xa0
Oct 23 10:45:32 ct523c-2103 kernel:  do_syscall_64+0x34/0xb0
Oct 23 10:45:32 ct523c-2103 kernel:  entry_SYSCALL_64_after_hwframe+0x46/0xb0
Oct 23 10:45:32 ct523c-2103 kernel: RIP: 0033:0x7f92d2713737
Oct 23 10:45:32 ct523c-2103 kernel: Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
Oct 23 10:45:32 ct523c-2103 kernel: RSP: 002b:00007ffdf0343958 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
Oct 23 10:45:32 ct523c-2103 kernel: RAX: ffffffffffffffda RBX: 000000000268b0b0 RCX: 00007f92d2713737
Oct 23 10:45:32 ct523c-2103 kernel: RDX: 0000000000000000 RSI: 00007ffdf03439b0 RDI: 0000000000000010
Oct 23 10:45:32 ct523c-2103 kernel: RBP: 000000000269b8a0 R08: 0000000000000004 R09: 00000000000000f0
Oct 23 10:45:32 ct523c-2103 kernel: R10: 00007ffdf0343a74 R11: 0000000000000246 R12: 0000000002677a40
Oct 23 10:45:32 ct523c-2103 kernel: R13: 00007ffdf03439b0 R14: 00000000000000f3 R15: 0000000000000003
Oct 23 10:45:32 ct523c-2103 kernel:  </TASK>
Oct 23 10:45:32 ct523c-2103 kernel: ---[ end trace 0000000000000000 ]---

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

