Return-Path: <linux-wireless+bounces-13895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C299A8FD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 18:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0207B285D39
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2828F199256;
	Fri, 11 Oct 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgPlXfy4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5F19ABBB;
	Fri, 11 Oct 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664595; cv=none; b=YK1CeQ9sKOxbZwXyhAUOMmNO1pTRGXvwBwAwhUwywAUe1Z0Asmi/svHHnp6aSUb6LXfUxI7s4Nm/uFGmfflr+Ci3s83VgUVHzpuxJxw2KULRPT0ncMoEJiuSLvVt51ssCnRTUpYFZPhhGkJkCuFKSQkZx7wsLtk2InA1pedqh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664595; c=relaxed/simple;
	bh=fRfQSncXuagBn4y3+lRD4uIyuFJFXMo6bVLzVfTEijs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMAt8F2kgT6x6NVfMs9hq/VY7NrI3MrHIVaY9B4SZHn8Yjk7L1NP6HyhXXCBaV371d9g/D1eF9BnaJM8ypuecoXaO3qjMCPQEQcko19TLQdv2y1JjgJW+rfroY2hfyJVfbof/qz72Rs6Ie7eQU/gVa4dF/L3xtIr2tPzdOpumes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgPlXfy4; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4604d8f1622so5747911cf.1;
        Fri, 11 Oct 2024 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728664592; x=1729269392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EICz9GuOyoUBn41No93e0bSvSxbKxa69NwvBJHCFQU=;
        b=DgPlXfy4/myMTTeSFFDTxAPldqcZh59EvJPPfGQ6zZPVVatclRj7rkOiGXtaFYp4qa
         o5CjXuVESZLbN/C/T048nL6E3Qu9kCC9gCGkY0DcH9zJizRfC8HlhLqfpHUVBObNlLm/
         Qa0x3ERbnZNcgT35g1jHizad6bSEeyq4Cp7qHX/3eFoyUlNNzZ3NKHbyk3aoEZLbCNKD
         0YVu9c/xO2Zv8ER/7gvmgnMXfZvcdPDKnMRdpFSiugyEPAvzIjTguDU5S4/W/dwF20oY
         giP3jt8BgpTQZond3dXsCdjY775RURmAzZQzyZnwWOEd9smuseNWtgr9SJR6tLOkiKh9
         eMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664592; x=1729269392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EICz9GuOyoUBn41No93e0bSvSxbKxa69NwvBJHCFQU=;
        b=SCRGakemgHuS0+UVn9+1WDrYiVZoomw+lwbEQ0ru5aDV5remXYuobztMqK2popFfbR
         N8ayV1tcmNxJy12QKwMK3S9zZWO/LlbZgWdHw6M076Kdd433NainQQisVIwcur4inZpq
         2VaV8ruCj0kL0yBej6G3oWGiETJYEitO8EPvfQcQWuWBwkOL7AR48oFoULqnVxqIiEoM
         gwCcxv5+u+o0ljxNA4YgMEd8rOfQKG11BRLhN8wVDyHAtNVwzD1dIgPSc7ISK+lI/jm9
         HI7VX5FYTOnGxLk/+8AELq+bMueHoqJL1JzsraGDt+UIABSN9OmnEvpHSe8DmSHyLNAt
         9G/A==
X-Forwarded-Encrypted: i=1; AJvYcCXd5Xb4NnAmahpdB505/AexF4FJX6+AyHJKnqZhsO5LJl82mLJ96kp0Vd+F0nami5oRZR6BL08giXVyWyc=@vger.kernel.org, AJvYcCXuTk4q1YhtH1j8QUG3OWa5wsBLdxQewSolrJ2NrtjlN9P6kZfBjN+KyIQCiV24TXp7NgPYYxaZqHjujWWanoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykPQTkR2x3IH3fMvOEOCU4oZKDb7kMLILolcRwNzIYyQVYvJIh
	CPoJn1BxBzFwAtBCnPbhvXGsPWOBRpwg4Y8jyyitQlclc8lL1SJlEwIKNg==
X-Google-Smtp-Source: AGHT+IG44fWfmR7QcPGgn1sQ4iDCOvZwINz0uufu8zxEXB5D5LFVJ4ttB1zQ8SXb+8eLL+1E1a9hew==
X-Received: by 2002:a05:622a:1f10:b0:458:5716:fbd8 with SMTP id d75a77b69052e-4604bbcecf9mr54546141cf.32.1728664592363;
        Fri, 11 Oct 2024 09:36:32 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042895a9csm16691971cf.91.2024.10.11.09.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 09:36:31 -0700 (PDT)
Message-ID: <7ccfcd67-986b-40a3-8311-73b5335f980c@gmail.com>
Date: Fri, 11 Oct 2024 09:36:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
 (ETIMEDOUT)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>
References: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
 <8be8619d-f09f-43b2-ada8-2fca2a7d8ea5@gmail.com>
 <8eda1bd2-88fc-4262-aec0-6f88a73797ef@molgen.mpg.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8eda1bd2-88fc-4262-aec0-6f88a73797ef@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

On 10/11/24 5:48 AM, Paul Menzel wrote:
> Dear James,
>
>
> Am 04.09.24 um 16:09 schrieb James Prestwood:
>
>> On 9/4/24 3:45 AM, Paul Menzel wrote:
>
>>> Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3 
>>> (or unloading and loading the `ath10k_core`/`ath10k_pci` modules) 
>>> having been connected to an AVM network:
>>>
>>>     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from 
>>> hardware (-110)
>>>
>>> Error code 110 is the value for ETIMEDOUT. I saw James patch [1], 
>>> and applied it, and the error is still there (as expected).
>>
>> My patch won't actually fix the timeout, I just lowered the time that 
>> ath10k would wait before it continued which fixed some 
>> incompatibility on the AP side of things. Based on your logs though, 
>> it appears you already got disconnected before the failure to remove 
>> the key...
>
> I am still applying your patch manually on the current master branch, 
> and it looks like it hasn’t still been reviewed. Maybe it’s due to the 
> RFC tag. Do you plan on moving it ahead?

There was another thread, which I cant seem to find where Kalle had 
mentioned the RFC patch. IIRC Kalle had said the proper fix is in the 
firmware, and would rather not take this patch upstream if we can get 
the firmware addressed. And I would have to agree this is the best 
approach if this is an option. This RFC patch was merely a workaround 
for some odd behavior with Cisco APs that one of our customers was 
using, where the APs would actually reject roams if they took too long, 
hence why reducing the timeout "fixed" the problem.

Last I checked your situation was different, your device got 
disconnected _then_ failed to remove the key. If this is the case my RFC 
patch isn't going to really change much, apart from fail in 1 second vs 
3 seconds.

Thanks,

James

>
>
> Kind regards,
>
> Paul
>
>
>>> [1]: 
>>> https://lore.kernel.org/all/20240814164507.996303-1-prestwoj@gmail.com/

