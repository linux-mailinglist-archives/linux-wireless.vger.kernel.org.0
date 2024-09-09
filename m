Return-Path: <linux-wireless+bounces-12715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D396C972661
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 02:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5D11F24FA3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959355E58;
	Tue, 10 Sep 2024 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="IuiKmmaM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B91369B1
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929484; cv=none; b=Ogk95keK9trF5ShfEBComPMC1ne+bqUEreXPCdmXtMaqpeS4CBC2BwpDQDQiVbNFuTUBNed42pI04cPyNxovTbi9OrH6cKS9VWigNn/nwry/aKUebpB/WAgJS+LS15Ft8ufuRiGQJpfnyupbxqm+LGmspkQWp9UJ2fKerBubhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929484; c=relaxed/simple;
	bh=POftXnbFEiZQIOeWglPFdIJZoq2ZRLkH2qpuBRlpkRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bU4LSFQWNzPim582hijSA9hjIk2WZlBvRxARcxLM8CbHU2GjX/7rObEGgQLU1AnZ1jbJt+Yfhn+teN3x4dcLcDARUyHDVK7GWn24BS73ZsxZ8a1+tMlFoqwICB9dcSjYFPFgx6P8v+Ixe6XPpkWVQsFh/876bdRNKu5RosIr120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=IuiKmmaM; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E327788B6C;
	Tue, 10 Sep 2024 02:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725929480;
	bh=cf+MRz5G5ApCceJN6pkjniRqFPQul1a4aLDBONmlo1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IuiKmmaMMa9jYzo+4fS0fYj4cB8eHz/Mr3itpRH0L1iGsFop12Bxcvf1o/NULw1Qq
	 pzzCgHHADPrF43xyTsAupjxn5rXLlig4renHzrriQbRy/CjxYPgf7SlI78bppNuMW4
	 a4CiEl1rDenbTQxk7R4nG4GzWTECOhQAjxo3ehGlkpMcL92yJ8KTbHBGayQ1BluM5I
	 7/y5IOvE8gLNe+40z99n6fEGmHPCRNgLEDk1BOQgz8okFtfdh7jQKFIR5NajXCSV4r
	 1f03y3tG8o0ov8BuUW7sXm8sPq9Vf94aDY0a+8my6SJvYH1THKCpAiKqxIk8BQtP44
	 Nbf/XpQJ5MNcg==
Message-ID: <ea819501-2309-4ee8-9a89-fe79435cecc8@denx.de>
Date: Mon, 9 Sep 2024 22:27:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Chung-Hsien Hsu
 <stanley.hsu@cypress.com>, Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>,
 Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>,
 Kees Cook <kees@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>, Matthias Brugger
 <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, brcm80211-dev-list.pdl@broadcom.com,
 Double Lo <Double.Lo@infineon.com>
References: <20240818201533.89669-1-marex@denx.de>
 <172431581868.2154344.15348672155352447310.kvalo@kernel.org>
 <6129cf7b-59bb-440f-a277-69af63168e87@denx.de>
 <191ac5df360.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <191ac5df360.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/1/24 8:55 AM, Arend Van Spriel wrote:

Hi,

>> On 8/22/24 10:37 AM, Kalle Valo wrote:
>>> Marek Vasut <marex@denx.de> wrote:
>>>
>>>> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>>>
>>>> Add support to download TRX firmware for PCIe and SDIO.
>>>>
>>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>>> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current 
>>>> linux-next
>>>
>>> Please fix the review comments, also Ping's comment that from and s-o-b
>>> needs to match.
>>
>> I have most of the changes addressed locally already.
>>
>> Regarding the SoB line, do I update the commit Author email (because
>> that would make more sense, cypress got assimilated into infineon) or
>> the SoB line email to the "old" cypress email address ?
> 
> I would say the SoB line is leading as developer's certificate and that 
> has the Infineon address so that seems more appropriate.

Let's add both to be on the safe side.

>> I am still hoping to get a bit more input on the TRX firmware handling
>> from Arend ... or maybe there is no further feedback ?
> 
> Took me a while before I looked into this. Can not offer much info 
> though. Within Broadcom code bases we only have a v1 and v2 defined for 
> the TRX format. This patch specifies v4. The only difference seem to be 
> the number of offsets and their meaning. Looking at the index 
> definitions I suspect this version accommodates signed firmware images 
> which is verified by the bootloader on the device.
> 
> Hopefully Infineon can/will confirm my suspicion and explain what SE 
> in .TRXSE stands for (security extension?). Anyways, this seem pretty 
> specific to (some) Infineon devices. Despite its history I would keep 
> this separate and specifically use trxse instead of trx.
OK

