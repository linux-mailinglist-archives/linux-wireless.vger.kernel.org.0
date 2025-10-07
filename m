Return-Path: <linux-wireless+bounces-27840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3BBBC015C
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 609414E03CB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5B20296E;
	Tue,  7 Oct 2025 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="woqbkUxW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B31FECAB
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807629; cv=none; b=A49t0qAGA35Q4rwVA5k6QiIbYhwYQGR4eJxjrR6AlQAHXtU6F7lAYYonSMgYiRUZctzCavPLeEsKj8znlLrx/IvWlSejMcrkqUiOzz+LRY65Y3L8Ng6HxKPUHsLFLUkJstlQSvnyksWbwhQa6pZvgtqqLTo43tXgQXcJRKX7swU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807629; c=relaxed/simple;
	bh=nPP3z0MakaatFz46jx/nNxLcVBn7UA+gdR3RvquzeHA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3vczLZkVj/xTBHUQD71Yn2ok+1SuCSQ7T3/54+c/nNzAo6wND+yrh+eLgYB4NQkY3Myk0C2oREmu+vUXhvj4OgQZPrStshS2XDCpR607RQ6RjhsCwwbdInKnIWEj+nu/gMzkF5e5gyUUKbPvCEfTbGfPaDKzZCtviH2KqoYj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=woqbkUxW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5973R2cD43453054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759807622; bh=r5tQzNcIQR+e9TyFkl4Rh1dVYd5zPR56jKYxh/e2Fdk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=woqbkUxWWlM/TgngFbgb3U2DG2anugBZDDiUuoPQst8mefJS8uYCsXDIxWATxd1Wr
	 Fvm703vPY1XoGmvVjBZgJNNLNHoJWzoVQ0pvqd1emN7wgcihc5IwrblcPKnUtk0tzy
	 i8s3rX94fTrO7HgUHYFD+NmFviox0EnLw4kD5YoXMNEVQdULddoB7qu6AaAgvbUbFM
	 vOg4p9JmBYAjR8AB5zTLrEihsnRwKulyRNhIyklnUhtm0qh/tFZN5O5lZ0JRvo17le
	 pZW6Dh3Qc6TooEm/j62wcuSiEK/Nz5hZRZxSdNtXYRKnCN8QIM4OBhRMwGHvhh9YPe
	 oqXfMCPXDvLGw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5973R2cD43453054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Oct 2025 11:27:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 11:27:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 7 Oct
 2025 11:27:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next] wifi: rtw89: fill TX descriptor of FWCMD in shortcut
Date: Tue, 7 Oct 2025 11:26:56 +0800
Message-ID: <20251007032656.13189-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

TX type FWCMD is used to download firmware and send H2C commands, and
it only fill few fields of TX description, such as desc_info->pkt_size.
Therefore, early return the TX type FWCMD.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 917b2adede61..c686565f04cf 100644
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
2.25.1


