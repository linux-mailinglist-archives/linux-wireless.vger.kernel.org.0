Return-Path: <linux-wireless+bounces-36871-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ADcBB8PFGpeJQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36871-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:58:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88935C8384
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E58A3004D2B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A33E51D5;
	Mon, 25 May 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsfSJ9qs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626E3E0248
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699483; cv=none; b=Or7fo/Uq9Ynx6qvZ9OgnxwCZxmV52F+b2NuvC2hTQkfUYXnQdThT3Fz+vzZbvgvnhcRKYefZnvtHOt7VfK0pGiqp5gYsa/zf5RusRVCrYOnSfn5P8spEtD+8sQbfCRFLZaSx/acqBcoeeuVxEA20B7RydnSzZETCTNNpkX0gp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699483; c=relaxed/simple;
	bh=xXz/GYVV9QSNbeC/HxJ0KuDPx2s68Hc+e5zq10KEVeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJhfU9NME2SdId/SEYFw2/BQmJd+JNg8w1ZbhSyCa2kNCspkr/a8HrbRy+00olFra/5e3FN5JJGcEjbmCtu2ZlNVPgsTGQ94TPHvPLVu2nYkNj9QgWiDHiEFnpyV+HQ6wzWi/hHSCGkZIgRmreL0w/jBmKm8vUOnEiUe7C9IWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsfSJ9qs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5745E1F00A3E
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779699482;
	bh=xXz/GYVV9QSNbeC/HxJ0KuDPx2s68Hc+e5zq10KEVeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PsfSJ9qsfwUwMwGEQi9C5gkghGo00zi/UHVZXT4fQmDaGE2tbo69FkGJUMDmJx5ZP
	 ajPVIPljZ4PYnb9NQO2JuaYOFz0uSSzjinXFbifeiuH7Y5hFnmw/pg0AbsywCXU/SD
	 iPUkHSnbzPHqA1uoorTRRt7DninH/J/mgesmdexSXzDEg3Ao0pEGi/C476ZUYOoNjo
	 DhVby5WWmAzJI1rJokBGqtXYfB6crSo2ze8eCNS3Z8HpmjitJ5phMuXGeqY8YpS/IE
	 4iv+mYl92pOnQMXUwDk8yLuuzxK9SKUDmBR1sZXJrfOae8y4hAMWzbqZLbeDzEDzc2
	 WZ12vmUy0grtA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e615efd7d7so1894012a34.2
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 01:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+yMM4WtGHSXs9/00CGi4U9s5ndasbuoiIwj02wkTtkZcAj7xH9VMKJzwHCH6xEgjI14prmE/mNrcjhsvAF4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlE85UOnVjU7IFcXTeDKtaznv1IMA+1jiAyr4GdVptymfWT9h
	bG2auAv2uDVGA95ZMgYvgIAwCc98Hyc3zMYJcbX+E4uWABWXYrBYtQCDmBU+QDt7AUJc0KJ1E4w
	VrDhyBc4GWGWQPqfieEnpKWLGI/GUzcY=
X-Received: by 2002:a05:6830:4985:b0:7d7:fb8c:3c29 with SMTP id
 46e09a7af769-7e5feeb63a7mr8912823a34.14.1779699481274; Mon, 25 May 2026
 01:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520183815.2510387-1-arnd@kernel.org> <20260520183815.2510387-3-arnd@kernel.org>
In-Reply-To: <20260520183815.2510387-3-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:57:44 +0200
X-Gmail-Original-Message-ID: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
X-Gm-Features: AVHnY4KW10_QvipgU3JqDhFdOUhRtRqnFXdZTNq6fk963CfrOH70VHOW3qgjj1k
Message-ID: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Christian Lamparter <chunkeey@googlemail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36871-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[40];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A88935C8384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 8:38=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> interfaces, but there are still number of ancient sh, arm32 and x86
> machines that have never been converted.
>
> Add an #ifdef block for the parts of the driver that are only used on
> those legacy machines.
>
> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> passing an IRQ number instead. In order to keep this working both with
> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> the gpio number if an IRQ is passed.
>
> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gm=
ail.com/
> Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

