Return-Path: <linux-wireless+bounces-11625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2895721C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03CE1F24E90
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1617BB13;
	Mon, 19 Aug 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JNERJ4sR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EB176233
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088453; cv=none; b=t6xvuEfC5xjVTZ2VCZpexMZl0UYricxfgNl1iZiI9gA/NzilZrlQZe1dXSQRLZ22nt841pvEODZloq1cdwW/gM/OsDvgDOVCsaghktZGQrYrE5U8TT+e657PZ2yUks+88heQ3hAhwgDxtHf/J6xsHDYw5yO5iK0B0jzQmI9LFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088453; c=relaxed/simple;
	bh=hTfwFKXYoARyydlpwnLuxqntQd77HK/80uMH9D3P2Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLipW/gg+yw9DA8Va0+0/rLY2ryJbW9F9dGuw8dYSKEPkGCcW+gXQeA9HDDL2VZIMQRpcVzBSPEJpn4Wmt5AJx8Y+ZjU/epyNRaxadCr2fwBMOrRvEZaaLImjkwYkczoGxIvfh0WVwGhSZ+CLdlrCF9OAUkGcYR6unTGLX8BAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JNERJ4sR; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 60288889C3;
	Mon, 19 Aug 2024 19:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724088450;
	bh=7gc151XOf+lmvySRQy5rZURSjAIrtYF4N3ANDzi7s+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JNERJ4sR1kVvUTFSwHW0cTnzQ0XKFwE8dmTS0dSjhlvdv/w5aIEOQctOL07Rfu8vj
	 UWbZcYE3pUYg4RuaqijwO3i79/p9w0UJQBMQ55Ldn4qaQyrrfyiw+Zu/VF5gC6ERKK
	 WXZlXAx97vHZCIkDps0Z0TGt3Bjj1qZjfLATmxj2g/j8TDMCYneHF5jVZayrcj7oCO
	 2ga+FHaKVXu2wkAyTsukN9HoPS2KQ4OdPNlrMV64PpJeqdHK1ISSYk7lAAjEGvPxoJ
	 Zvs4tQz6LK4+pPXuSx8pxABhJIJ7v8V0l+M/sEagyc0xrwJxvUQ8WJfe01Lc1RR+iB
	 G3P4x8jmKASMQ==
Message-ID: <c95f64f1-3ebb-41ca-a935-51c1efa1256a@denx.de>
Date: Mon, 19 Aug 2024 18:17:37 +0200
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
 brcm80211@lists.linux.dev
References: <20240818201533.89669-1-marex@denx.de> <871q2ky3zm.fsf@kernel.org>
 <1916b572558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1916b572558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/19/24 5:52 PM, Arend Van Spriel wrote:

Hi,

>>> Add support to download TRX firmware for PCIe and SDIO.
>>>
>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current 
>>> linux-next
>>
>> The commit message should answer to the question 'Why?'. What's TRX
>> firmware and why do we need it?
> 
> I looked over the patches, but did not sit down to comment on this.

Thanks, it is real nice that someone who is actually familiar with the 
hardware jumped in. I only upported the patches from infineon downstream.

> The 
> TRX firmware format allows multiple images and possibly compression. Not 
> sure if Infineon is using all this functionality. This is probably 
> needed for 55572 device support (patch 2/2). Turns out this device has a 
> bootloader that the driver has to talk with and that is probably where 
> this TRX support comes from. Not something I considered to happen for 
> SDIO and PCIe devices. There is always a puzzle to solve ;-)
> 
> Also noticed a random seed is provided to firmware. This already there 
> for apple chips so it should be looked at whether that code can be 
> shared. I will follow up.

I did notice just now there is some TRX support for USB broadcom devices ?

