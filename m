Return-Path: <linux-wireless+bounces-11616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90D956947
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 13:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768A928141F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1C142900;
	Mon, 19 Aug 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="rjoTLjh9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F16160873
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066676; cv=none; b=Mt9FoQucaSWcDWqZ8s5WqmDxxVCuSD57RMj1ZSsrYj8bNUtzG4JEZXG/Hc1r3RxvoTVOi2bEAY6TfANZD9isfUFOKJde/9vtA3/4h/EcbDPXR+29Inxn2yhJ6JFL1wEHMhx/X3rTnNXvdTvok57St7ZvQfRmlcwQlysCyHueX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066676; c=relaxed/simple;
	bh=07MBuIxs6/LBQhgoQiz21L1NSCc20DOXsCTb3zK8D98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUPtZyDEEjmu3LL74npV/0OSJbPFqEbdoXV5JKqvoDPIgfvbvMo+qixy/v3BCqKHzBrSLN2v0ZmvfDauCCURbGU9PHifOodCxqtSD/ItMlkDPo0pyKspjCSGLUOSUUBtxJeQfTIrSCkKwx71pSi0mj8KYN7QjIcocNCYYVMiPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=rjoTLjh9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1E2C988744;
	Mon, 19 Aug 2024 13:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724066671;
	bh=AM2+cgjvNwBJieFm20b0iY2p/mYLOAeVO/RempMOqT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rjoTLjh9Wx4UEWM1r+6qnw4p49PkTcXsH+Hgw2hdO8Z8EhfHCn7MPWHf71JXbm7ZU
	 a/m25WUbT3g0aFrajjeCiXVmwiFuDqf1FQjkPmYcujsXHVNo++v4ivI9V+6rFUwgNG
	 TMfQvtlaZ2JzWPEhH/s7Q7AWUnQ+Emmt5xiSyc2QlMk1IgGENswD3yjsYkJ6SwyQFd
	 D7DWiNRoGaHWu0esmOXiAxJzTwD5Zq3PniF8pr3HJY4SProbsYJG/Jn3BfXsrO+w7D
	 Au9b3hyBAbOPv7GloX7jaEl8GJcEFYoX3prdXYKhhRmsJtwtvMRcJqoiYKKEMxHFmK
	 ywELl0Gy3/Tyg==
Message-ID: <55eb179d-0b8e-45cc-9389-7776b3822855@denx.de>
Date: Mon, 19 Aug 2024 13:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Chung-Hsien Hsu <stanley.hsu@cypress.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>,
 Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>,
 Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>, Matthias Brugger
 <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
References: <20240818201533.89669-1-marex@denx.de>
 <582df73b7004435f8f0144cbfb1cd3f0@realtek.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <582df73b7004435f8f0144cbfb1cd3f0@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/19/24 5:08 AM, Ping-Ke Shih wrote:
> Marek Vasut <marex@denx.de>
>> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>
>> Add support to download TRX firmware for PCIe and SDIO.
>>
>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> 
> The email address of From field (author) is different from first s-o-b.

It seems this is a result of cypress being assimilated into infineon, it 
seems like it is still the same person though.

