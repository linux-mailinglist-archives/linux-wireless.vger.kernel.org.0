Return-Path: <linux-wireless+bounces-37946-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JEAVF6awN2p9PwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37946-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 11:36:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E61066AA823
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 11:36:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=UhWqZqX3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37946-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37946-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EAF1301FF85
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323A25A354;
	Sun, 21 Jun 2026 09:35:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32526D4DD
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 09:35:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782034553; cv=none; b=fH46YmHQscuBa2BtNEyuGn+WyY619Rj/cNZXBCUcSKa92/h+cvs8Io8KGQpTg4iyxevQPsEbANQhu2fq+aIRSnzXhp9ytz1Fo3AxtpN85IvW2udccDCtmBf7eTL2UFfm6ang+m+QuBKs3BYGMkrmoTMdVaWclt0Sz7+W6Oo0YjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782034553; c=relaxed/simple;
	bh=qqmQTmbfcoOQX/GWpDJx1gBR2flP9S/8tkKBIqf7Ozo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuCoOMftCfL6Iq2fSlOLQuucWdnx/JBi71xQQU8EVikwQwtGeUE3FrPojh1PhDUWOfpbIZ7aQIj2AKj+vVxFocQrblHYY8K52+E0I3q7DLsR33bVo15iAsTJPOBxqQIIcStvHKidFbMxpkasN4PLbe85R1QMbOzjmm2amJSDYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=UhWqZqX3; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8453f568e84so3176602b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782034551; x=1782639351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hGBmDovjgqqL0Zw35Gq17sjpjRPB0ygbzBv1yQLFbM=;
        b=UhWqZqX3m1pYR3Y892CTVWqz89q7NWuG2BfEimQlr+2w33iXaY4X9jNRCvUYEglblw
         7mfJ0IVf+IOgcBKjnH+wiffDDtzuWasJuUWY7Zx2loS3iWSyCXr7C2bmQv2ig/Y/pGB0
         zE8wKTFX55lTFaZlqc6Z7OJ6eM9Wac4NsOG6XG04zDPeEy/j2vGo5XdTLfVh9S/T0oZv
         k1pa7A7dHKZMx/k0vN6lV7fntUNe5dJ0toRthT7RV+OxPPJgwGTX6BL8qBqYQ225gjXY
         8jm67IOIneAL6QYOhBWjArb7V7GeAWE5yKJ44doLj+2ESNoOrRrqq1G1Ho2BNuku8wkt
         ephQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782034551; x=1782639351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3hGBmDovjgqqL0Zw35Gq17sjpjRPB0ygbzBv1yQLFbM=;
        b=DOSuAZbWX0xwXwmTSTfrOlbsnRnUrFtu2MGln83SuozEfpIyLdT+BruMdT0+iK/yqS
         nTHVsXPhSYANwQkJuktIMgOGOCQ8gmf/OBQc7Z08jAYnVDAz9PiomfdwkfYqbGN1voF2
         se9W0eVywX6OOMNDLrjsOrlEXB8qPE7kv47aIiEdp6co/gXTqgtQjgEyfASoxBlT/WRv
         1/A3coi8Xt/Rwepy/x2qVJOaoisy0ZUp6yMszmkr39EY+af7HksZsL3OvZ6oNilOvLLh
         cXBhziYkhT3iI94KZt0aRpEglvQFIWZkPiWvrdKrr95KArR+mZNa1NlQl/8RWa15kN7w
         tc/g==
X-Forwarded-Encrypted: i=1; AFNElJ/gGqRMXxZTcRi7PSQ6bFXGzGR1dBQDVuZz2dOoj5hKp7AlxKPhDStmsnCuYGy+SHDHP03AYIHTu+hQ6MMckw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOaMiFx2/vN/iDNxAcwuWYOkV0UhZS95OhfxJY+cFtNC6gQvke
	QsceDS+9tUdteJX7XnrzWwz1c5FACtyBRgosSbQ2hL/KgpFrAifp4cWJweSMvapS7A==
X-Gm-Gg: AfdE7cmhs/u5Nhn7JGyIDF3it9Kg0TdaSnbXzS4OqULvtXnY3wg82pRJ4R6k5eENwnz
	SuvgXlvMkMyADy7k0Pp4Zjy6AgI1ndpg8QMgDZebvqWwD1kj0rS1Dk1nUZYKLSG4JQuPSYtXwND
	ciAehNIvDWx3ARO6UhUTWkRam7mikPuXbuZMFdXm87eEx//l/20dtlvdMc+xxDPtvZ9QO/qgO3d
	TOinOcCYksAmP0oRsRCC83dPQRULWRkFEE8bPugKEePt03IeXdmwMGC1goxNCOfnULVp7SEHv5r
	xIHL5uMbzrr36aRPs3MzHGMiB280DvdwvIvJoJA3q3Ujp47CFq+YCo3jGYQsBZcTqAgAQh/D434
	Djex+8jgfORhAkD6T5DUZpJJI/z7R3NQDWXQmCauChJljXKaZppiMECOenE1GioyNDjGD2A==
X-Received: by 2002:a05:6a00:c8b:b0:845:1715:3b1b with SMTP id d2e1a72fcca58-8455616a5a6mr10463647b3a.35.1782034551120;
        Sun, 21 Jun 2026 02:35:51 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecad79sm4619364b3a.50.2026.06.21.02.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 02:35:50 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH wireless 2/2] wifi: mac80211: fix fils_discovery double free on alloc failure
Date: Sun, 21 Jun 2026 02:35:32 -0700
Message-ID: <20260621093532.884188-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621093532.884188-1-xmei5@asu.edu>
References: <20260621093532.884188-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37946-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,asu.edu];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:bestswngs@gmail.com,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: E61066AA823

ieee80211_set_fils_discovery() calls kfree_rcu() on the old template
before allocating the replacement. If the kzalloc() then fails, it
returns -ENOMEM while link->u.ap.fils_discovery still points at the
object already queued for freeing. A later update or AP teardown
(ieee80211_stop_ap()) re-queues that same rcu_head; the second free is
caught by KASAN when the RCU sheaf is processed in softirq:

  BUG: KASAN: double-free in rcu_free_sheaf (mm/slub.c:5850)
  Free of addr ffff88800c065280 by task swapper/0/0
   ...
   __rcu_free_sheaf_prepare (mm/slub.c:2634 mm/slub.c:2940)
   rcu_free_sheaf (mm/slub.c:5850)
   rcu_core (kernel/rcu/tree.c:2617 kernel/rcu/tree.c:2869)
   handle_softirqs (kernel/softirq.c:622)
  The buggy address belongs to the cache kmalloc-96 of size 96

Queue the old object for kfree_rcu() only after the new one is published,
matching ieee80211_set_probe_resp() and ieee80211_set_s1g_short_beacon().

Fixes: 3b1c256eb4ae ("wifi: mac80211: fixes in FILS discovery updates")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/mac80211/cfg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e926bced6..0bc10136b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1145,9 +1145,6 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 	fd->max_interval = params->max_interval;
 
 	old = sdata_dereference(link->u.ap.fils_discovery, sdata);
-	if (old)
-		kfree_rcu(old, rcu_head);
-
 	if (params->tmpl && params->tmpl_len) {
 		new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
 		if (!new)
@@ -1159,6 +1156,9 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);
 	}
 
+	if (old)
+		kfree_rcu(old, rcu_head);
+
 	*changed |= BSS_CHANGED_FILS_DISCOVERY;
 	return 0;
 }
-- 
2.43.0


