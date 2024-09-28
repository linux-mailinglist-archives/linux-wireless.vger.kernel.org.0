Return-Path: <linux-wireless+bounces-13275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC68988F0A
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 13:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB2228229B
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C380A3B1AF;
	Sat, 28 Sep 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahm87waX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62A2770D
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727522318; cv=none; b=HcEU5ecvFAZaaTuD0PEU7x94sxWaswv8j1+mC6ViwCUxPmeEDL3h8LTktRn+bYMxros2J7hm6XgpuADUQxHCuX6V3QLqVJZeNcJUiB4AaTriXXF08iTwQRYZD9XlOaVAB+uq37gAmUTWQ1thpgDZ/OfIhdsM2FZMTm6oGLIfRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727522318; c=relaxed/simple;
	bh=nWSl/kS/xKV62olerxS5ICrMVApGYZFzmOy3ATjIi0E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=A4wRauBLYyqiKE8b39sqS7if9lKOObCIzZF1rCZmhvF18Qct6j2Jkg/N/tAbxQXwuV4yHM4KECcpbzhbkkAvRsA9kK9K+bW6NHtyE8NFg/HCKuWaBA6K2cPfHmsRMQKnS4/cJ2zKyjxrp3rbPapnALCogvBHa84jfhUaJPJhJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahm87waX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5079C4CEC3;
	Sat, 28 Sep 2024 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727522318;
	bh=nWSl/kS/xKV62olerxS5ICrMVApGYZFzmOy3ATjIi0E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ahm87waXROxn8Umoz1SHjWGcCHfNsefIOSg+nYmujGPvQtX8Qv94MnX+dynPAISay
	 MNPSIKh+sCLx9nFC/YQwEugkFYGZNS0mTGmxdAwga/eUIKDYP4CJi5fGoUuH20Fa48
	 dP/Cmh9ygVzSKBkQ3SKW091hD7iDpJn0Oamy3Wdl/n7cfjLL7H98rq1mee9FoKEZf3
	 1o+beRlN2TXLp6EQHK2AYGNk8SnLmlvqNLIGxm57PFIvsl7rfgKNOPCC6SoDuDy5CX
	 tvCHbhOtOdxL5IuZZQDiBEBXX9Q02PpgjT7cqAdXxd9YXTm7d04dySbnZq3KqmechL
	 vb+V87SepN0fg==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org,  Ajay Singh <ajay.kathat@microchip.com>,
  Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,  Claudiu
 Beznea
 <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
References: <20240926195113.2823392-1-marex@denx.de>
Date: Sat, 28 Sep 2024 14:18:35 +0300
In-Reply-To: <20240926195113.2823392-1-marex@denx.de> (Marek Vasut's message
	of "Thu, 26 Sep 2024 21:50:55 +0200")
Message-ID: <87ed5481ro.fsf@kernel.org>
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

> The WILC3000 can suspend and enter low power state. According to local
> measurements, the WILC3000 consumes the same amount of power if the slot
> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
> off. Use the former option, keep the WILC3000 powered up as that allows
> for things like WoWlan to work.
>
> Note that this is tested on WILC3000 only, not on WILC1000 .
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: linux-wireless@vger.kernel.org
> ---
> V2: Rebase on next-20240926

BTW I recommend using wireless-next as the baseline for wireless
patches. For example, wireless-next is not pulled to linux-next during
merge windows or other patches in linux-next might create unnecessary
conflicts. Of course most of the cases using linux-next is fine.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

