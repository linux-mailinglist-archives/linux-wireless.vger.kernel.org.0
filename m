Return-Path: <linux-wireless+bounces-10458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498793A7B4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 21:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02635B22664
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F8813E898;
	Tue, 23 Jul 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnwliqo2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7913D628
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763102; cv=none; b=iANJkGPn/0uP3iTVRXbVnJ7IWfHzv7xmyTy67zUb5KWOgQ1fxFCWG4ms1e+kXXNSDqssA/cVEzSaNb6rQPktlaMSDwxFfDXzRaEQqLQ7pEwc8G2u6UrdM8cPoqJwUetIkgaA7Njcapv1IV5fRaF41lgK+eDRgjiKymLx9813hfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763102; c=relaxed/simple;
	bh=IFcDO3OnmF1L8H9nGyq7//G9FVKR9Z7NEIM7M9UtW+M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tzG6WWPzxq+9NpNWiDVPx5+MNMMXhUU1PJN/2YV3hhOHVP6ia8st7aXfwEdFTNvgxrs70NQhTkYWDmpKXbuuRlXXDobAst1N8F8oiI1aAJyTtQYHPRFBkaGz8L2weUvY0GHwJsyJlIDtBAQFKDgzF8xNfjewW4E+1QtcSw4vo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnwliqo2; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efbc57456so1953943e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721763099; x=1722367899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO4AhVxi4WtXemFwnuLtIBl3GHY32vzR7+rWPtVY4W8=;
        b=mnwliqo2n4L903cgzpmhKWeUuhpq97MytEKn93i+ltS5xMYtrT/xOxLvpo8jCFPA/L
         XldLbrUVHQ+fZkAhYQCvb5GZ8DMg3YuqxUD/UTIguedutuPzxztiXt3IZmHuDxSJc6Yx
         hObhGzcI+wvmkiZsAGLXpovkLSi6KEn01ow1QELKZlyAvKH5e0JZI7cJ0g5K/Q7oDTjf
         I+CufsusCNBKET3N7liJ9X6geebs8MiFUEsRLIsary21pwfnvzDgLUwpqXLWKMR8umFE
         w/xphwisw2bkyAhmznfeoliD2kfcCbRP/+tGz1g1gznW9StI/44rBhTiS1zOzbxelhjr
         CWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721763099; x=1722367899;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jO4AhVxi4WtXemFwnuLtIBl3GHY32vzR7+rWPtVY4W8=;
        b=PWv64qgXZRLpOGwoWIBuEMOvhu1Vw2idBbO4ulsej38n5Uot1AYMU3nuAbGQzD//TW
         ij+lbpAJS6LNFlrz/3KkhaosmUtbM4Jl0+iRkcpgMA2sZ0hejcOxXpwZslIU4gpcf1jt
         G6GzlUFwRCj4KaVURC9kwO9jP4LsqnJDzqM9NUqqCskKDCiR8f2m8w2xmvmemThSEWDw
         UdpzKrdgV9tyK7AJIwCVSwP5AF2YEreEFCqUE63AiaYMdhnYz9uNy9Z+mxqtp0xUcrBU
         63S8REaJIe63vHtMN7+OmKqCTGnocUrcJOnL291J4CBjh7XCvtQpioCNBAX+IjX/co0o
         w41Q==
X-Gm-Message-State: AOJu0Yy8Debq4hrEXhrg835JJaVzXoGjCP2Ngwh37yiUAPaf74v1Jbxm
	q5gWY4y8WWxlKEJxuULmB0lc1So1+3TSDqk/W/txF7jpnZ1Em8ykZi2wgg==
X-Google-Smtp-Source: AGHT+IHIsFNEKsFDKptsZu49H7jDMEqHQHEL+pQmWeadX0OL3bUoZAdz8DkyGQVNRFCm4l2uKL5kmA==
X-Received: by 2002:a05:6512:234b:b0:52c:e17c:3753 with SMTP id 2adb3069b0e04-52fcda18469mr486183e87.5.1721763098532;
        Tue, 23 Jul 2024 12:31:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a93c62343sm112902166b.201.2024.07.23.12.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 12:31:38 -0700 (PDT)
Message-ID: <bca8949b-e2bd-4515-98fd-70d3049a0097@gmail.com>
Date: Tue, 23 Jul 2024 22:31:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3 1/2] wifi: rtw88: 8822c: Fix reported RX band width
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
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
Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Use Fixes and Cc: stable.

v2:
 - Use Fixes instead of Cc: stable.
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


