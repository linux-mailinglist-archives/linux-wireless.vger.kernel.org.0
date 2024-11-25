Return-Path: <linux-wireless+bounces-15687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D039D84F1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC63284EA4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70066187553;
	Mon, 25 Nov 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az5roZdr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F55376E0;
	Mon, 25 Nov 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535904; cv=none; b=HwHxKLRiZB8M4xhtqv09EES9xvCXzaD7TvS7/Q/LmxsSjMe7URRQ/wCFlDtro8BgPmOivfNWz1TZVNbO2ktx8XLm7F1zEJUWe1Xx6rJ82HXCVUNquQFZTbmrCsuPSgGN4Mnylhyf3NpZCwRrwGKT6OAQnurvQY0sH98OsQst4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535904; c=relaxed/simple;
	bh=XPeICkEr0+V297XB982f0NK/O5g1go5UUG3H/yTQouY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FfQnq75MyQkPPLKyy7kjGvuMY32ISCu8GDOCS9xgyo99YRwyAK5vplXhF/Kt/iHF1xo+WzoVgfGz/IEO/IrodB6lwUvPgMPT18G4M76v69acUp6tWmV0Fgc/ehnvBL69CZQWQXW9oTZJtputOG5bUVPSTAHA22LfyEdtMNyUUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az5roZdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7F7C4CECE;
	Mon, 25 Nov 2024 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732535903;
	bh=XPeICkEr0+V297XB982f0NK/O5g1go5UUG3H/yTQouY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=az5roZdrft9m47fEWLZnbCOLrJ15hJGb9uQx+aRIrZ4VJMN4eNu/wyjhvMOmi4/3T
	 Ichjgt+zrPAagmPt6TfbriBhg4UE+apOQkeiGoBVoBaLIvYnfOt48sT+CxSwKGf77x
	 G7NKq0Auza9eZqB6gopYod70BF0ix92SYSdl1RV+UNQy2RqUotedrBHzaJSdUSXaWp
	 3EQuwlQvasfLuIkzEGy3MRABJ12wIoa3TUpZjR2VDPVlavC2JiLkqdVLrDV9/Wm8eD
	 u1uRmXKRLWIlc0hj6ykUdZrkN9kxmM7Yzj+u2GxDLxZlSX0HzlpwhwLYtjUWTnaYg5
	 P5zueNY5ktXOQ==
From: Kalle Valo <kvalo@kernel.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: linux-wireless@vger.kernel.org,  Alexey Berezhok <a@bayrepo.ru>,  Alvin
 =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,  Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Hector Martin <marcan@marcan.st>,  Janne
 Grunau <j@jannau.net>,  Kees Cook <kees@kernel.org>,  Neal Gompa
 <neal@gompa.dev>,  Wolfram Sang <wsa+renesas@sang-engineering.com>,
  brcm80211-dev-list.pdl@broadcom.com,  brcm80211@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] brcmfmac: fix RSSI report in AP mode
References: <20241122210346.2848578-1-alexthreed@gmail.com>
Date: Mon, 25 Nov 2024 13:58:19 +0200
In-Reply-To: <20241122210346.2848578-1-alexthreed@gmail.com> (Alex Shumsky's
	message of "Sat, 23 Nov 2024 00:03:46 +0300")
Message-ID: <87a5dnv82s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Shumsky <alexthreed@gmail.com> writes:

> After commit 9a1590934d9a ("brcmfmac: correctly report average RSSI in
> station info") it is required from firmware to provide rx_lastpkt_rssi.
> If this field is not provided brcmfmac doesn't report any RSSI at all.
> Unfortunately some firmwares doesn't provide it. One example is firmware
> for BCM43455 found in Raspbberry Pi.
> See https://github.com/raspberrypi/linux/issues/4574
>
> Fix it by falling back to rssi field if rx_lastpkt_rssi is not provided
> (like it was before 9a1590934d9a).
>
> Fixes: 9a1590934d9a ("brcmfmac: correctly report average RSSI in station info")
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>

'wifi:' missing but I can add it, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

