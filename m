Return-Path: <linux-wireless+bounces-11040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3569394970C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576E11C20AA2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367412A1C5;
	Tue,  6 Aug 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHgoggsG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCB3D0AD
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966346; cv=none; b=Ax8qVb1I5hg9q8hPmD1zq1RroG9Sjv5zA8v27pwHD4QK8mdBOQqlX4Pr3tg4ot4ufwwIYnCiDfcw36CSuayyfkthGfYCcYhUW5R5sKjrPSORSQhA8FWeNcmBYa0BYbFpEqqhx8UNmigLW0N0y+FQ0tnlKikWsz9tuNxMlAya3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966346; c=relaxed/simple;
	bh=qwp8f/6oLNNoDKE8g2OuXvofWoHsRonlEQIfZJgviyM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SANJbs3lidFB/xa9WDakjW69sMXEP7PM1YRzjdGI/1FkzIqzz+CnPd2syPqS9zU5g55NmcwbSdaZnahtq/n5870DZsIADIs5FUMPZDZaV6kZPimqDMVbcR7i7jrZbB+48WveaxI7NXJamKfVFemQ0udaM4xrdGBdL1ZRcgtVg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHgoggsG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so2207057e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722966342; x=1723571142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njw+nS9DRHdxmEl5+QU5MdQhy7Zg/xVhGhLV8YKYLH4=;
        b=aHgoggsGXhOjtR6hkVffssRRSM9xOPMpgFjzZY1goisalhAAyhHZ1SiVlwBIObTv10
         oHQ8Hewr+YPkdy7OeDxKsMFwqnDXdrLkC5iirvg6nOeuK9swIyOIt43who0EiAb1GLD7
         hjeDl7ci7YRZiLarpA8X1JLBLggHpCemFyMycvPIOob16WORIqt6OzpWDUi6sAFRUHtC
         UVtr6cHUE1+qfhA/M0CZYEi6s++osfKLESzk4VeDZbtFULOED1D7lTcZyWuVpafYgnU7
         lxWlMLec3NAz+d2mFhNBmfB1Xbg589jHyDPNd8EU9UT6tImh2FUy61zB+3mCRtWpAFgw
         sOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966342; x=1723571142;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njw+nS9DRHdxmEl5+QU5MdQhy7Zg/xVhGhLV8YKYLH4=;
        b=gPfWDBB6bI0hs/YUr9TXrM1YynWuUMSgZ4oYhH/Nzl1cSA5PrNVrIZ3BV5metUq9GB
         fg6/UhXnrh8RRTBsntCazOgH4Z/5XB0Xla3UzC9bC2Fj0yuokL/3z8+Bz43FTjZu62WT
         9cQqsIRc18ruPKqOUY6kVu3goWN0m9DKX3+qEUZkh83fiud0jidESAIo1i7e+PbU9K1W
         7G9N2Ix/uC1xhAUZp+1ITQmMpzWAkaroVLg7IxpvcQC38w6ndfj0ofVeWKD8xxwbE7nq
         nUB/nt/sZM+OCIR8ye8NeZw3Q4aZX9mFVuUjgbL+5RWkSltLkglRt1WQzoHG9foynEQT
         xWVQ==
X-Gm-Message-State: AOJu0YwvO2E+Ve49CHJNA62nlM4UQuv1mZC+DzEUwzBqRqqpFFqBb/dQ
	Nj+/fQU2ldyL1mTgOpDMMKiKRgYJVvloY58FzxurVOyIDOX2O00i+DXd5A==
X-Google-Smtp-Source: AGHT+IGeNKrXGNOm9/NBB2LK9a6wBJ6zDpk/QRkcPIw3AshlumdKqKX1yGh7tfgF22z/TUiQIbAQoQ==
X-Received: by 2002:ac2:4bc1:0:b0:52c:c9e4:3291 with SMTP id 2adb3069b0e04-530bb3c193fmr11008014e87.60.1722966341976;
        Tue, 06 Aug 2024 10:45:41 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d88650sm561377766b.152.2024.08.06.10.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:45:41 -0700 (PDT)
Message-ID: <489fdb38-e191-4f73-98b5-882e49b2f3c1@gmail.com>
Date: Tue, 6 Aug 2024 20:45:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/4] wifi: rtw88: usb: Support RX aggregation
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
Content-Language: en-US
In-Reply-To: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The chips can be configured to aggregate several frames into a single
USB transfer. Modify rtw_usb_rx_handler() to support this case.

RX aggregation improves the RX speed on certain ARM systems, like the
NanoPi NEO Core2.

Currently none of the chips are configured to aggregate frames.

Tested with RTL8811CU and RTL8723DU.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Don't initialise next_skb.
 - Add Tested-by and Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

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
+	struct sk_buff *next_skb;
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


