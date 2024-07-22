Return-Path: <linux-wireless+bounces-10431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997F938DD1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 13:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BDB1F21C76
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67413D53A;
	Mon, 22 Jul 2024 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSH16cpE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7316CD27
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646093; cv=none; b=jok7wa6S5Ii+ES8V0T5FIAghlyl6RikxuayP5w3bX+OKse+Pv+CFOSaaFYJ9WVE4ctVocM7utxKbSR6kMVs5n0jaLrKdqSwZ1X4+lwF5/AI+V3TLBOvJtMFirRcOspTMnH83rrL5jYoYBFYhspbPJkldzbFk+PCN193kwRfq3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646093; c=relaxed/simple;
	bh=JQWQzL0an6wMM6TwvRnl2dt9VXu2SHogJ0MaZ7ysE3Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ltpRIE0oH738VerJ+m3aORyyAZn+9IuJEdKGpWr+ohlYPuroHw9qVQLuQ+KMw/zP3tkuZMEzEFpeI9mD2tYwSyCrl3pY76UUkbvZVRuoI1gBBjQHGAeHX76ecAaYza3V0ofI5Lpc1H3lMIrT+m3xCRWihelG1st7DFGTOgHtasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSH16cpE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77cbb5e987so371037566b.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721646090; x=1722250890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10sTknDccu1nqfFEH4N3znXKbDcCDxyriSJwrZpBRpk=;
        b=VSH16cpExpQvmOR8khKQL9D+MsUALk05cyYyYPVc1E+ysyXEFBCYAFCcZB8Q6698UT
         L3af//QuJgOuOleLGRyeCi86TFppYjGOehZXhd0salm9SlxFqOL8ybq8XPEYbdTgcwqv
         ttQVXH3aEyjn1HR/b8m7ZIfrBC2MvHn3YGjWucxQUKHYqO/vfa9MyCAszuq3MyTFTMyF
         ppTJ89oCU5mVR+Q3BUjiTTN2BcP9jHG8PB4iOX8sEtq40hIEN1m/uZKjdGknLXLPX5gw
         ISxz/j+/aEhwNChq1YrisyMp+rdj1Vr5MCbzETfm4DrjhTn0NNZs78wzcqhmc8sV5qa5
         IpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721646090; x=1722250890;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10sTknDccu1nqfFEH4N3znXKbDcCDxyriSJwrZpBRpk=;
        b=HkTLC0H+1oEobtYqee5Xsvpan1WBbO4Haaa7Zgrm9m+RQrw9CkPo+jGFgQonbYTvpT
         V2TXN+pEVzS0BRZVwdwtHlnG2X6rPeroIcIhuFQdnlaK5CcNT1J05Blmzz+1fHtIlqo6
         HTdW1V6QeOYeH6O6kFIP8hCLCP3ctwiuaEZJKDIsT1STcyXcHhJO5haAs6tBWJqk3ypx
         iHP79Z6X8WXsFN5geuq9Hjfr5Rgu1MPzn07cJ5SBAjk+N2tKcI6ueU7fYKxdN9dHwxtd
         hDdVB2quUhuMxDSDwtWcMdBd47MKAJ7P77QOgScXz+PNqjyLnr4RZ73/0Ggg5qi8n5b0
         2RxQ==
X-Gm-Message-State: AOJu0YxADhwEcdIyQ+ySCNmw5Ria5VwRqaHl7mSC4ZQ+K7loXsMoJaAr
	Ae4Z5SblJx/KzzuDyXlr3d8gXDi3zuvtG6hGXk/ECNCXU4w58DTMG2CIEA==
X-Google-Smtp-Source: AGHT+IF0t4kIq6Da7FhPfhSJUu74JMGcQo03Eu9TO6SZOUF9hedz6WxaTuXsfD9QCCXqhM+AZIoJbg==
X-Received: by 2002:a17:907:2d8e:b0:a6f:4f2c:1936 with SMTP id a640c23a62f3a-a7a4c4147e1mr460327666b.44.1721646089786;
        Mon, 22 Jul 2024 04:01:29 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785ea4sm407346866b.37.2024.07.22.04.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 04:01:29 -0700 (PDT)
Message-ID: <432bf0ce-e3b1-4fe7-ac17-51401c029203@gmail.com>
Date: Mon, 22 Jul 2024 14:01:27 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] wifi: rtw88: 8703b: Fix reported RX band width
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Fiona Klute <fiona.klute@gmx.de>
References: <d3267712-e458-4a02-9408-f3d443185207@gmail.com>
Content-Language: en-US
In-Reply-To: <d3267712-e458-4a02-9408-f3d443185207@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The definition of GET_RX_DESC_BW is incorrect. Fix it according to the
GET_RX_STATUS_DESC_BW_8703B macro from the official driver.

Tested only with RTL8812AU, which uses the same bits.

Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use Fixes instead of Cc: stable.
---
 drivers/net/wireless/realtek/rtw88/rx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wireless/realtek/rtw88/rx.h
index d3668c4efc24..8a072dd3d73c 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.h
+++ b/drivers/net/wireless/realtek/rtw88/rx.h
@@ -41,7 +41,7 @@ enum rtw_rx_desc_enc {
 #define GET_RX_DESC_TSFL(rxdesc)                                               \
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x05), GENMASK(31, 0))
 #define GET_RX_DESC_BW(rxdesc)                                                 \
-	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(31, 24)))
+	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(5, 4)))
 
 void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		  struct sk_buff *skb);
-- 
2.45.2

