Return-Path: <linux-wireless+bounces-6146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C18A094B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 09:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF1A1C20756
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DBC13DDC5;
	Thu, 11 Apr 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku5tSdxO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DD13DDC3
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819332; cv=none; b=mHWG3JZ4BU1Imv+BKMeQAf6xzxkz44vnhEODAMUSXObB8YiCjFaqGXDFRwHUr1My84LFU7Qrimi9cv6G59XWCVqIVoeiJs0AWvP+mSY+zXXTrTsUROItuOv0l9CQc1OFmcG1HKHbnFOJi+OCkGgPTT/wpbl7oi/JjSdGXGC98I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819332; c=relaxed/simple;
	bh=JOiGvpeX5ent4J7D33rKQHoM/IvqydTc5RevJ+ufxLI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l8u4xEkOsxR2sXm64Q46wdjIiEM9wRHlDviSrsuSONxqz+7ZVuN1a3xM9kmD82Z+K/oolzagBSu6hucNoJoTbaGkc6gxeDq3aC8np6ZOfbtS6XUb/rNEMXBdcdzwiVlPcSrkEuqLQmkYYsaLqi3NdPBP0OADJ2onCFdfkOq6P3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku5tSdxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571A4C433C7;
	Thu, 11 Apr 2024 07:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819331;
	bh=JOiGvpeX5ent4J7D33rKQHoM/IvqydTc5RevJ+ufxLI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ku5tSdxOPHLXw8+75hytUR+u3j29Vj9wgoIe9a72RjzNcXIvNMh0mL1TRaHEXPhng
	 4K+FFu49pCwp1dQug9kuatJxe/GyBtx/y7yMlrMbu1OJzBINX2aWA2gR8limGLUf6e
	 K+bKSnp3rBEHmIBQrEuRK99Oil4dHV7/Y5ywH/zxbmz4Z2Y3coOrtYb4v1bBDQobrk
	 7QeOn4YCRuvc1msyXuvJILvzeTw0b2e6RaoYzzMyJUZGlT11tN1+z83WUwjYjGWSfx
	 lrq5qDyBpFTm9k3wCCz40iZmeMsc3j8BPvGRNBth7+YFxjxDBfnVeyIVmZfMkT8NhK
	 oq27p4zpOlekw==
From: Kalle Valo <kvalo@kernel.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  Larry Finger
 <Larry.Finger@gmail.com>,  Johannes Berg <johannes@sipsolutions.net>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART
 Bluetooth
References: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
	<5af71338f3904aac9d2c237637c851e7@realtek.com>
	<287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net>
Date: Thu, 11 Apr 2024 10:08:47 +0300
In-Reply-To: <287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net> (Larry
	Finger's message of "Wed, 10 Apr 2024 21:47:58 -0500")
Message-ID: <87o7agjs00.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(dropping stable list from cc)

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 4/10/24 9:13 PM, Ping-Ke Shih wrote:
>> Larry Finger <Larry.Finger@gmail.com> wrote:
>> 
>>> As discussed in the links below, the SDIO part of RTW8821CS fails to
>>> start correctly if such startup happens while the UART portion of
>>> the chip is initializing.
>> I checked with SDIO team internally, but they didn't meet this case,
>> so we may
>> take this workaround.
>> SDIO team wonder if something other than BT cause this failure, and
>> after
>> system boots everything will be well. Could you boot the system without WiFi/BT
>> drivers, but insmod drivers manually after booting?
>
> I sent the request to the user with the problem. I do not have any SDIO devices.
>
>> 
>>> ---
>>>   drivers/net/wireless/realtek/rtw88/sdio.c | 28 +++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
>>> index 0cae5746f540..eec0ad85be72 100644
>>> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
>>> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
>>> @@ -1325,6 +1325,34 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
>> [...]
>> 
>>> +       mdelay(500);
>> Will it better to use sleep function?
>
> My thoughts were that a sleep function would tie up a CPU, whereas the
> delay would not.

It's actually the opposite, msleep() allows other processes to run.

"In general, use of mdelay is discouraged and code should be refactored
to allow for the use of msleep."

https://docs.kernel.org/timers/timers-howto.html

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

