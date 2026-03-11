Return-Path: <linux-wireless+bounces-32985-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO9rNc9WsWmGtwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32985-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:49:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0B263187
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07C66306B79A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6F3C7DE6;
	Wed, 11 Mar 2026 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="N/ygScNT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6533DDDD8
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229736; cv=none; b=TQiB/FDA8mnL2BBp5mCe/j+b7PCuWePM30ypaAgZLZPMrscT1slYRZsFQKYDWtaVE0XAPuNTzYMSMYFlJOsO+1VTwkvXRCYc1nZF7fji3MPBZbiCfNvmZdWhLpjBhNFJNoORbQCHux1fizbnQ4rg5yYOW/C5QdvznjNxOzRHS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229736; c=relaxed/simple;
	bh=3VvcpGZ3a9Kimg/m5dW9W34gjX04iM34A+igarvQrPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPJNGSjuO2jgGNep1nTmO2uzZJb4xIBGFUPLhuKUMWGSwuzvEug/u4AaqNVF/L/GAH/3TjYMy/TV/IUFMguT6f3+3po14L1kotzMPflXUlqP4+UPiCwffATQIcMLVS4N2d1RRPpIpfJi9/pTrAO1z/ICKLISsUqCvOdNVtdVEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=N/ygScNT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aea68839a5so7187555ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773229735; x=1773834535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shBgew1sfYmt9ti86iub8tHGLDl4mhjB7e5YOdjQzFo=;
        b=N/ygScNTaj81NOQ3+TBF1vWCZmgZYzXQLONUfO8hK3tmTvRAehY8ZNq3WP2OYf57SN
         Y25dA+aKDP9qu7VIuZxJSD7m2/njeivs7OTGvXbEhTESBFV3TRROQK+l2C28SP5B16+A
         gVIfjV01KprFPingr2Lv62muSaqlUDmJZHH5X1gp0PyJakArp3FgdRlkiBeYzESfJIoP
         024YAwd2o1RpcO7yVEKsTpXYfx04YyZgNEZte1PhnsLDlgbHzab7opqnoZ/xJWzOQznL
         cnk3jlXsArjPLmiotxdfXFG4wotdHD8yA10aFcIO6LPzmocCdq8wQY7KuTX53hiczjV8
         NvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229735; x=1773834535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shBgew1sfYmt9ti86iub8tHGLDl4mhjB7e5YOdjQzFo=;
        b=YjOUdH3QQpA+U2r+nKJjQmWObwLxebpnDQXzJRXRWE9cspYm5ovX3C6KMsirZJDHqq
         IZxh7gfBsyLuUbql2sBdbILSq++nYuCuYl795By4CCIya6IWLH3P1psZ4mWdjhpnzEai
         j4W6H/CXUyDnxk6mvqXnqSm3tHAOwGAujtm97uJa3vOkgiU27jXSZaJRnG3aXL+CR0ef
         vT8bN3e1HFcgkCTdKiQ5T4TMCfcKb4Eo3+VO4I3yqJpSUx0TlO5NcjapjyHSCc5iE7lY
         P/bSSa4xiu2y+y5L7xmFmXWmvgMXjzwrFqbUiirEQj6U2SvtQ4uevnt193rILQVJpb2w
         na4g==
X-Gm-Message-State: AOJu0Yx7OmVWQOGf1evJix1bOJ/ZeQDvYF5hPuwPe+nZRkbzVPxEtCFQ
	AY1sV4epDDwBBtsV8nlDqocV537svOAeiv+c1veLd5/BWsCLkSDzvnnDZ90jkd37R/w=
X-Gm-Gg: ATEYQzw2A7z1jicI5qKVzoDdbpqtTWpNJF0aqIBLEa/Z6jCa+ImtR0J0lf5ghJYCGzv
	z0Kr5A6q3iSGliOYHe9wGmhBmQUWLFJC2z5yy4VESZwxfiQWrP3qo3SsXlQNal2GbNyTmxhfxL2
	YtgtKAozeARZwlH63FFsFVJHqWjPFpplEF4Z7NrtNBnv9TsWzDbbgE9ybL9tlZhHdhKb5YKcBiO
	EikJZD4nMlYOzldGphKXrRcP+tuKosryis+LbFXSCRkBpDDHEWVWB3KYqEQLFWMbhkmptOjqRTI
	bGHfkeR3p6L+hyriS73AkQ3rEHRsZnx/rXkhmrN9JfZuICth/MkoRD+Bf3eHpICBJt5gC/c/LBi
	8dZAZFXi7huFer1vSOMUWBRr9OwkgGaQ4b1Pex/Syf+pmm2nLiAyyYjsBIfApfF9EOx9fGXCyh4
	2UFmadBM0+NtvQZUNlrKbe3NcjvnCr9uWVkEFP6QGc11F4Qd3OqK/cAsbtHLuQegof
X-Received: by 2002:a17:903:f8d:b0:2ae:3a77:a1f6 with SMTP id d9443c01a7336-2aeaeb36d71mr20140075ad.6.1773229734839;
        Wed, 11 Mar 2026 04:48:54 -0700 (PDT)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34de45sm21844505ad.47.2026.03.11.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:48:54 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:48:49 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: init S1G properly when
 creating chandef
Message-ID: <6eitsqhsmmhwgd3cobhpdhhzn5m5siw4ser53g3ilvd7kdhy2u@rkilpa5ek26y>
References: <20260311064339.524758-1-lachlan.hodges@morsemicro.com>
 <791eaf8ab04dcbe01e2d71612d162f71c61e573a.camel@sipsolutions.net>
 <4dhrrbuvxdgve2doc7qvabzjancimtqpounngyrxspk4d4rbls@xnad5bwciz7c>
 <b725c0be05df1a9595c177aada4cc148bf555448.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b725c0be05df1a9595c177aada4cc148bf555448.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 3FB0B263187
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32985-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,morsemicro.com:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 11:56:37AM +0100, Johannes Berg wrote:
> On Wed, 2026-03-11 at 21:21 +1100, Lachlan Hodges wrote:
> > On Wed, Mar 11, 2026 at 10:55:46AM +0100, Johannes Berg wrote:
> > > On Wed, 2026-03-11 at 17:43 +1100, Lachlan Hodges wrote:
> > > > When creating a chandef, the initial width is determined by the
> > > > chan_type argument leading to a default width of 20/20_NOHT/40 which
> > > > does not make sense for S1G channels. Fix this by ensuring we default
> > > > S1G chandefs to a width of 1MHz.
> > > > 
> > > > Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> > > > ---
> > > > v1 -> v2:
> > > > 
> > > > - Remove the mac80211-based wording in the commit message and keep it
> > > >   simple.
> > > 
> > > Thanks :)
> > > 
> > > Now with more tea and all that, do we really want it to completely
> > > ignore the width? Should that be documented? Almost feels like it should
> > > WARN if you use it wrong, with an S1G channel but a regular width, and
> > > mac80211 should be fixed?
> >  
> > When you say "ignore the width" 
> 
> Sorry, I meant the channel type (chantype argument).
> 
> > do you mean nothing checks it?
> 
> I meant for s1g the chantype argument would be ignored now, not that it
> wasn't checked.
> 
> > If
> > that's the case we probably need to add something within
> > cfg80211_chandef_valid() to ensure if we have an S1G chan we don't
> > have a non-S1G width i.e > 16MHz. That would fix mac80211 from
> > giving it to the driver in the first place.
> 
> We don't have that? Seems like an oversight too,

Yea we have one way not the other, I will send a fix for that at
some point.

> but I was thinking like
> this (overall changes, not split to commits), since
> cfg80211_chandef_create() really doesn't work for S1G since the chantype
> is 20MHz-non-HT, 20MHz-HT, HT40+ or HT40-.
> 
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index b0451f1c8e79..9a055dfb445a 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1118,6 +1118,19 @@ ieee80211_ifcomb_check(const struct ieee80211_iface_combination *c, int n_comb)
>  	return true;
>  }
>  
> +static void ieee80211_create_default_chandef(struct cfg80211_chan_def *chandef,
> +					     struct ieee80211_channel *chan)
> +{
> +	*chandef = (struct cfg80211_chan_def) {
> +		.chan = chan,
> +		.width = chan->band == NL80211_BAND_S1GHZ ?
> +			NL80211_CHAN_WIDTH_1 :
> +			NL80211_CHAN_WIDTH_20_NOHT,
> +		.center_freq1 = chan->center_freq,
> +		.freq1_offset = chan->freq_offset,
> +	}
> +}
> +
>  int ieee80211_register_hw(struct ieee80211_hw *hw)
>  {
>  	struct ieee80211_local *local = hw_to_local(hw);
> @@ -1261,9 +1274,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  			/* if none found then use the first anyway */
>  			if (i == sband->n_channels)
>  				i = 0;
> -			cfg80211_chandef_create(&dflt_chandef,
> -						&sband->channels[i],
> -						NL80211_CHAN_NO_HT);
> +			ieee80211_create_default_chandef(&dflt_chandef,
> +							 &sband->channels[i]);
>  			/* init channel we're on */
>  			local->monitor_chanreq.oper = dflt_chandef;
>  			if (local->emulate_chanctx) {
> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
> index d9d4e043bb39..4ae2f6ca0378 100644
> --- a/net/wireless/chan.c
> +++ b/net/wireless/chan.c
> @@ -29,9 +29,10 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
>  
>  	*chandef = (struct cfg80211_chan_def) {
>  		.chan = chan,
> -		.freq1_offset = chan->freq_offset,
>  	};
>  
> +	WARN_ON(chan->band == NL80211_BAND_S1GHZ);
> +
>  	switch (chan_type) {
>  	case NL80211_CHAN_NO_HT:
>  		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
> 

Initially reading this I was a bit concerned because it means any
path calling cfg80211_chandef_create() wouldn't work for S1G; But it's
actually only a couple of places now that call it and - being forward
looking - for example with channel switching we would probably have
an S1G specific path similar to processing a S1G connection anyway. No
important paths (will confirm this) call this function anyway they
seem to build the chandef locally.

I'll do some testing, if it seems OK will send a new patchset.

lachlan

