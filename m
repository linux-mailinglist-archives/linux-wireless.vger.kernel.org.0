Return-Path: <linux-wireless+bounces-13284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D31A9899E9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE891F2178A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 04:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B314F8BB;
	Mon, 30 Sep 2024 04:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA+THiKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21142AAF
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671869; cv=none; b=qrTCfF31Au25CbfmKkjWUwQdERSussOEsS7K82syxwJThiNkkv8W5KbHfErzObW/SR066djXs095k3kXfEfnt0wsqcgGVtVP5YcyVGsfY9hphIGisk+WbznbX2PAAl/DWeFY5OkfMmr26PVQUSXDhBMBzMa4sAIo+CJbNiUV1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671869; c=relaxed/simple;
	bh=8ReNCrXTDmb13IHQNaIS5ZdxO6lytH+w3qGBBMwRuZw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SJpJeE1mDeCKasAUraFiuDwbnTD1U3o8GB1kXeTzdafwvUkq0AxiHdgQsXBAq45ZDm3RudF1yfLqKlQ+HYK5rn4byauP5u/xDSThMyFX66rCIasN/RZ8RzZkr2qVqfoR4A8eaHi5BpNIpJEIyZEp0vWPhSPItXQjo/Q8f1ZrocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA+THiKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97634C4CECE;
	Mon, 30 Sep 2024 04:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727671868;
	bh=8ReNCrXTDmb13IHQNaIS5ZdxO6lytH+w3qGBBMwRuZw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dA+THiKN8+fmzLduZK8iD2GqLBZZxeJD0r4MpNDrMOukLwG59D7GpWI7r/4osd6ce
	 aSDWXXy8YLxUBVRn92PyqzBK/O5UQwgl+9KT5AYx5wbpl6RMwMU/6jVx1uuZaDXh/j
	 OaCW0XxqE+XL65LnLeuMoS1BWLVpYBSiFI+tfUBmF8DOBtuG9B+eBla0+ec0ObqBL9
	 vDjx61hHs5sPGTGW56XYIlZmO/hTZGyIzeWiqQXEqjJrI5zlsbx9eLSNUDXiK7pLft
	 kBBJuok4NX1BMXSAJnzmCO9A1y+NLpUL5Z20ku28jNNrgzCSam+Lu2cp26xzPEev5R
	 eqL6ovdqEG+aQ==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org,  Ajay Singh <ajay.kathat@microchip.com>,
  Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,  Claudiu
 Beznea
 <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
References: <20240926195113.2823392-1-marex@denx.de>
	<87ed5481ro.fsf@kernel.org>
	<b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
Date: Mon, 30 Sep 2024 07:51:05 +0300
In-Reply-To: <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de> (Marek Vasut's
	message of "Sun, 29 Sep 2024 17:23:06 +0200")
Message-ID: <87zfnp922u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marek Vasut <marex@denx.de> writes:

> On 9/28/24 1:18 PM, Kalle Valo wrote:
>
>> Marek Vasut <marex@denx.de> writes:
>>=20
>>> The WILC3000 can suspend and enter low power state. According to local
>>> measurements, the WILC3000 consumes the same amount of power if the slot
>>> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
>>> off. Use the former option, keep the WILC3000 powered up as that allows
>>> for things like WoWlan to work.
>>>
>>> Note that this is tested on WILC3000 only, not on WILC1000 .
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>>> Cc: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
>>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>> Cc: Kalle Valo <kvalo@kernel.org>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: linux-wireless@vger.kernel.org
>>> ---
>>> V2: Rebase on next-20240926
>>
>> BTW I recommend using wireless-next as the baseline for wireless
>> patches. For example, wireless-next is not pulled to linux-next during
>> merge windows or other patches in linux-next might create unnecessary
>> conflicts. Of course most of the cases using linux-next is fine.
>
> I didn't know there was one such tree, added to remotes, thanks !

Another tip for the Monday :) get_maintainer script is a handy way to
find what tree should be used:

$ scripts/get_maintainer.pl -f --scm drivers/net/wireless/microchip/wilc100=
0/wlan.c
Ajay Singh <ajay.kathat@microchip.com> (supporter:MICROCHIP WILC1000 WIFI D=
RIVER)
Claudiu Beznea <claudiu.beznea@tuxon.dev> (supporter:MICROCHIP WILC1000 WIF=
I DRIVER)
Kalle Valo <kvalo@kernel.org> (maintainer:NETWORKING DRIVERS (WIRELESS))
linux-wireless@vger.kernel.org (open list:MICROCHIP WILC1000 WIFI DRIVER)
linux-kernel@vger.kernel.org (open list)
git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

