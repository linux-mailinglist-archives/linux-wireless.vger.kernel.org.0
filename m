Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8B7D73D4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjJYTEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJYTEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:05 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD99A116
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:02 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4EE0B100089
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:00 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id DCF4E13C2B1;
        Wed, 25 Oct 2023 12:03:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DCF4E13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260639;
        bh=C2SLlS3wqPNNp9HkNpxrU6DV2xPUkE8UUhX0ZQbHWlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9HyCoC5kvdWe24w9sjsx5M/dKWeXedtAW4aypLKqR05QrlwLZo8sBlzry7vsNKtZ
         hNYzhUjbx7NiKdI18N1OTbkbNK5fCwoxcufqdR+4/PCUGVpOTupmz0AeoxGErWzsur
         42S3FBuIFFjEyIrZHa1OHgUbibN3zjH78Pnrl290=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 02/12] wifi: mt76: mt7915: cache sgi in wcid.
Date:   Wed, 25 Oct 2023 12:03:44 -0700
Message-Id: <20231025190351.2141832-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190351.2141832-1-greearb@candelatech.com>
References: <20231025190351.2141832-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260641-Ra5u8P2kjpFN
X-MDID-O: us5;ut7;1698260641;Ra5u8P2kjpFN;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Explicitly cache short_gi and he_gi in wcid, don't try to store
it in the wcid.rate object.  Slightly less confusing and less fragile
when TXS starts parsing lots of frames.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 9 +++++++--
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ea828ba0b83a..9b30d4aab952 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -316,8 +316,13 @@ struct mt76_wcid {
 	struct ewma_signal rssi;
 	int inactive_count;
 
+	/* cached rate, updated from mac_sta_poll() and from TXS callback logic,
+	 * in 7915 at least.
+	 */
 	struct rate_info rate;
 	unsigned long ampdu_state;
+	bool rate_short_gi; /* cached HT/VHT short_gi, from mac_sta_poll() */
+	u8 rate_he_gi; /* cached HE GI, from mac_sta_poll() */
 
 	u16 idx;
 	u8 hw_key_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 93402d2c2538..c080b60327b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -657,7 +657,7 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			return false;
 
 		rate.flags = RATE_INFO_FLAGS_MCS;
-		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+		if (wcid->rate_short_gi)
 			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_VHT:
@@ -665,6 +665,8 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			return false;
 
 		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (wcid->rate_short_gi)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
@@ -673,7 +675,7 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		if (rate.mcs > 11)
 			return false;
 
-		rate.he_gi = wcid->rate.he_gi;
+		rate.he_gi = wcid->rate_he_gi;
 		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
 		rate.flags = RATE_INFO_FLAGS_HE_MCS;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2222fb9aa103..488faeb44e76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -202,12 +202,16 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 			u8 offs = 24 + 2 * bw;
 
 			rate->he_gi = (val & (0x3 << offs)) >> offs;
+			msta->wcid.rate_he_gi = rate->he_gi; /* cache for later */
 		} else if (rate->flags &
 			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
-			if (val & BIT(12 + bw))
+			if (val & BIT(12 + bw)) {
 				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
-			else
+				msta->wcid.rate_short_gi = 1;
+			} else {
 				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+				msta->wcid.rate_short_gi = 0;
+			}
 		}
 
 		/* get signal strength of resp frames (CTS/BA/ACK) */
@@ -2115,6 +2119,7 @@ mt7915_dfs_init_radar_specs(struct mt7915_phy *phy)
 		radar_specs = &jp_radar_specs;
 		break;
 	default:
+		WARN_ON_ONCE(true);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 867e14f6b93a..90e738126bf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -137,12 +137,17 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 			u8 offs = MT_WTBL_TXRX_RATE_G2_HE + 2 * bw;
 
 			rate->he_gi = (val & (0x3 << offs)) >> offs;
+			msta->wcid.rate_he_gi = rate->he_gi; /* cache for later */
 		} else if (rate->flags &
 			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
-			if (val & BIT(MT_WTBL_TXRX_RATE_G2 + bw))
+			if (val & BIT(MT_WTBL_TXRX_RATE_G2 + bw)) {
 				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
-			else
+				msta->wcid.rate_short_gi = 1;
+			}
+			else {
 				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+				msta->wcid.rate_short_gi = 0;
+			}
 		}
 
 		/* get signal strength of resp frames (CTS/BA/ACK) */
-- 
2.40.0

