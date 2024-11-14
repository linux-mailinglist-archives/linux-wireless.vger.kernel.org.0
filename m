Return-Path: <linux-wireless+bounces-15307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E609C95C8
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 00:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16A3284B36
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 23:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C261B21BA;
	Thu, 14 Nov 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/6POWrt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A811B21AD
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625606; cv=none; b=o42EhaGDyWUJBFOFhnQlSAmSjnV16uSnARBoKeNvCbmBxlCsntitGlHAO3/Dio9JCr674LCohPkIslTNXwhUS8CD/5Ocrtm22Pp2if5L4frvOfHZSeq3QRbu4ijYZW7D0xd/H10GzkeBCTgicxv7YZ+z4b5ijhZ9vI0cTtpRJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625606; c=relaxed/simple;
	bh=ucCoq1jKidFefvnUmPsSpe+0bVgEVL60+ANv+4Dtolk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NFQRcsH5R62J1YZ06yKgBTG2BvugAQkOBZdacjBNH7wWK+G24e6iju0KFYCsZdJI8PrpuutGN8pdtboSKg0ZQWaUowNhkY5Zm64YSZZtSz3vieCEe86/bGrDNVUj8dr2Ctcw4fhSUeIa9CzjvfNenVN3OvulLiw8WuX9qihR2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/6POWrt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so143279966b.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625603; x=1732230403; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaeywDd4M4JI0+9/U3MqQGsopGHB0bH2W77Lq+k1fHY=;
        b=j/6POWrtLa/tZYA6anMlU5rfE23VKzpo+bYITYtc/DZXLDFh1drL6Z/OP7UAyVgdj+
         cXH1M8I+62pwp89vA1u+g7+/AgLaLknI4Gec/nQo/wkCRPEUL1Km+DHE8YQewpoSWeXE
         RNCkVNxKD+5hCBq+VGGL8+uVTBwHYCuXjJdDyw9F7U+eZuwrKMiROooGTfbLflGomX2C
         4jaXVy2mkbpLmkn3zlYYe7pOWyzhok01GZFsWXhc+Rua1dFNPopOj9iqA3rqB2M/V41R
         Ar/mCiV2jnNugwQxNqd9mnFb+F3U/w270zaokjhUQsmOOj0YeFsVTUtxuY6hHUH6y4lq
         kUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625603; x=1732230403;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iaeywDd4M4JI0+9/U3MqQGsopGHB0bH2W77Lq+k1fHY=;
        b=oL2cxkPsWMvus/J4Q5xdRO4cMHEAbEhL3NUYX1wn5XHtPhJctVEJEzumZZMObp657i
         /v1BnOU+3q5sinbvfJDs4IOcqcGXO+T6Tj8SfuJ+wrUPgaamDs8xK4k0nANbXPxzEzz8
         xpPG96DydHv+I1N4+VwkgtrD0s1rSnV6Tr61SiDaGj4vVe+/95EfyB2Bs85ZWvABCePC
         6k/TWSERooIXzMe6uvpkAXavGhUohFcrm8Lp0iI3YwmeqXbwqWL8vCqbg/II+86EOsi4
         WyvQ30sUg+x1nogeYpuy6KGscJkXFhOVZGMv9cYtBM4Xg6I2OqZGE81o4B3nime406Ke
         4LPA==
X-Gm-Message-State: AOJu0Ywn7Hn8M8RMhgJEuWvf52k6/BCBnNVAkICXKuQ9FxkSAnAdHTw5
	jDxHwygYtOVxX1rdERd66SsGJj6ywpfgrCvmrZgZiCV3tCso8fSd/7Zwpg==
X-Google-Smtp-Source: AGHT+IGD3zBLQI1kAXwUSEug3plhPDkEyWd0rqcKu7oHMOSH3tYTTEDF+T//NpUlv4ZVDSdNEk6L1Q==
X-Received: by 2002:a17:907:7f1e:b0:a9f:508:6726 with SMTP id a640c23a62f3a-aa4833f60eemr34839366b.2.1731625602434;
        Thu, 14 Nov 2024 15:06:42 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df51653sm110914566b.48.2024.11.14.15.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 15:06:41 -0800 (PST)
Message-ID: <28b09f4d-5271-470d-99b6-a0bbe0224739@gmail.com>
Date: Fri, 15 Nov 2024 01:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtw88: usb: Copy instead of cloning the RX skb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"iperf3 -c 192.168.0.1 -R --udp -b 0" shows about 40% of datagrams
are lost. Many torrents don't download faster than 3 MiB/s, probably
because the Bittorrent protocol uses UDP. This is somehow related to
the use of skb_clone() in the RX path.

Don't use skb_clone(). Instead allocate a new skb for each 802.11 frame
received and copy the data from the big (32768 byte) skb.

With this patch, "iperf3 -c 192.168.0.1 -R --udp -b 0" shows only 1-2%
of datagrams are lost, and torrents can reach download speeds of 36
MiB/s.

Tested with RTL8812AU and RTL8822CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 52 ++++++++++++++----------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 93ac4837e1b5..727569d4ef4b 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -7,6 +7,7 @@
 #include <linux/mutex.h>
 #include "main.h"
 #include "debug.h"
+#include "mac.h"
 #include "reg.h"
 #include "tx.h"
 #include "rx.h"
@@ -546,49 +547,58 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 {
 	struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_work);
 	struct rtw_dev *rtwdev = rtwusb->rtwdev;
-	const struct rtw_chip_info *chip = rtwdev->chip;
-	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
 	struct ieee80211_rx_status rx_status;
-	u32 pkt_offset, next_pkt, urb_len;
 	struct rtw_rx_pkt_stat pkt_stat;
-	struct sk_buff *next_skb;
+	struct sk_buff *rx_skb;
 	struct sk_buff *skb;
+	u32 pkt_desc_sz = rtwdev->chip->rx_pkt_desc_sz;
+	u32 max_skb_len = pkt_desc_sz + PHY_STATUS_SIZE * 8 +
+			  IEEE80211_MAX_MPDU_LEN_VHT_11454;
+	u32 pkt_offset, next_pkt, skb_len;
 	u8 *rx_desc;
 	int limit;
 
 	for (limit = 0; limit < 200; limit++) {
-		skb = skb_dequeue(&rtwusb->rx_queue);
-		if (!skb)
+		rx_skb = skb_dequeue(&rtwusb->rx_queue);
+		if (!rx_skb)
 			break;
 
 		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
 			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
-			dev_kfree_skb_any(skb);
+			dev_kfree_skb_any(rx_skb);
 			continue;
 		}
 
-		urb_len = skb->len;
+		rx_desc = rx_skb->data;
 
 		do {
-			rx_desc = skb->data;
 			rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat,
 					     &rx_status);
 			pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
 				     pkt_stat.shift;
 
-			next_pkt = round_up(pkt_stat.pkt_len + pkt_offset, 8);
+			skb_len = pkt_stat.pkt_len + pkt_offset;
+			if (skb_len > max_skb_len) {
+				rtw_dbg(rtwdev, RTW_DBG_USB,
+					"skipping too big packet: %u\n",
+					skb_len);
+				goto skip_packet;
+			}
 
-			if (urb_len >= next_pkt + pkt_desc_sz)
-				next_skb = skb_clone(skb, GFP_KERNEL);
-			else
-				next_skb = NULL;
+			skb = alloc_skb(skb_len, GFP_KERNEL);
+			if (!skb) {
+				rtw_dbg(rtwdev, RTW_DBG_USB,
+					"failed to allocate RX skb of size %u\n",
+					skb_len);
+				goto skip_packet;
+			}
+
+			skb_put_data(skb, rx_desc, skb_len);
 
 			if (pkt_stat.is_c2h) {
-				skb_trim(skb, pkt_stat.pkt_len + pkt_offset);
 				rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
 			} else {
 				skb_pull(skb, pkt_offset);
-				skb_trim(skb, pkt_stat.pkt_len);
 				rtw_update_rx_freq_for_invalid(rtwdev, skb,
 							       &rx_status,
 							       &pkt_stat);
@@ -597,12 +607,12 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 				ieee80211_rx_irqsafe(rtwdev->hw, skb);
 			}
 
-			skb = next_skb;
-			if (skb)
-				skb_pull(skb, next_pkt);
+skip_packet:
+			next_pkt = round_up(skb_len, 8);
+			rx_desc += next_pkt;
+		} while (rx_desc + pkt_desc_sz < rx_skb->data + rx_skb->len);
 
-			urb_len -= next_pkt;
-		} while (skb);
+		dev_kfree_skb_any(rx_skb);
 	}
 }
 
-- 
2.47.0


