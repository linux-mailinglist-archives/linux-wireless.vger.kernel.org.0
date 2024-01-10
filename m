Return-Path: <linux-wireless+bounces-1661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C78829AE2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D031B2821BF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C24482E4;
	Wed, 10 Jan 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSWVswea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9201F48788
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-781753f52afso378352885a.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704891895; x=1705496695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/iE3zonRrD+7/513nkWlW303P6DfLmdTqqBHWTtojI=;
        b=TSWVsweak95Cfd7XeO91OQ5DU/Tc0hzjIBYDqQ+823VmnGv+/U8qTPcQtnXQ3XqhJj
         WoCaeHi6uK202axBQGY8/jy6TUHXzLQZszCYELGweICaO+PC4dsmkEGYahpRCmFkdumU
         wpwIGZAhInEf2Ck54IflCdb71mB97HAiTFOVnLxlfBLl4lGGXHQnJt47zk4OWOtct9h4
         u5qGn0rKHted+tvOh4ym9wUB8gHi/P4dgo8a0iWh4lL0GU4E/l4KSyHC1PlRDheY2pJp
         ZERb6QGObYPlF/Iv3Qw+IcX1zVotrXbMAcoRXXN3z0FVSgXUp8nM2VND6DeWiII+/gaK
         9aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891895; x=1705496695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/iE3zonRrD+7/513nkWlW303P6DfLmdTqqBHWTtojI=;
        b=rZ4ZmIpb4xEuIVScVGNDxHtlsuBhX0YFgV6+TTiGkf6rK+6t1IsroJ4FMJG/C0d5ml
         IZVlHKGL5VCtDR3I2DzJGgINLtlesBl3NR2hj1Clbvfez8vOkLfy8Uj3dHlcwFuGQ7Ig
         QqaCFm44WsjZZYNSiAn2Vg8IIR2er0tzXGc7NovCoXNvv91kXaJCqGg8ynKv1Ph8gLwx
         4krButVP36dvHyF9zPG2DdyWh0RFPx+wf8g0ZicD1B6LE2g5sxcmnP1Ori2TxX1JZNbR
         WwOm0Rl2RSZsV8umVjAD2YzDhadiyX1/AHhgsLrHaXQx1P53cjzkRRrEPde1V1pvdIPZ
         Wo6w==
X-Gm-Message-State: AOJu0Yy8lyO0IcWEQiYb6F+jYL7BvcDcSp4etmplF15GBlpIsUoRKXRp
	CTWCzBTeTWT8MUru/G4jNFnlgr/SKuk=
X-Google-Smtp-Source: AGHT+IEhUoaezwc3HlGdpSeYeYVqm1+ENALKEaER1uyKroBqR5tdhBdEvHQYO2hyG4xytfEaaflnjA==
X-Received: by 2002:a05:6214:1307:b0:681:91b:75a4 with SMTP id pn7-20020a056214130700b00681091b75a4mr1341182qvb.125.1704891895310;
        Wed, 10 Jan 2024 05:04:55 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j4-20020a0cf9c4000000b00680b1090832sm1654280qvo.146.2024.01.10.05.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:04:55 -0800 (PST)
Message-ID: <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
Date: Wed, 10 Jan 2024 05:04:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8734v5zhol.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kalle,

On 1/10/24 1:00 AM, Kalle Valo wrote:
> + ath11k list
>
> James Prestwood <prestwoj@gmail.com> writes:
>
>> For a while now I've been using vfio-pci to pass through wireless
>> hardware to a Qemu VM. This makes testing kernel changes quick and
>> easy compared to swapping the host kernel for reach iterative change.
>> So far I've had very few issues doing this, maybe I've just been
>> lucky... I tried doing this with an ath11k (WCN6855) card and ran into
>> issues with the driver starting up. I'm wondering if its a
>> configuration issue or just a lack of support by ath11k? The card
>> works just fine when I use it on my host machine. Based on the logs it
>> may not even be related to ath11k as wmi-bmof seems to fail first, but
>> I'm not familiar with anything at the PCI level so I've got no idea
>> whats going on.
> There's a bug report about this:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=216055
Yes I saw that, but apparently didn't read past the first comment... I'm 
not seeing any of the DMAR faults but the ath-releated ones look the 
same. Good to know its not just me.
>
> But I have also no idea what is causing this, I guess we are doing
> something wrong with the PCI communication? That reminds me, you could
> try this in case that helps:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/

Heh, I saw this pop up a day after I sent this and was wondering. Is 
this something I'd need on the host kernel, guest, or both?

Thanks,

James


