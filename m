Return-Path: <linux-wireless+bounces-25988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2672B106D0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497D7AE6B93
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529521A42F;
	Thu, 24 Jul 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="enq1DUEb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4223E338
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349992; cv=none; b=DO6mDtPSPsVfz4Kx6kEA9C2IHsanDsojnatNhK30+DXAAifquokRv/Z6bIvGoPdGzRseJBIwMOFdVPHmPns9upzBEFgVF1m2Y+G0ktnjX2WB8oI3xnhqsBiKrAJskE4TcvzArRvyAIo0xebS8KisecIvSziOhVLqOYbP6AY6ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349992; c=relaxed/simple;
	bh=izc6ZtFtUUTc/gvqzt08ghE4XQn99bjTUrW3q0pOB28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/nACn2bAED5OxTF9Sg18O5EKrDh4HFIu8oYWuiZsBXWw7SMqNIoeC+9mGj3EF9rSp3pGSk/90dNBdggljxMFqNvi2yNMWATs9h+0dvqyc94nOMjCABVQTPWx/L4bgDEKuizk0rXwC3DppNgxzo0sIaShUS+jYusZ6h2uOIZk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=enq1DUEb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab5e2ae630so10748141cf.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753349990; x=1753954790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IIjGGXVf11weW5oQjKnMXKtINVjpGksDSkfazxd3id0=;
        b=enq1DUEboMHww7HmGeO/kt9XirRokQtPOcxj7b26wepJvf+/hLFdBnbBHMiP3nHR8P
         OSWO11Tc4ZoJlRw91qkxbgEv11n/07XFYK3gmpDrSbakKJJaVIT3LVN+iL0wxwEmyxeU
         kUmgT21sYyyh7hFtOl7HcYYEj9GfzGSntJLVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349990; x=1753954790;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIjGGXVf11weW5oQjKnMXKtINVjpGksDSkfazxd3id0=;
        b=YGPQmFBYGzg7EjP3RD6bg29ZRIDXkZaFFcngGEAUVPEYITQSySD1SN2yslZuiA8+DL
         8U+g8Y+KRo5ZpVdURH7ZMXovattq4o5Jh/VMzjh4COLiPuAKh1uGqmw/VV7BThxoJCet
         JJ/jbiIt9mY0oDatO29xjyu7z5DGEndB+bNLMnClyC4tvjsT06H+ygt5t6uDZuKlmADB
         3h/cGd31mDoLQUJvxYzdJu9gBVxsHMobd+vBGq3jhh4XCKxJxF3hJKrnus2+HRmphXZ8
         POAogrB9VcsmcGYxoVdVInHIacZN9Hg1GU/Hf+Bf/ZTNM6qLhkVyvn70+rzBmHiISRlu
         1Dog==
X-Gm-Message-State: AOJu0YxW//ToKacKdmG1GhJdASwhsliBBbTHcgr7dbR7SaYTRTPud0O1
	vDaeKMIHhocqvjw3BuJBgJKJ2fxlNU6KqP246BlOTiXlRrGRQmFcanK9NgB6gWBR0A==
X-Gm-Gg: ASbGncv15iHLRjXsIEqV3LxivXhxaahyhkp3LlC88UN/VZ0lOIW/hsSODO9AFkY4ASo
	VAh3g/aaPBSZeAk6tRzqTHDNi0AylYsqZeoVBhWuB1wDOLSYq3ZjO9PLSI+JO9oxRuJX0uyaZi9
	VMrWj2qBbjfxvr8ymF5CPSYJ0Q1icczZBjLswUoE3KD3QapAA7uf1j13HIcvRXSROh6/NcAau9b
	l6lJbY0BDQGUFu5SPvHGWWq3VLnP5470CtZI6jJlSRUruw6afikGSv2OFK8pmII6heBAkgqhcBO
	O/XHIGf6V+wpGTeOvBkKFopxwKhPpqaIgIHPrkU6b0yxVkXyCX5TsD9iIlGnZzcPG2AIZ/grtRJ
	KlP1wXfFYCbqryUPNxR3lQSG9GtevCAKtisT8J+oqS7qvl9Qg+xz30Jad8up5TA==
X-Google-Smtp-Source: AGHT+IGNfXV1njPjLllSN7Yv5xduPy+7quFPky0yA0lxKLqQntvSccAoh4yqAbOZbCF3QOHbmmvClA==
X-Received: by 2002:a05:622a:181b:b0:4a9:957e:abfa with SMTP id d75a77b69052e-4ae6de7331bmr86722251cf.20.1753349989786;
        Thu, 24 Jul 2025 02:39:49 -0700 (PDT)
Received: from [10.176.3.57] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae7e5189d6sm9142561cf.35.2025.07.24.02.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:39:48 -0700 (PDT)
Message-ID: <084b0c7e-1ef4-4522-b671-d9dab84537dd@broadcom.com>
Date: Thu, 24 Jul 2025 11:39:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2] wifi: brcmfmac: remove 43752 SDIO
 incorrectly labelled as Cypress chip
To: Johannes Berg <johannes@sipsolutions.net>,
 Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 wlan-kernel-dev-list@infineon.com
References: <20250724084613.6336-1-gokulkumar.sivakumar@infineon.com>
 <432d50a2995dee6c421aad6bd21acceec191990e.camel@sipsolutions.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <432d50a2995dee6c421aad6bd21acceec191990e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2025 11:15 AM, Johannes Berg wrote:
> On Thu, 2025-07-24 at 14:16 +0530, Gokul Sivakumar wrote:
>> Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
>> has not officially released any firmware binary for it. It is incorrect to
>> maintain this WLAN chip with firmware vendor ID as "CYW". So relabel the
>> chip as "WCC" as suggested by the maintainer.
>>
>> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
>> Fixes: f74f1ec22dc2 ("wifi: brcmfmac: add support for Cypress firmware api")
>> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
>> ---
>>
>> v2:
>>   * Relabelled the 43752-SDIO chip from CYW to WCC instead of dropping the
>>     support for this chip as suggested by Arend.
>>
> 
> Maybe update the subject now?

That would be nice. Please not that the vendor ID is more about the 
firmware API that should be used for the device and not so much about 
maintainers.

Regards,
Arend

