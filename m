Return-Path: <linux-wireless+bounces-7962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B58CC44C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34F2B21B28
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F881734;
	Wed, 22 May 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TqKuDo6x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E527D3EF;
	Wed, 22 May 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392694; cv=none; b=SGEFguyxYCTjJTwjohqyMk6sw47Xzp4f/OO8Tvkgrwv3AU5btnl4JsyCWbKwmRMprUs8gTK3CAkTPp4DnDeWZ1Mx1Vd8XhHUGLaXKYanqkJS90R+zUhS52UwoDZ0Tcrne4uROOmh6Iw/W0b8qGFSzC093flloDbW8ZYOnZaI1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392694; c=relaxed/simple;
	bh=oB88OGiBRzAoayxRZBetm6e625rVBGs2HTQ0OrqFGWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q75D4VPkwgjg05tINIKB5a4yB/XrZ/IeMx34CCZAlP0PNJA3NfjYNcFO7ZZHw8/Q5NDS3LtHDZEaJfNUwT/5758esYa1ya63FEyOcghr2URnVvQNTZLvn+VkG8MRI363jBqiYWoS92XQM0OvDufJb/wY5lVADJgSkxsax16tUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TqKuDo6x; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MFif50043991;
	Wed, 22 May 2024 10:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716392681;
	bh=f+pEerrIm5HmFx7I6laOSLnzNWBKHizBP6ZI3HxvWK0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TqKuDo6xSu0marhlI7MQdWabVwJnrKQPUqF9sr0X9+8AGvvYPzMTUv3l0to17Pf9N
	 RUQ5zLORNtV+JszAiMCN5DaS084qgHIh1J93udYWAPO8qBd3FJRWK7Xrx8QpLDQGND
	 5baxfG8MB2KfmXReiBTu/Eaun55OKeRJOIK26DdQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MFifvo097080
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 10:44:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 10:44:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 10:44:41 -0500
Received: from [137.167.6.219] (lt5cg1094w5k.dhcp.ti.com [137.167.6.219])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MFicXH095048;
	Wed, 22 May 2024 10:44:39 -0500
Message-ID: <cdb9e99a-d0f5-47f8-9efb-77a661f53928@ti.com>
Date: Wed, 22 May 2024 18:44:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] Add cc33xx.h, cc33xx_i.h
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-2-michael.nemanov@ti.com>
 <383554c5-aef5-4c3f-bf67-dfdc83324897@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <383554c5-aef5-4c3f-bf67-dfdc83324897@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/22/2024 12:38 PM, Krzysztof Kozlowski wrote:
> Please also confirm that you also fixed all warnings from:
> 1. checkpatch --strict
> 2. smatch
> 3. sparse
> 4. coccinelle/coccicheck

I was running checkpatch --strict and sparse. I'll add smatch and 
coccinelle/coccicheck to the test list as well as testing on other 
architectures.

Thanks and regards, Michael.


