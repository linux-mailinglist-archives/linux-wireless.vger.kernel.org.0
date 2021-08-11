Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442FC3E9A88
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhHKVqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:46:07 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:58458 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232225AbhHKVpY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:24 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.172])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 414351A0077
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1699E14007C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 82DC313C2B1;
        Wed, 11 Aug 2021 14:44:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 82DC313C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718291;
        bh=ldM14Ycwtyxv79KbWuQDh+ryn/CEeFIE9HKWumFlZgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itmKQ5QmruxVMs7DHeSTiKMBOQ7wjHu+W7TdiRlwCmIIYUQeoCqLcxrqpOESIAkyD
         QxvjdAtG9UmRY7cEqqIdfdqorzARGW5158wO7S6NXOy45UI9YhmRyzY/bcL471hnIy
         elnPsRUeXLEeZvEkd0kT7Mo6XJWwEanI92gAnIqs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 09/15] mt76: mt7915:  fix rate rix and flags in txs path
Date:   Wed, 11 Aug 2021 14:44:33 -0700
Message-Id: <20210811214439.17458-10-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718292-5-GOIPQxFAH5
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Do not initialize rix to -1, build the rix and set flags
based on the mcs, nss, and mode.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 138059278ac0..7ca06b8c9671 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1541,8 +1541,6 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 	info->status.ampdu_ack_len = !!(info->flags &
 					IEEE80211_TX_STAT_ACK);
 
-	info->status.rates[0].idx = -1;
-
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
 
 	rate->mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
@@ -1575,6 +1573,7 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 
 		rate->mcs = mt76_get_rate(mphy->dev, sband, rate->mcs, cck);
 		rate->legacy = sband->bitrates[rate->mcs].bitrate;
+		info->status.rates[0].idx = rate->mcs;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
@@ -1585,6 +1584,8 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 		rate->flags = RATE_INFO_FLAGS_MCS;
 		if (wcid->rate_short_gi)
 			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+		info->status.rates[0].idx = rate->mcs + rate->nss * 8;
+		info->status.rates[0].flags |= IEEE80211_TX_RC_MCS;
 		break;
 	case MT_PHY_TYPE_VHT:
 		if (rate->mcs > 9)
@@ -1593,6 +1594,8 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 		rate->flags = RATE_INFO_FLAGS_VHT_MCS;
 		if (wcid->rate_short_gi)
 			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+		info->status.rates[0].idx = (rate->nss << 4) | rate->mcs;
+		info->status.rates[0].flags |= IEEE80211_TX_RC_VHT_MCS;
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
@@ -1604,6 +1607,7 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 		rate->he_gi = wcid->rate_he_gi;
 		rate->he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
 		rate->flags = RATE_INFO_FLAGS_HE_MCS;
+		info->status.rates[0].idx = (rate->nss << 4) | rate->mcs;
 		break;
 	default:
 		WARN_ON_ONCE(true);
-- 
2.20.1

