Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A658357B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiG0XBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CDF21812
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:43 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.137])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 76D0C1C008B;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3D0C114007D;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id F146313C2B0;
        Wed, 27 Jul 2022 16:01:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F146313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962901;
        bh=hz1HcD4sEsCfZlC/PH46frSa+cB/cA0ypTpyYL/iyEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7FI5Fa2wZryMZ+O/FJLeKy360m0kcq8rSZRKl4P4MMfSO2m7mCfRFtJsnx89yjqP
         dQ07pECmykxMdT/rNUNKdM72AB6Fc34MOVOA2JHT7BvxutPajizmFIksYu+ghRUbyq
         OnxAh6c5VPWH4CaEHtIdBJdz8yZT6ShFd6HnDmKk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 11/12] wifi: mt76: mt7915: add ethtool tx/rx pkts/bytes
Date:   Wed, 27 Jul 2022 16:01:21 -0700
Message-Id: <20220727230122.29842-11-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962901-cBGrn1bwIROp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

These stats are provided with same name by ath10k
and some intel wired NIC drivers.  Add them to mt7915
as well to allow user-space code to more easily get some
basic stats out of the radio.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  7 +++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 408121c4260f..afd480dd255b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -921,6 +921,9 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
 		mt7915_mac_decode_he_radiotap(skb, rxv, mode);
 
+	mib->rx_pkts_nic++;
+	mib->rx_bytes_nic += skb->len;
+
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
@@ -1584,6 +1587,8 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	u16 wcid_idx;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_tx_rate *rate;
+	struct mt7915_phy *phy = &dev->phy;
+	struct mib_stats *mib = &phy->mib;
 
 	mt7915_txp_skb_unmap(mdev, t);
 	if (!t->skb)
@@ -1675,6 +1680,8 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	/* Apply the values that this txfree path reports */
 	rate->count = tx_cnt;
 	if (tx_status == 0) {
+		mib->tx_pkts_nic++;
+		mib->tx_bytes_nic += t->skb->len;
 		info->flags |= IEEE80211_TX_STAT_ACK;
 		info->status.ampdu_ack_len = 1;
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b99a667ff251..f2e215468a38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1094,6 +1094,10 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 }
 
 static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_pkts_nic", /* from driver, phy tx-ok skb */
+	"tx_bytes_nic", /* from driver, phy tx-ok bytes */
+	"rx_pkts_nic", /* from driver, phy rx OK skb */
+	"rx_bytes_nic", /* from driver, phy rx OK bytes */
 	"tx_ampdu_cnt",
 	"tx_stop_q_empty_cnt",
 	"tx_mpdu_attempts",
@@ -1275,6 +1279,13 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 
 	mt7915_mac_update_stats(phy);
 
+	/* driver phy-wide stats */
+	data[ei++] = mib->tx_pkts_nic;
+	data[ei++] = mib->tx_bytes_nic;
+	data[ei++] = mib->rx_pkts_nic;
+	data[ei++] = mib->rx_bytes_nic;
+
+	/* MIB stats from FW/HW */
 	data[ei++] = mib->tx_ampdu_cnt;
 	data[ei++] = mib->tx_stop_q_empty_cnt;
 	data[ei++] = mib->tx_mpdu_attempts_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c5401e6e3cda..c0bb87bf2a2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -166,6 +166,13 @@ struct mt7915_vif {
 
 /* per-phy stats.  */
 struct mib_stats {
+	/* phy wide driver stats */
+	u32 tx_pkts_nic; /* tx OK skb */
+	u32 tx_bytes_nic; /* tx OK bytes */
+	u32 rx_pkts_nic; /* rx OK skb */
+	u32 rx_bytes_nic; /* rx OK bytes */
+
+	/* MIB counters from FW/HW */
 	u32 ack_fail_cnt;
 	u32 fcs_err_cnt;
 	u32 rts_cnt;
-- 
2.20.1

