Return-Path: <linux-wireless+bounces-29827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C574BCC65A9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 08:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E2230124E4
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052F274FD3;
	Wed, 17 Dec 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IgftKyhj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A947244675
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956426; cv=none; b=bkYnZ649F7YZxT2fHHe1OEU6Px2iL3DUWlZNEXPlMNnG4rUzTUds3B3xUbeTyctUCMQbHaRLMfPMEsS9sd9bsVz3TakObQLwStKFGr7L9vHpw2Ko09/QvFegtfKzbmYPFslvYAOE7Dpw+vD7H5AHkg87RJNuhn+0Qohm1xdaYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956426; c=relaxed/simple;
	bh=619vzv00/HK/OzTqk3zXMUKOUGrtjgX5qvtSIYObHLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bX7AmqgH8NVJusdWmv1Perpv+s/+fGknT7BiKujiVCw7IbQoC3vEq4NNT3mWopP+SH0ssvBm2/R7u2Y3r7yJDS+iHLC/HPk1GRysP3LHWxNgQIl4ScIMojXssXsQdd7Jt44d4FpDGfIp3Bh9hYT/N0SEJuEb4BD/j96mnTJFAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IgftKyhj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BH7Qpi561360982, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765956411; bh=NEGu7lnaZzhpb6Cp6z0PiO2TrLbMGh3eGjocJ55+Bb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=IgftKyhjIf1P3txWyjqIJ1SPWGoc6z68sBtLLSu8yB28TPHprpAzU7bB+Y9JPYyd3
	 xobeHwE9Ang4naVOOoHIZp6Kbj5J9EBy3lWg6FaKvAlMk9hTxohpzNcqc2I3samcsC
	 AsRMtpyM45xnPD+L9S6s6bKSPmvdMbzKfHMqeUxddj6aBYgqJOXKHr9bPgAM2MLLP9
	 p3twOVk0bne1JIEx/Kf2p7WCvepwS5zkrb7pOkR9VBkVA2MJy89gcdxxEaZkYMnRPo
	 Kw2JsjPFSBqlrNbM6IH8bl8ZI0y7ikajgk0Oy6Cj9tq6TnmmQppkF+uUUini9hfDjb
	 iPxbKwAx3akzg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BH7Qpi561360982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 15:26:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 17 Dec 2025 15:26:52 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Dec 2025 15:26:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Dec 2025 15:26:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <pchelkin@ispras.ru>
Subject: [PATCH rtw-next] wifi: rtw89: correct use sequence of driver_data in skb->info
Date: Wed, 17 Dec 2025 15:26:46 +0800
Message-ID: <20251217072646.43209-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

As ieee80211_tx_info is used to assist filling TX descriptor, and layout of
IEEE80211_SKB_CB(skb)->driver_data (accessing by RTW89_TX_SKB_CB()) is
union, so driver_data must be used by/after rtw89_hci_tx_write() or just
before calling rtw89_hci_tx_write(). Otherwise, ieee80211_tx_info::control
data is overwritten.

Found this by using injected packets which uses ieee80211_tx_info::control,
but always sending incorrect data rate.

Cc: Fedor Pchelkin <pchelkin@ispras.ru>
Fixes: d5da3d9fb05f ("wifi: rtw89: process TX wait skbs for USB via C2H handler")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
I'd let this patch go via rtw-next tree, because this change is conflict
with coming rtw-next patches, and actually this affects injected packets
function only which I'd consider as a debug function.
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 ++++--
 drivers/net/wireless/realtek/rtw89/core.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0824940c91ae..53d32f3137eb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1207,7 +1207,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	if (addr_cam->valid && desc_info->mlo)
 		upd_wlan_hdr = true;
 
-	if (rtw89_is_tx_rpt_skb(rtwdev, tx_req->skb))
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS || tx_req->with_wait)
 		rtw89_tx_rpt_init(rtwdev, tx_req);
 
 	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
@@ -1342,13 +1342,15 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.rtwvif_link = rtwvif_link;
 	tx_req.rtwsta_link = rtwsta_link;
 	tx_req.desc_info.sw_mld = sw_mld;
-	rcu_assign_pointer(skb_data->wait, wait);
+	tx_req.with_wait = !!wait;
 
 	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
 	rtw89_wow_parse_akm(rtwdev, skb);
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
+	rcu_assign_pointer(skb_data->wait, wait);
+
 	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a9cb47ea0b93..92636cfc5ca5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1211,6 +1211,8 @@ struct rtw89_core_tx_request {
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_sta_link *rtwsta_link;
 	struct rtw89_tx_desc_info desc_info;
+
+	bool with_wait;
 };
 
 struct rtw89_txq {
-- 
2.25.1


