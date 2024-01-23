Return-Path: <linux-wireless+bounces-2367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD8838A14
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 10:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882691F236F8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF265811B;
	Tue, 23 Jan 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LwwI/79S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECF58114
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001418; cv=none; b=EX6u5PZBL2F7NO3WyEbkETRAByR16Yp82qPNeJWKcdB2yGSHpncIUAbhSqPcI0KnbhRBJgUcOQtHhEzPJo1gt4UHsAgS34ZcUwxxokoUwltk9KkBadkMHA9BF48h3ZmhpYQZJnlO29KW02BYIesb4Ft3wWH21RFKYKWfM8TjNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001418; c=relaxed/simple;
	bh=GJwrt+CpYt4HvLTBGrxB/OyCOUO8xbC+KyUJGUwgyaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0S6pulGIbGM6u3+oOTp6HHMZDw0YF8JqoqT0F+A4vQdMrOVkuFoM6rZu+AmKxPI6pvvPKDZ+QpapKK7U2wV0m971CIJLGMsK36yMU1WIdiV3F5tSxH/g6PXAr7k/vVApLemHA/WOTWTJZ2XXNvdREZuA9Zu7Tcn8Ps+VMZtv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LwwI/79S; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FF901C0016;
	Tue, 23 Jan 2024 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706001408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAcGs0815Z35se73LKBQpmloBXobAehZ79Q1JvTFjjc=;
	b=LwwI/79SfT8pDizynDfcLTP1y4WNqWDwR7xlfr6kEdS3XeieccmguM85+PUxF2HK/FE+F5
	zjbGwJbQH8riWwKiZI/DnQOYx9WWfImv8F7Sfq95GEmNsEhTtNM4hClaa0G5L2GY4F/Aar
	2u2zFT4bgLJC4x7Wuo9SIl4C6qVRIPT8P5sr/HSG4THTsx/l4+wSU/OtQZg0e6ETgAeLih
	jSABIoxfDheXVRa4Rlu8bLvgkxlodjPlDGMhNU/lav7jNzBsjtnxzkR8jUj0ZeUDhE5cHt
	0IqUkxpHeCOyC7PCcSu+Fd2KfwtauPTJoHP1x1Ez3WGZINLHt81m0INMjA1OaQ==
Message-ID: <7615dcfe-4363-4d00-aac0-510c279f6b96@bootlin.com>
Date: Tue, 23 Jan 2024 10:16:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
Content-Language: en-US
To: David Mosberger-Tang <davidm@egauge.net>, Ajay.Kathat@microchip.com
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
 <e17d654a-8bd5-4327-8bf2-ad81c2f7355b@bootlin.com>
 <5ff15ae65ccb7c144ba8e0f07dc2ac25bd8b2b42.camel@egauge.net>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <5ff15ae65ccb7c144ba8e0f07dc2ac25bd8b2b42.camel@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello David,
just reacting to your answers, but I will take a look at your updated patch

On 1/22/24 21:41, David Mosberger-Tang wrote:
> Alexis,
> 
> Thanks for your feedback!
> 
> On Mon, 2024-01-22 at 15:19 +0100, Alexis Lothoré wrote:
>> Hello,
>>
>> On 1/19/24 22:51, David Mosberger-Tang wrote:

[...]

>>> + if (ret) {
>>> + ret = -ENODEV;
>>
>> I would keep wilc_spi_configure_bus_protocol original error instead of
>> rewriting/forcing it to -ENODEV here. I mean, if something fails in
>> wilc_spi_configure_bus_protocol but not right at the first attempt to
>> communicate with the chip, it does not translate automatically to an absence of
>> chip, right ?
> 
> Hmmh, I'm happy to change it, but, as it happens, all failure returns in
> wilc_spi_configure_bus_protocol() basically mean that the device isn't present
> or a device is present which the driver doesn't support, so I think -ENODEV is
> more useful than returning -EINVAL (as would be the case).  Let me know if you
> still think I should change it.

Yeah, but then I would change wilc_spi_configure_bus_protocol() to return
-ENODEV instead of -EINVAL, if that's really the cause, and just let calling
functions propagate it. That may just be a personal taste, but I find it pretty
tedious to debug some error code and eventually realize that some intermediate
function just rewrote the real error to another one (and sometime, loosing some
info while doing so).

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


