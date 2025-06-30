Return-Path: <linux-wireless+bounces-24683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B49AEE87D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79D93A6FF8
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46661EB5B;
	Mon, 30 Jun 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coZvM2tb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A610A3E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316360; cv=none; b=AZ5Mq0IzcMrqa696tn/ge03Gv3e0FTe04+c9cUb87Fad+fUo3FZVi/UDJglR8akjHIMvuT02ObZGQMu9hkPgzqX5Vfb5B1zg223XlmmrNv6TmodzDp7vcQ4W4pOByFzlyHU3kqUzihWU8nCZ2br+/jQg5TC+IKyHUx68qo73gQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316360; c=relaxed/simple;
	bh=CZj+YIOazlanCzV0OrG0N7Mm2aw3fsIVXeX0iHLoBJk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uY0a/mcY7WhGUUGt9DotWBHTDvyy0IFZ379niNQAOwj8X5fPr6r5OFNjTdGoJSkadexvSRdnTicufzSklljLP1p7aQYQwq9by8y6xLxFkefNhKZZyBB7QzA2BkaG4oBskclSxTQT2WHKDK5heD5nCOmgEFMxtmpbyqwXUwdcjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coZvM2tb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45363645a8eso34295695e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316357; x=1751921157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iv8zBlfl568ipHsR4SFdNn4HBr0n5JY+EpnZGKCsoLM=;
        b=coZvM2tbr2bClfqBeTGMKCYd+TfLBS9uUrtWS3Ly/74Y0GCd7nrQU285cK7fQxaFTV
         hwN2cY+o2HWq1nX0GFOv/bMyei3v6ACZ5t9k4WbfE6PDpcDoCxkz8UTBsaV5iUOAVlud
         kuy986HvKIy4E0lcuU2r7Re+UWuCClXgMenUmK9MXRglaced8YFpWk/suTW9/r2eJNyq
         Y5GHbNWwZ/KQfaWfqywiiYamoiiyVyENLGQpR0MyDXl1BwSCmZ5f32eQkjNkUWp7DjC5
         bl9ortPrZz4VbOHycbse15XwHyghIZALXMiVf6YFpdSj856fdH72yEQ+1zyZuwIHHS0s
         omhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316357; x=1751921157;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iv8zBlfl568ipHsR4SFdNn4HBr0n5JY+EpnZGKCsoLM=;
        b=WL1610TFO+xQ/nxZsmoHmi6gbWC4KYGHpf2NjHSVELYYNbf4FAwIImZAg+5BJf7Sjy
         Gbd/P85snRBi3JyqC/M5XuokT9IygpMIg1MjUydrQ2cnqr9gM5EA6qLUKlk3TULjSEIw
         Agg4jwGs8jZSRDp4u41qXrHL6m/0GWSsPR9H8pXHsJsdh2aCC2XjqqedBf9rthfiQE4/
         oxlDXlFtw80/WKIH+2wv1KFtektH4SCCKUrM3fmP4F/o3ZUm30/00Nu8uVThCX3+rdQM
         IVX00nDwXRP5uJmb27WehrGfU8/KkXJxGYd3USczwKRI4pfrP61jp4Bx1sdj1kfxQOZ7
         BWwA==
X-Gm-Message-State: AOJu0Yzrkresqljqk6f/llhy6ijpGXmw8GQIvFRBLsuPfhj9ILI02eXB
	BW058LBB/9vEPGwsFXj3kUqkEMkzBzEfodUDAXj7DkHtj+WQNExtZjlsYSiLkg==
X-Gm-Gg: ASbGnctthsiYh6aQRKu79bIguio+jFyydOGfSy/Z7x9xbVWM4EusX4bQS6tovVFaEIx
	kNpLv35XwYlUivNrYciMImJ21M6IZvtZ5ZJUagvzuQGAIrkSmoymaXjBQN2NsWN6uPe65DHeQav
	MXV++Iqdx+G8+DJCOIvBjeBm2Y3i70vXJXDTLMtmoSv5D6MFnc9SN6x1KJcnw6bnWIkgkrwenIi
	YbWfCCq+FSLy2JqIIPmeQUtd7oKTTP+FRzrRSOPGMgSOH261HMtaq17oa3eM7qNZqnYmC2veSO7
	xXfcXx5O15RBKnWc46aKzyks/K6toeY/nfBL+NhWoEkQ1jDxQpC+RFijbPmyaAjqySTpv5+zZCg
	dcbwe
X-Google-Smtp-Source: AGHT+IGPjquoc8wYUpVU5vd0gdoUVMjHIsOdSUkb43fd0jC7RYB0CAlFT+dSM0oY18beqJQXbh7U1g==
X-Received: by 2002:a05:600c:a307:b0:453:9317:8aa0 with SMTP id 5b1f17b1804b1-45393178c41mr87288305e9.32.1751316357106;
        Mon, 30 Jun 2025 13:45:57 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fadf3sm11508871f8f.34.2025.06.30.13.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:45:56 -0700 (PDT)
Message-ID: <a39da939-d640-4486-ad38-f658f220afc8@gmail.com>
Date: Mon, 30 Jun 2025 23:45:55 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 10/14] wifi: rtw89: Fix rtw89_mac_power_switch()
 for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clear some bits in some registers in order to allow RTL8851BU to power
on. This is done both when powering on and when powering off because
that's what the vendor driver does.

Also tested with RTL8832BU and RTL8832CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Put the new code in a function.

v3:
 - Delete empty line.
 - Add more information to the commit message.

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 19 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 877944cbb8da..ff4335ef4033 100644
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


