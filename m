Return-Path: <linux-wireless+bounces-24252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B5ADECF8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C98D161CBC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85A2586C8;
	Wed, 18 Jun 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i8TnY8n9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6802556E
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250868; cv=none; b=IcC/bjw4PCOlLGHlIZOPfKsl40dHBvyoi5V/7jI+p8RP5b4lf9Av3nM3Wa+/a7JJqWkUEQZkIwaQRlyq/gvf3WQbN7hchtkf7UbSRs81eWZW7nKUvYlqtO3NfUdvitF860Mi4jgzsQp9LtVa9rAW2D97/9oz6EqzwP3ASTvJWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250868; c=relaxed/simple;
	bh=NELny7Qdw5cfEEbNgeTw0w89+stQqlNGlwJRnDYIQr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spCaT1okFJ/cvfGP/o1ViTz0CEQrHlQwan416HQRPkQ3+xs6y4pIEDE56Cv+/p4huYmqkkznA8oTaNV4loolgbJCPlXM1565DwVqi1VxLlFgtPOmkZ5I/4Mopc2GxjzMlDNniYMqayskdDBYV+n1QWBu9s3QR3Ti34110P/ckn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i8TnY8n9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55IClixcF4151184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750250864; bh=H2x8S7Kjs48W2Ej3vHO4ofo365FCCxguswbqDjWxCmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=i8TnY8n9kiOotJVup+tJfjLuQaXxpLPwgG0JJztBRhNhCbJWWXC0OMals2tWCfYhL
	 rCmv61ccLgtUf9Xj1aR2Rf/ZKJLXLEjSXgWqUa3K3tvRHM15MghY8cD7/3mDHK4axU
	 tSOTRroPPArzJL3iY/CiYsSvF3HkTKhziPEFZ2wo7C2+2TmiehlUqEaUdBlFpfBU6g
	 NcOsIVoywshy9cWlGjODjQkHwVdoRRfzQmi6SqF1dAdKOXlnyMRp1y8LMu4BJFjI94
	 pYC4g9B/t6lGFC8nHiUUZl37FaOjhT3Uq7Ij+RvaaYN/8FS25bO5/6Rdf3xMgju0lk
	 scG+3pW6irRvA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55IClixcF4151184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 20:47:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Jun 2025 20:47:51 +0800
Received: from [127.0.1.1] (10.22.224.135) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 18 Jun
 2025 20:47:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 5/6] wifi: rtw89: report boottime of receiving beacon and probe response
Date: Wed, 18 Jun 2025 20:46:48 +0800
Message-ID: <20250618124649.11436-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618124649.11436-1-pkshih@realtek.com>
References: <20250618124649.11436-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Userspace tools will parse NL80211_BSS_LAST_SEEN_BOOTTIME (if any) for a
more accurate timing when a BSS was seen. For example, iw, wpa_supplicant.
For beacon and probe response, fill RX boottime_ns in ieee80211_rx_status.
And for certain, it shouldn't count the waiting time for the PPDU status,
i.e. the possible buffering time of a frame in driver.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0babf5472195..1f5639a5d166 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2796,9 +2796,11 @@ static void rtw89_core_stats_sta_rx_status(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
+					struct sk_buff *skb,
 					struct rtw89_rx_desc_info *desc_info,
 					struct ieee80211_rx_status *rx_status)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	const struct cfg80211_chan_def *chandef =
 		rtw89_chandef_get(rtwdev, RTW89_CHANCTX_0);
 	u16 data_rate;
@@ -2810,6 +2812,10 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	rx_status->freq = chandef->chan->center_freq;
 	rx_status->band = chandef->chan->band;
 
+	if (ieee80211_is_beacon(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control))
+		rx_status->boottime_ns = ktime_get_boottime_ns();
+
 	if (rtwdev->scanning &&
 	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
 		const struct rtw89_chan *cur = rtw89_scan_chan_get(rtwdev);
@@ -2966,7 +2972,7 @@ void rtw89_core_rx(struct rtw89_dev *rtwdev,
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
 	memset(rx_status, 0, sizeof(*rx_status));
-	rtw89_core_update_rx_status(rtwdev, desc_info, rx_status);
+	rtw89_core_update_rx_status(rtwdev, skb, desc_info, rx_status);
 	rtw89_core_rx_pkt_hdl(rtwdev, skb, desc_info);
 	if (desc_info->long_rxdesc &&
 	    BIT(desc_info->frame_type) & PPDU_FILTER_BITMAP)
-- 
2.25.1


