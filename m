Return-Path: <linux-wireless+bounces-8064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA28CF2A0
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 08:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864091F21232
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 06:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD617FD;
	Sun, 26 May 2024 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RtoSBFpu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D82C80;
	Sun, 26 May 2024 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716703462; cv=none; b=t5X2Bq9N1H8tuR3OsCpzDbshmc/BWSGmhqb9Dbp7yWhWFzAP4n9r8lLRvDqK8ZVLrJtYYPSPu/ZbFTzPdwk2TsDFltbf9EdrvHlvPotqILknQ9d+hozZ4T8irUxLP+b+tCrZS+PCc4dXrPGOPH4m1WpUH+gvl+lUzfJRxVVG05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716703462; c=relaxed/simple;
	bh=o6rUPsdPCbOTgYFZpdobClkupH8ef6fMP+RyiUkU1Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tm7bZ9eIwG7p8A/9NagjC6qETqts7wNse8aeIYwbHkGtX8VqjWmndq/MXs31fFd39WZ1JICrpti9AEHvRKjNHCLH5XYE6VlXEjWlaNhxZ8o16K7c7kD5yZkDt2u01cHUagFHNVOIpJJSVPHerptG/rSncsp5/MRBmLraFFnOuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RtoSBFpu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44Q63pST121861;
	Sun, 26 May 2024 01:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716703431;
	bh=tqUDn5jZPYTSUvIaZPcNDs5JiNCDnu6qqS/l9KXRD+k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RtoSBFpuVWMVV1x64IAnVPxwUGI7opnXWLdWWyujK1Jas+tEq8mR/D3Iran7DrFgp
	 yfP0V1EfoKLpDKnGUQm2aWwvywRHXgX0bqtywwyB+5eT4Cux6YxX90dWsjvAIIIcvV
	 C7locmVfTu5x5w7ZXyczXsA/73zSvMwG+33syhL4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44Q63p16090009
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 May 2024 01:03:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 26
 May 2024 01:03:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 26 May 2024 01:03:51 -0500
Received: from [10.250.145.232] ([10.250.145.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44Q63m6c028007;
	Sun, 26 May 2024 01:03:49 -0500
Message-ID: <d43fa0b4-a951-4266-a810-dfa144e059a9@ti.com>
Date: Sun, 26 May 2024 09:03:48 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] Add rx.c, rx.h
To: Breno Leitao <leitao@debian.org>
CC: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sabeeh Khan
	<sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-10-michael.nemanov@ti.com>
 <Zk2zCEhs9dDmOoMt@gmail.com>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <Zk2zCEhs9dDmOoMt@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 5/22/2024 11:55 AM, Breno Leitao wrote:
> > diff --git a/drivers/net/wireless/ti/cc33xx/rx.c b/drivers/net/wireless/ti/cc33xx/rx.c
> > new file mode 100644
> > index 000000000000..038b356f50a2
> > --- /dev/null
> > +++ b/drivers/net/wireless/ti/cc33xx/rx.c
>
> > +
> > +int cc33xx_rx_filter_clear_all(struct cc33xx *cc) {}
>
> You probably want to return an integer in this function here.

Thank you for looking into this. I'll fix it and the other problems 
you've found in v2.

Michael.


