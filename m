Return-Path: <linux-wireless+bounces-13468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C09698EE1B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4F11F224BC
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69AB15443C;
	Thu,  3 Oct 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Jg5Ewxh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E71422C7;
	Thu,  3 Oct 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954812; cv=none; b=YwJS8kWhF+fBdeGWFEXLI1Uw5rqO417ycrl+D4hqJSy4eg6s5Bfznneg84zCMyPO28tDQ+YZS7j0K9pb8axreeoN2hyPJjlAtf6GR5lozLifcUD0x8zrCl8PWc8UJtQ5EnVf+uap0VJ3StsIKNkh5lDzFEwojORRZQ/XFOScRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954812; c=relaxed/simple;
	bh=rN9Zk9w9vv9JH5KnlhikBpMgWnfALmbWAJGtOo+igPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZtT2XjJnozUY1wfEoIpu8Su85h2bAzRvgdVBkof2ivCRJ9k0us5iuVvEdhlUydoLa5ZtrlPaQ8K0ogXqxYsWNjwvEQE+f839+Uf8QVdvHgvAvsjNX6h3ybfPm3z9wnYeQ/8hnY4WFTUyYKQgiMTsIzVjUTsRKK3Gd8bGqLUzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Jg5Ewxh7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 748F987D1A;
	Thu,  3 Oct 2024 13:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727954809;
	bh=WRdq9PlcnZEO2EkMXzr9LcjVOsNChJ3R0PfyR+Qmyfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jg5Ewxh7pBE9lV78Pi3HntPjPVRoEeF2yxp7Oh5pdjgPApbKFmJIM/K6M586t+KQQ
	 yN1RUlP+5op2CKdTsXhOKMBgXE3ecuwRZd5q35I4NTTWADxMJtc2MlmDNKpoiRXodr
	 qWoVQYPnzSm0EQk5Kc2dl1835i951yTexKtjqQQeyuJACwMuwtNogQqa0ZEI6L6pVp
	 XWv9bUNUnTnMY6wER1eGb2nrxZy5npLImVgVGhjaCMt8uII2aiFs/RcTWBoqIgbynK
	 mYjwUIxJD0d0OXZjUc8BTza9+W+BMqNtIp9PcRyS2vx7E8Ae84Q88pYnSnzsFUWd/s
	 uMo5jb+bi95Hw==
Message-ID: <1a372dbb-2349-456b-8fa6-4d6884607d36@denx.de>
Date: Thu, 3 Oct 2024 13:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
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
References: <20240926195700.2823751-1-marex@denx.de>
 <20240926195700.2823751-2-marex@denx.de>
 <0321fc03-e1ea-4012-82a3-fcdc6f3b18eb@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0321fc03-e1ea-4012-82a3-fcdc6f3b18eb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/3/24 10:04 AM, Alexis Lothoré wrote:
> Hello Marek,

Hi,

> On 9/26/24 21:55, Marek Vasut wrote:
>> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
>> wilc_get_chipid() right after the SDIO/SPI interface has been
>> initialized to cache the device chipid, and then use the cached
>> chipid throughout the driver. Make wilc_get_chipid() return a
>> proper return value instead of a chipid.
> 
> This new update now makes the commit message wrong, wilc_get_chipid is used in
> files other than wlan.c (and this change goal is now rather to get the chip id
> early enough to register wiphy with correct info)
> 
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> With the point above fixed:
> 
> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Fixed in V7, thanks !

