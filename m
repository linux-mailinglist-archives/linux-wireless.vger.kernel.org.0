Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7C4F11CE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349482AbiDDJTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDDJTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 05:19:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB723B3D4
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 02:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF25660AFC
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 09:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B9C2BBE4;
        Mon,  4 Apr 2022 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649063828;
        bh=s2SPK9LgzFu5Yxliw1Yjvq+w6fHt/3dQHQOmW8MTi20=;
        h=From:To:Cc:Subject:Date:From;
        b=miBuDCDWkEGs5NdwvMiJkIaoK2oO01IVCSfSe0P3RVfoLmf2rkdoUZedAj2l57d0n
         6fhxOGjDQ5Hw+ssaOTESMZpXL8Y6GgPn8o2SrIEVETM0Qj3a31nZFj9GDNDT8vs4b/
         9nV21FObDsCfkVb0rtbQDJF/MpB3NajXb4+G50GxO6o2nvjJcESoWkieCVaL+6STk1
         dNe+ajgN4FmlKfEscCEON0xCMmA9P3cuLvO671nk6m2HGJ5p9pq6O99ziakIrpeadE
         xXLBXbGUilJGufs6zZnoupU7HwuAicqmYP1VUxSUzhQxM2qk5WyQ+27e/+f4l7V92R
         PiUBsTMFtXBXA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: report rx mode value in mt7915_mac_fill_rx_rate
Date:   Mon,  4 Apr 2022 11:17:03 +0200
Message-Id: <eaa4e612b65fd3585fab9b11176d5cefcbcdc349.1649063754.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report rx mode in mt7915_mac_fill_rx_rate routine in order to properly
add he radiotap if mode is at least HE_SU.

Fixes: 1c9db0aa23fd1 ("mt76: mt7915: update rx rate reporting for mt7916")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5ccdfa89bef6..803e5e05a40a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -309,7 +309,7 @@ mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
 }
 
 static void
-mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
+mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	static const struct ieee80211_radiotap_he known = {
@@ -474,10 +474,10 @@ static int
 mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			struct mt76_rx_status *status,
 			struct ieee80211_supported_band *sband,
-			__le32 *rxv)
+			__le32 *rxv, u8 *mode)
 {
 	u32 v0, v2;
-	u8 stbc, gi, bw, dcm, mode, nss;
+	u8 stbc, gi, bw, dcm, nss;
 	int i, idx;
 	bool cck = false;
 
@@ -490,18 +490,18 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 	if (!is_mt7915(&dev->mt76)) {
 		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
 		gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v0);
-		mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
+		*mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
 		dcm = FIELD_GET(MT_PRXV_DCM, v0);
 		bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
 	} else {
 		stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
 		gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
-		mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
+		*mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
 		dcm = !!(idx & GENMASK(3, 0) & MT_PRXV_TX_DCM);
 		bw = FIELD_GET(MT_CRXV_FRAME_MODE, v2);
 	}
 
-	switch (mode) {
+	switch (*mode) {
 	case MT_PHY_TYPE_CCK:
 		cck = true;
 		fallthrough;
@@ -546,7 +546,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 	case IEEE80211_STA_RX_BW_20:
 		break;
 	case IEEE80211_STA_RX_BW_40:
-		if (mode & MT_PHY_TYPE_HE_EXT_SU &&
+		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
 		    (idx & MT_PRXV_TX_ER_SU_106T)) {
 			status->bw = RATE_INFO_BW_HE_RU;
 			status->he_ru =
@@ -566,7 +566,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 	}
 
 	status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
-	if (mode < MT_PHY_TYPE_HE_SU && gi)
+	if (*mode < MT_PHY_TYPE_HE_SU && gi)
 		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 
 	return 0;
@@ -581,7 +581,6 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct ieee80211_supported_band *sband;
 	__le32 *rxd = (__le32 *)skb->data;
 	__le32 *rxv = NULL;
-	u32 mode = 0;
 	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
@@ -590,10 +589,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	bool unicast, insert_ccmp_hdr = false;
 	u8 remove_pad, amsdu_info;
+	u8 mode = 0, qos_ctl = 0;
 	bool hdr_trans;
 	u16 hdr_gap;
 	u16 seq_ctrl = 0;
-	u8 qos_ctl = 0;
 	__le16 fc = 0;
 	int idx;
 
@@ -766,7 +765,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		}
 
 		if (!is_mt7915(&dev->mt76) || (rxd1 & MT_RXD1_NORMAL_GROUP_5)) {
-			ret = mt7915_mac_fill_rx_rate(dev, status, sband, rxv);
+			ret = mt7915_mac_fill_rx_rate(dev, status, sband, rxv,
+						      &mode);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.35.1

