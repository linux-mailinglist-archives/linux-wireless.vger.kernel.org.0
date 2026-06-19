Return-Path: <linux-wireless+bounces-37924-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9qIMH2JtNWpkwAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37924-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:25:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C46A70A0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bsCwgCl8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37924-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37924-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A99E30214F5
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075583BB9EF;
	Fri, 19 Jun 2026 16:24:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F93BCD00
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 16:24:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886268; cv=none; b=b0mf/iWWyPZ9GDnisDA6/JI91nzLBD4lGfM/HthVdNF7GIfDaSCPu8utv5il9KtVF6QXRuQc5OQVcD40D4CfMuwvH+xbHVM7xe2fUXhIkmnlrRLQe8Z7xL1LSbohxW4VmIVEGMfQ/kemXZnQtl68AK1rhWh2G1vzi2EMnOVRRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886268; c=relaxed/simple;
	bh=GpS9N+m0FSGQ4dGI8MM9zQBrTwmN4En5EbXmu4cuLVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5xIkBoi25WnDRDxLGVJfAx/BiHafw5gg6C9eBQRICtC7AdOxfvUKjCfWAXlNCWzRTHfv/Bmd6zTgzfDc+cOzBblR3hQjMcz68lb6ed4qw62Ry7xbxlehUe9TsJFzRWKj+lAeZTrhC9CLGrAb+on2NBebpvElnMpwGmtcdFACpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsCwgCl8; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842848fd613so2037799b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886267; x=1782491067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2CbQ+kpNB+e+HTZk2sFB26eYNVwKtCy10gGIJQoT2U=;
        b=bsCwgCl8/lRh+k3b72Z49YG7u/f06eJs/LxmmJJBEhHyR6+8W+5WFQilBmiZVmgY7A
         hI7yZjB6IV7aA0geTgk0uxRlsWCH9X9rs6X+RNR4L9vQBEekBb5UUADxQhWcMlaV7RxT
         PINKl3MxRCa6Xf2/ofKyo55oba0QV/yJP9nBMwUFaC+t67fZKIpa5Fa/ImL5nX2CiVms
         0DG1ubQWeaEGSoPtl4rW8jXHFXM4fPm9GpKTV+ADWE8AZmiDry5KGSMfUJvwb661J2GA
         hhNvyp+i0GTplft5KtvR/xVxG2CKajrFEAafDEYk0hC7wKYP3tsfYr80VU3m065Wu7Tz
         bqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886267; x=1782491067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2CbQ+kpNB+e+HTZk2sFB26eYNVwKtCy10gGIJQoT2U=;
        b=kq1GKkIP+Qh5pOOJY1EzQZAfY0tO6hQGgZFwjfrnASnx05H3vTJEGUb+xOlRP7f9Zq
         +T3HDVKHUScLcLAkyp0Eydk0VLzjFcy7nBp0EhwBR7vteG0AY5zYXnMVN9uzFvxnAu9Y
         0OJ04hdkwgTMQZf0rWay0kbnoSFEITT+KY0Lpr0odmxNxc0g8pUbYMstAK17bkAk3zoS
         isytctWHlEAfadJe3HjeXqtwtqqPCpxsQZNHmUZWpBdqTi2SY4CbRXafim/XJ5tIhUm4
         NL3lZcJntBrr8xsXZzQiZ9GcZYZixtCY5VfV87y9oyZGgq5r6k4UCyt9MmCb7ZIVsweh
         N0pg==
X-Gm-Message-State: AOJu0YzuVIeSY5lr9ultwhcIhD+R25kvWPLXMteC8J3JCjF8tNRuw7Ta
	LThYDGPQdnLBV8hwqfIQn2dD+YXrTF+YEJhVhUvQ2yBHUWDf39TA1rLk
X-Gm-Gg: AfdE7cm47Lw5+kmyaCK6UbuAWaoqCvsSiKjnQWHI8Tt8zlIMfM17dgCHKWwdnidYSx/
	Q2cddUja7dm4hAEhla0z+ioj6uTN3l/N2F2iGKr39hxCakroHBul8PPnDP/+ToLpMyM+dEp0ned
	/47VOLAlyR6ZeGQLOLSO6L0A4dg8wUEf0nqvOYuZAZ9EPCRyTpCMBEBCbQDFPu+qIMGh7Lz4ncF
	AuXo4QtxYvnC/z94YVlYkb4WnG1z0WiaE9ywwmWO+BvgbtER7juM0CjyQZqXb4ymvgbrTpmjNGy
	rdobCdKO5k8++oZy2B+ud6UE219PJXW0lGheqp7vbJJvLjFY9VbOMHmxlW2yD0i2o58mZMa+m7Z
	vBNT4aLIR597dz55P90Xay5jwkcMW76IGPptVUr5sEahxyocxYFePB3KVAajy+ggXSxXVf3UoCL
	+WUG1KdOo=
X-Received: by 2002:a05:6a00:bd01:b0:842:7992:bdd3 with SMTP id d2e1a72fcca58-845624574d5mr394307b3a.4.1781886266727;
        Fri, 19 Jun 2026 09:24:26 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455366ec6bsm2837628b3a.16.2026.06.19.09.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:24:26 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] wifi: mac80211_hwsim: remove radios from rhashtable before freeing
Date: Sat, 20 Jun 2026 00:24:19 +0800
Message-Id: <20260619162419.3874564-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-37924-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF4C46A70A0

mac80211_hwsim_new_radio() publishes each registered radio on the
hwsim_radios list and in hwsim_radios_rht. The generic-netlink and
virtio command paths use the rhashtable to find radios by address.

Most radio removal paths remove the hash entry while holding
hwsim_radio_lock before unregistering and freeing the radio. However,
mac80211_hwsim_free() only removes the list entry. During init error
unwinding after hwsim netlink and virtio registration, this can leave a
freed radio reachable from hwsim_radios_rht until the callback surfaces
are unpublished and the rhashtable is destroyed.

The buggy scenario involves two paths, with each column showing the order
within that path:

init error unwind path:              hwsim command path:
1. create and hash a radio           1. receive a command by address
2. hit a later init failure          2. look up hwsim_radios_rht
3. call mac80211_hwsim_free()        3. get the stale radio pointer
4. free the radio                    4. dereference the freed radio
5. unregister netlink and virtio

Remove each radio from hwsim_radios_rht in mac80211_hwsim_free(),
matching the other radio removal paths, before releasing the lock and
freeing the hw object.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in memcmp+0x1ab/0x1d0

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? memcmp+0x1ab/0x1d0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x224/0x430
 ? memcmp+0x1ab/0x1d0
 kasan_report+0xac/0xe0
 ? memcmp+0x1ab/0x1d0
 memcmp+0x1ab/0x1d0
 get_hwsim_data_ref_from_addr+0x15b/0x4d0 [mac80211_hwsim]
 hwsim_cloned_frame_received_nl+0x1ff/0xce0 [mac80211_hwsim]
 ? __pfx_hwsim_cloned_frame_received_nl+0x10/0x10 [mac80211_hwsim]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kasan_save_track+0x14/0x30
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __kasan_kmalloc+0xaa/0xb0
 ? __nla_parse+0x24/0x30
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? genl_family_rcv_msg_attrs_parse.isra.0+0x17f/0x290
 genl_family_rcv_msg_doit+0x1e5/0x2c0
 ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kasan_save_stack+0x42/0x60
 ? kasan_save_stack+0x33/0x60
 ? kasan_save_track+0x14/0x30
 genl_rcv_msg+0x432/0x6f0
 ? __pfx_genl_rcv_msg+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_hwsim_cloned_frame_received_nl+0x10/0x10 [mac80211_hwsim]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __lock_acquire+0x466/0x2260
 netlink_rcv_skb+0x124/0x350
 ? __pfx_genl_rcv_msg+0x10/0x10
 ? __pfx_netlink_rcv_skb+0x10/0x10
 ? lock_acquire+0x187/0x300
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? netlink_deliver_tap+0x150/0xac0
 genl_rcv+0x28/0x40
 netlink_unicast+0x47c/0x790
 ? __pfx_netlink_unicast+0x10/0x10
 netlink_sendmsg+0x767/0xc30
 ? __pfx_netlink_sendmsg+0x10/0x10
 ? lock_release+0xc8/0x290
 __sys_sendto+0x34f/0x3a0
 ? __pfx___sys_sendto+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0xea/0x1a0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __x64_sys_poll+0x181/0x3e0
 ? __pfx___x64_sys_poll+0x10/0x10
 __x64_sys_sendto+0xe0/0x1c0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? trace_hardirqs_on+0x1a/0x170
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Allocated by task 444:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 __kmalloc_noprof+0x292/0x770
 p9_fcall_init+0xe5/0x400
 p9_tag_alloc+0x1b8/0x700
 p9_client_prepare_req+0x107/0x3e0
 p9_client_zc_rpc.constprop.0+0xf1/0x860
 p9_client_write+0x36d/0x780
 v9fs_issue_write+0xdd/0x170
 netfs_unbuffered_write+0x339/0x2680
 netfs_unbuffered_write_iter_locked+0x6c4/0x960
 netfs_unbuffered_write_iter+0x2d5/0x540
 vfs_write+0x5fb/0x1230
 ksys_write+0xf9/0x1d0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 444:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60

Fixes: c6509cc3b3e8 ("mac80211_hwsim: add hashtable with mac address keys for faster lookup")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..8e83ebdf4563 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -6274,6 +6274,9 @@ static void mac80211_hwsim_free(void)
 						struct mac80211_hwsim_data,
 						list))) {
 		list_del(&data->list);
+		rhashtable_remove_fast(&hwsim_radios_rht, &data->rht,
+				       hwsim_rht_params);
+		hwsim_radios_generation++;
 		spin_unlock_bh(&hwsim_radio_lock);
 		mac80211_hwsim_del_radio(data, wiphy_name(data->hw->wiphy),
 					 NULL);
-- 
2.43.0


