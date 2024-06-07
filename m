Return-Path: <linux-wireless+bounces-8703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16A9009EF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501F72857BB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB319B3CD;
	Fri,  7 Jun 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YeyzoXCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DC199EBB;
	Fri,  7 Jun 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776337; cv=none; b=t9MAEXNUR75P+PZap1YFDNkkKjGrl4oVpXoVzkP43gYg5gCVGRXy2tH9ouQ9H7mNrEroYHCvsWmXFNT0XzJi5MONNrjW63C/QMTS/bcXErABv8Ks6wjCWkVkKrXIgisoFzO7cwb78WLhjjZpReb4mff0ZwyjnEVnZqPdxccP/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776337; c=relaxed/simple;
	bh=z9L/VT5UsQCivJ6SxdEVOVB2wfbgOMAG2X9WckMrwEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ7aiFRTc2sEfSTQL5Q9SKKSFnjifC9nSzkVcDCS3l4FTc06piueVTusPLOLniWhvrHxQG9kq5senp/i/QZd/4yDCGMYruhhzJhNRSPk4VovhooSUsoQ8eUnJtxPBdPlFnXXJp3jpvbgCKBDyeyJknP+68NW1U8c0ww14B4Pzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YeyzoXCH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HFqbvy+yDIcOAsvFP2JAPAHPKAhf7Z1A8lonQFVNw84=;
	t=1717776336; x=1718985936; b=YeyzoXCHvwBq9JqcIH8YqjejXCDzHMmvGR+Uc23fbjKMMr4
	wiZ8EM1oTna/rjFZT3pD2GaVpKS2L8e7Iu8aDAawGHTsu30X0tUGjpiAvuhZaVTNp+O32D87UHL6k
	EAaHphw+69MkJ+U4QcX4iNadwOsXfMkgLYP8vDi7YUBV92+mq7tDReosumgJGrmYtwkO7I+N3HBLd
	GaqBEmGl6f2lPvopT1F8BRl7+mx9ak6ah/og1iE3kmG8qYb/kv4daEYvvSpad3sQaprs3MVtHZvuc
	an6pcSgGGrbZlK3c/Vo5zG5Opk7goNH0GQrEJj293wE3H6RQGQYwcagc+9AXRFFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFc5t-00000001Iyu-11vF;
	Fri, 07 Jun 2024 18:05:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 4/4] net: drop_monitor: use drop_reason_lookup()
Date: Fri,  7 Jun 2024 18:04:26 +0200
Message-ID: <20240607160527.23624-10-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607160527.23624-6-johannes@sipsolutions.net>
References: <20240607160527.23624-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Now that we have drop_reason_lookup(), we can just use it for
drop_monitor as well, rather than exporting the list itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v3:
 - look up SKB_DROP_REASON_NOT_SPECIFIED if initial lookup
   returns NULL, to preserve previous behaviour
---
 include/net/dropreason.h |  4 ----
 net/core/drop_monitor.c  | 20 +++++---------------
 net/core/skbuff.c        |  6 +++---
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index c157070b5303..0e2195ccf2cd 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -38,10 +38,6 @@ struct drop_reason_list {
 	size_t n_reasons;
 };
 
-/* Note: due to dynamic registrations, access must be under RCU */
-extern const struct drop_reason_list __rcu *
-drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
-
 #ifdef CONFIG_TRACEPOINTS
 const char *drop_reason_lookup(unsigned long long value);
 void drop_reason_show(struct seq_file *m);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 430ed18f8584..fddf6b68bf06 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -610,9 +610,8 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 				     size_t payload_len)
 {
 	struct net_dm_skb_cb *cb = NET_DM_SKB_CB(skb);
-	const struct drop_reason_list *list = NULL;
-	unsigned int subsys, subsys_reason;
 	char buf[NET_DM_MAX_SYMBOL_LEN];
+	const char *reason_str;
 	struct nlattr *attr;
 	void *hdr;
 	int rc;
@@ -630,19 +629,10 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 		goto nla_put_failure;
 
 	rcu_read_lock();
-	subsys = u32_get_bits(cb->reason, SKB_DROP_REASON_SUBSYS_MASK);
-	if (subsys < SKB_DROP_REASON_SUBSYS_NUM)
-		list = rcu_dereference(drop_reasons_by_subsys[subsys]);
-	subsys_reason = cb->reason & ~SKB_DROP_REASON_SUBSYS_MASK;
-	if (!list ||
-	    subsys_reason >= list->n_reasons ||
-	    !list->reasons[subsys_reason] ||
-	    strlen(list->reasons[subsys_reason]) > NET_DM_MAX_REASON_LEN) {
-		list = rcu_dereference(drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_CORE]);
-		subsys_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	}
-	if (nla_put_string(msg, NET_DM_ATTR_REASON,
-			   list->reasons[subsys_reason])) {
+	reason_str = drop_reason_lookup(cb->reason);
+	if (unlikely(!reason_str))
+		reason_str = drop_reason_lookup(SKB_DROP_REASON_NOT_SPECIFIED);
+	if (nla_put_string(msg, NET_DM_ATTR_REASON, reason_str)) {
 		rcu_read_unlock();
 		goto nla_put_failure;
 	}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cd1ea6c3e0f8..bd4fb7410284 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -139,13 +139,11 @@ static const struct drop_reason_list drop_reasons_core = {
 	.n_reasons = ARRAY_SIZE(drop_reasons),
 };
 
-const struct drop_reason_list __rcu *
+static const struct drop_reason_list __rcu *
 drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
 	[SKB_DROP_REASON_SUBSYS_CORE] = RCU_INITIALIZER(&drop_reasons_core),
 };
-EXPORT_SYMBOL(drop_reasons_by_subsys);
 
-#ifdef CONFIG_TRACEPOINTS
 const char *drop_reason_lookup(unsigned long long value)
 {
 	unsigned long long subsys_id = value >> SKB_DROP_REASON_SUBSYS_SHIFT;
@@ -162,7 +160,9 @@ const char *drop_reason_lookup(unsigned long long value)
 		return NULL;
 	return subsys->reasons[reason];
 }
+EXPORT_SYMBOL(drop_reason_lookup);
 
+#ifdef CONFIG_TRACEPOINTS
 void drop_reason_show(struct seq_file *m)
 {
 	u32 subsys_id;
-- 
2.45.2


