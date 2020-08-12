Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A69242689
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLIF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 04:05:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20093 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgHLIF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 04:05:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597219527; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3J11R7SylqfFQ7UfDN88hDocWcUxSt++ufruP3JxhrM=; b=fP4qG0/WRBIrx/JNxyQUtC28PO9h4D3p9MIJaInflELc9z6QtO9Rc891v7984ysAuUxovGPg
 SWN93BZZr2iGW3luSOrYuOLseHf7//BvV+tGD4R9J6JwQqUbPY0vCLeM2uIjNjt+nPVzsXjY
 7nTOGPOp4/zJHLhnXwEyAWlhrTg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5f33a2c6cbcd42bdee7abafd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 08:05:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72345C433CA; Wed, 12 Aug 2020 08:05:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82C08C433C9;
        Wed, 12 Aug 2020 08:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82C08C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ppranees@codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>
Subject: mac80211: fix xmit callback when hwencap enable
Date:   Wed, 12 Aug 2020 13:35:03 +0530
Message-Id: <1597219503-18295-1-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since transmit control port uses same callback for both
(ieee80211_subif_start_xmit) ethernet mode and native
wifi mode, which causes authentication issue (M2 Handshake failure)
in ethernet mode with encryption(psk2+ccmp).
This will also be an issue for hw/fw which doesn't support per
packet tx/rx encap/decap.

Added hardware encap check to filter out ethernet mode
packets to follow ieee80211_subif_start_xmit_8023 path.

Fixes: a7528198add8 ("mac80211: support control port TX status reporting")
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 net/mac80211/ieee80211_i.h |  5 +++++
 net/mac80211/tx.c          | 49 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec1a71a..d2c4d68 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1783,6 +1783,11 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 				       struct net_device *dev);
 netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 					    struct net_device *dev);
+netdev_tx_t __ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
+					      struct net_device *dev,
+					      u32 info_flags,
+					      u32 ctrl_flags,
+					      u64 *cookie);
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3529d13..a9d1b8d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4150,6 +4150,25 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	netdev_tx_t ret;
+
+	if (unlikely(ieee80211_multicast_to_unicast(skb, dev))) {
+		struct sk_buff_head queue;
+
+		__skb_queue_head_init(&queue);
+		ieee80211_convert_to_unicast(skb, dev, &queue);
+		while ((skb = __skb_dequeue(&queue)))
+			ret = __ieee80211_subif_start_xmit_8023(skb, dev, 0, 0, NULL);
+	} else {
+		ret = __ieee80211_subif_start_xmit_8023(skb, dev, 0, 0, NULL);
+	}
+
+	return ret;
+}
+
 static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, int led_len,
 			      struct sta_info *sta,
@@ -4193,7 +4212,8 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
 
 static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				struct net_device *dev, struct sta_info *sta,
-				struct sk_buff *skb)
+				struct sk_buff *skb, u32 info_flags,
+				u32 ctrl_flags, u64  *cookie)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
@@ -4232,10 +4252,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	memset(info, 0, sizeof(*info));
 
-	if (unlikely(!multicast && skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
+	if (unlikely(!multicast && ((skb->sk &&
+		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ||
+		     ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
 		info->ack_frame_id = ieee80211_store_ack_skb(local, skb,
-							     &info->flags, NULL);
+							     &info_flags, cookie);
 
 	if (unlikely(sdata->control_port_protocol == ehdr->h_proto)) {
 		if (sdata->control_port_no_encrypt)
@@ -4259,6 +4280,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		sdata = container_of(sdata->bss,
 				     struct ieee80211_sub_if_data, u.ap);
 
+	info->flags = info_flags;
 	info->control.flags |= IEEE80211_TX_CTRL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
@@ -4270,8 +4292,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	kfree_skb(skb);
 }
 
-netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
-					    struct net_device *dev)
+netdev_tx_t __ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
+					      struct net_device *dev,
+					      u32 info_flags,
+					      u32 ctrl_flags,
+					      u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct sta_info *sta;
@@ -4291,7 +4316,8 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
 		kfree_skb(skb);
 	else
-		ieee80211_8023_xmit(sdata, dev, sta, skb);
+		ieee80211_8023_xmit(sdata, dev, sta, skb,
+				    info_flags, ctrl_flags, cookie);
 
 	rcu_read_unlock();
 
@@ -5410,7 +5436,14 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	mutex_lock(&local->mtx);
 
 	local_bh_disable();
-	__ieee80211_subif_start_xmit(skb, skb->dev, flags, ctrl_flags, cookie);
+
+	if (sdata->hw_80211_encap)
+		__ieee80211_subif_start_xmit_8023(skb, skb->dev, flags,
+						  ctrl_flags, cookie);
+	else
+		__ieee80211_subif_start_xmit(skb, skb->dev, flags,
+					     ctrl_flags, cookie);
+
 	local_bh_enable();
 
 	mutex_unlock(&local->mtx);
-- 
2.7.4

