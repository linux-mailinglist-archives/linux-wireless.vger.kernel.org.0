Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14AD7D8C52
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjJZXuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 19:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 19:50:09 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2653C1A5
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 16:50:06 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CE8C6340067
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 23:50:03 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6676913C2B0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 16:50:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6676913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698364202;
        bh=k3C3i6VUjthXmS5aZt4ix+RSQdYJqIWMBHPNrDT0A00=;
        h=Date:To:From:Subject:From;
        b=khnLX7J5A90mIqKdIlol36GJlH3cWo4cVZB39IBsOD3gCDfOztZLLFePTtVAR0j7A
         CFuFAdITeMSNp4hukZlgDjNpgRr0Sso2jrB/skHJy5+zxadbDgbAj7ZTWZXpgBqDkM
         Wt0ozWbJ4QiUlIjn2/29lSLJVwL0t6TMQR8rcuyY=
Message-ID: <724c3f18-b5b7-637e-67e1-07cb5214a967@candelatech.com>
Date:   Thu, 26 Oct 2023 16:50:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Question on how to lock mac80211/debugfs_sta when accessing a link.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698364204-MKOX5WhfFqj2
X-MDID-O: us5;ut7;1698364204;MKOX5WhfFqj2;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have a patch to grab some info from the link object in
link_sta_vht_capa_read(), and based on lockdep warnings, it seems
I need to hold the wiphy mutex before I grab the link:

 From my modified logic:

static ssize_t link_sta_vht_capa_read(struct file *file, char __user *userbuf,
				      size_t count, loff_t *ppos)
{
	char *buf, *p;
	struct link_sta_info *link_sta = file->private_data;
	struct ieee80211_sta_vht_cap *vhtc = &link_sta->pub->vht_cap;
	struct cfg80211_chan_def *chandef = &link_sta->sta->sdata->vif.bss_conf.chandef;
	struct ieee80211_sub_if_data *sdata = link_sta->sta->sdata;
	struct ieee80211_link_data *link;
	ssize_t ret;
	ssize_t bufsz = 512;

	buf = kzalloc(bufsz, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;
	p = buf;

	wiphy_lock(sdata->local->hw.wiphy);
	link = sdata_dereference(sdata->link[link_sta->link_id], sdata);

	if (link && link->conf)
		chandef = &link->conf->chandef;
...
	p += scnprintf(p, bufsz + buf - p, "Chandef-Bandwidth:\t");
	switch (chandef->width) {
	case NL80211_CHAN_WIDTH_20_NOHT:
		p += scnprintf(p, bufsz + buf - p, "20Mhz-NOHT");
		break;
....
	wiphy_unlock(sdata->local->hw.wiphy);
...


While running with this code in place, I saw the OS lockup, and I am suspicious that this is because
something is reading from the debugfs file (and blocked trying to grab the mtx) while something else
is trying to remove debugfs files while already holding the mtx.

I assume there is *some* way to safely access the link in the debugfs code...any idea how?

I notice that sta_agg_status_write() method already grabs the wiphy lock, so probably it would
have same potential lockup.

Lockup splat is below.


[ 1804.595179] INFO: task kworker/7:2:102 blocked for more than 180 seconds.
[ 1804.600874]       Tainted: G        W          6.6.0-rc5+ #6
[ 1804.605288] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1804.611877] task:kworker/7:2     state:D stack:0     pid:102   ppid:2      flags:0x00004000
[ 1804.611890] Workqueue: events cfg80211_wiphy_work [cfg80211]
[ 1804.612047] Call Trace:
[ 1804.612052]  <TASK>
[ 1804.612063]  __schedule+0x7aa/0x16e0
[ 1804.612084]  ? io_schedule_timeout+0xb0/0xb0
[ 1804.612103]  ? lock_release+0x1d1/0x3b0
[ 1804.612112]  ? schedule+0xd0/0x110
[ 1804.612121]  ? reacquire_held_locks+0x270/0x270
[ 1804.612135]  ? mark_held_locks+0x65/0x90
[ 1804.612147]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.612161]  schedule+0x89/0x110
[ 1804.612171]  schedule_preempt_disabled+0xc/0x20
[ 1804.612178]  __mutex_lock+0x976/0x1200
[ 1804.612191]  ? cfg80211_wiphy_work+0x22/0x170 [cfg80211]
[ 1804.612345]  ? mutex_lock_io_nested+0xfe0/0xfe0
[ 1804.612354]  ? lock_acquire+0x15a/0x3b0
[ 1804.612363]  ? process_one_work+0x3c0/0x8f0
[ 1804.612377]  ? lock_sync+0xf0/0xf0
[ 1804.612383]  ? lock_sync+0xf0/0xf0
[ 1804.612392]  ? reacquire_held_locks+0x270/0x270
[ 1804.612411]  ? cfg80211_wiphy_work+0x22/0x170 [cfg80211]
[ 1804.612559]  cfg80211_wiphy_work+0x22/0x170 [cfg80211]
[ 1804.612710]  process_one_work+0x45e/0x8f0
[ 1804.612731]  ? kick_pool+0x1b0/0x1b0
[ 1804.612762]  worker_thread+0x380/0x680
[ 1804.612784]  ? create_worker+0x380/0x380
[ 1804.612792]  kthread+0x173/0x1b0
[ 1804.612800]  ? kthread_complete_and_exit+0x20/0x20
[ 1804.612811]  ret_from_fork+0x28/0x50
[ 1804.612818]  ? kthread_complete_and_exit+0x20/0x20
[ 1804.612827]  ret_from_fork_asm+0x11/0x20
[ 1804.612856]  </TASK>
[ 1804.612995] INFO: task wpa_supplicant:7306 blocked for more than 180 seconds.
[ 1804.618892]       Tainted: G        W          6.6.0-rc5+ #6
[ 1804.623303] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1804.629893] task:wpa_supplicant  state:D stack:0     pid:7306  ppid:1      flags:0x00004002
[ 1804.629905] Call Trace:
[ 1804.629909]  <TASK>
[ 1804.629920]  __schedule+0x7aa/0x16e0
[ 1804.629939]  ? io_schedule_timeout+0xb0/0xb0
[ 1804.629953]  ? lockdep_hardirqs_on_prepare+0x200/0x200
[ 1804.629967]  ? print_usage_bug.part.0+0x3d0/0x3d0
[ 1804.629986]  schedule+0x89/0x110
[ 1804.629995]  schedule_timeout+0x268/0x280
[ 1804.630005]  ? usleep_range_state+0xe0/0xe0
[ 1804.630012]  ? wait_for_completion+0xe0/0x270
[ 1804.630020]  ? reacquire_held_locks+0x270/0x270
[ 1804.630035]  ? mark_held_locks+0x65/0x90
[ 1804.630047]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.630055]  ? _raw_spin_unlock_irq+0x1f/0x40
[ 1804.630067]  wait_for_completion+0xe8/0x270
[ 1804.630079]  ? wait_for_completion_timeout+0x280/0x280
[ 1804.630115]  ? d_invalidate+0x110/0x170
[ 1804.630133]  ? shrink_dcache_parent+0x280/0x280
[ 1804.630155]  remove_one+0x78/0x90
[ 1804.630166]  simple_recursive_removal+0x2fc/0x480
[ 1804.630173]  ? start_creating.part.0+0x1e0/0x1e0
[ 1804.630194]  debugfs_remove+0x3b/0x60
[ 1804.630204]  ieee80211_sta_debugfs_remove+0x20/0x40 [mac80211]
[ 1804.630383]  __sta_info_destroy_part2+0x1ae/0x290 [mac80211]
[ 1804.630547]  __sta_info_flush+0x283/0x360 [mac80211]
[ 1804.630713]  ? __sta_info_destroy+0x30/0x30 [mac80211]
[ 1804.630874]  ? rcu_is_watching+0x1f/0x40
[ 1804.630883]  ? drv_mgd_complete_tx.part.0+0x230/0x260 [mac80211]
[ 1804.631062]  ieee80211_set_disassoc+0x2c4/0xbd0 [mac80211]
[ 1804.631253]  ? ieee80211_chswitch_done+0x2f0/0x2f0 [mac80211]
[ 1804.631427]  ? lock_acquire+0x15a/0x3b0
[ 1804.631448]  ieee80211_mgd_deauth+0x288/0xb10 [mac80211]
[ 1804.631624]  ? __mutex_unlock_slowpath+0x110/0x3d0
[ 1804.631635]  ? ieee80211_mgd_assoc+0x2910/0x2910 [mac80211]
[ 1804.631805]  ? wait_for_completion_interruptible+0x310/0x310
[ 1804.631821]  ? rcu_is_watching+0x1f/0x40
[ 1804.631841]  ? lock_is_held_type+0xa6/0x110
[ 1804.631856]  cfg80211_mlme_deauth+0x1db/0x480 [cfg80211]
[ 1804.632016]  ? cfg80211_mlme_assoc+0x590/0x590 [cfg80211]
[ 1804.632182]  ? kasan_set_track+0x21/0x30
[ 1804.632202]  nl80211_deauthenticate+0x174/0x1b0 [cfg80211]
[ 1804.632363]  genl_family_rcv_msg_doit+0x151/0x1d0
[ 1804.632376]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x120/0x120
[ 1804.632396]  ? cap_capable+0x9a/0xd0
[ 1804.632408]  ? security_capable+0x29/0x60
[ 1804.632424]  genl_rcv_msg+0x280/0x3b0
[ 1804.632438]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 1804.632448]  ? nl80211_assoc_bss+0xf0/0xf0 [cfg80211]
[ 1804.632597]  ? nl80211_disassociate+0x1b0/0x1b0 [cfg80211]
[ 1804.632745]  ? cfg80211_external_auth_request+0x340/0x340 [cfg80211]
[ 1804.632904]  ? lock_acquire+0x15a/0x3b0
[ 1804.632920]  netlink_rcv_skb+0xcf/0x210
[ 1804.632928]  ? lock_sync+0xf0/0xf0
[ 1804.632935]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 1804.632945]  ? netlink_ack+0x840/0x840
[ 1804.632975]  ? rwsem_down_read_slowpath+0x8e0/0x8e0
[ 1804.632987]  ? netlink_deliver_tap+0xf9/0x620
[ 1804.633004]  genl_rcv+0x1f/0x30
[ 1804.633013]  netlink_unicast+0x2e9/0x480
[ 1804.633026]  ? netlink_attachskb+0x400/0x400
[ 1804.633036]  ? __virt_addr_valid+0xab/0x130
[ 1804.633043]  ? check_stack_object+0x1d/0x60
[ 1804.633053]  ? __check_object_size+0x22c/0x3b0
[ 1804.633067]  netlink_sendmsg+0x3ca/0x6f0
[ 1804.633083]  ? netlink_unicast+0x480/0x480
[ 1804.633105]  ? import_ubuf+0xc1/0xf0
[ 1804.633117]  ? __import_iovec+0x25b/0x290
[ 1804.633127]  ? netlink_unicast+0x480/0x480
[ 1804.633136]  __sock_sendmsg+0x6e/0xb0
[ 1804.633149]  ____sys_sendmsg+0x3e6/0x470
[ 1804.633163]  ? kernel_sendmsg+0x30/0x30
[ 1804.633171]  ? __copy_msghdr+0x1a0/0x1a0
[ 1804.633178]  ? down_write+0xf2/0x180
[ 1804.633193]  ? up_write+0xfb/0x2d0
[ 1804.633210]  ___sys_sendmsg+0xdc/0x140
[ 1804.633222]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1804.633233]  ? find_held_lock+0x83/0xa0
[ 1804.633244]  ? lock_release+0x1d1/0x3b0
[ 1804.633252]  ? ksys_write+0xc2/0x160
[ 1804.633261]  ? reacquire_held_locks+0x270/0x270
[ 1804.633272]  ? __sys_recvfrom+0x169/0x200
[ 1804.633290]  ? netlink_setsockopt+0x2fb/0x470
[ 1804.633304]  ? netlink_connect+0x1c0/0x1c0
[ 1804.633315]  ? __fget_light+0xd2/0xf0
[ 1804.633334]  __sys_sendmsg+0xc4/0x150
[ 1804.633344]  ? __sys_sendmsg_sock+0x10/0x10
[ 1804.633355]  ? __fget_light+0xd2/0xf0
[ 1804.633382]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.633391]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1804.633405]  do_syscall_64+0x34/0xb0
[ 1804.633413]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 1804.633421] RIP: 0033:0x7f52d6513737
[ 1804.633428] RSP: 002b:00007ffcc0e8f6d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1804.633438] RAX: ffffffffffffffda RBX: 0000000001fb9a80 RCX: 00007f52d6513737
[ 1804.633444] RDX: 0000000000000000 RSI: 00007ffcc0e8f730 RDI: 000000000000000b
[ 1804.633449] RBP: 0000000001fc8470 R08: 0000000000000004 R09: 000000000000000d
[ 1804.633454] R10: 00007ffcc0e8f7f4 R11: 0000000000000246 R12: 0000000001fba8b0
[ 1804.633460] R13: 00007ffcc0e8f730 R14: 0000000000000000 R15: 0000000000000003
[ 1804.633487]  </TASK>
[ 1804.633500] INFO: task kworker/1:0:7949 blocked for more than 180 seconds.
[ 1804.639130]       Tainted: G        W          6.6.0-rc5+ #6
[ 1804.643537] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1804.650370] task:kworker/1:0     state:D stack:0     pid:7949  ppid:2      flags:0x00004000
[ 1804.650392] Workqueue: ipv6_addrconf addrconf_verify_work
[ 1804.650411] Call Trace:
[ 1804.650419]  <TASK>
[ 1804.650440]  __schedule+0x7aa/0x16e0
[ 1804.650475]  ? io_schedule_timeout+0xb0/0xb0
[ 1804.650488]  ? lock_release+0x1d1/0x3b0
[ 1804.650503]  ? schedule+0xd0/0x110
[ 1804.650519]  ? reacquire_held_locks+0x270/0x270
[ 1804.650547]  ? mark_held_locks+0x65/0x90
[ 1804.650571]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.650599]  schedule+0x89/0x110
[ 1804.650617]  schedule_preempt_disabled+0xc/0x20
[ 1804.650630]  __mutex_lock+0x976/0x1200
[ 1804.650655]  ? addrconf_verify_work+0x9/0x20
[ 1804.650676]  ? lock_acquire+0x15a/0x3b0
[ 1804.650694]  ? mutex_lock_io_nested+0xfe0/0xfe0
[ 1804.650719]  ? lock_sync+0xf0/0xf0
[ 1804.650756]  ? mark_held_locks+0x24/0x90
[ 1804.650788]  ? addrconf_verify_work+0x9/0x20
[ 1804.650802]  addrconf_verify_work+0x9/0x20
[ 1804.650817]  process_one_work+0x45e/0x8f0
[ 1804.650839]  ? kick_pool+0x1b0/0x1b0
[ 1804.650869]  worker_thread+0x380/0x680
[ 1804.650890]  ? create_worker+0x380/0x380
[ 1804.650899]  kthread+0x173/0x1b0
[ 1804.650906]  ? kthread_complete_and_exit+0x20/0x20
[ 1804.650917]  ret_from_fork+0x28/0x50
[ 1804.650924]  ? kthread_complete_and_exit+0x20/0x20
[ 1804.650933]  ret_from_fork_asm+0x11/0x20
[ 1804.650962]  </TASK>
[ 1804.650970] INFO: task kworker/7:1:8728 blocked for more than 180 seconds.
[ 1804.656610]       Tainted: G        W          6.6.0-rc5+ #6
[ 1804.661027] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1804.667633] task:kworker/7:1     state:D stack:0     pid:8728  ppid:2      flags:0x00004000
[ 1804.667645] Workqueue: events_power_efficient reg_check_chans_work [cfg80211]
[ 1804.667800] Call Trace:
[ 1804.667804]  <TASK>
[ 1804.667815]  __schedule+0x7aa/0x16e0
[ 1804.667834]  ? io_schedule_timeout+0xb0/0xb0
[ 1804.667840]  ? lock_release+0x1d1/0x3b0
[ 1804.667849]  ? schedule+0xd0/0x110
[ 1804.667857]  ? reacquire_held_locks+0x270/0x270
[ 1804.667871]  ? mark_held_locks+0x65/0x90
[ 1804.667883]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.667897]  schedule+0x89/0x110
[ 1804.667907]  schedule_preempt_disabled+0xc/0x20
[ 1804.667914]  __mutex_lock+0x976/0x1200
[ 1804.667920]  ? __lock_acquire+0x910/0x3240
[ 1804.667933]  ? reg_check_chans_work+0x74/0x7e0 [cfg80211]
[ 1804.668100]  ? mutex_lock_io_nested+0xfe0/0xfe0
[ 1804.668114]  ? lockdep_hardirqs_on_prepare+0x200/0x200
[ 1804.668144]  ? reg_check_chans_work+0x74/0x7e0 [cfg80211]
[ 1804.668292]  reg_check_chans_work+0x74/0x7e0 [cfg80211]
[ 1804.668444]  ? lock_sync+0xf0/0xf0
[ 1804.668456]  ? reg_query_database+0x280/0x280 [cfg80211]
[ 1804.668608]  ? mark_held_locks+0x24/0x90
[ 1804.668629]  process_one_work+0x45e/0x8f0
[ 1804.668649]  ? kick_pool+0x1b0/0x1b0
[ 1804.668680]  worker_thread+0x380/0x680
[ 1804.668701]  ? create_worker+0x380/0x380
[ 1804.668710]  kthread+0x173/0x1b0
[ 1804.668717]  ? kthread_complete_and_exit+0x20/0x20
[ 1804.668728]  ret_from_fork+0x28/0x50
[ 1804.668735]  ? kthread_complete_and_exit+0x20/0x20
[ 1804.668744]  ret_from_fork_asm+0x11/0x20
[ 1804.668773]  </TASK>
[ 1804.668781] INFO: task cat:9021 blocked for more than 180 seconds.
[ 1804.673707]       Tainted: G        W          6.6.0-rc5+ #6
[ 1804.678122] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1804.684706] task:cat             state:D stack:0     pid:9021  ppid:9011   flags:0x00000002
[ 1804.684716] Call Trace:
[ 1804.684720]  <TASK>
[ 1804.684731]  __schedule+0x7aa/0x16e0
[ 1804.684749]  ? io_schedule_timeout+0xb0/0xb0
[ 1804.684761]  ? lock_release+0x1d1/0x3b0
[ 1804.684769]  ? __mutex_lock+0x971/0x1200
[ 1804.684780]  ? do_raw_spin_lock+0x114/0x1a0
[ 1804.684789]  ? lock_is_held_type+0xa6/0x110
[ 1804.684807]  schedule+0x89/0x110
[ 1804.684817]  schedule_preempt_disabled+0xc/0x20
[ 1804.684823]  __mutex_lock+0x976/0x1200
[ 1804.684830]  ? find_held_lock+0x83/0xa0
[ 1804.684842]  ? link_sta_vht_capa_read+0xc9/0xb90 [mac80211]
[ 1804.685018]  ? __kmem_cache_alloc_node+0x3d/0x220
[ 1804.685028]  ? reacquire_held_locks+0x270/0x270
[ 1804.685037]  ? mutex_lock_io_nested+0xfe0/0xfe0
[ 1804.685048]  ? find_held_lock+0x83/0xa0
[ 1804.685066]  ? __kmem_cache_alloc_node+0x128/0x220
[ 1804.685073]  ? link_sta_vht_capa_read+0x8c/0xb90 [mac80211]
[ 1804.685265]  ? link_sta_vht_capa_read+0xc9/0xb90 [mac80211]
[ 1804.685437]  link_sta_vht_capa_read+0xc9/0xb90 [mac80211]
[ 1804.685627]  full_proxy_read+0x8c/0xb0
[ 1804.685642]  vfs_read+0x12c/0x4a0
[ 1804.685653]  ? kernel_read+0xc0/0xc0
[ 1804.685667]  ? find_held_lock+0x83/0xa0
[ 1804.685679]  ? lock_release+0x1d1/0x3b0
[ 1804.685687]  ? do_user_addr_fault+0x3d4/0x8d0
[ 1804.685698]  ? __fget_light+0xd2/0xf0
[ 1804.685714]  ksys_read+0xc2/0x160
[ 1804.685723]  ? __ia32_sys_pwrite64+0x130/0x130
[ 1804.685729]  ? mark_held_locks+0x24/0x90
[ 1804.685741]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.685757]  do_syscall_64+0x34/0xb0
[ 1804.685765]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 1804.685773] RIP: 0033:0x7f9103f01b92
[ 1804.685780] RSP: 002b:00007ffe47383a18 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 1804.685789] RAX: ffffffffffffffda RBX: 00007f910405e000 RCX: 00007f9103f01b92
[ 1804.685795] RDX: 0000000000020000 RSI: 00007f910405e000 RDI: 0000000000000003
[ 1804.685801] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
[ 1804.685806] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f910405e000
[ 1804.685811] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000020000
[ 1804.685838]  </TASK>
[ 1804.685843] INFO: task ip:9022 blocked for more than 180 seconds.
[ 1804.690685]       Tainted: G        W          6.6.0-rc5+ #6
[ 1804.695101] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1804.701682] task:ip              state:D stack:0     pid:9022  ppid:3570   flags:0x00000002
[ 1804.701692] Call Trace:
[ 1804.701697]  <TASK>
[ 1804.701707]  __schedule+0x7aa/0x16e0
[ 1804.701725]  ? io_schedule_timeout+0xb0/0xb0
[ 1804.701737]  ? lock_release+0x1d1/0x3b0
[ 1804.701745]  ? __mutex_lock+0x971/0x1200
[ 1804.701757]  ? do_raw_spin_lock+0x114/0x1a0
[ 1804.701765]  ? lock_is_held_type+0xa6/0x110
[ 1804.701783]  schedule+0x89/0x110
[ 1804.701792]  schedule_preempt_disabled+0xc/0x20
[ 1804.701799]  __mutex_lock+0x976/0x1200
[ 1804.701812]  ? cfg80211_netdev_notifier_call+0x48b/0x860 [cfg80211]
[ 1804.701956]  ? mark_lock+0x10b/0xd30
[ 1804.701964]  ? lock_release+0x1d1/0x3b0
[ 1804.701976]  ? mutex_lock_io_nested+0xfe0/0xfe0
[ 1804.702011]  ? cfg80211_netdev_notifier_call+0x48b/0x860 [cfg80211]
[ 1804.702163]  cfg80211_netdev_notifier_call+0x48b/0x860 [cfg80211]
[ 1804.702317]  ? cfg80211_register_netdevice+0x140/0x140 [cfg80211]
[ 1804.702476]  ? lockdep_hardirqs_on_prepare+0x200/0x200
[ 1804.702487]  ? lockdep_hardirqs_on_prepare+0x200/0x200
[ 1804.702497]  ? print_usage_bug.part.0+0x3d0/0x3d0
[ 1804.702516]  ? lock_acquire+0x15a/0x3b0
[ 1804.702524]  ? packet_notifier+0x46/0x440
[ 1804.702532]  ? find_held_lock+0x83/0xa0
[ 1804.702543]  ? lock_release+0x1d1/0x3b0
[ 1804.702551]  ? packet_notifier+0xfb/0x440
[ 1804.702559]  ? reacquire_held_locks+0x270/0x270
[ 1804.702573]  ? lock_is_held_type+0xa6/0x110
[ 1804.702592]  ? packet_notifier+0x100/0x440
[ 1804.702607]  notifier_call_chain+0x51/0x180
[ 1804.702624]  __dev_close_many+0xa7/0x1b0
[ 1804.702634]  ? netdev_notify_peers+0x20/0x20
[ 1804.702645]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.702653]  ? __local_bh_enable_ip+0x87/0xe0
[ 1804.702666]  __dev_change_flags+0x2a6/0x3b0
[ 1804.702681]  ? dev_set_allmulti+0x10/0x10
[ 1804.702703]  dev_change_flags+0x53/0xb0
[ 1804.702718]  do_setlink+0x5ae/0x1a70
[ 1804.702736]  ? rtnl_bridge_getlink+0x410/0x410
[ 1804.702743]  ? unwind_next_frame+0x4c/0xeb0
[ 1804.702751]  ? stack_access_ok+0x40/0xf0
[ 1804.702769]  ? is_bpf_text_address+0x65/0xf0
[ 1804.702778]  ? kernel_text_address+0x89/0x110
[ 1804.702787]  ? __kernel_text_address+0x9/0x30
[ 1804.702796]  ? unwind_get_return_address+0x2a/0x40
[ 1804.702803]  ? write_profile+0x220/0x220
[ 1804.702812]  ? arch_stack_walk+0x93/0xe0
[ 1804.702834]  ? __nla_validate_parse+0xb0/0x1160
[ 1804.702846]  ? stack_trace_save+0x8c/0xc0
[ 1804.702856]  ? filter_irq_stacks+0x18/0x60
[ 1804.702867]  ? nla_get_range_signed+0x160/0x160
[ 1804.702883]  ? kasan_save_stack+0x2b/0x40
[ 1804.702890]  ? kasan_save_stack+0x1c/0x40
[ 1804.702909]  __rtnl_newlink+0x770/0xd50
[ 1804.702926]  ? fs_reclaim_acquire+0x5e/0xe0
[ 1804.702939]  ? rtnl_setlink+0x240/0x240
[ 1804.702950]  ? lock_release+0x1d1/0x3b0
[ 1804.702957]  ? __kmem_cache_alloc_node+0x3d/0x220
[ 1804.702979]  ? kasan_unpoison+0x23/0x50
[ 1804.702988]  ? __kasan_slab_alloc+0x2f/0x70
[ 1804.702999]  ? __kmem_cache_alloc_node+0x10e/0x220
[ 1804.703006]  ? rtnl_newlink+0x31/0x70
[ 1804.703026]  rtnl_newlink+0x4a/0x70
[ 1804.703037]  rtnetlink_rcv_msg+0x210/0x7a0
[ 1804.703051]  ? rtnl_getlink+0x570/0x570
[ 1804.703064]  ? lockdep_hardirqs_on_prepare+0x200/0x200
[ 1804.703071]  ? mark_lock+0x10b/0xd30
[ 1804.703102]  netlink_rcv_skb+0xcf/0x210
[ 1804.703112]  ? rtnl_getlink+0x570/0x570
[ 1804.703122]  ? netlink_ack+0x840/0x840
[ 1804.703131]  ? lock_sync+0xf0/0xf0
[ 1804.703156]  ? __rcu_read_unlock+0x66/0x290
[ 1804.703168]  ? netlink_deliver_tap+0xf9/0x620
[ 1804.703188]  netlink_unicast+0x2e9/0x480
[ 1804.703201]  ? netlink_attachskb+0x400/0x400
[ 1804.703210]  ? __virt_addr_valid+0xab/0x130
[ 1804.703217]  ? check_stack_object+0x1d/0x60
[ 1804.703227]  ? __check_object_size+0x22c/0x3b0
[ 1804.703241]  netlink_sendmsg+0x3ca/0x6f0
[ 1804.703258]  ? netlink_unicast+0x480/0x480
[ 1804.703265]  ? reacquire_held_locks+0x270/0x270
[ 1804.703277]  ? import_ubuf+0xc1/0xf0
[ 1804.703288]  ? __import_iovec+0x25b/0x290
[ 1804.703298]  ? netlink_unicast+0x480/0x480
[ 1804.703307]  __sock_sendmsg+0x6e/0xb0
[ 1804.703320]  ____sys_sendmsg+0x3e6/0x470
[ 1804.703333]  ? kernel_sendmsg+0x30/0x30
[ 1804.703342]  ? __copy_msghdr+0x1a0/0x1a0
[ 1804.703371]  ___sys_sendmsg+0xdc/0x140
[ 1804.703382]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1804.703397]  ? kasan_save_stack+0x2b/0x40
[ 1804.703404]  ? kasan_save_stack+0x1c/0x40
[ 1804.703411]  ? __kasan_record_aux_stack+0x9c/0xb0
[ 1804.703418]  ? __call_rcu_common.constprop.0+0x42/0x3d0
[ 1804.703426]  ? __x64_sys_close+0x4c/0x90
[ 1804.703433]  ? do_syscall_64+0x34/0xb0
[ 1804.703439]  ? entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 1804.703448]  ? lock_acquire+0x15a/0x3b0
[ 1804.703456]  ? mntput_no_expire+0x85/0x5f0
[ 1804.703464]  ? find_held_lock+0x83/0xa0
[ 1804.703477]  ? mntput_no_expire+0xf0/0x5f0
[ 1804.703485]  ? reacquire_held_locks+0x270/0x270
[ 1804.703494]  ? find_held_lock+0x83/0xa0
[ 1804.703505]  ? lock_release+0x1d1/0x3b0
[ 1804.703515]  ? __fget_light+0xd2/0xf0
[ 1804.703533]  __sys_sendmsg+0xc4/0x150
[ 1804.703543]  ? __sys_sendmsg_sock+0x10/0x10
[ 1804.703553]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.703561]  ? percpu_counter_add_batch+0xd0/0x120
[ 1804.703589]  ? lockdep_hardirqs_on_prepare+0x132/0x200
[ 1804.703597]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1804.703611]  do_syscall_64+0x34/0xb0
[ 1804.703619]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 1804.703627] RIP: 0033:0x7fea97f13737
[ 1804.703633] RSP: 002b:00007ffc8d0d4fd8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1804.703642] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fea97f13737
[ 1804.703648] RDX: 0000000000000000 RSI: 00007ffc8d0d5040 RDI: 0000000000000004
[ 1804.703653] RBP: 0000000000000003 R08: 00000000653aef0d R09: 00007ffc8d0d798a
[ 1804.703658] R10: 00007fea97e0df08 R11: 0000000000000246 R12: 00000000653aef0e
[ 1804.703664] R13: 0000000000484540 R14: 0000000000000001 R15: 0000000000000000
[ 1804.703690]  </TASK>
[ 1804.703702]
                Showing all locks held in the system:
[ 1804.703716] 1 lock held by khungtaskd/65:
[ 1804.703722]  #0: ffffffff83843f00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x49/0x230
[ 1804.703752] 3 locks held by kworker/7:2/102:
[ 1804.703757]  #0: ffff888110060d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.703780]  #1: ffff88811a94fdc8 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.703803]  #2: ffff888171870768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0x22/0x170 [cfg80211]
[ 1804.703974] 1 lock held by systemd-journal/692:
[ 1804.704048] 1 lock held by fuse mainloop/2820:
[ 1804.704053]  #0: ffff88812a447468 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xd0
[ 1804.704080] 1 lock held by fuse mainloop/2821:
[ 1804.704097]  #0: ffff8881146bf868 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xd0
[ 1804.704158] 2 locks held by wpa_supplicant/6974:
[ 1804.704163]  #0: ffffffff83e2d5f0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x10/0x30
[ 1804.704186]  #1: ffffffff83df8228 (rtnl_mutex){+.+.}-{4:4}, at: nl80211_pre_doit+0x45/0x3d0 [cfg80211]
[ 1804.704360] 3 locks held by wpa_supplicant/7306:
[ 1804.704365]  #0: ffffffff83e2d5f0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x10/0x30
[ 1804.704388]  #1: ffff888171870768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: nl80211_pre_doit+0x317/0x3d0 [cfg80211]
[ 1804.704558]  #2: ffff8881b64d0150 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: simple_recursive_removal+0x215/0x480
[ 1804.704591] 3 locks held by kworker/1:0/7949:
[ 1804.704595]  #0: ffff88811c07e938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.704618]  #1: ffff8881c3f3fdc8 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.704641]  #2: ffffffff83df8228 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x9/0x20
[ 1804.704663] 2 locks held by kworker/0:0/8399:
[ 1804.704669] 3 locks held by kworker/7:0/8648:
[ 1804.704673]  #0: ffff88811c07e938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.704696]  #1: ffff8881ce0efdc8 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.704718]  #2: ffffffff83df8228 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x9/0x20
[ 1804.704741] 3 locks held by kworker/7:1/8728:
[ 1804.704745]  #0: ffff888110062138 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.704768]  #1: ffff88815404fdc8 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work+0x3c0/0x8f0
[ 1804.704790]  #2: ffffffff83df8228 (rtnl_mutex){+.+.}-{4:4}, at: reg_check_chans_work+0x74/0x7e0 [cfg80211]
[ 1804.704956] 1 lock held by cat/9021:
[ 1804.704960]  #0: ffff888171870768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: link_sta_vht_capa_read+0xc9/0xb90 [mac80211]
[ 1804.705160] 2 locks held by ip/9022:
[ 1804.705166]  #0: ffffffff83df8228 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x1d6/0x7a0
[ 1804.705189]  #1: ffff888171870768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_netdev_notifier_call+0x48b/0x860 [cfg80211]
[ 1804.705351] 3 locks held by sadc/9045:

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

