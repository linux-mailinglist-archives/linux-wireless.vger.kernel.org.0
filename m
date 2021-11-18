Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E284560C4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhKRQof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:44:35 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:34642 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233602AbhKRQoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:34 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.123])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 15BFB1A0073
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:33 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E8F534C007F
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:32 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 9B47413C2B7;
        Thu, 18 Nov 2021 08:41:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9B47413C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253666;
        bh=yKh80QtA4plnkl7Ai90G08J/zd3CMMJVcK/qpOhqx2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVq095CDieuIfgR20cCtSplL6kYha0YmrqwdpW+OlbLQga5wH4PdSQ/J9C9/wfNkP
         6thXnBBbIYm38IBcqCIrFCD3qOo2oxfhVo5+L53qrTFMPAuZ3DWkKCKgsKVob7qOOx
         2XYibQYyilcUp8/Wj+kCMS2VhwybjGMqm2e6JQRQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 07/11] mt76: mt7915: fix rate rix and flags in txs path
Date:   Thu, 18 Nov 2021 08:40:52 -0800
Message-Id: <20211118164056.2965-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253693-ZwczBQ77i1NC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Do not initialize rix to -1, build the rix and set flags
based on the mcs, nss, and mode.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index edf33540658e..300928edd0d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1571,7 +1571,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_phy *mphy;
-	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_info *info = NULL;
 	struct sk_buff_head list;
 	struct rate_info rate = {};
 	struct sk_buff *skb = NULL;
@@ -1596,8 +1596,6 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		info->status.ampdu_len = 1;
 		info->status.ampdu_ack_len = !!(info->flags &
 						IEEE80211_TX_STAT_ACK);
-
-		info->status.rates[0].idx = -1;
 	}
 
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
@@ -1627,6 +1625,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
 		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		if (info)
+			info->status.rates[0].idx = rate.mcs;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
@@ -1637,6 +1637,10 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		rate.flags = RATE_INFO_FLAGS_MCS;
 		if (wcid->rate_short_gi)
 			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		if (info) {
+			info->status.rates[0].idx = rate.mcs + rate.nss * 8;
+			info->status.rates[0].flags |= IEEE80211_TX_RC_MCS;
+		}
 		break;
 	case MT_PHY_TYPE_VHT:
 		if (rate.mcs > 9)
@@ -1645,6 +1649,10 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
 		if (wcid->rate_short_gi)
 			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		if (info) {
+			info->status.rates[0].idx = (rate.nss << 4) | rate.mcs;
+			info->status.rates[0].flags |= IEEE80211_TX_RC_VHT_MCS;
+		}
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
@@ -1656,6 +1664,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		rate.he_gi = wcid->rate_he_gi;
 		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
 		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		if (info)
+			info->status.rates[0].idx = (rate.nss << 4) | rate.mcs;
 		break;
 	default:
 		WARN_ON_ONCE(true);
-- 
2.20.1

