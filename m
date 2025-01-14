Return-Path: <linux-wireless+bounces-17501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E124A10B5D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 16:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7432E7A5271
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91A1CDFCC;
	Tue, 14 Jan 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jj4Rg+Bv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A721ACE12;
	Tue, 14 Jan 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869495; cv=none; b=GaLnmOBYkLkeg7xepdL+rVO9wwNrzSe4W048cLwkPLef10bzrEVqGiYt0gvpNg6QIh04Ya091hfUsxEwR4SIHBDWJFJXrWkF3rPtPgsZzdOHt0ZZlf1LynGfsprOXmj++LhvkBIWhBTf4eYy1agL9iAAaprzDLwEJIx1lSuk1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869495; c=relaxed/simple;
	bh=zxszI9t4R+vVNc8ZZxGix0Ap6as/A7QwELeAUTlB5cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Olk5JYqZRS9PGn+ZC2tfXJvMd2xSXhS+Z7Aa4rG0pfoKKNUliA0TJFozKkgrN3RaMWjb57z/VZX15zSrsZxBtHmCQrrTv6IvZsZHYZzy2qWrl28IbIq1NvtSvCZzH6hq7AY143g5nCUhc26ih68O0s5+m8mhtnn+fPk6N6b0oYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jj4Rg+Bv; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE85E1C0006;
	Tue, 14 Jan 2025 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736869491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOgokNd7tUxraq3YOmrF/cAoQHoDhiKkeICtOBBMWJk=;
	b=jj4Rg+BvaolhW+cNk+OACp8+RfkIfkn/BsU/H3aKFvAeo3MAWH9lg0Evl5JFWi0HUyGxMO
	6CLgkSHmE8XHNlDt1cxJU4ZD9txaULF73w9Dsd2hA91EXCR1hKih9FBvqS/Q6YPHsZ4Vbj
	9ZWEwtXnCW75zMQn3Qb/GDChfp8hIEd1Refp8Bhrez1LfgAhsFqMyXIv8LP8814sTdmhdR
	gUyEX/0BsPt1TCExCXhUjbGlObaBp5m6Wt0OBTE0Uj01s2MA3Kukf7Xw22ejds/LKYFXXw
	53chAyKu5bTQ9DXDi04Einh1t1iwn4wPC3ix2PoElQRniPp/1cMYwY/Lc8dHqA==
Message-ID: <d26a4283-a4fe-4ec6-9601-c239281335ac@bootlin.com>
Date: Tue, 14 Jan 2025 16:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: unregister wiphy only after netdev
 registration
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Marek Vasut <marex@denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com>
 <87frllr3h1.fsf@kernel.org>
 <165a166c-d402-48d9-a190-44a710fa4d1c@bootlin.com>
 <87bjw9r0qd.fsf@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <87bjw9r0qd.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/14/25 14:20, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> writes:

[...]

>>>> @Kalle: 89a7616e1715 (the faulty commit) is only in wireless-next for
>>>> now IIUC, so I did not provide any Fixes: tag to prevent any faulty SHA1
>>>> if those commits end up being picked in stable tree (however, the faulty
>>>> commit _has_ a Fixes tag). Please let me know if we should proceed
>>>> differently.
>>>
>>> Hmm, I don't really follow you here. I feel that always adding the Fixes
>>> tag is the safest option, that way it's clear for everyone what commit
>>> we are fixing.
>>
>> I was thinking about the fact that the faulty commit SHA1 may change because of
>> a merge, and then break the Fixes: tag, but maybe I am overthinking.
> 
> Ah, now I understand. Actually commit id doesn't change during a merge
> so we are safe in that regard. The commit id only changes if there's a
> rebase in the tree and we don't rebase wireless trees (unless something
> really drastic has happened).

ACK

>> So if it's ok for you, I would like to add the Fixes tag
>>> but I can't find commit 89a7616e1715 anywhere.
>>
>> Gaah, indeed that's not the correct SHA1. The faulty commit in wireless-next is
>> in fact commit 1be94490b6b8 ("wifi: wilc1000: unregister wiphy only if it has
>> been registered")
> 
> Thanks, so I'm planning to add this during commit:
> 
> Fixes: 1be94490b6b8 ("wifi: wilc1000: unregister wiphy only if it has been registered")
> 
> Is that ok?

Ok for me, thanks !

Alexis


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

