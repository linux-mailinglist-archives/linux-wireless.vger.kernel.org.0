Return-Path: <linux-wireless+bounces-33995-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF6QKPJoxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33995-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:12:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03743338F2B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E0F3009B36
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335AA325485;
	Thu, 26 Mar 2026 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6QdBbNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC47421893
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544788; cv=none; b=ib3EK6VKiiM6WKyrB2cerrP+8Cy0oTYujXvS2Go7/IcsdWbyt2PPEBr4FdAxnaIvpL25os6Prp1/8DUFzasL3lftQX5zHjo/nFYuOIAR96JgWENgYAgKopNFWOLeYxOaLJqdbTBjPHb3+VAbXndzcE0WSivXaIgJWX9Gaz9Dlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544788; c=relaxed/simple;
	bh=vdBuHBOq5v3CyIkklfYdjkK3Cb/5fdl5Dp1gdctNTEU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sOz8Pj/BUwkYfQLdnFQunM+uRzGzorlfdFTUbprAIqhM/Sfza4EQVVCRmJe4bXETcuulSvZg4Jej3/yrt/1tZ2Ni/Km+DVb0UDrKRtj8YrajYqRy/9vc81SbtqlOOJmz7EZHxvcv0+MkfVaxZFkWz8DSUtNzDv48o5jESdna3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6QdBbNN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso796343f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544784; x=1775149584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xM8LnvOmrNu+sA+3SpkiI0cWkAGEvuNFg134ab2iIwQ=;
        b=P6QdBbNNK6WzUQEIyWZIGFXPlkJVI3jSv3mLjmhPqsBS3XkJcWpjUB7C6ZRAv8zw/v
         CVAyxABa2FTQewZb+kAYOzKyAmQvWXZeaWmQvxBs1iZAf5cF/kW8TTBk2JMKvrGkkQvu
         aY4UyHJcUQCICWCyvPN8UBTlfoFv3TToHfFG19JHbljCmbT4s5i1JylX5zmVxVMwizDL
         5EEM+LS1bY6HuEdjOv64eETkEHzwFH9MTD1BH16Vpb+WEZQd1ASO7RniJsA8+J9Gm/Ic
         xXBmpH9gwP6lS6r62w2m9CVXPq4h6UfAVwOtODjCPoAv/ymsBvE6hD0zrHXPEP4sqbve
         uBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544784; x=1775149584;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xM8LnvOmrNu+sA+3SpkiI0cWkAGEvuNFg134ab2iIwQ=;
        b=sFzIzRoN8ph/hE5w6QKoBIgPhY02v5aqOJPmypR5iSi+C6vLM2sjoHU5HXSVxRdbf0
         phw1AZMeoXQnFwj3nNzIIW7pOR1XKTSuT/VgSz06B52r4b7Q6QHEi9tQ16Txem04bLMt
         mPyT+3l/loNng7txCMnm0CM1/4/t/vCQKjOSdg0+ZdR9Z5Auv2keCZklgZlWjamhZf3d
         QEVtz//uucWnzMs3Wxw6DWp8F5hq7xumHoQgyD9TZhnu/3XAqb6levFKt37X3z2ba+QD
         EBjYWavQBh1iVXqQ2pu2iFAdbmCk6zjeEI+sPAB5Tbre2SJ5qQ/75pvHQ1s16qYhyq6a
         sAow==
X-Gm-Message-State: AOJu0YwOMmAQXUA5FOYkJffJdPuEgcmS56wpeL4fhgvHg8Skp6L5hPOq
	s28PyfcyGIa0WAjNFx1RSfFz51gWQ17sokM+4iMXccLJt20UYTUZcMlKMJvGMw==
X-Gm-Gg: ATEYQzypbOVwbKqe+PwX8JotuureTFK74c6z3JskiNRA4/Lufl1c1Vw6wtxvrAQZdKr
	yeUC8jw5b82Ub7hKMRAUu/NfYJ3FQSjipEOcMIElls7ELeC2pmiAnbEV3ssU7VbJr7ixiBAP1Kr
	Pvm0Cgs8yqzcoYhNqAockMbXDN5oTNvWfqCGkm66baZtYIUdShEp9hZbhvxylSHQ3klvmWUuKiT
	ii04SAj7vhmVEF/LHWxTfLxNzHbAZt3EFbnjRi/170v1nLJ2YXQbTGw8USsbij5XrCH9jUFycSS
	6/c3681n9VPGCt8GKbI41odXjQnK0llw8a4agbkmLmDLdsvACm9zx4Ak8nWy5lgpYNJGx61HrR0
	gjAc6gZ36109hpE8RLVUICdZzdSnHtfGGEDryghsYl1/3e2nC4QuuW026wl5wCTkRMF92Q2CAKz
	d4IY73BhH18aCQiPSsrArgpI9sUTSy5Q==
X-Received: by 2002:a05:6000:2c08:b0:439:fd13:5c48 with SMTP id ffacd0b85a97d-43b889f5701mr13324387f8f.31.1774544783287;
        Thu, 26 Mar 2026 10:06:23 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e352sm9715287f8f.3.2026.03.26.10.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:06:22 -0700 (PDT)
Message-ID: <6d7440bc-d463-4d99-af12-181684b87bfa@gmail.com>
Date: Thu, 26 Mar 2026 19:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 06/12] wifi: rtw89: usb: Enable RX aggregation for
 RTL8922AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Language: en-US
In-Reply-To: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33995-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03743338F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It uses the same settings as RTL8852CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index f058a8e9f818..07c2176ccf21 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -796,6 +796,7 @@ static void rtw89_usb_rx_agg_cfg(struct rtw89_dev *rtwdev)
 		rtw89_usb_rx_agg_cfg_v1(rtwdev);
 		break;
 	case RTL8852C:
+	case RTL8922A:
 		rtw89_usb_rx_agg_cfg_v2(rtwdev);
 		break;
 	default:
-- 
2.53.0


