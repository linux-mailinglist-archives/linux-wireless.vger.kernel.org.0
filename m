Return-Path: <linux-wireless+bounces-37925-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WVAaKr5tNWqLwAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37925-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:26:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C06A70BF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:26:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bN3PVrMn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37925-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37925-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E83E3308564D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F43BCD17;
	Fri, 19 Jun 2026 16:25:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9B3B38B4
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 16:25:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886308; cv=none; b=oQTuFVsmB+Nigatl/a3Cj6TmJnfmd4xpNKeA4lHYbUgNXtE2QcPrLndofuZRwbm6rnbNKIW6l176lphy2PSHpeWmKb9uvQKG7CeYTiTmfFziBZvl6EFYS1f/8a2/Mp0b8iSQ1Ak4tQGP9qGkP4C2xCmgiVht1nYCsKCM/eosZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886308; c=relaxed/simple;
	bh=e29pFoMNGM2eCKhbcw0gYxXcivO9ok0GrFpZ2NN3e6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JyEkKEVbZm3BmIHVkZbJNykW6boBOhGE2lPz4s66b4EntpIa/QBZnQOP2lOJ+a0oIF0k8XR1EWFvGlsvWs21S/jUvvRKqtu8s1kkH/e9qm4s4nJ5ezXx2JQSX6YOP84fiIpBTjhcjuNhderb2KP65/rNIrxNtkRgjzLgrCpGgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN3PVrMn; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf125989f2so14773865ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886306; x=1782491106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mmj6kZigFMWnee2TpRKcVLN0+A76a+20tMCpfB7bcE=;
        b=bN3PVrMnEvT7Sfihf7rPjSLmv3LTarIBgXL5sGevh75sKdHiPYmyS18uVvF0C4GrrJ
         +NaGiqHlcBICNkThh2nnqYUcWiXWpRcA6zFdFfjhcu33R4cvBvBGvyTE4dNqFKnrHMFi
         oePyknN+hFLHA3pwAEC/Pwlp4XLXjomtT7P7/jfXjx3j9YRoBYZii72V2lEpQkSEOL7Z
         d+R6E3LiLy2pfg34Uxfs3lFMNwThhiUJDRTXn1YVLSvDXNziDafyEQ6M7ztCvqDNjhO+
         9Ws1nDwiXnvxVfo3ZX6/dw9z1QUciqxN7pyRiS0ku8ApCyU2pClDQ2UIV/WHXzf59ZGE
         CrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886306; x=1782491106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mmj6kZigFMWnee2TpRKcVLN0+A76a+20tMCpfB7bcE=;
        b=MztcqDEY0lxBNczgi7mkoUTMfzKSrcK0w43pn6Nzf9p7KZK0L5nsluBVc/UIS9YSjb
         Z4y8q0ovOM463dxcgD5TaK+bwBrETFPwCRfLWRETw/ecg1z+WBeez1H2xupcCPz6yhQ0
         omN38wBwT24uSS5Ok0t0EycpJlNy+E2IMJs6Wbba4dgaCBTeFXri4vi2j+Q/XIc9mHzR
         cJJAJRT8oDYNM6NYbW4YvgUck3TG62aGV0eSTTT2cyAyaBf7Wn3h7P/TKywh9V7YJhMd
         n9b0dh346sT1NU8nbIUocrdrueQk4eejWOXFcZUvT+G9bZOo4DGhIP0if+o7Ni+d+S7k
         MsqA==
X-Gm-Message-State: AOJu0Yx4h/X5P7Jl4qkh9G/Z+UTy6/VfnIRzHFS8KxtWbFzZetOngohO
	epd8Hdzpjk5F0XM2UY/w5qOjdrfi+VjcuLeUnv2UuaFDyOGHoBCESq+P
X-Gm-Gg: AfdE7clw/pa8sQG3VCfl4AigmTu81AlTcPxdRy1q8mA0F+oWBKxiHNLyF6kUcwhHVYY
	CfoC0uyAB1TPuAxElyAS/LkJHG63Wq1Hw+Kt4kX6RKTLNfPPJZcsusTtWcnnMN/lIssD+rp5YD0
	tpdjYyHvGKV+hALIamEYLbGZw8TwN78AAKRVCgADAMzSc+lZ9gh6nu92UGOw+YyNl5s3mlBNObV
	lkHKNhJ7M+4CJwDz05+LhfcRwwzyk47+nn73cEzO6RBl6owsWUtYJeMppuFt2YNZsUH4wARx8Xs
	V6Quc0SGX7si9/67J82j9Ic3SugLT6IeOWi00PA3I3MQxr9eUAhyDhXeshOuvUyZ/aVDEMpRb1l
	4g4kP7VoT74HS2Kck5aWxxAlhsvoN4qGSDJm6tz0WAba4DdT5mE4C7C3+mxTF9BDy7egWT6TJoK
	UpHrmd72U=
X-Received: by 2002:a17:902:db0e:b0:2c6:8e82:977c with SMTP id d9443c01a7336-2c718cbdd0bmr46699935ad.15.1781886306460;
        Fri, 19 Jun 2026 09:25:06 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c720c0d84dsm28208235ad.75.2026.06.19.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:25:05 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] wifi: nl80211: serialize socket owner release with netdev teardown
Date: Sat, 20 Jun 2026 00:25:00 +0800
Message-Id: <20260619162500.3876325-1-zzzccc427@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37925-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 148C06A70BF

nl80211_netlink_notify() walks the cfg80211 wireless device list when a
NETLINK_GENERIC socket is released. If the socket owns a connection, the
notifier queues the embedded wdev->disconnect_wk work item.

NETDEV_GOING_DOWN tears the interface down and cancels disconnect_wk, and
NETDEV_UNREGISTER removes the wireless device from the cfg80211 list. There
is no ordering between those paths today, so the netlink notifier can pass
the conn_owner_nlportid check before teardown clears it, then queue
disconnect_wk after the NETDEV_GOING_DOWN cancel has already returned.
synchronize_net() only waits for the notifier to finish; it does not drain
the work that the notifier just queued.

The buggy scenario involves two paths, with each column showing the order
within that path:

NETLINK_URELEASE path:              netdev teardown path:
1. enter nl80211_netlink_notify()   1. run NETDEV_GOING_DOWN
2. match conn_owner_nlportid        2. clear connection owner state
3. get preempted before scheduling  3. cancel disconnect_wk
4. schedule disconnect_wk           4. unregister and free the netdev

Take RTNL while the notifier walks cfg80211 devices and schedules owner
cleanup work. Netdevice notifier delivery already runs under RTNL, so the
schedule and cancel are ordered: either the work is queued before
NETDEV_GOING_DOWN and the existing cancel drains it, or teardown runs first
and the notifier no longer queues work for that connection owner.

Validation reproduced this kernel report:
BUG: KASAN: use-after-free in cfg80211_autodisconnect_wk+0x338/0x3a0
Workqueue: events cfg80211_autodisconnect_wk [cfg80211]
Read of size 8
Call trace:
  dump_stack_lvl+0x66/0xa0
  print_report+0xce/0x630
  cfg80211_autodisconnect_wk+0x338/0x3a0
  srso_alias_return_thunk+0x5/0xfbef5
  __virt_addr_valid+0x224/0x430
  kasan_report+0xac/0xe0
  process_one_work+0x8d0/0x18f0 (kernel/workqueue.c:3212)
  lock_is_held_type+0x8f/0x100
  worker_thread+0x5ad/0xfd0
  __kthread_parkme+0xc6/0x200
  kthread+0x31e/0x410
  trace_hardirqs_on+0x1a/0x170
  ret_from_fork+0x576/0x810
  __switch_to+0x57e/0xe20
  __switch_to_asm+0x33/0x70
  ret_from_fork_asm+0x1a/0x30

Fixes: bd2522b16884 ("cfg80211: NL80211_ATTR_SOCKET_OWNER support for CMD_CONNECT")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/wireless/nl80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 53b4b3f76697..1e30673d1e79 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22920,6 +22920,11 @@ static int nl80211_netlink_notify(struct notifier_block * nb,
 	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
+	/*
+	 * Keep disconnect_wk scheduling ordered with NETDEV_GOING_DOWN's
+	 * cancel_work_sync() and NETDEV_UNREGISTER's wdev list removal.
+	 */
+	rtnl_lock();
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
@@ -22961,6 +22966,7 @@ static int nl80211_netlink_notify(struct notifier_block * nb,
 	}
 
 	rcu_read_unlock();
+	rtnl_unlock();
 
 	/*
 	 * It is possible that the user space process that is controlling the
-- 
2.43.0


