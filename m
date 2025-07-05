Return-Path: <linux-wireless+bounces-24841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84CBAFA173
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC913BDF6A
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33B1FFC5C;
	Sat,  5 Jul 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzXbfA+8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC82E36E6
	for <linux-wireless@vger.kernel.org>; Sat,  5 Jul 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744224; cv=none; b=mTQxx9t282vwI5eHCbGwDihpgQ2b/tkNhVhip8vaBoLJfS3443B+Eewz6xc4b7yvp5E9S/OwrcnsdievZ7xdc2uUPc96hgbeg1ypieYByIZzHtOnGvs+YKjsDwIsn7owkN55UhHiRoKgt3THugLxYUQtDeqdMmgAh2q2uI1eMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744224; c=relaxed/simple;
	bh=oAyaqDioFqM0zLXr229p2pyVEbbsiC+3nCVKblL6mE4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G07qpv2A4JDBnp5yq4Up1RhnsykRfzkMX3qTK11z4xXPTxjkOHj9wYohTa4c6qhU9mN9FEg4QzTipLMXFf+WdjQxNPPVIz3iN9zpKI1brXsmZssMMeJQpTk33MtiMg8RGElrXT4DrekQfWmkla/EGM9vbbEg6nbYx0iraaeUiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzXbfA+8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cfb79177so10276555e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jul 2025 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744221; x=1752349021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nanAbwizA5SceykiP7rsB0rSlAbsQ7wVJ61I6Yz/oXk=;
        b=HzXbfA+8l5Dy56YtlvivnL7W0Hgz5QLTLeUjHN0HYefVdTG+D5SGAazcPZSC3v1AQD
         xJFhWXzrFDHnyMEobTCYp4F+C4CN15y1wUze/puMd3660IGKfRts8G/ALte6cUQo4p8R
         v7dU/BNjqW935VApq8nMv69BGMkI93CMQaqzES+NlvBN6raAMhzXDB5Oi4KOKSu9tGIN
         17xtcY1O9NxprqwwujErGnOISofgwsKdNPOWVQm1VjYONQN5s2mz7IgHlXml8AYJseWt
         bj3qU4PxwMgzgWVE4MV1fh1o9fM4jvc/TQjUZIceA6cv7jqJ6VpdPyb06emRBaA/xgp5
         jHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744221; x=1752349021;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nanAbwizA5SceykiP7rsB0rSlAbsQ7wVJ61I6Yz/oXk=;
        b=wT0YRNUFrWhv6RYHFsaW8d4ZbaxMeLptCaY0MDrkFuOeO+KySqDE/KdB/PG7mJnVmB
         Q6eD6f6KXKoc4Ui+pv/eP/BcPV4bsdtnmxputGrfI2LE1LELWcTM1s2w1eVIn3cKMlFK
         8y6ZXP08OMlv18uwWGpeH2J1xMMp0Kp6goF3gmb87v3gPsnHNHVll61ViTHoCIxUNLZA
         qKhIOEwB/SLxgEMN7IU7tIHkCo8wCXKqV3DGIc6lZA+uS4+FHKUbGlacD8WLlxteVN8L
         cLAuBZKwgNu3fMUrtpi/Y+XFgRMARpuoBvlkK9dYrzkV7/2DmC13mQVyHb/PdUhvC8Y7
         OcNA==
X-Gm-Message-State: AOJu0YwqrjsPI6S0oSc/y1QTsHy8s1PnXH9syR+i/T9gzftraa0ltfQ4
	ZQmRjE86zIMETBtrNa0CLiC7gPumytJaAuCZt8Z6tIrQcBcwN8Pl0NEZkax/aQ==
X-Gm-Gg: ASbGnctfvnX/Zzdr8oaYNci656lI7zwS5Ve74Rir87YqokKFM+89Qk41KqSFGkoB8Pu
	/IICASDq9rcdw3oWMZCSOytRXEQ65+WJBiOnDV4qpZY65gA81ODyjIc3mr4jTpVndNCGbHFqm/d
	EPDQgWUySnfRPAfpPqheqjRnMW8EuZOB1EyixGBVZCkAR+0m9VFk3UbHpRg/zB9Ww5tMvtbo/32
	eg6i8qjjrUXQ8MSZ/d6CpmtMvqWFq73Kge3Lp5YnNYcNKXLcJzB3HKG0a8wl8Os2d8Yj6R8kV4E
	cpIDa0unqHQHeujjjwjqzurdeNc24zr/TNLLJ8ytGuY9NBPT+jq8yTreD5XmUGSc3t8zTg==
X-Google-Smtp-Source: AGHT+IEFDCPpJhmCnBka0ahZrbP4bXNWmegIh5ssRW9dTq27AEpNhfmlnSSQ6y2uCvxIdqnuOGG4jQ==
X-Received: by 2002:a05:6000:4812:b0:3b4:65d4:8e27 with SMTP id ffacd0b85a97d-3b49aa77308mr1935536f8f.29.1751744221159;
        Sat, 05 Jul 2025 12:37:01 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470d9e470sm5623668f8f.41.2025.07.05.12.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 12:37:00 -0700 (PDT)
Message-ID: <1f58d168-67a9-4d86-9e6a-73789c7a59f4@gmail.com>
Date: Sat, 5 Jul 2025 22:36:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 1/6] wifi: rtw89: 8852bx: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Language: en-US
In-Reply-To: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make __rtw8852bx_read_efuse() accept USB devices and load the MAC
address from the correct offset.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 .../net/wireless/realtek/rtw89/rtw8852b_common.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 0cf03f18cbb1..3fb2972ae6f6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -172,14 +172,6 @@ static const struct rtw89_reg3_def rtw8852bx_btc_preagc_dis_defs[] = {
 
 static DECLARE_PHY_REG3_TBL(rtw8852bx_btc_preagc_dis_defs);
 
-static void rtw8852be_efuse_parsing(struct rtw89_efuse *efuse,
-				    struct rtw8852bx_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8852bx_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					 struct rtw8852bx_efuse *map)
 {
@@ -261,12 +253,18 @@ static int __rtw8852bx_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8852be_efuse_parsing(efuse, map);
+		ether_addr_copy(efuse->addr, map->e.mac_addr);
+		break;
+	case RTW89_HCI_TYPE_USB:
+		ether_addr_copy(efuse->addr, map->u.mac_addr);
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+
 	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
 
 	return 0;
-- 
2.49.0


