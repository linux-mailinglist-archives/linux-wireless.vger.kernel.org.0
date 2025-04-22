Return-Path: <linux-wireless+bounces-21838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B862CA967DB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1A16408A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30127BF88;
	Tue, 22 Apr 2025 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HCEOPFyg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2E265619
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321975; cv=none; b=ltpaZtqBz2Yj4fawfV7EtpelWrd3zFAleMCaHlLVRGtFceLwcoa7QwSNGagl5N+W8crJ3nepbo+V5GpPjLQ6W44n99ML0o8UxpsopnhTPLcpaGsTSs6zkzo59UbIUJkgW2SDSzZgV2JrfRd9gDxCI0iLsA8IA2UkguIoRVz6olw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321975; c=relaxed/simple;
	bh=gE+ihbtz5g3vP0Vibg5Xj0k7tkkJTIZuoEK+y6CIP1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxTq9VN93DXQavPRWUY+k8NMvcmkp7VIni8vmsPStOeJUnarsyRmGO0YHUx9nz8v8GnKgCWx75ZokFVIhZ3sh9yR1OyRtjU1VoEv7D69BsBFUM7464eULsCO4/7XRUqIMW17ud5saSuQ8xulo45KjMoqLR6hQxRzMWCt61d6KiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HCEOPFyg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33e5013aso56279205ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745321972; x=1745926772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aEq6bOVOJtLkZttL9T4pxEaQVgSJPvJbn2Yk/YAOwz0=;
        b=HCEOPFygLaeD9/pCKZixHw0HZXxpRTBrQKaDPML2t7Qdv4hldnGIzhOHZf0CZl9Vhm
         ISyz/pvMx/5EBn4Hds/Ada8yjuGYLtDnfHdVI2RIF0F4VJFLjyhyMNtFrEFDNpmzNK6C
         j6HpdUoWfgdk0QQMAVt4VRG2msNjloKDjbWk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745321972; x=1745926772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEq6bOVOJtLkZttL9T4pxEaQVgSJPvJbn2Yk/YAOwz0=;
        b=CRX4EZpTN54LbedrqGc6y3yHVcb+D7GrKnLYRIp4UIdUFCK94fxAeNNVs7qdjWXisD
         WUaRF0xDopVFIzmypghXtt56+3oavlT3djsZS2s6CHFN2qk7PnUSmx/e3cfFlS98Q8rU
         AlO5V1fnG7lhQbV3FgNPrzSkAyqkiX42Q1YtoH9sQvLZoxfM5Hjo83MWYEaaGBP3aj/r
         Y61HgEOCv6knnOekVQocRvQMh/JwWLnu4tVSMAbJ8AwLFD0QxY0xAiGPEdVtb6pQwG6+
         i5toy9lDoL2aYzeZxxW7uqktSr8ssvJGD6YNn8iviQtK+hD5CFib/NukqweJGsXcTzBT
         N10w==
X-Gm-Message-State: AOJu0Ywz4T3wXtc7ssYzVT6elzPAXuvKg1CUI6603fRAVyRx0bWi70Jv
	8lR1jL5/I2dPnXG5IdyxLQvwsq0yb7zonKq3CPtviOA/9cYdDVKeCojZXddCTw==
X-Gm-Gg: ASbGncs62AeH72cODgQg0XNG/4jioEUU1kTbv19rozk9VjaI2igQWb84a1jpM+QhSUT
	rnkip4UxaJh4EK0F7B6x0ZFY0QxFv8oguoyTQ+oXAYVz4hSX5xV1EgSepktIBKT77/m1oU4yw1f
	xnUcjIAg59HQDNZPlJD7xQswUaRtME1lEKkBYqOuG5oloBSJscmtfOsyhZ6LOglyMTLwYbr2qk4
	NH5TWb9D60Mp93fu1LZKJWaBUdKK0ks9dX3+K18GfQLBO9q6hd92rKLMf3bAr3ORmPFOLq9abPx
	c2/EemgaH64b0+f6OXYJz2w3dy1d4Dlj+mvLQG47SOY/vrn13zW6rq1R2hsQyiS0C0pj
X-Google-Smtp-Source: AGHT+IFKojdUh0sNb4Ebb1JmWK12MQdXSOdAiqRFGDE22Idk5RsvtjW5M/GTepe3dep46IbCS2UQwg==
X-Received: by 2002:a17:903:22d0:b0:223:66bc:f1de with SMTP id d9443c01a7336-22c5359e919mr226215295ad.21.1745321972509;
        Tue, 22 Apr 2025 04:39:32 -0700 (PDT)
Received: from [10.176.68.112] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3391sm82639865ad.60.2025.04.22.04.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:39:32 -0700 (PDT)
Message-ID: <15f43f65-2f2f-4fc6-8210-60afdd9be004@broadcom.com>
Date: Tue, 22 Apr 2025 13:39:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] brcm80211: fmac: Add error log in brcmf_usb_dl_cmd()
To: Wentao Liang <vulab@iscas.ac.cn>, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20250422065938.2345-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250422065938.2345-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/2025 8:59 AM, Wentao Liang wrote:
> In brcmf_usb_dl_cmd(), the error logging is not enough to describe
> the error state. And some caller of the brcmf_usb_dl_cmd() does not
> handle its error. An error log in brcmf_usb_dl_cmd() is needed to
> prevent silent failure.
> 
> Add error handling in brcmf_usb_dl_cmd() to log the command id and
> error code in the brcmf_usb_dl_cmd() fails. In this way, every
> invocation of the function logs a message upon failure.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v5: Remove finalize label.
> v4: Fix spelling problem.
> v3: Change patch name and comment. Move error log into brcmf_usb_dl_cmd().
> v2: Remove redundant bailing out code.
> 
>   .../broadcom/brcm80211/brcmfmac/usb.c         | 23 +++++++++++++------
>   1 file changed, 16 insertions(+), 7 deletions(-)

