Return-Path: <linux-wireless+bounces-11094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A060294ADB9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F42A2820E1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227713A899;
	Wed,  7 Aug 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a2boA3KY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6D126F1E;
	Wed,  7 Aug 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046955; cv=none; b=KjEGIEnxu97y91W0lZMdLbL9hr3pqcFj9SMHbmusHho5wD79dhRv0hu/XvVIzvpCsC/S5hPMOizuKqn/uyYFvr2n+35mO5BxGAD/gYXD5UbZ0Y1IYGeS0/SnAJpMUEzF3Bs3cmbw5cPFDiy72U8saqv380+unjK16q31LGP02L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046955; c=relaxed/simple;
	bh=YA2ZuyFNRNxqyBRIOQWI6/ABTXBLPVPilssOyCvAofk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dfnBByU34cyojtmFdbLOIs4oXPgrB+tg+wT1/41VRoEjR5erFLfFHhg57PI7oEbUibRDdF/xM+Q5PHB9G1bkj821sQmje30bi3c9Pu9TaiQkI8TGEzKJEK8E4LE+qKryanv1wc24My8MBr77HQIIySJrEfKX5JmgUzRHbjQZLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a2boA3KY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477G95JY071948;
	Wed, 7 Aug 2024 11:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723046945;
	bh=jzPSemYePbBHFr/+nsxFkMDC+tdgXWS4uZbaeSlS+mQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=a2boA3KY/mGKS5/ZM3OendLtaEOet8Nx/703NuGD7QWvF3XD8R1XjdfBXq5m1JopM
	 dhh9O4e8gX5GU5360YSum2yzRaYDuwaQrYYHTKV9bi2ExDyIxum9UXn+FylkBjY/v/
	 j004mCliaSmt2+weLv9WRm9bqoXPOZ0lzxumRTTA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477G95NQ106351
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 11:09:05 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 11:09:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 11:09:05 -0500
Received: from [137.167.6.133] (lt5cg1094w5k.dhcp.ti.com [137.167.6.133])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477G92jj042671;
	Wed, 7 Aug 2024 11:09:02 -0500
Message-ID: <e91645a1-aa5e-49bc-915b-f1bf9805ef51@ti.com>
Date: Wed, 7 Aug 2024 19:09:01 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] wifi: cc33xx: Add acx.c, acx.h
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
References: <20240806170018.638585-1-michael.nemanov@ti.com>
 <20240806170018.638585-6-michael.nemanov@ti.com>
 <813f5d6b-eda8-46d6-b152-9e7cdf737729@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <813f5d6b-eda8-46d6-b152-9e7cdf737729@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/7/2024 10:15 AM, Krzysztof Kozlowski wrote:
> On 06/08/2024 19:00, Michael Nemanov wrote:
>> These file contain various WLAN-oriented APIs
>>
>> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
>> ---
>>   drivers/net/wireless/ti/cc33xx/acx.c | 1011 ++++++++++++++++++++++++++
>>   drivers/net/wireless/ti/cc33xx/acx.h |  835 +++++++++++++++++++++
>>   2 files changed, 1846 insertions(+)
>>   create mode 100644 drivers/net/wireless/ti/cc33xx/acx.c
>>   create mode 100644 drivers/net/wireless/ti/cc33xx/acx.h
>>
>> diff --git a/drivers/net/wireless/ti/cc33xx/acx.c b/drivers/net/wireless/ti/cc33xx/acx.c
>> new file mode 100644
>> index 000000000000..3c9b590e69b1
>> --- /dev/null
>> +++ b/drivers/net/wireless/ti/cc33xx/acx.c
>> @@ -0,0 +1,1011 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +#include "acx.h"
>> +
>> +int cc33xx_acx_clear_statistics(struct cc33xx *cc)
>> +{
>> +	struct acx_header *acx;
>> +	int ret = 0;
>> +
>> +	cc33xx_debug(DEBUG_ACX, "acx clear statistics");
> 
> So you just re-implemented tracing.
> 
> No, I asked to drop such silly entry/exit messages because you duplicate
> existing mechanisms in the kernel.
> 
> That's a no everywhere. Do not write such code. You can have useful
> debug statements when tracing or kprobes or whatever you want is not
> sufficient.
> 
> Best regards,
> Krzysztof
> 

OK, I misunderstood the previous exchange with you and Kalle Valo. I'll 
remove all entry / exit cc33xx_debug traces. Non-trivial ones are OK 
tough, right?

Thanks and regards,
Michael.


