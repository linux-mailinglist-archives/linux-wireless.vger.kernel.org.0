Return-Path: <linux-wireless+bounces-10417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D793868E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 00:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889121F2112B
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2024 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B111713;
	Sun, 21 Jul 2024 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfdxyE7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EE10A0C
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jul 2024 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721602404; cv=none; b=Whj35T8mzUx9SCVvRsizclketXql+UuuCgj0iD2VQyufu3Sgw7yKbHzFPcGRZLdOqkiexldh9DfHyTDQZoE5vEaCX5j0Fn5IzUa8hfXPyF6zOf0sr4hOuxYYJ7BuqZ3tWQ/szGrOGcNuNEpXo5w7EPHnWdn8NBwa9UTm8cht4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721602404; c=relaxed/simple;
	bh=a8/CH7E0F1qBkBvcuTfwGgxqGbkEZFFVmZ6ovn2BJpM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TNvVowXEGpIKGfwXH88JcDupTRcuOM5YvzWPVhlkskQUIjwr/USEcqzIgiSgfMs9I1Pemg3jidaGNiGvFwOdGhFeNboh/WQv2a2gvGOYC552r8G3rh24Ugc/jynMomqYcvNtqeywO8xMS6iIpR1bnxtZDDyEvMbEWMl4frlVz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfdxyE7E; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so1646617e87.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jul 2024 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721602401; x=1722207201; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osy+SwZ6MSI4gmfpeBc1jUk71RsqdL37/ZS44MISaxk=;
        b=FfdxyE7EIQfSlaI2bLHGRoukLwk4Sxo24oy1dizV809n0MeijdmJTcYd3AMy60bK7D
         qX+2DhgYjApO/zN4OS5XKPOj7rY02E7JOvnZ1J14L7dKxuLtFrUetrJ6Ck+ADX2HkXlE
         H4TQOztXfoGgeBxFxCYs9RH+edZU7dA2GP8NCPUT59sLyayDOyjwDmaubGWuMtdf/ZV9
         yqea16sejEfiIQ0dSEJEegvfO2IEvZJTfvCPIIKRSt4SJohkSELSq6S6ysVy16m4D0qG
         pQtTkZSez/ifW7JRRcztXfFTvlxhFI6aVogOUdTQLW76oXZYD/PWIce4cHnrWjVLtiOa
         2uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721602401; x=1722207201;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=osy+SwZ6MSI4gmfpeBc1jUk71RsqdL37/ZS44MISaxk=;
        b=f/OBRT05Udl24JmnadZV03hkItG2sdrXs+EGASsPiMMNRa2qL7O/hD646wPYQq4OeL
         NQYRgralPFW66VRgGvTfiX5uFNPqVKqjkL/rCOREgGTu1cHouBRs8hTgLZ31LkrrP6bY
         K1ESrfAVAcnpJQPqDWNrt7o8AlFlPstsh0kygspDwZugw8dKe+YLdhiX6urFW/DUmNYf
         gmuhGst5bGuotDkBA1ivPufeAYfkT5V+V1ECfF88fhjPUasWLV3KKM4mQ5nO1HJXnbHj
         Hn1gcekSNXYI7FNFiLh3b02bY+kCMN1RPdB0KihNeM9NGQp/9JE5xvOKRKKjS8np+fzI
         HRFg==
X-Gm-Message-State: AOJu0YyNSxbIjedXBFki0CTHpO85sFNLVyw3iK+jZRI8cRD98ZhurITJ
	fvGV+sUUeCGE9KiForZyslmlxzAAsVEIOx70gTltWEev0Zm8+AyKOI+wNA==
X-Google-Smtp-Source: AGHT+IFt4oD/MW1zvFkTZ+swxsRD8GfdSb4u1Mo888Rf+w4SWvpPahemgRjLXaHAix9hYLfNTwd9fw==
X-Received: by 2002:a05:6512:10c2:b0:52c:e3ad:3fbf with SMTP id 2adb3069b0e04-52efb7c8891mr3325812e87.42.1721602401042;
        Sun, 21 Jul 2024 15:53:21 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7b6622sm344209166b.50.2024.07.21.15.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 15:53:20 -0700 (PDT)
Message-ID: <2fbacb83-3e47-4f37-a70a-fb9f4719eb26@gmail.com>
Date: Mon, 22 Jul 2024 01:53:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtw88: 8822c: Fix reported RX band width
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"iw dev wlp2s0 station dump" shows incorrect rx bitrate:

tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
rx bitrate:     86.7 MBit/s VHT-MCS 9 VHT-NSS 1

This is because the RX band width is calculated incorrectly. Fix the
calculation according to the phydm_rxsc_2_bw() function from the
official drivers.

After:

tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
rx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1

It also works correctly with the AP configured for 20 MHz and 40 MHz.

Tested with RTL8822CE.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index bc807b13e9ce..e265a35184ab 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2612,12 +2612,14 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	else
 		rxsc = GET_PHY_STAT_P1_HT_RXSC(phy_status);
 
-	if (rxsc >= 9 && rxsc <= 12)
+	if (rxsc == 0)
+		bw = rtwdev->hal.current_band_width;
+	else if (rxsc >= 1 && rxsc <= 8)
+		bw = RTW_CHANNEL_WIDTH_20;
+	else if (rxsc >= 9 && rxsc <= 12)
 		bw = RTW_CHANNEL_WIDTH_40;
-	else if (rxsc >= 13)
-		bw = RTW_CHANNEL_WIDTH_80;
 	else
-		bw = RTW_CHANNEL_WIDTH_20;
+		bw = RTW_CHANNEL_WIDTH_80;
 
 	channel = GET_PHY_STAT_P1_CHANNEL(phy_status);
 	rtw_set_rx_freq_band(pkt_stat, channel);
-- 
2.45.2


