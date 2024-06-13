Return-Path: <linux-wireless+bounces-8965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8590655D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 09:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B568D1C23164
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA813C3D6;
	Thu, 13 Jun 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HZLfaw0P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9B13C3D8;
	Thu, 13 Jun 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264391; cv=none; b=gBMZjwfIsB2OSrMPX+DqfEl8rtfwDNhJkSw2hkiXilwqQVIn+zSIatLQznUaqONYAbALtCgbbilkJDHUm6GNAznRpUL7oUVvXjC5tQMQrGO2rQNGHjQrqqV5QrATpOhzSxS+t20lPuLh3Ysm5CvQIcDZKh/FlQZ4bUVCh7lMsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264391; c=relaxed/simple;
	bh=TDG1hAEvKTqi8x6dK8QwzoYkuCJJOfpG15LJ6vNyGJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F2SM39Yx6gBwuOHU8ogSYaX9ea81CqA+72apZIRsLIxOV9gMdBKQP3vus0xeI3CNrNJfgvIpMOxFawe98c8x6LK3IAiis9xvbP8C72b7EORPAsCAPg1LvRw0A9ewdYI0MDS77wx8M7DUaHClBjpDJOAnXsNZA9cLyMGdCsiQE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HZLfaw0P; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D7degi088676;
	Thu, 13 Jun 2024 02:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718264380;
	bh=2okusDhLwSssKtYayuSI+ewFdBOg2dmNj/EzRz6J07A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HZLfaw0PrJDyZqDUmqmX8ctVk1V2Mh2Z2udJ+5X+gEGhoW8rZBq4la2Png1DAa31D
	 MoBCz+HJFDX7U90ygPInUHBP3eERu8T8S+cJ+i/VukI/DSpexCojohblTW8Wunh4dW
	 JKuLbI4ECOeA3tws/DgvZxH7/CqQ+IYuTDqJ5UJE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D7deOA055024
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 02:39:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 02:39:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 02:39:39 -0500
Received: from [10.250.214.9] ([10.250.214.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D7dZ9a102427;
	Thu, 13 Jun 2024 02:39:36 -0500
Message-ID: <1c655f3d-7198-4f7b-be14-407345f6a204@ti.com>
Date: Thu, 13 Jun 2024 10:39:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>, Sabeeh Khan <sabeeh-khan@ti.com>,
        Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
 <20240609182102.2950457-18-michael.nemanov@ti.com>
 <e7444ff4-763a-44c6-9a73-0c5f590ceaad@kernel.org>
 <0d4fc078-52a7-4d3b-a95e-fd64e0702a99@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <0d4fc078-52a7-4d3b-a95e-fd64e0702a99@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10/6/2024 11:17 AM, Krzysztof Kozlowski wrote:
>> On 09/06/2024 20:21, michael.nemanov@ti.com wrote:
>>> From: Michael Nemanov <michael.nemanov@ti.com>
>>>
>> 
>> Missing commit msg (explain the hardware), missing SoB.
> 
> And now I found that you actually received such feedback and you just
> ignored it.
> 
> Go back to v1 and respond to each feedback you got.
> 
> Best regards,
> Krzysztof
> 

Oversight on my part, will fix.

