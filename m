Return-Path: <linux-wireless+bounces-27653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D3BA1054
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 20:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9FE7B3F3B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E973164AA;
	Thu, 25 Sep 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MpjBrYgf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0D315D33
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824954; cv=none; b=gwNZe7TyEAw0NzP0VcOgDRCUvEdv2IeR234K3nHsJfPNhYHG1++jZRsn+c17TJiYKlquDDp8lP//UeQjZQc8qmrLRh0afF62MYKplyiDXdFj6YgaKgXWhGKce+1Q87DbhhGiI5GD2ztCwxHTgEMYa+QimE/Bi3j/JPW7fKO+7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824954; c=relaxed/simple;
	bh=pBO/UX4J7C0KI04B26XSe7hPoe9OX9Q+92VaUGVxbJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4AbRLi+ghsdETURyzQXpUPM7UXiOrRxxS2eXDdo312yECOJtvVrTdNn5fc509EQ8PspKWjLt3BZoRfo//uycKjSUwSqybJ1obLxFkV1XGq4YjnISv6KENowPLJlmIWxQOYTpFgA0Bo00HM//HsVOREQf95GMQ1hNCCuUC2jq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MpjBrYgf; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-71d5fe46572so16540797b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 11:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824952; x=1759429752;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9mUkWMYiaFyyO8vrDokgAXf/iLB3jaofepgCpBek4g=;
        b=fqkLxPQpE+zUCIRf9F8QtMwUCdhoJOUkVp9S9TgGinHNkZEwoWAn4DztHu3trw5hkb
         0g9JMcdTgzeuUP233SlESayC18jDeFbOXJc0ofvB7DdOo04a2mz9iEXSkRcY55Fp+M7R
         rOVWrEv5C9I+dikyalpT2+ZnJlSJ8r+vv8EBDD81f1y/XbC8sx6ZsnrtEls/FQZmbY+L
         z+UOOwBKdFt1mLQUvgewEURLpXzp7UYpxH9q9QWLYNMLscpFoVxLv9EikRO3wwcukF7e
         EP5Go240FIYb337bG5PZE7cT+4yzO3iruQB3qZF/CfZURppKE5ATiS83MSVe9AkEFdwa
         Gj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkiCkwaH7LpDJJF1F4B0NVMymFTIOrlW13JeE33a76G5bneh5lDsKERwVm39SRm3F5lX9xxp295oP2UKM04g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8DMYs/P5Dm3UbqZXCbfN1Z6yujUdk7iiSWLBzRna8BxIfJT7
	73+i4CUutfdHXH9Sh0sIWBwo80rl9R8HiuZN2QKB19cFZlwV4ZL4JCdSz8nzBkR15JtbM1o+pN7
	t66zn8c2lWwsxgCHUUTjG1QzDCjYOpeOjuSKptR+bDLc3Pw3uYznE5y2G/0LiwVt15PlEt3NnUw
	Zcp3qZYx99qrjWQ6f8YPHoxPJJEwyxolIdqCrpjm6tSMLCQY2R/KlrgsT+Wfjk02oTU1YLmALXz
	J+ASxNq9h66cGwtiChtIwkWw6mg
X-Gm-Gg: ASbGncumwu+VHHFfO1BB3Ulm+5QGeOgtl2RlRKPi+doX5V9WcZAO1G4cRJ8hgn2IjLK
	P7hetUTx0BrVYZtr4/6ktEf61f7FaYeKRqUSE7oQcPZn2KeZTG6xlqpiacJnMIXaUKSbcbDwwGH
	3Qy+6NtnB/yXG4RHxI87OSbBrbTuKOCRDnPQQ3k3dyRDriP5Zxk4/EACCQvyfb7aVWoKps+ChwH
	hcbmrZDMWLgoKGk4BNQ741AGDHBDgiXPuPHFtJVCOu0dFcngN6/zipk7OiDCRqJ7L8c/ynyOGeX
	zp7I+EvioSbdVrqE1qS64Uls4xQmYBpPbbSdShLBZNtwyFOPr8osdaw5qGkOJF7B8mgDivCS4B6
	3syye1fm9Xpld+yiorIigs/CaZFnyxFhCbXre3cmgZRGF8TDEuBfefgqJ7xJmI7bLVyavhz9Mvm
	AEDlmyPw==
X-Google-Smtp-Source: AGHT+IG/Zrh9mdSW6fMI8Ij8hxLXxxyyC4ccYtNe4P/qTE6R52cwzYA45k/WA1NMkhkVDdCmH1bzocrcYoSH
X-Received: by 2002:a05:690c:ec7:b0:729:5fe2:3dad with SMTP id 00721157ae682-76551448a01mr33671157b3.1.1758824952228;
        Thu, 25 Sep 2025 11:29:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-765cf0f6169sm1154097b3.12.2025.09.25.11.29.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2025 11:29:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b2d604db3easo106238866b.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758824950; x=1759429750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P9mUkWMYiaFyyO8vrDokgAXf/iLB3jaofepgCpBek4g=;
        b=MpjBrYgfW29vhURPfbQy+AI/x3wcC9qgcG0nS1Qvn7gVXt05/i8mZH/lAXCCVsi7Gh
         zX6wHobHk3Uniq1GyU58jZxBmimGs/4RNoR2a0bslA2JyRAuSOOd06BME6N+CQ32MOSa
         QwJUr3bB18z4qQ9UsP1pyDoQWNvLHz5ZtFMv0=
X-Forwarded-Encrypted: i=1; AJvYcCXgxbY6SPY1NQZXWFtc6Sfx7aEWSorRmJ4QV9RixKEARu7TWcquKbfLpAPc92NlAeGHG3Uvm8IAclbhTkW4nw==@vger.kernel.org
X-Received: by 2002:a17:907:908c:b0:b36:f77e:15d0 with SMTP id a640c23a62f3a-b36f77e2046mr120544166b.37.1758824950259;
        Thu, 25 Sep 2025 11:29:10 -0700 (PDT)
X-Received: by 2002:a17:907:908c:b0:b36:f77e:15d0 with SMTP id a640c23a62f3a-b36f77e2046mr120543066b.37.1758824949890;
        Thu, 25 Sep 2025 11:29:09 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d155asm220768766b.6.2025.09.25.11.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 11:29:09 -0700 (PDT)
Message-ID: <1122cfba-0735-4392-accb-ed42c5b3bf6a@broadcom.com>
Date: Thu, 25 Sep 2025 20:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hostapd Kernel Crashes with IOS
To: Chris Spargo <chris@streetlogic.pro>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>
Cc: Jonah Finkelstein <jonah@streetlogic.pro>,
 Parker Borneman <parker@streetlogic.pro>
References: <MW2PR02MB3674333A04868446C75C39EDB51CA@MW2PR02MB3674.namprd02.prod.outlook.com>
 <1997f6d2b48.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <MW2PR02MB36742154B795D5FBCB77C394B51FA@MW2PR02MB3674.namprd02.prod.outlook.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <MW2PR02MB36742154B795D5FBCB77C394B51FA@MW2PR02MB3674.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/25/2025 3:36 PM, Chris Spargo wrote:
> It appears that user was also testing with the Pixel7 (mentioned in the 
> ticket).
> 
> Our experience has been both the little circled information icon on 
> iphone triggers this, as well as simply joining the network then leaving 
> it.  It’s been a bit of a diagnostic frenzy here yesterday, so I need to 
> slow down and understand if those are both the same failure, or 
> different overruns that cause fundamentally the same crash.
> 
> I will pull together cleaner examples of both crashes.  Should I attach 
> them to the github ticket or forward directly here?

Either way works for me although I have a slight preference for using 
the mailing lists.

Regards,
Arend

