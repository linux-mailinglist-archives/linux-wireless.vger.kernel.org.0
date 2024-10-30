Return-Path: <linux-wireless+bounces-14735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C09B63E3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AB728295B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA445023;
	Wed, 30 Oct 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM8IIhHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415A3D551;
	Wed, 30 Oct 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294262; cv=none; b=hq3/bXVhB/5wj+Uj1cLgxp5xTkNiIRk/SNoEDz0K/yDdCAlvytwlBYUJbv46KXR90ZdXGqhG/PGXxmuXgK44XFZ9G+OfX5zQUJ8BwGyLJ3mtJIdIDK1zDvDA0R36J7IjACF0Ux21VpOFeVFkSrCN8SolWkfKetR5KYL9zbRvZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294262; c=relaxed/simple;
	bh=7LSgZxYpBGd1npYy4xgr5/IFiST5qDnV77eehbUTEDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=px3KVHNwU6I/0/rOw0VsLPp8m6idJnOcagpRUqC/Qf/Ys8+dQwS543rrNpBHnpRH4+om54HeKk6ib4taXk6EjFNK2cIbPVrFftJzo6Ua9b2G//jS2a702UUeExRW0A5DCT256sw9zKk2CsNFWWWVL1zRlS6sFK7uPy/SWJ7KjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM8IIhHW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so990821766b.3;
        Wed, 30 Oct 2024 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294257; x=1730899057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gyxyoUviu6uqUWH/cy1i8mHHBIJcAPqfiqibX0KqM8=;
        b=UM8IIhHWXPrgXvB6DFxfbO+hlcSp4QqmVJYWoxLw4RXa+/PLH3BsA1CZ+KHDzd1Iqy
         p8XRmUBe+k0cVhHrlhUWAxaKE3thcoOgaoyq3KCKMG3vb3fESB//Su96NMeEIQdcXqqA
         T0Wy9aPgxPi0DxUBb+OJSBI+GKAu073R9rw72+uRjlyfPeosUnF9DoFC3uYF1ZXCUl26
         xd6I9jwwQC+Bs7b2gXYUulc2F2wKafUrDFtg0a1uVe/wKwH7iWoNSuZNiyNse9fu7t2t
         5CrbbfXOVXeX189j3CCY88vinu6gP8b6YfGOgerdKOW94lgt0Y+Cd8MVpvizFDmqNmpf
         migg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294257; x=1730899057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gyxyoUviu6uqUWH/cy1i8mHHBIJcAPqfiqibX0KqM8=;
        b=OP42+RMvt0MNQp9cD5Yq3T134Q4gv9fgEIQ1h5mFe5cMVKbCdI0vZuMOYaKoTIQ4rg
         R9YT4eiJbF6CwwQSyhSec/R52YXtpLHCNzJs+w4Sxa/k9/NNGIJGIduMWzUowxYM+VDw
         DOh+niSrdFq13LhsPznmVNuFBIP53jX0kZgj4TrqPhhHU/AZK7/T6C1519GDNqIGxr8M
         wwhBTGl74MJMyPUW5ikiCNJA2UhP/ZKiLn9fqYzxFe+KELZ/uwjjLoZluINaOe1mQxjq
         si6c3Y5CgGL+m2pFtm2igYiagE6xzjgU+3R2adWWXuxoDFLRCTJPXDjjUpeBGL0PZZhp
         HIWA==
X-Forwarded-Encrypted: i=1; AJvYcCUdJt/yY2QB9YjWv/b3+IGH4qJVB8bQsgSE/rJE3uHkeA4yYz9bK1+ZflgnkKF4tERTEZ2ow50sBh/hjY0=@vger.kernel.org, AJvYcCVnvpk4rIX+rLX99YL0k03Ahr6FvKF+Q349KTwfDKQfb6gbsE6Dbjq+aW9r5cFzUeQIyAlkRkHp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VpPLwskW/3j4uEugkGE+uX7aB2keWJVsn9RD5mSPRFmhbZGb
	PqyfNskH6OWbDgz51+XwZUy/jR6ENXbRJ+xQSxFfpa2856SRkVmjTzaDBQ==
X-Google-Smtp-Source: AGHT+IER/5f2G4la7GINKS4UizPtPjbUp+XOatRjnXnsYQvTjY1fbBAFhhk4Vr2lAow13dab+g1eBA==
X-Received: by 2002:a17:907:3e20:b0:a99:d587:6045 with SMTP id a640c23a62f3a-a9de5d977b4mr1381667166b.19.1730294257251;
        Wed, 30 Oct 2024 06:17:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7b59sm570613766b.44.2024.10.30.06.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:17:36 -0700 (PDT)
Message-ID: <c47081db-4a7a-46df-bb4b-82f8dda94460@gmail.com>
Date: Wed, 30 Oct 2024 15:17:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
 <ed8114c231d1423893d3c90c458f35f3@realtek.com>
 <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
 <c93c8e9c109b444b91489ac0e88b987c@realtek.com>
 <14c3164c-0e1e-4d9d-89d9-28d3240861c6@gmail.com>
 <d6e01e56-51e7-cbb2-024a-c7db86dc70fb@igalia.com>
 <baf6d88e-e753-4aaf-a340-991373d77fa8@gmail.com>
 <984038be-6cc2-3acc-8ab0-5720a79dbf07@igalia.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <984038be-6cc2-3acc-8ab0-5720a79dbf07@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 19:58, Guilherme G. Piccoli wrote:
> On 29/10/2024 13:55, Bitterblue Smith wrote:
>> [...]
>>
>> I tested your patch. Both my devices can still read the efuse.
>>
> 
> This is super great, thank you! Would you like to have a Tested-by on
> that? If so, just send the name / email of your preference and I can add
> it to the V2. I'll implement the PCI guard and re-submit, thanks again!
> 
> Cheers,
> 
> 
> Guilherme

Sure,

Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

