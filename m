Return-Path: <linux-wireless+bounces-18792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A1A31893
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E60E1888E56
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAAC268FD7;
	Tue, 11 Feb 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp9WE0ro"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5C267AFB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312678; cv=none; b=YmvMh0P7CUauZ29tens/Do1SToeMtp7zu/MK9lvNLvad7ztzfjHFLIRdiqI50ATOmMNrmxo6t9s2oehW9gSVBix9WnYuCJsSMdpBUdiV2BX6uJaCSQtZzvG9AnmOyLu3E16Mb0u0fPOuutmlbElXjGl587/BQQsxIUICuZrwNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312678; c=relaxed/simple;
	bh=nW0diVWDrTgynFFoF/DWdwzpmGDFT5GDzzdnTqg0lEI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mhaFTkCGWjPKXaZt8LpW473lIj1E1Ki9m0xo2LLWggq31/jiqvM7aNYXJDdl+rcUPRj9hacBPVVEMm5DAnnx81Lj6n+cZL0Lpw76YerLK4xCMZ4SYaY/hTPMdlDqoXFHX9lf0f/Rg600pbceDAqL97tMw6QX5IW5xg7D0lz/NRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp9WE0ro; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so933005566b.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312675; x=1739917475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xI6GjA/juggeNWyo3ngAzYep14tdluCQ5ZqWxQaJ1XU=;
        b=Lp9WE0roOrueN7aEHoGqLF8G9queePHd6FH10pFsxZzuH7TNoVcOX+zwQGZvL1+eQk
         5uj/NztgsOc9ccvEFd5WTgx6ifQnCOi0XH9zGzyK7XVIJzQ4PNAcqesp3mKZ6pEb3IXS
         TQ4ZzCXceab5Ic91MM4V6236wqtA1HzxgzEYSJsyo99EnmQPu7Fel6evW78GdpxiNFZj
         H2b+4pwti1o7cmYSEBUYGJEZVqm/U5pAwPpl+Mpa1Qijx+S/P52siTGi502DyESKMUHj
         eKoDtOY40fRAyR+A39P+HApXS5bLcYkL7uhrpNmf0IvDFcH8qzqeD2reE8jm6UEyNrRI
         pt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312675; x=1739917475;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xI6GjA/juggeNWyo3ngAzYep14tdluCQ5ZqWxQaJ1XU=;
        b=Cz4JbHUBJI5Py36JkzW/Upp8S0C4kPbo1Legv2+b1PUsNJ53uU94Op3cs4kxlRHDKH
         2YjTD30g3qL/YkKe8T8DYTcFLDxUdks/e+BCxb+STHjUzUMw675J9rybTyBL7eqNBSDK
         J1rMg4bsPKJF0fhWtI98iTbfL9yxp9ccDWz8rfUqrDuYzonDIdFd+cfHpqTcmfqpd+VX
         iYHPGBpHzeObc5JkNOHG+syrSx0nWJxTZRM2O7FNvSIwxxDSf391qaEGv4DHWA9wO7Uf
         yTLT0GuYhL3YsG6iNhPmW5ueixViGRwNT7HgKoZGMjvb7P3bbnob3bh9YJtOxlCEZeJn
         kb5w==
X-Gm-Message-State: AOJu0YzOWDCsFPnLKBia8fmtvtbjETJg3YMgeYAWJB6tLaiW/DVTc3nh
	EE/AR0mdsSpAXwqnbsaISsAlhY4oqAdBCf9O0GKpiq+5zvx+/sPkdpkBvg==
X-Gm-Gg: ASbGnctsHKRB7m1f4x8+FyhlKLomMwjPSOp7HsJcHinS5tdS1HRlziva2bTUVdJcCSd
	o6yKHWMsEJ5lBHAwvxbCcgF8cbk+Ry1i2iUa/fTAbdsk6UXNPvxpW/EYUOgmcqw51MZlaWPgC8Q
	a+urL84euMXtiZStf0yABiyUIy4Ro61ZeP2gwJ5AD/v01v/qK7sgpyj8c/3m55ZZfrn5Xfwh1pQ
	Q4aD3UcTMCIFsCD/eO0d+rJyv9iB006IaqqCAYtbnxqtHmN3BKukcX5giKI/Puw/hjtmzXHhga3
	yAHQR6AkO1hmlYdQNPiw35Wq
X-Google-Smtp-Source: AGHT+IE2u1+D934fYsTGACC0L5BYXvO9FXrp9In67SzP57232cJ3vRAfiS2RyniM/eYftUS4P7G4lA==
X-Received: by 2002:a17:907:868a:b0:aae:fb7c:50df with SMTP id a640c23a62f3a-ab7f347c173mr58827666b.36.1739312674705;
        Tue, 11 Feb 2025 14:24:34 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b12d5f49sm642234766b.73.2025.02.11.14.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:24:34 -0800 (PST)
Message-ID: <222fe9d5-804c-4521-9983-fb0620414810@gmail.com>
Date: Wed, 12 Feb 2025 00:24:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/8] wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Record statistics for the 3SS rates too.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.h | 7 +++++++
 drivers/net/wireless/realtek/rtw88/rx.c   | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 24ac749271cc..c15e0f55d09a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -386,6 +386,9 @@ enum rtw_evm {
 	RTW_EVM_1SS,
 	RTW_EVM_2SS_A,
 	RTW_EVM_2SS_B,
+	RTW_EVM_3SS_A,
+	RTW_EVM_3SS_B,
+	RTW_EVM_3SS_C,
 	/* keep it last */
 	RTW_EVM_NUM
 };
@@ -403,6 +406,10 @@ enum rtw_snr {
 	RTW_SNR_2SS_B,
 	RTW_SNR_2SS_C,
 	RTW_SNR_2SS_D,
+	RTW_SNR_3SS_A,
+	RTW_SNR_3SS_B,
+	RTW_SNR_3SS_C,
+	RTW_SNR_3SS_D,
 	/* keep it last */
 	RTW_SNR_NUM
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 90fc8a5fa89e..8b0afaaffaa0 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -73,6 +73,12 @@ static void rtw_rx_phy_stat(struct rtw_dev *rtwdev,
 		rate_ss_evm = 2;
 		evm_id = RTW_EVM_2SS_A;
 		break;
+	case DESC_RATEMCS16...DESC_RATEMCS23:
+	case DESC_RATEVHT3SS_MCS0...DESC_RATEVHT3SS_MCS9:
+		rate_ss = 3;
+		rate_ss_evm = 3;
+		evm_id = RTW_EVM_3SS_A;
+		break;
 	default:
 		rtw_warn(rtwdev, "unknown pkt rate = %d\n", pkt_stat->rate);
 		return;
-- 
2.48.1


