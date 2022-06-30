Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F32561ACE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiF3Mzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiF3Mzc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 08:55:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625642A35
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 05:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 097D0B82A7D
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 12:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5A8C34115;
        Thu, 30 Jun 2022 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656593727;
        bh=sPb+aKZxcQB0DTQQMxp20Z9m97RURlz/tRrPqbGNYcA=;
        h=From:To:Cc:Subject:Date:From;
        b=U/qrqbrdd+koLjVRTzBhnRrCXKxqsTqa+YXlmIqMkFxeI2KRKnhlCBCmfgw6diH6G
         HnL+4CSlZQTDm92O2JYn2XiU7P/2BJfa0ogSSsqPeg6YuAodVDNUXFJSnrvsdkKB6Q
         S3ENH1azYs5C49ytamO5N3RztHZtaguBW3T7avid5WvA+g6WCHcjz55IKy8zvq56Yt
         pYQwmqUF+gCdP+K0TBrcDINny3hP4CcSg+7e1IGVB6flwSX+R2Rpuoka1Tt2SUlAjM
         hNuEAf6Y0/OWFJkBAAcJPNWsfrqRYdmXdpLtU8UijFGFpGdUCbEBLq3av29iE88KXP
         KHKh/5Og4oI5w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: add len parameter to __mt76_mcu_msg_alloc signature
Date:   Thu, 30 Jun 2022 14:55:18 +0200
Message-Id: <04f03d8f8951de1c2e7069992e5b4baf7f85cea1.1656593620.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce len to __mt76_mcu_msg_alloc signature in order to add the
capability to specify two different value for allocation and copy length.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c         | 10 ++++++----
 drivers/net/wireless/mediatek/mt76/mt76.h        |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 11 +++++------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 914ee278e6e2..a8cafa39a56d 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -7,17 +7,19 @@
 
 struct sk_buff *
 __mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
-		     int data_len, gfp_t gfp)
+		     int len, int data_len, gfp_t gfp)
 {
 	const struct mt76_mcu_ops *ops = dev->mcu_ops;
-	int length = ops->headroom + data_len + ops->tailroom;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(length, gfp);
+	len = max_t(int, len, data_len);
+	len = ops->headroom + len + ops->tailroom;
+
+	skb = alloc_skb(len, gfp);
 	if (!skb)
 		return NULL;
 
-	memset(skb->head, 0, length);
+	memset(skb->head, 0, len);
 	skb_reserve(skb, ops->headroom);
 
 	if (data && data_len)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4e8997c45c1b..bae1ec34e721 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1346,12 +1346,12 @@ int mt76s_rd_rp(struct mt76_dev *dev, u32 base,
 
 struct sk_buff *
 __mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
-		     int data_len, gfp_t gfp);
+		     int len, int data_len, gfp_t gfp);
 static inline struct sk_buff *
 mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
 		   int data_len)
 {
-	return __mt76_mcu_msg_alloc(dev, data, data_len, GFP_KERNEL);
+	return __mt76_mcu_msg_alloc(dev, data, data_len, data_len, GFP_KERNEL);
 }
 
 void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f2f29eca5d49..9bd0b4d56de1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1441,15 +1441,14 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
 	if (!idx)
 		return;
 
-	skb = __mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req_hdr) +
-				   idx * sizeof(struct in6_addr), GFP_ATOMIC);
-	if (!skb)
-		return;
-
 	req_hdr.arpns.ips_num = idx;
 	req_hdr.arpns.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)
 					+ idx * sizeof(struct in6_addr));
-	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+	skb = __mt76_mcu_msg_alloc(&dev->mt76, &req_hdr,
+			sizeof(req_hdr) + idx * sizeof(struct in6_addr),
+			sizeof(req_hdr), GFP_ATOMIC);
+	if (!skb)
+		return;
 
 	for (i = 0; i < idx; i++)
 		skb_put_data(skb, &ns_addrs[i].in6_u, sizeof(struct in6_addr));
-- 
2.36.1

