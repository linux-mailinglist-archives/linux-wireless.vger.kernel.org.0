Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBD7E4B84
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 23:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjKGWLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 17:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjKGWK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 17:10:56 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB6E10D0
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 14:08:23 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1FFDC80007D;
        Tue,  7 Nov 2023 22:08:21 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9AE4113C2B0;
        Tue,  7 Nov 2023 14:08:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9AE4113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699394900;
        bh=FsxpWjn+b/kDPwEhKK5st7nRS6+OlQrslDeMucgeYuQ=;
        h=Date:To:Cc:From:Subject:From;
        b=CPiG+sJlQq6yqNB9nWNfLcr/jZ9nsWjdtD5awSYGoidYssFXndOpw6IAyC4e3bJiE
         L63o0KELP6nTDfuUwG8UP9xzl6oRYmDtLab66mpo27PYwfmsDiwa6xQ4mVKW0QAzll
         65U38f7PmwfxhwhsrJgppnizfqULLNP9Oj8hydbE=
Message-ID: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
Date:   Tue, 7 Nov 2023 14:08:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     "Berg, Johannes" <johannes.berg@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Subject: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of debugfs
 file.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1699394901-hBGbjtp-Rpin
X-MDID-O: us5;at1;1699394901;hBGbjtp-Rpin;<greearb@candelatech.com>;232dd55d48f96bb835b07b88a6baba61
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I think this lockup is because iw is holding rtnl and wiphy mutex,
and is blocked waiting for debugfs to be closed.  Another 'cat'
program has debugfs file open, and is blocking on trying to acquire
wiphy mutex.

I think we must not acquire wiphy mutex in debugfs methods, somehow,
to resolve this deadlock.  I do not know a safe way to do that.

93434 Nov 07 01:06:35 ct523c-2103 kernel: task:iw              state:D stack:
       0     pid:342999 tgid:342999 ppid:342998 flags:0x00004002
93435 Nov 07 01:06:35 ct523c-2103 kernel: Call Trace:
93436 Nov 07 01:06:35 ct523c-2103 kernel:  <TASK>
93437 Nov 07 01:06:35 ct523c-2103 kernel:  __schedule+0x377/0xa10
93438 Nov 07 01:06:35 ct523c-2103 kernel:  ? sched_clock_cpu+0xb/0x180
93439 Nov 07 01:06:35 ct523c-2103 kernel:  schedule+0x29/0xc0
93440 Nov 07 01:06:35 ct523c-2103 kernel:  schedule_timeout+0x136/0x150
93441 Nov 07 01:06:35 ct523c-2103 kernel:  ? d_walk+0x2a2/0x2b0
93442 Nov 07 01:06:35 ct523c-2103 kernel:  wait_for_completion+0x7d/0x130
93443 Nov 07 01:06:35 ct523c-2103 kernel:  remove_one+0x52/0x70
93444 Nov 07 01:06:35 ct523c-2103 kernel:  simple_recursive_removal+0x1e3/0x280
93445 Nov 07 01:06:35 ct523c-2103 kernel:  ? start_creating.part.0+0x170/0x170
93446 Nov 07 01:06:35 ct523c-2103 kernel:  debugfs_remove+0x3b/0x60
93447 Nov 07 01:06:35 ct523c-2103 kernel:  ieee80211_debugfs_remove_netdev+0x15//
       0x30 [mac80211]
93448 Nov 07 01:06:35 ct523c-2103 kernel:  ieee80211_teardown_sdata+0x13/0x50
       [mac80211]
93449 Nov 07 01:06:35 ct523c-2103 kernel:  unregister_netdevice_many_notify+
       0x3a8/0x7c0
93450 Nov 07 01:06:35 ct523c-2103 kernel:  unregister_netdevice_queue+0x84/0xc0
93451 Nov 07 01:06:35 ct523c-2103 kernel:  _cfg80211_unregister_wdev+0x1e7/
       0x230 [cfg80211]
93452 Nov 07 01:06:35 ct523c-2103 kernel:  ieee80211_if_remove+0x8b/0xe0
       [mac80211]
93453 Nov 07 01:06:35 ct523c-2103 kernel:  ieee80211_del_iface+0xc/0x10
       [mac80211]
93454 Nov 07 01:06:35 ct523c-2103 kernel:  cfg80211_remove_virtual_intf+0x28/
       0xd0 [cfg80211]
93455 Nov 07 01:06:35 ct523c-2103 kernel:  genl_family_rcv_msg_doit+0xd1/0x120
93456 Nov 07 01:06:35 ct523c-2103 kernel:  genl_rcv_msg+0x17b/0x290
93457 Nov 07 01:06:35 ct523c-2103 kernel:  ? __cfg80211_wdev_from_attrs+0x290/
       0x290 [cfg80211]
93458 Nov 07 01:06:35 ct523c-2103 kernel:  ? nl80211_stop_ap+0x30/0x30
       [cfg80211]
93459 Nov 07 01:06:35 ct523c-2103 kernel:  ? nlmsg_trim+0x20/0x20 [cfg80211]
93460 Nov 07 01:06:35 ct523c-2103 kernel:  ? genl_family_rcv_msg_dumpit+0xf0/
       0xf0
93461 Nov 07 01:06:35 ct523c-2103 kernel:  netlink_rcv_skb+0x4f/0x100
93462 Nov 07 01:06:35 ct523c-2103 kernel:  genl_rcv+0x1f/0x30
93463 Nov 07 01:06:35 ct523c-2103 kernel:  netlink_unicast+0x18b/0x280
93464 Nov 07 01:06:35 ct523c-2103 kernel:  netlink_sendmsg+0x24b/0x4c0
93465 Nov 07 01:06:35 ct523c-2103 kernel:  __sock_sendmsg+0x33/0x60
93466 Nov 07 01:06:35 ct523c-2103 kernel:  ____sys_sendmsg+0x229/0x2a0
93467 Nov 07 01:06:35 ct523c-2103 kernel:  ? copy_msghdr_from_user+0x68/0xa0
93468 Nov 07 01:06:35 ct523c-2103 kernel:  ___sys_sendmsg+0x81/0xc0
93469 Nov 07 01:06:35 ct523c-2103 kernel:  ? do_fault+0x238/0x450
93470 Nov 07 01:06:35 ct523c-2103 kernel:  __sys_sendmsg+0x52/0xa0
93471 Nov 07 01:06:35 ct523c-2103 kernel:  do_syscall_64+0x3b/0x110

gdb) l *(remove_one+0x52)
0xffffffff81540d22 is in remove_one (/home/greearb/git/linux-6.7.dev.y/fs/debugfs/inode.c:735).
730		smp_mb();
731		fsd = READ_ONCE(dentry->d_fsdata);
732		if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
733			return;
734		if (!refcount_dec_and_test(&fsd->active_users))
735			wait_for_completion(&fsd->active_users_drained);
736	}
737	
738	static void remove_one(struct dentry *victim)
739	{

(gdb) l *(wait_for_completion+0x7d)
0xffffffff81dbc47d is in wait_for_completion (/home/greearb/git/linux-6.7.dev.y/kernel/sched/completion.c:96).
91				}
92				__prepare_to_swait(&x->wait, &wait);
93				__set_current_state(state);
94				raw_spin_unlock_irq(&x->wait.lock);
95				timeout = action(timeout);
96				raw_spin_lock_irq(&x->wait.lock);
97			} while (!x->done && timeout);
98			__finish_swait(&x->wait, &wait);
99			if (!x->done)
100				return timeout;
(gdb)


I noticed a blocked 'cat' process.  This one has debugfs open, and is blocked on wiphy mutex:

101118 Nov 07 13:50:49 ct523c-2103 kernel: task:cat             state:D stack:
        0     pid:343014 tgid:343014 ppid:342995 flags:0x00000002
101119 Nov 07 13:50:49 ct523c-2103 kernel: Call Trace:
101120 Nov 07 13:50:49 ct523c-2103 kernel:  <TASK>
101121 Nov 07 13:50:49 ct523c-2103 kernel:  __schedule+0x377/0xa10
101122 Nov 07 13:50:49 ct523c-2103 kernel:  schedule+0x29/0xc0
101123 Nov 07 13:50:49 ct523c-2103 kernel:  schedule_preempt_disabled+0xc/0x20
101124 Nov 07 13:50:49 ct523c-2103 kernel:  __mutex_lock.constprop.0+0x34d/0x760
101125 Nov 07 13:50:49 ct523c-2103 kernel:  ?
        ieee80211_if_fmt_dot11MeshMaxRetries+0x20/0x20 [mac80211]
101126 Nov 07 13:50:49 ct523c-2103 kernel:  ieee80211_if_read_sdata+0x3f/0xb0
        [mac80211]
101127 Nov 07 13:50:49 ct523c-2103 kernel:  ? __pte_offset_map+0x12/0x160
101128 Nov 07 13:50:49 ct523c-2103 kernel:  ? __pte_offset_map_lock+0x8e/0x100
101129 Nov 07 13:50:49 ct523c-2103 kernel:  ? folio_add_new_anon_rmap+0x48/0xd0
101130 Nov 07 13:50:49 ct523c-2103 kernel:  ? set_ptes.constprop.0+0x1e/0xa0
101131 Nov 07 13:50:49 ct523c-2103 kernel:  ? do_anonymous_page+0x2b2/0x3d0
101132 Nov 07 13:50:49 ct523c-2103 kernel:  ? __handle_mm_fault+0xa0f/0xd10

Method in question is this:

static ssize_t ieee80211_if_read_sdata(
	struct ieee80211_sub_if_data *sdata,
	char __user *userbuf,
	size_t count, loff_t *ppos,
	ssize_t (*format)(const struct ieee80211_sub_if_data *sdata, char *, int))
{
	char buf[200];
	ssize_t ret = -EINVAL;

	wiphy_lock(sdata->local->hw.wiphy);
	ret = (*format)(sdata, buf, sizeof(buf));
	wiphy_unlock(sdata->local->hw.wiphy);


Other programs are blocked trying to get rtnl or wiphy locks, but I think they
are not the issue...  Full logs available if someone wants to see it...


Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

