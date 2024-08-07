Return-Path: <linux-wireless+bounces-11107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137B94B2F0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 00:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D872832D1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1F146A7A;
	Wed,  7 Aug 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRgU569f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7F12FF7B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069242; cv=none; b=eAkoaXixk3F9pz6o5rdPNPBYf9pFRyDmbdbWJoIs7z8sHlZG+tuVXMvGR695FGo6z7IXybektIf1+KBycgQ4PE9d8g4U4o3C/yCeb3xB/zCSafSZIxy3NYmBvf3yKegiH4YNsrPZW65yDWhpIWKDErjBshl2gHoudeHRLruKX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069242; c=relaxed/simple;
	bh=8mqYTtW3gox2/aGZnKMSjTdE00CmM3stlXdyhG3lsKQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PinOQtAUOMMk8yRG+sckFQF/eMGFk01Y4q7IoLMmrGtPbPowM+HDhpg3Hl/H3llX+H7Nr3j2QI39NWow8h6nrE1m/z3BiGDt5dVt8oFjoc7Vs/ui28Vbl6F5Si8P0pWpCjt41oNmeRAtVj7CCupm6rMjLqmnL7qYOQuQWvt0ofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRgU569f; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so35144966b.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723069239; x=1723674039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M6crcIQrQbAt+iJaI1484xTdIov/RSKa/6ANwXVUE48=;
        b=hRgU569fPmdlJmQ2NuKRps7ANHifBg7WCihOjlK9LrLiijicj2pGC3o7SlIr4juhmf
         KTd9Yvtm3oJ1XQ8OJPW9AKdovorIc+cFLlzoguaJPqBD9zOhmNAngT4hMS/TepROLAK+
         4Wworb4W8KjF4ihn/+fifxSpR4LlxxQI0eWAQ/2VjfN+vUc81GkReNja2nZLQq8ufuVS
         9knDoVZiEsWwtT0ARDd6+knZQVFXyiB+DI6UfcI58czScvXCzmzq/cARnq+nJaMsC6Cs
         blXyDe701uBYVSqfIHhASxMpCB1q49ar/GjWTLD5X655+WA5SgVW5Y+is7GEtqfOeFr2
         +S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069239; x=1723674039;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6crcIQrQbAt+iJaI1484xTdIov/RSKa/6ANwXVUE48=;
        b=p4m4741R/nfhHGWQK+PivLTHgmlIqggGGk5gr9JutMYZkkK9xtiKfZS1TyGjO0FvzR
         S4s4cSN63w2+dYmaM8r2DYnGQTGw5R9QlHNrDFADxnPNzFtlTrV3inZJlHp1DJRirKgi
         VNEewBns3RBWjHzH6U4KYWXur/JSHB1GjavZPBfEGrte6A4GBOm095ZeN20cxqfo86UN
         YEiYKQtSt0koxrqoYoxSFSwV9Gg9dp/b7V27ruuAYe9Avto0/Pl4FYQOwlwea13H9II0
         h2zw4UbDtIgPyP/T8e8tOiGBk/S0NmBOozNyY9+X/xLHKaPql6pTCUhY47jcKiCFG41v
         Tk9w==
X-Gm-Message-State: AOJu0YyqGcYzQ7da7BVH44Y5km0KTjhPr2spWzpfJ0P/oyFrJdcX9Z/L
	5/3hNW8bTYt+VPV+lU0cExixoFkKAMXsTgrbh7iiyGK+56OsX6j/TRYSbg==
X-Google-Smtp-Source: AGHT+IHhav/14Vhc39m4sbeFLxP4P3rtW5voNC5t4K9nbcLBtZ/xN7JaZc6i4/pNXIOSxsKgi3YdMQ==
X-Received: by 2002:a17:906:ee85:b0:a72:8762:1f5d with SMTP id a640c23a62f3a-a7dc507f309mr1359961066b.55.1723069238605;
        Wed, 07 Aug 2024 15:20:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec7173sm670884166b.204.2024.08.07.15.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:20:38 -0700 (PDT)
Message-ID: <75a2ca52-8f01-45c5-926f-d3a68ae3b284@gmail.com>
Date: Thu, 8 Aug 2024 01:20:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/4] wifi: rtw88: usb: Update the RX stats after every
 frame
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Content-Language: en-US
In-Reply-To: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Update the number of received unicast data frames and bytes every time
a frame is received. This is what the PCI and SDIO drivers do.

This has an influence on the power saving, bluetooth coexistence, and
(in a future patch) the use of RX aggregation.

Tested with RTL8822CU, RTL8811CU, and RTL8723DU.

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Mention testing with RTL8822CU.

v3:
 - Add Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

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


