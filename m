Return-Path: <linux-wireless+bounces-15503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26BA9D254D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7173A1F2284C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DBA1CBE9B;
	Tue, 19 Nov 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YQzs/lkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A861CBEA2;
	Tue, 19 Nov 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018251; cv=none; b=PNCgx/x7jwWHlnBKUK9qjSwKodNMCcLVKF99IZZhBOlMQsTK228pyuQNxMiB+HlEu51mcnByxR1frHlcuHVQ3rBBThDcd7xGYPFr8T1PYrFkMg0hL2CiqKByVz59rgJFgua1Iy0925XUe7xUavqBod6krCyxJrU3t0sm2MdTUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018251; c=relaxed/simple;
	bh=05fpO7BzPwjbenkCrUKrYY+/DfO4tCIfVL4XejHfZ7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JJfh8EdEHEDEp/UEs+TmSLSe/NVqmtztF615JVAXCWrMI34ZjXW2tBJD9D0YQVfBmGzlM1WBacUKA1/4pK+qn4oAZhYgEV/M4C0/fvpjcQ+l8JE2zUsD6YQoccbIqFTXq1mlJdUWyT0zFOhlDdasMMergA/PWoC6eRxAOykB+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YQzs/lkE; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJCAYfB3872011
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 19 Nov 2024 06:10:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732018235;
	bh=FCGHGADOR/Gid+oabOsKGIdb9QgjKW0XNbA9D4BfNmI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YQzs/lkEaxGSCeq4kMeO7PahgeK6bOL41W2WYwflyX22ug7Ri0f/Cs8tziOBuD13I
	 5+TYBZ2BCHxq3o3Kqm/MGtwUpLgKndNe9RQoRS3ngdI/cwjc89JLba6J6cTaTylKJX
	 kG9TKC20J6Y0fu5atH7JqHImnUmIgXf6S36ahtWk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJCAYX4082124;
	Tue, 19 Nov 2024 06:10:34 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Nov 2024 06:10:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Nov 2024 06:10:34 -0600
Received: from [137.167.1.99] (lt5cg1094w5k.dhcp.ti.com [137.167.1.99] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJCAVFO122922;
	Tue, 19 Nov 2024 06:10:31 -0600
Message-ID: <1e84b675-a0a0-414c-9f42-45a958dc0724@ti.com>
Date: Tue, 19 Nov 2024 14:10:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sabeeh Khan
	<sabeeh-khan@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
 <20241107125209.1736277-2-michael.nemanov@ti.com>
 <y4ffzjekeccqg2tv7d54ilwbz3nhm4jkcq3fyg5tmpbupsqirn@dq3kjtwkllds>
 <2b0e95be-8192-416f-8655-631d6cecc336@ti.com>
 <1651f579-6f9b-4c98-b273-0d7de4e99478@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <1651f579-6f9b-4c98-b273-0d7de4e99478@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/19/2024 11:15 AM, Krzysztof Kozlowski wrote:
> On 12/11/2024 07:45, Nemanov, Michael wrote:
>> On 11/8/2024 2:02 PM, Krzysztof Kozlowski wrote:
>>> On Thu, Nov 07, 2024 at 02:51:53PM +0200, Michael Nemanov wrote:
>>>> Add device-tree bindings for the CC33xx family.
>>>>
>>>> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
>>>> ---
>>>>    .../bindings/net/wireless/ti,cc33xx.yaml      | 59 +++++++++++++++++++
>>>>    1 file changed, 59 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
>>>>
>>>
>>> <form letter>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my or other reviewer's previous comments were not fully
>>> addressed. Maybe the feedback got lost between the quotes, maybe you
>>> just forgot to apply it. Please go back to the previous discussion and
>>> either implement all requested changes or keep discussing them.
>>>
>>> Thank you.
>>> </form letter>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Are you referring to
>>
>>> diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
>>
>> ...
>>
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^wifi@2"
>>
>> ?
>>
>> If so, I replied here
>> https://lore.kernel.org/linux-wireless/8024aa1c-5bd1-40d8-b0c3-14b5fcd992e2@ti.com/#t
>> But if you don't think it's worthwhile I'll remove it.
> 
> I asked you to remove it. It's not correct, not needed, not beneficial
> at all. It is actually harmful because limits re-use. dtc already checks
> this.
> 
> Best regards,
> Krzysztof
> 

OK, I'll remove it in the next iteration.

Regards,
Michael.

