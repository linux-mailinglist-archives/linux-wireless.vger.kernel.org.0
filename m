Return-Path: <linux-wireless+bounces-12196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9AF9637A7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 03:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9991EB20BD7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E3D51E;
	Thu, 29 Aug 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Kzu845Qd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142F1798C;
	Thu, 29 Aug 2024 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894661; cv=none; b=df9Bqy18sjlwa1GAZv24jhs/mesbC5+u/2bBipwyCCCb/Gma1jxxUy4CHxLdVa/g4lJOLJAC3HENoq6S0Nbm1gjJeX+reI1Z/16a4OTLyZz/Oce7yZOYO7uS5zlh1xc6XixhHdF7Xxd/A8WbtPxcEuNWFIiywNcqY7CD+qkDFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894661; c=relaxed/simple;
	bh=nId9wh17NcsFbj4kMb3/qQ4e+x93TtvBDX89dEhDA98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0KyEg/8jVokNuNUI9dHPcgnLmAc7EL5NarLSSQvPENAysyamBcw0p/swlorfuaVS8GFadAwrHRNRz+e0TyDtjToyERuWIxkH2TefavIyn8uNYbCjVQd1mfkrMKXwrVkdZmUqGIKT0BepRVMx4EXgSpDY+kTS9LbBNYTQZCIHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Kzu845Qd; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2700888A43;
	Thu, 29 Aug 2024 03:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724894658;
	bh=oVFjNTxYTPIhEzBWKMmNe2XOXfD74nH2C86buWR8J+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kzu845Qd+nAiB4XF1lWl+4mV6XMgct53R0xrwesU8aZsJ9HdzVpi6d1GovllzVPT8
	 xV5xfF0J7FB8Jqcmz4WGjF80SbR9fb9qr9JqOlAUyudRp8MzoIxS050/4qMpg0e6fb
	 +Z9iAJD49cwsHKcGN7xCKjCwqTMGBJ/7DZnARI7x0Lo0U0vO+HpVUccwb8LLeZPfcP
	 BSTS5Zx2DlSm6JpZrnOa1DD5seC1SpXS6t2enkCvht+PCswv7xJlIADLXSacMVK+vL
	 qQrf5qu/LlrJ+y7JYH9hzSF9HZVOIIpgNoaYCaLx9P41ferkeroJSOFSsLPHKYo3A2
	 mIsGb1uENj1vg==
Message-ID: <041331c0-0ab0-473c-a8c4-89fe8e55ae6f@denx.de>
Date: Thu, 29 Aug 2024 02:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
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
 <20240827164042.53698-2-marex@denx.de>
 <e2130ebe-1c17-412a-a8ca-ac7c1f5b5bb4@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <e2130ebe-1c17-412a-a8ca-ac7c1f5b5bb4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/28/24 10:39 AM, Alexis Lothoré wrote:
> On 8/27/24 18:37, Marek Vasut wrote:
>> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
>> wilc_get_chipid() right after the SDIO/SPI interface has been
>> initialized to cache the device chipid, and then use the cached
>> chipid throughout the driver. Make wilc_get_chipid() static and
>> remove its prototype from wlan.h . Make wilc_get_chipid() return
>> a proper return value instead of a chipid.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-wireless@vger.kernel.org
>> Cc: netdev@vger.kernel.org
> 
> nit: The remaining wilc_getchipid() call in netdev.c should have been removed in
> this very same commit (it is removed in a later patch in this series, but it
> makes this commit depend on the last one).
> 
> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Fixed in V4, thanks.

