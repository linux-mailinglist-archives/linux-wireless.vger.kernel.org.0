Return-Path: <linux-wireless+bounces-33287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEKeFOvIt2kRVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:10:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C969A296BF0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FB73300C996
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B1382F31;
	Mon, 16 Mar 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YahZNhhJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5079355F2D
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652165; cv=none; b=JI6oknW7SU9DmzR6hpDl6iOFJChMaONHDarQHbt44hyRE19htHGRVFOXDx7jgetMx62TtZxWHix2SU5LLOzzKMyNHN6/RvZlSlSgIdWx8+lHJc22tQUxA60Nv4FAb2ML6BH3CRV//NXxDlDF6ZGLCloan/oa70aYuV9K94YGhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652165; c=relaxed/simple;
	bh=b/v2YK1Ny0iCGdh1uKhLo31haI200+Khn2gytgyltlc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n46EVQQ3DXARNn9lwJD4/YakgUGo9ACn2vJFFjgUs1TovFrXqtwPG45oaaQ5bl9KPy/e90MYOHXe7ozMJ/OXV17DZkCru2hwLX2STik5tnetvqqCZH7l+ZGNyNlYAViQDhMijzkOyuAF0DVoeK1s7bG0U6oFcEJAdk+rHQ786Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YahZNhhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756F4C4AF0D
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773652165;
	bh=b/v2YK1Ny0iCGdh1uKhLo31haI200+Khn2gytgyltlc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=YahZNhhJ3/iamDBtfHsrE3+vtZY6pAFMKyIsYsLjyVKzreB5aiwuNjFTYbWL5aMxM
	 UTa67fi67NmucwHIcNs6xLXr1MPYjsUwXw4CipJnBY9A/yL/4QHnXxZ3cLbq2uPhPo
	 TJnnbi648EopYGjP7ixrfqoBptD9u/TxuM9dzMpxjOsrxwkTLbdkZQ5BBHd2aUXOyb
	 o6MvWxllkb9ks4ZGsB0sGueG7qsW35uX7/LT4Wc2xAoDFSJJqQs2FLrn/2sXxUUAUV
	 OaZxIqNrKMHWwuvIkMid5W2jhpYUuSaXk/rwJPcav5nCZUz1UarNAC75jD8MqQw9f+
	 c4W4kKGE3wM1A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59de8155501so4303265e87.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 02:09:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YwkM7iNGEBfF36wyjkZeHJd5q27r49IJMI9AEYbeBvxvLgItl6Z
	kwGDDIjjNscfJvTeUgRazDjmjRdV0E6iad4021O4uAXkhzgZW4UJh6jqbnVFU4hCGBUcJTc/k92
	PYN5b7UCm93fXqjmNxLAA6nYUA1qnHG5xFjhIlkACwg==
X-Received: by 2002:a05:6512:606:10b0:5a1:378c:11ea with SMTP id
 2adb3069b0e04-5a162702d43mr3088735e87.13.1773652164132; Mon, 16 Mar 2026
 02:09:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 05:09:22 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 05:09:22 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260313-descriptors-wireless-v4-1-07ab47c89a98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313-descriptors-wireless-v4-1-07ab47c89a98@kernel.org>
Date: Mon, 16 Mar 2026 05:09:22 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdJXhXyid1a4ycmKv6nwOf3FYd=rFEaBqQ7k3SFq_j4FQ@mail.gmail.com>
X-Gm-Features: AaiRm50E8GRHGkdeiQAzZ_1v88_i8nLlnialk2yAEGDF-41oOttxzoscFG9qkpU
Message-ID: <CAMRc=MdJXhXyid1a4ycmKv6nwOf3FYd=rFEaBqQ7k3SFq_j4FQ@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: ath9k: Obtain system GPIOS from descriptors
To: Linus Walleij <linusw@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
	linux-gpio@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alban Bedel <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	=?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,linux.intel.com,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33287-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C969A296BF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 22:53:43 +0100, Linus Walleij <linusw@kernel.org> said:
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
> GPIO driver and associate with the NULL device (making them
> widely available) if and only if we are probing ATH79K wifi
> from the AHB bus (used for SoCs). We obtain these offsets from
> the NULL device if necessary.
>
> These GPIOs should ideally be defined in the device tree
> instead, but we have no control over that for the legacy
> code path.
>
> Testcompiled with the ath79 defconfig.
>
> Reported-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> This patch set is a long standing attempt to get rid of the global
> GPIO numbers from the ath9k Wireless driver.
>
> Maybe Kalle can merge this to the Wireless tree if we agree on this
> hack solution.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v4:
> - Fix review comments from Andy.
> - Collect ACKs.

I think this did not work. :)

> - Link to v3: https://lore.kernel.org/r/20260312-descriptors-wireless-v3-=
1-5230e0870c31@kernel.org
>
> Changes in v3:
> - Rebased on kernel v7.0-rc1
> - Fix up issues as pointed out by Micha=C5=82 K=C4=99pie=C5=84
> - Link to v2: https://lore.kernel.org/r/20240423-descriptors-wireless-v2-=
1-6d1d03b30bfa@linaro.org
>
> Changes in v2:
> - Define all the descriptors directly in the ATH79K
>   GPIO driver in case the driver want to request them directly.
> - Link to v1: https://lore.kernel.org/r/20240131-descriptors-wireless-v1-=
0-e1c7c5d68746@linaro.org
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

