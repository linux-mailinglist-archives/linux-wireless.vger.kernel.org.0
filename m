Return-Path: <linux-wireless+bounces-11272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E0994E31F
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A491C20DA8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775361537A7;
	Sun, 11 Aug 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn1KBgjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C93136352
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409650; cv=none; b=WdpwJrBl+01Q8seKoAk+q7fOrwRKsRJmFlfLCI1kBXyMWDr+wFwUOwMs1HRUx/C1luZToG4rzfvvOfcI9uduUdpPhvJGJU1gZsNm7YnEL25ybhv3f6qy91WO6uELrqgSDH4x/5ENezqSM32qjbjj/y2UEikkzwyf6UnfHJFxGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409650; c=relaxed/simple;
	bh=adHpK1ifi+dklQQrJDluOG8/ESC3MpkAtTBtU60CiVg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aAtfLTNa/9vtY8xfBdYgkATLeXWObILct8vAAyU7LlC6Yh4aqRBAushbmSH/aMW9KP2K3hfJ7uXdWrbJ3LD76xu5fx6Al9tWQB3w3+d+cgv4+I4ZOLFA29g2jVXK4Uam13khWFUKZkIp4OMsdBxuAFwiIrAT109w4VmN5Z/kJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn1KBgjy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7de4364ca8so406872766b.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409647; x=1724014447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRD4dZsHTm3V8bgCNjhDKAuuVDmXXU8d3d25M1QbT2o=;
        b=bn1KBgjydvaXoyQ9ZzM965oZy97IZc2oefx6w7i0dYiBkarNtj2gM2wpmx5ROdLvFL
         +gKY4zdLpjuVFIcvVMCOr29A6YX4xnwW7odVNhEGdBPmWuTvsd8b2k906BEST11CzHMB
         kv215QkCTV3ZKX8qI+yllNLlVbDWDfRDHj60ssOlM1Xo9YZvGgoKxMyHCFqyaEAf4caC
         +cWA6G0f8qFWn8Po2KfAXVJ1axdGTuYPzxjj+rtdZwGJEhtN0A8gYzTV2TZ3fcnh+env
         nH4PB+u/71O6unmMexhzK6zLmCkGfBkqgttVkD517utsefUeKapCAJvbQwWUKmcKw3dO
         GN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409647; x=1724014447;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRD4dZsHTm3V8bgCNjhDKAuuVDmXXU8d3d25M1QbT2o=;
        b=lX2S/CnwpefM2jW4j56cKvSAy5LRWGMVC/NZlTvl/miLJ393cGf0ykFOFAqwTaqfDJ
         5mNiEMcju5jAAaBG/CySuCBQiJL0TDTnZepqye1SILlxTQKx/fv6p+YBWmFW8UYtIA+F
         dUQCOmZd/q7Vu2/njPe3qAD20AanlJGsm8ooU2PjL1BZM62ej+z6/uoQC8e4PPR0FrJX
         txEp6zUHn4foGHwuuM5vhVvcmN6su9ukJibi5r45vJkyFqFJEbiCRwBxEekmyo30xCkj
         J6qsPlNSjM+KKPRcEN/GDlCT5eKl8j3On4W7znAW5/xpOVq1faDA++vMIeRUqKjVmW0B
         7DXg==
X-Gm-Message-State: AOJu0Yz2epJj+O/pvc3RJA2TemPkpehRTvUopL/GBtHvW+lD+BsYj86f
	QNOw+Yt5tDCqM8ryXxo5w8NTcQjENNpzQVuTc9pX3LSKQ0E66CjJVQNsew==
X-Google-Smtp-Source: AGHT+IGuLA1x7VcG4TT91WTAp47LUEP8lyXix5AOZwV9IYj633ra+GYVJXJsoKrq6zB29sK5stlpPg==
X-Received: by 2002:a17:907:f194:b0:a77:e2e3:354d with SMTP id a640c23a62f3a-a80aa5968b5mr541857366b.23.1723409647054;
        Sun, 11 Aug 2024 13:54:07 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb090a47sm171290866b.41.2024.08.11.13.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:54:06 -0700 (PDT)
Message-ID: <0394f438-11c0-45b1-aaf1-509b87496c5d@gmail.com>
Date: Sun, 11 Aug 2024 23:54:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 01/20] wifi: rtw88: Add some definitions for
 RTL8821AU/RTL8812AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add 8821A and 8812A chip type enums.

Add cck_high_power member to struct rtw_hal. This will be used to
calculate the RX signal strength.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 12b564ad3a58..7e4618095eca 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -189,6 +189,8 @@ enum rtw_chip_type {
 	RTW_CHIP_TYPE_8723D,
 	RTW_CHIP_TYPE_8821C,
 	RTW_CHIP_TYPE_8703B,
+	RTW_CHIP_TYPE_8821A,
+	RTW_CHIP_TYPE_8812A,
 };
 
 enum rtw_tx_queue_type {
@@ -1936,6 +1938,7 @@ struct rtw_hal {
 	u32 antenna_rx;
 	u8 bfee_sts_cap;
 	bool txrx_1ss;
+	bool cck_high_power;
 
 	/* protect tx power section */
 	struct mutex tx_power_mutex;
-- 
2.46.0


