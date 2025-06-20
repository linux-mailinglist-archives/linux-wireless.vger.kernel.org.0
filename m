Return-Path: <linux-wireless+bounces-24303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D50AE229E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA844A61A0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0ED1CBEB9;
	Fri, 20 Jun 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFn/3KLe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41782136988
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446141; cv=none; b=l8q+M3d4cXxtB34gu9nLZo5Yqq6z2sPikUGW8DlGgrtNGILtu7DOWEsaDDQgVk11/O9RIy6VPAO+DrAbe5/ODu2q6hUclHXUfy+Gq4ILsnml9c4U1Kvym/X874KDsEct14Bzjdthftd9b/Ziom19KWqQ3ojOnfwue5NxBrAl35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446141; c=relaxed/simple;
	bh=tNS7yA4JtumnVgwRQPEXCn77678kT8c9FIgsWPPDo8I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vEtz4Kn2Gd3icLlCxI08fwHF6yyj1eJwLvz25lJn6h9tKWVq9AGbsONQb4/qyd8S8lxUflpqZItpcCaAWhapDAY/irASBYRlB2e2rkPpjwuQTcCfQKz/MGe4iK+58JUnqV4bM7H0xIITkS3QiVtZb/Hf4vb7aknMsjAVUsrTMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFn/3KLe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45363645a8eso10756665e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446136; x=1751050936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gjE7a1aAkY59IIciaY7KCW9Qev/LL7cubDcSOLfu/WU=;
        b=KFn/3KLe29msngo+inBsID5OjycLDtuaAnni6ZEyxQhkvS7lyaQx9TrEFCLiBdDs8S
         HBybTshGZX8zw2Z0/tRbU9pMhVlpxNCDHSBvLbUr/t/s3jk9rMTY9fKj/9T2/hc+SuI6
         SHgz43nnQmt37HksH8V6uhxfPLMWc7k+rgGc20nYIWMm2tVwyAqGrA28oiYuNwCQX4H2
         zI+sRwwOjHKEKFTVYq2FFrxygB5nSMp1EOXa89K+LHuDfTqxjhB3xv43ldpvb9pvYU0A
         VwuN99oIczJAsthY6YkOCuQsDXZ1NGEY8s1gSs2BJEpzxpyb+eos0goF181Ow5/ZMVfs
         IGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446136; x=1751050936;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjE7a1aAkY59IIciaY7KCW9Qev/LL7cubDcSOLfu/WU=;
        b=edbrmdAg9EMfj9Uq3dP0oumPVolX4PP66l+hBRRzIhpv+R3gdAX0W0AMcQn9lpRcQB
         qsJkN/9LFBwD6M1vOoNJ35dT2mxzkl2IkQCcsKajyDpdnP03X9d+OiL4LBOabCBezZHe
         lxoORGkP9o1q7IvMZwoANv0yDCkv8K2CeqD3oAnKw27VOmzSOxn+r4+768aLG64S/6Xs
         D0qAuOj8SFtcUFxgMG/Y2IDTWfgpxLpjntcH2JHgn63wm9DZocGDCRXtKV4CwB0IHnu1
         kcCxrTDVDuyEhNOkEeLhUsYdtO4SyjpPWss4k1nIQ/nU7DrsR6FalWnrgpvOxhc+7jY6
         zdMA==
X-Gm-Message-State: AOJu0YydbLZztp1A60VCL7ypcM01YEiBd3wjvlypONR8/a9ullYX/wms
	i87rOsOcSrCuiJj3yFSPLQSUq+cBmxI3RjhiZ+y0rsg05dtu88TSlUHpO5nIIw==
X-Gm-Gg: ASbGncsCa/ILY52MD17N3xMiRMXtVj4/qPLCsf3fWEzSC18h2x1TQv3ne/OnDwCTkDP
	AmbcqMNwfJzKOnVoZeUIRYhaR995QytjV0XUSxMOM8XuAkvMynMO/vdJywRPgRAhcrie10XhvIf
	dCiSyd0h1BXE3Jj5DnOd1rTmRAbCsX4Omge6tyywLl8GRS3VFhOezWpVOvbdf04YnAB2L3343E4
	7zL4ra90W9Op+jzh4eleghCXjTvc+ervvvD1VnUfmLKjmePUGCE2zgqmKzlACkg6f9BE70NVVFt
	CrvQJvR4nd0qvuggfPH40h0RuZA6SUJk5KTMV404MCEP3BzeW1BxcT4s3O3ynhRsFgL4Zjo88Me
	sSMrP
X-Google-Smtp-Source: AGHT+IEpO7Nk1fOt2La1sS9kf7tqkksXPfaHA5p/VhK61KXoCMGlF6EPpUIway9mMr1WCAUGLhCGVg==
X-Received: by 2002:a05:600c:c8d:b0:442:d9f2:c6ef with SMTP id 5b1f17b1804b1-453653cf40amr34234425e9.2.1750446136404;
        Fri, 20 Jun 2025 12:02:16 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10411sm2701723f8f.1.2025.06.20.12.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 12:02:16 -0700 (PDT)
Message-ID: <3799b797-7d9a-4e8d-b9d5-73db3d3eccf8@gmail.com>
Date: Fri, 20 Jun 2025 22:02:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 10/14] wifi: rtw89: Fix rtw89_mac_power_switch()
 for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clear some bits in some registers in order to allow RTL8851BU to power
on. This is done both when powering on and when powering off because
that's what the vendor driver does.

Also tested with RTL8832BU and RTL8832CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Put the new code in a function.

v3:
 - Delete empty line.
 - Add more information to the commit message.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 19 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index c018071c94ee..96c54d1c658e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1440,6 +1440,23 @@ void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev)
 	rtw89_mac_send_rpwm(rtwdev, state, true);
 }
 
+static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
+{
+	u32 boot_mode;
+
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_USB)
+		return;
+
+	boot_mode = rtw89_read32_mask(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
+	if (!boot_mode)
+		return;
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_STATUS1, B_AX_AUTO_WLPON);
+	rtw89_write32_clr(rtwdev, R_AX_GPIO_MUXCFG, B_AX_BOOT_MODE);
+	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
+}
+
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
 #define PWR_ACT 1
@@ -1450,6 +1467,8 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	int ret;
 	u8 val;
 
+	rtw89_mac_power_switch_boot_mode(rtwdev);
+
 	if (on) {
 		cfg_seq = chip->pwr_on_seq;
 		cfg_func = chip->ops->pwr_on_func;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c680441232fb..be4a8486c9f8 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -183,6 +183,7 @@
 
 #define R_AX_SYS_STATUS1 0x00F4
 #define B_AX_SEL_0XC0_MASK GENMASK(17, 16)
+#define B_AX_AUTO_WLPON BIT(10)
 #define B_AX_PAD_HCI_SEL_V2_MASK GENMASK(5, 3)
 #define MAC_AX_HCI_SEL_SDIO_UART 0
 #define MAC_AX_HCI_SEL_MULTI_USB 1
-- 
2.49.0


