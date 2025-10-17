Return-Path: <linux-wireless+bounces-28028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F7BE7F3B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3205E509263
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3744314A74;
	Fri, 17 Oct 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="K8ATaeE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74983128A7;
	Fri, 17 Oct 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695639; cv=none; b=phqa7RVTxOq0tUaKS99RFrMf+BOHyiXbXw34hdH3yyEESmGi2NVsxLz9JYtqwvm04Cc4D2aBrqQBFPdb2NHW2tUQv0nrqvJP5GjTTakItS4GqqRnhMh13Ckwe1FUyrQUeBsHPy7OkCmtBcGvj/8Bb7T0ZCDbqjvsRXcB9UjZ57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695639; c=relaxed/simple;
	bh=fo20jNoFrZiBhopoOwyV308BK5T5SF4n90AVJoDjiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWcHwafadn13YpwVEPDVmiKh5Y9iG6e8KA2kBUXxM755MHuLub04g0au1v1a9PVpZ+PxbiaM8ndqXOWEd92K23FITBX3oCjoPMqLgbSHVZ5ymIa57MDcUEHYCK98130yylAye5+4dhK84Pw7MqeB8aeOGS7qeYDWIUFWJPgdFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=K8ATaeE+; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7525E407674B;
	Fri, 17 Oct 2025 10:07:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7525E407674B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695633;
	bh=ttxiGGBn5kiEFZLFIlor2UNVGgYKXqAfjcSk+gjuUk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8ATaeE+F7EQ+b2U/KMznfoEZJ5vDS+FgWg6g5s9gCwRELXkVbrn8K663PuLuS+vw
	 xw0bkCbSv5vyFyKdTy6RGeIQb7z4hD58BCOykQ2Z1tmrBC5O0vdj9zj7AejQN+tfIL
	 y1ZRhiaLYdoaWSXRz0p7XcOAoZxqq8/1QluSyp0I=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 6/9] wifi: rtw89: fill TX descriptor of FWCMD in shortcut
Date: Fri, 17 Oct 2025 13:03:08 +0300
Message-ID: <20251017100658.66581-7-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017100658.66581-1-pchelkin@ispras.ru>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

TX type FWCMD is used to download firmware and send H2C commands, and
it only fill few fields of TX description, such as desc_info->pkt_size.
Therefore, early return the TX type FWCMD.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 49ecc248464b..abe8eec1d0f5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1087,32 +1087,35 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct rtw89_addr_cam_entry *addr_cam;
-	enum rtw89_core_tx_type tx_type;
 	enum btc_pkt_type pkt_type;
 	bool upd_wlan_hdr = false;
 	bool is_bmc;
 	u16 seq;
 
+	desc_info->pkt_size = skb->len;
+
+	if (unlikely(tx_req->tx_type == RTW89_CORE_TX_TYPE_FWCMD)) {
+		rtw89_core_tx_update_h2c_info(rtwdev, tx_req);
+		return;
+	}
+
+	tx_req->tx_type = rtw89_core_get_tx_type(rtwdev, skb);
+
 	if (tx_req->sta)
 		desc_info->mlo = tx_req->sta->mlo;
 	else if (tx_req->vif)
 		desc_info->mlo = ieee80211_vif_is_mld(tx_req->vif);
 
 	seq = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
-	if (tx_req->tx_type != RTW89_CORE_TX_TYPE_FWCMD) {
-		tx_type = rtw89_core_get_tx_type(rtwdev, skb);
-		tx_req->tx_type = tx_type;
+	addr_cam = rtw89_get_addr_cam_of(tx_req->rtwvif_link,
+					 tx_req->rtwsta_link);
+	if (addr_cam->valid && desc_info->mlo)
+		upd_wlan_hdr = true;
 
-		addr_cam = rtw89_get_addr_cam_of(tx_req->rtwvif_link,
-						 tx_req->rtwsta_link);
-		if (addr_cam->valid && desc_info->mlo)
-			upd_wlan_hdr = true;
-	}
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
 		  is_multicast_ether_addr(hdr->addr1));
 
 	desc_info->seq = seq;
-	desc_info->pkt_size = skb->len;
 	desc_info->is_bmc = is_bmc;
 	desc_info->wd_page = true;
 	desc_info->hiq = info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM;
@@ -1129,8 +1132,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 		rtw89_core_tx_update_ampdu_info(rtwdev, tx_req, pkt_type);
 		rtw89_core_tx_update_llc_hdr(rtwdev, desc_info, skb);
 		break;
-	case RTW89_CORE_TX_TYPE_FWCMD:
-		rtw89_core_tx_update_h2c_info(rtwdev, tx_req);
+	default:
 		break;
 	}
 }
-- 
2.51.0


