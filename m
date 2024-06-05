Return-Path: <linux-wireless+bounces-8525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44B8FC862
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749A02829F8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A618FC85;
	Wed,  5 Jun 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jgs9t38X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2918F2DD;
	Wed,  5 Jun 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581378; cv=none; b=Dr0/3fewJohBneTexaYvORLWFQmcB2miepdH497peRTNmdq1iAb9MM59zBctNKKph5/FtKuAXgsyjY52t1HRKBX4g4Qd4S8eWhXksL3x2UQw1VWXMS90EpWGBUtHhLEQABO1oWnc9ksFB+NSZcxnZZlYSG5m4Y2lcnrTc3Se2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581378; c=relaxed/simple;
	bh=sZH130KhV6Sxe/srQIfQ6fLBm2tVfgmWGkFbCM8jzMo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DfjlKWPTfXDAF9a0y1TeKOScZt+yTKymoA0EHU4CmIALhXoUTiaNfN3KF1aoU6yGWrSxdka8JD3ArWhjxlNSVYUzR7vPwnLoAfkhYwFl6NRjfNHl9Gm3hzolXkYlc5OIAzhw9bTAvcg2begT9vbrIAszz6F0SeuRD4lakQJdeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jgs9t38X; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4559tBBN083735;
	Wed, 5 Jun 2024 04:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717581311;
	bh=m4dawFd7mVRkD8sUTHOUCTtxKHfu5Cbecp6wmmcEiss=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=jgs9t38XWrp8HD7lHcoWWvKBojDhhpkt6WR8pmNZEIphvCx9iq1EwtpMQaKs23XjK
	 NHUPYPDGAEc8w/p8uQPX1ECPCQRcI+sTvaHMgQRxzcMIScSBD1H4tVpg+fVi1lR8Qk
	 k/0YiJraRNTHvYszMHWtSFTk0PysGFiVpheu00l8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4559tBCB091164
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 04:55:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 04:55:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 04:55:11 -0500
Received: from [137.167.6.231] (lt5cg1094w5k.dhcp.ti.com [137.167.6.231])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4559t9C7098183;
	Wed, 5 Jun 2024 04:55:09 -0500
Message-ID: <eea16e12-6e9d-4630-87e6-f44071ab1c4e@ti.com>
Date: Wed, 5 Jun 2024 12:55:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] Add main.c
From: "Nemanov, Michael" <michael.nemanov@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-9-michael.nemanov@ti.com>
 <cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
 <456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
 <97d8acf9-6cb3-4da7-ad4e-0f2d0a63c172@kernel.org>
 <2e2ec1ba-0c24-4173-af60-ea51004f2e10@ti.com>
Content-Language: en-US
In-Reply-To: <2e2ec1ba-0c24-4173-af60-ea51004f2e10@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/31/2024 4:50 PM, Nemanov, Michael wrote:
> On 5/22/2024 12:46 PM, Krzysztof Kozlowski wrote:>
>>> +
>>> +static int cc33xx_probe(struct platform_device *pdev)
>>> +{
>>> +	struct cc33xx *cc;
>>> +	struct ieee80211_hw *hw;
>>> +	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
>>> +	const char *nvs_name;
>>> +	int ret;
>>> +
>>> +	cc33xx_debug(DEBUG_CC33xx, "Wireless Driver Version %s", DRV_VERSION);
>>
>> Drop
>>
>>> +
>>> +	if (!pdev_data) {
>>> +		cc33xx_error("can't access platform data");
>>
>> Do not use your own print code. Use standard dev_() calls. This applies
>> *everywhere*.
>>
>> [...]
>>
>>> +	cc33xx_debug(DEBUG_CC33xx, "WLAN CC33xx platform device probe done");
>>
>> Drop, tracing/sysfs gices you this. Do not print simple
>> success/entry/exit messages.
>>
>> [...]
>>
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, cc33xx_id_table);
>>> +
>>> +static struct platform_driver cc33xx_driver = {
>>> +	.probe		= cc33xx_probe,
>>> +	.remove		= cc33xx_remove,
>>> +	.id_table	= cc33xx_id_table,
>>> +	.driver = {
>>> +		.name	= "cc33xx_driver",
>>> +	}
>>> +};
>>> +
>>> +u32 cc33xx_debug_level = DEBUG_NO_DATAPATH;
>>> 
>> Why this is global? Why u32? Why global variable is defined at the end
>> of the file?!?!
>  
> cc33xx_debug_level together with cc33xx_debug/info/error() macros is how
> all traces were done in drivers/net/wireless/ti/wlcore/ (originally was
> wl1271_debug/info etc.)
> It enables / disables traces without rebuilding or even reloading which
> is very helpful for remote support. These macros map to dynamic_pr_debug
> / pr_debug. I saw similar wrappers in other wireless drivers (ath12k).
> This is also why there are plenty of cc33xx_debug() all over the code,
> most are silent by default.

Any more thoughts on debug traces? I'll remove all trivial function 
entry / exit traces as Krzysztof requested. Is it OK to keep other 
cc33xx_debug() calls which will be off by default?

Michael.


