Return-Path: <linux-wireless+bounces-6732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519FD8AEB29
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818701C22A98
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46113C66C;
	Tue, 23 Apr 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9Suwh23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E113C3E3;
	Tue, 23 Apr 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886333; cv=none; b=pmlK2RARl5z6ke4R5lJgxqhflXxqQAtC0wg3LraaSRi6Thwa4iJnaVM5DoTDq3fr3WS4yYNsbkgDQHCz7I8ZjqYj7gPHl66k2qNLrInaiH9DDuQW6APsk2mfWKp78lDZVaGiQxtHUbHZzJ/h2rpJrIMidX81i1LcIcg2ISgK6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886333; c=relaxed/simple;
	bh=loKLUZOtD2Ahu5u6ZjVLLzhH7+gsOeQjN/iG5Ye4+LQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tiFgH5VXmXIt83++ohvpAOwneJDDCe60vgamg5vVNoOsS2vR7Y52a28sdj4dP14SLQJTgL+ePx0MnTUDZp5bmDBQZ27I2gJ3CyAWYeLDrGguI6uhp3XWJIa2Hy3pBIXWkTT5ZVFeXk9gHYVywjJSs8oBmRnvx/VUQg0lves3q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9Suwh23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5777C116B1;
	Tue, 23 Apr 2024 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713886333;
	bh=loKLUZOtD2Ahu5u6ZjVLLzhH7+gsOeQjN/iG5Ye4+LQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=E9Suwh23sx3IIB9Z4pNt8T3srnBCr1SXJeKfITWC9nJdUUAEgGeoLHY3vPzwf2l7J
	 PbIlygKMPxrjsWiugzGcnIo0YwCqESO5UXHg+SnqMmg+pDrQr1Au3eX8/3UUtcLqcJ
	 5huwrjYTxZKD1fA5MJcG84xh0LbhcElv9IlkKd/Pj8D0JYzgVH1GDuMBhLSuQgHl3p
	 F8fZN+wiUbzWSfqmznAM3NtpvdsYkMYouebc9tkT5n3TDxcA+FTCXZg75hWLn1wJ7/
	 hX84vsv3KTvjBXSqQfU+Jz3YapjUAHCDeUMyRR/AngQBui1KUCyVEJU9ox8Isar3jg
	 S1aB3BjHhTtVw==
From: Kalle Valo <kvalo@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,  Arnd Bergmann
 <arnd@arndb.de>,  Alban Bedel <albeu@free.fr>,  Bartosz Golaszewski
 <brgl@bgdev.pl>,  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>,
  linux-wireless@vger.kernel.org,  brcm80211-dev-list.pdl@broadcom.com,
  linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: Obtain system GPIOS from descriptors
References: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
Date: Tue, 23 Apr 2024 18:32:08 +0300
In-Reply-To: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
	(Linus Walleij's message of "Tue, 23 Apr 2024 14:12:33 +0200")
Message-ID: <87v848t7rb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Walleij <linus.walleij@linaro.org> writes:

> The ath9k has an odd use of system-wide GPIOs: if the chip
> does not have internal GPIO capability, it will try to obtain a
> GPIO line from the system GPIO controller:
>
>   if (BIT(gpio) & ah->caps.gpio_mask)
>         ath9k_hw_gpio_cfg_wmac(...);
>   else if (AR_SREV_SOC(ah))
>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
>
> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> gpio_request_one() passing the local GPIO number of the controller
> (0..31) to gpio_request_one().
>
> This is somewhat peculiar and possibly even dangerous: there is
> nowadays no guarantee of the numbering of these system-wide
> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> correspond to GPIOs 0..31 on the system as a whole seems a bit
> wild.
>
> Register all 32 GPIOs at index 0..31 directly in the ATH79K
> GPIO driver and associate with WIFI if and only if we are probing
> ATH79K wifi from the AHB bus (used for SoCs).
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Define all the descriptors directly in the ATH79K
>   GPIO driver in case the driver want to request them directly.
> - Link to v1: https://lore.kernel.org/r/20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org

Linus, via which tree should this go?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

