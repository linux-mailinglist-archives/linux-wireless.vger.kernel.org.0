Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249626CF582
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 23:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjC2Vqa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2Vq3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 17:46:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5435E4215;
        Wed, 29 Mar 2023 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=WN4HGk8f22BiyRx+mXnlaMSZaFNc0dPPFLCt9P32Un0=; t=1680126388; x=1681335988; 
        b=U9QHgU7d2K024UxP80bfvh47L6LerB+crZMLYtlzLHYDIELl7qsnleSAL+Zdvl9UFIEE4zSkrFb
        axMZl0jUQcR/nshkFR6scIZQe6IqM83rGL8b6FW4pGSr2M/7R+2uSA9WOAUTD9UZ3k/ceZ0x9DnlF
        x5YIghuluYMeGr3UejamiZWnsxD6lrl2/Fs+KRGevl+SYsQTeXkVkRBQg9LG1cSjd3q1J9myAeG4v
        lxzTmEToqhAcK/JigqtDBDBf6a3VW8bB4z4keMDz/7AOeKTm4XR+71VesFB6UJXCL0LE2n2lyncYO
        RGcg6Wti6rrVfIerpG5PAyGHk1Vrh14jkVOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1phdce-000FPq-2d;
        Wed, 29 Mar 2023 23:46:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/2] net: extend drop reasons for multiple subsystems
Date:   Wed, 29 Mar 2023 23:46:19 +0200
Message-Id: <20230329214620.131636-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Extend drop reasons to make them usable by subsystems
other than core by reserving the high 16 bits for a
new subsystem ID, of which 0 of course is used for the
existing reasons immediately.

To still be able to have string reasons, restructure
that code a bit to make the loopup under RCU, the only
user of this (right now) is drop_monitor.

Link: https://lore.kernel.org/netdev/00659771ed54353f92027702c5bbb84702da62ce.camel@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/dropreason.h | 34 +++++++++++++++++++++----
 net/core/drop_monitor.c  | 32 +++++++++++++++++-------
 net/core/skbuff.c        | 54 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index c0a3ea806cd5..0f9508c6a34f 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -338,11 +338,24 @@ enum skb_drop_reason {
 	 * for another host.
 	 */
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
-	/**
-	 * @SKB_DROP_REASON_MAX: the maximum of drop reason, which shouldn't be
-	 * used as a real 'reason'
+
+	/** @SKB_DROP_REASON_SUBSYS_MASK: subsystem mask in drop reasons,
+	 * see &enum skb_drop_reason_subsys
 	 */
-	SKB_DROP_REASON_MAX,
+	SKB_DROP_REASON_SUBSYS_MASK = 0xffff0000,
+};
+
+#define SKB_DROP_REASON_SUBSYS_SHIFT	16
+
+/**
+ * enum skb_drop_reason_subsys - subsystem tag for (extended) drop reasons
+ */
+enum skb_drop_reason_subsys {
+	/** @SKB_DROP_REASON_SUBSYS_CORE: core drop reasons defined above */
+	SKB_DROP_REASON_SUBSYS_CORE,
+
+	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
+	SKB_DROP_REASON_SUBSYS_NUM
 };
 
 #define SKB_DR_INIT(name, reason)				\
@@ -358,6 +371,17 @@ enum skb_drop_reason {
 			SKB_DR_SET(name, reason);		\
 	} while (0)
 
-extern const char * const drop_reasons[];
+struct drop_reason_list {
+	const char * const *reasons;
+	size_t n_reasons;
+};
+
+/* Note: due to dynamic registrations, access must be under RCU */
+extern const struct drop_reason_list __rcu *
+drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
+
+void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
+				  const struct drop_reason_list *list);
+void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys);
 
 #endif
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 5a782d1d8fd3..c6c60dc75b2d 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 #include <linux/netlink.h>
 #include <linux/net_dropmon.h>
+#include <linux/bitfield.h>
 #include <linux/percpu.h>
 #include <linux/timer.h>
 #include <linux/bitops.h>
@@ -504,8 +505,6 @@ static void net_dm_packet_trace_kfree_skb_hit(void *ignore,
 	if (!nskb)
 		return;
 
-	if (unlikely(reason >= SKB_DROP_REASON_MAX || reason <= 0))
-		reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	cb = NET_DM_SKB_CB(nskb);
 	cb->reason = reason;
 	cb->pc = location;
@@ -552,9 +551,9 @@ static size_t net_dm_in_port_size(void)
 }
 
 #define NET_DM_MAX_SYMBOL_LEN 40
+#define NET_DM_MAX_REASON_LEN 50
 
-static size_t net_dm_packet_report_size(size_t payload_len,
-					enum skb_drop_reason reason)
+static size_t net_dm_packet_report_size(size_t payload_len)
 {
 	size_t size;
 
@@ -576,7 +575,7 @@ static size_t net_dm_packet_report_size(size_t payload_len,
 	       /* NET_DM_ATTR_PROTO */
 	       nla_total_size(sizeof(u16)) +
 	       /* NET_DM_ATTR_REASON */
-	       nla_total_size(strlen(drop_reasons[reason]) + 1) +
+	       nla_total_size(NET_DM_MAX_REASON_LEN + 1) +
 	       /* NET_DM_ATTR_PAYLOAD */
 	       nla_total_size(payload_len);
 }
@@ -610,6 +609,8 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 				     size_t payload_len)
 {
 	struct net_dm_skb_cb *cb = NET_DM_SKB_CB(skb);
+	const struct drop_reason_list *list = NULL;
+	unsigned int subsys, subsys_reason;
 	char buf[NET_DM_MAX_SYMBOL_LEN];
 	struct nlattr *attr;
 	void *hdr;
@@ -627,9 +628,24 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 			      NET_DM_ATTR_PAD))
 		goto nla_put_failure;
 
+	rcu_read_lock();
+	subsys = u32_get_bits(cb->reason, SKB_DROP_REASON_SUBSYS_MASK);
+	if (subsys < SKB_DROP_REASON_SUBSYS_NUM)
+		list = rcu_dereference(drop_reasons_by_subsys[subsys]);
+	subsys_reason = cb->reason & ~SKB_DROP_REASON_SUBSYS_MASK;
+	if (!list ||
+	    subsys_reason >= list->n_reasons ||
+	    !list->reasons[subsys_reason] ||
+	    strlen(list->reasons[subsys_reason]) > NET_DM_MAX_REASON_LEN) {
+		list = rcu_dereference(drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_CORE]);
+		subsys_reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	}
 	if (nla_put_string(msg, NET_DM_ATTR_REASON,
-			   drop_reasons[cb->reason]))
+			   list->reasons[subsys_reason])) {
+		rcu_read_unlock();
 		goto nla_put_failure;
+	}
+	rcu_read_unlock();
 
 	snprintf(buf, sizeof(buf), "%pS", cb->pc);
 	if (nla_put_string(msg, NET_DM_ATTR_SYMBOL, buf))
@@ -687,9 +703,7 @@ static void net_dm_packet_report(struct sk_buff *skb)
 	if (net_dm_trunc_len)
 		payload_len = min_t(size_t, net_dm_trunc_len, payload_len);
 
-	msg = nlmsg_new(net_dm_packet_report_size(payload_len,
-						  NET_DM_SKB_CB(skb)->reason),
-			GFP_KERNEL);
+	msg = nlmsg_new(net_dm_packet_report_size(payload_len), GFP_KERNEL);
 	if (!msg)
 		goto out;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 050a875d09c5..62bf5a756258 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -122,11 +122,59 @@ EXPORT_SYMBOL(sysctl_max_skb_frags);
 
 #undef FN
 #define FN(reason) [SKB_DROP_REASON_##reason] = #reason,
-const char * const drop_reasons[] = {
+static const char * const drop_reasons[] = {
 	[SKB_CONSUMED] = "CONSUMED",
 	DEFINE_DROP_REASON(FN, FN)
 };
-EXPORT_SYMBOL(drop_reasons);
+
+static const struct drop_reason_list drop_reasons_core = {
+	.reasons = drop_reasons,
+	.n_reasons = ARRAY_SIZE(drop_reasons),
+};
+
+const struct drop_reason_list __rcu *
+drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
+	[SKB_DROP_REASON_SUBSYS_CORE] = &drop_reasons_core,
+};
+EXPORT_SYMBOL(drop_reasons_by_subsys);
+
+/**
+ * drop_reasons_register_subsys - register another drop reason subsystem
+ * @subsys: the subsystem to register, must not be the core
+ * @list: the list of drop reasons within the subsystem, must point to
+ *	a statically initialized list
+ */
+void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
+				  const struct drop_reason_list *list)
+{
+	if (WARN(subsys <= SKB_DROP_REASON_SUBSYS_CORE ||
+		 subsys >= ARRAY_SIZE(drop_reasons_by_subsys),
+		 "invalid subsystem %d\n", subsys))
+		return;
+
+	/* must point to statically allocated memory, so INIT is OK */
+	RCU_INIT_POINTER(drop_reasons_by_subsys[subsys], list);
+}
+EXPORT_SYMBOL_GPL(drop_reasons_register_subsys);
+
+/**
+ * drop_reasons_unregister_subsys - unregister a drop reason subsystem
+ * @subsys: the subsystem to remove, must not be the core
+ *
+ * Note: This will synchronize_rcu() to ensure no users when it returns.
+ */
+void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys)
+{
+	if (WARN(subsys <= SKB_DROP_REASON_SUBSYS_CORE ||
+		 subsys >= ARRAY_SIZE(drop_reasons_by_subsys),
+		 "invalid subsystem %d\n", subsys))
+		return;
+
+	RCU_INIT_POINTER(drop_reasons_by_subsys[subsys], NULL);
+
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(drop_reasons_unregister_subsys);
 
 /**
  *	skb_panic - private function for out-of-line support
@@ -984,7 +1032,7 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	if (unlikely(!skb_unref(skb)))
 		return false;
 
-	DEBUG_NET_WARN_ON_ONCE(reason <= 0 || reason >= SKB_DROP_REASON_MAX);
+	DEBUG_NET_WARN_ON_ONCE(reason == SKB_NOT_DROPPED_YET);
 
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
-- 
2.39.2

