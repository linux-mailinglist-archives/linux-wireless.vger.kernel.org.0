Return-Path: <linux-wireless+bounces-13915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0099ADC6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BF71F21881
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A41CC162;
	Fri, 11 Oct 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3AZ9HNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD9199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680053; cv=none; b=drG9T1BSQvC9B0Vn6qAlCTBKCFuYEfY4Vdz2bdgvqWYz1POYc+4u7CewFRcuSiu+noUwa2tCGs1OrSiNq5fGrdHgAwAZJXEa3s5Z11ON4QStMguunfBmYoO00bwimvc/EHRnvAJNyv2hoDrvI3g/8QWSaIXSkkjZtFvrwvPAFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680053; c=relaxed/simple;
	bh=mEmcWvGlSD91BMxg+Ysc8LAb2lNyAzUGJGh3c1DAE4g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iFJQ4l10LgFyAKvHObq7JIk6J6/kDMV259u46BH+8RjF1rV6FSzktRkFf7K1FH4y7461UU7VpuduBjqYRggbtdmGFPNM0iMxZG3YciQO9UER+yHtY8jW1o1uyWLs8PR/8Gajm8avT6pQ+uHKVOrlJDIuCHgAJN1dkWdQLTqgotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3AZ9HNR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43058268d91so21422135e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680050; x=1729284850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NsAlEDexyNtIT3M8EZfMXluGWdnroVr4LIgIIYeep3k=;
        b=j3AZ9HNRnpKDVCoxXUQKtxqKhNhqNTERLr4NHE5p9+oAmTAA6GxBq8A6d3O1kEahj3
         /JSDdCisYKfPsn6BiLldf+ZxoSUWhFlaIgEADrYkpyKrHKzqPTB25orAgWvGIdqs51g/
         3LnGSKP/rtLkKZdI4nT5oW7ZCt0VzCg4eapy8uwFeaKeSyMzXQAVlc7VbvgkJ8SLgsvc
         IknDzpN2Nq4XYynWuoaWBlxisG2Aoqch8vhG/3xk7q2D97OGUGfXYuUa+XRvgiTXsLxh
         Hwx6VQfZKAkz9pcHixTMxgH2wDMmBb3F+uqUCWolYlpxC0kdc3EfUfEkoE40aLqbzHSx
         pFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680050; x=1729284850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsAlEDexyNtIT3M8EZfMXluGWdnroVr4LIgIIYeep3k=;
        b=EwWg4Nn2BIegg8RKI9j+ECzH4KFSlld0zKvm+4BGSKVaZYNRutkcuJa4oBvzx9h6n7
         xIigUyfhfRMumrE55tiuSkebmi7EqMdsOCcUdooKoUmHetI0Vo07g1AWa5NjhMz4M/pc
         2iV599ym8fqyWIZQK4UYJnnmdnloaQlblEqIFZNOos3WBvKKfb+d+5xc9nDwKLU6+vaa
         BzwbfTizCX8QE3Z5bf2jrhF1O3Q/2UyphS+K5IOeFGOZPsWwqn2e6g/HxuDlzvh9k6C/
         2lJODCEvJQCzzcQj2HT99rG4m3zMhuxh03d7JT4avjJo4a6+Ydk8jYU/OqIScy41zCYM
         efcA==
X-Gm-Message-State: AOJu0YwrOeLb6imOPYq045JefPiwfLEZ+UZP7eePuZIny/qRy7QECskE
	DTaucBMeT0WUjWYsonvpiTh4EUFPyOa9hSlpBFcI+XRk4eX876JFyOuaTw==
X-Google-Smtp-Source: AGHT+IHFfpvvWI8UvynXeuNC9gOg21Hi44BjXHC4TnfhalZf94X0X/BKpLKdSuyV3ZlxiZPlqHg/rA==
X-Received: by 2002:a05:600c:470e:b0:42c:b3e5:f688 with SMTP id 5b1f17b1804b1-4311dea3d0cmr29358745e9.4.1728680050180;
        Fri, 11 Oct 2024 13:54:10 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51c69sm82807695e9.28.2024.10.11.13.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:54:09 -0700 (PDT)
Message-ID: <0cb6b0b0-5ee9-42e7-97ac-deb630bd4bd0@gmail.com>
Date: Fri, 11 Oct 2024 23:54:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 15/22] wifi: rtw88: 8812a: Mitigate beacon loss
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
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
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/phy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index db2aa0b8c327..7ee3da82e44d 100644
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


