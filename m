Return-Path: <linux-wireless+bounces-7961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA88CC3ED
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857611C210E8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186331B815;
	Wed, 22 May 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sYKGFHxn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B846AF;
	Wed, 22 May 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390957; cv=none; b=J6F6dueW836qCCo0IpFxuXwRwcZhqQmpMz3J7T5jv/qPdk2B9jpLi649sbMz7A6FuOeCaZOY8EdKCK4rzSyy+kzGI9aSM1YB+DrPbp7MH1tDV/QQRX+10M2/O8EKNVyP8grtDs2ux1ejHMRuZmGijlMCbHEfwc8Im+SJYS0V/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390957; c=relaxed/simple;
	bh=BLzUQ8V0xeTF+dtdwWRkLWETsEKNM5FXTDRvAzbY51g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=edQkqmCwoIK2mQawA2H3voQJirKOO4rqOG74K9uACuFOgcvlotdkLtAUukR765FmV0twfv/KlIhkVeLK3+N4jsdCKfcpr9wmo/9F4T/j08HCmt3FXnsYjWi5KUOrk59LOFY5qnqaCdtQ4Odn0L708OLhQ6s5nKvg4TwElU2q28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sYKGFHxn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MFFgRS028006;
	Wed, 22 May 2024 10:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716390942;
	bh=uuwFmYRHuiGD48DhV0PDwVMHSAkqVP16xhaWkJZ/WKo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sYKGFHxnc9YqXL6iF19U12BZouXomlfSPV2r+iFPvelSJKZX3V9HWtS4vk+dMuVQN
	 lv0SNQpbcqTwHDso+5VfpKMxoK1HTWOS1czkudYWF97R3o/XPNljTzuPEDnoFqpx1G
	 IkJ0+p+yG0UWGOsEnDAHytwAbdKgOJLnR5h0aNB8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MFFfas011580
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 10:15:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 10:15:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 10:15:41 -0500
Received: from [137.167.6.219] (lt5cg1094w5k.dhcp.ti.com [137.167.6.219])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MFFdNX049254;
	Wed, 22 May 2024 10:15:39 -0500
Message-ID: <1ab99d82-602e-4c7e-9570-0d9c67719051@ti.com>
Date: Wed, 22 May 2024 18:15:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 07/17] Add boot.c, boot.h
To: Krzysztof Kozlowski <krzk@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sabeeh Khan
	<sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-8-michael.nemanov@ti.com> <Zk2ywFQQ2SuXvPiE@gmail.com>
 <f6ee888b-f4de-4b72-8224-aca4236ab220@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <f6ee888b-f4de-4b72-8224-aca4236ab220@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/22/2024 2:12 PM, Krzysztof Kozlowski wrote:
> So neither this nor previous version was ever built...

I was building with ARCH=arm. Seems like linux/vmalloc.h is included 
automatically with this architecture but not others. I'll fix the 
include and make sure to test with other archs as well.

Michael.


