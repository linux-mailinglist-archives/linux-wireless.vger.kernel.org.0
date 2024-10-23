Return-Path: <linux-wireless+bounces-14406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB989ACC09
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DB4286A64
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F7DDAB;
	Wed, 23 Oct 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7JftI7p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3B44C77
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692918; cv=none; b=uA4igcpoxmsB0J1GM5wkBkSmU126QYHPMuv+XcI0EvlGpf9Yp8oCokQgLlak0LdsPrQ8+ty1WbY1ynWTnTLrJVgpmB7PJ/Y79xbMMmIC6NUvGqQyvymc1N3VU2/HWSGZ1xHu7GYW87K3WUcDMIM/5ehhDp+kDbIYNGOyGIM7IA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692918; c=relaxed/simple;
	bh=PocJAPRdigeJoFlbfp/lpBpXJOxu3GlKc/1CmmI9kBs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U/SaQhrh9gNaJgvTi3AxYXw5opGcFarKf9Dlg+w5899WvEGgFgT43X6etHRBIu259imXFbpx4HBKukkiaY2jdRvHQm4tMMEx73tkxeSPrD0XkwYvk7u8FZ02TQACIkcvNdsdEzNHbEfZfnCm/gN+SYwO5mpaJA1WQqcA/rEjX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7JftI7p; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0472306cso921985366b.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692915; x=1730297715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rBUe/PhKxdG0MoYmuuufb9bsH/UKCUdRm1wrkRyNLGM=;
        b=N7JftI7p4iz0bjxCABhm300wg9zsKQ1LLMBYR/9KB3naOF3P93U4hpK5GRHM01aP6W
         UisBcq4iGX6fiXf6UIZXErC0DDqcNBUf5HoWYJ8Fb3yeYw6V5UO3VAf7EjoMdMgMEoxr
         Iq9ycHKPugFKsgqZhNHC8u+OpB4sk0yE5Alw4kSjTadJ1cDUooS/wnE65Fm4Ce0P0uBE
         kuUztcTszMFJBjFKF+RSFl9WoQlAoTUi7LDx427jMlCNCaeGWaSTXckO+7WaxXn8D5eX
         SLSiNWn30Zu3JJO0X2KhjhaTSxTBM127R4SHxR2pPTh0UGiM2m7ityu0AZZqfZJ35E0W
         t/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692915; x=1730297715;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBUe/PhKxdG0MoYmuuufb9bsH/UKCUdRm1wrkRyNLGM=;
        b=mbuCJFbH4mZeW0znEJWby9bi+2utkI6EGajQp3ziwvO8xupjIOxJSpniuAu+Vil4On
         nSs5md1EiAtSdOpPXwxIiz+683g6kraSmXilzevA3/nLOEXkrfJQLmVEUul7Qhv6mKq8
         4QRhcrs++Om1Iq++1YQN8vuBNTBt74DQl0TVNdtSKRrrojQUhGFDZw2UzIh4DWrcMUS5
         E25YYX08+JYhF628c8XBBQCTPkMMv7uZoHA24ndBGFCYV28y/iz7/zgwDgAfe7kPkx+Z
         2RHbcMtaCN2n6C3fe85GDSG3yzD7kYQtLfxCxKLx3zZIAtj/7RMs8PR1rD2BSI9+f3AT
         TZug==
X-Gm-Message-State: AOJu0YzcK4CKllpTu1U0Ew0uBRs6oyol+8P5lKdI2pgf7nfeX9SB+RjT
	E6WvJbR5SpEO81btN59cLh+FYbYPwAfSx7B+FYvBoJfI8S3SsYYbc4p3bQ==
X-Google-Smtp-Source: AGHT+IEfJdj7luP1eQf0HfHS6kxHQPDTrKzCOdVhgLVy2oo799ni1gzWU91vrWjS3Q7YDUjCSxAsUA==
X-Received: by 2002:a17:907:7f9f:b0:a9a:757:fbe6 with SMTP id a640c23a62f3a-a9abf9a5895mr284780366b.53.1729692914976;
        Wed, 23 Oct 2024 07:15:14 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9137074fsm485639266b.135.2024.10.23.07.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:15:14 -0700 (PDT)
Message-ID: <203f5043-4fe1-4f35-8b8f-d3b6f44e1fd9@gmail.com>
Date: Wed, 23 Oct 2024 17:15:13 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 15/22] wifi: rtw88: 8812a: Mitigate beacon loss
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
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

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/phy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index b52108f2b147..40c36118f579 100644
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


