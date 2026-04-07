Return-Path: <linux-wireless+bounces-34476-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNwMDxsg1Wnr0wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34476-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:17:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9907C3B0CC7
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F37D330086DA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9911F355049;
	Tue,  7 Apr 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b="dFNOKzPd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender-op-o11.zoho.eu (sender-op-o11.zoho.eu [136.143.169.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189435837C;
	Tue,  7 Apr 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574837; cv=pass; b=TuE2Kuh9cCWfFetnb/ThqtS6W47FEPctVtIlELvI5XVBMXMw8S0WvZl9P6EOKTDGZsPPaF1acT2Dz2EboaaoEz3md3PgF48D1lS+jzQnJmYayTflQTxXNb12901RxsOiQrfegTkhbGMjIvFZocZqsUojlqota3cU5XpmZhQYQ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574837; c=relaxed/simple;
	bh=//JcOV5p++bvo8mEpEEaKaGB8OSx+1UJgdY3pC7NSVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR48go26sN9fo1LxFb1QIJA5vVMRv9qzeqzCSYOLJDx2G9cI742GY3prfwjGFcnjf3jyOwv4VjB/IVh3V7QpsJTFt6SgQQHplvjOKa0ooqZd8rmEiHS1LT8HFYb5iKUBODQrOrackj9Uiqv8PgaucVfbGxXCO0svWEIaUy3xD/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl; spf=pass smtp.mailfrom=kempniu.pl; dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b=dFNOKzPd; arc=pass smtp.client-ip=136.143.169.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kempniu.pl
ARC-Seal: i=1; a=rsa-sha256; t=1775574801; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kM+05SV0CmLYqKkgn/7OzyRyijeAAz9XNg9KzLczJwcA0XFAVXwxEfUa9s+Z6f/aY6OcS5UmBHae9RCK+ljDPSv9wWbAjFMUmtivhBzfmeAFZt+cyktm32sbyac/MNvuxu04B/Y7NSkEqfJp1SDWLS4YcLNKj1ktnVV8o3EOk2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1775574801; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pM755TWVDXtvctLCMSHYr2HPrQ23PcJ/n2NnUxGMouw=; 
	b=C2zzF8vXm6zy6D1OK1dCYISpCUM1N+o9efs2NDdHh0KHjTtb6R1BuPYyUoioehrCDNOa9qOeprrS/s7uieZXdSWDTjt9/ALR9A7T3qBgbSABuA5iVBnUo6L+J/iKYZP7VNokOXv47AzKisgSYsrTYiL5MMdptLU4Y8A1z8XcXy8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kempniu.pl;
	spf=pass  smtp.mailfrom=kernel@kempniu.pl;
	dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775574801;
	s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=pM755TWVDXtvctLCMSHYr2HPrQ23PcJ/n2NnUxGMouw=;
	b=dFNOKzPdSO/DYJwujrCPP9NcxPw0hOqZxOMbCdeNZkCcWKY6Fvgf7O+YrJjTY8f2
	+ipIyTwqdaiVv7byRvj47sdkOrAuDBnYe3i5Y36/3Zu3HqA4DE0F0xLGG3H/qH6pBw1
	sn6s4RCN9vO6DMAMfa8vOTTM03Z9zX/j6EAY3K2Q=
Received: by mx.zoho.eu with SMTPS id 177557479865717.399845662206303;
	Tue, 7 Apr 2026 17:13:18 +0200 (CEST)
Date: Tue, 7 Apr 2026 17:13:16 +0200
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Linus Walleij <linusw@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <adUfDB4y-xt5QorX@larwa.hq.kempniu.pl>
References: <20260317-descriptors-wireless-v6-1-b19ecff9cd2b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-descriptors-wireless-v6-1-b19ecff9cd2b@kernel.org>
X-ZM-MESSAGEID: 1775570913823007700
X-ZM-MESSAGEID: 1775571581406007700
X-ZohoMail-Sender: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
X-ZM-MESSAGEID: 1775574477695007600
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.01 / 15.00];
	R_MIXED_CHARSET(1.15)[subject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[kempniu.pl,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kempniu.pl:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linux.intel.com,arndb.de,free.fr,bgdev.pl,toke.dk,vger.kernel.org,broadcom.com];
	TAGGED_FROM(0.00)[bounces-34476-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kempniu.pl:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@kempniu.pl,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,larwa.hq.kempniu.pl:mid,kempniu.pl:dkim,kempniu.pl:email]
X-Rspamd-Queue-Id: 9907C3B0CC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Linus,

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

I could only test a 6.12 backport of v6 on real hardware as that is the
kernel version that OpenWRT's current main branch uses for my router.
That being said, the only conflict I had to resolve was the one caused
by commit 551a097118391018ddc4079cbcec6fe4e7d64bc5 ("gpio: ath79: use
new generic GPIO chip API") in ath79_gpio_probe(), i.e. no functional
changes were necessary.

After replacing the "tweaked" version of v2 with a 6.12 backport of v6
in OpenWRT's source tree, the WiFi LED still works fine on my router.

For the above:

Tested-by: Michał Kępień <kernel@kempniu.pl>

-- 
Best regards,
Michał Kępień

