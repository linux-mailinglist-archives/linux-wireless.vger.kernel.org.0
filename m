Return-Path: <linux-wireless+bounces-8676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631808FFFCC
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692EB1C23035
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4A15B989;
	Fri,  7 Jun 2024 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OaLd97R7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCF15B122;
	Fri,  7 Jun 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753456; cv=none; b=M0ivTEHfnGcNKHsqSzYSUOck07MiYB8b+DYbLq1wPSygzYvev3nM2k5Evbu1ejXzoiIr6DTzWMTVt5bLIWO9KlQjCzRBai9CR35BTyTK9iydLt3OxHWRN7t9to0UzFM2uTuGvT+vgvQbMXHa2fdwf6KOT2gpa0BUxVfdDtRTvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753456; c=relaxed/simple;
	bh=2mT2I/1Q77Tiqay8xStHbcCX37B0aHQ26qx1zUhRLnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgrswDZbigoTsKEpFxat7wpEGLBDKDDR9p84aM3lJCkYWX2pjKzG4TVTY7KTabUoDhBS4lHFD9ZyLcpEIOdf3mp8djDOi3y4OGr22/7j+HXoMmPevouYsP5DpMC1eRPAVQ09TfFy7y4q8RgwbBo65pdn/gzIz6Bk8nmarOfWhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OaLd97R7; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CAE1240005;
	Fri,  7 Jun 2024 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717753452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yyx5zM1CvYIUAqANuHPAr8M/UeGqJG8eIhKlHzJByE=;
	b=OaLd97R7bAj+5dDAGZ0DA7B5AI83++gIwTNxZ35ji2PxPmQ+uy0ZIRhrQPSfG0iU/dIpDN
	c55Y8dpJ/CrvVILOQjB2ESfubylzjQROq0hiP13wCK4NnMfOqht6FmDslMtpCdJ1ZNxsYb
	y+sdrORNm8kemd2gjnPCrImy5Kj9H+0pbiLn5Do//h8QVHnOHw+HHJSjPoxi6ZaZMSucXL
	0HnZuv+vfhIxp1Z2NIwnDHkN0OgfRgdZvl1AbpQXEt0pVgOzpPxYkJ3F1PkDgCDzL2exFF
	1E+jbHmm97apf7REVsGzXv+ypf6N0oibjJdUlTmrsmok0n8IbmoLRcFApjPuWQ==
Message-ID: <317b515f-30fb-4b18-bb99-b65091449ec4@bootlin.com>
Date: Fri, 7 Jun 2024 11:44:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
To: Kalle Valo <kvalo@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240603110023.23572803@canb.auug.org.au>
 <875xuquyyb.fsf@kernel.org> <87tti6qt5o.fsf@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <87tti6qt5o.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Kalle, Stephen,

On 6/6/24 12:09, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>
>>> Hi all,
>>>
>>> Today's linux-next merge of the wireless-next tree got a conflict in:
>>>
>>>   drivers/net/wireless/microchip/wilc1000/netdev.c
>>>
>>> between commit:
>>>
>>>   ebfb5e8fc8b4 ("Revert "wifi: wilc1000: convert list management to RCU"")
>>>
>>> from the wireless tree and commit:
>>>
>>>   6fe46d5c0a84 ("wifi: wilc1000: set net device registration as last
>>> step during interface creation")
>>>
>>> from the wireless-next tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary. This
>>> is now fixed as far as linux-next is concerned, but any non trivial
>>> conflicts should be mentioned to your upstream maintainer when your tree
>>> is submitted for merging.  You may also want to consider cooperating
>>> with the maintainer of the conflicting tree to minimise any particularly
>>> complex conflicts.
>>
>> Thanks. We need to figure out how we solve this conflict, most probably
>> we'll ask network maintainers to fix it when they pull wireless-next.
> 
> Alexis, you know wilc1000 the best. Could you double check the conflict
> resolution, it somewhat complicated:>
> https://lore.kernel.org/all/20240603110023.23572803@canb.auug.org.au/
> 

LGTM, and some quick testing on the linux-next tree with the corresponding merge
commit showed no issue (no RCU warning, and mac address loading fix behaving
properly)

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


