Return-Path: <linux-wireless+bounces-11286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6194E338
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC161C21240
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1818E20;
	Sun, 11 Aug 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma5UYVQa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35012595
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410326; cv=none; b=iGqxEFhs6Vb9qEJ/PFcH/bT1XEkxizpO7iKefowhy9UOJZx6eQXdAgM4wuSfUgCt1aqMXkQw1qMJeLBgoPNRwDK8grSOKyEkfRDz0vQuuUWdOE2gyJ8Kc0rXZjvRewSMg8yeG0/PbF3Ql7aU3uydBemNGL/4Ezs5ZKmZz6+DMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410326; c=relaxed/simple;
	bh=mHTZ7yePzD2I4GThB+gTYuC0J7F1RCP6BcWh3e/VI3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ILjTKCcHDi0ZQ3Migfwd1wm/BbL4Lq2lh9iTRmuHI7gnY2RHzsrMCeqz3UCLiP9NndDdHd8QpgW8ZfUYCMpTL7mufOqqoWw2c/1tw6w4v0VLYdpCnxklq7CtRSFU4dhr3VtPN/uPwTFlA5Ng0o3t6qu+uHQtlSrqh0FTHLuAXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma5UYVQa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso4437121a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410323; x=1724015123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R66gI/BxDYgZGrfvtMuI/rr4Ks4BH+Q8UFp96x38ZIg=;
        b=Ma5UYVQamstUn+m+nYbxvn7RGGzqGAzDZJT0fk/p3OwlDOJaVbnQRJlZEaviCpSGUe
         l/KUGd+o7f1SR0CKRsXu3xq3JtTMFhoMnlSaCNuwr0EyUZAZQ1a4ECkw/ObPqJSiV17S
         5ao2FfaEkSQTJJ/P0GFZaWjmp3pS3pftlpuDsSzJJ54GxjJErjhi25CxB6LLPGWAvyVN
         JEpG2jIzuBJkPNqrXf8LaBLM4jTsPcV3Tsz5Zqbh5RMhxKttXRfBcOTbjIl+cBmpJd50
         ko3kC7KRQEF1cyIt/pw02vkbEULQMbLNvAqXZ7K2rYwh5xXiC7tornDRS+4/rIOLRSKk
         HRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410323; x=1724015123;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R66gI/BxDYgZGrfvtMuI/rr4Ks4BH+Q8UFp96x38ZIg=;
        b=Nwg4rFPfk5n/9WMhRCa7hWAv/9d20+k87clFHkPQNtT6f9AIo17XezqkXoVaO9Grvr
         GuJNO6YCC5TWzzfpbzsWZpoTJarLrvCPzw0LH4fzjb9v9SD0l4z74qSxVg5iq/Oz0wSp
         vwFj0GQE6w60xIqvlXYkiHRmsD7FIOHPp5p0+i21b9VB4zFGq0qCWZW6LB+lHAFc0PH6
         /PsWgM076XjirGWshLEkoCNJLxragJL4yu+sYdVN5mzEhF/g0WW+JVqdzT1kUtueckIu
         PyBIAPbpbOQWQRHEBeC3yE2McLdBXuw8Q0NgXcTdwLkdwpaPCJC30NA+jVKb2MytDR77
         y1KQ==
X-Gm-Message-State: AOJu0YxlDVlmyB/CwhKpGqQELAPA366j5/Zpb/Z4YOCypXXxhjqu0866
	LtLPKh+riW5pV3fS8bbaKMK1grm4HLVf3Uce87d+r2Cs+eCYZ7QcdNMCGg==
X-Google-Smtp-Source: AGHT+IHdHcekrtu8WQV2fHHooyJ3mUN2aM3lIVZj2o9ei6Lm5CqRL8vHVdmH3aZsfPfOUbLY8xzpzg==
X-Received: by 2002:a05:6402:5216:b0:5bb:9ae0:4a48 with SMTP id 4fb4d7f45d1cf-5bd0a509e51mr6019035a12.5.1723410322914;
        Sun, 11 Aug 2024 14:05:22 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f32fbsm1582093a12.11.2024.08.11.14.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:05:22 -0700 (PDT)
Message-ID: <d0b834df-801f-4b28-ba6e-d1bcab9801e8@gmail.com>
Date: Mon, 12 Aug 2024 00:05:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 15/20] wifi: rtw88: 8812a: Mitigate beacon loss
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTL8812AU has a reception problem, maybe only in the 5 GHz band.
Sometimes, in some positions, it stops receiving anything even though
the distance to the AP is only ~3 meters and there are no obstacles.
Moving it a few centimeters fixes it.

Switch the initial gain to maximum coverage when there is beacon loss.
This only helps sometimes. This is similar to what the official driver
does.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index cfe12a75ff84..fdca4e3c1038 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -530,6 +530,13 @@ static void rtw_phy_dig(struct rtw_dev *rtwdev)
 	 */
 	rtw_phy_dig_recorder(dm_info, cur_igi, fa_cnt);
 
+	/* Mitigate beacon loss and connectivity issues, mainly (only?)
+	 * in the 5 GHz band
+	 */
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8812A && rtwdev->beacon_loss &&
+	    linked && dm_info->total_fa_cnt < DIG_PERF_FA_TH_EXTRA_HIGH)
+		cur_igi = DIG_CVRG_MIN;
+
 	if (cur_igi != pre_igi)
 		rtw_phy_dig_write(rtwdev, cur_igi);
 }
-- 
2.46.0


