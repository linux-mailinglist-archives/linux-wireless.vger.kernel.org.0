Return-Path: <linux-wireless+bounces-11630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0289572B7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 20:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1B028339F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3634188CC8;
	Mon, 19 Aug 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL8h4ipd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B119184535
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091000; cv=none; b=WOG2ql0MO5wBhmsUkFg7/H5S97xAn/7KuEeywxGYovWBXtIcD9BP6gxgMjQfCu9I46jETKrcL1I0WUqMijrfyqUvhMFoJrlTFdwr+kbuGGayCjrs1mn5AaSOeyMt34ksTmWA3K/DpOSndJgcg4F2y/3ac68gFunEhLJr+lMBoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091000; c=relaxed/simple;
	bh=63+2QdlkyCN9L4q2CWGrCg16BE2JGVrtWcOW4JVfiag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiJUGb2+fn2r/hzCqWkdeKdFoK/6l7tYOoN+F1VhBNayDwyXrTV1fwol7GgoUItJrQjqYavgr7KYzBgef7um/55g2TOdm6FBy+WagbOEZzR7ClCtzIdDPhUbpbc1dZjnaEg4RL2NFn9pAdWuZ7B/hxm5ijEVrII7Ghoc5lyMD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL8h4ipd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fdcd7a622so24961641cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724090998; x=1724695798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0LwJQr3msiysrr5pQWOHrBaffwI03B4P+ZJn5xGSP4=;
        b=hL8h4ipd7e8SxWJXGjg+2mRAxysVGIx9wowCrmaFw2PJYprvOzbl1VM/hoRkHScPMe
         EXr7r30nD6MLnMvaWEswynTbqJ1GwFF2UzPEhQ/iGzJ73HLpou1xcs3o4S1QNGE/yI1g
         WrA048zn9hbO0+QALT8l6JciEy9W4FzO39+E0g3q+N4wIfiSaaXFSL0qSsWN+F+JEORP
         HjF0n1ITmtQmC1WPaBmVbwOSdfQ3ac0TN0wmftvgTo0IdKtym7VNMPsiELc5tDXHq5ui
         AK+oJSzJYTzie4v/pY5TztBRlyrRA90o99/cvYKTV1hjKkjIht1HQsoS6RgGZ0udx5AL
         bgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724090998; x=1724695798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0LwJQr3msiysrr5pQWOHrBaffwI03B4P+ZJn5xGSP4=;
        b=rjg/R7ovr6sLMJ2nF1EgC37Go2hTxdF/PHTMU0UaJVDPxEwDZEnpRjpqe7bugIdOKU
         1BO3Lvi0gmcU3/tw7oEj4BgCkBRejB1bIZB852h4QlMYB+zm96uBl9MMMT8FRsbrBmWB
         B4TuwWms9fl6Fw8Og8tPnD3mpUabD0pujRLswI5UeyK3d97Q6EacQtVPAYK1uAh3gW1i
         8HrLafxSF6LE2wp3oQdC9tWzWKBAJplu1gtjQf3R4J8lBrSDzrt8CjsmzDPcV6jVgPRc
         ASQJvjsTVpoIJExAdGzRxzffYTAnxfmssfRBu8ZIQfW2oUcgkq0x1mU2OAohanVzia67
         IQNQ==
X-Gm-Message-State: AOJu0YzyYFUxD+TdVuUTvSwThOtSMFDoqy0JizvX1ns4f1z4M05YZccn
	LeVEkRLOAokoh3CyP+Gge6ebQ5tc6WJMzWViT4VO4MFHumQVLP2v
X-Google-Smtp-Source: AGHT+IH3+QlTCvvPI2bIAaqp1+Yqeb33oJ1jrQ7ZGCg2XGiyOZJlCc77gjXxJdooZTP+muRDaCc+cA==
X-Received: by 2002:a05:622a:5913:b0:453:17f1:eb8b with SMTP id d75a77b69052e-453743a96a9mr155808021cf.43.1724090997863;
        Mon, 19 Aug 2024 11:09:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-45369fd9e9bsm42344461cf.13.2024.08.19.11.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:09:56 -0700 (PDT)
Message-ID: <b04c01e5-3e60-4b0b-8984-9d6e0782f5af@gmail.com>
Date: Mon, 19 Aug 2024 11:09:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
To: Marek Vasut <marex@denx.de>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Chung-Hsien Hsu
 <stanley.hsu@cypress.com>, Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>,
 Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>,
 Kees Cook <kees@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>, Matthias Brugger
 <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev
References: <20240818201533.89669-1-marex@denx.de> <871q2ky3zm.fsf@kernel.org>
 <1916b572558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <c95f64f1-3ebb-41ca-a935-51c1efa1256a@denx.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <c95f64f1-3ebb-41ca-a935-51c1efa1256a@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 09:17, Marek Vasut wrote:
> On 8/19/24 5:52 PM, Arend Van Spriel wrote:
> 
> Hi,
> 
>>>> Add support to download TRX firmware for PCIe and SDIO.
>>>>
>>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>>> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current 
>>>> linux-next
>>>
>>> The commit message should answer to the question 'Why?'. What's TRX
>>> firmware and why do we need it?
>>
>> I looked over the patches, but did not sit down to comment on this.
> 
> Thanks, it is real nice that someone who is actually familiar with the 
> hardware jumped in. I only upported the patches from infineon downstream.
> 
>> The TRX firmware format allows multiple images and possibly 
>> compression. Not sure if Infineon is using all this functionality. 
>> This is probably needed for 55572 device support (patch 2/2). Turns 
>> out this device has a bootloader that the driver has to talk with and 
>> that is probably where this TRX support comes from. Not something I 
>> considered to happen for SDIO and PCIe devices. There is always a 
>> puzzle to solve ;-)
>>
>> Also noticed a random seed is provided to firmware. This already there 
>> for apple chips so it should be looked at whether that code can be 
>> shared. I will follow up.
> 
> I did notice just now there is some TRX support for USB broadcom devices ?
> 

TRX is a format that is also used for partitioning flash devices, so 
there is probably some room for making a common header:

./Documentation/devicetree/bindings/mtd/partitions/brcm,trx.txt/drivers/mtd/parsers/parser_trx.c
-- 
Florian


