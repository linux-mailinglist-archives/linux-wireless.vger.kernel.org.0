Return-Path: <linux-wireless+bounces-31922-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA4CAWsdlGkpAAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31922-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 08:48:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6735014950E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 08:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF52430160D4
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4252D8387;
	Tue, 17 Feb 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jitJvq7p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14F13AF2;
	Tue, 17 Feb 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314533; cv=none; b=B66mbaaILygPa8pdc6Ds0RMJxp6ZX50wAYPP7aDwvKoRUticHp4LwT/VOk7M7cvFWnO3+cXrjLrl5j7EIglJ1QiWr9KxUtLrgU80qXv96tIQVZtlL/TZzew7AYe79TekaKEgCar7PgurCrV1Tsuc4Am+R6fvA5xSuAm08eYIVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314533; c=relaxed/simple;
	bh=SYQPZwM9BPeO0KCiELHpwM0G8Xx03g90P7N90VDHreA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6hsrQDAO34VIPfTeWbiAE7EOsLZEJS42KRZXvJjIjgJ7nL12cY7MVVzELRNz0VHB/uGq8Vu0rwSeIRxv74OIm55BnIAFDWNUoodc6jLWnDyAZSpAU8ZGqxQ4TGaLdSz7esb5yom15vZsyse7QI0V4/Y7KZEfu/FX7XjMQ4suFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jitJvq7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEDEC19424;
	Tue, 17 Feb 2026 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771314532;
	bh=SYQPZwM9BPeO0KCiELHpwM0G8Xx03g90P7N90VDHreA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jitJvq7pLsXhnmdDqHUyEM7sK2Jg0iUAzBw/vJkaxkg0iCjwlmOX0RsZSlNYIjsDV
	 sxbcLsrxM77NprVI0X+yKTrAY3c6rSaNOE++FBgKRgjzYkoWxgn3gxIytBdbzdI+qg
	 Hag5er9O2VqGWKdWGvqLLBb0As5dJFa/TH3SqkZP3AaJAXaLnMBciXJ9bAcZrzVdtu
	 bHkLYlXO/xrHXgH9M3r1gJ93PCyt9l6zTjyoT/Aao+g5w2gqinjHxJV3WWwt1iO+Vl
	 tC5gY6QpJSy/cFFC5QOzPgP9gZeLaDqW3OZOmaj7iXhUO5vn+eizlJgsHjLgRZwmlk
	 Wdf4WaGbxECdw==
Date: Tue, 17 Feb 2026 08:48:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: net: wireless: mt76: add more PCI
 devices
Message-ID: <20260217-lavender-dove-from-tartarus-fca40c@quoll>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1771205424.git.ryder.lee@mediatek.com>
 <5022737c82052132702004ab0fdc073f5cf6df69.1771205424.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5022737c82052132702004ab0fdc073f5cf6df69.1771205424.git.ryder.lee@mediatek.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31922-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6735014950E
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 08:01:15AM -0800, Ryder Lee wrote:
> This adds support for mt7915/mt7916/mt7990/mt7992/mt7996 PCI devices.

No, it does not add any support. I asked you to provide rationale why
this is needed.

Also, read submitting patches finally - it is not "This adds...".


> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> v7: add missing dts mailing list and maintainers

No, you still did not bother to Cc maintainers. I gave you detailed
instruction which you just ignored.

Best regards,
Krzysztof


