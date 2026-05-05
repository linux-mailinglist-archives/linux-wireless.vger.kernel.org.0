Return-Path: <linux-wireless+bounces-35898-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB8YKnjL+Wn3EAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35898-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 12:50:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8DA4CBD86
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7CEA301A4D3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1950D402BB0;
	Tue,  5 May 2026 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThXqo6e1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8078401A26
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977448; cv=none; b=rvimUOnxM52BBRb97lIa8RJAHZGe8WP1g89ss94etJtCV9LhBQwo59VqAEbywqEGP/s/1Lyy8sZiDFU/eZJDXdxA+k+zr+uQ6bGRIDKDuVZySBjjiBdRyhsB0m2M9J9S9YgZk/mHsldMpkRA0GK1zSQHht5epHkwelw6jfMbdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977448; c=relaxed/simple;
	bh=O1k9EcQ6FxBoy0l3c2OuSS9sgdShv8hsm/6tH6dR92Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPpW4OKs8MCGP0FrOgKfvvW4rdtqpxGz4rhsqM6XC0hwr4JDjJ43XsPRoYhi6czdWyjrq6BUQGwUtUVvp2JzAzuxgpzDD7Uv55y0a6RHRVUjNr+yOPIy7XA7O4Fj+HBAh6akZ7RV/NWPxUn5dTxkTNwFG85miT5ciYeELm503LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThXqo6e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910CEC2BCF4
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 10:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977447;
	bh=O1k9EcQ6FxBoy0l3c2OuSS9sgdShv8hsm/6tH6dR92Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ThXqo6e1rU/ERqtjJ0/iY65yI8g5OKLcudnQZ3mErUhAINOrMK1kRvatSEjw/aymI
	 tyz8uJRT1H94QGgZgJpAmZBEKhwt+k5rgNB1+fkpLK6nLklda575BySe/kvkxgxrPi
	 4W4L5829nXgbOk8BtTeUl/Z1/JKX8WvgnQyTT/G/C2RqdSFvkvX15ABfdQAGXz0o+b
	 D/ZCmpEQgi4ZUdCkmV11FwMv4ggLphaQeEJBgZf95MrOsV40mnU3Z3cVRoeVPy2qze
	 cR69WrZjNFzSklu/jNHQ4VFhLVhhXLbkcI7VGXwzxbLWJ0Wa6iULmA64C8/m9NpmJ3
	 T6+DsTjTPuThg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a4113ab355so4853725e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 03:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/z6615NFmuS6CUys/inobrjLZK4XkrQQ5bBQmBpWEkW7+3tPSqfXXOEX0AWoMnAnDBQTuBN4VEo+kJ2AWqWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZVjv8b+lP5o0Meb6b39Wc+T4xeirtGPbYjD8AAlFbpL8fN7F
	IUIy2YbEwqcdeRMbcOXe310zGSK0R1hpVKswcL1zljaDPtn1C/XXpS2jAZuFuILwoh8LikfQiE3
	iI6mgCfXYy1Tw0gMnJojkhGGYHjHoC2Q=
X-Received: by 2002:a05:6512:3095:b0:5a8:8222:7fbb with SMTP id
 2adb3069b0e04-5a882228046mr652967e87.34.1777977446254; Tue, 05 May 2026
 03:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430081242.3686993-1-arnd@kernel.org> <20260430081242.3686993-3-arnd@kernel.org>
In-Reply-To: <20260430081242.3686993-3-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 12:37:12 +0200
X-Gmail-Original-Message-ID: <CAD++jL=tgW74cF_e+4Ak7cV_pUCYo3koqmZ6vNR9SQiUsb2zUA@mail.gmail.com>
X-Gm-Features: AVHnY4Kta7CTuYHDE7Wgt7oimq4LNXS-PqBiYhrkb4K1P_cfZhJR-Ui5oKw0IfI
Message-ID: <CAD++jL=tgW74cF_e+4Ak7cV_pUCYo3koqmZ6vNR9SQiUsb2zUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3 net-next] p54spi: convert to devicetree
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
	"David S. Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Felipe Balbi <balbi@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-omap@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DE8DA4CBD86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35898-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arndb.de:email]

On Thu, Apr 30, 2026 at 10:13=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The Prism54 SPI driver hardcodes GPIO numbers and expects users to
> pass them as module parameters, apparently a relic from its life as a
> staging driver. This works because there is only one user, the Nokia
> N8x0 tablet.
>
> Convert this to the gpio descriptor interface and DT based probing
> to improve this and simplify the code at the same time.
>
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

