Return-Path: <linux-wireless+bounces-9644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30336919F3E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C061C215CD
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5DB383A9;
	Thu, 27 Jun 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m3H86Qvn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4D376E0;
	Thu, 27 Jun 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719469627; cv=none; b=cHWv8q0ee4Ak9N2WdfN//SwshZf+CXEmcJo37gEvgBfSD1rkgq7proHQCavhWIgDCGB6KwsJw7euidSSlgd/ZJuNt8ojMjuzN31GebiPrxHznEHg+W8GOr4tmi1e0GN+sGI0Kcfu72dx6d0JZoLvh6Yu5sc/Y0QUqwvon3hqPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719469627; c=relaxed/simple;
	bh=wyQ0BNlQZDym+FNWJd3NW7ohng0EPPqco/xEKaWgMQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XB0WnfXhHnVl32gPXJUT5bvCzTbQBnvLafLuJypkrSNGEJsfEYU+CBul2zjyMN7yXutZbpHAMam1MEWgEYU9+aGsKS0LfEQqfUi92PMjUil+lvT1Z2HsIGyLni5sDjtWwea9IvmvdSfRp9i3B5v50srKhdTWSmysGghGdZMkNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m3H86Qvn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45R6QslO008650;
	Thu, 27 Jun 2024 01:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719469614;
	bh=FnBX2WcfoG/M4I88+iE1oOfx0nlSEYSTb/yqXcoRJd0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=m3H86QvndPSxjkDekG3lw+MaBWr+2wNqxzCGbTJ7rKe32zcaj4qkHoJXJaIYf0NfP
	 ahz5pKBQd5b2wT7nbvdRHbwFPWRROG0PguadDIjahJmtWxAV00U9mAZIhsvoFJPtV0
	 NjoJB8SruTXQGuXKhhGAo48w6lfBCSs3NhrqMU+o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45R6Qs3p005564
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 01:26:54 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 01:26:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 01:26:53 -0500
Received: from [137.167.6.231] (lt5cg1094w5k.dhcp.ti.com [137.167.6.231])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45R6QqBC100855;
	Thu, 27 Jun 2024 01:26:52 -0500
Message-ID: <df34e044-8c51-4ced-8381-cbf424711e2f@ti.com>
Date: Thu, 27 Jun 2024 09:26:51 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 26/43] wifi: nxpwifi: add sdio.c
To: David Lin <yu-hao.lin@nxp.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <20240621075208.513497-27-yu-hao.lin@nxp.com>
 <16de364e-bd80-4674-9125-74c33e551961@ti.com>
 <PA4PR04MB963897BF79B6F05700263A7CD1D72@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <PA4PR04MB963897BF79B6F05700263A7CD1D72@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/27/2024 6:37 AM, David Lin wrote:
>>
>> On 6/21/2024 10:51 AM, David Lin wrote:
>> ...
>>> +
>>> +/* This function unregisters the SDIO device.
>>> + *
>>> + * The SDIO IRQ is released, the function is disabled and driver
>>> + * data is set to null.
>>> + */
>>> +static void
>>> +nxpwifi_unregister_dev(struct nxpwifi_adapter *adapter) {
>>> +     struct sdio_mmc_card *card = adapter->card;
>>> +
>>> +     if (adapter->card) {
>>> +             card->adapter = NULL;
>>> +             sdio_claim_host(card->func);
>>> +             sdio_disable_func(card->func);
>>> +             sdio_release_host(card->func);
>>> +     }
>>> +}
>>
>> Missing call to sdio_release_irq() ?
>>
>> Michael.
> 
> sdio_release_irq() is called by nxpwifi_sdio_disable_host_int().
> 
> David

Right, I see you calling it from nxpwifi_uninit_sw(). Maybe just align 
the comment then.

Michael.

