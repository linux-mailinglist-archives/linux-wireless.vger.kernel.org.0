Return-Path: <linux-wireless+bounces-35620-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBMLGLAI8mnhmwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35620-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:33:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1C494E73
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F12300A396
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C010A3F789A;
	Wed, 29 Apr 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="auTxyS5X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D442C159A
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469196; cv=none; b=GuhEDccNlEVLO7JZatrxxCkSuHDFPDF7NiJFTTLCvVmRtyeZlZmGB/UTF+XhMNndyzbWaJNKBshB1OuLqdzAS10jj6wWiKZYwLQFXI7M29SQcdneDw7jq6uGu2/nLjkrfAtCxZ3vD8dbbwr0z/Ytjxu9NaHMidwavry1+14mE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469196; c=relaxed/simple;
	bh=gMivTZrQhJBGGFzPUWW5pGLbJEDvrK+nEhknJjmIN7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YslKgUc0Gmr4IHwlxlt59mIAouf8h+MUNQbiSJNtWzOmGZ5xHIHJuCOiDZW0894TgKyDwZTQL7PgiZLqKSynOrIUWbqq2KxiaE7uqrmuSQG1lOmjyDQ/1bTgrTFAiHRSTUNZtfFOTF+RVIJsUODVqJibqEuuNffX238++LMM/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=auTxyS5X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDQVFb81222990, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469191; bh=YzEHe+MQ9OcxGXBGwNWmGGDq8PYqWMxNlotw5ofnoAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=auTxyS5X/Ar6lxS0+ynh8NwM3Whiwl5SbKzZPonELRahX/mej8mlxPwKHyWNs1qY/
	 uHdxfUuW6sidmtAcFXwTgnnbT+WDNPOra3u+7VQbWUtTzOotRL0Uk4XvGAm2PQFZyD
	 vSiNaHtzPWFoH3bWNub0QAxGDYj84k7fvgle0CaOHE+QDDPKhtASH/u0PYQ4+EpjJT
	 Zv1SKAFzzeUQGGX0+CrH8cZwErSM82F/e4ZMUSeM8ms9QOIL7Lxz+Dlg9qcJYEYxyJ
	 GLaSi/5oulST33W5MWMq8lD9PxZTza2I+bWj0SYXKH0SI0Qs5cVrRl23BlczrRkEtO
	 XINzITuUgbXXQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDQVFb81222990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:26:31 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:31 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:31 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:26:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 1/7] wifi: rtw89: mlo: rearrange MLSR link decision flow
Date: Wed, 29 Apr 2026 21:26:19 +0800
Message-ID: <20260429132625.1659182-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429132625.1659182-1-pkshih@realtek.com>
References: <20260429132625.1659182-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: D5B1C494E73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35620-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Kuan-Chung Chen <damon.chen@realtek.com>

The original MLSR link decision refers to RSSI, but it should be
based on the premise of an existing link. Otherwise, make a link
decision to select a new link from any available band.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7e058c071cc4..03d80d012022 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4746,13 +4746,19 @@ static void rtw89_core_mlsr_link_decision(struct rtw89_dev *rtwdev,
 {
 	unsigned int sel_link_id = IEEE80211_MLD_MAX_NUM_LINKS;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	u8 decided_bands = BIT(RTW89_BAND_NUM) - 1;
 	struct rtw89_vif_link *rtwvif_link;
 	const struct rtw89_chan *chan;
 	unsigned long usable_links;
 	unsigned int link_id;
-	u8 decided_bands;
 	u8 rssi;
 
+	usable_links = ieee80211_vif_usable_links(vif);
+
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
+	if (unlikely(!rtwvif_link))
+		goto select;
+
 	rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
 	if (unlikely(!rssi))
 		return;
@@ -4764,12 +4770,6 @@ static void rtw89_core_mlsr_link_decision(struct rtw89_dev *rtwdev,
 	else
 		return;
 
-	usable_links = ieee80211_vif_usable_links(vif);
-
-	rtwvif_link = rtw89_get_designated_link(rtwvif);
-	if (unlikely(!rtwvif_link))
-		goto select;
-
 	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	if (decided_bands & BIT(chan->band_type))
 		return;
-- 
2.25.1


