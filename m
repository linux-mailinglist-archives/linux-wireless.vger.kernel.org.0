Return-Path: <linux-wireless+bounces-11091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A8394AD5E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 17:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C931F22E43
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1E12C46F;
	Wed,  7 Aug 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CXsiJ7qa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DD84D0F;
	Wed,  7 Aug 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045915; cv=none; b=GjIu8AN6svu6SXppv/FynxvhXBqbCcfPMHiATYgcx6hP6mB1baHW3IANRiT/qGfsrP0EDyWsO47QulOvHN45tpKT3FdnXdQO0SSJY/E3iywXZ4mXWHzwdyhsZGIVBsUqgnH0fMXKoxZ/L4+95QAawdFpcuqwf+uagMHjytPhqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045915; c=relaxed/simple;
	bh=tq1kRIdkXXLmifGbrLj+K4OAlODh+bgQQ+deN5tg44o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K9qNOd4ClkocHc6fOo5RpNNYIJ/EVQWSvs5vto5NmI5C1hZtI0WORL18D6RZqUmcO1A3HjuqGEeTZCCtFoeHk+uCkI7lWIp58qqJ6Xw/nm4i1EFnoyMD3H/CmoO8Nmrw6jcYx7SLFd0UsYuTBjxqQUmlqqmX2w2MBsSAhV+i7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CXsiJ7qa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477Fpjg1114243;
	Wed, 7 Aug 2024 10:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723045906;
	bh=DFX4wIOpKaPspxP+zUbhiDATcnb9TKhja6y4k+FVRpc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CXsiJ7qaH+snf61hYdI72XYDQStBnZp5ZuQHwOJftzULiSWhDw7DOIQUFQxwiGlZj
	 Af3dvHvbxJhaxTqiJNxrXhxhFLu2PcJY6v1NYd9GKx3eQZoCLYCcm4l55I8gW0Udp+
	 j8GUB4pFq+eFbavXrLKx+vLMmQ0GjIDGZZ2H9nWQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477Fpjcd097114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 10:51:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 10:51:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 10:51:45 -0500
Received: from [137.167.6.133] (lt5cg1094w5k.dhcp.ti.com [137.167.6.133])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477Fpg4I014276;
	Wed, 7 Aug 2024 10:51:42 -0500
Message-ID: <0da6f8ce-e220-47b9-86dd-537ad4b328e5@ti.com>
Date: Wed, 7 Aug 2024 18:51:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
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
 <20240806170018.638585-18-michael.nemanov@ti.com>
 <40031203-63c6-46b5-b647-d344d4503bb7@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <40031203-63c6-46b5-b647-d344d4503bb7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/7/2024 10:06 AM, Krzysztof Kozlowski wrote:
> On 06/08/2024 19:00, Michael Nemanov wrote:
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,cc3300
>> +      - ti,cc3301
>> +      - ti,cc3350
>> +      - ti,cc3351
>> +
>> +  reg:
>> +    description:
>> +      must be set to 2
> 
> Then just const: 2 and drop free form text.
> 
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description:
>> +      The out-of-band interrupt line.
>> +      Can be IRQ_TYPE_EDGE_RISING or IRQ_TYPE_LEVEL_HIGH.
>> +      If property is omitted, SDIO in-band IRQ will be used.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    // SDIO example:
> 
> Drop, obvious.
> 
>> +    mmc {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        wifi@1{
> 
> Missing space.
> 
> Also, this does not match reg. Test your DTS with W=1 and FIX ALL warnings.
> 
> Best regards,
> Krzysztof
> 

Will fix all above.

I'm currently testing my .yaml with:
make dt_binding_check DT_CHECKER_FLAGS=-m \ 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml

It reports no warnings. Adding W=1 doesn't seem to change anything. Am I 
missing something?

Thanks and regards,
Michael.

