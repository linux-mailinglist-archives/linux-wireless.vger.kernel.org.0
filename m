Return-Path: <linux-wireless+bounces-7142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6D8BAB0E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593861F230BA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03F7E766;
	Fri,  3 May 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9BTj70D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E61509BA
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733613; cv=none; b=oThcTf3SN85XbXewCz6kQ3//Mv1JgFHsa2OO0SuvwWnMypB6BDhDYoJHSyZVIb2uVjmwoOOon6x20OiNY4IeEiPbTYg+Z0L6VQimuTgSxKTSEv2MNMa3Rqsj3xfmgEzzPmArKS//ZWkG7VSpgYtXSfb89Qgs2sCjySK6JzubjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733613; c=relaxed/simple;
	bh=qQX+kcBuMc+I4QDpBxoCwah+OgLXr+8NB1crfvr2PIs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RXrBrfLqD3PABBX3/kR23J+fIeqXmFi76lIJIUfp0FKSQ4kYC7PpVGz1hq895MznzzfoSmHChL/YZ9pnc0Ev1vIiEcNjUz3Q0+FWRG+/lMJn5W+SEhzdjAvMIar/BhUEehXOpLbD4AB+lICPoczQKhx0sb8RCfWnOMA3wyJJUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9BTj70D; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ef64d04b3so3553389e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 May 2024 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714733610; x=1715338410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvFTjeJLwMyWBoUgB5KjOTLDJj55PTKqu66k3Ek6xFo=;
        b=Y9BTj70DuiVpQNz/muCt8qSSNBZDDuLU/gZGZcY+rcrVJp/TX/5QhtcDRuwXSUoUsP
         9HV2LbR9J5NTyBhg+Y8f0Cr6/ZMYOuWfNCN5T6lgM2zKQZwHFrWPGLUBA7Y09g3Jjrqn
         RVK0+oBxx6b3Iqa3Q41foU5uozpSTvsBTmnUTfrZcGegn8YyjUkqAJ3PYnfinDl+59xD
         FLG6JUR9SKi/Tzz8+BtKGaMK9jIXpWLvx50rRjoxHkYGZsArawvaY5ldoExZtUGhECSz
         MRQlSF21tfJFVhfxLxQhCL0trisWx5a2O3Gn7VPDYGcJhmh821uDblhM6PC+GzRpzUNr
         VUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714733610; x=1715338410;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvFTjeJLwMyWBoUgB5KjOTLDJj55PTKqu66k3Ek6xFo=;
        b=FNSJoFGgKA/z5uk6597BlJbke/MymQMOPYEkZlALlvYSc8EnkN4ZAR/eG+MGvrv49C
         jwkReYGbZCXa14cecSrz+ulJJNfrXzRH1GnL6I8xuA1DdO64owaJ+0AeBMTNigpnih6S
         pXWDp5G7KxYXV0kHiVCVxJDskQSfqOL4CLNudaOGduSaWECvWjbVCGtxFpmePBNLNbkw
         lTIaF8HZ6JoxIqEb3e1mNL/WuNFgeZtTfVbYCwmZmiLzL8jmQzPnqnEf48gu8Bwq3HYR
         B4PjWUUBzLl3I/Bstm9A2Nq+jo0fr9I/kRluf4f7Ov6mK6DpGG2zA7nqA+dsA6+Gq5V5
         4Oxw==
X-Gm-Message-State: AOJu0Yws56PXWcR2gHBqSXGaOGvom22/0jqOCiLkSrZYE6kJzUogwDrS
	P5LkPAIJaUOHpeer/Plpku4cAD6MnJBz/GHT8z/Mu1SEf/5ULqM4AYsOXe4Y
X-Google-Smtp-Source: AGHT+IF/2CpHYUqmmBwgf4np8mISqTuQMsbTpAb+4uVvFWIJxnswlc++5Oe2FPw8SwXDgvFHu4qFGA==
X-Received: by 2002:a05:6512:131e:b0:51a:f11c:81db with SMTP id x30-20020a056512131e00b0051af11c81dbmr2451885lfu.30.1714733609610;
        Fri, 03 May 2024 03:53:29 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id o3-20020a1709064f8300b00a58ea7cfeedsm1575184eju.62.2024.05.03.03.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 03:53:29 -0700 (PDT)
Message-ID: <2479507e-3946-492f-857e-83e54969aad2@gmail.com>
Date: Fri, 3 May 2024 13:53:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtw88: usb: Simplify rtw_usb_write_data
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
 Larry Finger <Larry.Finger@lwfinger.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The skb created in this function always has the same headroom,
the chip's TX descriptor size. (pkt_info->offset is set by
rtw_usb_write_data_rsvd_page() to chip->tx_pkt_desc_sz.) Use
chip->tx_pkt_desc_sz directly.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Don't touch rtw_usb_write_data_rsvd_page(). It needs to set
   pkt_info.offset after all, otherwise RTL8822BU and RTL8821CU fail
   to upload the firmware:

---
 drivers/net/wireless/realtek/rtw88/usb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 1dfe7c6ae4ba..a28f35a03b26 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
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
 
-- 
2.44.0



