Return-Path: <linux-wireless+bounces-11807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4F95B9FF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB0B1C20D3F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2D2D05E;
	Thu, 22 Aug 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BvI3y5kh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565681CC899
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340257; cv=none; b=LT5Gad7vrLOS35anB1il1DAVs+oR5NGUIUuu7157hCHNIWFCnhVUK5q/oYlN40Muc4phzGpP/PSSSegeeyioAOYeB0nm41nbkiZoSDN2eaj/yAlzVZRtZ+5VgFYpXSHz7T8ViUrRFqah1MCTnLGmuaMPjV+shd87f/+7tieEz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340257; c=relaxed/simple;
	bh=ifbdnDJW70+jw6bx/lsmpC2xoyRoOWyXmUWG0zvUBxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt6IAMKivZ4EkNXFgooj0vpkh98gwaGsvCSCAM3amCDSrWKCIt0dw5vosW2G37pXkonljZjq9ecxZEkK63n8PqUqkkIcp7/1ElMjDaUjw0D2Hu8UxyoaK2g9fpam7SoGw1aozRNrUesFTIdX1PL4AKID0HUGdHO04ITqGevL7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BvI3y5kh; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 39D4A88B23;
	Thu, 22 Aug 2024 17:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724340249;
	bh=RACoWArEhJL9Q0Mv0jj8WLbXpHtBHRU+ZVaHNzkMKu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BvI3y5khqEftd8/OwffBZxNrngIrxyTPwhEtkkoC8kn+RYjslzyftP+Mbzl+3RVaG
	 mqnXNyR28Rvp3LyMYK4og3bRUvRL/+6Cn0kBpJTuKhaskKqvc/KrWpYK1AjHuVA9Ek
	 q5lAzp6RNRRYOYdLoo12iDvCxm39IllNpMFZiTm0PJZEkHBOde84urAZ7ZbCsLJUhw
	 5he1aY0u2dnu1ijN5XJg9PXW0bG6ZPiKIp7gq8o7j30HLK4Xii5fTeq05Egs+eiFpQ
	 k37u1IedS/83mIpzSZhKVOCIpv4YMwS41U9nIFpvhqO6nNBwJo1cpndmZDxg0uHk/b
	 U92FocWwiUW3g==
Message-ID: <6129cf7b-59bb-440f-a277-69af63168e87@denx.de>
Date: Thu, 22 Aug 2024 17:15:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Chung-Hsien Hsu
 <stanley.hsu@cypress.com>, Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>,
 Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>,
 Kees Cook <kees@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>, Matthias Brugger
 <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev
References: <20240818201533.89669-1-marex@denx.de>
 <172431581868.2154344.15348672155352447310.kvalo@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <172431581868.2154344.15348672155352447310.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/22/24 10:37 AM, Kalle Valo wrote:
> Marek Vasut <marex@denx.de> wrote:
> 
>> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>
>> Add support to download TRX firmware for PCIe and SDIO.
>>
>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next
> 
> Please fix the review comments, also Ping's comment that from and s-o-b
> needs to match.

I have most of the changes addressed locally already.

Regarding the SoB line, do I update the commit Author email (because 
that would make more sense, cypress got assimilated into infineon) or 
the SoB line email to the "old" cypress email address ?

I am still hoping to get a bit more input on the TRX firmware handling 
from Arend ... or maybe there is no further feedback ?

