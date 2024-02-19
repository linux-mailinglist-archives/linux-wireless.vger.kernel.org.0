Return-Path: <linux-wireless+bounces-3754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07498859C2B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 07:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C4E1F21BDA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 06:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EF1F941;
	Mon, 19 Feb 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAvx4DrM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223891CD38
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324126; cv=none; b=ml/RLwdFAzjmlgN/JIGTnvOgFPD1j9asrHU7mkX+U3p27DL9G5oAcbGl+Ufj1Iv9OOHPpiYaQIYUl16z4OdP64LdocagmcLN5aevTuqNq+H83uykyG69oE9cYTNMaB4+W0Y7VynfOlcdDh9YJNvktSpX0Ng2pVuVqEEWK4C2vGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324126; c=relaxed/simple;
	bh=q/ToE+4uybaNVZtBPxRJmZLbcfZCbCFrdvq7IvKkJc4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VBrjDdG8CbKpu3pYHhUZp12rxT6utj9wig2FOppXAjNZZ8ViMw5caEsQjigblB6UUpvfAbjH7wV74mAxT47cQr0Qy9zIIfMac0uJdIAb6GjBKfWK0npg0rSnWRAsF0E3RbHLpZprRPrZ09GAYYw+JFTTvXfXL1buu8lh7Y+kQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAvx4DrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EF3C433C7;
	Mon, 19 Feb 2024 06:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708324125;
	bh=q/ToE+4uybaNVZtBPxRJmZLbcfZCbCFrdvq7IvKkJc4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KAvx4DrMlXbS9BJdVm39JqbhUAQdxF4NYpwUHZZOxv9x7mXrzGx8v9XctG0LIuupb
	 Y1HSnRR0x1NltI9yozcFRdFELZ4HwcYDz4amWAGGmhu2lcFGBNftCB2fJq0PZFiJIC
	 ohDXNcF7E01IZEtvcV7jedS8fiuPN6t8fSmG07qUj3frBn8me7pZU+9GLzmj+Fa9G+
	 GC/ivuIksNGgoBGeUEyZATn5/4SIqNBbHqnERAl+KueXAWThaeGnKUgPXbCHFMkOzU
	 QYzUdDH4TVe3YwSi5HmQXvrtDTtSJiZ7V8EM2isjhVl7qpalrd0azReiT69d/NNwXH
	 syOfvGPErVmjQ==
From: Kalle Valo <kvalo@kernel.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Brent Roman <brent@mbari.org>,  linux-wireless@vger.kernel.org,
  martin.blumenstingl@googlemail.com
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa RockPi-S
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
	<9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
	<f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
	<b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net>
Date: Mon, 19 Feb 2024 08:28:41 +0200
In-Reply-To: <b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net> (Larry
	Finger's message of "Sun, 18 Feb 2024 09:55:59 -0600")
Message-ID: <878r3hc6hy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 2/17/24 23:13, Brent Roman wrote:
>> Larry,
>> Radxa confirmed that they do not program the eFUSE on these boards.
>> We do not get a sensible MAC from the chip, so I derive a one from
>> the CPU's unique serial number.
>> It's a hack, but it works well and is standard's compliant.
>> The RockPI-S a *very* inexpensive board, so I can understand Radxa
>> wanting to minimize the time spent configuring each one.
>> https://shop.allnetchina.cn/products/rock-pi-s
>> The vendor driver seems to deal with this by applying typical gain
>> parameters when the eFUSE is invalid.
>> With that driver, this board's WiFi performs beautifully, despite
>> the unprogrammed eFUSE.
>> Would you accept a patch to add this logic to RTW88?
>
> Of course a patch would be accepted. Ultimately, the changes should be
> made to the wireless-next code base, and sent to this mailing list. To
> make things easier, you can send me a patch file for the rtw88 repo,
> and I can reformat it for wireless-next and send it to the mailing
> list under your signed-off-by. Either one would work.
>
> Thanks for sorting this out. I like the idea of deriving the MAC
> address from the CPU serial number. That is unique and reproducible.

But make sure that the CPU serial number is really unique. If it's not
that can cause MAC address collisions which is not good.

Usually wireless drivers create a random address if a stored MAC address
is not available.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

