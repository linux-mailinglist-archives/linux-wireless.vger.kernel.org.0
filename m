Return-Path: <linux-wireless+bounces-35569-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J8VDZ+r8WkAjgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35569-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:56:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC74900BB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06F793012CE4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459EB39BFE5;
	Wed, 29 Apr 2026 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFhgfhPg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B82339719;
	Wed, 29 Apr 2026 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445740; cv=none; b=epgDDHtJJAYuANHpDYOIdiRbRknLPAsOLt5XQY2k0EMtFgYWVYFA3zo9U3U7Hs8K6OHv2QTUL0RWfE8gqcNV7Gh5+QAXIDlKRRfGFKBFn1II+5uuHtxIJvqQjBfaFcC9SrD1RZ8ww8IdAf9+Q8iWk0MLOfRRX4vmfvsmxo3AQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445740; c=relaxed/simple;
	bh=PHll4ZUqKiT08v1DLiiLenqv/Uz1VMM8r2/32Bt5mL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQUTEMsYWu9RU8g7LZbtLzxXBbzYYnvi/fw6MCEUsucIBpBk9+A//lQr8iuhcorvrvMs8s3V7aiEgxd2R8gW/LJBqvU/XcVe5heTvI7cwuewvykoj19BXBGTzjB2QAX/2/284DsREc55dgl6UGZWbD9dG50Ts9A1Puy5Eb8jl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFhgfhPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420CAC2BCB3;
	Wed, 29 Apr 2026 06:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777445739;
	bh=PHll4ZUqKiT08v1DLiiLenqv/Uz1VMM8r2/32Bt5mL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFhgfhPge/7WpbcBc2sMONWoZHLu8VL0rWWNY364iv6D5SQfahsqi1hTa0Mluri7T
	 CcsM9sRnXsc5j2lftprdsiE43Ve2gSwAKA3SrlIhJe5CZfOiaPJicX0CqQxJGvzlXK
	 k3Z/NBSA+S0xnr9RC9d82YUQYsX9fqcIRwsTNbKULEiWGaINpTd4nW2TUhscX956B9
	 mYacKBtQN4CXxY3ZZ5VMz6hwfmszSmT9R/ozpe2XRqycmy4FMJOTjAOojzHIqdjgup
	 L4Ojis1NJn1aZkkLJdIXnN656kdewwcmDAhlweLtJZ8M/zK4nhhVxD/CLoBVJ6MCvd
	 UvozQfhvMxJ0A==
Date: Wed, 29 Apr 2026 08:55:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Bartosz Golaszewski <brgl@kernel.org>, 
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, "David S. Miller" <davem@davemloft.net>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Felipe Balbi <balbi@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, 
	Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: add st,stlc45xx/p54spi binding
Message-ID: <20260429-crouching-dangerous-basilisk-22cfda@quoll>
References: <20260427142355.2532714-1-arnd@kernel.org>
 <20260427142355.2532714-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427142355.2532714-2-arnd@kernel.org>
X-Rspamd-Queue-Id: AFBC74900BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35569-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]

On Mon, Apr 27, 2026 at 04:23:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The SPI version of Prism54 was sold under a couple of different
> names and supported by the Linux p54spi driver, but there was
> never a DT binding for it.
> 
> Document the four known names of this device and the properties
> that are sufficient for its use on the Nokia N8x0 tablet.
> 
> As I don't have this hardware or documentation for it, this is
> purely based on existing usage in the driver.
> 
> Link: https://lore.kernel.org/all/e8dc9acb-6f85-e0a9-a145-d101ca6da201@gmail.com/
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../bindings/net/wireless/st,stlc45xx.yaml    | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc45xx.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


