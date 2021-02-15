Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E231C346
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Feb 2021 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBOUxt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Feb 2021 15:53:49 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:49532 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhBOUxr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Feb 2021 15:53:47 -0500
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A8C5113C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Feb 2021 12:53:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A8C5113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1613422383;
        bh=7/M25k9rA6oatR5cX7+2U5XhQsHOC3l//YHknNIQMz8=;
        h=To:From:Subject:Date:From;
        b=BI2WmaAJBTH/Vxoq23QaQqqJZO9HS+qPaXE/BrErLeGUZM/Zh4Swl+eEpB9dbCR7N
         KwOO0ZRl4eEyPVVRIs2VCBwTSNPr70Dla7R1dtroMTZUzyFtOl7DLATTWO5xwUj4jQ
         8YnxaTTRaM9qZZJXjOQeHWieXLPwvmC9AaCZ79go=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlmvm lockdep splat 5.11.0+ kernel.
Organization: Candela Technologies
Message-ID: <aa833be9-9c22-1189-8b90-db78cd0e3f49@candelatech.com>
Date:   Mon, 15 Feb 2021 12:53:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I enabled lockdep in 5.11.0+ kernel (I have some patches to the ax200/ax210 driver, but likely nothing
that would affect this).


Is this a known problem?


void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
{
	WARN_ON_ONCE(in_irq());
	lockdep_assert_irqs_enabled();   #### this line is 178
#ifdef CONFIG_TRACE_IRQFLAGS
	local_irq_disable();
#endif


[   45.367697] ------------[ cut here ]------------
[   45.367712] WARNING: CPU: 2 PID: 4053 at kernel/softirq.c:178 __local_bh_enable_ip+0x9d/0xe0
[   45.367718] Modules linked in: vrf 8021q garp mrp stp llc macvlan pktgen nfsv3 nfs_acl nfs lockd grace nfs_ssc fscache f71882fg sunrpc snd_hda_codec_hdmi 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep mt7915e(O) snd_seq intel_rapl_msr 
snd_seq_device mt76(O) coretemp iTCO_wdt iwlmvm intel_pmc_bxt intel_rapl_common ee1004 iTCO_vendor_support mac80211 snd_pcm iwlwifi intel_wmi_thunderbolt 
x86_pkg_temp_thermal cfg80211 intel_powerclamp mei_hdcp snd_timer i2c_i801 snd intel_pch_thermal soundcore i2c_smbus mei_wdt acpi_pad sch_fq_codel raid1 dm_raid 
raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 intel_gtt drm_kms_helper cec rc_core igb i2c_algo_bit xhci_pci 
drm ixgbe mdio agpgart hwmon dca i2c_core xhci_pci_renesas wmi video fuse
[   45.367816] CPU: 2 PID: 4053 Comm: ip Tainted: G           O      5.11.0+ #1
[   45.367818] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
[   45.367820] RIP: 0010:__local_bh_enable_ip+0x9d/0xe0
[   45.367823] Code: 0d 18 a1 ec 7e e8 03 13 11 00 fb 66 0f 1f 44 00 00 65 8b 05 05 a1 ec 7e 85 c0 74 37 5b 5d c3 65 8b 05 b3 af ec 7e 85 c0 75 91 <0f> 0b eb 8d 
e8 9a 14 11 00 eb 9c 48 89 ef e8 20 e0 06 00 eb a5 65
[   45.367825] RSP: 0018:ffffc90001a932e8 EFLAGS: 00010046
[   45.367828] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 0000000000000000
[   45.367830] RDX: 0000000000000002 RSI: 0000000000000201 RDI: ffffffffa102e392
[   45.367831] RBP: ffffffffa102e392 R08: 0000000000000000 R09: 0000000000000001
[   45.367833] R10: 0000000000000046 R11: 0000000000000000 R12: 0000000000000097
[   45.367835] R13: ffff8881060fed98 R14: ffff8881020e7e00 R15: 000000000000000c
[   45.367836] FS:  00007f57b0f19800(0000) GS:ffff88826dc80000(0000) knlGS:0000000000000000
[   45.367838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.367840] CR2: 00007ffe883f3008 CR3: 0000000126347001 CR4: 00000000003706e0
[   45.367842] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   45.367843] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   45.367845] Call Trace:
[   45.367848]  iwl_pcie_gen2_enqueue_hcmd+0x532/0x8a0 [iwlwifi]
[   45.367874]  iwl_trans_pcie_gen2_send_hcmd+0x4d/0x3f0 [iwlwifi]
[   45.367891]  iwl_trans_send_cmd+0x6e/0x150 [iwlwifi]
[   45.367902]  iwl_mvm_send_cmd+0x23/0x70 [iwlmvm]
[   45.367920]  iwl_mvm_led_set+0xc1/0xe0 [iwlmvm]
[   45.367936]  led_trigger_event+0x41/0x70
[   45.367941]  ieee80211_do_open+0x349/0x8e0 [mac80211]
[   45.368000]  ? ieee80211_check_concurrent_iface+0x141/0x1c0 [mac80211]
[   45.368033]  __dev_open+0xdf/0x1b0
[   45.368039]  __dev_change_flags+0x1b4/0x230
[   45.368042]  ? __lock_acquire+0x38b/0x2370
[   45.368050]  dev_change_flags+0x1c/0x50
[   45.368054]  do_setlink+0x249/0x10b0
[   45.368063]  ? __nla_validate_parse+0x5f/0xac0
[   45.368068]  ? rcu_read_lock_sched_held+0x3a/0x70
[   45.368073]  ? trace_sched_overutilized_tp+0x9e/0xd0
[   45.368077]  ? update_sd_lb_stats.constprop.0+0x825/0x850
[   45.368087]  __rtnl_newlink+0x5f9/0x970
[   45.368097]  ? lock_acquire+0xcc/0x470
[   45.368101]  ? find_held_lock+0x2b/0x80
[   45.368105]  ? load_balance+0x645/0xe90
[   45.368110]  ? __lock_acquire+0x38b/0x2370
[   45.368118]  ? __lock_acquire+0x38b/0x2370
[   45.368146]  ? rtnl_newlink+0x26/0x60
[   45.368149]  ? rcu_read_lock_sched_held+0x3a/0x70
[   45.368152]  ? trace_kmalloc+0xa6/0xd0
[   45.368158]  rtnl_newlink+0x3f/0x60
[   45.368161]  rtnetlink_rcv_msg+0x16d/0x480
[   45.368165]  ? netlink_deliver_tap+0x8e/0x3c0
[   45.368172]  ? rtnetlink_put_metrics+0x1c0/0x1c0
[   45.368175]  netlink_rcv_skb+0x49/0xf0
[   45.368183]  netlink_unicast+0x186/0x240
[   45.368188]  netlink_sendmsg+0x24a/0x480
[   45.368197]  sock_sendmsg+0x2e/0x40
[   45.368201]  ____sys_sendmsg+0x218/0x230
[   45.368204]  ? import_iovec+0x2d/0x30
[   45.368208]  ? sendmsg_copy_msghdr+0x77/0xa0
[   45.368212]  ? __lock_acquire+0x38b/0x2370
[   45.368218]  ___sys_sendmsg+0x70/0xb0
[   45.368222]  ? sugov_exit+0x86/0xb0
[   45.368229]  ? __lock_acquire+0x38b/0x2370
[   45.368242]  __sys_sendmsg+0x54/0xa0
[   45.368251]  do_syscall_64+0x2d/0x70
[   45.368257]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   45.368262] RIP: 0033:0x7f57b10cd5e8
[   45.368264] Code: 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 75 7f 0c 00 8b 00 85 c0 75 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[   45.368266] RSP: 002b:00007fffb5285718 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   45.368269] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57b10cd5e8
[   45.368271] RDX: 0000000000000000 RSI: 00007fffb5285780 RDI: 0000000000000004
[   45.368272] RBP: 00000000602add9e R08: 0000000000000001 R09: 0000000000000076
[   45.368274] R10: fffffffffffffcc8 R11: 0000000000000246 R12: 0000000000000001
[   45.368275] R13: 00007fffb5285e10 R14: 00007fffb5287bbd R15: 00000000004814c0
[   45.368285] irq event stamp: 48989
[   45.368287] hardirqs last  enabled at (48987): [<ffffffff8114dcad>] __local_bh_enable_ip+0x7d/0xe0
[   45.368290] hardirqs last disabled at (48988): [<ffffffff81cca5df>] _raw_read_lock_irqsave+0x8f/0xa0
[   45.368293] softirqs last  enabled at (48986): [<ffffffffa102e392>] iwl_pcie_gen2_enqueue_hcmd+0x532/0x8a0 [iwlwifi]
[   45.368305] softirqs last disabled at (48989): [<ffffffffa102df50>] iwl_pcie_gen2_enqueue_hcmd+0xf0/0x8a0 [iwlwifi]
[   45.368315] ---[ end trace fabe536c32904154 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
