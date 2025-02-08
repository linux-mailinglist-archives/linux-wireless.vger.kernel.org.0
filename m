Return-Path: <linux-wireless+bounces-18653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4BFA2D60A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 13:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71D33A955E
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686A246335;
	Sat,  8 Feb 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="vwyh9bLO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F12451EF;
	Sat,  8 Feb 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739017266; cv=none; b=N9uEhsmCuyHotijLuw51RSe+36nHD0oFCHSx2JUpzyfyBJakZ4Q2a7wvSEPrARwJ3SRNFeCl/pzZkAIG5vI+couXL0D1sb9fY44YfrM64wagS1NZkFFKUnWYp+urndkdf4X1yLpko5B/f3H3pMZcasw7w/D/H5WakTD9GiV1GnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739017266; c=relaxed/simple;
	bh=8fodqG0U8+c2xusdvvvWyc0H7YK/RqBhN9WmRxmZCPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3tEkuYI4oyARTWhd7OOwKRkdmwwc2jqlzVbrOYZkzmeXirxKs+wvZ4lBVVwvP7sX5QodeeSyeSNbZ6vrPMDs1BO0ZaiqnT6BlAyeZycrnh0MsHctI82ZS+5UMD20zhljmQJBd8BrwWlppFNvVCB6LOVEXzLESGqzx7rJiU6Djc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de; spf=pass smtp.mailfrom=matthias-proske.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=vwyh9bLO; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-proske.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 9CB511006EA;
	Sat,  8 Feb 2025 12:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1739017261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUJ38qvwQM3hoY8TEcm9mcnQw31XAmWoeS10esRamn4=;
	b=vwyh9bLOUFe93iX018/NF+gSC5GIUJaBfx9z4/q9DPkG9YUx4hPJnr/xIfktVcwuSv3ZeC
	TG9XFI+O9Pfuz2d3RidlghOinEcCMH55prWBAwcQ1e8LHojHJm8sXwA4CHbxZSkS5LKTkJ
	rSYrqJYj6gvT+X5Du/exsIkMwer0qTo=
Received: from [192.168.0.2] (unknown [185.181.129.144])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 1F4193605AD;
	Sat,  8 Feb 2025 12:21:01 +0000 (UTC)
Message-ID: <efb9b9b7-bf56-4b3f-87eb-afd356453e62@matthias-proske.de>
Date: Sat, 8 Feb 2025 13:20:57 +0100
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
 <6aa67bad-5712-441e-a24b-f787474472bb@matthias-proske.de>
 <CAPDyKFooyDSPu7RG18sp9cV1ndRPpg5yia1BAiqtb-c3cOqv5Q@mail.gmail.com>
Content-Language: en-US
From: Matthias Proske <email@matthias-proske.de>
In-Reply-To: <CAPDyKFooyDSPu7RG18sp9cV1ndRPpg5yia1BAiqtb-c3cOqv5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 2efe2db1-830e-4b10-ac55-03a231ea7f13



On 2/5/25 1:49 PM, Ulf Hansson wrote:
> On Tue, 4 Feb 2025 at 17:25, Matthias Proske <email@matthias-proske.de> wrote:
>>
>> On 2/4/25 4:26 PM, Ulf Hansson wrote:
>>> On Wed, 29 Jan 2025 at 12:05, Matthias Proske <email@matthias-proske.de> wrote:
>>>>
>>>> Hello,
>>>>
>>>> I have a question regarding the usage of the Device Tree property
>>>> `keep-power-suspend`.
>>>>
>>>> In the Device Tree documentation it reads:
>>>> "SDIO only. Preserves card power during a suspend/resume cycle."
>>>>
>>>> Does that mean that the SDIO Host Controller will remain powered or
>>>> should this equally apply to anything that is connected to this SDIO
>>>> Host Controller?
>>>
>>> Unfortunately the documentation isn't really clear.
>>> "keep-power-in-suspend" means that the platform is *capable* of
>>> keeping the SDIO card powered when the system is suspended.
>>>
>>> Depending on what the SDIO func-driver (like the brcm_fmac driver)
>>> decides to do during system suspend/resume, the mmc core we may or may
>>> not keep the SDIO card powered.
>>>
>>>>
>>>> To give a bit more background:
>>>>
>>>> I have an embedded board with a brcm_fmac WiFi module. It seems that due
>>>> to a hardware limitation we are not permitted to switch the module off.
>>>> It simply cannot be re-probed afterwards.
>>>
>>> How did we manage to power it on and probe it in the first place?
>>
>> Sorry if this was misleading. By "we" I meant whoever uses our hardware.
>> I probably should have written "I" instead.
>>
>> I have a hardware with the limitation that I can only power off WiFi
>> whenever I power off the complete SoC.
>>
>> Was it fixed it in newer HW designs? Yes.
>> Is there HW out there with the problem? Also yes.
>>
>> How could I probe it in the first place?
>> The brcm_fmac module was responding because it was still in its initial
>> phase after being booted.
>>
>>>
>>>>
>>>> The property `keep-power-in-suspend` was used and that used to work fine
>>>> until 92caded ("brcmfmac: Avoid keeping power to SDIO card
>>>> unless WOWL is used"), which made the wifi adapter by default turn off
>>>> on suspend to be re-probed on resume. Not working on our board...
>>>
>>> Would you mind elaborating why it isn't working?
>>
>> I can no longer probe the device after the resume.
>>
>> [   61.390016] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>> [   61.390128] ieee80211 phy1: brcmf_bus_started: failed: -110
>> [   61.390294] ieee80211 phy1: brcmf_attach: dongle is not responding:
>> err=-110
>> [   61.426594] brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
> 
> I had a look at the corresponding code in
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c. Yes, it
> seems there is a complete cleanup and re-probe being done during
> system suspend/resume (it looks heavy and prone to errors, but that's
> a different story).
> 
> Anyway, it would also be interesting to know if the SDIO
> card/interface is failing to be re-initialized correctly by the mmc
> core during system resume. Typically, mmc_sdio_resume() in
> drivers/mmc/core/sdio.c should not return an error code, but it sounds
> like that is the case too, right?
> 
>>
>> I assume that I have this problem because I cannot power off the WiFi
>> module using the two GPIOs, usually controlled by a mmc-pwrseq. In fact
>> I don't see these errors with the newer HW revisions where I can toggle
>> the GPIOs.
> 
> With HW revisions, are you referring to different platform revisions
> or revisions of the WiFi module? Or both?
> 
> Anyway, in the past we have seen many issues with incorrect HW
> descriptions in DT in regards to the mmc-pwrseq. The mmc-pwrseq may be
> different both from the platform point of view and from the WiFi
> module point of view.
> 
> For example, maybe those GPIOs were routed differently on some
> platforms, but not correctly described in DT? Or perhaps different
> variants of the WiFi module need different power-sequences?
> 
> Just wanted to be sure that we really have a broken HW and not just
> the description of it. :-)

With HW revisions I'm talking about our own PCB. WiFi module remains 
unchanged.

And the GPIO handling works with our different HW revision. Also 
modifying the GPIOs to some different timing did not change anything. I 
just need to keep the GPIOs "on".

> 
>>
>>
>>>
>>>>
>>>>
>>>> I have also looked at other WiFi drivers with an SDIO interface and it
>>>> seems that none of them are really honoring the `keep-power-in-suspend`
>>>> flag. Is this flag for the SDIO Host Controller only?
>>>
>>> See above.
>>>
>>>>
>>>>
>>>> What would be proper way to implement it so that the brcm_fmac return to
>>>> its old behaviour if necessary?
>>>> Add a Device Tree property directly for the brcm_fmac driver..?
>>>
>>> The corresponding SDIO func-driver may call
>>> sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER). In this way, the mmc
>>> core will leave the SDIO card powered-on during system suspend.
>>> Although, unless it's really necessary, it's ofcourse a bad idea as it
>>> would mean wasting energy when the system is suspended.
>>
>> Just to get my understanding right: The brcm_fmac driver would be the
>> SDIO func-driver in my case, right?
> 
> Correct. The one that is registered with sdio_register_driver().

I guess I would just write a patch for the corresponding SDIO 
func-driver, adding a DeviceTree property directly in that SDIO 
func-driver (not the mmc host driver) so this can be enabled just for 
these specific boards, or would you suggest a different solution?

Matthias


