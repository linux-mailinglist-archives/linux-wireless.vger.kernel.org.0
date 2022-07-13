Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A84573362
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiGMJqw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiGMJpk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C6F5D76
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mpXzuFSd58xiR2EOBMOUQGVZrkILLr7nwmtcyCY3Fss=;
        t=1657705529; x=1658915129; b=h14Y3nK2/knB+D0eWYWPPnOOi3mFCWFdpwQtCFEvIY3MiIO
        qAip2IzcwCLI1G7M84IDLSvDOW4zH0ydfXABTz8m66AicoYFVKpcHqQfNeyJVfdEQlqRgxZUuoA6F
        mQ1mK4RSEocExrgxFlCjJHc2wPUQ56EJeYc7dRb+pg+lrmpvl3k9LVVrkXcwXkEmY+t6IPKfoatVk
        9RgrCYnLL3mSrTpWIw1qpKDXO1vf+2f/qmi48CbBPGleEutcKn+rH1Pd9+ef+InL4yU4HGTPLhH4u
        Z4/4ilnTSWFi13TRT5nr+nef41MaDcMC9rU0okbMVcf+2394d4mKLlgK9mvRChXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvv-00EgvB-TM;
        Wed, 13 Jul 2022 11:45:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 67/76] wifi: cfg80211/mac80211: Support control port TX from specific link
Date:   Wed, 13 Jul 2022 11:44:53 +0200
Message-Id: <20220713114426.770642ac34cd.Ia44550171817fdecc58fc102675857d7d28d7ce9@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

In case of authentication with a legacy station, link addressed EAPOL
frames should be sent. Support it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h     |  2 +-
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/tx.c          | 20 ++++++++++++++++++--
 net/wireless/nl80211.c     |  5 ++++-
 net/wireless/rdev-ops.h    |  7 ++++---
 net/wireless/trace.h       | 11 +++++++----
 6 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 44abaa9d74ea..c2fd971e5c4d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4580,7 +4580,7 @@ struct cfg80211_ops {
 				   struct net_device *dev,
 				   const u8 *buf, size_t len,
 				   const u8 *dest, const __be16 proto,
-				   const bool noencrypt,
+				   const bool noencrypt, int link_id,
 				   u64 *cookie);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d17d73e8d19f..58b08315fa26 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1946,7 +1946,7 @@ void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      u64 *cookie);
+			      int link_id, u64 *cookie);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a077399ed065..1ba3bd180bd2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5684,7 +5684,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      u64 *cookie)
+			      int link_id, u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -5724,7 +5724,23 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 
 	ehdr = skb_push(skb, sizeof(struct ethhdr));
 	memcpy(ehdr->h_dest, dest, ETH_ALEN);
-	memcpy(ehdr->h_source, sdata->vif.addr, ETH_ALEN);
+
+	if (link_id < 0) {
+		memcpy(ehdr->h_source, sdata->vif.addr, ETH_ALEN);
+	} else {
+		struct ieee80211_bss_conf *link_conf;
+
+		rcu_read_lock();
+		link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+		if (!link_conf) {
+			dev_kfree_skb(skb);
+			rcu_read_unlock();
+			return -ENOLINK;
+		}
+		memcpy(ehdr->h_source, link_conf->addr, ETH_ALEN);
+		rcu_read_unlock();
+	}
+
 	ehdr->h_proto = proto;
 
 	skb->dev = dev;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 35fcf36bbaad..53d63effbca9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15223,6 +15223,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	u16 proto;
 	bool noencrypt;
 	u64 cookie = 0;
+	int link_id;
 	int err;
 
 	if (!wiphy_ext_feature_isset(&rdev->wiphy,
@@ -15271,8 +15272,10 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	noencrypt =
 		nla_get_flag(info->attrs[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT]);
 
+	link_id = nl80211_link_id_or_invalid(info->attrs);
+
 	err = rdev_tx_control_port(rdev, dev, buf, len,
-				   dest, cpu_to_be16(proto), noencrypt,
+				   dest, cpu_to_be16(proto), noencrypt, link_id,
 				   dont_wait_for_ack ? NULL : &cookie);
 	if (!err && !dont_wait_for_ack)
 		nl_set_extack_cookie_u64(info->extack, cookie);
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 53f5a0126dfd..40915a82da73 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -746,13 +746,14 @@ static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
 				       struct net_device *dev,
 				       const void *buf, size_t len,
 				       const u8 *dest, __be16 proto,
-				       const bool noencrypt, u64 *cookie)
+				       const bool noencrypt, int link,
+				       u64 *cookie)
 {
 	int ret;
 	trace_rdev_tx_control_port(&rdev->wiphy, dev, buf, len,
-				   dest, proto, noencrypt);
+				   dest, proto, noencrypt, link);
 	ret = rdev->ops->tx_control_port(&rdev->wiphy, dev, buf, len,
-					 dest, proto, noencrypt, cookie);
+					 dest, proto, noencrypt, link, cookie);
 	if (cookie)
 		trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	else
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index dac66ad5937d..592b9e9e821a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2015,14 +2015,15 @@ TRACE_EVENT(rdev_mgmt_tx,
 TRACE_EVENT(rdev_tx_control_port,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 const u8 *buf, size_t len, const u8 *dest, __be16 proto,
-		 bool unencrypted),
-	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted),
+		 bool unencrypted, int link_id),
+	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted, link_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		MAC_ENTRY(dest)
 		__field(__be16, proto)
 		__field(bool, unencrypted)
+		__field(int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2030,12 +2031,14 @@ TRACE_EVENT(rdev_tx_control_port,
 		MAC_ASSIGN(dest, dest);
 		__entry->proto = proto;
 		__entry->unencrypted = unencrypted;
+		__entry->link_id = link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ","
-		  " proto: 0x%x, unencrypted: %s",
+		  " proto: 0x%x, unencrypted: %s, link: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dest),
 		  be16_to_cpu(__entry->proto),
-		  BOOL_TO_STR(__entry->unencrypted))
+		  BOOL_TO_STR(__entry->unencrypted),
+		  __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_noack_map,
-- 
2.36.1

