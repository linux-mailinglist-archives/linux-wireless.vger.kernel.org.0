Return-Path: <linux-wireless+bounces-16927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F49FEBF7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 01:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF917A1630
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5F747F;
	Tue, 31 Dec 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t5xDT+Iy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433F33F3
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735606143; cv=none; b=KiVMrScMvL0sq10njEEf/jzxOJIcKirrQEYfSE0QM0U2KmKK/TwBaeLkOhu3SWi+q7biqp1i4QgajsPzGU9uMNiQo5t47MTxWhpcn7At+rZfjeFvjR0fiFRrjmAJcf5LPpp1xyzBNJDEsvODg2t/ZgQmh15frsWAS2a5T7ePEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735606143; c=relaxed/simple;
	bh=Nh1Ton1O/+S+9x7PaSTaueskNUH/EVTz2l3O5obvz98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/hEdgnxrPlXRiq2GdPROLHmDd1uxdovY0B8lsA/xEq77WEsAfMBvlbO5Dgwcz33r8oubOwcVtdCJTvZFR18ghwpR1MlwC8lMKT5Q6L4WgiwJy+0FDelPxLn5V/8Iqq20VCE4q5ISYcsOFup/EPNPpIIqx3xQSPinuARPdxeKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t5xDT+Iy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BV0mwpgF791456, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735606138; bh=Nh1Ton1O/+S+9x7PaSTaueskNUH/EVTz2l3O5obvz98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=t5xDT+IyFSYIS9XB8kR2HnFSopfWL6FeKNZXY4BYRhP+GsaaPUzBUqrDF7uFaxeMz
	 M9er8mpDmCK1rrvDjofhmMcWhe3NvawneUWm1n/RjnRL098wy7qr0ZDGc5CifrT0R9
	 DecrlI2CVQQDXr/Y9eP87vuyTm6RERxVMf4vgLYa4fwc0Z8t001XmuAzTOI2/l5xWK
	 iELA2OmDs5OfD70bH9HN2/9tc+J9fa8W3zYiHj0m/ynfTFkq1fCDA+EASFGZdD9VvY
	 TDjlH0OeNmwRt1YLZTaronRDI71dTf4iblyDMqtR4N3Z7XUAWC0z74xQvGolX/d3vM
	 u2AIPy39KL0jA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BV0mwpgF791456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 08:48:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 31 Dec 2024 08:48:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 31 Dec
 2024 08:48:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 3/3] wifi: rtw89: correct header conversion rule for MLO only
Date: Tue, 31 Dec 2024 08:48:10 +0800
Message-ID: <20241231004811.8646-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241231004811.8646-1-pkshih@realtek.com>
References: <20241231004811.8646-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Header conversion should only be used with MLO connections. Otherwise
P2P connection fails due to wrong probe responses sent. Fix it
accordingly.

Fixes: b8499664fca9 ("wifi: rtw89: Add header conversion for MLO connections")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 9 ++++++++-
 drivers/net/wireless/realtek/rtw89/core.h | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bb4621d38658..74bf590ad88c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -980,6 +980,11 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	bool is_bmc;
 	u16 seq;
 
+	if (tx_req->sta)
+		desc_info->mlo = tx_req->sta->mlo;
+	else if (tx_req->vif)
+		desc_info->mlo = ieee80211_vif_is_mld(tx_req->vif);
+
 	seq = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
 	if (tx_req->tx_type != RTW89_CORE_TX_TYPE_FWCMD) {
 		tx_type = rtw89_core_get_tx_type(rtwdev, skb);
@@ -987,7 +992,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 
 		addr_cam = rtw89_get_addr_cam_of(tx_req->rtwvif_link,
 						 tx_req->rtwsta_link);
-		if (addr_cam->valid)
+		if (addr_cam->valid && desc_info->mlo)
 			upd_wlan_hdr = true;
 	}
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
@@ -1127,6 +1132,8 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	}
 
 	tx_req.skb = skb;
+	tx_req.vif = vif;
+	tx_req.sta = sta;
 	tx_req.rtwvif_link = rtwvif_link;
 	tx_req.rtwsta_link = rtwsta_link;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 37722a0b6a8b..77af3cf3019a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1170,12 +1170,15 @@ struct rtw89_tx_desc_info {
 	bool stbc;
 	bool ldpc;
 	bool upd_wlan_hdr;
+	bool mlo;
 };
 
 struct rtw89_core_tx_request {
 	enum rtw89_core_tx_type tx_type;
 
 	struct sk_buff *skb;
+	struct ieee80211_vif *vif;
+	struct ieee80211_sta *sta;
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_sta_link *rtwsta_link;
 	struct rtw89_tx_desc_info desc_info;
-- 
2.25.1


