Return-Path: <linux-wireless+bounces-13860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A080F998BD1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 17:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CFB1F2587E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84A1C7B6E;
	Thu, 10 Oct 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGukoTWI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8E1C9ED3
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574489; cv=none; b=EJI6Hof6749/tVoFvL1rjpJzEcGXqkCzZAX7TdSL1hxmt2SERn7cgdI/syOBkJQ6GMeO7ZH/ln8tvojgCBOb7XFiv5kfSil1Mh3SBwtPXa3+86cHhbSe/NfDc40ueC3Ivuk+xq6uxI2a/80A+OxQ9VD+OgCnOj4I/41HTRDA1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574489; c=relaxed/simple;
	bh=PFBIcv46mn+D/7igUKKFZQQDvks5N/zjQi1i39OUsF0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=A21tBxBlsluxc+o3PCwCHy+NLlEZJITvW7wA4E1DK43F1FvIy/W6p0PEsgiuzEhZGyKL55rFuMOhvZapeGZrIfSmscZmn1M0DvVidqMNRfXLWFiGU1eNTleTK74hdHxbupt7oJzXUEMREmZO+TAD807JpyCWM7Xu3quSh31eCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGukoTWI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d325beee2so604701f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728574486; x=1729179286; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf30UMv+RaJ3IRyGx+fIEb/mnwhUMHa/yIXJVpWwLrQ=;
        b=MGukoTWIt3trw/Zz7gyevAhnTjOJhwQYfa35wlLJZpxz6oZxBv9aVnZVFbGj/6ja/r
         4I3JKnnypoWl9hQGAiL5BIFYotxGLkP8hoKpmKSlwkT7nJEAc2RhPY34H0/YYiIC0tFH
         Zcy1bcQ+MCj18unPEjiMr0k6EupVr4BpP7MH7VVs2DlMrW06cIVj0zoHHJbD285IFbTt
         HN5ZmhDrM7mhRghVTLTIWlmvSbIKatHf8O05zfkg5UIMJzwEI7cPCncxDSIZaOUR9/33
         UrGfjY3jJRwb4AQ42Hr7SUOI9P4HN+FNyGeTDz+rOk3DWqTi0JlFDVLw1Ty/TAQMnn7T
         dCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574486; x=1729179286;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tf30UMv+RaJ3IRyGx+fIEb/mnwhUMHa/yIXJVpWwLrQ=;
        b=q9yMDsc/dl40EhxBCmG3v2d7jHI2j/6Km72Q2ron2AZu9ZKazyeQMqwIzVVSRUqOLv
         qmoy+9/hWcT46kSxkNWbYq01WMQEBJIfSGBzy2EloZ86GQsjw4lQa4m/AArAigMroA4a
         vIzcoXOdf05KQrRya0G2evLGLd0sKILWzi3NgWcK5NplE2Pt3pNvKtRhiqx1FMFyWuM6
         SID2ivYUcQUZI1fO2mlcOM/pMyiX2uL75TUhQwBPEH0a6F8uzB9omzUDFAYtu0BamiD5
         MF0RM1MH0a84jv9bpzUV9O14cbSQ9TulEzCFaXHiH0zIUhcdLfq/G5KnnYyCn2bl8r6z
         1G9A==
X-Gm-Message-State: AOJu0Yx+u1yEj4u7c2TZejYJQuXMdhNnRgFZB4MyKQfJuNkmcVFLUhu7
	df2k2xkFfmSlPf+WzZEV1AGnNhbvqTPFe9uAGkayZ/5s5oEuZZfSsTIBRQ==
X-Google-Smtp-Source: AGHT+IF+n6pQfmVHFpTa0WdJ0rbsg6JyoHribRTpeRwOGxi0C8nECE3NZjQ3yuMBKIKqbaQog3DdfA==
X-Received: by 2002:a05:6000:2cc:b0:37d:4cd5:ffec with SMTP id ffacd0b85a97d-37d4cd601e8mr1867038f8f.2.1728574485493;
        Thu, 10 Oct 2024 08:34:45 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7edeb4sm1803999f8f.91.2024.10.10.08.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 08:34:45 -0700 (PDT)
Message-ID: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
Date: Thu, 10 Oct 2024 18:34:43 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This ID appears to be RTL8188SU, not RTL8192DU. This is the wrong driver
for RTL8188SU. The r8712u driver from staging handles this ID.

I think this ID comes from the original rtl8192du driver from Realtek.
I don't know if they added it by mistake, or it was actually used for
two different chips.

RTL8188SU with this ID exists in the wild. RTL8192DU with this ID
probably doesn't.

Cc: stable@vger.kernel.org # v6.11
Link: https://github.com/lwfinger/rtl8192du/issues/105
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
index d069a81ac617..cc699efa9c79 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
@@ -352,7 +352,6 @@ static const struct usb_device_id rtl8192d_usb_ids[] = {
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8194, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8111, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x0193, rtl92du_hal_cfg)},
-	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8171, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0xe194, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(0x2019, 0xab2c, rtl92du_hal_cfg)},
 	{RTL_USB_DEVICE(0x2019, 0xab2d, rtl92du_hal_cfg)},
-- 
2.46.0


