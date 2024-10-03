Return-Path: <linux-wireless+bounces-13482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1098F623
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 20:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBB8282062
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 18:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925D6A8D2;
	Thu,  3 Oct 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ODZymaUY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FDBA41;
	Thu,  3 Oct 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980295; cv=none; b=s7tJzzscR2Cql3yS5qKuN6zHKc9ZBhTAaT/lWD50loU8esfPcBChOFJkIWvVxBVCOofZxLf82DY6MPZWyQnAcohT/8Bt6EWEnqBHHqYhHQT0cPVY8bzf1LrOb4Gx/zkYOcGCV/RaAsUbrbC1J32bfyRNp/ypu4FjgoqKPQ34TpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980295; c=relaxed/simple;
	bh=fYj3RyO1TCC1UywFyFsk8unCFvaNs309HO7H33lQWmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo1e9rHatdoMe9P/nVXkIcgy4eSVvvNpgqKHo41eHXxE38X210lnoXgE6XdOcoU33AkIwnV5oPLLmkjpdPOGBdSpookqj+m2+blha9BpXZn9Qz+k597S6DDRKsKDKGxUi4sWEtFxZ6D1fJiCZ3jHkdpIOZ3GYz1Aa5zCuTkUCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ODZymaUY; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 835CB88EA7;
	Thu,  3 Oct 2024 20:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727980291;
	bh=urWCAcPRU+WZu8zm+Uk5s33cemx3OGm+bIgFrNOe5yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ODZymaUYrjwkQe3Y1Yt/wD05BRSM45RrLmdRmMz64X2/xXhBbSz2nKY5UBtAinG2Q
	 CTbdaXqp2BHjnRjJ+Y1GBhNT0zM/VvuBwhogycyBboXsF/otKnePDdNhwlPyIv2xhD
	 aOIFxM5MJPkqxROb/04XWeKczk8A0ftd58uaX3cQ59WaekEuC2rU6nce4QWtCgsGmD
	 XnSCLso/QqdeERAS3tHQy7ftPX23g9Z23eWMfvcmjyQW3+gq2iA3kE5zda1LdcXvb2
	 Q0wY4nztQh0Ur9+KTq/IzoMO5idCF7e7U2s/u9C+UyNROyx7t7eEpo36SMvrQqybNV
	 59R8+PgZ8z3NA==
Message-ID: <2f3bb6ce-50aa-40d9-959f-10c8193acaba@denx.de>
Date: Thu, 3 Oct 2024 20:31:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] wifi: wilc1000: Clean up usage of
 wilc_get_chipid()
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
References: <20241003111529.41232-1-marex@denx.de>
 <20241003111529.41232-2-marex@denx.de>
 <2d9d4896-a81a-4393-8cf3-8e42b36aaae2@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2d9d4896-a81a-4393-8cf3-8e42b36aaae2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/3/24 7:33 PM, Alexis Lothoré wrote:
> On 10/3/24 13:14, Marek Vasut wrote:
>> Reduce the use of wilc_get_chipid(), use cached chip ID wherever
>> possible. Remove duplicated partial chip ID read implementations
>> from the driver. Update wilc_get_chipid() to always read the chip
>> ID out of the hardware and update the cached chip ID, and make it
>> return a proper return value instead of a chipid. Call wilc_get_chipid()
>> early to make the cached chip ID available to various sites using
>> is_wilc1000() to access the cached chip ID.
>>
>> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]
> 
>> +int wilc_get_chipid(struct wilc *wilc)
>> +{
>> +	u32 chipid = 0;
>> +	u32 rfrevid = 0;
>> +
>> +	if (wilc->chipid == 0) {
>> +		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
>> +		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
>> +					     &rfrevid);
>> +		if (!is_wilc1000(chipid)) {
>> +			wilc->chipid = 0;
>> +			return -EINVAL;
>> +		}
>> +		if (chipid == WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
>> +			if (rfrevid != 0x1)
>> +				chipid = WILC_1000_BASE_ID_2A_REV1;
>> +		} else if (chipid == WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
>> +			if (rfrevid == 0x4)
>> +				chipid = WILC_1000_BASE_ID_2B_REV1;
>> +			else if (rfrevid != 0x3)
>> +				chipid = WILC_1000_BASE_ID_2B_REV2;
>> +		}
>> +
>> +		wilc->chipid = chipid;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> My bad for not having spotted it in v6, but you are still missing an
> EXPORT_SYMBOL_GPL(wilc_get_chipid) here, making the build fail if wilc support
> is built as module:
> 
> ERROR: modpost: "wilc_get_chipid"
> [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko] undefined!
> ERROR: modpost: "wilc_get_chipid"
> [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: *** [/home/alexis/src/microchip/linux/Makefile:1878: modpost] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
Fixed in V8, thanks.

Before I send V8, can you have a look at the last two patches in this 
series? They need some RB/TB.

Thanks !

