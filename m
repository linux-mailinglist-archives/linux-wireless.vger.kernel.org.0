Return-Path: <linux-wireless+bounces-16552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C79F7013
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C72163214
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777516A92E;
	Wed, 18 Dec 2024 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgCPIE/+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186935948
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734561207; cv=none; b=LEqJBpH5n+9C8iHzbeolqt2YgvFI4kER3LNqx8TkvhErMYDHRVTVWj0L+2kaT+ssdv/9f3L0MXzhvRPEuIU1Bm6JuIJDS6j7YtyRK35qX41ETluMnjSu3eH63laHKwrmEs/NeLCtFDwxIrh31ynLoV+jeXSOeYWUsakHQ9x6lyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734561207; c=relaxed/simple;
	bh=gJti6UIvVj7b8u81nqgmnYFQJBtDHmYrPQbjgsdeW8M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=juJRz977X8f6fDc0opZGW7m1fHZ8o0t+l42Lrh9K1SZPVd2X9ICH5FUDP3AhM2rJ1OlUplv0liOq8+jO/JkwbD33/vvMRQs22q7+Anx5TukB0yV+VWYLhkxl5hTz22h8GaVJXndbpSIUAeae5qL+7Q7Wu8lmGgwJeRj0EK1gXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgCPIE/+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aabfb33aff8so40477966b.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734561203; x=1735166003; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1LtM4D+RAOANoTg5UBfWOeqCJ9YeYukS4mq2nMbLd0=;
        b=WgCPIE/+dEEi3CnrleIiIraZ538N1MOwjbouoVkIVRhJ6mW+jWquMHgfZHX9DuXFvr
         wR/xln4E0fxVsoHys697DBLYnx23pRbJBp2f76G5NlPijsDyRBTDRUCNLMH3CGhrO/Lz
         au+H0y57bwgjXRccn1wloOstiVCzfHyDt5yYZPyERagSmkRdu7962o8oP+OsL76GVnOz
         92CtgjH8wz6OjFyFa3bHAGR8YpwXaOnw+7ztT1EKPsLN1vX0iQhIZuwjQUhZf4wjpVMb
         FMWFK+sg8AUFUCpFq5RQjRuOikcLtyrue96WE7UDMzIp1G6Yfemy52dkn6DbN7N0J0Ok
         zkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734561203; x=1735166003;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1LtM4D+RAOANoTg5UBfWOeqCJ9YeYukS4mq2nMbLd0=;
        b=J2puxj1fsslN2rgU7FF8sqOIgDYawa66lks5G/AKxIsfLjVh1z78hXA0fF4jV9r4qC
         yitQ02AFyNzz05TsfcmAA8trddRZoTKTyx0v5mQ6KzyfsIoi3Z7vhqGhENDHR+V52p/O
         FgnMTrd9dlodpI7AESgQq+pj5o2TVNkq7DEIsIq4nSfX4wrDFUgTIn6ZFyBgXv6Hn9bd
         LGWni+l6KtCQ+jzxZfl0gCfp0eFOhWK/NqZkkY7wIVFIA/71fvlI0p/7uuJIq4OI3cKY
         8+TKTiMykpXKwszZ1klO5NxgmVpUBgp1X1BsgXw48fz3nbvCTQvfuh8JgYcdd/62m/Us
         zTJA==
X-Gm-Message-State: AOJu0YwFK70xJ1wZp96ZqBebGPI8e0pE4wGUlZoGZ60K9froF10wbhq2
	rXcmgqE/GMfzVsQXuodELVf9ZB1cavXV7kcYyu0FGvbnyNkr8bFm5MjIKQ==
X-Gm-Gg: ASbGncuQOpRLS1y0EdW0qiCd57f0aiAh8S+QLvBuk0fSOG5s9J/aki7Za5c32DmaXoD
	d2H1X1mXBpy715eO9zQrrak5JC4xn8kwgjUPjZigOKEZIn7gETSrIqn5ShLJU3TwwJmuFfVp9Sm
	QboSf3WRQuxnCwhtpBGut5lwDPkOyfH/tZUA48kgL3W2gHRhxKR1vgzltikbHUKdkLbi23foMM8
	zH/tn8ndritXrKipFKH65GQ2s09yB2co7exTTGe+YX7QZeqbv50pFiBJi2gMn4L
X-Google-Smtp-Source: AGHT+IHK1cmCBVU2spyi1HXsrmysqPUdkTt1tp5jQ9t/jImthkFlOLq56ElvFivVj9ZKNg9svx63aA==
X-Received: by 2002:a17:906:32ce:b0:aa6:832b:8d70 with SMTP id a640c23a62f3a-aac081134afmr85146366b.3.1734561203270;
        Wed, 18 Dec 2024 14:33:23 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ec32sm595133666b.151.2024.12.18.14.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 14:33:22 -0800 (PST)
Message-ID: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
Date: Thu, 19 Dec 2024 00:33:20 +0200
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
Subject: [PATCH v2 1/3] wifi: rtw88: usb: Copy instead of cloning the RX skb
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
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 52 ++++++++++++++----------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 34df371e599b..4dbd5167faa4 100644
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
2.47.1


