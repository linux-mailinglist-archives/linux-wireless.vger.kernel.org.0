Return-Path: <linux-wireless+bounces-11108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EB294B2F4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 00:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1544283290
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DAD12FF7B;
	Wed,  7 Aug 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWURHhzd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615C250EC
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069302; cv=none; b=CoNE8sTVcBTPLTDKJkDDY1n2pAlT4AMV1Uf53zktu/22r52UjmQcpQ2UHw6GA833fWlB1Hk4FbZcPesbzTdA8BIqefsTsFolE3255U/egpJjW6P4HRokJ9dbPi+6sPKhGIdWE8w5h0qEujqtIyLMn2LGTgAiVcP/NUz6QWhNDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069302; c=relaxed/simple;
	bh=pe6imP2VCyfnUczdiPVEqzNmSJaqMa3x8rEL/jewclU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cU+4T2GSM/f4dqRWETlJaQR03k42ru89zOimX5rdpcRHVYvvNYC6+6RNJ7hES8VwzDZZuCt8+5MQhhR1W3cYtohaJ3uZF+pYDI4RviZ5KJJ68i0eCoYYPBOkwZm/nXVh8hFL37Y+wfYZcwTKIvHQLJKDedVjpDYskpNeCdFjeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWURHhzd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aada2358fso235037466b.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723069298; x=1723674098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNYiS372C0zB0UDB3Hw6DFWhtABURfH2ZPnWnEEQDJA=;
        b=OWURHhzdwvNEVdrgjjFhl/sUzkBDOMEovpQ2sWRFrD8BylmukCpUaTqrFVcvTXsTC3
         waFEA76WufFE7azEGKb55rbxJ7pRIwVQgIf7E29kvOHIvIhiAAtDf71MwVurxgPVla7x
         sOq8MsdIhBTN+oFMk8VwUfAqyrAC6B626i33U5jKyByfEKxyjXwHVeNWt90Ew5rouKwz
         Y69Hbwtviii8tu77+f07YNkMl6xElrhDYgJv1vF60gkiKaDFJzVDW7OWeBCWlldYnhb9
         K9ysS6OR13O6bfKs4U2+NHQ3Xzg+VGJCJ03OXBLDiJcBDiIvbGUc3Fnb+Hw9TtGndWhF
         16Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069298; x=1723674098;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNYiS372C0zB0UDB3Hw6DFWhtABURfH2ZPnWnEEQDJA=;
        b=o9QWflgzEDOuXOwR0bezLRtN7uwmoW6O/rMul1bFFeXwxvT2afzfNNoKY59KrhVKGt
         AyHK84wXgMEPbE04xA+XfwUApUiKWHB1t/vSJxTWa1+csRKJ6ssgxIOebnvbeFOlSshh
         wlsxUbO/6lx8Gg0sa0veFu3Ii6PKvbc7soWIl41/Yurarr6AoN2f+ZAPeoaTLqGAVgpU
         oeIIJpoyj99bj0jHaP6MjFigsTERAYhDig1UkW6a/h2BBpHiOL6eJcyc5zfmo+MacNAE
         ep87NMdGWRQz2SKAamejg2z1FR6ZutswvfBSpgDU6IiQtEzD3vON9TsIYpq32vWwxRgF
         Cv/g==
X-Gm-Message-State: AOJu0Yyg3/g+A4xJhQiJfCyhIxkCbUQdLaaSIrd9WvyoMJke/V/E3dZU
	ydBioJtUORXtTy8AY97hnk5DDT3VLQnyvvJE3Bvzdi07ZBz0K2hsrCfvpA==
X-Google-Smtp-Source: AGHT+IFd9CoAuV7PgznDBl1+zDWCP2go+nz6tnTVUdsgyTP9wsIBb+UiA9Bu1owrFPcnvMCCnOm7HA==
X-Received: by 2002:a17:906:f58e:b0:a7d:c382:bcdf with SMTP id a640c23a62f3a-a807903616emr310294766b.10.1723069298154;
        Wed, 07 Aug 2024 15:21:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc4fsm680506666b.77.2024.08.07.15.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:21:37 -0700 (PDT)
Message-ID: <f845826d-de71-492d-9a22-e48c07989a1f@gmail.com>
Date: Thu, 8 Aug 2024 01:21:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 3/4] wifi: rtw88: usb: Support RX aggregation
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Content-Language: en-US
In-Reply-To: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The chips can be configured to aggregate several frames into a single
USB transfer. Modify rtw_usb_rx_handler() to support this case.

RX aggregation improves the RX speed of RTL8811CU on certain ARM
systems, like the NanoPi NEO Core2. It also improves the RX speed of
RTL8822CU on some x86_64 systems.

Currently none of the chips are configured to aggregate frames.

Tested with RTL8822CU, RTL8811CU, and RTL8723DU.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Mention testing with RTL8822CU and the effect on it.

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
index 10f1d724370e..64d68366812c 100644
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


