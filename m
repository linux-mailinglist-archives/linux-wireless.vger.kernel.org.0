Return-Path: <linux-wireless+bounces-30223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462BCCEBA34
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8285230B79A9
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6AD315D25;
	Wed, 31 Dec 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pDamIYVZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83477315D47
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172083; cv=none; b=Oc9IPeimu/+eWs/4kbC+4H9UvWlXEE6oHzsM1DYpEtbYmB0qCVDk/rzqUXVY9F3DseAI9Q4+QcRYPMrDqq+wUdGDArlcuAA02ZEITGflxM3bV5sD8lHYEosYrzluuz/LFZGwDPE6LDHda6znhGUVyj5zrhqgxQzUU7eqFAFX7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172083; c=relaxed/simple;
	bh=2Dar004hbnzyGMrjzuQW19JSXu75Xqg50UVOFCa8yoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBrniXKO2t0NE3U7d/OEWJgX2NEmUy+vUCedNutkXRCvHsIYHQALJclVDuqCnbTVc9PC8vwHZ0uboQSlysqmHpMIWgfSgvY6ixNSkEszLEiJc+ytSmngXZSkb6w5HwmTLw5FIvBqWYLMDslaWyeA/8C+ZLQ0l7y63fkUwypdT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pDamIYVZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97xcR6881275, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172079; bh=o7jCCwZVXeKfypoGUlr5lHg1ovR7vx7wtWLcIU2d/CY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pDamIYVZCjBAhzmK7D78VUc9Wahd+DS88oAdZnht1g8l3//2VLujp/2wPHOX5JrUc
	 nkvweaZunoVH7MVQFCqmOikUVgOmZItVruWno8HFmnebcBA4b62dUvAY6/QhsOkwHV
	 HXt0oZeVPM+0FYPlZRLUX81s9QlzzKlK7p8+3Pwpfj8ltp7wOCmBTDR7WeyUCqcW1A
	 FOs/ZfidB74hgVh3+6ys74jE7K7ARhVGhTLjS4UhfJTXghy6H9AGORHPS/xVdlVec8
	 /N6T9ZdXlXvdipgaZUovSz9sNMZPKSjZbb4Ju+3XwSaU7S01FeVXhux9xd6iMa3J6Q
	 kHCMpJdLdLnpw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97xcR6881275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:59 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:58 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/11] wifi: rtw89: fix potential zero beacon interval in beacon tracking
Date: Wed, 31 Dec 2025 17:06:46 +0800
Message-ID: <20251231090647.56407-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

During fuzz testing, it was discovered that bss_conf->beacon_int
might be zero, which could result in a division by zero error in
subsequent calculations. Set a default value of 100 TU if the
interval is zero to ensure stability.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 191caafbd0fb..6811a3970ddb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2813,7 +2813,7 @@ static void rtw89_core_bcn_track_assoc(struct rtw89_dev *rtwdev,
 
 	rcu_read_lock();
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
-	beacon_int = bss_conf->beacon_int;
+	beacon_int = bss_conf->beacon_int ?: 100;
 	dtim = bss_conf->dtim_period;
 	rcu_read_unlock();
 
@@ -2843,9 +2843,7 @@ static void rtw89_core_bcn_track_reset(struct rtw89_dev *rtwdev)
 	memset(&rtwdev->bcn_track, 0, sizeof(rtwdev->bcn_track));
 }
 
-static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
-				  struct ieee80211_bss_conf *bss_conf,
-				  struct sk_buff *skb)
+static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
 #define RTW89_APPEND_TSF_2GHZ 384
 #define RTW89_APPEND_TSF_5GHZ 52
@@ -2854,7 +2852,7 @@ static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
 	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
-	u32 bcn_intvl_us = ieee80211_tu_to_usec(bss_conf->beacon_int);
+	u32 bcn_intvl_us = ieee80211_tu_to_usec(bcn_track->beacon_int);
 	u64 tsf = le64_to_cpu(mgmt->u.beacon.timestamp);
 	u8 wp, num = bcn_stat->num;
 	u16 append;
@@ -2862,6 +2860,10 @@ static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
 	if (!RTW89_CHK_FW_FEATURE(BEACON_TRACKING, &rtwdev->fw))
 		return;
 
+	/* Skip if not yet associated */
+	if (!bcn_intvl_us)
+		return;
+
 	switch (rx_status->band) {
 	default:
 	case NL80211_BAND_2GHZ:
@@ -2949,7 +2951,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		pkt_stat->beacon_rate = desc_info->data_rate;
 		pkt_stat->beacon_len = skb->len;
 
-		rtw89_vif_rx_bcn_stat(rtwdev, bss_conf, skb);
+		rtw89_vif_rx_bcn_stat(rtwdev, skb);
 	}
 
 	if (!ether_addr_equal(bss_conf->addr, hdr->addr1))
-- 
2.25.1


