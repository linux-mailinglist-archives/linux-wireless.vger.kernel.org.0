Return-Path: <linux-wireless+bounces-22412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3BFAA8949
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B1C7A5971
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F6224CC;
	Sun,  4 May 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXB3MLTK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3723A6
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391982; cv=none; b=oRt6PTI91H+4r8slGTCR77C9S5NbqYKZKDrYL60lhZYmgCosxQs2lA1hk0Hk6fod0Hl+bOKoZGtUM+7UhmkntxCeGjJ3Re8E8BVmO4V+5R4Y7B/cA1QmdkjDd9o5eBhADyn0P8/Fa/+wNS7kAjFH2Rtv1gXu/vIVr18EfmvTgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391982; c=relaxed/simple;
	bh=FhZY9EbyQMXG4W+JUgVr+Y8daP2M1HnRC2IojROL+ME=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QNzOk93X9reHNI/xyC6qKFEaUlzJDCm1pCWtFcOnwzl3eV2FdY+E7hKVJbbVwD3EorRYYqrYQi6BF9uZX16xEH++IW4kNCHqb6cq6Ewb+KrG9/Z7kdqEHSZvf9hHs9qG0IgZcRCziDmsyGCpc6BBejU4rAMEpbLH0Q3BsXvEcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXB3MLTK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so715927666b.2
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391979; x=1746996779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lm4+BXVPyvxj2cP/K1voAad3j+1frpHmpWa70b/2Qkw=;
        b=WXB3MLTKjZoOtwe1dgFaie5wRyq7G4pOInLSEuqgNUFnJNh4jDxqsUxv6R52YGxJvm
         7MgdJjAWBx7eCSkyLVnjdeujSw3umWrGh99BM2i4Y2tpVGWgW5bpv94+HMWqnUJbVtj4
         71508WGdD4ynY4/pb7BZfSbBT0GRa2IXHaIKkFG7eNWoEHkhe3nWiwyARuJgyYypmoK0
         pu/yHCKIR/5jOKEomV2sJThc1fsVvN+zbD/VhK4GrTQEn/2yFEoiir+GAc222QtIxAjj
         n2Ho9+khyPKocWt/NK6kE+BpaBDDuyJiw34LGOjmuSt7GWNzUc2DR5N9XgTMayGQIYlN
         JM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391979; x=1746996779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lm4+BXVPyvxj2cP/K1voAad3j+1frpHmpWa70b/2Qkw=;
        b=LBhuUPOJdZpbjQ+McV7y7iEZ7wINsNoRpm30fAqQo2f0CLzTO8mMqr/f6rPd2Xx0R5
         8tDApyV5gHvMJUqcLNr+Aw8XqByF2O9LZpcJPznQLY9oHQTfxVQ6f4BHIpX2iQwh4hfD
         lxZbCV2UmEeZycTn2LyGLlIOIWVKYN2/JFkTAdjb21wHMRkNqX/Aoduyv8rvbPWZ7C8s
         rJc4WcHCP4dv9iILi73S6kwNmTJm1QMDk2mFFVe0YzEKHqh/VoWQE8rrIf+pvM9v0BWC
         TMCBQ4aEo/9NJ6gUxEiS9hd/BCmhcavALTqzWpcuK0J5+QaAEo8qJy/ZXFwVY19xj0RZ
         Zobg==
X-Gm-Message-State: AOJu0YwWnRxpsIQxCL1dneksDrV5Ar/K0KQT0zFWntXWI4V2lQxjtDw3
	H8vaB+XzWO8bgvh+kbi8+BoUnCj/LnkAoRjM5kKCmbThr8Nt5MCJKir2LA==
X-Gm-Gg: ASbGncuLRGNNT9HfVXl4wUO4v0rn2jltF5djR2b6jLVAC3WpCotje99OdEkwXFYtgRa
	qb3ZWkhmCMkCqC1AWyV0zPm19ZCo837i/+r9fFl5AsgoWbfl1oIr0THXZvfi4Xk40vgWNZBrU2R
	XEcvomBF/H31MzB3EYeWIy/PltAtPbtskYbmJao8laEZN6widxnNRglb+hn8jM3uj/MctdG93hF
	sM47zasH0jtPsVQxeFjc407Pc341b4zEZfdGwyqsvZOVI/bCtj2IMsqNlhRtDrQL8r55mvW0lhd
	MIf8CYKCoye/auutFOe3QBUNmjiwfFkFjScnupgxoFK+eCxMe05YeX/+xoP6
X-Google-Smtp-Source: AGHT+IGwZosMxO3/eqEc840Nu/b2Tg+m8SMWH7foI2aonmyZFc63GcOyaTaVA0B93loUvkecqOTbRQ==
X-Received: by 2002:a17:907:c04:b0:ac3:bd68:24f0 with SMTP id a640c23a62f3a-ad17b470a90mr1041905266b.7.1746391978854;
        Sun, 04 May 2025 13:52:58 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189508c2csm370752866b.130.2025.05.04.13.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:52:58 -0700 (PDT)
Message-ID: <3df912fb-3a56-40d7-940f-c82a23212adc@gmail.com>
Date: Sun, 4 May 2025 23:52:57 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 09/13] wifi: rtw89: Fix rtw89_mac_power_switch()
 for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clear some bits in some registers in order to allow RTL8851BU to power
on. Also tested with RTL8832BU and RTL8832CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 99f01fff90fe..d3cf67dfabc9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1458,6 +1458,14 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	int ret;
 	u8 val;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB &&
+	    rtw89_read32_mask(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE)) {
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
+		rtw89_write32_clr(rtwdev, R_AX_SYS_STATUS1, B_AX_AUTO_WLPON);
+		rtw89_write32_clr(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
+		rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
+	}
+
 	if (on) {
 		cfg_seq = chip->pwr_on_seq;
 		cfg_func = chip->ops->pwr_on_func;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index f05c81ae5869..9d9e1b02bfc7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -182,6 +182,7 @@
 
 #define R_AX_SYS_STATUS1 0x00F4
 #define B_AX_SEL_0XC0_MASK GENMASK(17, 16)
+#define B_AX_AUTO_WLPON BIT(10)
 #define B_AX_PAD_HCI_SEL_V2_MASK GENMASK(5, 3)
 #define MAC_AX_HCI_SEL_SDIO_UART 0
 #define MAC_AX_HCI_SEL_MULTI_USB 1
-- 
2.49.0


