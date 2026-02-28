Return-Path: <linux-wireless+bounces-32311-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO8IEH35omn18QQAu9opvQ
	(envelope-from <linux-wireless+bounces-32311-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 15:19:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B16DD1C384D
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 15:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45F130CD938
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5D413234;
	Sat, 28 Feb 2026 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QwXVwyWa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47A310762
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772288333; cv=none; b=KvO7ylNBL6aZnnccUylwNug0/O85rDcBB3NvQf1pJG8mveQzaLx8PkK+8Dkk/hbJ5VC3ZZhvrXcjCanieqD9A6WD7w2L/HPFB8MBxiSpd5vQnljfn0fRVL5ywcJPYZMnEkoJ5ir8wTbRuHGxzD9XCxUp5sSDLGxMgrBLgC4ChcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772288333; c=relaxed/simple;
	bh=+E8RrQo6tNwi1jRwxIqM6xhuLOlyz3080xNfTxDdR14=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YIONGEIwuuaCxUYnsA0xiHWGFHxkUmCc6uR09zDvoJKKBegfFHZV+6lcHltUkmEiZ7eexLK+/HC54Qn0ZBllcZoWfjxlBif6WrOUD1CLmDnIu+dZ2SkZ1in2l5wYRqO4CaJ6S9M2sJ32COBidKFUJOw8bJLPa/LPJGU3csoHUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QwXVwyWa; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E681EB8007A
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 14:18:43 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 77F3013C2B0
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 06:18:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 77F3013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772288321;
	bh=+E8RrQo6tNwi1jRwxIqM6xhuLOlyz3080xNfTxDdR14=;
	h=Date:To:From:Subject:From;
	b=QwXVwyWauXQcr0DUGfSt5CVvaIDHmqlcWVqcYJDxzY6Jr+XjSAXRElYfUYCaRb93B
	 zaToAPesXxIUC8mGH2SMHnBH3FgwmyZT7bFZpMWNQn6Nx1PdGCjR1oREgy21etMWwk
	 61SjVS6yE91uaGh99BvlNt1AdbW0RWNUhJyqW/tk=
Message-ID: <894eeced-2ae1-4b11-929e-510efe0b3205@candelatech.com>
Date: Sat, 28 Feb 2026 06:18:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: 6.18.14+: use-after-free in debugfs, kasan splat
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772288324-KfW6mkALuWhx
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772288324;KfW6mkALuWhx;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32311-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B16DD1C384D
X-Rspamd-Action: no action

Hello,

I've been hunting this crash for a while, finally got it to trigger in
a KASAN enabled kernel.

This is with a kernel with local patches, including debugging to try to
catch this problem in earlier attempts.

gdb says [  767.773845]  simple_recursive_removal+0x1e/0x50 points to the
WARN_ON_ONCE line I had added, but probably it is dget(dentry) with dentry being already
freed.

static void __simple_recursive_removal(struct dentry *dentry,
                               void (*callback)(struct dentry *),
			      bool locked)
{
	struct dentry *this = dget(dentry);

	if (WARN_ON_ONCE((unsigned long)(this) < 8000)) {
		pr_err("simple-recursive-removal, bad 'this': %px\n",
		       this);
		return;
	}

I am guessing this is some tangle related to how vif.debugfs_dir and link
debugfs_dir sometimes are the same pointer and sometimes not.  I'm going to
try to make that code more safe somehow... This test system is using MLO (with be200 radios).

If someone has ideas to try or is working on the same problem I'd be happy
to compare notes.


[  767.745519] wlan8: mgd_auth, prep connection failed: -22
[  767.745545] wlan8: mgd_auth failed, err: -22
[  767.747684] wlan8: prep-connection, no-have-sta, valid-links: 0x4  active-links: 0x4
[  767.754165] wlan8: mgd_auth, prep connection failed: -22
[  767.754183] wlan8: mgd_auth failed, err: -22
[  767.756145] wlan8: ieee80211_vif_set_links: new_links=0x0; dormant_links=0x0
[  767.756159] ==================================================================
[  767.762099] BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2c/0x40
[  767.767435] Read of size 1 at addr ffff888127660e08 by task wpa_supplicant/23758
[  767.773544]
[  767.773759] CPU: 2 UID: 0 PID: 23758 Comm: wpa_supplicant Kdump: loaded Tainted: G        W           6.18.14+ #23 PREEMPT(full)
[  767.773766] Tainted: [W]=WARN
[  767.773767] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[  767.773770] Call Trace:
[  767.773772]  <TASK>
[  767.773774]  dump_stack_lvl+0x73/0xa0
[  767.773780]  print_report+0xce/0x620
[  767.773786]  ? __virt_addr_valid+0x205/0x3f0
[  767.773791]  ? _raw_spin_lock+0x2c/0x40
[  767.773795]  kasan_report+0xc6/0xf0
[  767.773801]  ? _raw_spin_lock+0x2c/0x40
[  767.773806]  ? _raw_spin_lock+0x2c/0x40
[  767.773809]  __kasan_check_byte+0x2e/0x40
[  767.773814]  lock_acquire+0xdc/0x2e0
[  767.773819]  ? simple_pin_fs+0x85/0x150
[  767.773823]  ? lock_release+0xce/0x290
[  767.773827]  ? debugfs_init_fs_context+0x110/0x110
[  767.773833]  _raw_spin_lock+0x2c/0x40
[  767.773837]  ? lockref_get+0x9/0x40
[  767.773841]  lockref_get+0x9/0x40
[  767.773845]  simple_recursive_removal+0x1e/0x50
[  767.773849]  debugfs_remove+0x49/0x80
[  767.773854]  ieee80211_vif_update_links+0x9df/0x1500 [mac80211]
[  767.773980]  ? irq_work_queue+0x69/0xa0
[  767.773986]  ? ieee80211_apvlan_link_clear+0x60/0x60 [mac80211]
[  767.774099]  ? vprintk_emit+0x2e4/0x3e0
[  767.774103]  ? wake_up_klogd_work_func+0x80/0x80
[  767.774110]  ? _printk+0xb2/0xe0
[  767.774113]  ? printk_get_console_flush_type+0x2d0/0x2d0
[  767.774127]  ieee80211_vif_set_links+0xa8/0x130 [mac80211]
[  767.774241]  ? ieee80211_find_best_sta_link+0x430/0x430 [mac80211]
[  767.774356]  ? lock_is_held_type+0xa5/0x110
[  767.774361]  ? ieee80211_send_teardown_neg_ttlm+0x2e0/0x2e0 [mac80211]
[  767.774473]  ieee80211_prep_connection+0xe3/0x1550 [mac80211]
[  767.774586]  ieee80211_mgd_auth+0xeba/0x1960 [mac80211]
[  767.774698]  ? ieee80211_mlme_notify_scan_completed+0x300/0x300 [mac80211]
[  767.774809]  ? mark_held_locks+0x49/0x70
[  767.774815]  ? __cfg80211_get_bss+0x429/0xa50 [cfg80211]
[  767.774923]  ? __cfg80211_get_bss+0x429/0xa50 [cfg80211]
[  767.775025]  ? __cfg80211_get_bss+0x46f/0xa50 [cfg80211]
[  767.775126]  ? lock_is_held_type+0xa5/0x110
[  767.775132]  cfg80211_mlme_auth+0x458/0x7f0 [cfg80211]
[  767.775238]  nl80211_authenticate+0xa90/0x1180 [cfg80211]
[  767.775342]  ? __rtnl_unlock+0x65/0xf0
[  767.775348]  ? nl80211_parse_key+0xe60/0xe60 [cfg80211]
[  767.775452]  ? __kasan_kmalloc+0x83/0x90
[  767.775461]  ? nl80211_pre_doit+0x3f3/0x750 [cfg80211]
[  767.775564]  genl_family_rcv_msg_doit+0x1cb/0x2a0
[  767.775570]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x230/0x230
[  767.775579]  ? security_capable+0x2d/0x80
[  767.775586]  genl_rcv_msg+0x3f7/0x6b0
[  767.775590]  ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
[  767.775595]  ? nl80211_get_reg_dump+0x450/0x450 [cfg80211]
[  767.775697]  ? nl80211_parse_key+0xe60/0xe60 [cfg80211]
[  767.775798]  ? nlmsg_trim+0x60/0x60 [cfg80211]
[  767.775902]  ? __lock_acquire+0x432/0x23b0
[  767.775908]  netlink_rcv_skb+0x125/0x380
[  767.775911]  ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
[  767.775915]  ? netlink_ack+0xda0/0xda0
[  767.775922]  ? netlink_deliver_tap+0x14f/0xb60
[  767.775927]  genl_rcv+0x24/0x40
[  767.775930]  netlink_unicast+0x5dd/0x9d0
[  767.775935]  ? netlink_attachskb+0x9b0/0x9b0
[  767.775939]  ? __virt_addr_valid+0x205/0x3f0
[  767.775943]  ? __check_object_size+0x489/0x640
[  767.775948]  netlink_sendmsg+0x749/0xc00
[  767.775953]  ? netlink_unicast+0x9d0/0x9d0
[  767.775955]  ? find_held_lock+0x2b/0x80
[  767.775960]  ? lock_release+0xce/0x290
[  767.775965]  ? netlink_unicast+0x9d0/0x9d0
[  767.775968]  __sock_sendmsg+0xc1/0x150
[  767.775974]  ____sys_sendmsg+0x5f4/0x8f0
[  767.775979]  ? kernel_sendmsg+0x30/0x30
[  767.775983]  ? __copy_msghdr+0x400/0x400
[  767.775990]  ___sys_sendmsg+0xed/0x170
[  767.775995]  ? copy_msghdr_from_user+0x110/0x110
[  767.775998]  ? __might_fault+0x113/0x170
[  767.776004]  ? _copy_from_user+0x4f/0x90
[  767.776008]  ? ___sys_sendmsg+0x170/0x170
[  767.776011]  ? netlink_setsockopt+0x32d/0x650
[  767.776015]  ? lock_release+0xce/0x290
[  767.776019]  ? kfree+0x2ae/0x580
[  767.776025]  ? do_sock_setsockopt+0x1c2/0x3b0
[  767.776029]  ? do_sock_setsockopt+0x1c2/0x3b0
[  767.776033]  ? move_addr_to_user+0x150/0x150
[  767.776039]  __sys_sendmsg+0x107/0x1a0
[  767.776042]  ? __sys_sendmsg_sock+0x20/0x20
[  767.776052]  do_syscall_64+0x69/0x1210
[  767.776057]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  767.776061] RIP: 0033:0x7f3fcd3f4e24
[  767.776064] Code: 15 f1 ff 0b 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d 45 85 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
[  767.776068] RSP: 002b:00007ffeea2fac78 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  767.776073] RAX: ffffffffffffffda RBX: 000000001a1e8400 RCX: 00007f3fcd3f4e24
[  767.776076] RDX: 0000000000000000 RSI: 00007ffeea2facd0 RDI: 0000000000000007
[  767.776078] RBP: 000000001a25e740 R08: 0000000000000004 R09: 000000000000000d
[  767.776080] R10: 00007ffeea2fad9c R11: 0000000000000202 R12: 000000001a1e8310
[  767.776082] R13: 00007ffeea2facd0 R14: 00007f3fcd5f0000 R15: 00000000007e3d78
[  767.776090]  </TASK>
[  767.776091]
[  768.112216] Allocated by task 25666:
[  768.114508]  kasan_save_stack+0x1c/0x40
[  768.114517]  kasan_save_track+0x10/0x30
[  768.114522]  __kasan_slab_alloc+0x62/0x70
[  768.114527]  kmem_cache_alloc_lru_noprof+0x1ce/0x6d0
[  768.114533]  __d_alloc+0x31/0xa30
[  768.114539]  d_alloc_parallel+0xfb/0x1150
[  768.114543]  lookup_open.isra.0+0x53c/0x1620
[  768.114547]  path_openat+0xf1c/0x2c10
[  768.114551]  do_filp_open+0x1d3/0x420
[  768.114556]  do_sys_openat2+0xd3/0x160
[  768.114560]  __x64_sys_openat+0x134/0x1d0
[  768.114565]  do_syscall_64+0x69/0x1210
[  768.114570]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  768.114575]
[  768.114781] Freed by task 25666:
[  768.116725]  kasan_save_stack+0x1c/0x40
[  768.116730]  kasan_save_track+0x10/0x30
[  768.116735]  __kasan_save_free_info+0x37/0x50
[  768.116739]  __kasan_slab_free+0x3b/0x60
[  768.116744]  kmem_cache_free+0x164/0x680
[  768.116748]  rcu_core+0x7d0/0x1710
[  768.116753]  handle_softirqs+0x1c6/0x810
[  768.116758]  __irq_exit_rcu+0xcc/0x100
[  768.116763]  irq_exit_rcu+0xa/0x20
[  768.116769]  sysvec_apic_timer_interrupt+0x6e/0x90
[  768.116774]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  768.116778]
[  768.116984] Last potentially related work creation:
[  768.120575]  kasan_save_stack+0x1c/0x40
[  768.120580]  kasan_record_aux_stack+0x88/0x90
[  768.120584]  __call_rcu_common.constprop.0+0x76/0x790
[  768.120589]  __dentry_kill+0x3a7/0x4f0
[  768.120593]  dput.part.0+0x31e/0x670
[  768.120597]  lookup_open.isra.0+0x4a4/0x1620
[  768.120601]  path_openat+0xf1c/0x2c10
[  768.120605]  do_filp_open+0x1d3/0x420
[  768.120609]  do_sys_openat2+0xd3/0x160
[  768.120613]  __x64_sys_openat+0x134/0x1d0
[  768.120618]  do_syscall_64+0x69/0x1210
[  768.120623]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  768.120627]
[  768.120833] The buggy address belongs to the object at ffff888127660d38
  which belongs to the cache dentry of size 312
[  768.130322] The buggy address is located 208 bytes inside of
  freed 312-byte region [ffff888127660d38, ffff888127660e70)
[  768.139985]
[  768.140194] The buggy address belongs to the physical page:
[  768.144479] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x127660
[  768.144485] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  768.144489] flags: 0x5fff8000000040(head|node=0|zone=2|lastcpupid=0x3fff)
[  768.144495] page_type: f5(slab)
[  768.144500] raw: 005fff8000000040 ffff8881202b9cc0 ffffea0005737400 dead000000000002
[  768.144504] raw: 0000000000000000 0000000000150015 00000000f5000000 0000000000000000
[  768.144509] head: 005fff8000000040 ffff8881202b9cc0 ffffea0005737400 dead000000000002
[  768.144513] head: 0000000000000000 0000000000150015 00000000f5000000 0000000000000000
[  768.144517] head: 005fff8000000001 ffffea00049d9801 00000000ffffffff 00000000ffffffff
[  768.144521] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000000
[  768.144524] page dumped because: kasan: bad access detected
[  768.144527]
[  768.144733] Memory state around the buggy address:
[  768.148240]  ffff888127660d00: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
[  768.154179]  ffff888127660d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  768.160116] >ffff888127660e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
[  768.166051]                       ^
[  768.168257]  ffff888127660e80: fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00
[  768.174190]  ffff888127660f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  768.180125] ==================================================================


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

