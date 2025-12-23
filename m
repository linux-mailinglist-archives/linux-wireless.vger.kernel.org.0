Return-Path: <linux-wireless+bounces-30060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7CCD7F01
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A25302517F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974BE2C21FC;
	Tue, 23 Dec 2025 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uDZaHmDf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29B2C11E7
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459244; cv=none; b=ZgHeWTDxFQCfUZwSKfKY9KAo5iASaCSFO+NzQjlBsjUVnqQXlth7lY1kqnrG/ULo8n8ysTxKCnuCiA9bmNXW+2Z7PNiVdRKFX7uDf5ikWxF9m6zSznn4rvCaEWV59hGseCYTreBtDj0seQvmSZGuN4lYDyhEuTwnAfrBY2F4H4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459244; c=relaxed/simple;
	bh=Dp250U6HG8yPN4Xxgf97skxiyVpENplg2oejJiEkhz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGW0Lsxcn+BxGNTsJgUGxVXIimrDhTP47ofMmHzCZvjMtyffoOe3Gf3PhrQYAeUalHje2Ffu3XlgOnt9Kjc4EeqeYjOQhXOqAs8JGJeKUMPinFpRydQR9NCvKuo+ZYtIckphnxfXnORX4fU8+OahXzMwIH6fMrad7exrJ3wTBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uDZaHmDf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN37KFW0571166, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459240; bh=4d+PqML9qqqEn99XI6x2+sHQnoqFL8ffY6rAWeEf5uA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uDZaHmDfI1vle96/e0kS6quE7Soa3RSmUSScdKt95742cRff1DSZQcqm8oswIcjhJ
	 s96hkUnfk4lHEpvj0Z5GXeqoVGrMlrrPi9QyCmztWJoJFNtQq37m5QC7qGtwVboK7w
	 OARsUv1UP3xiTF0PhhD2Wh+1CRmEVspT44JHRvCIySr1sZT+U3ZME2aQh6mC9K9IVW
	 w9vELo7niwQ8E1UrnI/7Jij5YpXhSsPXkWTlYj4btQI/DCNL18fwzEnt8S4C8HiqoO
	 6ZavFdYE5u1gb+SpqL16A9bkHOrTLasyxnDR7gGIL8j9Hp+K3s1mgTEazrROPwF5lN
	 eZEPjaQ3/OPEg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN37KFW0571166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:07:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:07:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 03/12] wifi: rtw89: mlo: fix incorrect link address in management frames
Date: Tue, 23 Dec 2025 11:06:42 +0800
Message-ID: <20251223030651.480633-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223030651.480633-1-pkshih@realtek.com>
References: <20251223030651.480633-1-pkshih@realtek.com>
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
index 53d32f3137eb..d07dc97e22d4 100644
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
 	tx_req.with_wait = !!wait;
 
 	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
@@ -1387,8 +1388,7 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		}
 	}
 
-	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false,
-					NULL);
+	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, NULL);
 }
 
 static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
@@ -4093,8 +4093,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
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


