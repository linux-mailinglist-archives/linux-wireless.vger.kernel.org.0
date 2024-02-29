Return-Path: <linux-wireless+bounces-4271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213886D6E5
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 23:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525EC1C21B6B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB3200CD;
	Thu, 29 Feb 2024 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuwgwAhn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4EC208DA
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246057; cv=none; b=QUX/xfYJ/BFBgC6hqV5XRSzgFbgZt6+SQVsMMHQKFSi6VRQ7FrRO456JAkLYb6qN2oNnOQ14vqdgriZ5+sSXpqpIk38IwieEpp9DvtY+hpU10HZNL/v2gEbZTBM5KRDFnRLJ7TgiBGxrf3UD4v2Y1IsnowYH5c5jgrSUx4zfLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246057; c=relaxed/simple;
	bh=fD/xamvG6zR8Ouxc+TXsK8mP2JejVEg2rAqhlxbaink=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pKhIr2Ig9K37T+5xzhBFV7tpLXgeTHmkCdg3SmOwqODMJ+KR3/M25OxR+1sxk1BWxDSVaFf1jtgVSeK/i7VBComwlDz+uD5zFzL/1mLipkijDj5aQO0bR4HCOPATrNnUEni8k5Mkbo18rx5As/jZMRudwf7aKuZnvCznzVzH0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuwgwAhn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131f3fc695so1578684e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 14:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709246054; x=1709850854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3JZvTB/m4fw2x2v8iZTUePG8qieB3qG0XBnMg/1QpA=;
        b=WuwgwAhnPKsArJ9LRtOTepnI8D40WJIo53K9/IGgRfmJSf09vDyVHrmeOfwPv6dKAT
         6xiFfkDlAK7An5DS4w4m1MKK+9F0PBUY3A1vW53NrYtI3kxNqyR/Xcq/u8P6q6K54CFC
         +to4nA84j5Lo2bb0V+6YsG/gMdbH7WurUNL/wbKxl80HLK9L9KE/JtdsJ9l+N6DmcsMv
         G+IGzp0K3VlMsWtlq6QNQpL24eCbQrwTlaWALiCAEPOA/dk2Y1tOqhy3jzGHbVe3QArX
         O2CKx5s/0hJuMJNOKioie400Q+EfsjpEiYmrJ3Bwf5bDcnMfsk9oEx2eGIO+dzuhnF7L
         Jivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246054; x=1709850854;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3JZvTB/m4fw2x2v8iZTUePG8qieB3qG0XBnMg/1QpA=;
        b=rhK7AM4avTonovIDjPkLD2HyFqDDeiWuKyLSzFpJLQ/SHe+YAh7w0KINVbpCYXDtfJ
         0QpX82q9tcf7WQ4XwAVTIaQHxYMHSh4Xa9qI8hODniY9RKArCkrx2m69m3O4coHe5x+E
         YU+53AsbJMFrVQLRUiDb+060NeeDvKdf8bC39oVGtIakIXsW4HqTMJBiHqLgnjIVEFb2
         Zqvm1/+F3dBFzRCEjSPR+00rIBLWSucdmnG5pQshPuRwZVoPdnqKxU/rZNfnkMkoOtNG
         rSzWvBkJSjgLzsAk5H8F1yeieIWKjS9BJqPh9AWv2kBpid6JYh5YzDLGwjkLKrxUTBg+
         AfUA==
X-Gm-Message-State: AOJu0YwSUpx/KaNQpJuhF6wIizdjrExkg7x3joE2qYdzgzaPOni5kpZ1
	q7862I9531OZiGa6sjkPeZhq2bOq3zMFORkBGEPJFxEjqd2mQmpxMLk8M7vk
X-Google-Smtp-Source: AGHT+IG6+6mhadPMKfVleb/i0CgUM8XUrNH7ZO4wOH2WHMUhvLW917ZKiW8scjoTu052y0gCPR9gPA==
X-Received: by 2002:a05:6512:31ca:b0:513:1cfd:14b2 with SMTP id j10-20020a05651231ca00b005131cfd14b2mr2628041lfe.33.1709246054046;
        Thu, 29 Feb 2024 14:34:14 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b00412b68cc169sm3360442wmg.16.2024.02.29.14.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 14:34:13 -0800 (PST)
Message-ID: <aeeefad9-27c8-4506-a510-ef9a9a8731a4@gmail.com>
Date: Fri, 1 Mar 2024 00:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/4] wifi: rtw88: 8821cu: Fix connection failure
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
In-Reply-To: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clear bit 8 of REG_SYS_STATUS1 after MAC power on.

Without this, some RTL8821CU and RTL8811CU cannot connect to any
network:

Feb 19 13:33:11 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 1/3)
Feb 19 13:33:13 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 2/3)
Feb 19 13:33:14 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 3/3)
Feb 19 13:33:15 ideapad2 kernel: wlp3s0f3u2: authentication with
	90:55:de:__:__:__ timed out

The RTL8822CU and RTL8822BU out-of-tree drivers do this as well, so do
it for all three types of chips.

Tested with RTL8811CU (Tenda U9 V2.0).

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Check for pwr_on instead of pwr_seq == chip->pwr_on_seq.
---
 drivers/net/wireless/realtek/rtw88/mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 298663b03580..0c1c1ff31085 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -309,6 +309,13 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
 	ret = rtw_pwr_seq_parser(rtwdev, pwr_seq);
 
+	if (pwr_on && rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB) {
+		if (chip->id == RTW_CHIP_TYPE_8822C ||
+		    chip->id == RTW_CHIP_TYPE_8822B ||
+		    chip->id == RTW_CHIP_TYPE_8821C)
+			rtw_write8_clr(rtwdev, REG_SYS_STATUS1 + 1, BIT(0));
+	}
+
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_SDIO)
 		rtw_write32(rtwdev, REG_SDIO_HIMR, imr);
 
-- 
2.43.2

