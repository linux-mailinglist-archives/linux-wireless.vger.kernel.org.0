Return-Path: <linux-wireless+bounces-10587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4793E917
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 21:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8006528166B
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50453B669;
	Sun, 28 Jul 2024 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7mH8g84"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA38C06
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722195758; cv=none; b=U78x+CS39Y2++nVrbx+9N1eUycps5GgBg89MtSZBT4+unya4vRY7U6UejbxQWUwllHfU2fWWfSWTR/6UHV/J/IZe3kxsMc7hYO75ZXL+OGryiDgKD5zl7dNS6R/Lp+p0xnGhaxoj5Sw3AKmOgK2nSmEOGEpaO1TtJ88wWxzSEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722195758; c=relaxed/simple;
	bh=6zOTC0cmn+UnzQ/wHkDqJnGeuxUEn5PyfeUKWouydX4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G6yB4plHsbgGeY1QxobCWL6XylOWgP7aUSmyQOgT9BRF943vXC2F1BP80iVkFG+QpFqmNvwrXPqoe9ua7LHPBGHsTJPc4eXS+sLNfBHB8A/GIQ2uuUVcNm224Zfm0wMXguOVfLap/2neZZEVzG4uaXJcCMX3VW+Xbx4QXSEvnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7mH8g84; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so4313065a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722195755; x=1722800555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2rGEQ1q8wDYD248t6Z/UJo8GkMRvxVZQZMJvH6xmo0=;
        b=k7mH8g84+IAUoDJ+WiySI/9fYR12qDjVlgySy5YAbQJHj1ViMp4CWl4n5mk/UdsJIP
         BU2yEmdbr1V74tfWWaFLchkBTfzxCIAYUk7S1AGpzjyaYStnFFwYzPeswOAbnMIy09Et
         TZi6/SRlUSruH4L++IMi4VP3t1v/vpmYcujiTDJulanXjdCx5XYTFr8bQEimIoQJB2He
         hpR6Iii8UMIVYDYnFVDYPtG91yJknUreSVCoQduvKoJWmbqXpHdr1ap8CT7gFgLImwPo
         DUfvZAGzXdzF2yUjRldaB0487xjK3gJeJVmrE3udycIwuhImgvvzsXBKGfIXua4SudfV
         H7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722195755; x=1722800555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2rGEQ1q8wDYD248t6Z/UJo8GkMRvxVZQZMJvH6xmo0=;
        b=OtMGRDc1wEd8VYat+MGXiznm3Key7eEIYvrJd6bs4vPLV3yHTM0K4JzMkoBxArKKiW
         QKilr0E5pLG+nmtLvB/SDpbsaxWkP750TyK0hJWLDQquhGJQ+pQ4kT40AznBNoTm6BlT
         sAfD/KE3jPx5Yjv150EE5WMf/4F8claPWFFOkjl/ZpSRFy/BPkEq84VMxPgJiMpdXgH/
         4ZNF+ID/E3l+Jd+9zCaDT2o7lgF9sW0OUW258Cn8NzEn2lhUTVmQpQk+JEOH1EwWE9a5
         G+ZphvKlzYs2qKHiLGCIBbc+2BrH3Qu32TbrCIi+IT5EvfBUq4F0HsSXMbbmZEeSHfL6
         WcYg==
X-Gm-Message-State: AOJu0YwNmGwgihjbdk4GmHFQ64apV/aGJdBYFcfwzYSG0iT1XdvwP7sx
	NyIeA8wUvPyUXccgBwsuXL/ABGb/7xkIL93gdR7FFuM/0kN5iFjIuyoFwg==
X-Google-Smtp-Source: AGHT+IFdbDVr4MEFulQST5R269frxBCg7Om7qmWSGVadKAdVOeGVY9WjnjS9dP9xDDS9JJsVVbPaAg==
X-Received: by 2002:a17:907:86a7:b0:a72:af8e:15af with SMTP id a640c23a62f3a-a7d400d71e4mr449136366b.49.1722195754430;
        Sun, 28 Jul 2024 12:42:34 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9068esm414781766b.153.2024.07.28.12.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:42:34 -0700 (PDT)
Message-ID: <a549707a-09f4-4787-8111-65cc266675d6@gmail.com>
Date: Sun, 28 Jul 2024 22:42:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] wifi: rtw88: usb: Support RX aggregation
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
Content-Language: en-US
In-Reply-To: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
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
 drivers/net/wireless/realtek/rtw88/usb.c | 57 +++++++++++++++---------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 73948078068f..d61be1029a7b 100644
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
 
@@ -559,29 +560,44 @@ static void rtw_usb_rx_handler(struct work_struct *work)
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
-		rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
-		memcpy(skb->cb, &rx_status, sizeof(rx_status));
-		ieee80211_rx_irqsafe(rtwdev->hw, skb);
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
+
+			if (pkt_stat.is_c2h) {
+				skb_trim(skb, pkt_stat.pkt_len + pkt_offset);
+				rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
+			} else {
+				skb_pull(skb, pkt_offset);
+				skb_trim(skb, pkt_stat.pkt_len);
+				rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
+				memcpy(skb->cb, &rx_status, sizeof(rx_status));
+				ieee80211_rx_irqsafe(rtwdev->hw, skb);
+			}
+
+			skb = next_skb;
+			if (skb)
+				skb_pull(next_skb, next_pkt);
+
+			urb_len -= next_pkt;
+			next_skb = NULL;
+		} while (skb && urb_len >= pkt_desc_sz);
 	}
 }
 
@@ -625,6 +641,7 @@ static void rtw_usb_read_port_complete(struct urb *urb)
 			if (skb)
 				dev_kfree_skb_any(skb);
 		} else {
+			skb_put(skb, urb->actual_length);
 			skb_queue_tail(&rtwusb->rx_queue, skb);
 			queue_work(rtwusb->rxwq, &rtwusb->rx_work);
 		}
-- 
2.45.2


