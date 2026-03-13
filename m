Return-Path: <linux-wireless+bounces-33202-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCn6Ih7fs2ktcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33202-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 10:55:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2829280F23
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 10:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D12328F308
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3573890FB;
	Fri, 13 Mar 2026 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="AR+T1ciW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFA36E498
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395340; cv=none; b=H7czIjNBs2M/nVEqXA+eiUTfJT/0rQrWmIKPJgT9D8gR2RGU99+WTQrRp9okRYAF7BEreL9egPS1P7Q/BHu+N/JGValsBAfBfC/S/lTakLbLs6DL0DEua/Th861XVoGWKLzXGwhWDqpQ9nFnExMlqNLOru+KbedGVbM+RZqRuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395340; c=relaxed/simple;
	bh=V4nNPy2aFr59x/RR+ByzLxeYdHhrbgCFyiySQ9Cg+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9LxQtm/SO5XWSw6n3xJku4BzfW4WmEwKKS0Ud9sJ8rCXx9kH5C6Gy3rt7n+otBoZJKQBRGpJ7L+bTKmNic+A47h/xwObCkdEZ/y57BMpX9cm4VpJZvH89ZxOFiMJuUOpG2yQ1nF5PMwL5aJ1QmNWVoF0C4013GBmRvc6JH0Cw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=AR+T1ciW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab39b111b9so9071475ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773395337; x=1774000137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gU9H7Bo9roQ+prgGEiA4EB14853/ekv7Z79E0nFUk7o=;
        b=AR+T1ciWYUQLEL50ZmFho4cSrfkGRlp5gjDSKcH8AL9x+Fz67IPgUbcvRAreFMG+nj
         r61zPDaTVrOz4M8yP6IGPEy2Z3v8v6jsgDEBY7AdeyhKFH/GV1vWlsV0NqbEOhxA7yjW
         qQ6sVarh4ByiryQ+9pykWQaB8ZTuTtVgS/xuZ6/7LE/ao0+8TzOexTfBbkpAk+a5OLNU
         dCFU3Lwh5bTqxVUdGqjZ6yGGb74aUbQ0XnTofnSZ7zuQQF0xm2XbXWJIXoYMxxM7alT0
         cX/3E4lq4AzzIApKK2ujxjXmBNFOoJDUFlwXXRGiXvaDNEcgGywE4+PSt6kPgL1itCMQ
         p6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773395337; x=1774000137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gU9H7Bo9roQ+prgGEiA4EB14853/ekv7Z79E0nFUk7o=;
        b=IO/8eHpsOSt8AtZpvFaKoDr017m+TEkTQn3eUY7DvBJhZEhLW3go77/URJn6R0Lk8y
         YAUPNJlHsRla3F4Fw2nXHnqwva2bLzqpUlRUmNZ4YnX81sD0y/NUviPQdCte2ZfoPhRw
         lX+ONwwuWK383uBw+y6UVtrAQ8f8+nN6u0xqOcPnAaTTLcyo8z2tYtqsypGl1Knv9Pvm
         kg1PQq3SVZ2tg1kRAo5vowqHnwGJ2f6Iilu8Z3zx3WbAi9AZHKifAg4wp5v3vPyeaFpT
         7KHJHRllPrf6MPGXsGLlvq2tgsGTCUmqOKY8LOJFVvTM6JJVaJuZMbLNIbRl60ZG8mod
         lcGA==
X-Forwarded-Encrypted: i=1; AJvYcCULZ7W9+MknSBpZnAPCGvwHdhoFQyObm2pLwFPd2LTNe87bgAZx7MqcVfo3pNXj8+Ycfak7WNYZWow4xIQtGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRaTtku4MDdgoidiO87ySBF1rQ3Dml1h/AyIrbnEkUzVGGaVX
	WgeNYISClRyATP6w+VCNEiSP1bee+QvdEzCj7MaEZMFaArBjjYkuFDyU1MDsfmQTChY=
X-Gm-Gg: ATEYQzxgZaSXYsoj6QeuNCWmPQzNAGMEP04YqLrnDwBryrGuli27FbSHWC8W9JFeM9a
	f5WOqTVErQ9BjIf5D7VNmQYaVzz6c9Au6nzbrWZVvPOkOGB8yaCKJcLbaDPFDAaxa8pMleSTO0K
	8iAT/Td528xxpsU15Ek8BXq8cJD6zDywpLmJpMOOCDUrQTHLLIjTkHpaKQ3cR0Yuz4CnzFveVc1
	+cvx36xLzIzg6a4qANkEXJV90zfbmfx0TYvrV8KRuB5J+iBVPD5OEQ9+h/qw0U5l78vt+m/pOkx
	RFR2QL6vpPDe6VOUTWv6M0MK7pc0pyRsckATSY7N3qqgm559DTgnD0Da1mcffziDDw9V/fegytf
	Z8pekN2nAEcom4C7IuNGqH5D3HxMUXT/aJU6XOf0WhJ3oomAQ+ffpKypCtkm7RzcAlrbGQ+IHuc
	oYIaQpXWziFiSj41rQwsP973dibPZu8WCfr2PP9TwpW92UGzR/DyElHtoz3mzmeCJL
X-Received: by 2002:a17:903:ac7:b0:2ae:47f9:de12 with SMTP id d9443c01a7336-2aecac84e7fmr24772455ad.46.1773395337034;
        Fri, 13 Mar 2026 02:48:57 -0700 (PDT)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece845022sm17450755ad.83.2026.03.13.02.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 02:48:56 -0700 (PDT)
Date: Fri, 13 Mar 2026 20:48:52 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: syzbot ci <syzbot+ci0f91523e1d0ef709@syzkaller.appspotmail.com>, 
	arien.judge@morsemicro.com, linux-wireless@vger.kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: misc chandef cleanups
Message-ID: <sezz36jv4edclmbtrcbdwzyb5goxp2tcfneoi56ounzuled42v@o6bajqutzp33>
References: <69b3ce9d.050a0220.12d28.010d.GAE@google.com>
 <855780e1bece0de480b7fd3e1cf67c9f70129818.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855780e1bece0de480b7fd3e1cf67c9f70129818.camel@sipsolutions.net>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33202-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,ci0f91523e1d0ef709];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzbot.org:url]
X-Rspamd-Queue-Id: D2829280F23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:05:15AM +0100, Johannes Berg wrote:
> On Fri, 2026-03-13 at 01:45 -0700, syzbot ci wrote:
> > syzbot ci has tested the following series
> > 
> > [v3] misc chandef cleanups
> > https://lore.kernel.org/all/20260312045804.362974-1-lachlan.hodges@morsemicro.com
> > * [PATCH wireless-next v3 1/3] wifi: mac80211: don't use cfg80211_chandef_create() for default chandef
> > * [PATCH wireless-next v3 2/3] wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based bands
> > * [PATCH wireless-next v3 3/3] wifi: cfg80211: check non-S1G width with S1G chandef
> > 
> > and found the following issue:
> > WARNING in cfg80211_chandef_create
> > 
> > Full report is available here:
> > https://ci.syzbot.org/series/ce6fc7d6-d8d4-4d00-a746-db78cba13e47
> > 
> > ***
> > 
> > WARNING in cfg80211_chandef_create
> 
> D'oh, just after I apply it.

That didn't take long ^.^

> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 3e867930e253..7314312ec567 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -3634,8 +3634,6 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
>  		case NL80211_CHAN_HT20:
>  		case NL80211_CHAN_HT40PLUS:
>  		case NL80211_CHAN_HT40MINUS:
> -			cfg80211_chandef_create(chandef, chandef->chan,
> -						chantype);
>  			/* user input for center_freq is incorrect */
>  			if (attrs[NL80211_ATTR_CENTER_FREQ1] &&
>  			    chandef->center_freq1 != nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ1])) {
> @@ -3652,6 +3650,11 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
>  						    "center frequency 2 can't be used");
>  				return -EINVAL;
>  			}
> +			if (chandef->chan->band == NL80211_BAND_60GHZ ||
> +			    chandef->chan->band == NL80211_BAND_S1GHZ)
> +				return -EINVAL;
> +			cfg80211_chandef_create(chandef, chandef->chan,
> +						chantype);
>  			break;
>  		default:
>  			NL_SET_ERR_MSG_ATTR(extack,
> 
> 
> I think?

I'm probably misunderstanding - but cfg80211_chandef_create() modifies
chandef->center_freq1 if you have a HT40+/- chantype wouldn't you
wanna do that before you validate against the CENTER_FREQ1 attribute?
Since in the generic init code above it sets cf1 to the control freq?

[...]
chandef->center_freq1 = KHZ_TO_MHZ(control_freq);
[...]

where it wouldn't match for HT40-/+ since im guessing the CF1 sent
down should be what it would be _after_ being set by
cfg80211_create_chandef() based on the chantype? Or am i missing
something?

lachlan

