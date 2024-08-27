Return-Path: <linux-wireless+bounces-12084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AAF96146B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059F71C23605
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28EC1CF2B3;
	Tue, 27 Aug 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="P5q6WqFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EB1CCEFE;
	Tue, 27 Aug 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776966; cv=none; b=DUX5TkjROn6hN9YqJ/ReHuhFJJzQTOdJLuNmnmyS+zpiyRQRmyqKWl0b5boxrfIak0sjiqyQ39qcWmktKDjYInv0jkwhX2NQSwI3N4NdEAafc3CXqJy5C0wc5SiNo5Ux7d8mEY8muzEfq9gAulFnOSrW0nzwJOxNxVuMapRQORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776966; c=relaxed/simple;
	bh=DmxjFhnAHK+VWjm0356yo6E5Yi51ofS0JYRn6zjFSFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ju+PFLpNN3yuFukbNJd6VjOfH1FVLxhHVrHGG+h+HDeQnRdJMn3OPps3W0tVMz/ovwQJLTq7TwVZlNJSYEMOFgwgBWvnV8t6LcpZ8SxUYvJVGEuTOWaSkD3g5qnFu/7J0sXTMrnq+9L6krvi+lhevQ7eEcUHZ8CNMoKPpm7kVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=P5q6WqFz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 657FC8897C;
	Tue, 27 Aug 2024 18:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724776963;
	bh=Xp4MUtvj4s/OszPG6oxIpWEWZX/+92XaG1xSPN7hUAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P5q6WqFz1Iv4ZOqHZBssbxtTol9mJ05pkqpf5A0BcUkf4LxBOaJ/2aVqjaUUwATKv
	 QRnYKh7QDkzolzCZkQ87VYBv0ny79uSm0+SCEqefdB4q7cDw5qg6/PKettChPlglgr
	 RSnJ4woswr6W0G97cf6kzBDpZ8deO62w2vjdFD7O10ME4TQesLX3MB3Nv1EJb7ERVj
	 UjPOc1BKh4yzrN/8X9BHs2h+EaFCBJdF34lAG678L/AtdygEjbR1AxDJBltbkx1ZAk
	 PsH/IY9JMqu9j35izdYoKr2qnX9nWuqFzmIhGP52xd/TXIvV3KFv8Dw5VZYQXHam18
	 T8mnCIoavc4Ig==
Message-ID: <182e449a-3e6d-4727-a538-6fd518ae75f8@denx.de>
Date: Tue, 27 Aug 2024 17:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
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
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-2-marex@denx.de>
 <2b167618-473a-4da1-9c10-cba2b9051381@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2b167618-473a-4da1-9c10-cba2b9051381@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/27/24 9:51 AM, Alexis Lothoré wrote:

Hi,

>> +static u32 wilc_get_chipid(struct wilc *wilc)
>> +{
>> +	u32 chipid = 0;
>> +	u32 rfrevid = 0;
>> +
>> +	if (wilc->chipid == 0) {
>> +		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
> If we search for WILC_CHIPID in the whole driver, there are still two places
> manually reading this register. Shouldn't those places also benefit from
> wilc_get_chipid ?

Both the one in wilc_wlan_start() and wilc_validate_chipid() look more 
like some sort of communication check attempt, rather than reading out 
the chipid for any sort of actual chip identification purpose. I could 
simply remove those ?

>> +		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
>> +					     &rfrevid);
>> +		if (!is_wilc1000(chipid)) {
>> +			wilc->chipid = 0;
> 
> While at it, since you have trimmed the update parameter, it would be nice to
> also fix this return value (ie make wilc_getchipid() not return 0 but a real
> error code if we can not read the chip id.

Fixed in V3, thanks .

