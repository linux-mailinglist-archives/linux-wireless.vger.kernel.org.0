Return-Path: <linux-wireless+bounces-34973-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aImzI8rW5Gl5awEAu9opvQ
	(envelope-from <linux-wireless+bounces-34973-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:21:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9F4241A0
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB092300FFB5
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7837BE87;
	Sun, 19 Apr 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDhiISp2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D633260B;
	Sun, 19 Apr 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776604871; cv=none; b=o4DQ4CkSPAPNzWtBxF5eDT5hzJYvvU1O++4A4b2s8ig2PfpmEiq1lOBedvO4QvcjK5iZnyg0vxcplFBe27g8jdjBtzeZ7yOZ51EDJGlGkjWSx/Xdc7qm/ovzT2LLK9H8CBqfrp3uzbcAnnknx0fJF+XBgYmHsV2r3vWtS/aEiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776604871; c=relaxed/simple;
	bh=FgDYXkUkm9aucXmTXa4FHW6oLYLPtFizZghvL9EwMm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAs/HuWBg5VhgTY/Uu/5VPjxUZBi2uOU/ICMznsQsObgqmR2EUoC6LS1Kvdc8aqUnyOEXViq2v+rncbDctqR+XvnXdVH1oArfJ/N80UyXHv3LQJjrmxPWodhJfXT6zdVjZW85fofH6NNVcLb3n5frvUgJFsHFsJZHdrPCAAd9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDhiISp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D68C2BCAF;
	Sun, 19 Apr 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776604871;
	bh=FgDYXkUkm9aucXmTXa4FHW6oLYLPtFizZghvL9EwMm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XDhiISp2Bu0d3vER2JR79jpIxctjflJuL7SuiiWuPZ75M71sQppUtfKTKyrR3cYwO
	 WEzADiHx2qew8M3V1O0MD1vhiB+hYHqPR4QC9m4GqGdjS2PFzEtd0Y1/3lulheT/Xp
	 ugDYG8nhDF7krkLw6ZMTfLSsiuwusEZMX3TqbKXkfswUOewKxFwpKxp5y5o52LT0Pm
	 5F5s8NjqlBvl5VN1beILzpkyeivldBiSQ1v6j4tsemKTywS0Oq3tKdoEF8wTiTzeqP
	 lcqhCgiVybVohCBO9IDowaGU8qBiPEOXPfUktCrNy9CHXOiEkgHwrv8djPaaWl65mI
	 LeXlslE3jf3Mg==
Date: Sun, 19 Apr 2026 14:20:54 +0100
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
Subject: Re: [PATCH 4/9] iio: magnetometer: yas530: switch to using
 FIELD_GET_SIGNED()
Message-ID: <20260419142054.0660e8e2@jic23-huawei>
In-Reply-To: <20260417173621.368914-5-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-5-ynorov@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34973-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 43A9F4241A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 13:36:15 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> Switch from sign_extend32(FIELD_GET()) to the dedicated
> FIELD_GET_SIGNED() and don't calculate the fields length explicitly.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>

