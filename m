Return-Path: <linux-wireless+bounces-26084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75062B18834
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D282D188B0FF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6B91F463C;
	Fri,  1 Aug 2025 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiFSusSs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720081F4628
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080661; cv=none; b=C95j4sNL+qDcAAmba3Ho3dthp5gOf4Ny/SkO+EguG/wpAGSWjjdP4S53xFUYf1dzOcxJVCKxpp1BEbb2qLnmGKy7OnODlFGGdBJQS2rumYpdziSzvAQjzXRGEThUNRAVUEBK2sdiM4ociw9jpyojgK+eQOHnTyTdifv9WoGAm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080661; c=relaxed/simple;
	bh=GlWm9A4QR3tu6+z2qP5erUciPALDdzInE5DBfMnQBSA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GfPTOBhwLqY4ukM9RiAEwatsfVX5CmyXscKeY/xc+K0d99RdYXqFlSgq37TBng5T0T3NeA+z6lu0Fc4p1uzimy1PIpyqbN8jfF4+tpliYKHVGB3NCgP+MG8fJG6pHXBk23NlJ4sq+DYx5jDLeYos8SuCm4iDVfdiNR+e/rCKsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiFSusSs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so1961292a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080658; x=1754685458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5p4KKE/o6b0bUBzHi5YGrQiPMCLg1LTQYQPkDXqvsvs=;
        b=fiFSusSsw9WDYbCsnmmdh7g0iebIcOcQZm5kpMmvLgIdZQso1OAzMIypEhoWQOW41x
         d56q9psD9m0Ch0L88abuh2fQyBY6iM0ks55K7vN1Y71vlZSRUEg+OFqtsl88ecyPAEmd
         L2AtSBO2EQ96fKOeFHcRVzkkN+2wn4f3NpA9bCYLtx8744GEAHKGCIvt14z4OXIHVpB2
         rL0NydT65BjLvZh/NENUaRdUKsDvJ/eicZii9ZUkQUGV+q3bzzgQOtUqN/j59kTRrbNx
         +/wAj3cckDlqfNGxGClo5KtzWzFu48/ECcY/udF2+rmMkuOG/9pojlIJQ0869WSFEead
         V3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080658; x=1754685458;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5p4KKE/o6b0bUBzHi5YGrQiPMCLg1LTQYQPkDXqvsvs=;
        b=Olz7ZC2Ap8M1ixy2f3zKQtGEWcgQfR1i0Lg9KiEmLv02ShOoFdjaxxoxa97FBwW2j3
         NYHG8G5unWb9RJy49NGemfdCVUY5f882wzMBakkw0ZnhPaB8jwHyn7fYh3U1T8bv0oBJ
         oyeX3o1zzTuAX0ym47Ce5Po25ltLJtCJIdprql16NMp8KQ0G7vMFjQG3GIV4dPYtU5OC
         6KVMis3OcjWHjPa2YxHcXyzHMXGxm3vbPTF5JQHnor0n/95c/+xPSdjvgU/GTQK34LT2
         33dacXn7tPnhtBA7q+5Rn/OqKWL9xO5JBrotw04sPHlworf0jmkN7HYuIaTPGI/Huwn7
         8+lA==
X-Gm-Message-State: AOJu0YwMR9Oek+9xZS37CHcvfXvWtVxqMibbvH+FQ+RAozLSW6jcWbk/
	StICOlGRqbLO3+YOoeOqSyeGvJxaCBGLk0WrDGWdbZX8AiyjZgVbPhTP8n3zRg==
X-Gm-Gg: ASbGncuEY7K4+6IlEfVuEddl46mVpU4PCWfXPa4K4PIhv++d/8xeg3F8NgnfzB9kBk5
	M4SVC61d6G+JREnIYCQtG0Kn3q0wQLhXiEt8S6t7TnQec+5ljwenj75sJCO1kjlYeCsJRhU5ymC
	epVhTzvibObJZC5WjKrdatsyLHEKL9oywd5SxX4F//BGeEgCYm6pSNYNKkA9qIX3v5WubWWf8IG
	ZvCCtu7I3vzRBitG4NBCaLOvwXP+vM382GjVmuLd/p/Uouo/3buUASw3jAG4oL7SqATKXix29Yr
	c6/i1K15Kyk6xQfUS83e0dW/qamlPbdD1L6qF/EdYXAqSEzBxGMzn5zm6YwJBXjq4ZFtEaAQ6Hn
	iiFcjl6CXA7N81L2yc1+biCyGyfsnQg==
X-Google-Smtp-Source: AGHT+IG0bI1WqfIm6KKaVtDps7FEsio7h5JtR1eAsSld57+4hqKhP1IeQpQzFKn1E9nvTBUJUbdTpQ==
X-Received: by 2002:a17:907:7b85:b0:af9:2e2a:64a8 with SMTP id a640c23a62f3a-af94005fb13mr143133866b.25.1754080657314;
        Fri, 01 Aug 2025 13:37:37 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm336301466b.39.2025.08.01.13.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:37:36 -0700 (PDT)
Message-ID: <ce0b772b-5822-41fe-b496-b1c725c222fc@gmail.com>
Date: Fri, 1 Aug 2025 23:37:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 02/11] wifi: rtw89: usb: Fix
 rtw89_usb_get_bulkout_id() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8852CU can work in two bands at the same time, thus some USB bulk
out endpoints are dedicated to one band, others to the other band.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 64 +++++++++++++++++-------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..eb9978a60d04 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -167,24 +167,52 @@ rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 	return 42; /* TODO some kind of calculation? */
 }
 
-static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
+static u8 rtw89_usb_get_bulkout_id(struct rtw89_dev *rtwdev, u8 ch_dma)
 {
-	switch (ch_dma) {
-	case RTW89_DMA_ACH0:
-		return 3;
-	case RTW89_DMA_ACH1:
-		return 4;
-	case RTW89_DMA_ACH2:
-		return 5;
-	case RTW89_DMA_ACH3:
-		return 6;
-	default:
-	case RTW89_DMA_B0MG:
-		return 0;
-	case RTW89_DMA_B0HI:
-		return 1;
-	case RTW89_DMA_H2C:
-		return 2;
+	if (rtwdev->chip->chip_id == RTL8852C) {
+		switch (ch_dma) {
+		case RTW89_DMA_ACH0:
+			return 3;
+		case RTW89_DMA_ACH2:
+			return 5;
+		case RTW89_DMA_ACH4:
+			return 4;
+		case RTW89_DMA_ACH6:
+			return 6;
+		default:
+			rtw89_warn(rtwdev, "unexpected TX channel %d\n",
+				   ch_dma);
+			fallthrough;
+		case RTW89_DMA_B0MG:
+		case RTW89_DMA_B0HI:
+			return 0;
+		case RTW89_DMA_B1MG:
+		case RTW89_DMA_B1HI:
+			return 1;
+		case RTW89_DMA_H2C:
+			return 2;
+		}
+	} else {
+		switch (ch_dma) {
+		case RTW89_DMA_ACH0:
+			return 3;
+		case RTW89_DMA_ACH1:
+			return 4;
+		case RTW89_DMA_ACH2:
+			return 5;
+		case RTW89_DMA_ACH3:
+			return 6;
+		default:
+			rtw89_warn(rtwdev, "unexpected TX channel %d\n",
+				   ch_dma);
+			fallthrough;
+		case RTW89_DMA_B0MG:
+			return 0;
+		case RTW89_DMA_B0HI:
+			return 1;
+		case RTW89_DMA_H2C:
+			return 2;
+		}
 	}
 }
 
@@ -251,7 +279,7 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	struct usb_device *usbd = rtwusb->udev;
 	struct urb *urb;
-	u8 bulkout_id = rtw89_usb_get_bulkout_id(ch_dma);
+	u8 bulkout_id = rtw89_usb_get_bulkout_id(rtwdev, ch_dma);
 	unsigned int pipe;
 	int ret;
 
-- 
2.50.0


