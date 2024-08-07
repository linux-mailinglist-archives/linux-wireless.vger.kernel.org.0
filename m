Return-Path: <linux-wireless+bounces-11093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B553294AD66
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62FA1C21A29
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3712CDBF;
	Wed,  7 Aug 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sqfp5Er6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AB126F1E;
	Wed,  7 Aug 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046000; cv=none; b=Z2kxhLlRju4soI8WbOBtqlIkoenu/DZtPa2sR7B5uqmOfAjQyt27QI0F31tLdKVGNC8PdWgwd6aYiB8RPf2JFWDlIqtrF0qao2E/zkKfT7f0Xx0yf4ZIJ7ffaFD3IQq3CmN848B3kSNzROWlQ1EDYtVAiTQNbJ5A2NW2sGs2Eds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046000; c=relaxed/simple;
	bh=bn47YP12kWc3dMpGor24aBlvQsD58IxcjXIZF4DC4a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sfcRVqcvD0btJPtI5jptWNYPlMrW8RDyr+keytX3osAbHR8gwl5zeOBR41N6UOb0u8Qji7i0fH0bUgsYuv48v7bc2G+xppMqO+Q3mXqV9UWr54Vq+FkSI+vr27T0fSDhWzjTCmI77WSDrh8lVhrNH1UZwMeN0/BM/W9B/xuZ2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sqfp5Er6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477Fr67s011023;
	Wed, 7 Aug 2024 10:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723045986;
	bh=cdp6OMt/4LGxz+51R6rlxVL7Veu1/+Etfqvh+ytE9us=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sqfp5Er6nrMxw2hOza2GCm+ltgqhTEUi6pHiu2uRbb45bPLt0EXpcEi+aJ7nbQI9S
	 LmoNheEHeFGxXUvtQJf2wKqHO3Jd8VsSESWFfoObw88XoRFh6nWoGeCskOq4In4do9
	 aiXoXBTvDngp+oFt8TiBv4N7TLJ0bdegit9X1k2M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477Fr6C5026058
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 10:53:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 10:53:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 10:53:06 -0500
Received: from [137.167.6.133] (lt5cg1094w5k.dhcp.ti.com [137.167.6.133])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477Fr3hr003276;
	Wed, 7 Aug 2024 10:53:03 -0500
Message-ID: <a596ead6-250d-4b7e-84c3-9c3dbf120cc6@ti.com>
Date: Wed, 7 Aug 2024 18:53:02 +0300
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
 <a36b8ece-5e46-439e-8463-855394be69a7@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <a36b8ece-5e46-439e-8463-855394be69a7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/7/2024 10:06 AM, Krzysztof Kozlowski wrote:
> On 06/08/2024 19:00, Michael Nemanov wrote:
>> Add device-tree bindings for the CC33xx family.
>>
>> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
>> ---
>>   .../bindings/net/wireless/ti,cc33xx.yaml      | 56 +++++++++++++++++++
> 
> Also, bindings always come before users, but maybe the maintainers will
> re-order things since you expect here some squashing.
> 
> Best regards,
> Krzysztof
> 

Will hoist the bindings to be 1st.

Thanks and regards,
Michael.

