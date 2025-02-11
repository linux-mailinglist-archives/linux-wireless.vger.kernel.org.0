Return-Path: <linux-wireless+bounces-18795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75942A31897
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87201888EF4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98336268FD0;
	Tue, 11 Feb 2025 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw7Es3nj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7608267AFB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312775; cv=none; b=VSKu52C2QVqhB7AfLoNoLexRHNLlY6HWy6yBpjorBArx1wt0acg1YAgUbsYIKwX3KHJXkBlhlqT7YCoiT9YyGKJW3NkwavK7JryJCjMTMfz+0Y6vSZVtbo5iKXdN9iLntvErx0oZgNeJ6Mb3OpSe2IQyzGeXYCeUX+cGktIl8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312775; c=relaxed/simple;
	bh=WMQZ4G6KGSATIk2HAhb3UOeSAY7+nKsmS0IBKr1z/4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eKb0mvgsvuoos2sUHz+2znqXvURoQWKnjqEkr4neqk1JSyXF7PcmLww4u5MWfGP0Jl0ffuWjRJkIwOdrgaRcUan2Cw41flRHeVdMuWzoJ4z9XqbFLeyv7PuCyXxUyCj0jdvVGWidGhHxrScTgOC/oOtTrhHB0QkQB1MGSp76veA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw7Es3nj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so133668866b.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312772; x=1739917572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0fTULECwBuzzTX7pSLnSQoHxx4aAeFdJAs05MrYoVJg=;
        b=gw7Es3njJTjkjbjDLCjr88g0nFCfOKu23LCIGnrijaS3yrWQywPU+MyiqSIc3VJke9
         Viv8QRQtTdXL6kKz9qKYZp7fUN74/eEj9uhzA3yZuS7GKG8NC33rps2+zyuJ6PbZaZxw
         3sa7a+f9o1T/7SRd/oIsaFUp9EeytWEC5Hoo3nLYKZRzygGaT3yoMiTbEml/aMKDIbyp
         BdB1F0d/xgGR7IO6lqYrqhK3MaZ7BaylxLxJt2Nrgo0VAUKUlYWrY2ZjayVlonxqrZ95
         ZOqviYKmdvDtwWaQpUNdFOfIvPZOQgBy97hkQ6OCdLXkDZrrS2umQ3qirw//QWbN1rrx
         wg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312772; x=1739917572;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fTULECwBuzzTX7pSLnSQoHxx4aAeFdJAs05MrYoVJg=;
        b=ZJdD7/LrYt+jDVhIG4C+2oHOzRry8EMPd0+thaiDDhmPQhrcZU3E3IGt0N0urI+JiV
         rIUXhZGuR5ok7QsbrveKdb7JwMZHFF4aCWupHo7t5LH9WaNtT+1I+s8U2F+Fy5q8DqtW
         sYATF0NXustSMeJfXgwtANJnzMhAmtVMEEqPSD8KdqjE9JOaWThxRa0RsFJpGLrpw3b6
         tLNIneXOKFj8G9r8MWc5iczf9hymky2ydmbagqHHfKFX/CH9hxmKvLnaxEdQMAYkIJ9k
         t+Ng7tf/ZCLWaBKMJ+Hs5A6cRCHzIxxl/om1CiNyCVcK+eJp5J+CgRIepno9lr0LyxNt
         N4Rw==
X-Gm-Message-State: AOJu0Yy14y1MicOytyZ5zVu9Gi9nW4G/abarMxyH0AcbYPqaZrIfZbVQ
	JpmvawkO7CFFFKGmLUeEpxO15L7+FbHdlINjHHudFGPmGvuGZJ/fZXq0KQ==
X-Gm-Gg: ASbGncs5PpVmlLyCoO7sElSuZiIxDreVSo7yvNZpjrxnzkBri8lJvBIeOn+IwhNcXx7
	fYy2C1rgJRy1T7qREzRUK3edIJhk9N+62NUFSpHld6NOFhZoaeOC/4CVSOwpyk7FBoEqtN6QWrY
	qR8r/Ng/weJSmgmlesNz/g54F1ULSpBYsuJWk3Kad1dbKExs4dZvztAAn8cT4RDJQy0PiuyP+4F
	iPAEX7wRqecg24juW8BZbBx2o24CYxXqJ12proBIW58N5xlNmGwufiaHnQccw7C/qHr8j447xkA
	WEU8La7ZWsgp6SCV72YG/I8L
X-Google-Smtp-Source: AGHT+IF4CuNeb/uBtwZKMJf0n2wp8/3yvZWxKaaJzIwsdFFCFn4EmKbYIKLaLSl7tPUk/bHJ0/ZqJQ==
X-Received: by 2002:a17:907:94c5:b0:aac:619:e914 with SMTP id a640c23a62f3a-ab7f33b480amr77530666b.16.1739312772000;
        Tue, 11 Feb 2025 14:26:12 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e386014dsm188617966b.55.2025.02.11.14.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:26:11 -0800 (PST)
Message-ID: <6bb6443a-3e2a-4cd4-83b9-34d2eb235654@gmail.com>
Date: Wed, 12 Feb 2025 00:26:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make it print the TX power details for RF paths C and D, and for 3SS and
4SS rates.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 1adb03d1210a..0efb5c19b90e 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -708,20 +708,14 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 		   "path", "rate", "pwr", "base", "byr", "lmt", "sar", "rem");
 
 	mutex_lock(&hal->tx_power_mutex);
-	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
+	for (path = RF_PATH_A; path <= RF_PATH_D; path++) {
 		/* there is no CCK rates used in 5G */
 		if (hal->current_band_type == RTW_BAND_5G)
 			rate = DESC_RATE6M;
 		else
 			rate = DESC_RATE1M;
 
-		/* now, not support vht 3ss and vht 4ss*/
-		for (; rate <= DESC_RATEVHT2SS_MCS9; rate++) {
-			/* now, not support ht 3ss and ht 4ss*/
-			if (rate > DESC_RATEMCS15 &&
-			    rate < DESC_RATEVHT1SS_MCS0)
-				continue;
-
+		for (; rate <= DESC_RATEVHT4SS_MCS9; rate++) {
 			rtw_get_tx_power_params(rtwdev, path, rate, bw,
 						ch, regd, &pwr_param);
 
-- 
2.48.1


