Return-Path: <linux-wireless+bounces-14877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6359BB46A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 13:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DB9B2625B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAFF1BDA8F;
	Mon,  4 Nov 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="qLC0lpHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76B1BBBD0;
	Mon,  4 Nov 2024 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722451; cv=none; b=t311s4H/wPm2xz1y8ZUjsLxD2ubZwe2WlK3g0QQ9S3EzjxUdS6digWIM1brU1CP56zCqVK25okBnNHG+Z/BlODtqeBfEAj9VRwVIRHtagL3rHnsmxs/wbb7NsCMjsUdXm4M1137R1XAytjbMUP8g6PAjHttKvusZgk3AOHKGrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722451; c=relaxed/simple;
	bh=hnoFp2jrmTCv8QXmcb/QGK9fuoQ7COD+C5WnlZRNs5g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r45WXdjzUXidINJ/M8qjy4SIvE83S9onwEbUUW3cF7dgAupZgrwlPOyS3AezpR0iG2zJAAIsgGsHyNK5WvCMuJ+Few3LV7FdtzS6uJcrlErX8pWqj1j8RPQZfQ/G3M+csmtEcuCOpJwzkNVq89zQHBwKaD2w+DkjpPP6gzPWZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=qLC0lpHO; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8C1A688009;
	Mon,  4 Nov 2024 13:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730722447;
	bh=RbP1054GvB61ShZBZGNpCOGJO/HAU6VHlS0FG1xGG0A=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=qLC0lpHOOnxdRkOo5dIwmh7FkzUTx9YtUI0K20NQztK0/8Tya5E8u72eVkyvUTZ7W
	 6ovz0aHu+/wYLWi0sGjxS1vkgXVJEqqXxXf5ICT1gE7TSA7/uP/9HnDmPwmfOGFgY3
	 +GKuzictb8S/hH+P9XIbqFmk9JqKyErArIlfAop/DWLidTIpAFSwX7kJj02OvT0J6n
	 wiyJtpajcYul4Z6Ztgu3tsczv65+/l4LLWsGwrbbthkIzuwowNAe9dcwFxmhUNe1HL
	 ddh2/eaco0gaRXXELDmONpKAw8r9E5AC4BN4eW3MVQZAKk8pHlngDimIfMYxPBA6W/
	 bf/nOgpplharA==
Message-ID: <16e5c8d7-64ac-424e-9430-b683ae16a34e@denx.de>
Date: Mon, 4 Nov 2024 12:44:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
From: Marek Vasut <marex@denx.de>
To: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
 linux-wireless@vger.kernel.org
Cc: davem@davemloft.net, adham.abozaeid@microchip.com,
 claudiu.beznea@tuxon.dev, conor+dt@kernel.org, edumazet@google.com,
 kuba@kernel.org, kvalo@kernel.org, krzk+dt@kernel.org, pabeni@redhat.com,
 robh@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20241022013855.284783-1-marex@denx.de>
 <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
 <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
 <a4c8c489-c6b9-4a38-84ab-f08409baccff@microchip.com>
 <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
 <880baad9-be3d-41b2-bea3-620f915ca397@microchip.com>
 <9d20b408-72a4-49f0-aca6-108dfdd65f99@denx.de>
Content-Language: en-US
In-Reply-To: <9d20b408-72a4-49f0-aca6-108dfdd65f99@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/23/24 8:47 PM, Marek Vasut wrote:

Hello again,

>> Is power-save enabled during the test. With PS enabled, The SDIO 
>> commands may
>> fail momentarily but it should recover.
> 
> It seems it gets enabled after first ifconfig up, that's a good hint, 
> I'll try to disable it and see if that makes them errors go away. Thanks!
> 
> Do you have any details on WHY would such sporadic errors occur and how 
> to make those go away even with PS enabled ?
Can you explain why does uAPSD (iw ...set power_save off) adversely 
affect SDIO bus stability ?

Can you explain how to prevent that or shall we disable uAPSD altogether ?

Thank you

