Return-Path: <linux-wireless+bounces-22313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C5AA627D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 19:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530301B676C4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53D214A97;
	Thu,  1 May 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="e6hd/Ecs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8731D6DBC;
	Thu,  1 May 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746121568; cv=none; b=beKCcsa9qv/dOslwUp1H6F/w7tNbgHpkQVT3Ks87vauAYJ8dVEMtEKTPz/t1x24zSeldC6A+DXhnlxoTSLd12iTiJzP7d9fNosXejwRUa8j1hBlk+8ggfMcu/7HO9s5HwuVjQivMLX58r3P5VGH5e+Rtblhnyq86IGrAnYn8aG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746121568; c=relaxed/simple;
	bh=idSL8FIZNtnlvPROVmiwxEiJwDqSNBxM751hv/Tx08g=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=VX+MRMDinBlPjGMFXRkJGoC75dGoiWrHDUtIihf9Oq3gIybb4Z0pGc75FER7GWNkCHDLysooHAYGp9c6RiaxIKwdUIuKrfNANEhxT9DYQ7C2HjuyR3oQsOuRhXV+Vqwdpe5mp4Ulnx+Qi79itsshEF+ZD0cUHSqB5aYjyRym4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=e6hd/Ecs; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id AXxpuAhzzGqxdAXxsugzS3; Thu, 01 May 2025 19:44:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746121494;
	bh=z7Nrw4AKQmy2euxdBhwFFiDxhQNLz4rSOScscuh0W0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=e6hd/EcsRx6taxaXTxk2taRj60hukc4HpaW8I/gT9gCIIY4QSz7wOdqu1UXQoYSPh
	 GdHtdPl5nHlivewS3IHl6Ee/IJz6dDdd5yL+VkdRPVq73RZMAGt0vYMRbHrmzojZIy
	 8p8m1Myau4F3hU6/17scjv8dF0IegiTmVtUgoinmrH30z9PS0/nm53hXTMfw+RkPOO
	 NYFtDgeZINfF310bF/aJHQVCKV0WlzGPsdyfadWucJphCKEVAd0xdiYHogobPu46VR
	 wfH1OOWDup6fveZMCvu+NcOjRN4xRfUK8AEDuqJTF9Se5HyGdYrMtqHxygTTwD50pw
	 TsCw+ZUxZwxBg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 01 May 2025 19:44:54 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a73dd097-cc0b-449c-b819-3450688e67ba@wanadoo.fr>
Date: Thu, 1 May 2025 19:44:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] wifi: Add Nordic nRF70 series Wi-Fi driver
References: <20250422175918.585022-1-artur@conclusive.pl>
 <20250422175918.585022-3-artur@conclusive.pl>
 <3cfd718f-e96a-44d0-b42f-d759ae698810@wanadoo.fr>
 <CAGhaMFNhq-O3O0TCj6cvzvTqzPQKE_id67U0hZjV0V2uKV91Tw@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 jakub@conclusive.pl, johannes@sipsolutions.net, krzk+dt@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
 ulf.axelsson@nordicsemi.no, wojciech@conclusive.pl
To: artur@conclusive.pl
In-Reply-To: <CAGhaMFNhq-O3O0TCj6cvzvTqzPQKE_id67U0hZjV0V2uKV91Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/05/2025 à 12:41, Artur Rojek a écrit :
> Hi Christophe,
> 
> thanks for the review!
> Reply inline.
> 
> On Fri, Apr 25, 2025 at 9:31 PM Christophe JAILLET
> <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
>>
>> Le 22/04/2025 à 19:59, Artur Rojek a écrit :
>>> Introduce support for Nordic Semiconductor nRF70 series wireless
>>> companion IC.
>>>
>>
>> Hi,
>> ...
>>
>>> +     /* vpwr is mandatory, but we want to catch the -ENODEV error. */
>>> +     priv->vpwr = devm_regulator_get_optional(dev, "vpwr");
>>> +     if (IS_ERR(priv->vpwr))
>>> +             return dev_err_probe(dev, PTR_ERR(priv->vpwr),
>>> +                                  "Unable to find vpwr-supply property");
>>> +
>>> +     priv->vio = devm_regulator_get_optional(dev, "vio");
>>> +     if (IS_ERR(priv->vio) && PTR_ERR(priv->vio) != -ENODEV) {
>>> +             return dev_err_probe(dev, PTR_ERR(priv->vio),
>>> +                                  "Invalid vio-supply property");
>>> +     }
>>
>> Unneeded extra { }
>>
>>> +
>>> +     irq = of_irq_get_byname(dev->of_node, "host-irq");
>>> +     if (irq <= 0)
>>> +             return dev_err_probe(dev, irq, "Unable to find host-irq\n");
>>
>> If irq is 0, is it expected to return sucess here?
> 
> No, return value of 0 is considered IRQ mapping failure, as per
> of_irq_get_byname() documentation. Perhaps it warrants a different error
> message, though.

My point is nor related to the test itself, or the message.

I mean, that, should irq = 0, then it ends to
	return dev_err_probe(dev, 0, "Unable to find host-irq\n");
and the probe returns success.

Maybe something like:
	return dev_err_probe(dev, irq ? irq : -ESOMETHING, "Unable to find 
host-irq\n");

CJ

> 
> Cheers,
> Artur
> 
>>
>>> +
>>> +     mutex_init(&priv->write_lock);
>>> +     mutex_init(&priv->read_lock);
>> ...
>>
>> CJ
> 
> 


