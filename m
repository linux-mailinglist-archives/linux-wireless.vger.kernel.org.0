Return-Path: <linux-wireless+bounces-11090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80094AAC5
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 16:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0391C21535
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E080638;
	Wed,  7 Aug 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AvbZIWhZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BB3EA9A;
	Wed,  7 Aug 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042529; cv=none; b=Odpo28MJiWbypRqirOvwDHu5O19ZfrJ4Ptade70GFCBYDHTADTr/xVae8dOf7Zyz05kEPcPYU7yDV7ygoMUCDy2koSzG9osJupLT2itL174tOThFabUMPyvpNApcy1vhFgSldvGdAJXbHaeY/NG8Lm6DGarL9WXBGCXF2FqEd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042529; c=relaxed/simple;
	bh=Y6bjRDCBCO5kBeL3l6MJlOzYWzvB7zZ6CXPmw2/LDt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mg2lB2arypcYO07/xIkHgai7h9OGPT7svKgAHCMLy79KRuIVt491kX5hzEyaqVKUedJ6lXX88gygZFw8U1EXlHjZzIHf4pPwx9X2RidAhyc61vR1YJWVl8qdNqXryMSRrsDoOUeb3nGBppB2MXpLN7GxHRwoY8x4YRFH3bTAQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AvbZIWhZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477EtKBO039766;
	Wed, 7 Aug 2024 09:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723042520;
	bh=f34AOrvZhL2gScq8E1BslSWfE+Ba56tXOrZSmR99RYM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AvbZIWhZxuXhlgNqpp2hwKv90M5e8Jil9AQojvKQWgOmaSb3IiZe5kXN4Aa6ZaQsn
	 T1jGFh87m+v002WNVZBtXjeQWzcXeumsxjn+V5ZEDF5XJXb0O3wlbtsZkPpt+ApVwj
	 PghWnxbqlmaEbk1q1IGVdcM/SO1YdbJl1t5PmRkg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477EtKuN061439
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 09:55:20 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 09:55:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 09:55:19 -0500
Received: from [137.167.6.133] (lt5cg1094w5k.dhcp.ti.com [137.167.6.133])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477EtGqZ022066;
	Wed, 7 Aug 2024 09:55:17 -0500
Message-ID: <68d0852a-2390-4fe4-be16-3f691e99bd86@ti.com>
Date: Wed, 7 Aug 2024 17:55:16 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] wifi: cc33xx: Add sdio.c, io.c, io.h
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
 <20240806170018.638585-4-michael.nemanov@ti.com>
 <5020193f-64f5-48ff-8597-8e6a5ca0fb36@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <5020193f-64f5-48ff-8597-8e6a5ca0fb36@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/7/2024 10:12 AM, Krzysztof Kozlowski wrote:



>> +static const struct of_device_id cc33xx_sdio_of_match_table[] = {
>> +	{ .compatible = "ti,cc3300", .data = &cc33xx_data },
>> +	{ .compatible = "ti,cc3301", .data = &cc33xx_data },
>> +	{ .compatible = "ti,cc3350", .data = &cc33xx_data },
>> +	{ .compatible = "ti,cc3351", .data = &cc33xx_data },
>> +	{ }
>> +};
> 
> 
> Eh? What happened here? So devices are compatibles thus make them
> compatible in the bindings.
> 

I thought this is the right way to do it (originally taken from [1]).
How can I solve it via DT bindings?

> 
>> +
>> +module_param(dump, bool, 0600);
>> +MODULE_PARM_DESC(dump, "Enable sdio read/write dumps.");
> 
> This should be rather debug interface, not module param.
> 

Meaning debugFS?

Thanks and regards,
Michael.


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ti/wlcore/sdio.c#n204

