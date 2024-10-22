Return-Path: <linux-wireless+bounces-14295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0799A9CA7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAD31C23BCA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9F814EC4E;
	Tue, 22 Oct 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mDa4MV6w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088115539D
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585900; cv=none; b=rtNZegt8eDIGbEQwOxlq2reM88X+1qi5/scsiCFeO2eI93/H5fCLzWpH+h99mel05yYDUgyyr8GPSCzUR6x/5FuSDIqeKvnxLbENUtLTnlClH73ifch1np0dwBROk8UQ9/SXffrq5AN8e7csUQkUpdXFgKcgSMvRPsRRC5fkWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585900; c=relaxed/simple;
	bh=zz0iyfV7QtVME38mFi3AYY8bjPVRiOk6AkqITuLdrkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXR2Am4rtzbAozQ7XLv9SlN2leaASDIpcfX1RE+9QclLP8f+K2muHfqlmQwJ+Ja/j2e83WO4NrJUpjPdvK2LpXhN4dXMHWdU6p/JlQYwVtvI1qRuzo91zcLFv7Dtru3LQP05dMaD3Ndq6NDpb24JMSysL9HJm3Xkg/HIf87Dkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mDa4MV6w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M8VYJu83771821, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729585894; bh=zz0iyfV7QtVME38mFi3AYY8bjPVRiOk6AkqITuLdrkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mDa4MV6wBp697s4+vx5wD3bMQ7XH5ZknPtmlOLfHKtze8r0YGZX7KOcXgAyowaiYO
	 wwt3JZ/71wxdyC0ejy4A1QhFIi3SEA9da3YhW47AofnYqD17GIQaQOwK1TIRF75rj+
	 O9M2G/aY3wE39DMkyWbPsWfE+/LsWVemRBxJdudZaU52kO1Zh526EYH3aYLqCHJfjg
	 NRJ8ZSFlmzlqJuIFNsLT8tWCZg16u6t7Z16/TAn4h0/4dNnw/rjOB0N+FWXECVVuAI
	 l3d9gNJqJspffWWs+bEev3YVx6sQMdLtjUlo+pcKgVRkzd0vd5lJN4vDwYoltmhmch
	 WBoqVDipwBPRw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M8VYJu83771821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 16:31:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 16:31:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Oct
 2024 16:31:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 1/5] wifi: rtw89: Add header conversion for MLO connections
Date: Tue, 22 Oct 2024 16:31:02 +0800
Message-ID: <20241022083106.149252-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022083106.149252-1-pkshih@realtek.com>
References: <20241022083106.149252-1-pkshih@realtek.com>
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

For MLO connections, this setting replaces 802.11 header addresses
to according link addresses based on each packet's destination.
The fields most likely to be replaced would be both A1 and A2.
For legacy connections, it's the same with or without the conversion.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 16 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bba5bde95bb4..3317f9b8a705 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -939,8 +939,10 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct rtw89_addr_cam_entry *addr_cam;
 	enum rtw89_core_tx_type tx_type;
 	enum btc_pkt_type pkt_type;
+	bool upd_wlan_hdr = false;
 	bool is_bmc;
 	u16 seq;
 
@@ -948,6 +950,11 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	if (tx_req->tx_type != RTW89_CORE_TX_TYPE_FWCMD) {
 		tx_type = rtw89_core_get_tx_type(rtwdev, skb);
 		tx_req->tx_type = tx_type;
+
+		addr_cam = rtw89_get_addr_cam_of(tx_req->rtwvif_link,
+						 tx_req->rtwsta_link);
+		if (addr_cam->valid)
+			upd_wlan_hdr = true;
 	}
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
 		  is_multicast_ether_addr(hdr->addr1));
@@ -957,6 +964,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	desc_info->is_bmc = is_bmc;
 	desc_info->wd_page = true;
 	desc_info->hiq = info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM;
+	desc_info->upd_wlan_hdr = upd_wlan_hdr;
 
 	switch (tx_req->tx_type) {
 	case RTW89_CORE_TX_TYPE_MGMT:
@@ -1355,6 +1363,13 @@ static __le32 rtw89_build_txwd_body5_v2(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_body6_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY6_UPD_WLAN_HDR, desc_info->upd_wlan_hdr);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_body7_v2(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(BE_TXD_BODY7_USERATE_SEL, desc_info->use_rate) |
@@ -1418,6 +1433,7 @@ void rtw89_core_fill_txdesc_v2(struct rtw89_dev *rtwdev,
 		txwd_body->dword4 = rtw89_build_txwd_body4_v2(desc_info);
 		txwd_body->dword5 = rtw89_build_txwd_body5_v2(desc_info);
 	}
+	txwd_body->dword6 = rtw89_build_txwd_body6_v2(desc_info);
 	txwd_body->dword7 = rtw89_build_txwd_body7_v2(desc_info);
 
 	if (!desc_info->en_wd_info)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 171711d6eac9..4366b581c56b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1162,6 +1162,7 @@ struct rtw89_tx_desc_info {
 	bool er_cap;
 	bool stbc;
 	bool ldpc;
+	bool upd_wlan_hdr;
 };
 
 struct rtw89_core_tx_request {
-- 
2.25.1


