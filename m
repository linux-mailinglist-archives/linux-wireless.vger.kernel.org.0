Return-Path: <linux-wireless+bounces-14847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB21A9BA59E
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121CFB20AB6
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB01EB5B;
	Sun,  3 Nov 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XvTavTnB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24745BA42;
	Sun,  3 Nov 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730640846; cv=none; b=HS9q5UJM4U1Z3ZwrAEGh0nv1jO6DshNsWxp4dgmbaXZyDSJbGOMoYS3bwoabZU/CTlamPshGNsVZG03Yoywt/793ceJCynhdukJFFxObje6yFrTe/rIf/UlWGQ6esEIy0y9LD1RKb03z8gj2SCshEIP2ckivpM5DcMbHDrXpGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730640846; c=relaxed/simple;
	bh=I54X4peSj3IPI/qOlSKztxqhq18cLbGg5nqbNKX7vzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jCe1YBjvqpuvypCtMnGoF3ETs7eWvds7o+PZg9sV9x/O9BfCKsHOPKRFm2jRJXnMyMdJtiDpSJuhXkGpXxB8sj9tsutFNYeSV5SWbAQhMC28iFQ0rtO/l+d9PFETlIpNXs1DRKgP1+8wQ59iKFZI4bDsBjc4hbv41AYja/Y2WFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XvTavTnB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A3DXuYP086682;
	Sun, 3 Nov 2024 07:33:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730640836;
	bh=gmVA7vfrv9fk4q4SW8yK7cB8cAzdiQdnrMLsiuJ7YAg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XvTavTnB/edNGzlRMsUNVETDEG9heYT8AVt2uGxN/waty3GlDk6Q6U+sVWghm8NVm
	 0zVtYroyGrayIwUgJJWXPOMmHY39nPqbCDd7v0z5cCA6xsBVJNJ7Gia57M1iBcAwPr
	 W+zZh5TftXd1gdJHmaI8Di1LFokoQvi/za16rUq0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A3DXuKx103426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 3 Nov 2024 07:33:56 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 07:33:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 07:33:55 -0600
Received: from [10.250.202.81] ([10.250.202.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A3DXqIa032298;
	Sun, 3 Nov 2024 07:33:53 -0600
Message-ID: <e2c01b4b-769e-4409-a8e7-90792b2ce2a1@ti.com>
Date: Sun, 3 Nov 2024 15:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] wifi: cc33xx: Add sdio.c, io.c, io.h
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
 <20241029172354.4027886-5-michael.nemanov@ti.com>
 <9aff2bed-bca4-482b-83ea-4cd945812817@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <9aff2bed-bca4-482b-83ea-4cd945812817@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/29/2024 7:34 PM, Krzysztof Kozlowski wrote:

...

>> +
>> +void cc33xx_disable_interrupts_nosync(struct cc33xx *cc)
>> +{
>> +	cc->if_ops->disable_irq(cc->dev);
>> +}
>> +
>> +void cc33xx_irq(void *cookie);
> 
> Why do you need forward declaration of non-static function? If you need
> it, it means you had W=1 warning which you fixed incorrect way.
> 
> Regardless, be sure this code has 0 warnings on clang with W=1.
> 

Indeed a refactoring leftover (already moved to a header file) will fix.

...

>> +
>> +static struct sdio_driver cc33xx_sdio_driver = {
>> +	.name		= "cc33xx_sdio",
>> +	.id_table	= cc33xx_devices,
>> +	.probe		= sdio_cc33xx_probe,
>> +	.remove		= sdio_cc33xx_remove,
>> +#ifdef CONFIG_PM
>> +	.drv = {
>> +		.pm = &cc33xx_sdio_pm_ops,
>> +	},
>> +#endif /* CONFIG_PM */
>> +};
>> +
>> +MODULE_DEVICE_TABLE(sdio, cc33xx_devices);
> 
> This is always next to the table.
> 

Will fix.

Regards,
Michael.


