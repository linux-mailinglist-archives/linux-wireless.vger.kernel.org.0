Return-Path: <linux-wireless+bounces-12146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAA9622C7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B71286C4F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14C1607AC;
	Wed, 28 Aug 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pI/IV7//"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7C15E5B7;
	Wed, 28 Aug 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835034; cv=none; b=N6I2X2TkrOx8ek3uZGz+FF9bBf/XwWC0uJdLyd2m8U//UQ+MwfpmXu+yy0elvifzvhUee3rPnoCBBGdbvmbiOZzDouLZIqsOodXLNDYSR8VCsaAlm2Q2W3G6i3UUWIdt13GUUVdqpSbGF5A/IMaA8+pbB9fy0B0ufLys+FfHDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835034; c=relaxed/simple;
	bh=IQ+8b6ezJHQknQ+4JKSeRiRsQwuKp0tKlK4ZBgpIXjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+R6Gqx/LFNzL73i8ywBbT1ssAbiU1tjW6nPPDDAlAeOw6YxYrqYQpK4G1PKbrNY0jstQAz7lMZ1Wt5YSF9wCJlWu0BOT6LfqjyhleGcF9tn02BTIJIJJg6RwG/0rnrIFPPuJ54X4q2f5lIXm/X0TQJOLJ1ldl8dnj6i3omtRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pI/IV7//; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05E0A24000D;
	Wed, 28 Aug 2024 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724835029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEsEUXDUXUejO/Je6E+NCRRmChvWVykVcGk2OFYncmU=;
	b=pI/IV7//hsNshLXrSCUJSCwoPe55ouJt5dt9e9Q81WrPAPJKFdsOdjuhTEkcFxDF0LZRoE
	nv4RPohhJ4htaWM4SbKNy2oW5Nw6zfH+hmc4tJMiNpKm1Oc+wyzemeA3spBrfmxysWSSYf
	3AX8OPCXcmx1t5uJmHJnabZIUBsllOD8DDusyky3RBpSgwdvuR+NAqzIBAVsw8sv8SkDPi
	4sckv/sJiUepYJEUAfqVx4Pa8RH8uOIb5zmBkyHBedmusD1It03mAnD7oLh7hrTZ0EaiMc
	XH1JV/kW+WaWZ9y4d2sg8RSO9x76pKDscrMRrOOtb7JJxjo9zCf2Vzfv5W0zaQ==
Message-ID: <8082fffa-28b0-4d50-ac4e-e053649696c5@bootlin.com>
Date: Wed, 28 Aug 2024 10:50:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] wifi: wilc1000: Fold
 chip_allow_sleep()/chip_wakeup() into wlan.c
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240827164042.53698-1-marex@denx.de>
 <20240827164042.53698-3-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240827164042.53698-3-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/27/24 18:37, Marek Vasut wrote:
> Neither chip_allow_sleep()/chip_wakeup() is used outside of wlan.c .
> Make both functions static and remove both the exported symbol and
> entries from wlan.h .
> 
> Make chip_allow_sleep() return error code in preparation for the
> follow up patches.
> 
> Move acquire_bus() and release_bus() to avoid forward declaration
> of chip_allow_sleep()/chip_wakeup().
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


