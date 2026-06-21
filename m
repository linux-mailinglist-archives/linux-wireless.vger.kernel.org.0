Return-Path: <linux-wireless+bounces-37945-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QI1THnywN2p4PwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37945-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 11:35:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF46F6AA817
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 11:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b="l8C/SGoe";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37945-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37945-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E15301038F
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588525A354;
	Sun, 21 Jun 2026 09:35:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D21B142D
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 09:35:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782034551; cv=none; b=qcxl9VsZQ9QQ9g7xKqYKEADsFlGvDlwoYLucQGPUfz/ci7WaS1M/+ciLJF/sh9gXZx3ILjQBtJuYWarmc/lenrezqG7nnKQr556i3CHflHsCGKV+uMUn3dWQIeAoXw6iJSgHemSTnsrhGvFtCiXceViIIGOG+q9uyBQjs1PhPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782034551; c=relaxed/simple;
	bh=kxlJ27RuML17of6OkCir3HZ8g90/kbn8TJZLwT7Ch/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRab6RlGrQ+iutCa2H7dTp9uRqPL7Wwr8D/sqjeY8EHcwrF9tRS6ho1U6gkmzUO7ZiiuuuRE+RtdoxfZuGH/RbP+P1tl2T4k1ATtbTKrfqsyfZkAmZz/JJYuS+piKhlFoClb6u3aWsPDtUynAcuLWUKHK9mO50Qb/g4jPv+i9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=l8C/SGoe; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3067366b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782034549; x=1782639349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5vc/NdjXesB9jkRNJ8XJ8hP5JNiEf0N2brRizf1Yl0=;
        b=l8C/SGoelhR7+tlDRjYtCQB5qOIBZO6frI/mWpuMWRf5tNYV9v7FVJDT0oG1ifdGRN
         ASNKMGxpK28W6/mp6za67OkBfQ7HP0Q/IahSNsrOUy430PuW+A6rWTLNEoOMrYvfdJ6a
         nFM9lKbl/PhEK9GUoRBljpz+R5LajfUc5m7CJ6t54leXebsAU1KZlA/IH0KBkhS/gdYB
         b19X70IfQF7nJy5lRrk0uCg3fTmQ1NOpi5VQEh/J0N6Oy4mw087wBOC/OfKxbjZP9YEi
         51pE2sgItEaguRUinUoU7Mj153IxvV6RKtLva7/wbhj/bQX6Sfc2bvqMvztN6KedyMMo
         7S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782034549; x=1782639349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5vc/NdjXesB9jkRNJ8XJ8hP5JNiEf0N2brRizf1Yl0=;
        b=B16Y//UZeeoeNXn4mYE0AYbelePd8kfWQoQoNP8CW/zUqNquz4maCdYMYzz3XKYUmf
         uVMdRluBdg6PXCD3qlpQe7pLRWmgLK0yHQ7aYx2nKTJGsMZRNYQ3Uj1NSsdENOY0z9qW
         8JdLWzuz9+qRcpv8D3OCDP+1T5wliCa1oHlMzNn+qOv/XdVK+BwbfwH9nz56rlpvAqry
         Hh3CtOBP9YNZyhR6XEfWjb1TdJ9xNfebSpyzbpPqgnpulbdlJIBxlXCyNZbM5fDFMY5k
         EGEhyf4NUUVXVQg3byKoftyFzr/23oaZ/jB8iSV8GV9FwFanKwecG7FqyxPzAT4r+i00
         VxQA==
X-Forwarded-Encrypted: i=1; AFNElJ8oC6PABH32cE9XNVn7P3X9ZjN1MxrXR4vT1rcvOkOruoypqbc+XHybs036b2HxBlsfW6OJURXOcvVK+ONeUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4y/9QeSPtFEnX6/8E1gnqdeeKYb9u0xLu4g/5vsG5vmwhKIfa
	ig48zS/PBJQLYbTgHSUDDLiMCgdorEyi43XXuS2FtyH9pGwM0KKqVLsBYRB6QnnzgA==
X-Gm-Gg: AfdE7cnz9myhR141btzLhEKVvJxte23+Dz+pHQrfTG1XvtpYirvhCkrulLzE6gTVJli
	p88M8Uykgk1GGwZlk8mNru8g7CQLLoYgkrba8S/dNU5bEhTDwnsyOTZD3vlKanzmG9z2vn8Mowb
	SMVkA0Nflnl7gumvRTxQsXdXZTlRpwjEIERWiIahEnw6djWOrJDliuvPmPuIxu5bi8sbpkpUVka
	CnAz4T2dKnQLv2VrFOELF1cDwms4wQHau6m/qg8p1t0uWrIzrlbK7sy7fA2RMOI7P+QpWzjB9YF
	CSC12x/x4qMYuNsS0xb75hxQENJfZGfKSxBkLdwQ4UzikT1As02MzSe1rasPIr+aoWhr97lZE8b
	6Vyvv0Heb1XKOij7pOcEs3BUy62nXmPF24YqOp+pONa/tyZnwiUt5E279Cq4bZqUKtICJqw==
X-Received: by 2002:a05:6a00:2a0c:b0:842:5d9b:d590 with SMTP id d2e1a72fcca58-84550887d3cmr12196574b3a.30.1782034549300;
        Sun, 21 Jun 2026 02:35:49 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecad79sm4619364b3a.50.2026.06.21.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 02:35:49 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH wireless 1/2] wifi: mac80211: fix unsol_bcast_probe_resp double free on alloc failure
Date: Sun, 21 Jun 2026 02:35:31 -0700
Message-ID: <20260621093532.884188-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37945-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,asu.edu];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:bestswngs@gmail.com,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF46F6AA817

ieee80211_set_unsol_bcast_probe_resp() calls kfree_rcu() on the old
template before allocating the replacement. If the kzalloc() then fails,
it returns -ENOMEM while link->u.ap.unsol_bcast_probe_resp still points
at the object already queued for freeing. A later update or AP teardown
re-queues that same rcu_head; the second free is caught by KASAN when the
RCU sheaf is processed in softirq:

  BUG: KASAN: double-free in rcu_free_sheaf (mm/slub.c:5850)
  Free of addr ffff88800d06f300 by task exploit/145
   ...
   __rcu_free_sheaf_prepare (mm/slub.c:2634 mm/slub.c:2940)
   rcu_free_sheaf (mm/slub.c:5850)
   rcu_core (kernel/rcu/tree.c:2617 kernel/rcu/tree.c:2869)
   handle_softirqs (kernel/softirq.c:622)
  The buggy address belongs to the cache kmalloc-128 of size 128

Queue the old object for kfree_rcu() only after the new one is published,
matching ieee80211_set_probe_resp() and ieee80211_set_s1g_short_beacon().

Fixes: 3b1c256eb4ae ("wifi: mac80211: fixes in FILS discovery updates")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f9ee9947a..e926bced6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1178,8 +1178,6 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 	link_conf->unsol_bcast_probe_resp_interval = params->interval;
 
 	old = sdata_dereference(link->u.ap.unsol_bcast_probe_resp, sdata);
-	if (old)
-		kfree_rcu(old, rcu_head);
 
 	if (params->tmpl && params->tmpl_len) {
 		new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
@@ -1192,6 +1190,9 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
 	}
 
+	if (old)
+		kfree_rcu(old, rcu_head);
+
 	*changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
 	return 0;
 }
-- 
2.43.0


