Return-Path: <linux-wireless+bounces-35270-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF6DKKBd62lGLwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35270-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:10:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F109345E36F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E63300EAAB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F063C343A;
	Fri, 24 Apr 2026 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km+siIRS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04473C279B;
	Fri, 24 Apr 2026 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032585; cv=none; b=eKe9Tm3NRxNye0X5tOXz1M//7mkX0+WuqYYvD4V57INkhFy7C5aY6dnsROc25gsWlpYSEnD7/5sThraavKdUhVm1S0mGJwi3dA7NyZ2Qr1/qcf2oLhbepQtFtGm6shYvvQPdBS4ByiqKeVhhL7glQ2xgioehL1fE4yc4HMNAm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032585; c=relaxed/simple;
	bh=rRaSkeKhlvpU4tWi8hdt4ujoWHjih8+/eulMWmIEvI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNsc2jKZC6IURwpMbfm6cbdfdpmudgH0zfBh3g8/4LPTOh5l8H0mgT4+WCdsPWSPc0vZ445ZW0P3VsgUvnP0QmRWsxGpREboLxJztVAByw5S4VZMAFjtpju+QHjBuDiGkeq2TvS3U9C0ODmM3E7XrPs2a3lVWlA3/Eck9c3WIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km+siIRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D64C19425;
	Fri, 24 Apr 2026 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777032585;
	bh=rRaSkeKhlvpU4tWi8hdt4ujoWHjih8+/eulMWmIEvI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Km+siIRSuoDTa3nXOPBrNIscTm6Udb4rIj9eJRYWafziUy3gUVXZlj3UmWYvd0tUb
	 4oO1dWzyHJ9SUCNIov620+KeDrw8mKfNwpqK9sCoIHdlPu5MDd3V5HKgQ5lzaj+y70
	 oJ0qID4VKZK2Xq9F6l1p/bff0ZxHNSSXgCStxzgvoIq4X3Om3dS4bga6VK24rEXTHC
	 I/EhE+CDjHynmxgsnMUMGbYMU3TmjLj0Sb+v2nVAlspbLWthFhbI+kAB2cDIK2Crmd
	 PYbVxjlF+F40zzKQX9DH/H5i854t1XPwlIHlOY7FbAWJAOQtxbyFe82jhT6xZjLdj7
	 bEOyJVLK+yP/A==
Date: Fri, 24 Apr 2026 13:09:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Hans de Goede <hansg@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Salah
 Triki <salah.triki@gmail.com>, Achim Gratz <Achim.Gratz@Stromeko.DE>, Ben
 Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260424130927.349ad3ae@jic23-huawei>
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F109345E36F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35270-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

On Fri, 17 Apr 2026 13:36:11 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> The bitfields are designed in assumption that fields contain unsigned
> integer values, thus extracting the values from the field implies
> zero-extending.
> 
> Some drivers need to sign-extend their fields, and currently do it like:
> 
> 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> 
> It's error-prone because it relies on user to provide the correct
> index of the most significant bit.
> 
> This series adds a signed version of FIELD_GET(), which is the more
> convenient and compiles (on x86_64) to just a couple instructions:
> shl and sar.
> 
> Patch #1 adds FIELD_GET_SIGNED(), and the rest of the series applies it
> tree-wide.
> 

Just a quick heads up that I'm beginning to assume that this series
will land in some form.  If it does can we do it as an immutable branch
as I'm suggesting it gets used in some other patches in that should land
in the new cycle.

Thanks,

Jonathan

> Yury Norov (9):
>   bitfield: add FIELD_GET_SIGNED()
>   x86/extable: switch to using FIELD_GET_SIGNED()
>   iio: intel_dc_ti_adc: switch to using
>   iio: magnetometer: yas530: switch to using FIELD_GET_SIGNED()
>   iio: pressure: bmp280: switch to using
>   iio: mcp9600: switch to using FIELD_GET_SIGNED()
>   wifi: rtw89: switch to using FIELD_GET_SIGNED()
>   rtc: rv3032: switch to using FIELD_GET_SIGNED()
>   ptp: switch to using FIELD_GET_SIGNED()
> 
>  arch/x86/include/asm/extable_fixup_types.h       | 13 ++++---------
>  arch/x86/mm/extable.c                            |  2 +-
>  drivers/iio/adc/intel_dc_ti_adc.c                |  4 ++--
>  drivers/iio/magnetometer/yamaha-yas530.c         | 12 ++++++------
>  drivers/iio/pressure/bmp280-core.c               |  2 +-
>  drivers/iio/temperature/mcp9600.c                |  2 +-
>  .../net/wireless/realtek/rtw89/rtw8852a_rfk.c    |  4 ++--
>  .../net/wireless/realtek/rtw89/rtw8852b_common.c |  4 ++--
>  .../net/wireless/realtek/rtw89/rtw8852b_rfk.c    |  4 ++--
>  drivers/net/wireless/realtek/rtw89/rtw8852c.c    |  4 ++--
>  drivers/ptp/ptp_fc3.c                            |  4 ++--
>  drivers/rtc/rtc-rv3032.c                         |  2 +-
>  include/linux/bitfield.h                         | 16 ++++++++++++++++
>  13 files changed, 42 insertions(+), 31 deletions(-)
> 


