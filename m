Return-Path: <linux-wireless+bounces-12750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BBE9732BA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B685B295E9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C619580B;
	Tue, 10 Sep 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="x8cpIvU4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD8194C6A;
	Tue, 10 Sep 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963522; cv=none; b=FrfaiLqA6fE8GfimMDrTZ7ziblr0PNtcBZeJOy+digobIj5DfD1KwsY/PRleHi9IG1efqDHnBrzc6IiyHsA4gY8dCpt4EyanKqqX9lZu47ISzFzMvLW2qHDc7Kcq83YIyKWnwk+mF3dQkE8GfLPtAxkNC6v4fS1XPLRNivI4eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963522; c=relaxed/simple;
	bh=4ppkzx0iEJWvQLnOf9+XCRDybkyCpUpSefyWUiSgBE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0TS0cSZDpCdrBC+DtxHMSfnwtT6aukqaXL7bjRYK/ldudS8fwpD5YLLQmlD4f/Yf6n2uzEVwDazNfRXjy/G5pOkI7qb0jCGLSBosa0t6zw0HpvlytHj1d+sk7g706Q+ZqATypTRaQZnP8x5LVugKJZLXcPP/1CXwWpZo4EjxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=x8cpIvU4; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E79E088F6E;
	Tue, 10 Sep 2024 12:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725963513;
	bh=Oh//qcvTpCKv5tXHZ5DrqUB4403UgPCbNs5V8TgEIv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x8cpIvU4YOoFGzJlLJAJSmRkjpzFqyQcusi3N7ixJZpsZi7oZRcnj5AWE6YpKEW6G
	 8Eq4K8qi9U2yEVeHHiCbisZDNe9+rqjw4saF6Y5svBATxwFCB3qwamm65hN5i6DmMb
	 +XsRCEDjK0dGjKH/zfivJPkvbXfttntbRg84BZLuPN7LLHKEv87WB5sGuQcohSi11o
	 fQxwBRHTAh4/X0AzsRJtPAnlgYXt4CT0vjHYoLNkQ9zJ7hQzGFEwBgkFE4kiLyv8B8
	 F9WF4Q18Agx08o9EL1kgF1eA801xLeMreq1+ksSzVEFpk1K6R2jXjlnSPToSH6AFAx
	 WxPjglKq7/goQ==
Message-ID: <9ecd8ee8-0e7f-4364-aa62-cedd987295f0@denx.de>
Date: Tue, 10 Sep 2024 11:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] wifi: wilc1000: Get chipid early
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
References: <20240909193035.69823-1-marex@denx.de>
 <20240909193035.69823-7-marex@denx.de>
 <bf78598f-15e8-4deb-9230-5f4727197167@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <bf78598f-15e8-4deb-9230-5f4727197167@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 11:01 AM, Alexis Lothoré wrote:
> Hello Marek,

Hi,

> On 9/9/24 21:29, Marek Vasut wrote:
>> Export wilc_get_chipid() again and call it in driver probe to get
>> wilc->chipid assigned early on. This is necessary to discern WILC
>> 1000 from 3000 to disable WPA3/SAE on the later.
> 
> I like the general change (reading chipid early enough so we can enable/disable
> NL80211_FEATURE_SAE accordingly before wiphy_register), but then there is no
> point in making wilc_get_chipid private in wlan.c in patch 2, to make it public
> to the module again in patch 7.
I was worried squashing it into 2/9 would be messy, but apparently not, 
so squashed into 2/9 for V6.

