Return-Path: <linux-wireless+bounces-11762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EB95A54D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 21:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE52B283501
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 19:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3D16DC12;
	Wed, 21 Aug 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="T7r5nGqE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588CA31
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268781; cv=none; b=H5F+Yui0Uj61K8Hq7sP24MeoMUuvmF9DUP8g/UjNTdWq7XkcEOUPr6M0cIN33jQN5i3iRGLVtgMpqn1moU4U70Qe4YYfWntemXZnpSF5kCvydfasC55uArrDo92Lhl/KfCVIWfCziQcBKMVdEnd6ItjAsF84VOyQB6h+0LzqT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268781; c=relaxed/simple;
	bh=ljwy/vdQYzq0SlCleqiGWnPhL6kZGy2OwVYbA5OpAmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXf7Ded58aDmeb+qOJe3g8c5g+vhKhHa8zTm307kw8sVG5SLgh9wkP4CzOcGDSciDx0Su8LAcD+ufaJXF9R4Iw+/ziN0hqIBHNGMfNNoLCIDn0uYC49VpwxGeluqBMQnleYlJCTZOql5Vps3+fqlLl17OnVEZPXWoKoZAg767EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=T7r5nGqE; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 64C718690D;
	Wed, 21 Aug 2024 21:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724268778;
	bh=Aa6MrW3Cdn81LBB6tl4whpJwkasBOOCzwE4lpYpxQgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T7r5nGqEfXuFsjCkkdEn1JqaLXk9fS23vOJl+8cllRu4Q+ZAj2N/Ev+9pt/y+rt8G
	 6vGpivfzt1ALgKxkyguXj20GFoqEm3T7Uq6mVb7jK9PomDhRm3olH2z0bIx89bH2kQ
	 CBjEA4Zt9EEJCYY6ge2MpPbQe2S60XD8B0qJz6bMBnM7shN0q4t9EHp2sp0t8RlK6r
	 U59lhn/zMxnIznvDp4enn4ZzlLCtgoWq0AVSzKNK1YGV2uGOWGU/8t20SnFCmrFL8E
	 psAIFSyIiplH0RGTJau2wO+k/VPHgjSM3r2IlXos9ffAZWkrvKwgH+aI18Ylh3vk2o
	 3rKS0fKS1lKZg==
Message-ID: <533967a1-c01a-4c48-868f-25056a5d20d0@denx.de>
Date: Wed, 21 Aug 2024 18:10:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
To: Florian Fainelli <f.fainelli@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
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
 brcm80211@lists.linux.dev
References: <20240818201533.89669-1-marex@denx.de> <871q2ky3zm.fsf@kernel.org>
 <1916b572558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <c95f64f1-3ebb-41ca-a935-51c1efa1256a@denx.de>
 <b04c01e5-3e60-4b0b-8984-9d6e0782f5af@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b04c01e5-3e60-4b0b-8984-9d6e0782f5af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/19/24 8:09 PM, Florian Fainelli wrote:

Hi,

>> I did notice just now there is some TRX support for USB broadcom 
>> devices ?
>>
> 
> TRX is a format that is also used for partitioning flash devices, so 
> there is probably some room for making a common header:
> 
> ./Documentation/devicetree/bindings/mtd/partitions/brcm,trx.txt/drivers/mtd/parsers/parser_trx.c

Is that format somehow standardized ? I recall it was used on some 
OpenWRT routers ?

It seems the TRXSE (whatever it is) is used more like a carrier for the 
firmware blob (chunks?) which are pushed into SRAM (?) of the CYW55572 
device.

