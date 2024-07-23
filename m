Return-Path: <linux-wireless+bounces-10459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FD93A7B9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB1B22B6E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10AD141987;
	Tue, 23 Jul 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd31vPlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5913D628
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763185; cv=none; b=S3Q3ZqH7eZjosbBqBqM1CG7gaFgbjGq8HiK/BhVRw5NA1HFSW4XyQbmZ3G2sukIhG1tfhWIhV/96fRwWcgqY3Bfx/RsDC21hRns19occJPmWMgDgnuJ4kNQXJs66s3Uz2FhbxxS3A0XvTZuugBhrfUPsAkKuVJ3MgkWK1X0ochs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763185; c=relaxed/simple;
	bh=o+LUEWGgqTWSkGQc0DOmL+ipLzeABxAqv0+nb/tr6t0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tayi8XH4cuQeprt6QnM77VotLlvv+DnXqmk749d6s8ECQ0lP1LN257ZHUU0v3oiAR6CU3LNPMApk3PRvR4kFxcNwBX2jHSeYqusob1/gq7k/erjFIxsB60o7p1bZsKR6lfklCCbuZLHTKs7BSWoylCgO9aJm7i36PsRbiRFYjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd31vPlJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so26190566b.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721763182; x=1722367982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JIy4ls7s6fD/h2R9RtjPtacTlpHzU/ybjCNwz9UsVc8=;
        b=jd31vPlJsWkbxIKjHJ5PZ14E3+TG4rgl4VCIACQF59UQFPOI99oeHxHuT+rEldTkSB
         WBmpfn7CroIUN8hPJzQhzkH0CLQ1AfE6KiHSZXrLt54tR2WwDnYN3/ITXnNCrPd/X4OM
         UxshjRmBIjoMSE5LjIVWKpq96TbReZzwXqfbCaBRj+OyRRqysSbLQW0xzQJ/QAc8tMBq
         iOm5Moanq74C8Qqtft/kmafl1QOZcRWfr4tLVRbzWNmLfSLB2G5/Igcbqi7lUTJ+JpX6
         mVpNTxX/Z5e7QcTr10uUHWExsxuq5DKPgeZDFzHxU8vgdJwUe8ItsLr8CboT4CotT0nc
         +xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721763182; x=1722367982;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIy4ls7s6fD/h2R9RtjPtacTlpHzU/ybjCNwz9UsVc8=;
        b=KQYlCLpcWJZ4uADrQVW5UI0KRNefzKGo7gH/DyDOIH3zpWuYJ2IwUUM+5MWfdGZ7tO
         5lSaiuAXYTkx8l8qByziQfeY9gCkBmdXUcYLJ0I8M8zs/uaheq5Pv32u+df11RdcBJf7
         nKi1OcCk5P8xTd8hEgrKGnx8rsQwO8QdUQSLV7RV2juhrAWAuz5nK4fCtxmL+NSkemtZ
         AKLNzJEgA1eZ2gVIM9vRjKBkqvEa/R0ds+gUAj0SyfBnrHwtlbrSv9+VfNmM4RBrseX2
         098Jmnf1Y5UooIPehQBZ62JoCqmWDT93HxiQ7ETlhhKALMwqeJlexYl+l3wams5pWjvK
         3XvQ==
X-Gm-Message-State: AOJu0Yxs9jm4F2C6fKPvN+0yW1o4JnwUamvirJSYzJ8TdfrSDephlIMz
	cwt2gY0oGrpM6itLxuomHalq4lF0aDP8XQ0gOwn7XfHyFOcQxieHzJ3ZKg==
X-Google-Smtp-Source: AGHT+IFTLmexyzNvyyING5U6avcp22/tk6yjv8BjvRE+S8Qd7zNBzPS3Gf5r+acR+BoAWC1OC5j28A==
X-Received: by 2002:a17:907:1b22:b0:a7a:9f0f:ab2b with SMTP id a640c23a62f3a-a7a9f0fb5e5mr192408066b.32.1721763182211;
        Tue, 23 Jul 2024 12:33:02 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c950817sm572169066b.211.2024.07.23.12.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 12:33:01 -0700 (PDT)
Message-ID: <1cfed9d5-4304-4b96-84c5-c347f59fedb9@gmail.com>
Date: Tue, 23 Jul 2024 22:32:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/2] wifi: rtw88: 8703b: Fix reported RX band width
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Fiona Klute <fiona.klute@gmx.de>
References: <bca8949b-e2bd-4515-98fd-70d3049a0097@gmail.com>
Content-Language: en-US
In-Reply-To: <bca8949b-e2bd-4515-98fd-70d3049a0097@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The definition of GET_RX_DESC_BW is incorrect. Fix it according to the
GET_RX_STATUS_DESC_BW_8703B macro from the official driver.

Tested only with RTL8812AU, which uses the same bits.

Cc: stable@vger.kernel.org
Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Use Fixes and Cc: stable.

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



