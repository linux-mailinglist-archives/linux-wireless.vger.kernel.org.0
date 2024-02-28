Return-Path: <linux-wireless+bounces-4136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985D86A9CC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD73B24F25
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132512C857;
	Wed, 28 Feb 2024 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+XIOsi0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7A2C6BA
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108652; cv=none; b=BqipXdbyLBka0QUtEuuTkdpDPJxWs0D7r9gE3a3mWfPx6lnhwZOpPDkvxlsAmlFNrBR1rT5YGWsNkMC1u0LMZx8lxZFIac8Zgr2ndJ3hCs+BqH++Jzz8lM5QuGJjORoe4WaTlyPMbZftC0GCvboavcsU+rVHYTNWfV6t4mBsnHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108652; c=relaxed/simple;
	bh=/34dynQfECm5B+3LFDIPAZBmeHM5kcxjFKpAK3qqMls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HwB1UYkkbzLgUP8YH3vqkazZjgvV3fLnd1c5264yf27sDSlDzlgwBwKQ3676XLtvWvx6jvanlKKlDgWQ+XlKmvjYyxS4lmPQlIrjbkyf7lB3I/TcfenhIwxdPkYRzMpsaR8D6o0ew3Sk9eUeOb2JRq2qz6hi8QGjwQTaV9GLKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+XIOsi0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709108648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9Ndb3isEOpYMN4yO8UqNjKboPqCzY08CWqnXU9iwDw=;
	b=U+XIOsi0ri602B7oJiJv6ViATJ8zob3zQaTdXvU383dqrenTpkASboXlIFV+vkXqZVPsMs
	OPMw1puuAP3304+CTDmsbTAhk5P0dkLtNQxvCwmvmdQmGxoMLvjNIgXd4CWMsnZ+LYjTz9
	9hvvhYlov1REdhWyndiVqUEXst9JROI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-GpyiYTvHPNic5LirLJtngw-1; Wed, 28 Feb 2024 03:24:06 -0500
X-MC-Unique: GpyiYTvHPNic5LirLJtngw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d25a02f48fso42844551fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 00:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709108645; x=1709713445;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9Ndb3isEOpYMN4yO8UqNjKboPqCzY08CWqnXU9iwDw=;
        b=iz0NXARS0P/ALDoqq2E0qFQXCY9wpXly3nxMHTNZzdiXl2hMLktDuLKnYZTl/Uk0Vk
         R7PlqhS0fPYahcXGrCMBp6+4TUdzF0mxJphx8gH1meKJ4xc++RlOCHEitzyi3OZQ/xd+
         wtwn+AECmeO8lOvgCdGpS0jqOpJyOs/oeBlUJwsy6sJA+kaUCBNIMArVD2xcmXJUHLEq
         VCk1A+c/lX3hZu8t5HiVeng91Dk9JSokLWLm9sRTNuA/j/mBarMXux/PwPbElLjReZIA
         XRspUAHBym1zpYx+sS0Jew+ljG6FJ399pm5C1ZuGHAksOF729+lkNcwuCq8mq7GG221n
         Pb8g==
X-Forwarded-Encrypted: i=1; AJvYcCWEfasV3sDyF2JGkyAvM22JMNmSA4dsZlrmOF2K8mDF2Qa1BWso2YzunEbKfMY4JhZZLPK/FAWKg56TBNY1EZYJ/IQH+QxV978xT/zC4Sg=
X-Gm-Message-State: AOJu0YyFTfk7JIl7eatS6e91JlEE+NU9BwSpJI4+09JrPzoKyrW65YgD
	sILC2/UWIRea4GWi4DpQEkK3F1XO0ZV0GTNKY2Ot2J69QY/5s0oyFS8ih2oe0WZtlna1MZknoad
	zpRPJCJva03VS+1gfGTsNcTDbZHnAFideOBCdnT06ynVspoBkGvnkaz3gbKHl4daN
X-Received: by 2002:a05:651c:503:b0:2d2:7a4e:f5ec with SMTP id o3-20020a05651c050300b002d27a4ef5ecmr9461736ljp.7.1709108645194;
        Wed, 28 Feb 2024 00:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU9RFfTDN6DCawl4zOzM2ajPJXakuMJ1PeT8SScHF5O6ubWlcg+N2qiwzBokAlcvgl/u+VpQ==
X-Received: by 2002:a05:651c:503:b0:2d2:7a4e:f5ec with SMTP id o3-20020a05651c050300b002d27a4ef5ecmr9461721ljp.7.1709108644858;
        Wed, 28 Feb 2024 00:24:04 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b00412a31d2e2asm1308154wmc.32.2024.02.28.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:24:04 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Breno Leitao
 <leitao@debian.org>, Li Zetao <lizetao1@huawei.com>,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wlcore: sdio: warn only once for
 wl12xx_sdio_raw_{read,write}() failures
In-Reply-To: <8734tdaal1.fsf@kernel.org>
References: <20240227002059.379267-1-javierm@redhat.com>
 <8734tdaal1.fsf@kernel.org>
Date: Wed, 28 Feb 2024 09:24:03 +0100
Message-ID: <877cipngik.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

Hello Kalle,

Thanks for your feedback.

> Javier Martinez Canillas <javierm@redhat.com> writes:
>
>> Report these failures only once, instead of keep logging the warnings for
>> the same condition every time that a SDIO read or write is attempted. This
>> behaviour is spammy and unnecessarily pollutes the kernel log buffer.
>
> Removing error messages is not usually a good idea, it would be much

This patch is not removing error messages though, just limiting to print
only since IMO there is no need to constantly keep printing the same error
message over and over.

> better to fix the root cause.
>

Agreed and I'm trying to figure out the cause. But to do that, I need a
usable serial console and it's barely usable with all the warns and stack
traces printed while I'm trying to type commands.

>> For example, on an AM625 BeaglePlay board where accessing a SDIO WiFi chip
>> fails with an -110 error:
>>
>>   $ dmesg | grep "sdio write\|read failed (-110)" | wc -l
>>   39
>
> -110 is -ETIMEDOUT. Why is it timing out?
>

If I knew it then I wouldn't have to type this patch :) In theory it
should work according to Nishanth (Cc'ed) since I've both the firmware
and the required patches for the bootloader to set some clocks early.

But it's not working for me... I don't know what's missing for me.

>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

>> -	if (WARN_ON(ret))
>> -		dev_err(child->parent, "sdio read failed (%d)\n", ret);
>> +	if (WARN_ON_ONCE(ret))
>> +		dev_err_once(child->parent, "sdio read failed (%d)\n", ret);
>
> WARN_ON() feels excessive here, maybe remove that entirely? But

Agreed and I'm on board to drop it.

> dev_err_ratelimited() feels more approriate than printing the error just
> once.
>

Works for me. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


