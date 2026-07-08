Return-Path: <linux-wireless+bounces-38775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oc/SI7XBTWp/9wEAu9opvQ
	(envelope-from <linux-wireless+bounces-38775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 05:19:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB2F72159A
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 05:19:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iNvpeQ7C;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38775-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38775-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8B06304ED46
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137D3469F6;
	Wed,  8 Jul 2026 03:14:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB99315D40
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 03:14:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480470; cv=none; b=BGjb6I1jXFInWluBWhI+Gi42z6be3qIjXM9hAz+WJtNtowTOzOrAnivFCjk2CRiO4a6K+zrjMB8oyXAQ1BHv0ok78SURFiyBrt/fUZRorWwR3fyxXahD+D1CX3LlkzqPzhliiTwuE9Low2r274Jtm0Z1/NY6zOP0Dkx87XA0tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480470; c=relaxed/simple;
	bh=3IHuIja7e1WdS6iV9pCDHoDOKnQIHX3M0YAFf3HpaqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRkVRJH2ZSHwZhklP438iKaSwdmrYWN0wJk5KyNOke44qBOBAYwMz/I0mHG6qvBLSYIBhvl/cJXAZ96smnZPTlwTxV2XCkh7uDgTvqH8DOd17s6ZtNq2Snqd25SWQzGm5NJ3wx/Of1VTjsHicOUHqx3W+C7dNFJSmGYt+Vn33KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNvpeQ7C; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so86979a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480468; x=1784085268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRMQKJ8Vv3KLx4GpiVwLR6T6CZd6YKMLVnC0zd8xgd4=;
        b=iNvpeQ7CqoeRiykyQV3OYJ7nDfwo6ALgk/Shiey/kushd7v1dKl+uZryySw+SCTECP
         qpnva40l4Bgv4OKVfQS32+zYUpLIgmbnCAYHdIobzZzKjLm2NAcWUYyi1Fm/ADffIRGI
         HX6X9zA8nkuAnNIZqcvqhahmzxDt8KEN8pvM2kdvfEvG35C52CNkTRMnW4JvgLmjxyzz
         Aa2zBssJbMqGBfDAklwRBX4260AO9edtIyKhHggIWpOwmN77Wo0vLBZhy8LC0x8qf2zw
         0gXYCfBraR4xeJLhmdm2rLIDK/0k0vzCgNpxiT8VP+0Zs7SACxREJJPCaiDFlCC3jo8f
         nzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480468; x=1784085268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRMQKJ8Vv3KLx4GpiVwLR6T6CZd6YKMLVnC0zd8xgd4=;
        b=aCGl9X7qdwQCuRM9VvCAfnFs6z0Y/J/dJEKV6C97Ulzz1fh92379cdJygk0wO2yiyO
         +w3EtM9O6T6NWI/XsrSPhdRzk9nhqNxk6K/WM7/pECOE+PoV7jSlKJSj5KCmmBnFNFxy
         z7Jw/FIt8nu3HwrOk55MKYcQVXvNL2RMqcIgKtOqtnIRMo2kS6gpPYLpAYkpQp+Rht27
         8ttRNSU8NKx3r7/rUaGR9c7dl1oEXee/MQt83bGJfZk8iP+Sx8GJRG25F4/nZoWeOpWb
         HBGQh5I1niHeti0j6z/O4C4sSnZsaMU7qtx/u0BZweQIHp5EHdcMzPuNXyAMYTaEQyDm
         i/sA==
X-Gm-Message-State: AOJu0YyJL3U1uja4rrfNPIClOrPUdeE7dTiVgGImk2EBk74di3Qy6W0a
	RpjqgyM9Lmhi4E+HYc7cOr7gZAs+J5oBh6/atzbhiZBB0IHh25ON+fKZ
X-Gm-Gg: AfdE7cmW4WuOpr585DLxeCX+CTalQy+JmEqrTwdqj6pXbB79WgFIb0niT5Ynp0/RXJ+
	GsdZKWCwecjcCDNMjZgf/ViFCfqT8bINWCSt+agbOpjQB4zIptrgs1hjGXax6zwt+yiq3OuVNKS
	Fti+XiB8ISiVs861vtBJnXCmw0xonnZCYgm/9iG3cziwClyoFAB++al4Q2E6Qi0jbWUJjy73y+C
	vDfZk5E39Zq0k74eIO/JK/gkvVgIuOePTAqQfwn9P3x0yDHbX6i+kDeQuBc38DJY3KiiAmenX31
	nqzWvl4ieJowdQ9D6xIg9HjwL+tqEIAUghOgv3JhKXbrGm8tPfBKXM57ScXhAP/bxTt7tJTLnRu
	aZwTA9yqKtBlgOv6CIC/p7mwpIzcHvVsQwGo99WzGybtLkSD53ntyMjfM++z2c2kRj+r4LUvB/j
	moWy0cn+ZSErEhQxW9Rg==
X-Received: by 2002:a05:6a20:939a:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3c0bcc5b894mr539746637.20.1783480468152;
        Tue, 07 Jul 2026 20:14:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af6df87fsm1762658a12.5.2026.07.07.20.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:14:27 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] wifi: cfg80211: BUG on runaway wiphy work drains
Date: Wed,  8 Jul 2026 11:14:22 +0800
Message-Id: <20260708031422.2215685-1-zzzccc427@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38775-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCB2F72159A

cfg80211_process_wiphy_works() currently tries to recover from a
runaway drain by reinitializing rdev->wiphy_work_list. That avoids
walking the list any further, but it can strand valid owner-embedded work
entries with stale list links. Trying to fix that by walking the
remaining list is not safe either, because the guard may have fired after
list corruption or accidental work reinitialization.

Stop trying to recover from this state. Raise the limit to 30000
iterations so ordinary long drains have much more headroom, and BUG() if
the guard still fires. At that point the code cannot reliably tell a
self-requeueing work loop from a corrupted list, and continuing risks
either silently losing work or touching corrupted links.

Fixes: a3ee4dc84c4e ("wifi: cfg80211: add a work abstraction with special semantics")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v2:
- Raise the runaway limit to 30000 and BUG() if it is still hit.
- Drop the per-entry drain so the fallback does not walk a possibly
  corrupted list.

 net/wireless/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3dcf63b04c41..9a4d022f8838 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1256,7 +1256,7 @@ EXPORT_SYMBOL(wiphy_rfkill_start_polling);
 void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
 				  struct wiphy_work *end)
 {
-	unsigned int runaway_limit = 100;
+	unsigned int runaway_limit = 30000;
 	unsigned long flags;
 
 	lockdep_assert_held(&rdev->wiphy.mtx);
@@ -1278,8 +1278,8 @@ void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
 		if (wk == end)
 			break;
 
-		if (WARN_ON(--runaway_limit == 0))
-			INIT_LIST_HEAD(&rdev->wiphy_work_list);
+		if (--runaway_limit == 0)
+			BUG();
 	}
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 }
-- 
2.43.0

