Return-Path: <linux-wireless+bounces-15194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F82B9C4EEA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 07:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74222B251BB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 06:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C120A5D0;
	Tue, 12 Nov 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eclWhf2q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAB4C91;
	Tue, 12 Nov 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393980; cv=none; b=t4akFgDT1WLqMVGgEdxv+ORXLp2Tb5VrZfdbUemgHdY4XetbWUY4EEz9dId9tS3iMkdXWgPOP+Nk2uRanNN6inC5ii3Acjf8DGaFHVvXljYAHquT5og4ijz2LE6kyHytue5pm5qWiSzKOpL+Q8IXQXOQfApdYzo+zxVym1BNvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393980; c=relaxed/simple;
	bh=VX9N36lARRqzMlNgWNjXqZec+VAuskDFhLy+Txu1Lwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OeM3oZOGS5fmmzzjHbkSKdOwtmE84KpCx3CBtqij/38+5yXjXlj+DIKAmo9WMooIt15qS6nWZIDYR7JhubCiQkchlSkAm4jtZfWuixsM5BWe4rz8F6ONCIzngJH8qCroMq2MCD/oNKXUmi2tiKR3GLLsG7Pngi2/qsO09nW6isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eclWhf2q; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AC6jtlY076588;
	Tue, 12 Nov 2024 00:45:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731393955;
	bh=SHKLsrMhF1OLae930Bz/9un5AiYrRlutqYBk9lsUp60=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=eclWhf2qiB9WkGR5ub4qr3ubstyuvulIWLf8h3bpVvyyUy6bdaJK7sy1bcgV0WqJ/
	 Wl8x8zW/sywdCB1h3GzGFbB8DraZonu+xSz1cbcVeLAeg9BSp62ZF8MNBFcfyMUPO6
	 bHsNufvo5nZYSCyxGaWa7yKa2mRPXY8L78vmMg74=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AC6jt5I067443
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Nov 2024 00:45:55 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Nov 2024 00:45:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Nov 2024 00:45:54 -0600
Received: from [10.250.214.214] ([10.250.214.214])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AC6joPB087798;
	Tue, 12 Nov 2024 00:45:51 -0600
Message-ID: <2b0e95be-8192-416f-8655-631d6cecc336@ti.com>
Date: Tue, 12 Nov 2024 08:45:50 +0200
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
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <y4ffzjekeccqg2tv7d54ilwbz3nhm4jkcq3fyg5tmpbupsqirn@dq3kjtwkllds>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/8/2024 2:02 PM, Krzysztof Kozlowski wrote:
> On Thu, Nov 07, 2024 at 02:51:53PM +0200, Michael Nemanov wrote:
>> Add device-tree bindings for the CC33xx family.
>>
>> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
>> ---
>>   .../bindings/net/wireless/ti,cc33xx.yaml      | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
>>
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
> 
> Thank you.
> </form letter>
> 
> Best regards,
> Krzysztof
> 

Are you referring to

> diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml

...

> +
> +properties:
> +  $nodename:
> +    pattern: "^wifi@2"

?

If so, I replied here
https://lore.kernel.org/linux-wireless/8024aa1c-5bd1-40d8-b0c3-14b5fcd992e2@ti.com/#t
But if you don't think it's worthwhile I'll remove it.

Regards,
Michael.

