Return-Path: <linux-wireless+bounces-25531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC33B0710E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E895168A6B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD2264F99;
	Wed, 16 Jul 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="E8ukO/c+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864723C50A
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656472; cv=none; b=nrJxLXu+gSSU54ANl/JKWMWV8ghaABSZVI/pZ3P+kTwMRF2j3YQkhCikbJBPSTOezkSNqLl5V2448XlMukIXiAtQblAbQb6zZNYXgd4dAGjJagfEYSIgiNhuccxq6ZXXommETS4eWNSvsWrxkxZULFApkzdaG+n7pvOLgS9ykGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656472; c=relaxed/simple;
	bh=wygvSqVuYFyxmJ2vbzH+MKoJt9HOaDE5XxHw8iesggY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJMeZ5wBFTxgrIftaAVlpUc2kK4Jjhbi0/hpXp4EWs3aQGeGHJGLJLf9evmLaKVDwYKioA/n8jUaYOSgwFVuGkMEEJE+/LbDu2Fa29Ivsz9iAzG4RULpqDIVi9yfoLA4sfZa3Y4KX1tYe8IYPuVYLS+OB3IzlRuxSjXqkkeg9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=E8ukO/c+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74931666cbcso5111166b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752656469; x=1753261269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymmRVN9YY+llT0EKhl1FcJhkiipFoRdb1bC5dTqivRE=;
        b=E8ukO/c+EhKgtpHGA8d6kn83tkB9+0uM5ecH5nQAK/lacvMIbX0yLxT0jdJRHvfIPv
         iBfVeTkq6cP9WAH057KqSrpNkj2gINW3jmfqd44M+pHzzZkYlnVbzhutmVLbzhZ7CiFd
         zgLNII7C/VZNNMf1kX0iilEK1iS9sYS8k5wGbwSUC+sxSeq+xj+xkLbFjY3sDtOj/kEk
         PPudnAsOpvQzHjSU+NW/7pwZ0+8dXOTedhMmg9mU1dgAmINR+YpWfLhPIbtF7dG1INUN
         cmtCbMLtl1KlI0/aGCLDpdG1oNg+aQm2t8el+6rjiL8R8VjLXHnHTPkM8AvnqVP69Ldl
         cUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656469; x=1753261269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymmRVN9YY+llT0EKhl1FcJhkiipFoRdb1bC5dTqivRE=;
        b=Bill2L06O101PGZpB8LBpC5OUOrlSsLVYO+xtRu/td25v9jvkdZJV9AgH0BAElXGkp
         jadzPkwxUa9JZUJnbyPvMZCxJJZb3WAwnWjn6guoIeRnVSImLYfwUz8kqjekVwG0gkPG
         1k1W8ACylG2XqgXYSycSqopdHA4LWS4MrRRE/itUSB3qxRrcSklVdqqb7yUbu+JarBuc
         13tdrgkoIiWnEEgiQv1j6HBzT8QnYNTl9G0+lPGO1JUS/ALhdedTJyQtPMSf2yExP34A
         9PDfGEntqLG7UnvCvtEVMGqRJeK9XGtf0FN8pw6uXsabNBOFgKmx2uehQaDIRq3erI1h
         hkSw==
X-Gm-Message-State: AOJu0YzShSkKGdTXoOqc2oMfpKPA2DXvM0JxwUT+XmTE2aIeH/4Oy6+s
	23+hMyEGSapAZXtlp6D5dgYewrjnqSDKOmf3vnoMr2FELfV8zplt/H3O4fMtDDSxrp0=
X-Gm-Gg: ASbGnctyh7JYMomsgeLMs9PT6FOHdhRKjqsXGV1VTpmP0dEcxwJDnSL3M3N71IyHOU3
	MJJueH0aRANAsXZXWVyV+L7LgVxiqU0CAUYqEelX5sWN2/VB03dzLHsec1k7UhM5JxqXSoAVifa
	rvubHrFBGZ6jH+fNzauXErGMnWR1a+lOKLdQzhh6noTBIX/q0dDhMvtIWL1l7WU6HT9ioa9c534
	Brcid4me8z5sZDmtGnB2uU5Y1b9Phi3ThLVXF1AgfZQDq1Uvix7IzW5Y55y+4rC4xgyKZ0cIQ4l
	qayz9CIrTTEJhaf+13iHLs1kWq8cYaWPev1ytnwMWQtqQEqM2ULuuT524rXCQW58RD8DjVBXqC2
	bw+GTe92dxjshEnbJpyeXrbPcfbO4m88=
X-Google-Smtp-Source: AGHT+IFFDP1++P0QGLFauvDh49ZpDNFdm6lTD0bw3lZTZZrgOoDI8PCZEc/VLnsZmW6h8oFZwuJ9AQ==
X-Received: by 2002:a05:6a00:3cce:b0:748:de30:d01 with SMTP id d2e1a72fcca58-756e922f107mr3452811b3a.10.1752656468572;
        Wed, 16 Jul 2025 02:01:08 -0700 (PDT)
Received: from localhost ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1f62bsm13827791b3a.95.2025.07.16.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:01:08 -0700 (PDT)
Date: Wed, 16 Jul 2025 19:01:05 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next v2 2/4] wifi: mac80211: support initialising an
 S1G short beaconing BSS
Message-ID: <3rvtczj6c3svz273xdeowocxfx5cln4qsxqatkvtyfdujjwnrb@o3vc3ekryfrj>
References: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
 <20250716053254.439698-3-lachlan.hodges@morsemicro.com>
 <d5d5cce69b8300cfe1de7c0b2109403a4735f309.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d5cce69b8300cfe1de7c0b2109403a4735f309.camel@sipsolutions.net>

On Wed, Jul 16, 2025 at 09:55:58AM +0200, Johannes Berg wrote:
> On Wed, 2025-07-16 at 15:32 +1000, Lachlan Hodges wrote:
> > 
> > +++ b/include/net/mac80211.h
> > @@ -365,6 +365,7 @@ struct ieee80211_vif_chanctx_switch {
> >   * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
> >   * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
> >   * @BSS_CHANGED_TPE: transmit power envelope changed
> > + * @BSS_CHANGED_S1G_SHORT_BEACON: S1G short beacon changed
> >   */
> >  enum ieee80211_bss_change {
> >  	BSS_CHANGED_ASSOC		= 1<<0,
> > @@ -402,6 +403,7 @@ enum ieee80211_bss_change {
> >  	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
> >  	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
> >  	BSS_CHANGED_TPE			= BIT_ULL(35),
> > +	BSS_CHANGED_S1G_SHORT_BEACON	= BIT_ULL(36),
> 
> I feel like at the moment the driver has no way of using this, is it
> even needed? It's (currently) designed to really only work with drivers
> that pull each individual beacon, since you have no "get short beacon
> template" and such.
> 

This is correct and an oversight on my part. Looking at our driver we
retrieve the beacon each time, so theres no reason to be notified for
a short beacon update. Will fix this.

> > + * @s1g_short_beaconing: determines if short beaconing is enabled for an S1G
> > + *	BSS.
> > + * @s1g_long_beacon_period: number of beacon intervals between each long
> > + *	beacon transmission.
> >   */
> >  struct ieee80211_bss_conf {
> >  	struct ieee80211_vif *vif;
> > @@ -857,6 +863,9 @@ struct ieee80211_bss_conf {
> >  
> >  	u8 bss_param_ch_cnt;
> >  	u8 bss_param_ch_cnt_link_id;
> > +
> > +	bool s1g_short_beaconing;
> > +	u8 s1g_long_beacon_period;
> >  };
> 
> Given that, should these even be visible to the driver?
> 
> And is s1g_short_beaconing needed at all, I don't see it ever being
> read? Almost feels like it shouldn't - could get out of date vs. the
> link->u.ap.s1g_short_beacon pointer, which internally indicates the
> same.
> 

An interface can't be modified such that we can disable short beaconing
without tearing it down. This is how I've reworked the initial
configuration within the first 2 patches. As for whether it needs to be
exposed to the driver, it does not. I kept it included as I find it
easier to read then validaing against the link->u.ap.s1g_short_beacon
pointer though I have no opposition to doing what you suggest (though
maybe in an struct not exposed to the driver). I suppose since this is
only checked twice (once here, and once when we check if we need to return
a short beacon SKB) we can just check the link->u.ap.s1g_short_beacon.

> 
> > +static int
> > +ieee80211_set_s1g_short_beacon(struct ieee80211_sub_if_data *sdata,
> > +			       struct cfg80211_s1g_short_beacon *params,
> > +			       struct ieee80211_link_data *link,
> > +			       struct ieee80211_bss_conf *link_conf,
> > +			       u64 *changed)
> > +{
> > +	struct s1g_short_beacon_data *new, *old;
> > +	int new_head_len, new_tail_len, size;
> > +
> > +	if (!params->update)
> > +		return 0;
> > +
> > +	old = sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
> > +	if (!params->short_head && !old)
> > +		return -EINVAL;
> 
> Not sure I understand this logic. If there's no update, it returns
> anyway.
> 
> This should probably be on the cfg80211 patch, but now that I'm writing
> here ... If there is no new short beacon update cannot currently be set
> to true, I think? And also, right now by the policy you can't set the
> long_beacon_interval == 1 from userspace, but what if you actively want
> to _remove_ the short beacon entirely?
> 

I initially did think so that this should be in a cfg80211 targetted
patch but since cfg.c since within mac80211 I did such. Can do either.

> Maybe that's not legal? Or maybe it should be allowed, and then I think
> the easiest way of achieving it would be to allow the long beacon
> interval to be set to 1, which effectively removes the short beacon?
> 
> Either way - I'm not sure I follow the "!new && !old" part here since
> you can't actually have params->update && !params->head right now? And
> even if you could, I'm not sure what the old matters.
> 

So you are correct, It's not legal to disable short beaconing without
tearing the interface down (as mentioned above). Thats why within
ieee80211_change_beacon() we check if we are short beaconing first
and if theres an update proceed with said update. This function should
really just be setting the new pointers and discarding the old pointers
if they exist i.e during an update. 

> > +	new_head_len = params->short_head ? params->short_head_len :
> > +					    old->short_head_len;
> > +	new_tail_len = (params->short_tail || !old) ? params->short_tail_len :
> > +						      old->short_tail_len;
> 
> This seems similarly odd to me, if you set a new short head but no short
> tail you surely don't want to reuse the old short tail?
> 
> Seems to me really this should never use "old" at all, since you want to
> update everything (or even remove the short beacon if that's allowed per
> above), but never mix things?
> 
> And if update is false nothing ever happens here anyway.
>

Yea.. this seems to be a case of me stealing the beacon change code...
:). We essentially just want to be setting the new pointers, freeing
the old and that is it. A quick rewrite to something like this:

static int
ieee80211_set_s1g_short_beacon(struct ieee80211_sub_if_data *sdata,
			       struct cfg80211_s1g_short_beacon *params,
			       struct ieee80211_link_data *link)
{
	struct s1g_short_beacon_data *new;
	struct s1g_short_beacon_data *old =
		sdata_dereference(link->u.ap.s1g_short_beacon, sdata);
	size_t new_len =
		sizeof(*new) + params->short_head_len + params->short_tail_len;

	if (!params->update)
		return 0;

	if (!params->short_head)
		return -EINVAL;

	new = kzalloc(new_len, GFP_KERNEL);
	if (!new)
		return -ENOMEM;

	/* Memory layout: | struct | head | tail | */
	new->short_head = ((u8 *)new) + sizeof(*new);
	new->short_head_len = params->short_head_len;
	memcpy(new->short_head, params->short_head, params->short_head_len);

	if (params->short_tail) {
		new->short_tail = new->short_head + params->short_head_len;
		new->short_tail_len = params->short_tail_len;
		memcpy(new->short_tail, params->short_tail,
		       params->short_tail_len);
	}

	rcu_assign_pointer(link->u.ap.s1g_short_beacon, new);

	if (old)
		kfree_rcu(old, rcu_head);

	return 0;
}

seems more robust, where we simply update the new beacon given
the parameters and discard the old, else if theres no update
we do nothing.

lachlan

