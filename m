Return-Path: <linux-wireless+bounces-3657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA588573FE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 04:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96291F232A0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 03:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D5FBEB;
	Fri, 16 Feb 2024 03:40:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079DFBE9
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708054819; cv=none; b=hKKyPDVlKfltASqBr5ebCWRAN+pjAmQE3gFxU1aesPjZHAAeoXhZlNFQFtVs4P5RR6WirS8kSF+2WBtITMmmGvcaeIKQfmvXvFwtb10vkMyMPuZOrrkc6sbOd6biRJDiuJKJINt/HXTaVjGhBQDYeo6ZaXEJ+TTPYA0ijVlHxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708054819; c=relaxed/simple;
	bh=TmGy1oZBUtjFf5JvZnS5vqKGzsirWauaIJxkBiR9zfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BkDOmApiltQeKDLQLn5C85Yk1g8awO2yBEWYlVaN5KjPAjePmP7XHpQYuXsW73+RERbaAGoXBqNVv1EG9a92MmLv48NhXIF/ygq6oPptNlwUwiWyDjGP/rdvLBkc1ZnMSx73pldAHE3iIH2cx4jOjMr5oByZJfPEBj6YBumdHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41G3e1As92751774, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41G3e1As92751774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 11:40:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 16 Feb 2024 11:40:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Feb
 2024 11:40:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>, <Jes.Sorensen@gmail.com>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtl8xxxu: check vif before using in rtl8xxxu_tx()
Date: Fri, 16 Feb 2024 11:39:23 +0800
Message-ID: <20240216033923.34683-1-pkshih@realtek.com>
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

The 'vif' is from tx_info of SKB, and other codes check 'vif' before using,
which raises smatch warnings:

drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5656 rtl8xxxu_tx()
   warn: variable dereferenced before check 'vif' (see line 5553)

Compile tested only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 66bf92c164c3..40edf55d8e4a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5550,7 +5550,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	struct rtl8xxxu_tx_urb *tx_urb;
 	struct ieee80211_sta *sta = NULL;
 	struct ieee80211_vif *vif = tx_info->control.vif;
-	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
+	struct rtl8xxxu_vif *rtlvif = vif ? (struct rtl8xxxu_vif *)vif->drv_priv : NULL;
 	struct device *dev = &priv->udev->dev;
 	u32 queue, rts_rate;
 	u16 pktlen = skb->len;
@@ -5621,7 +5621,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 		default:
 			break;
 		}
-		if (bmc && rtlvif->hw_key_idx != 0xff) {
+		if (bmc && rtlvif && rtlvif->hw_key_idx != 0xff) {
 			tx_desc->txdw1 |= cpu_to_le32(TXDESC_EN_DESC_ID);
 			macid = rtlvif->hw_key_idx;
 		}
-- 
2.25.1


