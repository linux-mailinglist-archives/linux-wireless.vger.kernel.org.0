Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23890667D8D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjALSLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 13:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbjALSK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 13:10:28 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFEC87577B
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 09:38:14 -0800 (PST)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673545092;
        bh=/UMxvA492mnAVerCKqjkAy7O1mOSbytYjsiAV22V8Wo=;
        h=From:To:Cc:Subject:Date;
        b=BQxGQmmHNaJoidzKO4PHK7ZU5l/A30Pw9BX2Qaw3QTOsCXJxbxc8dTr7LyTykcTtC
         nG76JgEkpf+kGFWFuQcJxeMQYgg9zS2dcmPvZMTvfH59wRAzqVwfyZ6rvdtWNTrOh+
         GqGlriSjHyH89W5q3vdeizNxYp8iLWjjJmjJT8w0=
To:     linux-wireless@vger.kernel.org
Cc:     Alexander Wetzel <alexander@wetzel-home.de>
Subject: BUG: KASAN: use-after-free in ieee80211_mgd_auth
Date:   Thu, 12 Jan 2023 18:38:08 +0100
Message-Id: <20230112173808.6205-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

My hostapd/hwsim test VM triggered now two times the KASAN warning at the end of
the Email. Now the system is used to verify "move everything to iTXQ" draft
patches and it *could* be a side effect from these...
But does not look likely. I only mess around with the tx path and not touching
the functions the KASLR report shows.
It also looks too frightening to simply ignore it, especially when this is
indeed an issue in the current code base.

The hostapd hwsim test I triggered the warning with is wext_pmf.
But it's nearly always working fine. I tried the test a few dozen times in a
row, always ok. Most full hostapd/hwsim test runs are also fine but two times
out of roughly 100 I hit it.

Here the relevant code with some remarks from me.

Any tips or ideas what may go on here?
///////////////////////////////////////////////////////////////////////////////
int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
		       struct cfg80211_auth_request *req)
{
	struct ieee80211_local *local = sdata->local;
	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
	struct ieee80211_mgd_auth_data *auth_data;
	u16 auth_alg;
	int err;
	bool cont_auth;

	/* prepare auth data structure */

	switch (req->auth_type) {
	case NL80211_AUTHTYPE_OPEN_SYSTEM:
		auth_alg = WLAN_AUTH_OPEN;
		break;
	case NL80211_AUTHTYPE_SHARED_KEY:
		if (fips_enabled)
			return -EOPNOTSUPP;
		auth_alg = WLAN_AUTH_SHARED_KEY;
		break;
	case NL80211_AUTHTYPE_FT:
		auth_alg = WLAN_AUTH_FT;
		break;
	case NL80211_AUTHTYPE_NETWORK_EAP:
		auth_alg = WLAN_AUTH_LEAP;
		break;
	case NL80211_AUTHTYPE_SAE:
		auth_alg = WLAN_AUTH_SAE;
		break;
	case NL80211_AUTHTYPE_FILS_SK:
		auth_alg = WLAN_AUTH_FILS_SK;
		break;
	case NL80211_AUTHTYPE_FILS_SK_PFS:
		auth_alg = WLAN_AUTH_FILS_SK_PFS;
		break;
	case NL80211_AUTHTYPE_FILS_PK:
		auth_alg = WLAN_AUTH_FILS_PK;
		break;
	default:
		return -EOPNOTSUPP;
	}

	if (ifmgd->assoc_data)
		return -EBUSY;

// auth_data is allocated. Only the code below can access it
// We also reserve space at the end which is probably intended for data[] later
	auth_data = kzalloc(sizeof(*auth_data) + req->auth_data_len +
			    req->ie_len, GFP_KERNEL);
	if (!auth_data)
		return -ENOMEM;

// OK: ap_addr is part of the struct and filled in. 
	memcpy(auth_data->ap_addr,
	       req->ap_mld_addr ?: req->bss->bssid,
	       ETH_ALEN);

// OK: bointer to bss and link_id is initialized
	auth_data->bss = req->bss;
	auth_data->link_id = req->link_id;

	if (req->auth_data_len >= 4) {
		if (req->auth_type == NL80211_AUTHTYPE_SAE) {
			__le16 *pos = (__le16 *) req->auth_data;

// OK: u16 int values read 
			auth_data->sae_trans = le16_to_cpu(pos[0]);
			auth_data->sae_status = le16_to_cpu(pos[1]);
		}

// Should be ok and use the extra space at the end.
		memcpy(auth_data->data, req->auth_data + 4,
		       req->auth_data_len - 4);
		auth_data->data_len += req->auth_data_len - 4;
	}

	/* Check if continuing authentication or trying to authenticate with the
	 * same BSS that we were in the process of authenticating with and avoid
	 * removal and re-addition of the STA entry in
	 * ieee80211_prep_connection().
	 */
	cont_auth = ifmgd->auth_data && req->bss == ifmgd->auth_data->bss &&
		    ifmgd->auth_data->link_id == req->link_id;

	if (req->ie && req->ie_len) {

// Looks also ok: We now use the space reserved for ie
		memcpy(&auth_data->data[auth_data->data_len],
		       req->ie, req->ie_len);
		auth_data->data_len += req->ie_len;
	}

	if (req->key && req->key_len) {

// OK, no pointers. Can write into that
		auth_data->key_len = req->key_len;
		auth_data->key_idx = req->key_idx;
		memcpy(auth_data->key, req->key, req->key_len);
	}

// The following line is the one KASAN complains about.
// But we line itself looks ok for me...
// We are using "fresh" allocated mem nobody but us knows (yet) about.
	auth_data->algorithm = auth_alg;

///////////////////////////////////////////////////////////////////////////////


Here the KASAN report:
(gdb) list *ieee80211_mgd_auth+0x59f
0x19fbcf is in ieee80211_mgd_auth (net/mac80211/mlme.c:6741).
6736                    auth_data->key_len = req->key_len;
6737                    auth_data->key_idx = req->key_idx;
6738                    memcpy(auth_data->key, req->key, req->key_len);
6739            }
6740
6741            auth_data->algorithm = auth_alg;
6742
6743            /* try to authenticate/probe */
6744
6745            if (ifmgd->auth_data) {


Jan 11 12:37:35 debian kernel: BUG: KASAN: use-after-free in ieee80211_mgd_auth+0x59f/0xc50 [mac80211]
Jan 11 12:37:35 debian kernel: Read of size 13 at addr ffff8881608bd4a0 by task wpa_supplicant/624
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: CPU: 6 PID: 624 Comm: wpa_supplicant Not tainted 6.2.0-rc2-wt+ #10
Jan 11 12:37:35 debian kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
Jan 11 12:37:35 debian kernel: Call Trace:
Jan 11 12:37:35 debian kernel:  <TASK>
Jan 11 12:37:35 debian kernel:  dump_stack_lvl+0x34/0x44
Jan 11 12:37:35 debian kernel:  print_address_description.constprop.0+0x86/0x1e3
Jan 11 12:37:35 debian kernel:  print_report+0x36/0x4f
Jan 11 12:37:35 debian kernel:  ? ieee80211_mgd_auth+0x59f/0xc50 [mac80211]
Jan 11 12:37:35 debian kernel:  kasan_report+0xae/0xe0
Jan 11 12:37:35 debian kernel:  ? ieee80211_mgd_auth+0x59f/0xc50 [mac80211]
Jan 11 12:37:35 debian kernel:  kasan_check_range+0x35/0x1b0
Jan 11 12:37:35 debian kernel:  memcpy+0x20/0x60
Jan 11 12:37:35 debian kernel:  ieee80211_mgd_auth+0x59f/0xc50 [mac80211]
Jan 11 12:37:35 debian kernel:  ? cfg80211_find_elem_match+0xd5/0x1c0 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? ieee80211_mlme_notify_scan_completed+0x230/0x230 [mac80211]
Jan 11 12:37:35 debian kernel:  ? is_bss.part.0+0xc8/0x110 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? _raw_spin_unlock_bh+0xa/0x20
Jan 11 12:37:35 debian kernel:  ? cfg80211_get_bss+0x3e5/0x810 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_mlme_auth+0x298/0x570 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_conn_do_work+0xbd1/0x1020 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? cfg80211_conn_scan+0xed0/0xed0 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? cfg80211_sme_get_conn_ies.isra.0+0x6c/0x430 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? queue_work_on+0x48/0x50
Jan 11 12:37:35 debian kernel:  ? cfg80211_get_conn_bss+0x285/0x3b0 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_sme_connect+0x51f/0xa90 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? cfg80211_conn_do_work+0x1020/0x1020 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_connect+0x986/0xda0 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? mutex_lock+0x9f/0xf0
Jan 11 12:37:35 debian kernel:  cfg80211_mgd_wext_connect+0x3dd/0x560 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_mgd_wext_siwessid+0x4b4/0x660 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? check_heap_object+0xee/0x3f0
Jan 11 12:37:35 debian kernel:  cfg80211_wext_siwessid+0xca/0x110 [cfg80211]
Jan 11 12:37:35 debian kernel:  ioctl_standard_iw_point+0x6e9/0xb10
Jan 11 12:37:35 debian kernel:  ? cfg80211_wext_giwessid+0x190/0x190 [cfg80211]
Jan 11 12:37:35 debian kernel:  ? wireless_process_ioctl.constprop.0+0x240/0x240
Jan 11 12:37:35 debian kernel:  ? mutex_unlock+0x80/0xd0
Jan 11 12:37:35 debian kernel:  ? __rtnl_unlock+0x5b/0xd0
Jan 11 12:37:35 debian kernel:  ? netdev_run_todo+0xd5/0x7c0
Jan 11 12:37:35 debian kernel:  ? __cond_resched+0x1c/0x90
Jan 11 12:37:35 debian kernel:  ? cfg80211_wext_giwessid+0x190/0x190 [cfg80211]
Jan 11 12:37:35 debian kernel:  ioctl_standard_call+0x123/0x170
Jan 11 12:37:35 debian kernel:  wext_handle_ioctl+0x198/0x1d0
Jan 11 12:37:35 debian kernel:  ? call_commit_handler+0x10/0x10
Jan 11 12:37:35 debian kernel:  ? finish_task_switch.isra.0+0x14a/0x710
Jan 11 12:37:35 debian kernel:  ? __switch_to+0x5cf/0xd60
Jan 11 12:37:35 debian kernel:  ? __schedule+0x6ca/0x1690
Jan 11 12:37:35 debian kernel:  sock_ioctl+0x219/0x510
Jan 11 12:37:35 debian kernel:  ? br_ioctl_call+0x90/0x90
Jan 11 12:37:35 debian kernel:  ? __fget_light+0x51/0x220
Jan 11 12:37:35 debian kernel:  ? kernel_fpu_begin_mask+0x1a0/0x1a0
Jan 11 12:37:35 debian kernel:  __x64_sys_ioctl+0x124/0x190
Jan 11 12:37:35 debian kernel:  do_syscall_64+0x35/0x80
Jan 11 12:37:35 debian kernel:  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
Jan 11 12:37:35 debian kernel: RIP: 0033:0x7fdc8aec85f7
Jan 11 12:37:35 debian kernel: Code: 00 00 00 48 8b 05 99 c8 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 0>
Jan 11 12:37:35 debian kernel: RSP: 002b:00007ffe59e83b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jan 11 12:37:35 debian kernel: RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fdc8aec85f7
Jan 11 12:37:35 debian kernel: RDX: 00007ffe59e83b40 RSI: 0000000000008b1a RDI: 0000000000000009
Jan 11 12:37:35 debian kernel: RBP: 000055c2cf6c1310 R08: 0000000000000000 R09: 0000000000000017
Jan 11 12:37:35 debian kernel: R10: 000055c2cd2e7df0 R11: 0000000000000246 R12: 000055c2cf6d893c
Jan 11 12:37:35 debian kernel: R13: 00007ffe59e83b40 R14: 0000000000000001 R15: 000055c2cf6c1328
Jan 11 12:37:35 debian kernel:  </TASK>
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: Allocated by task 624:
Jan 11 12:37:35 debian kernel:  kasan_save_stack+0x1e/0x40
Jan 11 12:37:35 debian kernel:  kasan_set_track+0x21/0x30
Jan 11 12:37:35 debian kernel:  __kasan_kmalloc+0x7a/0x90
Jan 11 12:37:35 debian kernel:  __kmalloc_node_track_caller+0x60/0x140
Jan 11 12:37:35 debian kernel:  kmemdup+0x1f/0x40
Jan 11 12:37:35 debian kernel:  cfg80211_mgd_wext_connect+0x2bb/0x560 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_mgd_wext_siwessid+0x4b4/0x660 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_wext_siwessid+0xca/0x110 [cfg80211]
Jan 11 12:37:35 debian kernel:  ioctl_standard_iw_point+0x6e9/0xb10
Jan 11 12:37:35 debian kernel:  ioctl_standard_call+0x123/0x170
Jan 11 12:37:35 debian kernel:  wext_handle_ioctl+0x198/0x1d0
Jan 11 12:37:35 debian kernel:  sock_ioctl+0x219/0x510
Jan 11 12:37:35 debian kernel:  __x64_sys_ioctl+0x124/0x190
Jan 11 12:37:35 debian kernel:  do_syscall_64+0x35/0x80
Jan 11 12:37:35 debian kernel:  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: Freed by task 40321:
Jan 11 12:37:35 debian kernel:  kasan_save_stack+0x1e/0x40
Jan 11 12:37:35 debian kernel:  kasan_set_track+0x21/0x30
Jan 11 12:37:35 debian kernel:  kasan_save_free_info+0x2a/0x40
Jan 11 12:37:35 debian kernel:  __kasan_slab_free+0x106/0x190
Jan 11 12:37:35 debian kernel:  __kmem_cache_free+0x159/0x290
Jan 11 12:37:35 debian kernel:  cfg80211_upload_connect_keys+0x1e4/0x700 [cfg80211]
Jan 11 12:37:35 debian kernel:  __cfg80211_connect_result+0xfd2/0x18d0 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_rx_assoc_resp+0x606/0x1160 [cfg80211]
Jan 11 12:37:35 debian kernel:  ieee80211_rx_mgmt_assoc_resp.cold+0x784/0xea6 [mac80211]
Jan 11 12:37:35 debian kernel:  ieee80211_sta_rx_queued_mgmt+0x358/0xed0 [mac80211]
Jan 11 12:37:35 debian kernel:  ieee80211_iface_work+0x19b/0x410 [mac80211]
Jan 11 12:37:35 debian kernel:  process_one_work+0x684/0x1040
Jan 11 12:37:35 debian kernel:  worker_thread+0xd7/0xc30
Jan 11 12:37:35 debian kernel:  kthread+0x28f/0x330
Jan 11 12:37:35 debian kernel:  ret_from_fork+0x1f/0x30
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: Last potentially related work creation:
Jan 11 12:37:35 debian kernel:  kasan_save_stack+0x1e/0x40
Jan 11 12:37:35 debian kernel:  __kasan_record_aux_stack+0x95/0xa0
Jan 11 12:37:35 debian kernel:  kvfree_call_rcu+0x30/0x600
Jan 11 12:37:35 debian kernel:  __ipv6_dev_mc_dec+0x2f4/0x440
Jan 11 12:37:35 debian kernel:  __ipv6_ifa_notify+0x4e3/0x910
Jan 11 12:37:35 debian kernel:  addrconf_ifdown.isra.0+0x98f/0x1370
Jan 11 12:37:35 debian kernel:  addrconf_notify+0x1fc/0x1000
Jan 11 12:37:35 debian kernel:  raw_notifier_call_chain+0x8b/0xd0
Jan 11 12:37:35 debian kernel:  __dev_notify_flags+0x15b/0x240
Jan 11 12:37:35 debian kernel:  dev_change_flags+0xfa/0x170
Jan 11 12:37:35 debian kernel:  devinet_ioctl+0xf75/0x1650
Jan 11 12:37:35 debian kernel:  inet_ioctl+0x1ad/0x290
Jan 11 12:37:35 debian kernel:  sock_do_ioctl+0xce/0x1c0
Jan 11 12:37:35 debian kernel:  sock_ioctl+0x27b/0x510
Jan 11 12:37:35 debian kernel:  __x64_sys_ioctl+0x124/0x190
Jan 11 12:37:35 debian kernel:  do_syscall_64+0x35/0x80
Jan 11 12:37:35 debian kernel:  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: Second to last potentially related work creation:
Jan 11 12:37:35 debian kernel:  kasan_save_stack+0x1e/0x40
Jan 11 12:37:35 debian kernel:  __kasan_record_aux_stack+0x95/0xa0
Jan 11 12:37:35 debian kernel:  kvfree_call_rcu+0x30/0x600
Jan 11 12:37:35 debian kernel:  ieee80211_stop_ap+0x47f/0xd30 [mac80211]
Jan 11 12:37:35 debian kernel:  ___cfg80211_stop_ap+0x142/0x8d0 [cfg80211]
Jan 11 12:37:35 debian kernel:  cfg80211_stop_ap+0x5a/0x80 [cfg80211]
Jan 11 12:37:35 debian kernel:  genl_family_rcv_msg_doit.isra.0+0x1be/0x290
Jan 11 12:37:35 debian kernel:  genl_family_rcv_msg+0x335/0x530
Jan 11 12:37:35 debian kernel:  genl_rcv_msg+0x9f/0x130
Jan 11 12:37:35 debian kernel:  netlink_rcv_skb+0x12b/0x390
Jan 11 12:37:35 debian kernel:  genl_rcv+0x24/0x40
Jan 11 12:37:35 debian kernel:  netlink_unicast+0x4c5/0x7a0
Jan 11 12:37:35 debian kernel:  netlink_sendmsg+0x788/0xc30
Jan 11 12:37:35 debian kernel:  sock_sendmsg+0xb2/0xe0
Jan 11 12:37:35 debian kernel:  ____sys_sendmsg+0x5e9/0x830
Jan 11 12:37:35 debian kernel:  ___sys_sendmsg+0xe0/0x160
Jan 11 12:37:35 debian kernel:  __sys_sendmsg+0xc8/0x160
Jan 11 12:37:35 debian kernel:  do_syscall_64+0x35/0x80
Jan 11 12:37:35 debian kernel:  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: The buggy address belongs to the object at ffff8881608bd400
                                which belongs to the cache kmalloc-256 of size 256
Jan 11 12:37:35 debian kernel: The buggy address is located 160 bytes inside of
                                256-byte region [ffff8881608bd400, ffff8881608bd500)
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: The buggy address belongs to the physical page:
Jan 11 12:37:35 debian kernel: page:00000000171b2280 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8881608bee00 pfn:0x1608bc
Jan 11 12:37:35 debian kernel: head:00000000171b2280 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
Jan 11 12:37:35 debian kernel: anon flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
Jan 11 12:37:35 debian kernel: raw: 0017ffffc0010200 ffff88810c842b40 0000000000000000 dead000000000001
Jan 11 12:37:35 debian kernel: raw: ffff8881608bee00 000000008020001f 00000001ffffffff 0000000000000000
Jan 11 12:37:35 debian kernel: page dumped because: kasan: bad access detected
Jan 11 12:37:35 debian kernel: 
Jan 11 12:37:35 debian kernel: Memory state around the buggy address:
Jan 11 12:37:35 debian kernel:  ffff8881608bd380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Jan 11 12:37:35 debian kernel:  ffff8881608bd400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jan 11 12:37:35 debian kernel: >ffff8881608bd480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jan 11 12:37:35 debian kernel:                                ^
Jan 11 12:37:35 debian kernel:  ffff8881608bd500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Jan 11 12:37:35 debian kernel:  ffff8881608bd580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Jan 11 12:37:35 debian kernel: ==================================================================
Jan 11 12:37:35 debian kernel: Disabling lock debugging due to kernel taint

