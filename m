Return-Path: <linux-wireless+bounces-18426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F0A2773C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA07164FAF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF29F21576F;
	Tue,  4 Feb 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="pzoGAQI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76432153E1;
	Tue,  4 Feb 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686897; cv=none; b=d0SlMSpmZ9H0dxuH7Q/KyAyguGV4U+/K/4JM/fgeVkmYoWnXBHoERBINY/c55GD3GPloHHlu46Ua//irWA9vTXMCZakFqBJYANovfouCaaUqSghHX1+G1fMS1KR/WQUAkB9fGn0QxsHlydf3GBvDtfbGEHwFWsxf0KiD8rf28LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686897; c=relaxed/simple;
	bh=JWuL72d2BMcYAzCqqX/ObYlKkPfRZMidUKhZETqEsxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nemZM9WQ43KzDPTaq+xoxwFglVxKo4PqBGJoSjiEQeAaF9bow/KRGaW5u0ZwzX02nQX8AJI+12lH3081QgiSxycYPqXPrLfZ4diV91yI2nlUADpvNZKtZ4K5EM/u49kcFDKyVNjfApaiUgGF/Xz3CdjsNFfXHwiiyDS4o3RtLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de; spf=pass smtp.mailfrom=matthias-proske.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=pzoGAQI+; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-proske.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id EAF7F602FC;
	Tue,  4 Feb 2025 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1738686340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhXltd/RAA4tdApb1z8cvqOm1VvOvEorkNbrJ/OD54E=;
	b=pzoGAQI+poPsyTwzAWxEYO4BKfBRcJUyOLra02Ze6DR9+rxM78WNRlsXiXQGajCPRH2IvQ
	ttXSlmi+sZJLZ2G4jNpGe1c4CkmH/BdhMZgpKtaEqLaU7KtAgQ6jXPeJpq6kSwLqYy72wc
	jSZ8EfHXspYnVv60HmqLOtkmJV0/tNs=
Received: from [192.168.178.89] (unknown [185.181.130.204])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 6F81E3604F8;
	Tue,  4 Feb 2025 16:25:39 +0000 (UTC)
Message-ID: <6aa67bad-5712-441e-a24b-f787474472bb@matthias-proske.de>
Date: Tue, 4 Feb 2025 17:25:35 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DT property keep-power-in-suspend and how WiFi drivers use it
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-mmc@vger.kernel.org
References: <cd1b13d4-b01d-4237-813e-bd48c55d9ca9@matthias-proske.de>
 <CAPDyKFr=XyLg2VjuEq1ZTrdAwSJJmYFDn9wSFj4zWD1+ZB9MTQ@mail.gmail.com>
Content-Language: en-US
From: Matthias Proske <email@matthias-proske.de>
In-Reply-To: <CAPDyKFr=XyLg2VjuEq1ZTrdAwSJJmYFDn9wSFj4zWD1+ZB9MTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 0bf1165b-eb46-4642-9087-12bc0afec4d0

On 2/4/25 4:26 PM, Ulf Hansson wrote:
> On Wed, 29 Jan 2025 at 12:05, Matthias Proske <email@matthias-proske.de> wrote:
>>
>> Hello,
>>
>> I have a question regarding the usage of the Device Tree property
>> `keep-power-suspend`.
>>
>> In the Device Tree documentation it reads:
>> "SDIO only. Preserves card power during a suspend/resume cycle."
>>
>> Does that mean that the SDIO Host Controller will remain powered or
>> should this equally apply to anything that is connected to this SDIO
>> Host Controller?
> 
> Unfortunately the documentation isn't really clear.
> "keep-power-in-suspend" means that the platform is *capable* of
> keeping the SDIO card powered when the system is suspended.
> 
> Depending on what the SDIO func-driver (like the brcm_fmac driver)
> decides to do during system suspend/resume, the mmc core we may or may
> not keep the SDIO card powered.
> 
>>
>> To give a bit more background:
>>
>> I have an embedded board with a brcm_fmac WiFi module. It seems that due
>> to a hardware limitation we are not permitted to switch the module off.
>> It simply cannot be re-probed afterwards.
> 
> How did we manage to power it on and probe it in the first place?

Sorry if this was misleading. By "we" I meant whoever uses our hardware. 
I probably should have written "I" instead.

I have a hardware with the limitation that I can only power off WiFi 
whenever I power off the complete SoC.

Was it fixed it in newer HW designs? Yes.
Is there HW out there with the problem? Also yes.

How could I probe it in the first place?
The brcm_fmac module was responding because it was still in its initial 
phase after being booted.

> 
>>
>> The property `keep-power-in-suspend` was used and that used to work fine
>> until 92caded ("brcmfmac: Avoid keeping power to SDIO card
>> unless WOWL is used"), which made the wifi adapter by default turn off
>> on suspend to be re-probed on resume. Not working on our board...
> 
> Would you mind elaborating why it isn't working?

I can no longer probe the device after the resume.

[   61.390016] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
[   61.390128] ieee80211 phy1: brcmf_bus_started: failed: -110
[   61.390294] ieee80211 phy1: brcmf_attach: dongle is not responding: 
err=-110
[   61.426594] brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

I assume that I have this problem because I cannot power off the WiFi 
module using the two GPIOs, usually controlled by a mmc-pwrseq. In fact 
I don't see these errors with the newer HW revisions where I can toggle 
the GPIOs.


> 
>>
>>
>> I have also looked at other WiFi drivers with an SDIO interface and it
>> seems that none of them are really honoring the `keep-power-in-suspend`
>> flag. Is this flag for the SDIO Host Controller only?
> 
> See above.
> 
>>
>>
>> What would be proper way to implement it so that the brcm_fmac return to
>> its old behaviour if necessary?
>> Add a Device Tree property directly for the brcm_fmac driver..?
> 
> The corresponding SDIO func-driver may call
> sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER). In this way, the mmc
> core will leave the SDIO card powered-on during system suspend.
> Although, unless it's really necessary, it's ofcourse a bad idea as it
> would mean wasting energy when the system is suspended.

Just to get my understanding right: The brcm_fmac driver would be the 
SDIO func-driver in my case, right?

Thanks for the feedback

Matthias


