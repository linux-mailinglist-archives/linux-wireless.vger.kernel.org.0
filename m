Return-Path: <linux-wireless+bounces-10561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35D93DDC9
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC511F21AAF
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2E18641;
	Sat, 27 Jul 2024 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cMJOl0bG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039137144
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067658; cv=none; b=tgvMQD9TSoctZmFmiC7QGatWaBkGJEnKC8ig+mkSwlqcnEwtv4CriF6mNCtDTa7K96iXmuobxvB5lLRK5ibxavll3Z7u1bWIKfUbmsCjlX9e3USzFkR3VLCmQSd3A3OHBBXAY5AaVRVRRVpPOB7NBq/ofBPGRp5LADTmeSueuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067658; c=relaxed/simple;
	bh=93MYfP3Cmj+sYUQr3L97ESrg2i+2f6TTVJRrqprXWLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIVNd3esp8DsD6Q+xUFgnQnTDi8TZV3D8yBxRlbWnWjVa+na/VeqBs1isNlHvfgfMIZeYlWHiahsyF15s0jBhIeRAHVhKb0eKNedm7AVOHgCkkOOyXR23h3REScFXiNPNcJTGjRXnCvy1j3mW7sYjTdIOQjhZEFamWM3iiZd6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cMJOl0bG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R87YppC1417439, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067654; bh=93MYfP3Cmj+sYUQr3L97ESrg2i+2f6TTVJRrqprXWLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cMJOl0bGb5LmVnk9m2a0PDg2Wvl2ZbJVNXVKmrr9rLEHOQqrc2ot4wxO014E7pugN
	 ELQ4ksEfeXGeGtXzahleZ654XCrWrujfdx9IuxB72huJkX2gSB06IdFnrPQSU/2dKs
	 fkJ0CaXHzw1SL3JgrswsBGjhJkk0osTnJsd1RfJf9sBY6CrZZkvvsE2CVqjH+LQunn
	 UPKIjmtmJOxQLokbmAriuoUZlA6rK5ikI6BMMPCCHuBhhWGe/qrwA3jLYlP6jcif3o
	 Z5UWxZMXRrNri371/PDR3nq996GU1G0pRnc37pPGVUYQEFrJay64utiQzxNpjdmqvx
	 3LU1NN5twl2nQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R87YppC1417439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:33 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 6/7] wifi: rtw89: fw: correct chan access in assoc_cmac_tbl_g7 and update_beacon_be
Date: Sat, 27 Jul 2024 16:06:49 +0800
Message-ID: <20240727080650.12195-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240727080650.12195-1-pkshih@realtek.com>
References: <20240727080650.12195-1-pkshih@realtek.com>
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

Originally, these H2C commands access chan with hard-code RTW89_CHANCTX_0.
They are problematic when the chip supports multiple channels. So, correct
them by accessing right chan under rtwvif.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1db32418e912..b9bf9ae3a512 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2947,9 +2947,9 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
 	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
 	u8 pads[RTW89_PPE_BW_NUM];
@@ -3289,7 +3289,7 @@ EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon);
 int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct rtw89_h2c_bcn_upd_be *h2c;
 	struct sk_buff *skb_beacon;
-- 
2.25.1


