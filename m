Return-Path: <linux-wireless+bounces-6039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C964F89E3DF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C81F22057
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49000157A44;
	Tue,  9 Apr 2024 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML5pzFHz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A231E89E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692006; cv=none; b=LOGeJjNM9jaqViHuX9NPM/GD9rJ3TOavPsEAGSHjcNHqDPyPV3AcwkJYxB1xcAqCcNzWnJG7lth1S0xbMKiL+qeSXaWMtcSZM1jdC/kCZZn6TBfhTOcE48yB2Cjr4SMrPIYkqwZM+8G06flVVbYniOx8+IR3eolWMtkocIKwUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692006; c=relaxed/simple;
	bh=CBOhLK/uao1vokigYOTH9RJEgSWlg5ABsNtjSutPt1A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tf11qukClUaVKmCKyvKHPdbwKprtQAmJ6oIILvs2vtbNDLFpM0g9TKf2D9gPUqhGnhqm7m35PFu6wsRsvcmEFFNZ4IGiARqMtsKm9FkZN2MSITZaneVByXT8rVOhGK8uHZ3Kf4E8yTyUeeBnn80MevfWKq/Kr+SbeMNPmTCeEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML5pzFHz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46a7208eedso872652366b.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712692003; x=1713296803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYg/gvZwcx3MAcXs0h3Q9eqiJ0H12k2ZcTxoXisnt/I=;
        b=ML5pzFHzl0kiBsk7uC4xPvbmClt6Vm0MTxCi086Z6XEdLF+eeF2Yd7dGXpEGZTqZHU
         +gzgbpbi4goVCzW3Zg/zOXqK9RzFr971QyRGq4V7MjuWdqjplZvxxUGtbF5AjZ6VHb7Z
         c4SUp8EDekxE4nkTNS16Mn1wDyle9a1DiqWfaIERpR0JGiDxz6wFvsBlt7pnsJzJYzE7
         JJeoZRxTSXUBkQT1XPrL4iFXZ6TVUSSh3lYLnKUwiSI06ml9WBl+lzQsxVxfRvH/AKuo
         rkDz6C0cDICxmlxFrFH6Uc/A9Tq3bsbdfa80hK2E8J4HLCbDRHH0U9FuZxLvB0Bt0Zgn
         WGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692003; x=1713296803;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYg/gvZwcx3MAcXs0h3Q9eqiJ0H12k2ZcTxoXisnt/I=;
        b=EM928tiF5ZvvTZGZQJnE1KKWlE/AHxxt0xc3HH9Hcaaug6ilAmFVQfhQDk9uNgeCZu
         PbviXuaBpqCJZkSKBf5jxuVfqlNPEdrVN+dsoSuICmBkKGh02ux8c7GnCeedaAb6QTZq
         LeCuDfwucErnpV19U59p8tT1v1mr9xHEI3SUi2lpsn7hlVCg3HmTxjX91eCZIQZzJhW6
         Yq3oqvSOXFkks+eDFpJ2ZLcUvEZlLkzlBu6hmtHM5DEbkP2rSHl8ge1eh3YRhvgq/L+G
         Mo8TjEJZWxGoLO7YKgNud7xX9CMO7UmOn0B3zxSKMXRRHXFQiR/0N65GTu6d8biP2+lb
         qoSA==
X-Gm-Message-State: AOJu0YwXFa5OavlwJ1OAt2dJ+aXA12CQgxzdLUBSOa4JZRKNdzsHXnAO
	dHkzI2jHEwiMZSzXliPBplcyJkcU4GqvQYpTdm3fxGL3inK6RZ4KAFEglqBDAR0=
X-Google-Smtp-Source: AGHT+IGWZKF/UlTdp6OuJRCzB1mgWVT56/wDjh7OG+50lQo6GecfE+7RQ1dw/8w+ThzVwr0K1WIgPg==
X-Received: by 2002:a17:906:e09a:b0:a51:d1f6:393b with SMTP id gh26-20020a170906e09a00b00a51d1f6393bmr242088ejb.40.1712692002634;
        Tue, 09 Apr 2024 12:46:42 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id xi1-20020a170906dac100b00a51d3785c7bsm3140884ejb.196.2024.04.09.12.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:46:42 -0700 (PDT)
Message-ID: <4bc08a14-4b6f-463f-a913-ad7f11b89d4f@gmail.com>
Date: Tue, 9 Apr 2024 22:46:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 01/14] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Language: en-US
In-Reply-To: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Different channels have different TX power settings. rtl8192de is using
the TX power setting from the wrong channel in the 5 GHz band because
_rtl92c_phy_get_rightchnlplace expects an array which includes all the
channel numbers, but it's using an array which includes only the 5 GHz
channel numbers.

Use the array channel_all (defined in rtl8192de/phy.c) instead of
the incorrect channel5g (defined in core.c).

Tested only with rtl8192du, which will use the same TX power code.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - CC stable.

v3:
 - No change.

v2:
 - No change from v1, which was originally sent separately:
https://lore.kernel.org/linux-wireless/9995b805-ef8b-47c9-b176-ff540066039a@gmail.com/
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d835a27429f0..56b5cd032a9a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,8 +892,8 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel5g); place++) {
-			if (channel5g[place] == chnl) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
 				place++;
 				break;
 			}
-- 
2.44.0



