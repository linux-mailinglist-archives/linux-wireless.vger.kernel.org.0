Return-Path: <linux-wireless+bounces-13282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E3989652
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 18:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977682840A1
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842E16E892;
	Sun, 29 Sep 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GTNpefNf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150E79FD
	for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628960; cv=none; b=Hisdx25j9Nwbv4eZe0A3q4BgZun69z4TDEHPHoHTMKXQxjiddkdZdJOcSv8CFs5hayGNWzlzPXzmjzIqkLWUDAMM8Q2dwAfmO8auuhVtB24nl77aQeWOh6wgEC7vImHTcZm5AVUyEd885gSelRzFuqEWcPR776v4BoHZrSPwOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628960; c=relaxed/simple;
	bh=evl46cONqR6tsRQcyvoDdwMddYZCAtKVBnEfgVbv4sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbB5ze/z3czTvcdFBU3uD2WYm1rZAZAZcDum+iZfBEJfvf+JjDF3PQ6++AhfUPSBHo94rEJ/XTYGuBKW6L+EhOiC79xLeKtiDddeMGJelmeF4CVRS7xwordi58s7myQXXrQurPnhdwZ/IbhZfVs9n+hGwLC+8PH2erkLVciMMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GTNpefNf; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CBAD388785;
	Sun, 29 Sep 2024 18:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727628956;
	bh=7ZiQ4+DijJ8oJQiLFtV/oJHTFvJ3YDk26aBwWL3fOQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GTNpefNfXaXaCwzQoF03ogZbEox7eO8tMmYLjNMHBtgQeW5aNnijorAgfQW1RF/JK
	 vUWv/51+bh4Sw+fd1D8K5WLYOdogn3O7g4eqWf5bPMGHYp8s2fqErIPhV+Vjvyjm/D
	 WjxrRZU/DsNxdsYcep+/43BgG8yR3sWy0Gvaw4xv82cSP8FXNT2nwwYfY4lYEhoA+e
	 3EmLbLDeFqiydDzCqnVB5MfdsMrS/I14nBynUUUdr10hqUtSWXJc3t4pCCZwwXIu4D
	 7l80lBW5n9qHfl4Wdzgfmcnnkgp0lJI2FeSi60MxY3XPDpTRtwQwaCYmF0YmGL+0OR
	 KgNErpBu6Pt8Q==
Message-ID: <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
Date: Sun, 29 Sep 2024 17:23:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240926195113.2823392-1-marex@denx.de>
 <87ed5481ro.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87ed5481ro.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/28/24 1:18 PM, Kalle Valo wrote:
> Marek Vasut <marex@denx.de> writes:
> 
>> The WILC3000 can suspend and enter low power state. According to local
>> measurements, the WILC3000 consumes the same amount of power if the slot
>> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
>> off. Use the former option, keep the WILC3000 powered up as that allows
>> for things like WoWlan to work.
>>
>> Note that this is tested on WILC3000 only, not on WILC1000 .
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: linux-wireless@vger.kernel.org
>> ---
>> V2: Rebase on next-20240926
> 
> BTW I recommend using wireless-next as the baseline for wireless
> patches. For example, wireless-next is not pulled to linux-next during
> merge windows or other patches in linux-next might create unnecessary
> conflicts. Of course most of the cases using linux-next is fine.
I didn't know there was one such tree, added to remotes, thanks !

