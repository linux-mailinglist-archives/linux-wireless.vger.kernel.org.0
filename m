Return-Path: <linux-wireless+bounces-23930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A9AD3886
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535B216243B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7F2E3378;
	Tue, 10 Jun 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZursJl8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA152E336C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560474; cv=none; b=O67UR8vAkDWr72sDWH84ZwhOlUe+CvZXowDVxVuQrNYlhsWPfaEDa+mWvIyM3bSe70X0yAHv+ezRW00GJk701fSZTuVcojyY8F0loosEw0w67n88w2mE0X62Ch+M1QeVoL85v6x68yGuVzeQdJqsEQGg2DQGOr6/DjjfNZ+ihq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560474; c=relaxed/simple;
	bh=dhn4aqnkuvfw9Ryunc1MnG6u5aq+/NZ5Xv5JPzDbbOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6//8rxPo4qyfkFDz9Mh1suEqt24yIpgCbYaz6EF3G5TGAN1wMz9sYk+FExHfO/hLd2WhBtK8oWeeonSdMLkV4u1Qu/UjSl9mqv5HpwefMuelq5+L0Eaav4bBsrOJv82W+fDwDB1wcYA4vf5YYcWNEB7bF2IuomEeAjUbpt9abc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZursJl8I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1AiwC2995448, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560470; bh=NwE1x8jaelIei5spAXnFPskV9KCTUJqtJrPVo+uSadw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZursJl8I8EVHaZHrheKnidEU6dZQbaO19x19VMSjPqQq2LT2K5Wplj+/fSQ6USIVg
	 hGdiL5lUcZ9H7gWwSjR6mbhEfB+1Q+JzKJ+DbpaS30jyWg6Qb7FNKJF197nSxtYcjc
	 ByTEwHdSs1q1TV0FY5LzbT/eTvzXU/8FyAXIb4iIhxuVqsTzlpw/ff89GHc4dXsGDX
	 vBS8N9fqOPIAoubvIFd2SjtlayTGCLJiJFgiDP3pueh4LPWD94ZgEaGfkbVQheOJ95
	 LuK00/jLumpjB7JivYj3zr1ZYcxM9EQqIhz2Mx/tnmurrHIt3+1DF1PcInltRBUKXk
	 rnDqwJPENHNug==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1AiwC2995448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:11 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/12] wifi: rtw89: mcc: correct frequency when MCC
Date: Tue, 10 Jun 2025 21:00:25 +0800
Message-ID: <20250610130034.14692-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

The frequency get from PPDU status set as center channel during MCC,
but we need to report to mac80211 as primary channel. Therefore, we
use the chanctx information in software to instead it.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0a4c420000b8..4252717b1584 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2478,6 +2478,41 @@ static void rtw89_core_update_rx_freq_from_ie(struct rtw89_dev *rtwdev,
 	rx_status->freq = ieee80211_channel_to_frequency(chan, rx_status->band);
 }
 
+static void rtw89_core_correct_mcc_chan(struct rtw89_dev *rtwdev,
+					struct rtw89_rx_desc_info *desc_info,
+					struct ieee80211_rx_status *rx_status,
+					struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_sta_link *rtwsta_link;
+	const struct rtw89_chan *chan;
+	u8 mac_id = desc_info->mac_id;
+	enum rtw89_entity_mode mode;
+	enum nl80211_band band;
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	if (likely(mode != RTW89_ENTITY_MODE_MCC))
+		return;
+
+	if (chip_gen == RTW89_CHIP_BE && phy_ppdu)
+		mac_id = phy_ppdu->mac_id;
+
+	rcu_read_lock();
+
+	rtwsta_link = rtw89_assoc_link_rcu_dereference(rtwdev, mac_id);
+	if (!rtwsta_link)
+		goto out;
+
+	rtwvif_link = rtwsta_link->rtwvif_link;
+	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	band = rtw89_hw_to_nl80211_band(chan->band_type);
+	rx_status->freq = ieee80211_channel_to_frequency(chan->primary_channel, band);
+
+out:
+	rcu_read_unlock();
+}
+
 static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 				      struct rtw89_rx_phy_ppdu *phy_ppdu,
 				      struct rtw89_rx_desc_info *desc_info,
@@ -2496,6 +2531,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status);
 	rtw89_core_validate_rx_signal(rx_status);
 	rtw89_core_update_rx_freq_from_ie(rtwdev, skb_ppdu, rx_status);
+	rtw89_core_correct_mcc_chan(rtwdev, desc_info, rx_status, phy_ppdu);
 
 	/* In low power mode, it does RX in thread context. */
 	local_bh_disable();
-- 
2.25.1


