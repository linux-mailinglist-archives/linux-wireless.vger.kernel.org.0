Return-Path: <linux-wireless+bounces-7125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168908BA22D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 23:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61142827C7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 21:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478FB181312;
	Thu,  2 May 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhOs56xq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE91802AC
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684999; cv=none; b=LoRjg1buDC3u+0tndrvGFzIlfGZGDeaJIfeDV+heT3dI6XzaAKCwStq3WJ371XYm+MDLyN+M1wMqsbA6O6BV3NizLgkvkmlIESCo1ot6XJxZ/lQRJ0zJq+IcoOZHc5ShGEjh/b2CzU8uEQgQN9h5Pj+MxZ7j3BZZLmA0L/xQqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684999; c=relaxed/simple;
	bh=dMuYdhmet8MSwxarAxjbei0okS1rIFTACy2iCxSFSK8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sJ7EGbxbZN6omwJUlOv/1jJZ+UbqmlcbDmP9DOZzpfzMNiTZpVgzQTXk0rUUIwTNL0MencpAKa/mc+Da71L10nKjZw5iXWjSwwyJcXSTnnxaL3PlQdJpTuIaJcGjc6SbJN3XG0f3RUuOMSgbtedESxY2A0NW7Ll6q0LHG2FZ2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhOs56xq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso72278361fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 May 2024 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714684996; x=1715289796; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIKVoSFpeGqR86Bt3yVO+kPZXWTM7wBIBTqJd5/wanI=;
        b=AhOs56xqgFE6dozeoTmNAKspWXi2+FA8ma4pwEClAY17LBKbUOxtP0Tn8AV+mLDKH4
         qt3ov6Dc84p0xgs3fZ1GQKLfj4WId5tq1PrjVbrpHuEi5vVLYUc5CE+y/75qldqStmNG
         tCBabqp8sFmM818ClKYknrubx9lG8+rFa7t4FaWfPWXEU80ZlHGVmsTrVjSearFzBn1+
         KoExieWTl41NGYJ0ISuw0z+sfATFs8UDdykTZphNd3pWZgep76R5Cf09BYOWMDZfmFPA
         RMSJO/yg9FUgPvYQEx1rX0UxkqyteBZf8EqDQZeW6fylxiHhxpaxPjcZ91pV4nYy2dFL
         RdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714684996; x=1715289796;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NIKVoSFpeGqR86Bt3yVO+kPZXWTM7wBIBTqJd5/wanI=;
        b=pIKEmRAdf+Eq0tokAChKSZoH9rTPBqnDiDRCEhq1LNDicLsEUp0lUVqw08AfAsvJZC
         2h0Rv3KqLhq1GtX8kxxbP0MgUpl1hYS088mxaM1JBucTymP6o94NEGDJkeSSNQdIiIU8
         t2Pt6pPLeror6vOpGB+o5QNlrUr87jlbQXsGk4jL9VVs5NhUAeYpLg7ETuAxR3OloC0z
         r0Orj8aYhgS+5ONxUgCM+9YnpvGyX89Bs5wALqvcNP7dBmd+WJl3P8vduoD8l0ttOUvD
         IMs+desBo2BK+LE0se5a3waT7aQqbqnCTEPr6+up7gQntKZj50/KLz+y2V9CcMuvEaYl
         Sy3g==
X-Gm-Message-State: AOJu0YzvcFjS+ldx26Fix3Kcq0BWQdvCrMltuAUEeZBIkk8i6lPAcXVV
	fSMum6Cd9jBX2uqd2MCxSDdfRUpf4A4djDMvoZObAAP1yDVJBCZ1EsLinu6h
X-Google-Smtp-Source: AGHT+IG5mmvLYf3oyIiO+R8Imw3rmKqgc5AAixo/w22o/R+07TD4M6PFAsYLkgQDufcfNVDLoWZDhA==
X-Received: by 2002:a2e:9bc4:0:b0:2df:98c3:95dd with SMTP id w4-20020a2e9bc4000000b002df98c395ddmr490800ljj.22.1714684995465;
        Thu, 02 May 2024 14:23:15 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id o5-20020aa7c7c5000000b00572c25023b1sm923737eds.0.2024.05.02.14.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 14:23:15 -0700 (PDT)
Message-ID: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
Date: Fri, 3 May 2024 00:23:13 +0300
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
Subject: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The skb created in this function always has the same headroom,
the chip's TX descriptor size. Use chip->tx_pkt_desc_sz directly.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
This is the patch I promised earlier:
https://lore.kernel.org/linux-wireless/cae2d330-a4fb-4570-9dde-09684af23ffd@gmail.com/
---
 drivers/net/wireless/realtek/rtw88/usb.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/usb.c b/usb.c
index 1dfe7c6ae4ba..ff57976b9d3b 100644
--- a/usb.c
+++ b/usb.c
@@ -440,23 +440,21 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
-	unsigned int desclen, headsize, size;
+	unsigned int size;
 	u8 qsel;
 	int ret = 0;
 
 	size = pkt_info->tx_pkt_size;
 	qsel = pkt_info->qsel;
-	desclen = chip->tx_pkt_desc_sz;
-	headsize = pkt_info->offset ? pkt_info->offset : desclen;
 
-	skb = dev_alloc_skb(headsize + size);
+	skb = dev_alloc_skb(chip->tx_pkt_desc_sz + size);
 	if (unlikely(!skb))
 		return -ENOMEM;
 
-	skb_reserve(skb, headsize);
+	skb_reserve(skb, chip->tx_pkt_desc_sz);
 	skb_put_data(skb, buf, size);
-	skb_push(skb, headsize);
-	memset(skb->data, 0, headsize);
+	skb_push(skb, chip->tx_pkt_desc_sz);
+	memset(skb->data, 0, chip->tx_pkt_desc_sz);
 	rtw_tx_fill_tx_desc(pkt_info, skb);
 	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
 
@@ -471,12 +469,10 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
 static int rtw_usb_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 					u32 size)
 {
-	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_tx_pkt_info pkt_info = {0};
 
 	pkt_info.tx_pkt_size = size;
 	pkt_info.qsel = TX_DESC_QSEL_BEACON;
-	pkt_info.offset = chip->tx_pkt_desc_sz;
 
 	return rtw_usb_write_data(rtwdev, &pkt_info, buf);
 }
-- 
2.44.0


