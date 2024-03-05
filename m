Return-Path: <linux-wireless+bounces-4360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78108711EF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 01:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3AD1F23D07
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 00:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF8C5382;
	Tue,  5 Mar 2024 00:46:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477E3210
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599571; cv=none; b=aCjUjVwQutKRsvdoctpP3EzJvgbSqECaXrEP0SdCxpF5pNgCw+lNUYe1fPk/xtZewq2EGn4fL1wOK5r4Bx1+eGdMJtvInLu/aP2Y73uqDVm+HFXgrEJshRNyzFNuAqIlAdaRreGZvrNGAajATa0Vi7mVc5IM6N/7JUyDnkxf3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599571; c=relaxed/simple;
	bh=tc4AEy7B6Rc7D0EIqf8rS6hLAXDvBZgYg2BpiuuTMJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iN8i2pfseyD5KKx0i7LnbrX8r/f63U0IrMne1EP+1rRZ4xxW44cQHk6l+ioJ3tMIACOzAkYYboUzFLQNeZnxt10JSZJcUGUpmgZk/YxL2Tz5ja6bKuUZU2PTGqp8cLwAwBwsYWFu4mO5nFsRJ1RLrxKB1G61l3xV1qp3dMjtWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4250jsSfB3909755, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4250jsSfB3909755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Mar 2024 08:45:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 08:45:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 08:45:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <dian_syuan0116@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: Correct EHT TX rate on 20MHz connection
Date: Tue, 5 Mar 2024 08:45:02 +0800
Message-ID: <20240305004502.6655-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

We used EHT capability of 20MHz-only as rate mask to RA (rate adaptive)
H2C command when connecting with AP set EHT 20MHz. It would get the
wrong rate mask and the MCS rate can only reach MCS11.

According to the description of 802.11be spec, if all supported channel
bandwidth field of HE PHY capabilities are zero, then the EHT capability
of 20MHz-only is valid. As a result, we adjust the code to set correct
rate mask based on HE PHY bandwidth capability.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 12da63d64307..eaa18140d1a8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -122,6 +122,7 @@ static u64 get_eht_ra_mask(struct ieee80211_sta *sta)
 	struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
 	struct ieee80211_eht_mcs_nss_supp_20mhz_only *mcs_nss_20mhz;
 	struct ieee80211_eht_mcs_nss_supp_bw *mcs_nss;
+	u8 *he_phy_cap = sta->deflink.he_cap.he_cap_elem.phy_cap_info;
 
 	switch (sta->deflink.bandwidth) {
 	case IEEE80211_STA_RX_BW_320:
@@ -132,15 +133,19 @@ static u64 get_eht_ra_mask(struct ieee80211_sta *sta)
 		mcs_nss = &eht_cap->eht_mcs_nss_supp.bw._160;
 		/* MCS 9, 11, 13 */
 		return get_eht_mcs_ra_mask(mcs_nss->rx_tx_max_nss, 9, 3);
+	case IEEE80211_STA_RX_BW_20:
+		if (!(he_phy_cap[0] &
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
+			mcs_nss_20mhz = &eht_cap->eht_mcs_nss_supp.only_20mhz;
+			/* MCS 7, 9, 11, 13 */
+			return get_eht_mcs_ra_mask(mcs_nss_20mhz->rx_tx_max_nss, 7, 4);
+		}
+		fallthrough;
 	case IEEE80211_STA_RX_BW_80:
 	default:
 		mcs_nss = &eht_cap->eht_mcs_nss_supp.bw._80;
 		/* MCS 9, 11, 13 */
 		return get_eht_mcs_ra_mask(mcs_nss->rx_tx_max_nss, 9, 3);
-	case IEEE80211_STA_RX_BW_20:
-		mcs_nss_20mhz = &eht_cap->eht_mcs_nss_supp.only_20mhz;
-		/* MCS 7, 9, 11, 13 */
-		return get_eht_mcs_ra_mask(mcs_nss_20mhz->rx_tx_max_nss, 7, 4);
 	}
 }
 
-- 
2.25.1


