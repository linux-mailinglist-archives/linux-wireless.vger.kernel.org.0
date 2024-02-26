Return-Path: <linux-wireless+bounces-3985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E961866815
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18631281AA4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77719470;
	Mon, 26 Feb 2024 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeiupenD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7519478
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913617; cv=none; b=N2GZDPcqSzkqg4y01aLoumIYBH44d15Az1kdSvtC5CDb5rX65Yd9uKf1LVVpEPITLakMIwW+RKIYHCf6dTXpETtqQWvaI8JzitxJWv9jxHx9cPXCC8O5qVjiscK11VCcUOh5DDYcST51T+7AWq4olO0tDMiMldRiCZVF3vnePsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913617; c=relaxed/simple;
	bh=3yzG/40Y8IsJzzv/elukZg9yo934Lk3r/cd/J8QWRz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6miR+k0v+UsOlMvfZF8TCPLcYE2R/9CrvXOzK6vKDVXk/zEQkg5clTymOi7Z6xSKsPY70FYK+jS09PEHtGNP6fNwVjhIlJ088nfcODRWl98+1tZQcv4l+XaPMxEQJiVKxbsMtFinmC1+YbsueoQbQg/FqgtxyxKS1uVq/oB8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeiupenD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2568236a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 Feb 2024 18:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708913616; x=1709518416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvbwORjAcCQlavyhrOq7yHYE/Da1J169JbgbZCVHVNI=;
        b=BeiupenDUU6KZGfXpNplchLTXTygjFL9FhapxmmmEJFHPdvCOpyM3SGbM4bmaBrFaW
         6IGi+V+QOg2IxPjK01asTf6XTwTcpF35fu+sRGe11hXOArFZzrigkzYIPkP4XpWw/rE4
         ZsQxIynA1NokLHcWRjUZ+67niKMUjgKBCbbxHIvxbbSRGMqKnCnSb4dg/l6fZc9FQln6
         VTIrvp8aZom/JKidVCk8g9sCwKR8YgaecSkf5Mgqa12JiwLHkoPU3kVTLHm2SBRzd811
         I3kSAnqu9bwA3qTqG2deVzNjwd4d9HO4az4Gdi8RXXtr9Qq6RL/w1aYRYRo/6mQYa6l9
         M7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708913616; x=1709518416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvbwORjAcCQlavyhrOq7yHYE/Da1J169JbgbZCVHVNI=;
        b=epfZnzKXbIsmDRhPjdMXrrr7JhxzMjge7SpJwsxnFlX8nhOyboQHlTSMkem3jJjFwJ
         arhF1tnfUhNQOKMTJfsXWxMDTRvygaowu8g5s6vx7U9Ovj9UmNAElwBvqErzl4hAFv58
         H1V/0cQydJXWD1JSw/kM7+ey9n4jEEgS5UbT0hx89Z0Y2AldcY8zYeoC1Sj/9KXy7VSQ
         ttw0pF0HaoKNzWuHRS1VIDvqult6Fv6mHI8T5L4B48mkIXTboRiCg9QyUCL2iykovzTp
         1gwuisoYrlNJ1N+0WqyR3azd7m3EJAq0r8cwfLqpOevYhPlxocbXpzfiFueSJojkoIfu
         9wxw==
X-Forwarded-Encrypted: i=1; AJvYcCU6dlsGonLOxkKqEjmEcUrgA/i8k3pxEcXGqwUl2umDMs9PIGqoljPH5tUkkRB/2b0Tsp8pqAC6vpT1vlN7MpL25/vSnpkOZprYORULXSY=
X-Gm-Message-State: AOJu0YwsYt4aQR+e7w01VtKmhGvj6xy9dWG4a2SnELdzUIOXWrVqePXs
	WmVSv5+Jqr/MetabkVGGRzGEO2FQxfsaLOMg+1ulxR3hcXYxS59c
X-Google-Smtp-Source: AGHT+IHmdw/6mreGwUkgeB2G4V/RfpMNc0Q1g+F0QuK6yNk8Bjq2vPEVIyVnPX/k4ssjTRtWeetgSg==
X-Received: by 2002:a17:90a:730b:b0:29a:15c0:44bd with SMTP id m11-20020a17090a730b00b0029a15c044bdmr4532322pjk.23.1708913615693;
        Sun, 25 Feb 2024 18:13:35 -0800 (PST)
Received: from [192.168.0.87] (c-98-37-244-255.hsd1.ca.comcast.net. [98.37.244.255])
        by smtp.gmail.com with ESMTPSA id w191-20020a6382c8000000b005c6617b52e6sm2936627pgd.5.2024.02.25.18.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 18:13:35 -0800 (PST)
Message-ID: <21846c39-b5c5-482c-97be-51e36e1ebf49@gmail.com>
Date: Sun, 25 Feb 2024 18:13:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wireless: orphan qfnfmac and plfxlc drivers?
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, Sergey Matyukevich <geomatsi@gmail.com>,
 kernel test robot <lkp@intel.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, srini.raju@purelifi.com, i.mitsyanko@gmail.com,
 krystal.heaton@onsemi.com
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
 <02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
 <875xypejwt.fsf_-_@kernel.org> <871q9dej8j.fsf@kernel.org>
 <89bc5ff1-b049-49d1-b15a-4e01a4659c74@quicinc.com>
 <87le7kda2a.fsf@kernel.org>
From: Igor Mitsyanko <i.mitsyanko@gmail.com>
In-Reply-To: <87le7kda2a.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 01:37, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> On 2/15/2024 9:21 AM, Kalle Valo wrote:
>>> <imitsyanko@quantenna.com>: host mail.quantenna.com[50.87.249.29] said: 550 No
>>>      Such User Here (in reply to RCPT TO command)
>> Apparently Quantenna was acquired by ON Semi in 2019[1], and in 2022
>> they closed it down[2]. Seems pretty abandoned to me.
> Thanks Jeff. I do wonder is anyone even using qtnfmac and plfxlc? Maybe
> we should just delete the drivers as nobody seems to care about them?
>
(replacing imitsyanko@quantenna.com with my personal email)

Hi Kalle, Jeff,

that's right, Quantenna division was shutdown by ON. To my knowledge no 
users of qtnfmac drivers are left after that. I would think removing 
driver altogether is the right approach. I'm not associated with ON 
anymore so it's just my personal opinion.

CCing Krystal Heaton who I found on ON "contacts" web page (just in case 
someone from ON wants to comment if removing qtnfmac driver from Linux 
kernel is a concern).



