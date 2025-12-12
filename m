Return-Path: <linux-wireless+bounces-29690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F3CB7BAD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF2573005029
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781D7255248;
	Fri, 12 Dec 2025 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R//PYNl8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABC256C8D
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509234; cv=none; b=aqsGcj/w7sOCb11jy4Q7jrfUzV3VhSx32y3MgSGAJCbe8TLXanB9qYED6stE6hX5n0w2xGR1BmgphFH8B5TEzGvGYvBwqr+Va7LtLytwkZbBhSYwh+z/dzjD3+80Bt0gKGbDfIqkOwBgXuNmslE153TM5LEDmhNvz2BCrf4LYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509234; c=relaxed/simple;
	bh=2/uZ4pnk8haj9GbwZ/EDySEx8oT4SbiTiScxwGVbgZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2ECNGkmSlqNALcvBdcVIMF1lFPU4/Jvq9+0Fckn9llgQijUywup3Tn32QG8y+wN1fTzuoyAtpeoph3z3rf1BF5s5pT6SAI9MTsL5bvRtWwfk3srx0uIAQu6adjBTLoVPQRgW9CYZDRtdy7K/LwluNh9czuYINbCZp5/kw+NXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R//PYNl8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3DnTY23508117, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509229; bh=AwIdPO18O2aZ7tI9JtvEQ4KbOTJYfaWthAqUDBvbp4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R//PYNl8PdscXf8cBAXidXD4ZPxXZuN5q4aDOGry/Rtdkd2eSc+MIYYmSYPSGv/zu
	 gID10A3wTYslnPLGz76AXAtv9vfMRhzDvKd1sBJeJgHT6WY1Gaxd/UWcvL8KcmmTxp
	 7VvUmmbBKlNYSRE9XXr7m6302jexf+oc5f11RghBSgrek3ADCpJZm6OUE2PLueHbZw
	 u2GFBYgtq4ID5P7Gx3L/H8mfBKPLhDVooRg1qqWAavuLUQzgIGdis0yIESJCZQOkrg
	 EhX8cUgfmfbkiKSVPqWs92886HD95v6+3rbAPoRJXszNV1ThTUejEW+8jlarYtWmU2
	 BeJ3RB2m9WNIQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3DnTY23508117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:13:49 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:13:49 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 12 Dec 2025 11:13:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/12] wifi: rtw89: mlo: fix incorrect link address in management frames
Date: Fri, 12 Dec 2025 11:12:54 +0800
Message-ID: <20251212031303.19882-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

Deauth frames used wrong link address after switching from default link
to another, causing AP to reject subsequent auth frames. This affected
not only deauth but all management frames. Fixed by setting correct
mac_id to let header conversion references correct address CAM.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0824940c91ae..c2f940381db6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -548,7 +548,7 @@ rtw89_core_get_tx_type(struct rtw89_dev *rtwdev,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
 
-	if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_any_nullfunc(fc))
 		return RTW89_CORE_TX_TYPE_MGMT;
 
 	return RTW89_CORE_TX_TYPE_DATA;
@@ -833,6 +833,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 
 	desc_info->qsel = qsel;
 	desc_info->ch_dma = ch_dma;
+	desc_info->sw_mld = true;
 	desc_info->port = desc_info->hiq ? rtwvif_link->port : 0;
 	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
 	desc_info->hw_ssn_sel = RTW89_MGMT_HW_SSN_SEL;
@@ -1051,6 +1052,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	desc_info->ch_dma = ch_dma;
 	desc_info->tid_indicate = tid_indicate;
 	desc_info->qsel = qsel;
+	desc_info->sw_mld = false;
 	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
 	desc_info->port = desc_info->hiq ? rtwvif_link->port : 0;
 	desc_info->er_cap = rtwsta_link ? rtwsta_link->er_cap : false;
@@ -1326,7 +1328,7 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link,
-				    struct sk_buff *skb, int *qsel, bool sw_mld,
+				    struct sk_buff *skb, int *qsel,
 				    struct rtw89_tx_wait_info *wait)
 {
 	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
@@ -1341,7 +1343,6 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.sta = sta;
 	tx_req.rtwvif_link = rtwvif_link;
 	tx_req.rtwsta_link = rtwsta_link;
-	tx_req.desc_info.sw_mld = sw_mld;
 	rcu_assign_pointer(skb_data->wait, wait);
 
 	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
@@ -1385,8 +1386,7 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		}
 	}
 
-	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false,
-					NULL);
+	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, NULL);
 }
 
 static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
@@ -4091,8 +4091,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 		goto out;
 	}
 
-	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true,
-				       wait);
+	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, wait);
 	if (ret) {
 		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
 		dev_kfree_skb_any(skb);
-- 
2.25.1


