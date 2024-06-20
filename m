Return-Path: <linux-wireless+bounces-9275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9890FF11
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 10:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5201A282E63
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D852199237;
	Thu, 20 Jun 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w2VnSADv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061633A1AC;
	Thu, 20 Jun 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872855; cv=none; b=RveszTmCZZ6p9HTFnL2QGF9bHLNid90B26JGmWIJWjL+iy8Sxr6bZF/2cWJZa1xHW3TDvyCqIx2569deR6tPaWCm1h+pw/H9ObdDES0WmXXT2s2QtvjUazkHfM6ujDP8lFq38pHFyuvvT9Klq8/UXbeSLu6LT+6eLRJMgt1zvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872855; c=relaxed/simple;
	bh=T9c/AzwULmtVSuRIh4jy995d8pfVUHRZXM6im43OF3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CTK0eUB4sh0WeOI+jcdo12JxJY5WApNZvJpBLVRRErpXOJfsYC0ALhHOOm56RJVpjjV6MQEfZbScmxmUboAln1Nvm+thcM5l4ezgoKPzSujCbSkcBnQozs3jxc/Ma4EAJhQbsaG+84dp9smB+sOYX5X6NQABoQ+Rt6EU3I/BsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w2VnSADv; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45K8eZCe008471;
	Thu, 20 Jun 2024 03:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718872835;
	bh=fZ9aXf7RFumbeOarN7U1Qbe0conyNks+EiRAd8ZfoNU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=w2VnSADv40EhC0cSx2hIWyLrE+4n5g5arwnVz9rCAq0JJaAhw3oVeR0MgGcf2vd95
	 ebYVsf93/zIVXq7w9sLexb91PfRWYqqwGyeK2tI603FLQApjZgeC1UlsBSMUuJOV3u
	 EkP3/q25hHrd7h1UlP5ByVi0ASxSk/H21MGd8pZ8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45K8eZUJ058461
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Jun 2024 03:40:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jun 2024 03:40:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jun 2024 03:40:34 -0500
Received: from [137.167.6.231] (lt5cg1094w5k.dhcp.ti.com [137.167.6.231])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45K8eVmq108104;
	Thu, 20 Jun 2024 03:40:32 -0500
Message-ID: <8dbb30be-3c0c-43c9-8f7a-dbfeeca3837e@ti.com>
Date: Thu, 20 Jun 2024 11:40:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/17] wifi: cc33xx: Add init.c, init.h
To: Simon Horman <horms@kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
 <20240609182102.2950457-12-michael.nemanov@ti.com>
 <20240615085133.GA234885@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20240615085133.GA234885@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/15/2024 11:51 AM, Simon Horman wrote:
...

> 
> Hi Michael,
> 
> allmodconfig builds on x86_64 with gcc-13 flag the following:
> 
> In file included from ./include/linux/string.h:374,
>                   from ./include/linux/bitmap.h:13,
>                   from ./include/linux/cpumask.h:13,
>                   from ./arch/x86/include/asm/paravirt.h:21,
>                   from ./arch/x86/include/asm/irqflags.h:60,
>                   from ./include/linux/irqflags.h:18,
>                   from ./include/linux/spinlock.h:59,
>                   from ./include/linux/mmzone.h:8,
>                   from ./include/linux/gfp.h:7,
>                   from ./include/linux/firmware.h:8,
>                   from drivers/net/wireless/ti/cc33xx/init.c:6:
> In function 'fortify_memcpy_chk',
>      inlined from 'cc33xx_init_vif_specific' at drivers/net/wireless/ti/cc33xx/init.c:156:2:
> ./include/linux/fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
>    580 |                         __read_overflow2_field(q_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function 'fortify_memcpy_chk',
>      inlined from 'cc33xx_init_vif_specific' at drivers/net/wireless/ti/cc33xx/init.c:157:2:
> ./include/linux/fortify-string.h:580:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
>    580 |                         __read_overflow2_field(q_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    CC [M]  drivers/net/wireless/ti/cc33xx/rx.o
> 
> I believe that this is because the destination for each of the two memcpy()
> calls immediately above is too narrow - 1 structure wide instead of 4 or 8.
> 
> I think this can be resolved by either using:
> 1. struct_group in .../cc33xx/conf.h:struct conf_tx_settings
>     to wrap ac_conf0 ... ac_conf3, and separately tid_conf0 ... tid_conf7.
> 2. Using arrays for ac_conf and tid_conf in
>     .../cc33xx/conf.h:struct conf_tx_settings, in which case perhaps
>     .../wlcore/conf.h:struct conf_tx_settings can be reused somehow
>     (I did not check closely)?
> 

Thank you for checking. I agree this code should be rewritten so it is 
more clear and w/o any warnings. Will fix.

I was unsuccessful reproducing the warning on my end. Tried with GCC 
13.2.0 (ARCH=x86_64, allmodconfig) and Arm GNU Toolchain 13.2 (ARCH=arm, 
allmodconfig) and only got errors in scan.c which I assume you refer to 
below (will also be fixed).

> 
> Similar errors are flagged elsewhere in this series.
> Please take a look at allmodconfig builds and make sure
> no warnings are introduced.
> 
> Lastly, more related to the series as a whole than this patch in
> particular, please consider running checkpatch.pl --codespell

Sure, will add checkpatch.pl --codespell to my tests.

Michael.

