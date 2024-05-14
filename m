Return-Path: <linux-wireless+bounces-7639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FD8C571F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4528D1F223D7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB861448E1;
	Tue, 14 May 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUoAI4CA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D41448C0;
	Tue, 14 May 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692875; cv=none; b=P7G4DTQR1GNKQR9dthk+ZErjZ8emkSXi+D4xser/q76dQU+u/aaHyn+mwC3euMNq2hEmWMnimeLpqTwsce1a0Z3MqbIf5FufmH1+kfQ8zl5RYj3qTq+4SwpraT9auyWGDFkXGlkQkQJ0M8PDdVeXV0cup8NgOzsGnI2JKOtnsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692875; c=relaxed/simple;
	bh=+d+x3xrqLLNvB0bbaPBE1svfJd8r+2gvH4Ec5dTMZ40=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bcA3uy2LngkBfzr3/RlHoteKiD8PBK38eDr2ItA0FB+A7C6Mb+ONj1NHOioD25ozqd++VFJvAvnzxnfqwWrsd5N+mdEAAXZiKc+i+89Zvz4FIPrbqr5s7eZTQ4i4GajtkaDWN8jfcg9DdhK8f12ZQDc/gh8iFk0OsmGVrblzI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUoAI4CA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4501EC2BD10;
	Tue, 14 May 2024 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715692874;
	bh=+d+x3xrqLLNvB0bbaPBE1svfJd8r+2gvH4Ec5dTMZ40=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kUoAI4CAz0fTV3x70RnAKMy5FV2rxOSdsFEF3amjvtu9NFCHmUzi9FE2tZmi9btiG
	 FR/mBFylv3Onecvi4jP4mxleHUWxJRK8aPlaOFbK1urlmVUw+csR3FJ9NF/M0p/OtS
	 QYkTIRHvun8zT1BTDPdCJCrMFos4zP0A6r4+JngXKmuCtse/0v/9r1cH6PIJC8/S90
	 nW5nrg1eSb/DZPCDefWHC3CMdepmMNJvufMqtbsnlZZmrAI11FKYxjgBYfiUOtU1vH
	 TCWrfI4qbjCIZarVfGHhz6kqxnCuOfUIgzDAfGMmjilZjjFfu9rodUCQOcCScC+OH9
	 sonORoDxb4Ynw==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] wifi: wilc1000: set net device registration as last
 step during interface creation
References: <20240417-mac_addr_at_probe-v1-1-67d6c9b3bc2b@bootlin.com>
	<171569074600.2017278.13914732662896657638.kvalo@kernel.org>
	<3f53441d-b8b0-448a-aaaa-fb7e64aa86c0@bootlin.com>
Date: Tue, 14 May 2024 16:21:11 +0300
In-Reply-To: <3f53441d-b8b0-448a-aaaa-fb7e64aa86c0@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Tue, 14 May 2024 15:09:29 +0200")
Message-ID: <87wmnwil6g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> Hello Kalle,
>
> On 5/14/24 14:45, Kalle Valo wrote:
>> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> wrote:
>>=20
>>> net device registration is currently done in wilc_netdev_ifc_init but
>>> other initialization operations are still done after this registration.
>>> Since net device is assumed to be usable right after registration, it
>>> should be the very last step of initialization.
>>>
>>> Move netdev registration at the very end of wilc_netdev_ifc_init to let
>>> this function completely initialize netdevice before registering it.
>>>
>>> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
>>=20
>> I see errors:
>>=20
>> ERROR: modpost: "wilc_load_mac_from_nv"
>> [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko]
>> undefined!
>> ERROR: modpost: "wilc_netdev_ifc_init"
>> [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko]
>> undefined!
>> ERROR: modpost: "wilc_load_mac_from_nv"
>> [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
>> ERROR: modpost: "wilc_netdev_ifc_init"
>> [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
>> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
>> make[1]: ***
>> [/home/kvalo/projects/personal/wireless-drivers/src/wireless-next/Makefi=
le:1871:
>> modpost] Error 2
>> make: *** [Makefile:240: __sub-make] Error 2
>>=20
>> 6 patches set to Changes Requested.
>>=20
>> 13633102 [1/6] wifi: wilc1000: set net device registration as last
>> step during interface creation
>> 13633103 [2/6] wifi: wilc1000: register net device only after bus
>> being fully initialized
>> 13633104 [3/6] wifi: wilc1000: set wilc_set_mac_address parameter as con=
st
>> 13633105 [4/6] wifi: wilc1000: add function to read mac address from eFu=
se
>> 13633106 [5/6] wifi: wilc1000: make sdio deinit function really deinit t=
he sdio card
>> 13633107 [6/6] wifi: wilc1000: read MAC address from fuse at probe
>
> Shame on me, I missed those basic errors since I worked with drivers as b=
uilt-in
> instead of modules. I'll update my workflow and send a v2.

No worries, but I'm surprised that Intel's kernel test robot didn't
report anything.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

