Return-Path: <linux-wireless+bounces-1445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E6822BCF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 12:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADC6281459
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DEB18EA2;
	Wed,  3 Jan 2024 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzEyvilD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D518EA1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704280093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QsK2zTzsBP8mr0W5TxJLUBCVnnwGlPVfyttD5Ww9+7c=;
	b=XzEyvilDuWFByuaydNaNuYgx/hyTFeveUibNWmU9hXQKAUJ9vjEFzChCy4UQAWxj99z+0c
	La58A9aBu90FuTn4MzpqY5XDRTbvXn4UrGHSbk6anf5i+DVuu1bAAcew7kzgPTJGuNIdVG
	rI4uB0BgpF0eQlns1qTDrK14V1ziBUA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-Wq4m8HhkPdyhRwdk9Hm83A-1; Wed, 03 Jan 2024 06:08:12 -0500
X-MC-Unique: Wq4m8HhkPdyhRwdk9Hm83A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a27619b3a46so208898866b.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jan 2024 03:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704280091; x=1704884891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsK2zTzsBP8mr0W5TxJLUBCVnnwGlPVfyttD5Ww9+7c=;
        b=DgmOaqPnqPrgdhrzuU4hHGBOmwNj/pW9Y4BXwbYW1XF04CsURkSPYN05i4Gzdf2Ex5
         qijiI6C+kdOQQpUsJys4ZtVpFDbSrnmV+4bJN9TUDTvoFgtBuQF57rQuqGZDoyQR1d2q
         Y71WH19Mm+dQqx6fPhQ1hNuE2iM9qQ9ReE+xpRGE7nH9aQUGA8qjrCQQgfVtdG3NcqP6
         i+kdRtX53al9ZOcDJIO5ymweS70ORAfmGvS/KTRpgYwvarl3kRiK07IjvaUEuPdkZ7dz
         ZlAAnDwORXlyMwEU2McdoIyHIrN3+OkLjVMaYmfUZ+nVgmmcdco+KcVB5SANqDUdgrEb
         pxzg==
X-Gm-Message-State: AOJu0YxyWdf7d655XQVPSw9qC7dIMOySaOH1kN3O951qe8vgFEBknHO3
	Jjv3I1nR9kIkiHT92uTJkDjKMzfcOcz2GzgE1Omykumhf1fv8tKAK6K5LOWlRPMhI/jpHYMpext
	Gajv2C+JpnmojcW35/yKswpQhVNzLSCVtQY5YCBQW1Cg=
X-Received: by 2002:a17:906:25c3:b0:a19:a1ba:da45 with SMTP id n3-20020a17090625c300b00a19a1bada45mr9918923ejb.108.1704280090891;
        Wed, 03 Jan 2024 03:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExggJ5bLSpH1ad1KuTzdmZwdD6JpkDqu4njalckDXsIWCHCiNdA5AIJa/KpQ8SU1itdsikIA==
X-Received: by 2002:a17:906:25c3:b0:a19:a1ba:da45 with SMTP id n3-20020a17090625c300b00a19a1bada45mr9918918ejb.108.1704280090577;
        Wed, 03 Jan 2024 03:08:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fv14-20020a170907508e00b00a269f8e8869sm12618335ejc.128.2024.01.03.03.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 03:08:09 -0800 (PST)
Message-ID: <0c125614-6258-4743-9e24-a0bd59fe414d@redhat.com>
Date: Wed, 3 Jan 2024 12:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: License of old broadcom BT firmwares and WiFi calibration files
Content-Language: en-US, nl
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-wireless@vger.kernel.org
References: <CAPVz0n2Ky350xhOv6WvE0YhFJ9QBe59LnWvKiafs2tjFnptP+g@mail.gmail.com>
 <22115037-3a81-4a52-8e64-bc85c2be4212@broadcom.com>
 <CAPVz0n2Dah1b45c0yUjMZNph5AVJjneLsc2LOQ-dkXNRTv6y+Q@mail.gmail.com>
 <18cce9a7818.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <18cce9a7818.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/3/24 10:14, Arend Van Spriel wrote:
> + linux-wireless
> + Hans de Goede
> 
> 
> On December 16, 2023 9:14:48 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> 
>> сб, 16 груд. 2023 р. о 21:57 Arend van Spriel
>> <arend.vanspriel@broadcom.com> пише:
>>>
>>> On 12/16/2023 6:45 PM, Svyatoslav Ryhel wrote:
>>>> Greetings!
>>>>
>>>> I am trying to submit bluetooth firmwares (BCM4329B1.*,*.hcd and
>>>> BCM4330B1.*,*.hcd) and wifi calibration files
>>>> (brcmfmac4329-sdio.*,*.txt and brcmfmac4329-sdio.*,*.txt) from a few
>>>> Tegra 2 and Tegra 3 based devices into linux-fimware.
>>>>
>>>> I have faced ambiguous license issue since those files were part of
>>>> Android Images of different vendors. Those vendors did not provide a
>>>> license nor for android images, not for these files.
>>>>
>>>> Maybe you can clarify licensing of these files and you can suggest a
>>>> way they could be accepted into linux-firmware?
>>>
>>> Basically, the firmware files in linux-firmware fall under the license
>>> conditions that are in the repository. This means the firmware you want
>>> to submit would get a different license. The main reason is that the
>>> license in linux-firmware allows redistributing the firmware files which
>>> is an important aspect for linux distro maintainers.
>>>
>>> So the device vendors would have to give their blessing. For these old
>>> chipsets they probably got it from Broadcom. I never had much contact
>>> with BT side so not sure who to contact about this.
>>
>> So even though those files are built from Broadcom sources they still
>> fall under device vendor licensing? Or am I misunderstanding
>> something? I have to contact the vendor of each device for a licence
>> regarding those files?
> 
> If you only have the binary firmware files it is  hard to say. Can you refer to a public repository where these can be found?
> 
>>
>>> Regarding the calibration files it is a bit awkward. There is a
>>> precedent as these have been published by community under GPL license.
>>> Broadcom never released those as they are board specific and the device
>>> vendor should provide them. So maybe you can submit those without any issue.
>>
>> So I may modify them with a GPL license header and pretend this is how it was?
>> Looks like an affair but alright.
> 
> Well. Most if not all have been submitted by Hans de Goede so maybe he can advice how to go about with this.

The practice of submitting these upstream was actually started by Linaro.

I believe the thinking behind this is that the calibration + gpio info
in these files are purely functional and thus this is not copyrightable.
Note I'm not a lawyer and this is not legal advice.

The nvram files as submitted to linux-firmware have all comments stripped
and have the name=val pairs sorted alphabetically by name.

Regards,

Hans




