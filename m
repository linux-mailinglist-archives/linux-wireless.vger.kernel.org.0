Return-Path: <linux-wireless+bounces-23112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F975ABAAC4
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 16:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD84E161A2B
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226041FDA9E;
	Sat, 17 May 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="o/S121zr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53061E3DF4
	for <linux-wireless@vger.kernel.org>; Sat, 17 May 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747493640; cv=none; b=SMQ/4icm46/9OzzA1rBaKFBM779uCk8ddlBC857Qmvb4XKNUWwyRF7MhcWR70TAmR1xyX8x308V7vugWKiUBPo/b5CVXhkwICzTUkOW0xbK0qMuvd+Oow38y2lnWiFXsWXELnGUPbT6PmES9K+VbQOiM5X0VPtnxzh0HvQJou+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747493640; c=relaxed/simple;
	bh=cXMPqTXmSg3A8q4/lexSQeKGv7Eq/skAQeXYIDOSZKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm5sgNVa6OZSyvkv4Sgmbmh0gxisH9ED/2vAr3xvRG/qaXjtWOtGX2qNIHQVer/H6ezvdnFyPEkUzEz5a7xrhGevdI4a9sYnVaFeu7JYaun1u7v3xcNrD9bUooqc2iDuvI5XdIU3uBBYvG5Cuxi9CfqdtmCbRaffUukE7JH2obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=o/S121zr; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 35466 invoked from network); 17 May 2025 16:53:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1747493634; bh=h56n9EjT24/ca+cjGGEx6B8lTas1EKvnunog3UGR0TE=;
          h=From:To:Cc:Subject;
          b=o/S121zrHyMZmR5wlV6RIf/tnaIlsf2C8/kf0ajc8VaiUkd5M+CcDGLqabNoINkzt
           GLU5AaUnvqDoI8FtuAoRRHmMbVPjICsUXALnxwANtmNblZcCh8t0LrCcYYSNGofH3j
           RmMYFZXIt3MCMcnBIGww9Et4RXFqRNGs2jg+sRYHe/3NLGewKBPyNolzHMmgtwwwvX
           Rj3q9lKv+hU1NpR7uLG8DELcXFI7TBJWTaGMqYwp9PgndnYtgRYtZN1oX9vW/6JIxS
           zBwernAIAk3BxjBYxsC4Mgl0WPnD7XM/IPvVztwE+E39NO7plEZExQjlWlSTlPzMXm
           F3R4detOERQng==
Received: from 89-64-9-114.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.114])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <pchelkin@ispras.ru>; 17 May 2025 16:53:54 +0200
Date: Sat, 17 May 2025 16:53:53 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexei Safin <a.safin@rosa.ru>, lvc-project@linuxtesting.org,
	netdev@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] wifi: iwlegacy: Check rate_idx range after addition
Message-ID: <20250517145353.GA138457@wp.pl>
References: <20250424185244.3562-1-a.safin@rosa.ru>
 <20250427063900.GA48509@wp.pl>
 <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
 <20250517074040.GA96365@wp.pl>
 <hrpy3omokg5zvrqnchx4jvp26bvfgdrashkmrjonsyz5b64aaz@6d5kn7z7x73q>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hrpy3omokg5zvrqnchx4jvp26bvfgdrashkmrjonsyz5b64aaz@6d5kn7z7x73q>
X-WP-MailID: 97996bdff59639d864b2fefc20139b51
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8UNh]                               

Hi Fedor, thanks for review,

On Sat, May 17, 2025 at 03:21:03PM +0300, Fedor Pchelkin wrote:
> On Sat, 17. May 09:40, Stanislaw Gruszka wrote:
> > Move rate_idx range check after we add IL_FIRST_OFDM_RATE for it
> > for 5GHz band.
> > 
> > Additionally use ">= RATE_COUNT" check instead of "> RATE_COUNT_LEGACY"
> > to avoid possible reviewers and static code analyzers confusion about
> > size of il_rate array.
> > 
> > Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > Reported-by: Alexei Safin <a.safin@rosa.ru>
> > Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> > ---
> 
> Thank you for the patch, Stanislaw!
> 
> Please see some comments below.
> 
> >  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > index dc8c408902e6..2294ea43b4c7 100644
> > --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > @@ -1567,16 +1567,19 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
> >  	/**
> >  	 * If the current TX rate stored in mac80211 has the MCS bit set, it's
> >  	 * not really a TX rate.  Thus, we use the lowest supported rate for
> > -	 * this band.  Also use the lowest supported rate if the stored rate
> > -	 * idx is invalid.
> > +	 * this band.
> >  	 */
> >  	rate_idx = info->control.rates[0].idx;
> > -	if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_idx < 0
> > -	    || rate_idx > RATE_COUNT_LEGACY)
> > +	if (info->control.rates[0].flags & IEEE80211_TX_RC_MCS)
> >  		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
> > -	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
> > -	if (info->band == NL80211_BAND_5GHZ)
> > +	else if (info->band == NL80211_BAND_5GHZ)
> 
> 5GHZ shouldn't be in 'else if' clause, I think. Is it mutually exclusive
> with IEEE80211_TX_RC_MCS ?

Right, this is wrong. I thought we can use index returned by
rate_lowest_index() but we still should add IL_FIRST_OFDM_RATE.
At least this is how is done now.

> 
> > +		/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
> >  		rate_idx += IL_FIRST_OFDM_RATE;
> > +
> > +	/* Use the lowest supported rate if the stored rate idx is invalid. */
> > +	if (rate_idx < 0 || rate_idx >= RATE_COUNT)
> 
> There is a check inside il4965_rs_get_rate():
> 
> 	/* Check for invalid rates */
> 	if (rate_idx < 0 || rate_idx >= RATE_COUNT_LEGACY ||
> 	    (sband->band == NL80211_BAND_5GHZ &&
> 	     rate_idx < IL_FIRST_OFDM_RATE))
> 		rate_idx = rate_lowest_index(sband, sta);
> 
> so RATE_COUNT_LEGACY (60M) is considered invalid there but is accepted
> here in il4965_tx_cmd_build_rate(). It looks strange, at least for the
> fresh reader as me..

Indeed this is strange. I'm not sure why those checks differ.

Anyway for the rate_idx in il4965_tx_cmd_build_rate()
for 5GHs I'll just add additional check like below:

	if (info->band == NL80211_BAND_5GHZ) {
		rate_idx += IL_FIRST_OFDM_RATE;
		if (rate_idx > IL_LAST_OFDM_RATE);
			rate_idx = IL_LAST_OFDM_RATE;
	}

This patch should be dropped.

Regards
Stanislaw



