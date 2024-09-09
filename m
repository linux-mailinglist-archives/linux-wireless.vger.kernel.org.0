Return-Path: <linux-wireless+bounces-12652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE8E9713F1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F61F27665
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816531B251C;
	Mon,  9 Sep 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kt4o5tHy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EE1B1D4E;
	Mon,  9 Sep 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874620; cv=none; b=mnstabQgj3P85Axz5cy+FxvjHnunD5qCCuDa3x0O/oGLIek1jEX149p8yvwfH/TpOZvxQ8JlC+Y4NHU70l+01WPgPzEX5nQUEngVmwdNCNBXKOgtElzbearGc5BXhk3sHubg8CdHm7sIX8OqjgHmYHBG9YVSJKIsWh5OMcB0riw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874620; c=relaxed/simple;
	bh=GQEr/9zpRirO1wQsM0VqynSiZInCc24ILWtlBq5o0yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dvehJkSdUxib6hBpi8Vd9H2I3AVlRFlu669jKoNjYf/49WReRhyrFLRRuPAbDaT9RcVPAsITa1PDRJO/8xJHAGLafCoctZe7E4K3N+wUfRMaQPW9r2NrLo2xHCguKoV3Kj2mINrH4Dykq3XUk4VL608TOlAIDK/rM6xWopxB/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kt4o5tHy; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4899aPEr114802;
	Mon, 9 Sep 2024 04:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725874585;
	bh=9rFahbn1qIk8LJHzDYN4y2k/Snsiv71P703icd1KpGI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kt4o5tHySTtI4MT0ZHZRH5WucoWLVokLdUlABPXgQVIm2Cd3JTDqPhSQvDi4GWvGR
	 xfSssveZrHUXx8a9VcEoYnYStzA7aw+88XIKPWMPdDWApIYSaun/iKK/FSFQVTBw3v
	 WPPGGrRsWhseNDS7kv808vtRuQ2mF9uPB47lW9QE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4899aPTn104813
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Sep 2024 04:36:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Sep 2024 04:36:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Sep 2024 04:36:25 -0500
Received: from [10.250.149.85] ([10.250.149.85])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4899aKaD032721;
	Mon, 9 Sep 2024 04:36:21 -0500
Message-ID: <7a7f5870-b74e-4c0e-8d76-b97b45bae963@ti.com>
Date: Mon, 9 Sep 2024 13:36:19 +0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 2/3] wifi: wlcore: sdio: Make use of
 irq_get_trigger_type()
To: Vasileios Amoiridis <vassilisamir@gmail.com>,
        <arend.vanspriel@broadcom.com>, <kvalo@kernel.org>
CC: <knaerzche@gmail.com>, <leitao@debian.org>, <linus.walleij@linaro.org>,
        <javierm@redhat.com>, <linux-wireless@vger.kernel.org>,
        <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
        <linux-kernel@vger.kernel.org>
References: <20240904154919.118513-1-vassilisamir@gmail.com>
 <20240904154919.118513-3-vassilisamir@gmail.com>
Content-Language: en-US
From: "Khan, Sabeeh" <sabeeh-khan@ti.com>
In-Reply-To: <20240904154919.118513-3-vassilisamir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vasileios,

On 9/4/2024 7:49 PM, Vasileios Amoiridis wrote:
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).
>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/net/wireless/ti/wlcore/sdio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
> index 92fb5b8dcdae..9e1b644beba9 100644
> --- a/drivers/net/wireless/ti/wlcore/sdio.c
> +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> @@ -324,15 +324,13 @@ static int wl1271_probe(struct sdio_func *func,
>  	memset(res, 0x00, sizeof(res));
>  
>  	res[0].start = irq;
> -	res[0].flags = IORESOURCE_IRQ |
> -		       irqd_get_trigger_type(irq_get_irq_data(irq));
> +	res[0].flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
>  	res[0].name = "irq";
>  
>  
>  	if (wakeirq > 0) {
>  		res[1].start = wakeirq;
> -		res[1].flags = IORESOURCE_IRQ |
> -			       irqd_get_trigger_type(irq_get_irq_data(wakeirq));
> +		res[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(wakeirq);
>  		res[1].name = "wakeirq";
>  		num_irqs = 2;
>  	} else {
Reviewed-by: Sabeeh Khan <sabeeh-khan@ti.com>
Tested-by: Sabeeh Khan <sabeeh-khan@ti.com>


