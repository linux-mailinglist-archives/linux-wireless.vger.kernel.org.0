Return-Path: <linux-wireless+bounces-26445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F21B2B7EC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 05:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ECB3B60D0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D3BBA4A;
	Tue, 19 Aug 2025 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="j90r8hFZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670701946DA
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575142; cv=none; b=WdzKScSqzhWrH3ZWPhUQFXiWJJXzjDbAxvD+tFZlETkR8E3U7PauXhUwAZbvfv6zv1Rg/xSxhwYyJMTqSykBWNMGUyJRFI5NplkP2lY0RlHpqndGZySPRiLsktE0Y7Se3/3lNvB2RKd5WyseB1Buv3BdGcoJlBDpy/RwjZJzgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575142; c=relaxed/simple;
	bh=v8diEjdg/CutncybSmIUsr678xliC2BHzvpgY0ybEsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0zp6HYHGd4is7ehWc9WQWnHlkjRQxiOZtdSEBWwTVWK8O838fsxYEf8lXGulyzsua6qjbAkDeyuqlAu2uI/HzaGnIr5gJjG8EpA4tLAuka+FQZ8SrIWtIn/Faw/140bfPCo2b4wgt9AOBKpZZuB7r6rYWFg3jvvOFPWMa+jJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=j90r8hFZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J3jZ8B12064819, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755575135; bh=stqm/fWa94aTNjeDVmN0WS1yFq/mVi8FFtyGdWNsfeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=j90r8hFZoOgnMKUHCgbh5468x2Y4B7AJ+AHH8479KRPVPbbr7T+kwBQSbJw4qkhZT
	 R0IBqQSolYthTY6wG0QFzS8lyB6lpai8ncP+S2OlkpYcqFmuCxR79AZYmFWcRK5psH
	 m/Fy5xjhoX0h4gwPAb080MF1UQDfzaTPZTlpozAJ74nu1hKi0Jps4UWDSOhhvBgBdh
	 ohrdJBwnNTLzivAZBPrnShEj2SMGqzCHg691cyGBf54dG2phVWJSzWjvG7ulFXJPSq
	 HmQJ3MqVYwdnFhL+PHywxwK3+vX6EpYwjtsWWk+w6Q+ZIxy83i0Fga5KSQg/PXJJfH
	 fXT5wg0uSa+4g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J3jZ8B12064819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:45:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 11:45:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 11:45:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 2/4] wifi: rtw89: 8852a: report average RSSI to avoid unnecessary scanning
Date: Tue, 19 Aug 2025 11:44:26 +0800
Message-ID: <20250819034428.26307-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250819034428.26307-1-pkshih@realtek.com>
References: <20250819034428.26307-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Po-Hao Huang <phhuang@realtek.com>

8852A uses single antenna during power save, when the loss
between two antennas is too large, previous logic induces
greater RSSI variation. Report the average beacon RSSI for
connected AP to get more stable RSSI and less unnecessary scanning.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1d85607e9424..d4200246eecc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2109,10 +2109,17 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 {
 	u8 path;
 	u8 *rx_power = phy_ppdu->rssi;
+	u8 raw;
+
+	if (!status->signal) {
+		if (phy_ppdu->to_self)
+			raw = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
+		else
+			raw = max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]);
+
+		status->signal = RTW89_RSSI_RAW_TO_DBM(raw);
+	}
 
-	if (!status->signal)
-		status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A],
-							   rx_power[RF_PATH_B]));
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
 		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
-- 
2.25.1


