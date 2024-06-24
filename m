Return-Path: <linux-wireless+bounces-9497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9046914809
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 13:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E702B21D1C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B578137753;
	Mon, 24 Jun 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs1HUbX4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E51369B1;
	Mon, 24 Jun 2024 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227277; cv=none; b=LPiyPZFEpkfCHDL4LzftsP2WpDo8FM9lglT33x4f6RdZ8deqimfnrf96ywTXIfFYFQYUrJL3X9GFzs8tXWJir4ZiCKnxSWMtaqqurjp+QpS3f4NLil4nG39CAUiytqEdm1sGldDjPneRYY20mPm4+qGdgkrF8JZ2SlxbqbmCRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227277; c=relaxed/simple;
	bh=ogdxO09Aw+q7fzqXK98EasQIY/VuYqocCS1dTm1kZ20=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RpB9qqxKWl5CxjkFT+UfeXQh+SarRE2n0LZ3U+pei3OgC1F2wDxADj9dT9nhRhXzXv7MydMuEdgyR+6gze0Db+M6D5VVX2DrMMGcbevbhHqRxvjv9V892LdcJDUULQ1b5WrdNYXiiT1wkeXU9KDm9eJgVRNPtiJ5AVtSe2NvYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs1HUbX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8083DC2BBFC;
	Mon, 24 Jun 2024 11:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719227276;
	bh=ogdxO09Aw+q7fzqXK98EasQIY/VuYqocCS1dTm1kZ20=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Vs1HUbX4sXoW34LAYYbq2XW4z0ePo5VUwmfycsE/i+8rRUB+JaED2Qdj7jB+4sKir
	 n9UeLiP9oyFPJTg9isQdZuil+ZYjDNtMqDqCIP0JGKlNGu6lXtAM17Q3PE1XPAsyg6
	 KmLg+VpAGFJhe4EqG9N9kH/U3UC/gDaO6t+s24EtDEl1mnr+/8oBOkP1TU8+p3MMRO
	 utSJHyiPCnZNupX7MBag1I7WWKh3IFCSowM8PuWZ3iOAhw1aKh5gk9lgXC4X7cxkpS
	 XpiKDIrc+seo1UKz7VIkkYOiHjGBRbLqga4sFSXPB7ZNhwV8IZHMsScg5+kBeRR/0l
	 98pUji/jS2GJg==
From: Kalle Valo <kvalo@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  David Lin <yu-hao.lin@nxp.com>,  Francesco
 Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
	<87wmmll5mf.fsf@kernel.org> <ZnSHcZttq79cJS3l@google.com>
	<ZnVCzx3-pvbcYQLm@pengutronix.de> <ZnYDwjS293Cb8O1f@google.com>
Date: Mon, 24 Jun 2024 14:07:53 +0300
In-Reply-To: <ZnYDwjS293Cb8O1f@google.com> (Brian Norris's message of "Fri, 21
	Jun 2024 15:50:42 -0700")
Message-ID: <87zfraha46.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brian Norris <briannorris@chromium.org> writes:

> On Fri, Jun 21, 2024 at 11:07:27AM +0200, Sascha Hauer wrote:
>> I am running plain wpa_supplicant -i mlan0 with this config:
>> 
>> network={
>>         ssid="somessid"
>>         mode=2
>>         frequency=2412
>>         key_mgmt=WPA-PSK WPA-PSK-SHA256
>>         proto=RSN
>>         group=CCMP
>>         pairwise=CCMP
>>         psk="12345678"
>> }
>> 
>> wait for the AP to be established, <ctrl-c> wpa_supplicant and start it
>> again.
>
> Thanks. I still can't reproduce, but that's OK. From your fuller
> description now, it seems it depends on the particulars of the bss
> indices in use, and maybe my device/firmware is behaving differently.
> Anyway, your current description and patch below make a lot more sense.

Indeed, this makes a lot more sense. Thank you both for getting to the
bottom of it!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

