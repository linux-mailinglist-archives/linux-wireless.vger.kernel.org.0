Return-Path: <linux-wireless+bounces-13466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C598EDFE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB993B23A03
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC114F104;
	Thu,  3 Oct 2024 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="lS5PG2wO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2C126BEF
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954374; cv=none; b=SANa34OxqrM6oWlFnENvs8Os14wZdHdMH7BUUnmc+WLybtbH32D3Qp5ygxRM3Uo3j1u4xtP4kDrIamnMjoFH5iDW2yuowx6qoaco+ADVXk4q6ZQP7FzMY9e3IuAXKOU5kNPwgTQEiH0WCUQFEZemKrj1r8SYuxbfRIRZW4+HVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954374; c=relaxed/simple;
	bh=XEtri4sAeHvGMHuffB0lO3Eeg8bj3Y6aIoOpdhEtoNs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qb/GfhlukuuLr6MzA7+BsFDA9yK6RVqHF46LpzH1M1pwrOau4pg8wNCevRzjvCcluMU8+m7IRS81K9h4uT7ymUR2aQE7U0WcTwj2l6X6tMOH0Ff9gIG47QQ0gNhXGGjcbHgbkEsRYIf0C2zqE7VuvGey64EsNW7/ngw+kGblLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=lS5PG2wO; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6364588B11;
	Thu,  3 Oct 2024 13:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727954371;
	bh=StINGKoUa7nniTXnb21w3B++99Gca8geDCyPpEwGc0c=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=lS5PG2wOwQekcD4JRpDy/S/v/vKQAJ70rAsboPb79otObdmkB8wQpeXg5kGk7F/0Z
	 qjv6LM3SRLjJ2j9G7EN1mXl88MPzzC5/lKpCXCa/buWtyDiTbAIBM1Wve1SuYbwgSz
	 aGKyf9b0KAcLO2oAioZF86IYO9zi7TjbkvXdXZoI/xOhXjhQvgDh7t3Mews1TowH6/
	 N1CWc7MJN7AJfxZYv4/9noTTRbJBbG+nkNZHer4ozTNEcV+gevhWNsa7dccppwu7RP
	 gb5AKW/T6xYOr72BPwwFQ51HP793+7Qar2BlHzUZr8XPBu9MnZgOyqqM9S3q/j1su+
	 yetgE0qSBxxMw==
Message-ID: <1e7351db-366b-4e4a-b423-92867f24cbb5@denx.de>
Date: Thu, 3 Oct 2024 12:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240926195113.2823392-1-marex@denx.de>
 <87ed5481ro.fsf@kernel.org> <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
 <372e6f65-79f1-4a64-a323-2939269a8a45@bootlin.com>
Content-Language: en-US
In-Reply-To: <372e6f65-79f1-4a64-a323-2939269a8a45@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/3/24 10:31 AM, Alexis Lothoré wrote:
> On 9/29/24 17:23, Marek Vasut wrote:
>> On 9/28/24 1:18 PM, Kalle Valo wrote:
>>> Marek Vasut <marex@denx.de> writes:
>>>
>>>> The WILC3000 can suspend and enter low power state. According to local
>>>> measurements, the WILC3000 consumes the same amount of power if the slot
>>>> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
>>>> off. Use the former option, keep the WILC3000 powered up as that allows
>>>> for things like WoWlan to work.
>>>>
>>>> Note that this is tested on WILC3000 only, not on WILC1000 .
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>>>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>>>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>>> Cc: Kalle Valo <kvalo@kernel.org>
>>>> Cc: Marek Vasut <marex@denx.de>
>>>> Cc: linux-wireless@vger.kernel.org
>>>> ---
>>>> V2: Rebase on next-20240926
>>>
>>> BTW I recommend using wireless-next as the baseline for wireless
>>> patches. For example, wireless-next is not pulled to linux-next during
>>> merge windows or other patches in linux-next might create unnecessary
>>> conflicts. Of course most of the cases using linux-next is fine.
>> I didn't know there was one such tree, added to remotes, thanks !
> 
> +1, as already mentioned in previous revisions, I would gladly test wilc3000
> changes on both wilc3000 and wilc1000 on my platform, and having the series on
> top of wireless-next would allow to do it on top of any change also affecting
> the driver in wireless-next :)

I just had a look at a diff between wireless-next/main and next/master 
20241003 for drivers/net/wireless/microchip , there are no changes to 
the driver between the two trees, so it should be possible to test this 
patch on either tree. Can you give it a try ? Ideally test this patch 
separately on WILC1000 across suspend/resume and check if it works. You 
might need the MMC controller fix which sets struct mmc_host .pm_caps |= 
MMC_PM_KEEP_POWER for your controller , unless this is already upstream.

The WILC3000 series depends on this patch.

