Return-Path: <linux-wireless+bounces-7289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1728BE5F2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A97B2A0C7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1B16C86F;
	Tue,  7 May 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7NPxJIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178D16C860;
	Tue,  7 May 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091696; cv=none; b=f4IUUiw7a9QWyeVvto97Hkx63jFluxHvH+PCT7jzODZV4JYsvhN60VYu1ieVOa2mUZfwCl0lNAPxYz8MZjtpjw8xvfhKdQWNNPTt/M0xczaXKxuSeZ4PhAVJ5iCnAO0dtMCBST4Xi+8Eu+63la4pRbW2ikJs/djkL8cQQ9NKro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091696; c=relaxed/simple;
	bh=i2E5f+dB1EUwb3tuR1XJwg1cOzf13xFovo4QS6A7gTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ughg8s7quCo4z6KBP6OfVf5C25dZkQ4JMaCEktFQ2nWi6uQAzOtaYslTvJkvm9B+hTVZTRFHzMSa7ja2AC8h4OBwMvovPJUqjhAEcSTUky727u2k0TBEAtJk8uLpYubsAy2VhmPKGYrzrYmIT1IULsWFTdW86aEQ1lOknktcESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7NPxJIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EDAC2BBFC;
	Tue,  7 May 2024 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091696;
	bh=i2E5f+dB1EUwb3tuR1XJwg1cOzf13xFovo4QS6A7gTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7NPxJIFUnhj41GEADsCnTt0O/mg9WsB7JFfNkseRXukJoeOZ7qfekt2H2oYKxvPc
	 sDhp9VrS+Umsdf3lq0jV8eFnQr+zUVxom9DrXDbXlYy/bILEaD4zWk1zsP4+nZuBU5
	 C5kvWCmM2I0YCP8nn8dBqHcVxDv6KW7z2Scu3eeKK03RXxXn1x8QFHcL2TjbuBwjtQ
	 9ptcQRePaqfexMQIVr1Eu8Zbg6tiHT+Rn759rMZ6hbT5sRaWBrbkoB/G/jo8hm3Da3
	 4HLSBBiSSv00c9b25uLBnYJZberuqKLnBBt/2f/PkK8joNdyafr4/87Y+yhQ4cd7Fh
	 dob8ZjGFpFaKw==
Date: Tue, 7 May 2024 07:21:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <20240507142133.GB2746430@thelio-3990X>
References: <20240424220057.work.819-kees@kernel.org>
 <20240425181342.GA657080@dev-arch.thelio-3990X>
 <10256004963b6e1a1813c6f07c5d21abfc843070.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10256004963b6e1a1813c6f07c5d21abfc843070.camel@sipsolutions.net>

On Tue, May 07, 2024 at 12:46:46PM +0200, Johannes Berg wrote:
> On Thu, 2024-04-25 at 11:13 -0700, Nathan Chancellor wrote:
> > On Wed, Apr 24, 2024 at 03:01:01PM -0700, Kees Cook wrote:
> > > Before request->channels[] can be used, request->n_channels must be set.
> > > Additionally, address calculations for memory after the "channels" array
> > > need to be calculated from the allocation base ("request") rather than
> > > via the first "out of bounds" index of "channels", otherwise run-time
> > > bounds checking will throw a warning.
> > > 
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > 
> 
> How do you get this tested? We have the same, and more, bugs in
> cfg80211_scan_6ghz() which I'm fixing right now, but no idea how to
> actually get the checks done?

You'll need a toolchain with __counted_by support, which I believe is
only clang 18+ at this point (I have prebuilts available at [1]), and
CONFIG_UBSAN_BOUNDS enabled, then they should just pop up in dmesg.

[1]: https://mirrors.edge.kernel.org/pub/tools/llvm/

Cheers,
Nathan

