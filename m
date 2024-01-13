Return-Path: <linux-wireless+bounces-1877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633A82CCBB
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 13:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84B3283B32
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A021106;
	Sat, 13 Jan 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJC1XS8q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122C17BDB
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 12:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FCFC433F1;
	Sat, 13 Jan 2024 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705150346;
	bh=r4J2teQ8JFRhqzsOZabxx7oBbE4IBBjUw16HhgLQwFc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eJC1XS8qJaI3bK5rFgOo2wq09dv5ZpTVh7D9ixTNjfrl3UAMC6CCb0DMuyratin3g
	 Qmw878dD120m2sktrHKkUcWqV6LC/36rvih1gBkw15+tgP43jWNhXTJ0nvKmsQRAMM
	 lU8KYeZ0cfrIQpsRjCCZ+Iw6j1pp+m2vZpRYDIAZUGJBtkoBstG7wl6W2biwjrZ2wI
	 xE9QPIsBpwxCmsdz+7A/AGBV7ShgwhpZtjYOe9gGbo0LsmaNK8Sybv7kORi9A+v1Vm
	 UlbQZ8ZFXh/ufe/LJcZjKOLO65+GrvJ28FWAr1OSOdNPGN7a7QzKezJtjezXVBRpY3
	 kSL0dVepNnuBQ==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>,  Larry Finger
 <Larry.Finger@lwfinger.net>
Subject: Re: wifi: rtlwifi: Speed up firmware loading for USB
References: <6351ca3f-6b06-4fe1-ace7-6e9d67497dce@gmail.com>
	<87o7dphha3.fsf@kernel.org>
	<e72fdcf0-2d2c-496e-a9be-8b554dec9fd4@gmail.com>
Date: Sat, 13 Jan 2024 14:52:22 +0200
In-Reply-To: <e72fdcf0-2d2c-496e-a9be-8b554dec9fd4@gmail.com> (Bitterblue
	Smith's message of "Sat, 13 Jan 2024 14:08:45 +0200")
Message-ID: <87v87x8kft.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> On 13/01/2024 08:35, Kalle Valo wrote:
>
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>> 
>>> Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
>>> (and 11 seconds for RTL8192DU). That's because the firmware is uploaded
>>> one byte at a time.
>>>
>>> Also, after plugging the device, the firmware gets uploaded three times
>>> before a connection to the AP is established.
>>>
>>> Maybe this is fine for most users, but when testing changes to the
>>> driver it's really annoying to wait so long.
>>>
>>> Speed up the firmware upload by writing chunks of 64 bytes at a time.
>>> This way it takes about 110 ms for RTL8192CU (and about 210 ms for
>>> RTL8192DU).
>>>
>>> PCI devices could upload it in chunks of 4 bytes, but I don't have any
>>> to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
>>> rather than as dwords") decided otherwise anyway.
>>>
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> 
>> There's another version so I assume I can drop this one:
>> 
>> https://patchwork.kernel.org/project/linux-wireless/patch/0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com/
>> 
>
> Yes, you can drop this one. Sorry about that. I forgot to write
> "[PATCH]" in the subject. I thought you wouldn't even notice this
> one because of that.

I think patchwork assumes that any mail with a diff is a patch, like
this one:

https://patchwork.kernel.org/project/linux-wireless/patch/c7b331edd65b66521a6605177d654e55051568a3.camel@toradex.com/

So "[PATCH]" is more like a visual clue. BTW usually it's a good idea to
mark the next mail as v2 and explain in changelog what happened/changed,
that way everyone are on the same page. But no big deal, just trying to
make this smooth for everyone :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

