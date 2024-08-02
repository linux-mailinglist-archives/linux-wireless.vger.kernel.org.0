Return-Path: <linux-wireless+bounces-10873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0E946518
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 23:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9972A2817A7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A95481AB;
	Fri,  2 Aug 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQbCa7YD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DB1396
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634386; cv=none; b=fhcd8rPPUzvMnTyM1HRSKZUVUvGYld2APDpoWsbRdsp6sAtHaneN9tFUz3wojEq8jxVYi6//zDFwacBdQiG0bF0yMb3WAZJNUj26R/mYLMG5r9ujXt9NyAhc01twvR4W1RsUO+57T7+YEc+9eUXERtQ62UQKezTP0b6SPaYAmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634386; c=relaxed/simple;
	bh=dsM5T8buRWchqI60liVEUOPlWuhs71ryQ3cbcIudXBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k/tO4kI0wEqJ6jJryY0p2bNEQw5XL0i/gTWrAR9jA6CnZ67h5ZP4I+oHLSmhWHX8Rm6ZzlwDFoA9/qVXqWukBQjLaJc5ZR6OzCbU0QbbulQNS32mtbuHRp1Dfpa1pVS/2R4uGcIuNlrw+xaL4uEsTU475XBAd6jDn1pRG4OIy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQbCa7YD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7d26c2297eso1082668566b.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722634383; x=1723239183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWb/U6a1+cb2LkrJoqaGh9jGrIMelpBHol/y6TNP2z4=;
        b=LQbCa7YDSmZtwPz05EzNtNTdet9dKNC9ryE2QccnYHBGR5vKuhJkhHqNPmxORP+Fay
         8mN63nCV4/ZGW48XfqZuDavAlZGipD/gNF2wFtFubaXgtLPYHdyPSXEYvCS+qrKV2TrH
         VIbNMjBeQuvICFWGPWha1nfLpKcB/Aq7A3GbeeBC/ivjYHaQ7InVhvrU0U3SakK3eeqq
         BQ9fliU0RjGL/LK3G6gYOVBfMqWekBrL9yfISHta78zXfj53JTZNBPjMNTm/sysoKFiu
         kcSRW1bml0w3TXJadVoMbskHtbUFoOu+PN4xPZaUE146EwE0cD0Ek4J1A5eqmZsN4/y/
         tmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634383; x=1723239183;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWb/U6a1+cb2LkrJoqaGh9jGrIMelpBHol/y6TNP2z4=;
        b=i64B9PMYvBvWwV9YW5KK25CTHp3HEkf8tZ/YMnZd8eZ6Wxc1W638OhlnwmTD/sI10u
         N2YE913UHq+4isGUCfG9RcT1qviTPvf07LIl+kz+EG4NKi8N0kaCVY+74LSZHswtDPjq
         1E+3TBSVJ6tYtQOoNR8XDIm3vOQZC733WjlfnnuzGsbP5zV4ztsTToKTRapAUNPhZHgV
         qzgHBPIYFnNtMH90WhSIXSC8NVjlEWpAkhnd19L50y/LSvfT32zfj4n+1qmKsMQ81kaU
         Nml49773JBTq9RA8jKSuqYTEquS4yy1X2pZC90Wv+aGb3wS2ZuU3rSeHs3GOVmnsn6So
         Va2w==
X-Gm-Message-State: AOJu0YzjxnA/Tml5rQ9Aqffcfcijm7L30D18on0sDTQQ9BwqVEIJtXKR
	DYyB4w7AsdK6r8zYyo/2GTC7CdFj3MW1Pn7ejwg2OHytHsFsJKbW/AhQpg==
X-Google-Smtp-Source: AGHT+IF+tDQbuW46Ybq2JOZxuZIJP6DqQww0Has01pK4DAALoD3fPLcbao2M4wrT8XVLOfbdNWcG6A==
X-Received: by 2002:a17:907:2d2c:b0:a77:eb34:3b49 with SMTP id a640c23a62f3a-a7dc4ff0b22mr373332066b.37.1722634383308;
        Fri, 02 Aug 2024 14:33:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d43777sm138047866b.136.2024.08.02.14.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:33:03 -0700 (PDT)
Message-ID: <3766e2fc-3970-4628-a660-98681450deb7@gmail.com>
Date: Sat, 3 Aug 2024 00:33:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/4] wifi: rtw88: usb: Update the RX stats after every
 frame
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
Content-Language: en-US
In-Reply-To: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Update the number of received unicast data frames and bytes every time
a frame is received. This is what the PCI and SDIO drivers do.

This has an influence on the power saving, bluetooth coexistence, and
(in a future patch) the use of RX aggregation.

Tested with RTL8811CU and RTL8723DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Rebase on top of the latest rtw-next.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 1c40d46a7eb4..10f1d724370e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -581,6 +581,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 		skb_reserve(skb, pkt_offset);
 
 		rtw_update_rx_freq_for_invalid(rtwdev, skb, &rx_status, &pkt_stat);
+		rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
 		memcpy(skb->cb, &rx_status, sizeof(rx_status));
 		ieee80211_rx_irqsafe(rtwdev->hw, skb);
 	}
-- 
2.45.2



