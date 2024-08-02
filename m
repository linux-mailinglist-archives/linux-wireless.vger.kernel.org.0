Return-Path: <linux-wireless+bounces-10874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C089946519
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16AB28172C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD0481AB;
	Fri,  2 Aug 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVP90H61"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C681396
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634464; cv=none; b=P4ORykDlbWEZf8NT33vw4ekqhWdjsJd2TCVPcSHGLDR1S7j5ofK2GXN1uElw/Wlh1AnqilQZhsMrBpcb4R7lBXimhYihhBCxJubUdWeMj5I0hwg1gJr7iQQ4kbo/jEWnrmXtICsVou7D7vB5PuhtTaOaMeX25rrOrBzIjAQqd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634464; c=relaxed/simple;
	bh=XhbQEiol8HdUA4uf31CFHHLOjvpW4eppA9VS4mfoTI4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IH2p0V+ejkdHZAFPvuSqQWMqkuoasOG5KtjazLjOybD7YnHeTUB/6jOEhcy+1Anb4eQEqJTIoX/fMC4/8k4ypXbYgrY+rfYnS87bGog8vBNk0/1T/ZHv3ZSrhcY4ivJfA6NgddtWQ+JZKdVZkcoFV0rZGiGSWhoynP4vW1nYWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVP90H61; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a728f74c23dso1106254966b.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722634461; x=1723239261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JXGRikJbmkktOV29addA6aC5OBALJTXn+coH6SIDJaE=;
        b=GVP90H61N3GjSqfzmhAojGrqUnsJVZUIitxuhIkWNu5fo/4nGGopd0r+mJPIoxa3hz
         Qdo9Bcqtl/38oTNWgGfH8ZFdIZbUj5rx943EbH+Y3MZOxVQzfzsc41ipOcAOVytzWpWG
         DRxXWwq7mGbrZROsy50hzhk1hkybre5WaDyKlx9SRer0ueq5Fg/YR32Xkam+TXr0tAQh
         NUuUvnVHBu4BQ6W/oTKynV5mMRgTBppxxmQJZpeB4jzW3oXymIVyeTQHelFTYQN2uprl
         2At/R9F19X8tgKyC0wh861N+UoKiXU6EgWAXTWzJ4CkGVtWNalBMNmm3pAnpBjTiPScv
         KFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634461; x=1723239261;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXGRikJbmkktOV29addA6aC5OBALJTXn+coH6SIDJaE=;
        b=VvBh/luDSax1e4yQdaG+lR57KEsZ6rrNzVQI6Qy6uv36cidDgrHevEhXbQzzMfqCUb
         h4xML4hwJLS0kG/Hzn6oN6/EXt+hGfzrbxUiLAeI1EA2V84HjS5+ftDCUsdq0aIxD4tj
         GZRw6WoxdXxKzBP913PS6YVPXbbVEb5uOZ7ycv3fwkJGgyb2F98ny1UHiQd5kD1i/Rs2
         ZSNDQiUR+7ZDRtUsKvviN79oBvFhVwCkI4F3kR9uMRdkx5UvnD1Bn9fIHmDuGbUOHtSc
         8rBF4seO8zlB2sa4WDBNgOx3tShPwppia63DNRZjyATn6myh/mRozjMEjp1OF2Po9ezm
         8rlw==
X-Gm-Message-State: AOJu0YzIJOIJQWOo3rQaeBMt3Fyci6GNp8aB3pOKgvzxJ5QMBYLKk7EG
	I+St+xj3pJ0lB2FtKn9Bvl5fuFpI0vfZCpJo8wQ7ICIMRNT+UgxS2lCk/A==
X-Google-Smtp-Source: AGHT+IFacnZcm6mnqTDyWmkHKUOKYoPmoqTj5Rx255QYIJaPzedCd+3u4LZR1TzteMDDpfkU4OhcdQ==
X-Received: by 2002:a17:907:3207:b0:a77:e2e3:3554 with SMTP id a640c23a62f3a-a7dc4e0f5eemr280340666b.28.1722634461220;
        Fri, 02 Aug 2024 14:34:21 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d42825sm139293766b.123.2024.08.02.14.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:34:20 -0700 (PDT)
Message-ID: <ac43a1bb-d735-43df-b6bf-41c44148c9e2@gmail.com>
Date: Sat, 3 Aug 2024 00:34:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/4] wifi: rtw88: usb: Support RX aggregation
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
Content-Language: en-US
In-Reply-To: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The chips can be configured to aggregate several frames into a single
USB transfer. Modify rtw_usb_rx_handler() to support this case.

RX aggregation improves the RX speed on certain ARM systems, like the
NanoPi NEO Core2.

Currently none of the chips are configured to aggregate frames.

Tested with RTL8811CU and RTL8723DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Simplify the code and make it more readable.
 - Rebase on top of latest rtw-next.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 61 ++++++++++++++++--------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 10f1d724370e..4c7ba5c76a57 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -546,11 +546,12 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 	struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_work);
 	struct rtw_dev *rtwdev = rtwusb->rtwdev;
 	const struct rtw_chip_info *chip = rtwdev->chip;
-	struct rtw_rx_pkt_stat pkt_stat;
+	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
 	struct ieee80211_rx_status rx_status;
+	u32 pkt_offset, next_pkt, urb_len;
+	struct rtw_rx_pkt_stat pkt_stat;
+	struct sk_buff *next_skb = NULL;
 	struct sk_buff *skb;
-	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
-	u32 pkt_offset;
 	u8 *rx_desc;
 	int limit;
 
@@ -559,31 +560,48 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 		if (!skb)
 			break;
 
-		rx_desc = skb->data;
-		chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
-					 &rx_status);
-		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
-			     pkt_stat.shift;
-
-		if (pkt_stat.is_c2h) {
-			skb_put(skb, pkt_stat.pkt_len + pkt_offset);
-			rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
-			continue;
-		}
-
 		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
 			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
 			dev_kfree_skb_any(skb);
 			continue;
 		}
 
-		skb_put(skb, pkt_stat.pkt_len);
-		skb_reserve(skb, pkt_offset);
+		urb_len = skb->len;
+
+		do {
+			rx_desc = skb->data;
+			chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
+						 &rx_status);
+			pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
+				     pkt_stat.shift;
+
+			next_pkt = round_up(pkt_stat.pkt_len + pkt_offset, 8);
+
+			if (urb_len >= next_pkt + pkt_desc_sz)
+				next_skb = skb_clone(skb, GFP_KERNEL);
+			else
+				next_skb = NULL;
+
+			if (pkt_stat.is_c2h) {
+				skb_trim(skb, pkt_stat.pkt_len + pkt_offset);
+				rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
+			} else {
+				skb_pull(skb, pkt_offset);
+				skb_trim(skb, pkt_stat.pkt_len);
+				rtw_update_rx_freq_for_invalid(rtwdev, skb,
+							       &rx_status,
+							       &pkt_stat);
+				rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
+				memcpy(skb->cb, &rx_status, sizeof(rx_status));
+				ieee80211_rx_irqsafe(rtwdev->hw, skb);
+			}
+
+			skb = next_skb;
+			if (skb)
+				skb_pull(skb, next_pkt);
 
-		rtw_update_rx_freq_for_invalid(rtwdev, skb, &rx_status, &pkt_stat);
-		rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
-		memcpy(skb->cb, &rx_status, sizeof(rx_status));
-		ieee80211_rx_irqsafe(rtwdev->hw, skb);
+			urb_len -= next_pkt;
+		} while (skb);
 	}
 }
 
@@ -627,6 +645,7 @@ static void rtw_usb_read_port_complete(struct urb *urb)
 			if (skb)
 				dev_kfree_skb_any(skb);
 		} else {
+			skb_put(skb, urb->actual_length);
 			skb_queue_tail(&rtwusb->rx_queue, skb);
 			queue_work(rtwusb->rxwq, &rtwusb->rx_work);
 		}
-- 
2.45.2


