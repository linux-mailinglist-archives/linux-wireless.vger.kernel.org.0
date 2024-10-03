Return-Path: <linux-wireless+bounces-13478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254198F335
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 17:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDC22824C7
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE017A5BE;
	Thu,  3 Oct 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="akr+QVN9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7AE13B280
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970697; cv=none; b=Mgy80/cI0I58f7DcAho2/RAwvKIjhckndVEWjtKpoGEziQfZUMs40aEvGmLaW9R14y4XaTTZY8rwAFEA5DvABWg7moRgP8tD0UFuONxfVEx6DHroO/5AoMPwpLFhWWoZAiBrpW0TEtKqZd8PdSS9hgANROn9WqEFF8p1ZjFHeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970697; c=relaxed/simple;
	bh=GOorHwNQd8WAtcpsQwO8eu97whI5W65gVWIJf4O30ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DC+7YiolmBKr1C18Jz3rW4lHanc6psyur2F+5mB2dS/R8AEVNag9gKxanhbsjGmBz1Tiwb1KxFAURBg2HsgaDEWIuve7PPr9NEq3lr18U/53r5HIe1DvlwqNjNdJsxNy2F4IQu4b1Ja/DCDggw2vJMliWOuMTwRbGGgAYFT6rkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=akr+QVN9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EF1340004;
	Thu,  3 Oct 2024 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727970693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xzudn7+CACukka0Qq+PGM4biVcK2oJvSAf/elaEcgI=;
	b=akr+QVN965ktP9KeUCn5PXzu5WV4SILvKvkN4jR/5chubCEewm0SDiUbGFlMJ6gBFxq2TU
	w2fzjbe/ttaxC2jf70gcD4iQ6eBQ1gNq0H3jbSNaoiQ8kxiIhGeWKGcinlOukV2yUsMkxR
	KLdALRvSbLpRotITm/ehkIL6OaIApTv40HAEQbLSGpkHBiscpdzzSv7HpCvKiQgvt0ZpYM
	TvGHspgt82FHOD2+nWYSDPXC0qwDXbEYg85pKh24PN4O7kb0NCXpULN8Ng0A6c992Gvlb6
	F/oiMKdUpQuMR7EdtotGol8774wI00IZlosUp0DvTkZ7gxmPbhIpbeeiy29uog==
Message-ID: <6f1d432d-dfe1-441c-a1ac-885ee4363b9c@bootlin.com>
Date: Thu, 3 Oct 2024 17:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
References: <20240926195113.2823392-1-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240926195113.2823392-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/26/24 21:50, Marek Vasut wrote:
> The WILC3000 can suspend and enter low power state. According to local
> measurements, the WILC3000 consumes the same amount of power if the slot
> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
> off. Use the former option, keep the WILC3000 powered up as that allows
> for things like WoWlan to work.
> 
> Note that this is tested on WILC3000 only, not on WILC1000 .

So I have tested this change on wilc1000 over sdio (after enabling
MMC_PM_KEEP_POWER capability on my sdmmc controller), and LGTM, system properly
enters and leave suspend, and on resume module is working (ie in sta mode, chip
properly reconnects to configured AP).

The only concern I still have is about existing user who currently do not
declare MMC_PM_KEEP_POWER cap correctly on their platform (as it was the case
for me, and as Ajay eventually raised in the first revision):
- they can currently enter system suspend (and yes, for at least some Atmel
platforms, wilc chip still works on resume because it is "accidentally" kept
powered on)
- after this change, they will fail to do so (because of the failing call to
sdio_set_host_pm_flags, which makes the whole suspend method fail)

But I guess the issue is rather on the sdio host controller description on those
platforms, which should always have the MMC_PM_KEEP_POWER cap set ? If so:

Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Tested-on: WILC1000SD 07 SDIO WILC_WIFI_FW_REL_16_1_2

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

