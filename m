Return-Path: <linux-wireless+bounces-27156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6561FB4A82C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4521BC60DF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFA328C006;
	Tue,  9 Sep 2025 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="04AYDPag"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384928C009
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409932; cv=none; b=Y7ckiMkp1aBqfzVXUSahaJVvAZV7pjnqFeL/m7E1AreHUtE0xpLnshJriyyTZ6Ysw+wndbIMTd+VnPMJz7VwSh7c1f3mkSseB10070NIjKkQpqCbnnH6xmo0AeKZAEzCsgiazmKSNiuZ9An05nAp4OG7V3pJZxB52r9PPrSDRrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409932; c=relaxed/simple;
	bh=O5Ej2uGVKzXO3eXNONd7fnZIS7KI1x7765n/7tulvhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKFR2+JtdH+WW2QLPTXVxbtUwMlc/ARJmPPIx1RXK5rdRDWeF5wwxKGDUFM7BjvZTb+Ncvx/qPUp/b8gRCp40mgEjq2AYVerZ98N732m2JhIlpbD9tUDYE7LswL4tCUhXbhE0snazTD2uEU2+o3EDXPxH0UGgD2kORpDvTUDfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=04AYDPag; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24c784130e6so59832375ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1757409929; x=1758014729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LaNA4ztuRjbrTnl69ihQqOt5c3Nv7jGseU3931ttclk=;
        b=04AYDPagcVAS7+LlvcWZokC8+yGWCtY/3GXERtF8xDOfrymXkmUDOipX/AlhR8x7SW
         hZwRqbKgAfKxC/WSKrf9854rvpVq1Dls6Ep3ACCRIv841SCN7SoR6RBffY8ueSt8FsYT
         zifnXgttmUWjsr+5bXoYgjmFfyXo2Z1+WBqI5wv29CjlpdoPT4XMa2sBK8xwmfRa8QIR
         i+XmXrfG6DDtaaXSvcaiSiC4B5cILbXkmWovYg3u67cJz/3p9JbIeip50s/kmSyvi6+D
         2BrdBYflT31sm9Jn+K3r/3HY0+cmsU3rNZmtzP0rcopA886YRg3IXHFvEe08LcnzxBGV
         nVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409929; x=1758014729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaNA4ztuRjbrTnl69ihQqOt5c3Nv7jGseU3931ttclk=;
        b=hGLGfYVBKTwS7NqjLo/wBw2gBCmS6X2WfdbU1ZMf8Peh8abrHJq5Zowcs+R7yKZ6ND
         zUvH8zCBqOQ2Yo32etlVmQ+OGxVzmPaerqwPkZNIIrXrcmw07+USiDwwh2itqus66Wa4
         CZUfscIyZ5atVzUkKG9lB3KuynS5zQYCZyCpzSWhNDfw1PKwfUgFRBpemhHks9FVIUIB
         EexD4AECe0NTWWa/ZyUDodUrmuIoHpil+zIM7vt6NgeiiZVKWNRedRGCLeI96DBciDca
         vTtsdw/JeYWmGY10LGgQ7gSc/F4MV2C2lw4hF/uWVzE1f9RzAsnns3VHR6Vg/r40g+oh
         ggXA==
X-Gm-Message-State: AOJu0YwJ6nJOgJPouTqLp6e0w84xp93JYr9CKyGLzWG3NEgoOvF4xaDt
	CDSaUrf2/pLSQAqmjOmRzwaglZNfON7vGWm5NB6ZHRZ6nwc3VCDeTQ8JmUkwqZ+dLRM=
X-Gm-Gg: ASbGncv7wtht2DqSffuEgAv2pTgZ28nRFR0xXRdsXO3HD5WsRHqG3j0lFn6/iCZLtDC
	YMQyVCa7uJsPa6T05Kvg6UERexGsbU12tiFdm4ZJuqs03WqleIzo0DTcjQcgVn9fzzjGaV0QPBW
	uuXy4OAMB0vkbaFb7/M99qkZKMKdk7Amd7OkAPakOTKwIkqe6K05BcSQWWv5G3UmSbmmVdw4Vpc
	OZUe7sjZVvuHircp6O5KGNRx6QyNICLG2UwZgn9ItCh93h93Wd10Cr2x8nq9r8mdFBWRVn1dRRL
	vWnnkdr6GNj/sPzerBhaD7BR9phbk+ro3FXV49hyjZ+58IP8CiMxkZ5pGiZ9yaAOaxE5CXXcTA8
	u/sgPQ7VBhxeht3l0stsuMe4chzqgMniVdMbUvv6rXKwXzA6pJFQT/18sBEkCLnYJuLVJtMryma
	M=
X-Google-Smtp-Source: AGHT+IFhmLn9rwFUoye1S1z+DffopBndkjNcWciCRVunKmghtcad/hRwk6v/Md6GpPXoZifQEEnfUg==
X-Received: by 2002:a17:903:1212:b0:24c:ed7e:53ca with SMTP id d9443c01a7336-25172e32eabmr139842345ad.44.1757409929022;
        Tue, 09 Sep 2025 02:25:29 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea5ccsm117470945ad.111.2025.09.09.02.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:25:28 -0700 (PDT)
Date: Tue, 9 Sep 2025 19:25:24 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com, 
	Andrew Pope <andrew.pope@morsemicro.com>
Subject: Re: [RFC wireless-next 1/3] wifi: cfg80211: correctly implement and
 validate S1G chandef
Message-ID: <x6q3yzmv7dm4qdnmcwuj25jsqsck6f52oe55qzsmvpehmpvuu6@27vr54on5a7f>
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
 <20250909080758.1004956-2-lachlan.hodges@morsemicro.com>
 <8d4d59375d86747b8bace9a1a4b443d7238b5553.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d4d59375d86747b8bace9a1a4b443d7238b5553.camel@sipsolutions.net>

On Tue, Sep 09, 2025 at 10:46:58AM +0200, Johannes Berg wrote:
> > --- a/include/uapi/linux/nl80211.h
> > +++ b/include/uapi/linux/nl80211.h
> ...
> 
> > @@ -4365,15 +4370,11 @@ enum nl80211_wmm_rule {
> >   * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this channel
> >   *	in current regulatory domain.
> >   * @NL80211_FREQUENCY_ATTR_OFFSET: frequency offset in KHz
> > - * @NL80211_FREQUENCY_ATTR_1MHZ: 1 MHz operation is allowed
> > - *	on this channel in current regulatory domain.
> > - * @NL80211_FREQUENCY_ATTR_2MHZ: 2 MHz operation is allowed
> > - *	on this channel in current regulatory domain.
> > - * @NL80211_FREQUENCY_ATTR_4MHZ: 4 MHz operation is allowed
> > + * @NL80211_FREQUENCY_ATTR_NO_4MHZ: 4 MHz operation is not allowed
> >   *	on this channel in current regulatory domain.
> > - * @NL80211_FREQUENCY_ATTR_8MHZ: 8 MHz operation is allowed
> > + * @NL80211_FREQUENCY_ATTR_NO_8MHZ: 8 MHz operation is not allowed
> >   *	on this channel in current regulatory domain.
> > - * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
> > + * @NL80211_FREQUENCY_ATTR_NO_16MHZ: 16 MHz operation is not allowed
> >   *	on this channel in current regulatory domain.
> >   * @NL80211_FREQUENCY_ATTR_NO_320MHZ: any 320 MHz channel using this channel
> >   *	as the primary or any of the secondary channels isn't possible
> > @@ -4427,11 +4428,9 @@ enum nl80211_frequency_attr {
> >  	NL80211_FREQUENCY_ATTR_WMM,
> >  	NL80211_FREQUENCY_ATTR_NO_HE,
> >  	NL80211_FREQUENCY_ATTR_OFFSET,
> > -	NL80211_FREQUENCY_ATTR_1MHZ,
> > -	NL80211_FREQUENCY_ATTR_2MHZ,
> > -	NL80211_FREQUENCY_ATTR_4MHZ,
> > -	NL80211_FREQUENCY_ATTR_8MHZ,
> > -	NL80211_FREQUENCY_ATTR_16MHZ,
> > +	NL80211_FREQUENCY_ATTR_NO_4MHZ,
> > +	NL80211_FREQUENCY_ATTR_NO_8MHZ,
> > +	NL80211_FREQUENCY_ATTR_NO_16MHZ,
> >  	NL80211_FREQUENCY_ATTR_NO_320MHZ,
> >  	NL80211_FREQUENCY_ATTR_NO_EHT,
> >  	NL80211_FREQUENCY_ATTR_PSD,
> 
> This you can't do, you have to keep the old attributes for API/ABI
> purposes and add new ones at the end for the new settings.
> 
> We probably don't need/want to translate the 8MHZ to !NO_8MHZ, I'm not
> sure the 1/2/4/8/16 ever even made sense at all so I'm not worried about
> that, but we can't renumber any  of these (to keep a stable ABI) and/or
> take away constant names (to keep the API.)

Assumed this would be the case, I think it's fine if we keep the flags
but remove the references in the kernel. It also makes this patchset much
cleaner as we no longer have the mess of removing the body of a function,
then removing the rest later.. :) 

> > +	for_each_s1g_subchan(chandef, freq_khz)
> > +	{
> 
> nit: { should be on the end of line for loops/conditions
> 
> > +		chan = ieee80211_get_channel_khz(wiphy, freq_khz);
> > +		if (!chan || (chan->flags & prohibited_flags))
> > +			return false;
> > +	}
> > +
> > +	if (chandef->s1g_primary_2mhz) {
> > +		sibling = cfg80211_s1g_get_primary_sibling(wiphy, chandef);
> 
> also nit: you could move some variables into this scope
> 
> > +		if (attrs[NL80211_ATTR_S1G_PRIMARY_2MHZ])
> > +			chandef->s1g_primary_2mhz = nla_get_flag(
> > +				attrs[NL80211_ATTR_S1G_PRIMARY_2MHZ]);
> 
> Now seeing this and looking back - I think you need additional
> validation in cfg80211_chandef_valid() to make sure that
> s1g_primary_2mhz is _not_ set in the !S1G case?

Yep can include that.

> > +++ b/net/wireless/util.c
> > @@ -109,27 +109,7 @@ EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
> >  enum nl80211_chan_width
> >  ieee80211_s1g_channel_width(const struct ieee80211_channel *chan)
> >  {
> > -	if (WARN_ON(!chan || chan->band != NL80211_BAND_S1GHZ))
> > -		return NL80211_CHAN_WIDTH_20_NOHT;
> > -
> > -	/*S1G defines a single allowed channel width per channel.
> > -	 * Extract that width here.
> > -	 */
> > -	if (chan->flags & IEEE80211_CHAN_1MHZ)
> > -		return NL80211_CHAN_WIDTH_1;
> > -	else if (chan->flags & IEEE80211_CHAN_2MHZ)
> > -		return NL80211_CHAN_WIDTH_2;
> > -	else if (chan->flags & IEEE80211_CHAN_4MHZ)
> > -		return NL80211_CHAN_WIDTH_4;
> > -	else if (chan->flags & IEEE80211_CHAN_8MHZ)
> > -		return NL80211_CHAN_WIDTH_8;
> > -	else if (chan->flags & IEEE80211_CHAN_16MHZ)
> > -		return NL80211_CHAN_WIDTH_16;
> > -
> > -	pr_err("unknown channel width for channel at %dKHz?\n",
> > -	       ieee80211_channel_to_khz(chan));
> > -
> > -	return NL80211_CHAN_WIDTH_1;
> > +	return NL80211_CHAN_WIDTH_20_NOHT;
> >  }
> >  EXPORT_SYMBOL(ieee80211_s1g_channel_width);
> 
> Wait, what? Maybe you just want to remove this API?

:)

lachlan

