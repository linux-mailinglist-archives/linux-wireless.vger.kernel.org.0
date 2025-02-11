Return-Path: <linux-wireless+bounces-18788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09DA31889
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8CA188895B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00436268C6F;
	Tue, 11 Feb 2025 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRU/3ivB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44896267715
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312541; cv=none; b=qI77JCEnYkS/BvUb31pPGXr8fk5pQPvL7ARNeb/LlmaN7MFIRVFEg7a1oH0+fS9139X9RBVQZjBMb/QQqmTod3sHJUicQAB3WhA1dhX8Q/SGHAuMrT1iYbvoXWIv1LIc7Az9H5bnsWc6iUC+SEwMRv7JVwftY6gega63QadcK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312541; c=relaxed/simple;
	bh=+VayUWbg8pu3OIpUV7DPdKi3S42ml7UlmBsVRWRZfh0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O8WG3VrGfaqJreHzbM13x8TR7p/UVFdKCuHR5Lpy3m9am8l044fs3hOa2gkpCTIbNFgCGP90jiECHi5bUAj6Ral7j6SGUGAkce9kG9LDNAq1It+xBz+XRyGK5LN4V03BfIAj9ixaIGRZ4O1Hh2GDqmSgPg6oLNfmVfWRn17c89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRU/3ivB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso992778066b.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312538; x=1739917338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VbiTCbXEeldJnegnvSXu0fmcBO2Za0kGDLfJrHVRyUM=;
        b=HRU/3ivBCyBw5LxZxI2UnZdlIVUa/+f00JSEYL1cwXgaxjSqK9UFD89cAJZWIgjpeg
         yqdUh+CW4QsFuFiTiDzQMNOh3q7JKXypisw3veWWUtevO0SKelSvmLETew3n4ptvpiJ7
         dt8vHIPm78KsixMB3hb8nkBuziX53SNfZmfdFUBYW92ZsTiDMzKtij3mWcB+LEGEZ/rB
         eY/Nzy8sd1vd2z238OKYW+PFn5k1lyZrsmtsOS5fqDCesFCJ+HNhGwbLTzhKMvJN/rse
         vtIl0CRm4BxTExDDhmcYb2pXPPDebqXH70D0UZ2nRyhYBzQFks+OhDJNoxqk/6WuH+D1
         zRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312538; x=1739917338;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbiTCbXEeldJnegnvSXu0fmcBO2Za0kGDLfJrHVRyUM=;
        b=La5yxmZ2l0TK7pI+tYCROWmN6IBYICudJ4cmWsEZbot1DCSMiuVylPUeE4qSGpBe1e
         Xdqu7lGyISeD9u48shke6a0hGJA6RlJCPJRdM71zhPGrw4Ure5143xfisIe7FQXlEa59
         BWbZDqZ+hXVH2PEAYRvgpfBduw54IkCHsZGJtEhkQqtHZCIR5YYmI3psxwOh5D69DIwp
         ahHAgGBUsiqeT0uqhiN8cv0DW5LHP2NNN1+2g05wCpW8x96bxBr1dZGz7guGi4p2mLQA
         hzUuZ309QJn2250bUC3ihH9lCVKWU7rNnQqcJOGOAout7DiRB9UGTj7eKmfqi+svwi/h
         lW4g==
X-Gm-Message-State: AOJu0YzKZeQhj0xLX/VGbiSpaVJOsEpf2+RlCZcsO1rK+Jzso0LlBFuV
	e0DxWnj2NHk1DFT47KdnT8wd/fCFV6nHqj9V3FQVTi/l3e0HbixlkqPV+Q==
X-Gm-Gg: ASbGncsTJxwji38udIW5uRKmrDPxpRRHBvUxxs31a0ZYiLy2qFKthJuu9g818YBCGIe
	bAhO4GPuaV24azEiqQ0r21rysomHQs9mwOAtIZEhd5vDsujzE3eULlFicrhDb/3Juk8zMYvU/VE
	gYpcYFY7zsxEpEald1SWIJ+cP6h7NFLk78ZEiujECmGc1IjMuntDX3FydDq5FPumzVuGylS0Ua5
	6ei7eICc3wqXjEelKfmxjB3Z9Anojj8lH9jjZxyepio7XlUKappwx4lvflHPi0eRKpPX5Sk38VC
	Ktej5MRdA0NJNz3VxDZyBrPA
X-Google-Smtp-Source: AGHT+IFBB9C5py1SO+kqi4bkM/UVahiIJCh4aqcBeiLSKVF9r452PEdR1us9vy1GZu4rtVybVlBD1Q==
X-Received: by 2002:a17:906:7956:b0:ab7:f221:f7b4 with SMTP id a640c23a62f3a-ab7f34738c0mr51235366b.43.1739312538186;
        Tue, 11 Feb 2025 14:22:18 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bc28c58csm535888166b.135.2025.02.11.14.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:22:17 -0800 (PST)
Message-ID: <83c8e281-0d25-4de6-a6c7-84d24b228888@gmail.com>
Date: Wed, 12 Feb 2025 00:22:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtw_mac_power_switch() checks bit 8 of REG_SYS_STATUS1 to see if the
chip is powered on. This bit appears to be always on in the RTL8814AU,
so ignore it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 63edf6461de8..5de16c75adf2 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -291,7 +291,8 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	if (rtw_read8(rtwdev, REG_CR) == 0xea)
 		cur_pwr = false;
 	else if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB &&
-		 (rtw_read8(rtwdev, REG_SYS_STATUS1 + 1) & BIT(0)))
+		   chip->id != RTW_CHIP_TYPE_8814A &&
+		   (rtw_read8(rtwdev, REG_SYS_STATUS1 + 1) & BIT(0)))
 		cur_pwr = false;
 	else
 		cur_pwr = true;
-- 
2.48.1


