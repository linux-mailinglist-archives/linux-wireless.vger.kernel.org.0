Return-Path: <linux-wireless+bounces-23367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F828AC2373
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA33AA359
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE284315C;
	Fri, 23 May 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFwxlWMM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC699286A1
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005630; cv=none; b=DcI91BTS/aN81EyP/M6gcivgXbUsvV8a8z32Nn0aKmOGsuas92490bHmouzBg4bIMA1kFhQd79WaFQ89dVhCuhyXEmOOXvX3xu6RDcyTumcRJgV3CORsKjsVARsckSWcfOWSxJngqzW957mcfTSLb2x2fDdO82tTHqzwzn2XAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005630; c=relaxed/simple;
	bh=dI8Ft+WNHgNsbNHVt0cpz/HS3wHFHAbkPh9PcMBHT7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iXUoAcLS3LeC76A3poGIBynPLzgbwnqmCqmOnD61hy2OAU90L5TH6Kc0Ch3wiMl4dqNCEu/xkiIICpofUc9i2tzXJvaJ2YQ15Au5aBJ6Mbo5/GmwIuLqIQ/Rg71Y69XVht1Fx7lDVo5RXf9v92fKoH2sOPirFdALvdWuOPldUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFwxlWMM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c7a52e97so5229619b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748005628; x=1748610428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3rzC5V66f5Qtg+6RNtEwfgS1eJCMpr6W/IQ38lCH08c=;
        b=KFwxlWMMiudETodxqfMWW7wV83Mv6Cl/uoTvuUhDtoW4VJrQVfBZwZPMDQBXMaaIt3
         LY5fvL5rD4ykc0VOmjskUQywISOSeMiefSucsB0yXX/OoE5xNQ5EN997ZCkBXuHZYvFr
         Ytq97FtQpWTRZ6I/iLno6xW6cKwaarNR8extsMWq/5y+sn02rx9lWwp2RpXTGPkp+sy/
         CYe7eCop8eXWhhBPZQt4YCT/lPZU/3Kyp5+JJwg4+xnufBYPDOkHBpeiFz+pZPW1HjAu
         DA4pXLisfvmpHERfodcqt5pxClekOyvHJrQV4c3FesXXqKT53JktIAcUx9SyxYieieWI
         G3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748005628; x=1748610428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rzC5V66f5Qtg+6RNtEwfgS1eJCMpr6W/IQ38lCH08c=;
        b=Afgne8jtT5f8ca+9CRXghvIx/DYmFLdbR/q40+un6GpK0aqiAOu4ipWFST4CZIBNWI
         C5YJnUJuQooCl+0jdSGpS34Sja960wOz3K/VaDzJpHCuVZTcq/pLBEpk3/xwKjvfz9fi
         9A2jH8VJNvQqSO9Xmv+sEo15xdmvv0JgecacK2U18y56W5IhdMC1uSxsFBzMffLvR4RQ
         1iEVILdmPnORaFhQaMbAlGDBQsNBjhqyi66FkG1UyJIO6XRjvUlv7m9TGQksi3ZH4Qqx
         /AdZl42bHahCbfFMX17EjbrCc5fSimxmB5XE40b5J203Eni2bNPYezR1uLLg13OWy3Oo
         rbVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/LsokjKlwd7YvDipcZCqpR+t24+jpbpv7SXxRqvqXwZgL2k97U0yDnDLbgEG5qYVskjKZsgrN7DrXyURpNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbBDW3cC59vDwkxjZkgCglqx5EYRTz+sxpwKv69suLsoyIard
	3GYWLhQOW19TbrQZVZzO9PUfqCdcukrF3ixaIrf59RhuiXblt73Jef7Q
X-Gm-Gg: ASbGncsHd1vNyemxXIRHqRn+wjGPIp2a8TozBYS5x7zJrd7kidVnW92RoSNnRmr2hmz
	p5eeAdZMp121AjxITJAOrEJ4nuQpYIbrz8vp15yrMOpQvmMP13ZYRm3z39SbXNiOK/asMw2L2D+
	Qx6vpWSTSQjdYMsogm+O+lx3gISCIjKADxyR+kFnUKmr7LZ8ARrWt48VpiCmb5I8Jvj92XSxNou
	hu1ZCsSU/YZA4w076TuivLGPWmjcJpJhzRRzHj7mFxOywiWmfE4KWJwKQLYumUkb9zzSRfE1hBR
	BLm5/8ko0zgRdhX9HJwfqG+zNeccMFXloVstm8N3AjmZTy7T8xvpEP4KUIvp+MOHvC3EYvBuEOt
	k/G4fJffB+2YuoraNH9GHe8R7zA1IVA==
X-Google-Smtp-Source: AGHT+IEIHRXGJQ8MYzkfSYDsgj/dP8hvQoakZ+h7r7CZGO2NlxtJzFj2EGuZBj6u4/2odSWC2VkyLg==
X-Received: by 2002:a05:6a00:3a0b:b0:73e:2dc8:94f3 with SMTP id d2e1a72fcca58-742acc8da73mr36327889b3a.1.1748005628012;
        Fri, 23 May 2025 06:07:08 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a95b2b19sm12698902b3a.0.2025.05.23.06.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 06:07:07 -0700 (PDT)
Message-ID: <3e4dd1d6-2eee-43c0-a9f9-9fdca5eda866@gmail.com>
Date: Fri, 23 May 2025 06:07:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Association comeback delay behavior
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
 <2e1fdb77f2ed5f381323f6a493c62ea1bdec19a7.camel@sipsolutions.net>
 <56bcd608-bda2-40a8-9314-d978a39bf90f@gmail.com>
 <e5241e83e7675a3db309c9bdab378549ee27ee45.camel@sipsolutions.net>
 <1b442183-1b73-4461-a9ad-14c1980bbc43@gmail.com>
 <17ba3b94c5c5ced1d77ad457beedb57b0815820d.camel@sipsolutions.net>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <17ba3b94c5c5ced1d77ad457beedb57b0815820d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/23/25 5:57 AM, Johannes Berg wrote:
>>   From a user-experience point of view I think most people watching their
>> device trying to connect for more than about 20-30 seconds is going to
>> trigger a "wtf, this is broken" response. And I know if my router was
>> taking that long to accept connections it would be promptly rebooted.
>> Its a long way of saying that I think there is some reasonable value here.
> We don't just implement wifi for laptops though. I mean we, Intel, do,
> but generally the stack gets used elsewhere. The random IOT device out
> in my garage? I don't really care where it waits, it only gets a single
> BSSID it could ever use.

Yeah the use-case is important. And for mine where connectivity/uptime 
is very critical even a 1 second comeback delay is too long and I would 
want the device to roam/connect elsewhere, which then leads back to 
CMD_ASSOC_COMEBACK.

So no matter what I'll need that event, I was mainly trying to figure 
out why the kernel let these excessive wait times happen. I don't have 
an answer as to where the cutoff would be though, so I guess I'll drop 
it for now.

Thanks,

James

>
> johannes

