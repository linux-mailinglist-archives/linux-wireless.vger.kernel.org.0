Return-Path: <linux-wireless+bounces-35899-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KROJYrM+WlHEQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35899-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 12:55:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A34CBF38
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 12:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CC3305663E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B99407583;
	Tue,  5 May 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB3LP/gB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276434BA5B
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977727; cv=none; b=aBRZE3EBZhUpSYtL5LANMt9/9hIaZZbePyy4/Y5gk6iMfDIAwuZ0/HlO5Th/FIbqger5eBjx1A80uKAQQbdPpqirTbGbceQvyXLJjrbHBZmTsJjqSj0sXoAViV1ipmYPs0oD7nrJeEQYwVx+HO1726f0mTmAEI7tobHi763YxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977727; c=relaxed/simple;
	bh=QAxbkpqBCKTE79BmMO4+ohI26sWtDnSzhbxpx26l2V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhVpjw+WQo4WsYaYNsKzLKVdG3Pq8JEdAMkpQjXHn+rcNqwCvVP47L45j/orXAZiDsiaez2OU2CNtO1Tu9cQKI24QBWGYMYkFs0/DPjuaHkyypg0tDF93Y6FzFIYTM9LU4HMnmZaiV/s76pw4RclzEskZ6tZEFov/t7RoOEyXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB3LP/gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4974C2BD04
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977726;
	bh=QAxbkpqBCKTE79BmMO4+ohI26sWtDnSzhbxpx26l2V8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iB3LP/gBTdkL681ekJ6SD7SzFnjeEi0S7q13Uso5teGhN4R9KYvcrXC4myk/6zJ9Y
	 2psnd+tfE0mclve2Zz2qh9NG4Ht3aPQe37v+qJerfkOQ/ImhraqadrpeVodLewPo12
	 PaU+AnLGj7Tf7GtmVl9ZyCQgl973aaKYdipuKSCq4BUg6N3orsVxuXcZyb3FQoBELf
	 CBUarz8RynkQW0ZE/REclid3FDXRanLQIi+zq/ELKKn4xQaMeymZPrk7vs5czGy2ER
	 c9Ac3gL9ItUiB9KwHsuNCbxzkt7LXDN+O76QcEREmz/T3dpZfcxc/ZocILw7NNJLph
	 im4ok6XRSXD/Q==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393800586aeso26671151fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 03:42:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9FgVDPyav3wElHQruit5DA+J+JpW8KFVEsGj194avM1PRkTCzFgGxC96yd0RFZreBTGCmj0CcGqguxOSCPnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XfruN8HxUtFHz0IXwVXo7PPe2LEFZ2PtffWBYpBRXUB52kuM
	Qx2DCxKWwPLXvFtp5D1AzPnHoPZHLhRXOXRav7/1icbTgiJEDLmNo2i5L0i8TWnFYa89u5tjmsn
	3CYl9vYPOVLsGsv7q1sQZl2Oy1JFpyJM=
X-Received: by 2002:a2e:bc09:0:b0:393:9cf1:78a with SMTP id
 38308e7fff4ca-393b2bda7c5mr11198661fa.22.1777977725320; Tue, 05 May 2026
 03:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430081242.3686993-1-arnd@kernel.org> <20260430081242.3686993-4-arnd@kernel.org>
In-Reply-To: <20260430081242.3686993-4-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 12:41:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLkDmQ5eK3Lzg4N2X=_iQMoeh9TWh67hvOLBh1r_x=afoQ@mail.gmail.com>
X-Gm-Features: AVHnY4LQ-69b-VeuKsX-tQijtzj4ctkK9Gpn7v8pkwosSSN69m0jMPm2kOmRFFg
Message-ID: <CAD++jLkDmQ5eK3Lzg4N2X=_iQMoeh9TWh67hvOLBh1r_x=afoQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3 omap] ARM: dts: omap2: add stlc4560 spi-wireless node
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
	linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 378A34CBF38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35899-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]

On Thu, Apr 30, 2026 at 10:13=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Converted from the platform_device creation in board-n8x0.c.
>
> Link: https://lore.kernel.org/all/20230314163201.955689-1-arnd@kernel.org=
/
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

