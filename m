Return-Path: <linux-wireless+bounces-22139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA37A9EF0A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42883A83F2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093C262FF9;
	Mon, 28 Apr 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UiVn8TA3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784325E800
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839566; cv=none; b=pTCi7xkQ/GU2Onw0WU4jfH9voDTrNR1unUOpxs1k7LF+bv2VYGhK6DNzv1qg4IQiXLz4nqLrBUcNmzac0kZOKZToQxTxpestcUM2VbPoYdO3gxYTXi/HFZ/0vPwpKU6KVAN9+1rmBN8+hCbrpRmF8KfUVhpGp8v9gkmdY1TsWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839566; c=relaxed/simple;
	bh=SqXqYaNBd0LnvRjJYXhR4fnO8XAtREFo4OlrnRbWfvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzgohG2/80LmTGumE4lFw+fooT6w8Ov30s09yYymOu5GGRILnC4Nwt0MzUt3KiujfMWynUDpMTeMoSshVp9oCJLcNL6EQvrrVFVgT/T3Q0JDLTfd35JXs6OJASyV1sCMSU2bSrfzI4elhBhsLzz14J+knxV1xJfIlHK2vpEO2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UiVn8TA3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBQ2WA02101280, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839562; bh=SqXqYaNBd0LnvRjJYXhR4fnO8XAtREFo4OlrnRbWfvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UiVn8TA3AO5mHWosVyHCzryDYjeBSS2gMh3bxtg2e3mLkrAbmXAn2x7jk4wtVH5cS
	 LSoA7XBOwD4NZxa5J03a0MFI6zXO+NHiC1L/c4cNzlPSFHvkn0H2AxemichePv2GLD
	 f+KRrwmblQFRAw6Y8LnDhgfKZdrnUesebYRo288MzZSLnsrsDpTYWgoKCwSEyaia9u
	 83YUmNqC1hg/enJBFhiTmaVKF0xdpfNHTI7u4mSoMNxcIEjs5KRPkm05BwYJnGXppZ
	 +j1ECEbVg89KS0oZm7MS8REoa32fYCqXDsaKoWmvKMJGsIGF7b+EwcFXruoZV81UK2
	 gaiiVhU9MSnKw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBQ2WA02101280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:26:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:26:02 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:26:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/10] wifi: rtw89: roc: dynamically handle link id and link instance index
Date: Mon, 28 Apr 2025 19:24:55 +0800
Message-ID: <20250428112456.13165-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, a macro, RTW89_ROC_BY_LINK_INDEX, is used to decide the link
which deals with the ROC process. Before enabling MLO support, it's fine
to hard-code RTW89_ROC_BY_LINK_INDEX as 0 since the link instance-0 (on
HW-0) is always active. But, for the impending enablement of MLO support,
tweak the leaf functions to dynamically handle ROC link instance index.

Besides, in the follow-up, ROC caller will get a designated link and will
then drop RTW89_ROC_BY_LINK_INDEX.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 11 ++++++-----
 drivers/net/wireless/realtek/rtw89/chan.h |  2 +-
 drivers/net/wireless/realtek/rtw89/core.c | 12 +++++++-----
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 355e582ecd19..6d17456046d5 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -189,9 +189,10 @@ void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
-			      enum rtw89_chanctx_idx idx,
+			      struct rtw89_vif_link *rtwvif_link,
 			      const struct cfg80211_chan_def *chandef)
 {
+	enum rtw89_chanctx_idx idx = rtwvif_link->chanctx_idx;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_chanctx_idx cur;
 
@@ -205,6 +206,7 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 		}
 
 		hal->roc_chandef = *chandef;
+		hal->roc_link_index = rtw89_vif_link_inst_get_index(rtwvif_link);
 	} else {
 		cur = atomic_cmpxchg(&hal->roc_chanctx_idx, idx,
 				     RTW89_CHANCTX_IDLE);
@@ -339,11 +341,10 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 
 	roc_idx = atomic_read(&hal->roc_chanctx_idx);
 	if (roc_idx != RTW89_CHANCTX_IDLE) {
-		/* ROC is ongoing (given ROC runs on RTW89_ROC_BY_LINK_INDEX).
-		 * If @link_index is the same as RTW89_ROC_BY_LINK_INDEX, get
-		 * the ongoing ROC chanctx.
+		/* ROC is ongoing (given ROC runs on @hal->roc_link_index).
+		 * If @link_index is the same, get the ongoing ROC chanctx.
 		 */
-		if (link_index == RTW89_ROC_BY_LINK_INDEX)
+		if (link_index == hal->roc_link_index)
 			chanctx_idx = roc_idx;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 1bcb87a8f9ee..b42e044d7927 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -103,7 +103,7 @@ void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 				 enum rtw89_chanctx_idx idx,
 				 const struct cfg80211_chan_def *chandef);
 void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
-			      enum rtw89_chanctx_idx idx,
+			      struct rtw89_vif_link *rtwvif_link,
 			      const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c718dd83dc1e..268107b1e039 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3379,6 +3379,8 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		return;
 	}
 
+	roc->link_id = rtwvif_link->link_id;
+
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_ROC);
 
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, true);
@@ -3399,7 +3401,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	}
 
 	cfg80211_chandef_create(&roc_chan, &roc->chan, NL80211_CHAN_NO_HT);
-	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, &roc_chan);
+	rtw89_config_roc_chandef(rtwdev, rtwvif_link, &roc_chan);
 	rtw89_set_channel(rtwdev);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
@@ -3428,10 +3430,10 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, RTW89_ROC_BY_LINK_INDEX);
+	rtwvif_link = rtwvif->links[roc->link_id];
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "roc end: find no link on HW-%u\n",
-			  RTW89_ROC_BY_LINK_INDEX);
+		rtw89_err(rtwdev, "roc end: find no link (link id %u)\n",
+			  roc->link_id);
 		return;
 	}
 
@@ -3439,7 +3441,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
 
 	roc->state = RTW89_ROC_IDLE;
-	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, NULL);
+	rtw89_config_roc_chandef(rtwdev, rtwvif_link, NULL);
 	rtw89_chanctx_proceed(rtwdev, NULL);
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, false);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ce5521c413a1..5e4b096f42fc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3454,6 +3454,7 @@ struct rtw89_roc {
 	enum ieee80211_roc_type type;
 	enum rtw89_roc_state state;
 	int duration;
+	unsigned int link_id;
 };
 
 #define RTW89_P2P_MAX_NOA_NUM 2
@@ -4851,6 +4852,7 @@ struct rtw89_hal {
 	bool no_mcs_12_13;
 
 	atomic_t roc_chanctx_idx;
+	u8 roc_link_index;
 
 	DECLARE_BITMAP(changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_CHANCTX);
-- 
2.25.1


