Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9137EE624
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjKPRvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 12:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRvi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 12:51:38 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC5189
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 09:51:34 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 570B9C00073;
        Thu, 16 Nov 2023 17:51:31 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 360EE13C2B0;
        Thu, 16 Nov 2023 09:51:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 360EE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1700157086;
        bh=X69F+qE043aVqo//x/LxdXKirDU9VYUrMXLtk/LjLzQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DTvMikXsC4GQl4Z+52xqjnNDYbkwfUjXjCNUG3CYWGxttSmjc3fqR6uim7wJCYR4T
         +fe22/NlRO2cyOAkSgdXXsU1bpi0L2cnNzlVWJRkIt+MO9UWmAat4FuCDAsSd0ci5F
         dOl1lRmBr1RT/w07PCfApOgjAunrunI+vxjYDHM0=
Message-ID: <cc2a770a-d780-5d7b-82a8-9837c407e720@candelatech.com>
Date:   Thu, 16 Nov 2023 09:51:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: iwlwifi: Add debugging around scan failure warning.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20231114212309.2180281-1-greearb@candelatech.com>
 <9574407e2be4c97b1ef2d9f73b5eecb08791ff56.camel@sipsolutions.net>
 <7a76305b-dd42-b866-f64f-93b7c8811f97@candelatech.com>
 <8693a54d50f05a7668b11518eea2de46dd13952d.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <8693a54d50f05a7668b11518eea2de46dd13952d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1700157092-yrZ5zKAC5gAE
X-MDID-O: us5;at1;1700157092;yrZ5zKAC5gAE;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/15/23 08:10, Johannes Berg wrote:
> On Wed, 2023-11-15 at 08:01 -0800, Ben Greear wrote:
>> On 11/15/23 00:57, Johannes Berg wrote:
>>> On Tue, 2023-11-14 at 13:23 -0800, greearb@candelatech.com wrote:
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> Provide additional information that may help debugging why
>>>> the WARN_ON is seen.
>>>>
>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>> ---
>>>>    drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>>>> index 75c5c58e14a5..ec24ece7c877 100644
>>>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>>>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>>>> @@ -2356,7 +2356,10 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *mvm,
>>>>    			link_id = ffs(vif->active_links) - 1;
>>>>    
>>>>    		link_info = scan_vif->link[link_id];
>>>> -		if (!WARN_ON(!link_info))
>>>> +		if (WARN_ON(!link_info))
>>>> +			IWL_ERR(mvm, "scan failure: Cannot find link info for link-id: %d active-links: 0x%x\n",
>>>> +				link_id, vif->active_links);
>>>>
>>>
>>> It would make sense to put the data *into* the warning, rather than
>>> separately? Though I'm not sure I see so much value in the long string
>>> (vs. just the data).
>>
>> I assume IWL_ERR will provide some extra context in systems with multiple radios,
>> so more useful than what I could easily put into WARN_* directly.
> 
> That's true, though not sure that helps so much more? You could put it
> easily into the warning though :)
> 
> Anyway, the point is that bug reports from the field often don't include
> the full log etc. so putting things _into_ the warning really is usually
> more useful than putting it after.
> 
>>>
>>> But honestly I'm not sure this really even is a problem at all? Some
>>> confusion can happen during firmware restart here, and not sure we can
>>> really fix that. Though maybe with the new locking we can.
>>
>> I see the splat, not sure why.  It would be nice to know if link-id is
>> corrupted somehow, or if active links is zero, etc.
> 
> Yeah in this case we'd really need more of the dynamic information to
> really debug it, I guess.

I found a splat with my debugging enabled today, running with the v86 firmware.  Looks like
immediate cause is that active_links was 0x0.  Logs are full of it, in fact.  Seems to always
be the same reason.

[ 4381.954574] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4000  need_scan_psc: 1 req-n-channels: 2
[ 4382.599873] ------------[ cut here ]------------
[ 4382.599880] WARNING: CPU: 3 PID: 6083 at drivers/net/wireless/intel/iwlwifi/mvm/scan.c:2359 iwl_mvm_scan_umac_v14_and_above+0x169a/0x1730 [iwlmvm]
[ 4382.599950] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt snd_hda_codec_hdmi ee1004 intel_pmc_bxt snd_hda_codec_realtek snd_hda_codec_generic 
iTCO_vendor_support ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling snd_hda_intel x86_pkg_temp_thermal snd_intel_dspcfg intel_powerclamp 
snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm irqbypass intel_wmi_thunderbolt snd_timer snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace fuse sunrpc zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper igb drm_kms_helper i2c_algo_bit cec rc_core ttm ixgbe mdio dca drm agpgart
[ 4382.600146]  hwmon mei_wdt xhci_pci i2c_core xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 4382.600167] CPU: 3 PID: 6083 Comm: wpa_supplicant Tainted: G        W          6.7.0-rc1+ #3
[ 4382.600173] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 4382.600177] RIP: 0010:iwl_mvm_scan_umac_v14_and_above+0x169a/0x1730 [iwlmvm]
[ 4382.600240] Code: 8b 84 24 28 01 00 00 48 0f ba e0 2f 0f 83 9a fe ff ff 41 83 ce 04 e9 91 fe ff ff e8 50 63 c2 df b8 80 ff ff ff e9 ec f7 ff ff <0f> 0b 4c 89 
ff e8 7c 65 c2 df 49 8b 3f 45 0f b7 c4 89 e9 48 c7 c2
[ 4382.600245] RSP: 0018:ffff88814342ed18 EFLAGS: 00010246
[ 4382.600251] RAX: 0000000000000000 RBX: ffff88814c0ef198 RCX: ffffffffa19e4a83
[ 4382.600256] RDX: dffffc0000000000 RSI: 0000000000000003 RDI: ffff88814c0efa80
[ 4382.600259] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102b98cd01
[ 4382.600263] R10: 0000000000000000 R11: 6048302418120c08 R12: 0000000000000000
[ 4382.600267] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88814b1454e8
[ 4382.600271] FS:  00007f32fbf4b780(0000) GS:ffff88841bf80000(0000) knlGS:0000000000000000
[ 4382.600276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4382.600280] CR2: 00007f604e9faa50 CR3: 00000001a07b2001 CR4: 00000000003706f0
[ 4382.600284] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4382.600288] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4382.600291] Call Trace:
[ 4382.600295]  <TASK>
[ 4382.600299]  ? __warn+0x9c/0x1f0
[ 4382.600307]  ? iwl_mvm_scan_umac_v14_and_above+0x169a/0x1730 [iwlmvm]
[ 4382.600384]  ? report_bug+0x1aa/0x1e0
[ 4382.600393]  ? handle_bug+0x41/0x80
[ 4382.600398]  ? exc_invalid_op+0x13/0x40
[ 4382.600404]  ? asm_exc_invalid_op+0x16/0x20
[ 4382.600413]  ? iwl_mvm_scan_umac_v14_and_above+0x13e3/0x1730 [iwlmvm]
[ 4382.600475]  ? iwl_mvm_scan_umac_v14_and_above+0x169a/0x1730 [iwlmvm]
[ 4382.600536]  ? iwl_mvm_scan_umac_v14_and_above+0x13e3/0x1730 [iwlmvm]
[ 4382.600597]  ? desc_read_finalized_seq+0x69/0xf0
[ 4382.600604]  ? desc_read+0x190/0x190
[ 4382.600609]  ? rcu_is_watching+0x1f/0x40
[ 4382.600615]  ? lock_acquire+0xc4/0x3b0
[ 4382.600621]  ? rcu_is_watching+0x1f/0x40
[ 4382.600627]  ? __iwl_info+0x1e0/0x1e0 [iwlwifi]
[ 4382.600690]  ? ieee80211_iterate_active_interfaces_atomic+0x78/0x100 [mac80211]
[ 4382.600849]  ? __iterate_interfaces+0x12e/0x220 [mac80211]
[ 4382.601000]  ? iwl_mvm_scan_umac_chan_flags_v2+0x2c0/0x2c0 [iwlmvm]
[ 4382.601063]  ? iwl_wait_stats_complete+0x30/0x30 [iwlmvm]
[ 4382.601125]  iwl_mvm_build_scan_cmd+0xb21/0x2110 [iwlmvm]
[ 4382.601190]  ? iwl_mvm_scan_umac_v12+0x530/0x530 [iwlmvm]
[ 4382.601253]  ? iwl_mvm_build_scan_probe+0x39e/0x550 [iwlmvm]
[ 4382.601316]  iwl_mvm_reg_scan_start+0x77a/0xa10 [iwlmvm]
[ 4382.601388]  ? iwl_mvm_check_running_scans+0x130/0x130 [iwlmvm]
[ 4382.601449]  ? stack_access_ok+0x40/0xf0
[ 4382.601482]  ? ieee80211_scan_accept_presp+0xb0/0xb0 [mac80211]
[ 4382.601623]  ? kasan_unpoison+0x23/0x50
[ 4382.601632]  iwl_mvm_mac_hw_scan+0x81/0xa0 [iwlmvm]
[ 4382.601689]  drv_hw_scan+0x15e/0x2f0 [mac80211]
[ 4382.601834]  __ieee80211_start_scan+0x5bf/0xb10 [mac80211]
[ 4382.601977]  ? drv_hw_scan+0x2f0/0x2f0 [mac80211]
[ 4382.602117]  ? __kasan_kmalloc+0x83/0x90
[ 4382.602122]  ? rcu_is_watching+0x1f/0x40
[ 4382.602128]  ? __kmalloc+0xd7/0x150
[ 4382.602136]  rdev_scan+0x6d/0x1d0 [cfg80211]
[ 4382.602276]  nl80211_trigger_scan+0x673/0xd10 [cfg80211]
[ 4382.602426]  genl_family_rcv_msg_doit+0x151/0x1d0
[ 4382.602435]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x120/0x120
[ 4382.602444]  ? cap_capable+0x9a/0xd0
[ 4382.602451]  ? security_capable+0x29/0x60
[ 4382.602458]  genl_rcv_msg+0x281/0x3b0
[ 4382.602465]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 4382.602471]  ? set_track_prepare+0x3b/0x60
[ 4382.602477]  ? kmalloc_reserve+0xa3/0x120
[ 4382.602482]  ? __alloc_skb+0xcb/0x210
[ 4382.602487]  ? nl80211_assoc_bss+0xf0/0xf0 [cfg80211]
[ 4382.602627]  ? nl80211_send_scan_start+0xd0/0xd0 [cfg80211]
[ 4382.602765]  ? cfg80211_external_auth_request+0x340/0x340 [cfg80211]
[ 4382.602901]  ? do_syscall_64+0x3b/0x110
[ 4382.602906]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 4382.602913]  ? ____sys_sendmsg+0x3e6/0x470
[ 4382.602918]  ? ___sys_sendmsg+0xdc/0x140
[ 4382.602926]  netlink_rcv_skb+0xcf/0x210
[ 4382.602931]  ? lock_sync+0xf0/0xf0
[ 4382.602936]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 4382.602943]  ? netlink_ack+0x840/0x840
[ 4382.602954]  ? rwsem_down_read_slowpath+0x920/0x920
[ 4382.602960]  ? netlink_deliver_tap+0x9f/0x630
[ 4382.602965]  ? netlink_deliver_tap+0xf9/0x630
[ 4382.602973]  genl_rcv+0x1f/0x30
[ 4382.602978]  netlink_unicast+0x2ee/0x490
[ 4382.602985]  ? netlink_attachskb+0x430/0x430
[ 4382.602990]  ? __virt_addr_valid+0xab/0x130
[ 4382.602996]  ? check_stack_object+0x1d/0x60
[ 4382.603003]  ? __check_object_size+0x22c/0x3b0
[ 4382.603010]  netlink_sendmsg+0x3ca/0x6f0
[ 4382.603018]  ? netlink_unicast+0x490/0x490
[ 4382.603025]  ? import_ubuf+0xa9/0xd0
[ 4382.603032]  ? __import_iovec+0x256/0x290
[ 4382.603038]  ? netlink_unicast+0x490/0x490
[ 4382.603044]  __sock_sendmsg+0x6e/0xb0
[ 4382.603050]  ____sys_sendmsg+0x3e6/0x470
[ 4382.603056]  ? kernel_sendmsg+0x30/0x30
[ 4382.603061]  ? __copy_msghdr+0x1a0/0x1a0
[ 4382.603069]  ? up_write+0xfb/0x2d0
[ 4382.603076]  ___sys_sendmsg+0xdc/0x140
[ 4382.603082]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 4382.603089]  ? netlink_setsockopt+0x2da/0x420
[ 4382.603096]  ? netlink_realloc_groups+0x180/0x180
[ 4382.603101]  ? reacquire_held_locks+0x270/0x270
[ 4382.603108]  ? sock_do_ioctl+0xaf/0x180
[ 4382.603114]  ? rcu_is_watching+0x1f/0x40
[ 4382.603120]  ? do_sock_setsockopt+0x162/0x2a0
[ 4382.603125]  ? move_addr_to_user+0xf0/0xf0
[ 4382.603133]  ? __fget_light+0xd2/0xf0
[ 4382.603141]  __sys_sendmsg+0xc4/0x150
[ 4382.603146]  ? __sys_sendmsg_sock+0x10/0x10
[ 4382.603152]  ? __sys_setsockopt+0x119/0x190
[ 4382.603158]  ? __ia32_sys_recv+0x60/0x60
[ 4382.603167]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 4382.603174]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 4382.603180]  ? trace_hardirqs_on+0x12/0xe0
[ 4382.603188]  do_syscall_64+0x3b/0x110
[ 4382.603193]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 4382.603199] RIP: 0033:0x7f32fb713737
[ 4382.603203] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 4382.603208] RSP: 002b:00007ffd9313fc08 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 4382.603215] RAX: ffffffffffffffda RBX: 0000000001dabc00 RCX: 00007f32fb713737
[ 4382.603219] RDX: 0000000000000000 RSI: 00007ffd9313fc60 RDI: 0000000000000007
[ 4382.603223] RBP: 0000000001e43e40 R08: 0000000000000004 R09: 00000000000000f0
[ 4382.603227] R10: 00007ffd9313fd24 R11: 0000000000000246 R12: 0000000001dabb10
[ 4382.603230] R13: 00007ffd9313fc60 R14: 000000000079cd98 R15: 00007f32fc093000
[ 4382.603239]  </TASK>
[ 4382.603243] irq event stamp: 0
[ 4382.603246] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 4382.603250] hardirqs last disabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 4382.603257] softirqs last  enabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 4382.603262] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 4382.603266] ---[ end trace 0000000000000000 ]---
[ 4382.603271] iwlwifi 0000:21:00.0: scan failure: Cannot find link info for link-id: 0 active-links: 0x0
[ 4382.611303] iwlwifi 0000:21:00.0: Scan failed! ret -5
[ 4382.615098] wlan15: _ieee80211_start_scan had failure code: -5
[ 4382.615103] scan: cfg80211_scan failed: -5
[ 4383.282455] wlan5: do_stop, canceling dfs-cac-timer-work.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


