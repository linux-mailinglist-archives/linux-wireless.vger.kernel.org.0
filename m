Return-Path: <linux-wireless+bounces-9005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357CE908615
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1FD1F26D16
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA118734B;
	Fri, 14 Jun 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T5vLlqDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAD184129;
	Fri, 14 Jun 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353205; cv=none; b=THNp8rf1COspXYClCIpkXNOxWQBZPlVb9IPUq4H/hhuepjeFd4K1g6hrh8W7sUHgV4jRMYc4ZP82Mcbn00UEkwab86iQcO/d73gMQyRzfqUBCj484zjnliSaqRTzDrtnyNsRznJqnQiqmn4nHG9G9erbkjZg0dxYRTwCYMKXpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353205; c=relaxed/simple;
	bh=E4arFM9k6nDnCNLegQCocTifweIoWJFBm9lxLSUeLxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1hcIu+7bg6by4GgeVnbzW2urQIMnerGePlB3tGA+hhPy+WVmdmVRf478rikVQ8LOjx9LuOHTkGLGRVdvgUWpDAy3ZSnnr54f02ZAwbQ3Up7p1bkxkDP9KH4LbCNNd8NdFIkG1/NxBODoYl3fUO39LEx+n//P0+QfoLMU+JplSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T5vLlqDM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tKr7lLN/VFwO5+6n6WfNe+lZgTMwnw4xRQwRBA9Nxfs=;
	t=1718353203; x=1719562803; b=T5vLlqDM+7SsNvDd+drThIEjlardDxuDnvrWU/YlT43oQ4Y
	lGJgQi+CWsgK95Pt6FaeUxh8LWEv8Qvk2pRQfRPI87cLBJCEpDM1CDzXuoseWPTzDB/ZfxuI5/rqQ
	n74cDpA7W3a9t+dxlyBdCHe9Q2tt/H8b59cn2FuIMDqDHBF5z8Fwj82NJ7dRh1tfnAfsOmhHgCkeQ
	i1WhRIUqB8KmzkUbPPUgE/PBjycb5scyxTNeJ6QRwT/i0Ae8Eb9RlYAPKIpD/6blCYcjjKSBcw+hv
	2INFtDGKjWPdQyfG3vDCmp5FXd4MJSg4t8KYT1cPhtqBJtF/eVp5JL0g15oI6Xww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sI2AC-0000000DZpq-3rmT;
	Fri, 14 Jun 2024 10:20:01 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 3/4] net: dropreason: use new __print_sym() in tracing
Date: Fri, 14 Jun 2024 10:19:15 +0200
Message-ID: <20240614081956.19832-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614081956.19832-6-johannes@sipsolutions.net>
References: <20240614081956.19832-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The __print_symbolic() could only ever print the core
drop reasons, since that's the way the infrastructure
works. Now that we have __print_sym() with all the
advantages mentioned in that commit, convert to that
and get all the drop reasons from all subsystems. As
we already have a list of them, that's really easy.

This is a little bit of .text (~100 bytes in my build)
and saves a lot of .data (~17k).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/dropreason.h   |  5 +++++
 include/trace/events/skb.h | 16 +++-----------
 net/core/skbuff.c          | 43 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 56cb7be92244..c157070b5303 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -42,6 +42,11 @@ struct drop_reason_list {
 extern const struct drop_reason_list __rcu *
 drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
 
+#ifdef CONFIG_TRACEPOINTS
+const char *drop_reason_lookup(unsigned long long value);
+void drop_reason_show(struct seq_file *m);
+#endif
+
 void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
 				  const struct drop_reason_list *list);
 void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys);
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 07e0715628ec..8a1a63f9e796 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -8,15 +8,9 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/tracepoint.h>
+#include <net/dropreason.h>
 
-#undef FN
-#define FN(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
-DEFINE_DROP_REASON(FN, FN)
-
-#undef FN
-#undef FNe
-#define FN(reason)	{ SKB_DROP_REASON_##reason, #reason },
-#define FNe(reason)	{ SKB_DROP_REASON_##reason, #reason }
+TRACE_DEFINE_SYM_FNS(drop_reason, drop_reason_lookup, drop_reason_show);
 
 /*
  * Tracepoint for free an sk_buff:
@@ -44,13 +38,9 @@ TRACE_EVENT(kfree_skb,
 
 	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s",
 		  __entry->skbaddr, __entry->protocol, __entry->location,
-		  __print_symbolic(__entry->reason,
-				   DEFINE_DROP_REASON(FN, FNe)))
+		  __print_sym(__entry->reason, drop_reason ))
 );
 
-#undef FN
-#undef FNe
-
 TRACE_EVENT(consume_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location),
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..cd1ea6c3e0f8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -145,6 +145,49 @@ drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
 };
 EXPORT_SYMBOL(drop_reasons_by_subsys);
 
+#ifdef CONFIG_TRACEPOINTS
+const char *drop_reason_lookup(unsigned long long value)
+{
+	unsigned long long subsys_id = value >> SKB_DROP_REASON_SUBSYS_SHIFT;
+	u32 reason = value & ~SKB_DROP_REASON_SUBSYS_MASK;
+	const struct drop_reason_list *subsys;
+
+	if (subsys_id >= SKB_DROP_REASON_SUBSYS_NUM)
+		return NULL;
+
+	subsys = rcu_dereference(drop_reasons_by_subsys[subsys_id]);
+	if (!subsys)
+		return NULL;
+	if (reason >= subsys->n_reasons)
+		return NULL;
+	return subsys->reasons[reason];
+}
+
+void drop_reason_show(struct seq_file *m)
+{
+	u32 subsys_id;
+
+	rcu_read_lock();
+	for (subsys_id = 0; subsys_id < SKB_DROP_REASON_SUBSYS_NUM; subsys_id++) {
+		const struct drop_reason_list *subsys;
+		u32 i;
+
+		subsys = rcu_dereference(drop_reasons_by_subsys[subsys_id]);
+		if (!subsys)
+			continue;
+
+		for (i = 0; i < subsys->n_reasons; i++) {
+			if (!subsys->reasons[i])
+				continue;
+			seq_printf(m, ", { %u, \"%s\" }",
+				   (subsys_id << SKB_DROP_REASON_SUBSYS_SHIFT) | i,
+				   subsys->reasons[i]);
+		}
+	}
+	rcu_read_unlock();
+}
+#endif
+
 /**
  * drop_reasons_register_subsys - register another drop reason subsystem
  * @subsys: the subsystem to register, must not be the core
-- 
2.45.2


