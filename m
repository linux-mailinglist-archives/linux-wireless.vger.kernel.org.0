Return-Path: <linux-wireless+bounces-35042-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IOjEgAN5mluqwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35042-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:24:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8160429E64
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09F8030146B4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35AA393DE6;
	Mon, 20 Apr 2026 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EYRazRQ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E035343D7F;
	Mon, 20 Apr 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684283; cv=none; b=SESyLVNxphjGnNpn9nyTFCWOzyIKKpwFsHLrgLL79FS1Nei5zUjwI2AFcMEkjrRIn78uz25cClOyUGVXnQZ59OqnY2tibzoafXaIlkponPH4olAocKDFowI50FZkp7rd99kGmqkm8VfB427hIciKnP+Mow61O9aAQF50EEj3aXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684283; c=relaxed/simple;
	bh=47W35rh/mMCLQXPRDwYAG5PUe6RYoYdQ6G/0S2HxWEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo9k6FflkGHlqP6iqb5TvHIB56TJVZicxfiHoENEMKOPOxHsUbE5n7IQcJ2w7q/dgzxV1i9cs1vJ4hqUOlFsb2fLXZQUAvqSm8+3zjF1qufDXu6sZLazSFVQR7JqcTv/rhzHrwqaKfVoCWgVg+irg4ql2sr2L9eGSWTl2Yv9hKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EYRazRQ+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HFCHZ2mGNLNZ9GU5z2Bd294rO8tmj5ZIpPj/CtmDgZk=; b=EYRazRQ+Fn5BbeISOIIdwweLLo
	vfT8i7CWpZNYbXDUrWs12QFZ3Jc0JawhcffPxYy3vtTu642xmoyyalRW39DkTyouk7MCuuGOPy2pB
	4JlAP84EQbux+YzlWETVTr/Z7w5U/wTCdZFbUR2PrvocdDO1NK04tvUauizdFIQlRB7FnpwgkgkxV
	bS6ODPz4Zfy3+L0ncclRSNek27FU1MZX4Y4p9GRY5HoaKZZSmLINWjJDbVpYeUPHzt5bwp7J30xxY
	/3zbrQBGMVOLqstuCke/xoEPm6jznL5xaW/KjTco9TOqtwLXIGFVUubk6wlEIYmmqNwJiWoZnY4Wd
	oOHDwVoA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEmjt-00000007p0p-0dW8;
	Mon, 20 Apr 2026 11:24:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9690B3021A4; Mon, 20 Apr 2026 13:24:28 +0200 (CEST)
Date: Mon, 20 Apr 2026 13:24:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Ben Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/9] x86/extable: switch to using FIELD_GET_SIGNED()
Message-ID: <20260420112428.GF3102624@noisy.programming.kicks-ass.net>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-3-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417173621.368914-3-ynorov@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35042-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: E8160429E64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 01:36:13PM -0400, Yury Norov wrote:
> The EX_DATA register is laid out such that EX_DATA_IMM occupied MSB.
> It's done to make sure that FIELD_GET() will sign-extend the IMM
> field during extraction.
> 
> To enforce that, all EX_DATA masks are made signed integers. This
> works, but relies on the particular implementation of FIELD_GET(),
> i.e. masking then shifting, not vice versa; and the particular
> placement of the fields in the register.

I don't think the order of the mask and shift matters in this case. If
we were to first shift down and then mask, it would still work (after
all, the mask would also need to be shifted and would also get sign
extended, effectively ending up as -1).

But yes, this very much depends on the signed field being the topmost
field and including the MSB.



