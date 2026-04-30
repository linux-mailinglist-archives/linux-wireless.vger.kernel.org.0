Return-Path: <linux-wireless+bounces-35702-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOO/Ag8g82lsxQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35702-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 11:25:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7949FD3B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACD7A3005989
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAA3A0B32;
	Thu, 30 Apr 2026 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iot/Czbj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46A39F160;
	Thu, 30 Apr 2026 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541129; cv=none; b=D5hMj1nxEpOETapXT0FoUcSQkrSkRioqQgDF90qKuHZPp9LrXx4U+bBGIZqoAU2ajYUaOJtc1EN+mrii8Uv1PYWrQaHQjI0yqPyGnedN0oc1bRYZI3Al6qqryjHew85osbwExpxeDf9RymHwn3osIPq/7qN4kIZpV4NZDxtuxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541129; c=relaxed/simple;
	bh=B853Eh9uk565MxVVpob3pa08VA0fsq5RODboe/BkwDg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Fs9Qj9uAzNV9xGK6MexXhqUIWgV+GRItq+yDB6BBdVRDB9TMOxqyDnAkI6yVJ+8IN55iGUiWzg6yjlNNd9wvxw/JAFoPnuPXTvDeSUI2Ui8fOLUwM2AcqG2c/M6C4i/L4TeBlGCg377xEJ57/7LPWwvHHrY0RidE7Mx3PElnUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iot/Czbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C5C2BCB4;
	Thu, 30 Apr 2026 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777541129;
	bh=B853Eh9uk565MxVVpob3pa08VA0fsq5RODboe/BkwDg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=iot/Czbj1UTXZtIKbuakUOJPEZf2jgEJsXUobkf3fTE6pxHY1WoYVSUKSdjGjweU2
	 uJCII7hbjhIouQ7z+4khXHPcxKRfaQKW5M8Ob7Ff/2xSIiteOAtptRQ6PRVkaTUlXR
	 m5hnmHC34YoQvr6bwwzWq2O9IDz3/7o6w2Ux/d7uBQOzrHFiHHPE6x5MGEwTHosl5Y
	 FtyWqlDWOsE2uTUmk93O2vMxDZkoZBQ9EeRqJitySRYcWBAmbfCmXMjl7Y98+WSE2j
	 s23YYEIaJkoJReZgcK3bIv8Gfrr3USg/F7iytFGSPEmXH9vDS7tcs9sL21B1DUkETF
	 aW/y9woiMNIXw==
Date: Thu, 30 Apr 2026 04:25:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Christian Lamparter <chunkeey@gmail.com>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
 Eric Dumazet <edumazet@google.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-omap@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Roger Quadros <rogerq@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, 
 Linus Walleij <linusw@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20260430081242.3686993-2-arnd@kernel.org>
References: <20260430081242.3686993-1-arnd@kernel.org>
 <20260430081242.3686993-2-arnd@kernel.org>
Message-Id: <177754112702.3678889.4847926893667561974.robh@kernel.org>
Subject: Re: [PATCH v4 1/3 net-next] dt-bindings: net: add
 st,stlc4560/p54spi binding
X-Rspamd-Queue-Id: 75B7949FD3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kemnade.info,baylibre.com,google.com,kernel.org,sipsolutions.net,arndb.de,vger.kernel.org,redhat.com,davemloft.net,lists.infradead.org,iki.fi,atomide.com];
	TAGGED_FROM(0.00)[bounces-35702-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arndb.de:email]


On Thu, 30 Apr 2026 10:12:40 +0200, Arnd Bergmann wrote:
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
> v4: renamed file to st,stlc4560, matching the primary compatible string
>     require st,stlc4560 string
> ---
>  .../bindings/net/wireless/st,stlc4560.yaml    | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/net/wireless/st,stlc45xx.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/wireless/st,stlc45xx.yaml
MAINTAINERS: Documentation/devicetree/bindings/net/wireless/st,stlc45xx.yaml

See https://patchwork.kernel.org/project/devicetree/patch/20260430081242.3686993-2-arnd@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


