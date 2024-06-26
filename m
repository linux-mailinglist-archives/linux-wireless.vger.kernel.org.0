Return-Path: <linux-wireless+bounces-9597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C95917FE8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B620D1C22C7E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C2149E06;
	Wed, 26 Jun 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dj4/v/mo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122E17F39A;
	Wed, 26 Jun 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402047; cv=none; b=eKiv+PPf0fc4q9e9tsEb7ggBdcYu2X0VMM9C+dG5U9YBLTF3oxLMdsihNTJMsyxVDcNb9tX7EsMBpR1d863ey9FteMnSuLreIgdMlRXRqtH5mp3e2F1EuZlMYubh8FB0mPynSVyJjzOI9C/+Hxbj5JJV6vFhqeq0AlF6zIhWuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402047; c=relaxed/simple;
	bh=pczfog09UIHcPsEJjzJd5+EU+oHI91fjPgKgwsYbpUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OigBfMcRgXH+P4tFc5963UFohkkVk8JqAbtwKuTeKncQyMESb7oQqGEIsKUGbNHjFHmw7yMYRvTBDU9ktzifWcih6sVkb1pP/PWAl5DGjAu3EKd9Q7oQxzKCh/tJWJC8BxPEJj8wYkirbnnJ7ESMmmq1Hg1TTlUPftXq6pE5STA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dj4/v/mo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QBeJea107396;
	Wed, 26 Jun 2024 06:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719402019;
	bh=CFBdJZ7nQEh8e7MuO6Sn87b7kJj+Ogt1xZYKl5Es3eA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dj4/v/moBDp5qdtoYkEsNAqmIepOOEc9jVpAhpYHW8aSWX5sRaVEkX+w5z6ZfVnNf
	 5rSHxhK8FKzv+gTgzNoDK6o1B/Ixffg9j6HtbT1c9rXW9zmlF76xb4VMsHXBmHWWJJ
	 2uQqhQWpdFnK3ghGcOcCu5J1OKZ8UfajqZ9hAacM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QBeJdt039449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 06:40:19 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 06:40:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 26 Jun
 2024 06:40:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 06:40:19 -0500
Received: from [137.167.6.231] (lt5cg1094w5k.dhcp.ti.com [137.167.6.231])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QBeHPP080750;
	Wed, 26 Jun 2024 06:40:17 -0500
Message-ID: <16de364e-bd80-4674-9125-74c33e551961@ti.com>
Date: Wed, 26 Jun 2024 14:40:16 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH 26/43] wifi: nxpwifi: add sdio.c
To: David Lin <yu-hao.lin@nxp.com>, <linux-wireless@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <briannorris@chromium.org>,
        <kvalo@kernel.org>, <francesco@dolcini.it>,
        <tsung-hsien.hsieh@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <20240621075208.513497-27-yu-hao.lin@nxp.com>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20240621075208.513497-27-yu-hao.lin@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/21/2024 10:51 AM, David Lin wrote:
...
> +
> +/* This function unregisters the SDIO device.
> + *
> + * The SDIO IRQ is released, the function is disabled and driver
> + * data is set to null.
> + */
> +static void
> +nxpwifi_unregister_dev(struct nxpwifi_adapter *adapter)
> +{
> +	struct sdio_mmc_card *card = adapter->card;
> +
> +	if (adapter->card) {
> +		card->adapter = NULL;
> +		sdio_claim_host(card->func);
> +		sdio_disable_func(card->func);
> +		sdio_release_host(card->func);
> +	}
> +}

Missing call to sdio_release_irq() ?

Michael.

