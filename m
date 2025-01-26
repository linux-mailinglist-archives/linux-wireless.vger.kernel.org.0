Return-Path: <linux-wireless+bounces-17981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25F3A1CF0C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4863D1666B2
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737142056;
	Sun, 26 Jan 2025 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP1AsyRM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF725672
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932102; cv=none; b=PzCt5Un3Oo2WKwbNc4U565MestPc5NvBWxAg5/MHAcf/EXmQU+9dWBux/5vNjg2VIsZqUhBbE41cu9fEQQNgPzSk6olm+YV3a5rN3nlsqmKFoO61anIlRdHebqzTSX/DT/T3sEG9kxMrlaF330OZRhKWE4+JImIC+IP9x5XGTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932102; c=relaxed/simple;
	bh=gikjv/JFgpU6gwksXYuonDfyGKlhm0Iv6qHiKQP0/2I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ya3wHvhLQLZwJjs87FElxxXV+oZ1uYaZDwmc6O6mt17pxxGCkqWy8lQPw9q8xNheRsCJifgCEDnneajE6vutzn5plB80nQdW0PK26GKOIQwiihYRsX4MwCX40NqfdRLHNy/+Twh50hoqECPwFHSN44RCnfQbAiiXTPdZlFkGmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP1AsyRM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso3631910f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737932099; x=1738536899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OdJPl/pIxq7UPAWlijuOkLRWdPX67GLTSPT2bSG0RNk=;
        b=ZP1AsyRMP6hkkNpWPwup6f4d2nc1lknKqCf4CGyWzpG7qFmry4qLwpiSP/LjxzZ8nQ
         QtApdVwhHRqGeg26gKlDIGXtq7ZXa6h5E3R4fJLkImxD6LOmZ7BxHqfmyWF8s1s+T3V5
         +mX42N2MU4dLfpxVxcu4fOf3RqvfEM6W4cXrwDd1Q3sOrtajuAKHrBKze2aDnw6OQs/8
         obhEHInBUTTqdWMsRkHRcuPGiUfX/m7WEO7EM6W66CdOfg8T+b/Szw+DnBU91Z38mNSh
         I/0ofv7O2rnP8E1aCkQYwpeoyQA4cryuWx51NjXMOFoVI4NJDmb2+XcE4+htmX1GA3Co
         XKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737932099; x=1738536899;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdJPl/pIxq7UPAWlijuOkLRWdPX67GLTSPT2bSG0RNk=;
        b=Aiw+mmCk6VusgHCvTmZu4TYGntrC9oEyjrz7w+8aeiGDBshYL3gg6934DmWiLATOMa
         O2b5CoEKiiShmsCK8Lxr/8p6ZR3A3MDL9eCXwKYZqKlX0E6SvsOhSuMeu0u5qR85OV10
         +NvFVVYSuZXoEALPpGuMTC1/3dD+Xz4M7hpSiba9CY6eQW+IayCcr990tt7rELLzUEsT
         AXfyshh2B9HMc15rJ+s41Q5Mop3PnRuT3qlqHVsBifqUpMV67TpaImbCiaqkgvHQ0WwT
         bnh2xDx/w+YpLdnWPVK80WX9oN0irvsyguGOZ2pYMRrL1dCOD4i4QIV7QqaEXGusMxcd
         uQ9g==
X-Gm-Message-State: AOJu0YzYxMnB2nY+OyUyvuHkEYETy7wmOaItlZnohpqOh75lNOSTPHdT
	p1QI3Cpa9bSy/7/TFPV6AP7SrDfoxLl9rx/yTPnrwBT1c14evcJCMlZ2Dg==
X-Gm-Gg: ASbGncvdG6llGukaXIaOJRpuT0dRDy+wz/dflBlVfyGFPR3S0HWcWfPtzTkAt062Z3+
	vE6ODCi/9M4l5bmLpyCoAc3ANeLdwLlH+kGA9rF7GPG6bEnUHP1MwiUMKXXr+2q1VALHa8bUrBE
	mbnY8yLEuG5owUq9/Z9+0/WA3oXSowe3NUu1Fm3GsTzZcUk91+CizelsAvqlpf1erkoxFN4/Hdf
	hsDViYuZ/poDQ/5OkFH/eq57lbZx0rx56v9L76am9Ro1Cw2dhHxykjLYXv7/N8EoB8XKQb/8T7M
	thOk+VK/3mJF
X-Google-Smtp-Source: AGHT+IFuGUSijt/GKbDJ2m1j8YvlNf3uwrSv0Xe2uJ2SK9O1pNnNvpKLZi9LS1z74pi6ZrRVyAuvAg==
X-Received: by 2002:a05:6000:144a:b0:38a:9c1b:df5b with SMTP id ffacd0b85a97d-38bf566a279mr35384857f8f.30.1737932099248;
        Sun, 26 Jan 2025 14:54:59 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bbb39sm9300255f8f.65.2025.01.26.14.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:54:58 -0800 (PST)
Message-ID: <a157faf6-16f4-41bd-a29f-0d8db7940e1b@gmail.com>
Date: Mon, 27 Jan 2025 00:54:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/7] wifi: rtw88: Fix download_firmware_validate() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Language: en-US
In-Reply-To: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After the firmware is uploaded, download_firmware_validate() checks some
bits in REG_MCUFW_CTRL to see if everything went okay. The
RTL8814AU power on sequence sets bits 13 and 12 to 2, which this
function does not expect, so it thinks the firmware upload failed.

Make download_firmware_validate() ignore bits 13 and 12.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/reg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index e438405fba56..209b6fc08a73 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -130,6 +130,7 @@
 #define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
+#define BIT_CPU_CLK_SEL		(BIT(12) | BIT(13))
 #define BIT_RPWM_TOGGLE		BIT(7)
 #define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
@@ -147,7 +148,7 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
-#define FW_READY_MASK		0xffff
+#define FW_READY_MASK		(0xffff & ~BIT_CPU_CLK_SEL)
 
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
-- 
2.48.1


