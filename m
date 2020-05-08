Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EF1CB219
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEHOmX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 10:42:23 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:54263 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgEHOmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 10:42:23 -0400
Received: from legolas.fritz.box (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id B5577580248;
        Fri,  8 May 2020 16:42:19 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/3] nl80211: cookie arg for tx control port
Date:   Fri,  8 May 2020 16:42:00 +0200
Message-Id: <20200508144202.7678-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
References: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is a preparation for getting tx status reports for nl80211
control port frames. It adds a cookie parameter and replies the cookie
to the sending process. This cookie can later be used to identify
succesfull or lost ACKs (analog to already existing status reports for
mgmt frames).

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/net/cfg80211.h     |  3 ++-
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/tx.c          |  3 ++-
 net/wireless/nl80211.c     | 45 +++++++++++++++++++++++++++++++++-----
 net/wireless/rdev-ops.h    |  4 ++--
 5 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a82fc59a1d82..d3d18481f6da 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4067,7 +4067,8 @@ struct cfg80211_ops {
 				   struct net_device *dev,
 				   const u8 *buf, size_t len,
 				   const u8 *dest, const __be16 proto,
-				   const bool noencrypt);
+				   const bool noencrypt,
+				   u64 *cookie);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
 				struct net_device *dev,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8cbae66b5cdb..4f6432c7e150 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1800,7 +1800,8 @@ void ieee80211_check_fast_xmit_iface(struct ieee80211_sub_if_data *sdata);
 void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
-			      const u8 *dest, __be16 proto, bool unencrypted);
+			      const u8 *dest, __be16 proto, bool unencrypted,
+			      u64 *cookie);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6dad67eb60b2..ba34cc392ea8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5339,7 +5339,8 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
-			      const u8 *dest, __be16 proto, bool unencrypted)
+			      const u8 *dest, __be16 proto, bool unencrypted,
+			      u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3d27b24c68b2..4fe232a51078 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13862,14 +13862,18 @@ static int nl80211_external_auth(struct sk_buff *skb, struct genl_info *info)
 
 static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 {
+	bool dont_wait_for_ack = info->attrs[NL80211_ATTR_DONT_WAIT_FOR_ACK];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct sk_buff *msg = NULL;
+	void *hdr = NULL;
 	const u8 *buf;
 	size_t len;
 	u8 *dest;
 	u16 proto;
 	bool noencrypt;
+	u64 cookie;
 	int err;
 
 	if (!wiphy_ext_feature_isset(&rdev->wiphy,
@@ -13899,10 +13903,10 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 		if (wdev->current_bss)
 			break;
 		err = -ENOTCONN;
-		goto out;
+		goto out_unlock;
 	default:
 		err = -EOPNOTSUPP;
-		goto out;
+		goto out_unlock;
 	}
 
 	wdev_unlock(wdev);
@@ -13914,11 +13918,42 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	noencrypt =
 		nla_get_flag(info->attrs[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT]);
 
-	return rdev_tx_control_port(rdev, dev, buf, len,
-				    dest, cpu_to_be16(proto), noencrypt);
+	if (!dont_wait_for_ack) {
+		msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
 
- out:
+		hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
+				     NL80211_CMD_CONTROL_PORT_FRAME);
+		if (!hdr) {
+			err = -ENOBUFS;
+			goto free_msg;
+		}
+	}
+
+	err = rdev_tx_control_port(rdev, dev, buf, len,
+				   dest, cpu_to_be16(proto), noencrypt,
+				   dont_wait_for_ack ? NULL : &cookie);
+	if (err)
+		goto free_msg;
+
+	if (msg) {
+		if (nla_put_u64_64bit(msg, NL80211_ATTR_COOKIE, cookie,
+				      NL80211_ATTR_PAD))
+			goto nla_put_failure;
+
+		genlmsg_end(msg, hdr);
+		return genlmsg_reply(msg, info);
+	}
+
+	return 0;
+
+out_unlock:
 	wdev_unlock(wdev);
+nla_put_failure:
+	err = -ENOBUFS;
+free_msg:
+	nlmsg_free(msg);
 	return err;
 }
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index df5142e86c4f..63b5786572d0 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -748,13 +748,13 @@ static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
 				       struct net_device *dev,
 				       const void *buf, size_t len,
 				       const u8 *dest, __be16 proto,
-				       const bool noencrypt)
+				       const bool noencrypt, u64 *cookie)
 {
 	int ret;
 	trace_rdev_tx_control_port(&rdev->wiphy, dev, buf, len,
 				   dest, proto, noencrypt);
 	ret = rdev->ops->tx_control_port(&rdev->wiphy, dev, buf, len,
-					 dest, proto, noencrypt);
+					 dest, proto, noencrypt, cookie);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
-- 
2.26.2

