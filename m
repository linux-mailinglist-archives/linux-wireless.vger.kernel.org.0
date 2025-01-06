Return-Path: <linux-wireless+bounces-17110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9491DA029B3
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 16:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F24C162065
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9753515B0E2;
	Mon,  6 Jan 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8FePDMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F238635E
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177172; cv=none; b=cY2ibEbOXNyKrYIDyLfBM6trC7QCfbYhv2q4eZ8m5OAIHAf4iReCTge6mCLxlhxMzdm7jiwE1/VyskuKHkqS7vUj7vJcJRvycD6BtMvwiZjhFIepS3NOTqvbEhnFzny4tQIMtovQm+eJVdmiptQxyezxRlTrvkkuzjA3z9EybPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177172; c=relaxed/simple;
	bh=KCkkRlVbjVi4Vx9XDK5pTirJMVCASqOtoXMm3a6MOIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i55HO6CJRftu1vibtVnuGzyHBp6z9yDUmHJHH9+YHc3puuXx4/w0osn9DKXe3SygV4eKJBQa1ImQz1grztyrXekO4YTz1KoUxGTFiOAfaJG0/cx5e3SwA1NKVcuq1czhhz029QWfgzCvTOBI3jHxvupsixmCSJG6hEs4loWwgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8FePDMs; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eba583fbe8so4937314b6e.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177170; x=1736781970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vF9TfLGeGkzRHyrFY2OJFn48HlFLx2qhDAYMa9X6qtE=;
        b=l8FePDMsLHRgRWTufi96JvTZyy4Xpsnhsz553A9dny+2SIwv5r/O0RYiedglnI9pVt
         pgZF+gB5Wrjq+CkGnJEqAoyxKOYW1K+Aomch0IxYQl3u9/mIAVva918W0kCCUjYgoUN5
         im6pcQHtxNc4NDaZsWS3oVASrua/MucGBJJX7+o2FcYFeC21TtgDo1vM1oDQ/nQw/qi+
         cEOKRSJWy8UVwdpZqx7D8yxyVyUX0PHG8ysWpcYOOWP3FrGQ8JW2iGIBwxhfqidwvmN5
         H5sNP2tDSzLY+d7TSNhuuT+WashZtNAlhk/zi8evtyk+FlFclBmuQ06WTfGp0Us3n/oe
         CdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177170; x=1736781970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF9TfLGeGkzRHyrFY2OJFn48HlFLx2qhDAYMa9X6qtE=;
        b=duMvRcjXkebRWexKisJH16eOTmon3sCa4mFqh1QbKAXP3Xwo/CcErvWj1hmFpa0Ed8
         hv4xff9tZScEiD6GxQH8iAtO29nBLnqe2Qg3xjtN2ICV9umGbdevrXQrbCwZp5KM0O76
         wHn58uCyhdgDiNY6KbxorrD2FQ39Dc3WU6Pfy6pChugvTT7RgGKjQHUWfJfRSW9GpxOr
         nUx59rMeiFU/trean2+LN9iNCZmPpKGjMYyD94qn/jlQZkuYEbhaKK/kBw2rd1n9roWd
         M2Rk+bjNfsRLS5hkpTz/LD+Da70v1Ohc+GIYpj0uvyZ97Xm0Y6/JHzPR9rQd36+66sN1
         432Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEbAyvepvYFHA/5if7Af/ZcS+3tpbM8oYF3B77UFZgS7RknwtpSETHbSRlvOLmpElIZUU17nPjtswxlacs9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjkLUP2P0p+xG4EPAWXMlcRukAQYdngkq6hfFdbYXXYhc2loI
	srjDDnRKM/lES0fEWpM4WbsCYQP0V+thl0HxSJCD5fsojkXiVL9oQxjiNA==
X-Gm-Gg: ASbGncsp5Hn4JJzSl+KFV8uRStZLRcX7RSnRZRRFbpvD5mYd7wEnC7p0yaPpiUqk5gb
	OZl7Q8vm+5FdXDRmJ9H7JCBkiNTL1/Kh/8ZCnWGs5is+1i2xqMNdjupgAiEVuhnj+Sn/PzzQ+Fz
	HJZ1J87/N1kSUrxrr7a6YfeXy3kuYvwkofzN7qgCT0kXY56PYSS8yXGOgxqVYuf6UlWs7Y9+vOq
	HP/jifV0rICE9ZEAo5sXz/BM5B3AMka/ejFq4PmFFYlH6nFP4ZPEhb+ym9Npj1ZalyYnud6YdqU
	kbXXLj4cM9cocRqJDMC+2g==
X-Google-Smtp-Source: AGHT+IEDsf+Mbmc864QWHbpcygNhlrEJQXEcL036nHAtw3bukK6uUa5WVwWpRd61Ht2ZgWmFa/t3Rg==
X-Received: by 2002:a05:6808:18a0:b0:3e6:1ea5:6b30 with SMTP id 5614622812f47-3ed88fa6f1emr31032951b6e.24.1736177170113;
        Mon, 06 Jan 2025 07:26:10 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3ece25014a7sm9980594b6e.28.2025.01.06.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:26:09 -0800 (PST)
Message-ID: <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
Date: Mon, 6 Jan 2025 09:26:08 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: KeithG <ys3al35l@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: James Prestwood <prestwoj@gmail.com>, connman@lists.linux.dev,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com>
 <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com>
 <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 1/5/25 6:41 PM, KeithG wrote:
> I am looking at the iwmon logs for a successful wpa_supplicant
> connection versus one from IWD. Both connect and both pass data and
> both grab a DHCP address. I do note one difference in the connection,
> though.
> 
> Request : Connect
> through the responses RTNL
> wpa_supplicant knows it is dynamic

wpa_supplicant doesn't manage network interfaces.  I assume you're using ConnMan 
for this? If so, ConnMan sets the IFF_DYNAMIC flag.  See
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/inet.c#n372

> 
> Whereas the iwd log does not:

iwd doesn't use IFF_DYNAMIC in its DHCP implementation at the moment.

According to 'man netdevice':

               IFF_DYNAMIC       The addresses are lost when the interface
                                 goes down.

I doubt this is the cause of your DHCP / connection problems.

Regards,
-Denis

