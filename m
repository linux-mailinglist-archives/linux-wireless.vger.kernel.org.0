Return-Path: <linux-wireless+bounces-30129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F442CDE608
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3190C30056CF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A5135A53;
	Fri, 26 Dec 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NwCVYzoU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585732652A4
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729769; cv=none; b=EkGZLYwzV/F1UksQYcX2jrXexR2FiJbkbz6NtCLLh+vWBZQ9+ofkevmLy6U5qqZ1PSJcmZOBPeuvJPvanOIyhw42ei2/KDCnV/aF9hPGk4DPVj9POW72zwisGBrY7xU56ut8PbGUUdipiEkv0NUFP5Caj6jwx0ynLaTtcwVBJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729769; c=relaxed/simple;
	bh=Tc+0YR6TK49pflaIWAzhtXFS29I7DbKVFZQyOL+F/ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrPc4nMfkmYuNjAmfIyHogvcDUvE1GAjc8PJtrbp9Q47GkGQsI4Cm1y560Au58+iZ00io4DW1UDgNVGrWYbF80bVbMuBFnZTy48SsGJaEn8b5VQ6oja3MLdWwat3zexnbwMWRZySXb/VAxoTp5yGbLUPnKhl7TdF6bWRTfBQ6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NwCVYzoU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6G3buC3115205, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729763; bh=cNA0Vj5FLpUFzLrhzKi5br5VvjH37+SgOkLvMlTwD2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=NwCVYzoU0+Df0UM1bZlHTF7i0KszEhMA/qF50y2rLGj9pM2Qusw4RX7fu319U2IGB
	 C641r/PGZbYHc7le6R73IsIsj9SpE34S8tc2Rw45qHTJzEYUIefqk8TDrC7B3Pnefa
	 D36T+TAeLmmRHLhGsu1DWcLQaRkQy9rKvKSyFZIl5nIExu8eo4kmGmVm3jToAmDcqR
	 ALHlBVx8xYRMgn8dBNgKYPKAnSeWlSR/L+GoC26CRKkae2g0ulDwcatNWZaaVj4yNZ
	 PnzYg53qehItOrWpH5IVDOX9bmL9hddvlFCLd26/JSpGhoFrMzkUACsUgNgIgeaf0t
	 3ZOnxlx3/V9Kg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6G3buC3115205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:16:03 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:16:03 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:16:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/12] wifi: rtw89: enhance connection stability when triggering beacon loss
Date: Fri, 26 Dec 2025 14:14:46 +0800
Message-ID: <20251226061446.63514-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251226061446.63514-1-pkshih@realtek.com>
References: <20251226061446.63514-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

If the driver supports ack status reports of TX frames, mac80211 allows it
to detect AP if it's alive and determine whether the client can maintain
the connection by sending null-data. Therefore, refine the flow to let
driver inform mac80211 to enable beacon loss work to track AP's status
upon receiving beacon loss event.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 91854ae9a310..1375ab324a8b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5253,10 +5253,10 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 			if (start_detect)
 				return;
 
-			ieee80211_connection_loss(vif);
-		} else {
-			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
+			ieee80211_beacon_loss(vif);
 		}
+
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
 		return;
 	case RTW89_BCN_FLTR_NOTIFY:
 		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
-- 
2.25.1


