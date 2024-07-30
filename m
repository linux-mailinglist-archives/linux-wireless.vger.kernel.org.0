Return-Path: <linux-wireless+bounces-10684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54C9412A7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 14:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214F01C229CD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3618E77B;
	Tue, 30 Jul 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5tHK93+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646D442C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344165; cv=none; b=lOTsGgUmB/SmVqF4p8UrcH6NnBQYIfx+sFJoa1kOuGVXVE5VyyhH9sdkim2h3MEeBwigkMYGP9y5I/9zoOHU8BjqPX8gctFhXF12Rpz2eX6rFzMQi9cIbtApchmXSEGltFKzjiO7obRoCJXQn3DLFeR355+5FtdxMxJrzk690fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344165; c=relaxed/simple;
	bh=7nXWt09b0nexn4zGWUYjj/r8yRR7NsQPoiQBTgYjiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMyVQGviVLNkZdQqajqvEBRCygJVGWTEVs1jX2Fro0M8enWeu3ZQMPheYwK/+R1mTzI33Cto/rqQyJCUGiIO9TBknyvtRDvkCqxzsIKQiz/ZV6GLw4NSu+Ll/8iUuieJjEIiSJdFOAm1SO6bK9BesCe4RN0zyL1OdGYaNRpWHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5tHK93+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f035ae1083so60161021fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344161; x=1722948961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oq+yo1Kdix6Ioo1L4vXZKkGorFSkj97G3xcCP1Bnu9E=;
        b=b5tHK93+F3dVFpNlETZQIWnZaItDqPdAYB019pe1suqu3o9nEB4LMMe7SoAqSGARz0
         xCGBSLXGMa/L2v7VdO/QHYcgAPtNEipsJsOI3qFAsKRQaks58oPBD3nsXTq8v5Bkc33L
         lcp7aLRTyfp/pFUsTMETpOSJQm8lVdsaKLlGSAB5nTInF8IYusXR9VkV3+htXChfrBQ4
         2Zr0hxnsXPNiZhY9zr8B/5UPOpvF6ANAG+hsOHhJOQieeGuFejlrRLf23APO/vXEXJwz
         ZhFeRihIhLRSdwH3/SCM/h4LgA9KC1RvG6cn/+mI117BTmOj5IfeKunGZV0JCMK3Yncm
         DpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344161; x=1722948961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oq+yo1Kdix6Ioo1L4vXZKkGorFSkj97G3xcCP1Bnu9E=;
        b=j/Vp+iihdDPBIaljtzkiGGF5TOval+xFAtBDtCLVZgWWhMpJhaxsBknUOALgil/1uC
         YyixKTAWZPsnL1zVHEKrD6oEIowhTImCFR6AIYboMM/6tOMM6aSEJyVf5ctSOewApoED
         9KePBIjh025HvyB2L1bT6XKm3sHXHP6KcOZD31nzEfq/zgdIUYHtKnfW7/kXFIjBp46I
         rkYQPzuq1VQ6DFD/6SEbQ8lvqE403oeQQL5Q29UjHAiYbdCHGH9LlI3pbiDKWNOVBnBD
         libHtfweaLB3v3mGitvXsOSzRqSjitXgH3trBDNgsGkC4we3mw3NOAB48QH7WbvbGCAc
         ze9g==
X-Forwarded-Encrypted: i=1; AJvYcCUzVlKDQXA1fefLVoL9z8nab3iis12BH11WhbRjHKPxHIyXUlaVucDlLLatdvt1r2pFTxbVF3pPp27QYPpaDEBgxtGdUUICCXMXPdphVdQ=
X-Gm-Message-State: AOJu0YzKvPkJtMUNZESbZdzW9SEdaQWCTSlstqdY5uyez8eCJoBw1nEY
	hnc+8hnsGKyTkWRldS1zjHe8slJ7c4dotYGn+rqgdf1KF6/YMwZ9
X-Google-Smtp-Source: AGHT+IEJmJi0Z6ozaj8Da2kBWl4+LXKKsijQVUlF7XDA0z2CB3uFutLxKM74ARBNa4XzLVLsLjQs1A==
X-Received: by 2002:a2e:7d0b:0:b0:2ef:2016:2637 with SMTP id 38308e7fff4ca-2f12ea9bf15mr68760101fa.0.1722344160195;
        Tue, 30 Jul 2024 05:56:00 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590e73sm7241688a12.35.2024.07.30.05.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 05:55:59 -0700 (PDT)
Message-ID: <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
Date: Tue, 30 Jul 2024 15:55:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9356af89520243ccacc0be72b8b03252@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 09:33, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> In AP mode, the firmware stops transmitting beacons if it receives
>> H2C_CMD_RA_INFO for macid 0.
>>
>> Leave macid 0 unused in AP mode. Macid 1 is already reserved for
>> broadcast/multicast. Assign macid 2 to the first connected client.
> 
> Seemingly we missed to set mac_id in TX desc for a long time.
> 
> +#define RTW_TX_DESC_W1_MACID GENMASK(7, 0)
>  #define RTW_TX_DESC_W1_QSEL GENMASK(12, 8)
>  #define RTW_TX_DESC_W1_RATE_ID GENMASK(20, 16)
> 
> The mac_id should be from rtwvif->mac_id or si->mac_id according to
> operating mode and role.
> 
> And I suppose mac_id assignment for AP is mac_id 0 for broadcast/multicast, and
> other mac_id can be used by connected stations regularly. 
> 

What about the concurrent AP + station scenario? Will the
station vif use the next available macid, whatever that is?
Just wondering, I don't use concurrent mode.

Also, do you mean that you will do all this? It's not clear to me.

