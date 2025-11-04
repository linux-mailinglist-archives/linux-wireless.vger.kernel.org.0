Return-Path: <linux-wireless+bounces-28540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7107C315B3
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 15:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78661424A7C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF632A3DE;
	Tue,  4 Nov 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="TeSh/9fL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A932D0FC;
	Tue,  4 Nov 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264677; cv=none; b=VzrMrV3SWbDuU6nxjDVpyPgtppd+gfJxLNTq3dokqvmAYexYaBU8QC6z0O+xQ3Cl0rTegdy/IpfgFUjYSOL9UdENP57FA3aSDSGY75TrPLHgbjn+n6OwVwi4a00oSPj7ml0rMM3gAdi1vt2Q7BeVY9SdDlPlKJJPcKPj9KWkCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264677; c=relaxed/simple;
	bh=G0hvHkH8q4DqlILtpmv3ZZwB0dFXXtqsw9ScThwATt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxydqK+00NXBn/2lWcoheBcJpGlG4AtDgI/XDo2E2hnCaOSdsXNvSQLOtlsMAi77qh9Vd/8NEYN92+i9ETTv0CnK3T4TgpRmyRadH4+T1kdLZmQ9m9JII1Th52IhtqChQXusAt+nMUt119cNlskZPbyu5/CvqXtER3SnMA0poPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=TeSh/9fL; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2C57240777B7;
	Tue,  4 Nov 2025 13:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2C57240777B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264665;
	bh=xUtZQNk0KS6IxOt6IzufwTTd/oByoo2lbxIYUICdznA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeSh/9fLha3JdQeO2rTSfq6k5pP+OFKM9iIu0R1wXBvuJO1Py7gBN5d+W2hU3ZSqj
	 z/tzyoFjmvcDt08VbEDTM2e74PD2/tMEInyz8mPVtjQct1GnvFLm27l6oE+apipNZa
	 7CGdBl6/uNsjB0TW2JmD6VSGYpfqY53BioMY09Ak=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 06/10] wifi: rtw89: fill TX descriptor of FWCMD in shortcut
Date: Tue,  4 Nov 2025 16:57:13 +0300
Message-ID: <20251104135720.321110-7-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104135720.321110-1-pchelkin@ispras.ru>
References: <20251104135720.321110-1-pchelkin@ispras.ru>
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
index 84f94c796a48..fd6624d12efe 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1106,32 +1106,35 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
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
@@ -1148,8 +1151,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
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


