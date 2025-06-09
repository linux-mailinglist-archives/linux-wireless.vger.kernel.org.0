Return-Path: <linux-wireless+bounces-23897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2888BAD26BB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F55161266
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9521C18C;
	Mon,  9 Jun 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyCXs45z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B2145B25
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497295; cv=none; b=gJZ5EQBq2USPG8tKkfQIeUaLLpkA3IFJQ/qTlnxCoRKhG9fffh+GcuOE/Y/CGdAf3HmNE20yUZjF+t44iZn6FHFHE9rCl6d/wk4AvSMrXLO7554KCR3RXy9BTCd50lWUaBRM+WyHsFGRYp7xLifMedO3n6FlEWqsh1Q6+W5hviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497295; c=relaxed/simple;
	bh=+pV+fOMoKXaHlkNvd0jFMeNmRohR8UZzkYzqzF4tF+U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J2Jzl1gYvViOOG8mz8MwMh5cvHNJ9O+RAcbajTfMEl7firjbA6IcsnFsXRp+p+1OIMzmwIfKt1762D61RPSBRHuK7oasYutE7ToPMnTcOWQsF5qSPak644/ZU1X64vyyQWlArNBs5bRgm+/FrU7GvtTfo1r4svVsHixlLKwGeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyCXs45z; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adb2e9fd208so858921966b.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497292; x=1750102092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R/HV1lLF6yRpN9qJmbyYwGYq6JfXVSAXhBu/MEYCDsA=;
        b=DyCXs45z3nsJ5Ci2Wm69X4cjHAjsLrk6dgkkeargdXT7Zn5FUq3bl7flaLwr33vNWp
         dUFCyPGvolKbJYTqKNiaL1u1rTHS1KINrjhkSIAYl7hblsCgYEWsuqDhy0cROnJirsLZ
         cXq+umRIYpouit/Xotfyz8+Ji3iFQcM6Qx3wm7cTjf8TV1oWdOhEeI63276uUxcMb7kW
         LGU4l3rbj8vvQpJRvWFFKd0us5tCMYtNnbYQxquiI015kOvFv9yS+2ouW1fg4ma3vzf0
         GEp0C7UhyPY5gahlaztWThZ1d9b0J8cIxV8aWi9kdWgyGbI7SfW4z1+oEd7UjOGUd30w
         Fjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497292; x=1750102092;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/HV1lLF6yRpN9qJmbyYwGYq6JfXVSAXhBu/MEYCDsA=;
        b=EEZ3wL60voNDRXGUUOgp4EnRzvIiGNjdkBMLt4GcpZ3au4qex2Nm8zrfep7d7tjbq4
         t5uLhVVmlc8b1suW5ddJrWjRjY5MdLKfxVJfIh5shRJTpLaYlhjKsLvEeBHeDRwKDzT1
         JmHEM4ow9dWM4nYOhknewxF7Q/S3+xjz8nXjdxMaYhzUByxeFwTIG6zyxXzO6IOpEDeX
         sY1bJqUv4K/zGSbx2AWLMa0p+QhCGcB/rrWztPNvqRF2df4EK816TSm6IrAC24kj8Jb4
         I/L6HKeejm0VN8IzQ2jGCPL2XdMJXISsSRmo1MFPwLogZmE8oayGyDV3E3VtedxijJEP
         RXZw==
X-Gm-Message-State: AOJu0Yz8gpTum3eNMREQIbBl0QCzlbLFfJvNP2zbo7EbBWOPYD6rkTAY
	fwqPdO29VZBiWHCv61BZfKgrH2NA1yjoIztwRD/eDRAk0usqvXXvH+Un+ZKdaw==
X-Gm-Gg: ASbGncsSdq+oIGeXnANG7FSNhWPelpf0XSomVAvs7qbeBT6WhvJFqWTmquKrR9HbfAt
	elKQLQ1cbR7Q5go2MaDLThsWhM90j6v9AAWth0JfVjjpexmdlXztOhpcXN8pFPIM/W2eyUna+y8
	scpt08YmXnlMgciSIbIeTDrMZEiTAXQjBGlqop0yUOTnJ4ax6svScsu+5QwB1qSyXHY+AsVkKEF
	yP70ngQS8ivv7v+PurfDgD70GkLGWk+iuOqHCkTrcdt+8Os2w49LPiBIu8nLuxAiL7T338KdXZG
	pQJxlUyitGbs/ZggTptcmMdoRwK6PwoRwvI1o1c1xpA14iBLAq7vt2b3bgFpnEbMUqLolA==
X-Google-Smtp-Source: AGHT+IGPYCHR7IijoPevwmVzDVreZLPkaoky/isLXSaMpSvj6td40f1vxfRNLoAQJXnueVgaawpK2Q==
X-Received: by 2002:a17:906:7315:b0:ad8:9645:797a with SMTP id a640c23a62f3a-ade1aa4d67cmr1368509166b.15.1749497292472;
        Mon, 09 Jun 2025 12:28:12 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c1d8sm596484066b.83.2025.06.09.12.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:28:12 -0700 (PDT)
Message-ID: <1e25d8b6-fb5c-4733-81ec-b9ae9bbd8f92@gmail.com>
Date: Mon, 9 Jun 2025 22:28:11 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 06/14] wifi: rtw89: Disable deep power saving for
 USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Disable rtw89_mac_send_rpwm() for USB and SDIO because it is called in
atomic context and accessing hardware registers results in "scheduling
while atomic" errors.

Disable rtw89_mac_power_mode_change() because it prints an error message
when rtw89_mac_send_rpwm() is disabled.

Modify rtw89_ps_power_mode_change() to call
rtw89_ps_power_mode_change_with_hci() only for PCI because the latter
is probably relevant only for PCI and also because it calls
napi_schedule(), which results in dereferencing a null pointer with USB.

For USB and SDIO rtw89_ps_power_mode_change() probably needs to call
rtw89_mac_power_mode_change() instead, in case deep power saving is ever
enabled for USB or SDIO.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Disable deep power saving for SDIO also.
 - Don't disable rtw89_ps_power_mode_change() for USB/SDIO.
 - Disable rtw89_mac_power_mode_change() for USB/SDIO.
 - Call rtw89_ps_power_mode_change_with_hci() only for PCI and call
   rtw89_mac_power_mode_change() for USB/SDIO.
 - Update the commit message.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 6 ++++++
 drivers/net/wireless/realtek/rtw89/ps.c  | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7f3c816d4704..2cebde9e9229 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1336,6 +1336,9 @@ static void rtw89_mac_send_rpwm(struct rtw89_dev *rtwdev,
 {
 	u16 request;
 
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
+		return;
+
 	spin_lock_bh(&rtwdev->rpwm_lock);
 
 	request = rtw89_read16(rtwdev, R_AX_RPWM);
@@ -1412,6 +1415,9 @@ void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 	int ret;
 	int i;
 
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
+		return;
+
 	if (enter)
 		state = rtw89_mac_get_req_pwr_state(rtwdev);
 	else
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 8e4fe73e7d77..9f63655b7568 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -57,7 +57,8 @@ static void rtw89_ps_power_mode_change_with_hci(struct rtw89_dev *rtwdev,
 static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 {
 	if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode) &&
-	    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags))
+	    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags) &&
+	    rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
 		rtw89_ps_power_mode_change_with_hci(rtwdev, enter);
 	else
 		rtw89_mac_power_mode_change(rtwdev, enter);
-- 
2.49.0


