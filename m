Return-Path: <linux-wireless+bounces-9313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF3910D9A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BE51F21B93
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D221B29B6;
	Thu, 20 Jun 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PZ58B+r9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED317545;
	Thu, 20 Jun 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902367; cv=none; b=VgXSWWp3nXyeSTrCI39IDuKzNmBOJ3SDFJWESHPTeJEw/oos+TYUawHw8KOLs02mtf38Kyvq7Kl/XAm6pE/Law+9E3LMG5awGcbFS/a/p8xhEE8FT2hpvg1fkkLUgq1ApQJCOiqHa3i7D++RKSz8EcDEPVMa/BxFF5Qk9FDqd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902367; c=relaxed/simple;
	bh=qbAYQwuAZ3+wqE5qpkltgeY9gIOi1oncenNBRJRTJTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sl6SUKXieLUaNV0B/Win3s9lHhlQZ+uH3PHt8NUB9ynK/COuRNyeH51m985T5swg695oHnghIZ5r5DaRf1BeapJxznAB/RSNZzpaXbW1eOkOWHKdzjsASUQIt/eivtNXHTlqAhnutwQxqfl53qdhr0hKg16a3ytT7mkqfmwFjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PZ58B+r9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45KGqQKQ070807;
	Thu, 20 Jun 2024 11:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718902346;
	bh=HG1bfcMijyIFrjAnBLZjdBnssxxpZ4esXoREhIa1pjM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PZ58B+r90OegnbC0udY0dzwaoPOwxby3SKaz8mAZwm0IW2iGKQXON5/H33HYpA6e4
	 gzRuO/nN8LNt3ff8zinl+KLMiw/wzfOjEI4qtX8O8UC67ibKow2AiufjJEE4ulj8Ud
	 F1NA5jVNDS8dC149dVZC1d6GDuO/EYPp7u1LOveo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45KGqQbm020672
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Jun 2024 11:52:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jun 2024 11:52:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jun 2024 11:52:26 -0500
Received: from [10.250.212.197] ([10.250.212.197])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45KGqMX1051378;
	Thu, 20 Jun 2024 11:52:22 -0500
Message-ID: <8dd345ae-7da3-440f-9d9c-d2b0500ba78b@ti.com>
Date: Thu, 20 Jun 2024 19:52:21 +0300
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
 <8dbb30be-3c0c-43c9-8f7a-dbfeeca3837e@ti.com>
 <20240620163048.GK959333@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20240620163048.GK959333@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/20/2024 7:30 PM, Simon Horman wrote:

...

> Hi Michael,
> 
> I tried this again with GCC 13.2.0 on x86_64 with allmodconfig.
> And I was able to see this with a W=1 (make W=1) build.
> 

Oh it was the combination of CONFIG_FORTIFY_SOURCE=y (from allmodconfig) 
and W=1. Thanks, I see it now.

Michael.


