Return-Path: <linux-wireless+bounces-1705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB382AC71
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AD11F20C9E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884C14AB7;
	Thu, 11 Jan 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU3ZFnmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81B14AB2
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 10:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAC4C43390;
	Thu, 11 Jan 2024 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970161;
	bh=2BwsaHH3RaECoGSLr9kkKwt5y19AQVc+35+9uREmYFQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WU3ZFnmzV9e0gUDD9/IJX9F9Tc3j6m6txyHXCgiyomWY7FWM3BQsC8cWNixE1TTXZ
	 Xrluo8NENCieT40hGO4hesBPMIetTv92Dg/fFKEzcO+AS175CHVLXLAGJpDISPOxgY
	 U5KwIdVrd3STkHD+k65yA8mbOWpd843Aj+xK/31fsG12yhDTDUtf32HfGN6Sm/P+ur
	 myqfuXLMOYdCzK+X++h430wYmCDROtzO4SzYQG51BvSsPJRAI0Of+0gd2PJkhWhVTz
	 nP1be/nDfOJQ9UsbWyAExlMLU5c//+VIKtBqZimXlT89qDqeNA/GS76Z68UgbCwTNG
	 +Qvcq9tx0SsAQ==
From: Kalle Valo <kvalo@kernel.org>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: linux-wireless@vger.kernel.org,  chunkeey@googlemail.com
Subject: Re: [PATCH] wifi: p54: fix GCC format truncation warning with
 wiphy->fw_version
References: <20231219162516.898205-1-kvalo@kernel.org>
	<cf644ed2-6d75-4fc5-9a56-34541ef8eaff@gmail.com>
Date: Thu, 11 Jan 2024 12:49:19 +0200
In-Reply-To: <cf644ed2-6d75-4fc5-9a56-34541ef8eaff@gmail.com> (Christian
	Lamparter's message of "Thu, 21 Dec 2023 20:53:49 +0100")
Message-ID: <87edeoi1qo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Lamparter <chunkeey@gmail.com> writes:

> On 12/19/23 17:25, Kalle Valo wrote:
>> GCC 13.2 warns:
>> drivers/net/wireless/intersil/p54/fwio.c:128:34: warning: '%s'
>> directive output may be truncated writing up to 39 bytes into a
>> region of size 32 [-Wformat-truncation=]
>> drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 16777215]
>> drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 255]
>> drivers/net/wireless/intersil/p54/fwio.c:127:17: note: 'snprintf'
>> output between 7 and 52 bytes into a destination of size 32
>> The issue here is that wiphy->fw_version is 32 bytes and in theory
>> the string
>> we try to place there can be 39 bytes.
> Puh, I've been looking into /lib/vsprintf.c. Looking at the code, it seems
> that it goes like this:
>
> snprintf() -> vsnprintf() -> case FORMAT_TYPE_STR: -> string() -> string_nocheck():
> | [...]
> |                if (buf < end)
> |                      *buf = c;
> | [...]
>
> which dutifully checks for overruns (i.e. before writing into the buffer=wiphy->fw_version).
> So, thankfully no blind memcpy/strcpy is taking place here.
> Though, I don't know if this could be used for speculation attacks.
>
>> wiphy->fw_version is used for providing
>> the firmware version to user space via ethtool, so not really important.
>> fw_version in theory can be 24 bytes but in practise it's shorter, so even if
>> print only 19 bytes via ethtool there should not be any practical difference.
>> I did consider removing fw_var from the string altogether or making
>> the maximum
>> length for fw_version 19 bytes, but chose this approach as it was the least
>> intrusive.
>> Signed-off-by: Kalle Valo <kvalo@kernel.org>
>
> |ethtool -i wlx0014a535e989
> |driver: p54usb
> |version: 6.7.0-rc6-wt+
> |firmware-version: 2.13.25.0 - 5.9
> |expansion-rom-version:
> |bus-info: 5-2:1.0
> |supports-statistics: yes
> |supports-test: no
> |supports-eeprom-access: no
> |supports-register-dump: no
> |supports-priv-flags: no
>
> (yes, this doesn't change the output of ethtool. The firmware version is indeed
> much much shorter than 24 bytes for the firmwares I know of.)

Thanks for checking all this.

> To be honest, I would write something like: "This patch silences gcc" in the commit
> message. Rather than trying to come up with a well-intended justification. But I get
> why this happens. That said, I would like to see gcc envolve... And maybe then it
> will add warnings that go in the other direction (i.e. it will complain that
> this %.19s was unnecessary here) :D.
>
> Acked-by: Christian Lamparter <chunkeey@gmail.com> (Tested with Dell 1450 USB)

Yeah, I get why you dislike this. But it's just that net tree more or
less requires that our code is W=1 warning free and it will be soon
become a mess if we have existing warnings. So having this fixed, or
silenced, makes my life easier.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

