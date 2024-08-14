Return-Path: <linux-wireless+bounces-11436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70319951EF4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 17:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D97928951E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31CE1AE86B;
	Wed, 14 Aug 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf+PEtvy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AB1B29CF
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650386; cv=none; b=F5QcShTWTMhDI6rITnoazt/OWwf74m00d6QrrG/9wdIDRwgH3p3K5PcYOzPg+1yCzfOc8qPfrhmbC9tLwme0xxwPFxHkolxsrLo+KXtmBsqueGu1SyZ9hbmq2fizEiQFEb1BE5MsStJCPN2moQVY0Yq1HWmk0tnhyOIIECLiAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650386; c=relaxed/simple;
	bh=X0QsgfT5bDi0b35xHpFaz9QVGffFAI+Ynd/EuOux6UU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ej0b6YP3r9KPi3DhWWwR0Ym8a7qyPnbqMnxWoQrJur8d6gAeEvkGv1DO0bP0JTQDPrC356+1hNQfDsxOVsH9WFaZdxDEChXfX/GvwygoAhtq/dNfhrdhYndJdhEcxIQvPYLyd45B9Z5NWLufFWgYPJZUPOx0MNnAWAWKffIqngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf+PEtvy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso630471fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650383; x=1724255183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bRPEnt+UgePlZ3KhAkXimBTF2+g5TXY/scfZYgz7QTs=;
        b=Qf+PEtvyqPqbpTXCVc+EhPxTR5EwSnqG8Ar3+JF00AjL1+HY5FrIsSDGevt+uGNeF+
         px2M8uThuEjl6dFIo4VvGRGEOSwCcexFm3GJ+Fs2rbPzhDdYk3LGYsTHzPLvNFfjdGl7
         WRdysCn5NrFk5wVv2YUCbighvgx459iCOWv3/G5iZFfDyI8bW6sIkTnZGmPP/I/ky3AD
         WwrSAX0gemNBoqiF3DCKpNR/H53ge3QUWjVSGeiBzj8GjRN79HH3vXixT2kuvvqrpNCg
         WIkWnHDSugeqhVRSw8cqAA4Ya5k2gBhCuWcnepqjFg+18Q2C9oO2wvHicT/PaGa3mLvD
         mmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650383; x=1724255183;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRPEnt+UgePlZ3KhAkXimBTF2+g5TXY/scfZYgz7QTs=;
        b=vzxk/+bIcYRE+bC+lcVuwTVcQCyxUOCvyW9fqJwP8wrJx3OWL+H3s2WHgVNs2hFSHw
         6Gq999Rgn1naligRAjhdEKCjOPi4WAODTO9Aji9OcduKDihUcOX/HmswU+RrEL5/NLPi
         HqTV+rBGs164pgOb/6jL7sSPFikJHU5AFcGJZfdM0gOgblKLNRp3602leW5A6zQagKEx
         fjuSW7zMqpBWErHAUFhPdEoYettXrDWWBfn5D4JCgqiu0U4ppb9Y8aPlYxjlFMIynWrk
         e/VN1JSKYQnHx2BT/6ClHIN09ESZF9YhN/7Z5ckTJbfkd7H7bwKuWtGpWk88p0+tqDct
         /sWQ==
X-Gm-Message-State: AOJu0YwV4ATMzAgcY7bhp2XoB6jphX0fT2RgbcP08Lkr8Zu/TwIrjlDu
	GXWFo3FEeOZFyvus/xafPZzUnOncTpVGylRif0neAGuBEL7r+FhLzJV1EA==
X-Google-Smtp-Source: AGHT+IHgPS8BeIAAs4QPC7yWpVRDMHPBO0tYIu3AF0VCs4w7+PPohNvYhErNnpmHZ4JWoJ6d20Q5Bg==
X-Received: by 2002:a05:651c:b10:b0:2ef:2e3f:35d9 with SMTP id 38308e7fff4ca-2f3aa2fbd57mr33187681fa.33.1723650382501;
        Wed, 14 Aug 2024 08:46:22 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f4b801sm186584666b.1.2024.08.14.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:46:21 -0700 (PDT)
Message-ID: <64c8a9c6-9da7-4e25-9245-490c9e7e21d2@gmail.com>
Date: Wed, 14 Aug 2024 08:46:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath10k: fix invalid VHT parameters
From: James Prestwood <prestwoj@gmail.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
 <603104a7-a1ea-43c2-b0d5-fd4e46a27fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <603104a7-a1ea-43c2-b0d5-fd4e46a27fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 7/15/24 5:38 AM, James Prestwood wrote:
> Hi Baochen,
>
> I've compiled both changes and so far those messages are gone.
>
> Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2

I just noticed another one actually:

invalid vht params rate 585 100kbps nss 1 mcs 4

Thanks,

James

>
> On 7/10/24 7:03 PM, Baochen Qiang wrote:
>> supported_vht_mcs_rate_nss1 and supported_vht_mcs_rate_nss2 in host 
>> do not
>> align with firmware's definitions, resulting in some warnings. Fix them.
>>
>> Baochen Qiang (2):
>>    wifi: ath10k: fix invalid VHT parameters in
>>      supported_vht_mcs_rate_nss1
>>    wifi: ath10k: fix invalid VHT parameters in
>>      supported_vht_mcs_rate_nss2
>>
>>   drivers/net/wireless/ath/ath10k/mac.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>
>> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45

