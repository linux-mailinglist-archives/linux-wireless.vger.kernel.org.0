Return-Path: <linux-wireless+bounces-10418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5809938695
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 00:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6EB20BA1
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2024 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8425322E;
	Sun, 21 Jul 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXyq4jMV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21743101DE
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jul 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721602523; cv=none; b=YZhaqm5p00hiSYHvdK9y9Dt3Qpwkvtb1kX9/VsD8Lql+qHwGOq5fxx6k79ODqxq1u7Akd5txjNACTGf4iGz0vrpfkdsS2oqa84umvwQFwRKeH+ASqRuIr/AjxQAO+XGyIzdcTm/Aluxr5CxqVRPRRBL7SmNeSz7hIHvLAJHEckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721602523; c=relaxed/simple;
	bh=4kLCRihZfAZaNc/VAWav0zFBu/xv3FTXAeJTxsQ3d28=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qeoEJVz7XtixyNyY3oo6AJi/+ZFAenJhELSnMnx6HhzwrxVfgBMC4BI7VIlFDkbyybdOLgVSMz9LV59bja39GQMJDSTOrJvTk503IDKwKCphLnsAyJMzJjoCi1Q51TqNY7/paoNCteUqW/zJIeLl65yJSd76nlQvfcyTTBzekF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXyq4jMV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so2879887a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jul 2024 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721602520; x=1722207320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V3uFIn772x/iA/Bfo6KBY14WxnbP+FlHltBawdJRh5s=;
        b=IXyq4jMVDYcTzir+17fidim0z+59XPQ+MUeenMM166aFvQccuWRtC2AoLzNPIY971T
         8N4o53dOrwAapJKJQXzJ2Qz+o3qe4TwqRnWhRZnVOgqSWPVl5D3qYzx/RszEeS63Qtmw
         WYepXEYD1QAIc9PtG+LwsnKQDByuRTMyV2WOEHTQ1C1SiXCnraWXejTM3t+/RXs7dLAb
         NbBLiMSu6S6w4yIIMly4yUGem0OnfSR4lBfDdGPsma1IXCY5uIk2FD3nlRyUG192wgEF
         X4YOXky02T78x6M4OgDITK+sUbXszOFTDsnDoJqntaYVZUxj2nF54cU34piGwNRJ0B1/
         aBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721602520; x=1722207320;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3uFIn772x/iA/Bfo6KBY14WxnbP+FlHltBawdJRh5s=;
        b=sKzg26pCHuGZ8l8WPkki46uRzgPI8TLqfo+tBiDGyUkPoh4V+2aZmxCwa8SLNl4EiX
         NlP0BPUTD0QAteuWbh3OyLTha1MqzD6QEeIUQvbkIQLswhgG/R3/1VPKdD/p/eljud2z
         UDgp2T+1KVIPDBUG8Md779i0Fp+EVk3l9G1vCuseRH+EexBgGjpqIqzUz3GwW3CKrGRU
         VSDaHPVNHO+hCpA3az8CBskzBe83OdP2WO2Aeh07I0P3quWKWFKY0vse5EhmKcDbWuD7
         8AJHURRcbnMSvNDrHD5JlteiXj+iTl4cOhLZEEdzkZezCVUDweEFHba4noRbFDx4I1OG
         gt8Q==
X-Gm-Message-State: AOJu0YxIc2FH2o4IbBCMOOxRCZsBBZ5nweJCqCmqTL5jbEBvVECI6u3o
	7ZRsQvUqvRxgD36aVHk++g00qh5zbgiWjE0rUyIJI1ywUpKfR2aNXBijFQ==
X-Google-Smtp-Source: AGHT+IHFBvJABoB9JXzB+wZuGdwxASNwkH6SBNKvTioOIkks9F1+y3wVHqj4JjB4z+Df2VqJHwfiEg==
X-Received: by 2002:a05:6402:3553:b0:5a3:f5c6:7cd5 with SMTP id 4fb4d7f45d1cf-5a47a91fd73mr3091514a12.26.1721602520275;
        Sun, 21 Jul 2024 15:55:20 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30af83177sm5172013a12.42.2024.07.21.15.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 15:55:20 -0700 (PDT)
Message-ID: <712d08e3-fc90-48ad-bb61-bb601b2cf953@gmail.com>
Date: Mon, 22 Jul 2024 01:55:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: 8703b: Fix reported RX band width
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Fiona Klute <fiona.klute@gmx.de>
References: <2fbacb83-3e47-4f37-a70a-fb9f4719eb26@gmail.com>
Content-Language: en-US
In-Reply-To: <2fbacb83-3e47-4f37-a70a-fb9f4719eb26@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The definition of GET_RX_DESC_BW is incorrect. Fix it according to the
GET_RX_STATUS_DESC_BW_8703B macro from the official driver.

Tested only with RTL8812AU, which uses the same bits.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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



