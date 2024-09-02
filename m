Return-Path: <linux-wireless+bounces-12343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4F5968D0D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94F02813D8
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B714287;
	Mon,  2 Sep 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MsSkAo5y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF31A2635
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300110; cv=none; b=m7ga9UBVdI/d83OwKStPubaikXJs3wWbR9lMK2af9MhIts6Mbi94S3p1qkFNr65qOzxpeJQe2gllN2XTJswjhaaGprMmoFy5QeeghSRIsAIcguKtRLyZmDnudW7YIbijSnKeiqZ+picUMIR0k89jHlUZj0uAeEAaqSpeV6vgZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300110; c=relaxed/simple;
	bh=+ayKrzV+yN2O5mVCbOdT51jWFVhI8wxt3yqIwgNd3hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtV4iWru4uI+IWeek3w8+qlR+1fYHYkHbbRjKsQZqwX6Cbb6cimPQq/QfweAaocXZXTTtBffRLkeREnngulgG7fzDbhu8NqxdxkmjriPDdb00npsfLXB/87CLEUxvCBI9awcSBe9wDx8SkPGgoXSSt0PS7TENbv95URHJLpxP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MsSkAo5y; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 17BA4881C1;
	Mon,  2 Sep 2024 20:01:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725300106;
	bh=x1VfyL552TpV5DZ44UjvtoPTymolqi8zxS0K6tIDc3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MsSkAo5yg/U0P5Ve4yhzth/a/jInZEOYtKItSvFobqJsHo8x3mPkfXZd+UzHpZsra
	 aXi7wkb4bICGhoB4NA8wmV+VlBWql4F0NCyanMlxWOcRtMm9N2eiw+rygNTcfWFcRP
	 YaNj+tMx/4Er36JrwBp5I5LnAR9P5COdekb1xlRStzttSw+GFgX3HLtQS6h2/yosnu
	 9Xg1P6pGM16r+ZNL+Ejbo0wxHLuD2hBZ3rCd2qXjvFFZxVxaHrEwmybDfm6BHUQoqU
	 SP9oIVmcXeJUZY8dUNcPyDDxJP1pTgBwixI77K1De6uIypw/d5AvqG+Bo65O4F/i/b
	 82rI+9AZ3movw==
Message-ID: <2d5f4d63-ab91-40d6-ae0c-81d4bc847fbf@denx.de>
Date: Mon, 2 Sep 2024 18:43:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
 linux-wireless@vger.kernel.org, claudiu.beznea@tuxon.dev
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
 <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
 <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
 <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
 <ae40b138-77ad-4044-9448-784be6964195@microchip.com>
 <12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de> <874j73e1dp.fsf@kernel.org>
 <5ba25a08-dc7f-4eb6-8982-e7a246178ba0@denx.de> <87ed62kodu.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87ed62kodu.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/2/24 6:32 PM, Kalle Valo wrote:

Hi,

>>>> Since this driver does not reload the firmware into the card on
>>>> resume, the card has to be kept powered on during suspend/resume
>>>> cycle. The card can NOT be powered off during suspend/resume cycle,
>>>> otherwise the firmware is lost.
>>>>
>>>> Without this flag, the card may be powered off during suspend/resume
>>>> cycle. It possibly does not happen on the Atmel controller, but it
>>>> does on the STM32MP15xx ARM MMCI one.
>>>>
>>>> Now, since the card does consume about the same amount of power
>>>> whether it is powered OFF or whether it is powered ON but suspended, I
>>>> opt for the later option -- keep the card powered ON, suspend it, and
>>>> that's what this patch does. This also allows us to support WoWlan
>>>> then.
>>> Are you also taking into account hibernation? During hibernation the
>>> device will be powered off. I can't remember the details right now but
>>> wanted to mention this.
>>
>> I don't think I am. Isn't hibernation actually a full shutdown, so the
>> hardware does get reinitialized ?
> 
> I don't know how it works exactly nor what you exactly mean with
> reinitalized.

My understanding is that hibernation is suspend-to-disk, isn't it ?
(that's not something that is even available on my hardware)

Doesn't the hardware get completely turned OFF during suspend-to-disk 
and then turned ON (and therefore initialized again) on resume-from-disk?

> But at least with ath11k hibernation didn't work when it
> left the firmware running during suspend.

Is there a thread on lore or some details of this you could point me to?

