Return-Path: <linux-wireless+bounces-35231-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPA+NLgn6WljVAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35231-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 21:55:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1F44A527
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7835A301E593
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4353F166F;
	Wed, 22 Apr 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A4J09eGF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2435959
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887661; cv=none; b=TfDSS2Z9bbJIvbZ6ZHpiFsNNxL7q6kYM7N++/IiE0PWvbJ9dKfAcbZgt2/AOp3QQkxMriJGPMAkhX5D1orjI2q+Nb5VAgVWcf0ZsD1WsxNHlUrPMZKOm6t+KcHrtg8L94mVTafjuS/OIuH9Lvx0a1uQCxIGHDJfFqT/fB0hCjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887661; c=relaxed/simple;
	bh=e5IZu42mb7nV0X3l1RkdEY/DI3U71KqYU4Q6BEfv5m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwE3l8kRhy9lXY+W9qsXoXmUdABHbmaTgQuOQCnbAmo0SMEFWeX7KJ9HTV1nm3D6eOibrNnJ638lRI5Vchf78My/8sivzJRJ5Kc8ADFh14iQvO5cGpl4HhYLyC5ut4gbfB+NcIlj4mTFzoyOMgBIFCINcUng6py/EaXcVZ0PSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A4J09eGF; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7771370eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776887659; x=1777492459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cMyiwH+fmvU5XTrh+FUXRhUtV8/4w1QLlRxNETTXXI=;
        b=A4J09eGFAqnz63ABNAiXa7NKyzwcjsH2r+ipRJHU4VIt8FjRnwE++bFPyqTf4M3am/
         14xZKX8Nd9vtQHmlD/rnt9HUtLriTU3jbjthr2OItt6hpeXUTmbsXFRWhwj4wDfIRO+z
         SCvpdug1hx5QjpKgyZTnd9v75jGSOS7oJ+4HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776887659; x=1777492459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cMyiwH+fmvU5XTrh+FUXRhUtV8/4w1QLlRxNETTXXI=;
        b=NXYd7NlS7oGY9mT24fHbICPx3mIKEKCyzOngDUuATaGwfNLea8gFRTTQd5LeYFIVV6
         vkjWsti8MYu6a0LBr+e85kRM6xR3hztw4KHHoMeFHCbuZ87WoBBO6eyyDdAxs4mbutvt
         SjZ2++zo6kmpbcd9u1/CGd26Na5XZwwQv08Y0dQollyjyM/T6dtXJTc5Rdejr83uXAYZ
         kTN1+HGMvPFkyj1rgYSYTILpyjLF5CXlZtvr2jF1B272eijEjjIsOr3HksK+9rATH0NH
         xX6NbT7qn4h/u0jJvBwxGgfrbQGz5M1q9yb3m2AEmjPxc8Qq0LTjMCBESXS/AOc54Y2t
         jmcg==
X-Forwarded-Encrypted: i=1; AFNElJ/dSiFg53fk26+FaLP//iYsFVfpHQcklFWYnG9ibiKmsxjO8mUfh9xDjTbuoYnNAQeBekqfm8hvsg3Z7Wo2Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91z9wjrZGL6E7kMwtS68o1PnhALPhFOiaT5khNF955vMb2BBM
	QxDudpAyuHgUfFrzdGVeKCTam2StshqsaJGLZeRuMWo+UsLIi86YHyzDWvxbvBUI8A==
X-Gm-Gg: AeBDiesa5/SBs8kGVTrOATPbAMNvZgZ6gQF3RNvspZbZCuyWWdbpijkm/xrYy0xfkKB
	IkQPyvK10B/exgndRvgLpOPNuaf5FToAdH5t4xMniAiliqj6vxT8m+D0PP5vW+5W9bUgbZyOECZ
	H9DPH4BU4lPo28VGciPp24TI2Tj/W2Yk29d//V7chVdwqzvqUrWv9ppZsEjrxSIWdjR3tOL/ox+
	bs3W4fCnHfo41hXt5ZvjmruiIEzDpNxqYU/0Rp62x70RMljtf1f9Iab7nU5HCDRMkBzmACSks/D
	c/a5qCgFZ7cDB00mR2p1o5Vuz31iqklMmD8fJI2R7bCLN9bzjIWXUB64AKEbKYcKjiSCMy/IWSU
	foG7wVaJZNvuK/jJNQAYfU55CpPJHE3iPwBCttpcbuZTPjvplrHcsBrmcqLkdwqmDC3i4Rs8o/p
	QifXxmp8u8Gus7rkeUX0FEDY0wP9Bj82i0sjknpZGBY4jmrUaDuNqRU83sWYtA++4RwpOJKivH
X-Received: by 2002:a05:693c:2b04:b0:2d8:8c38:8cec with SMTP id 5a478bee46e88-2e464eaa23emr12092785eec.2.1776887659239;
        Wed, 22 Apr 2026 12:54:19 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:e136:eb5d:6ed2:47d5])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e53d8aed43sm24463386eec.26.2026.04.22.12.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:54:18 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:54:16 -0700
From: Brian Norris <briannorris@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tristan Madani <tristmd@gmail.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 3/6] wifi: mwifiex: fix OOB read from firmware
 sta_count in station list response
Message-ID: <aeknaNDFrmtuTQP1@google.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
 <20260421134938.331334-4-tristmd@gmail.com>
 <aekS72ESOUlnqGIo@google.com>
 <2e20cb23d2d156963c2b687c4c51635e5eec2c7c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e20cb23d2d156963c2b687c4c51635e5eec2c7c.camel@sipsolutions.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35231-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,talencesecurity.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 26C1F44A527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 09:12:11PM +0200, Johannes Berg wrote:
> On Wed, 2026-04-22 at 11:26 -0700, Brian Norris wrote:
> > 
> > > +	u16 resp_size = le16_to_cpu(resp->size);
> > > +	u16 count = le16_to_cpu(sta_list->sta_count);
> > > +	u16 max_count;
> > >  
> > > -	for (i = 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
> > > +	if (resp_size < sizeof(*resp) - sizeof(resp->params) + sizeof(*sta_list))
> > > +		return -EINVAL;
> > > +	max_count = (resp_size - sizeof(*resp) + sizeof(resp->params) -
> > > +		     sizeof(*sta_list)) / sizeof(*sta_info);
> > 
> > The repeated arithmetic is a bit weird, but I'm not sure if it'd
> > actually be better to stash it in its own variable. Seems good enough I
> > suppose.
> 
> I think it might be simpler if instead trying to limit:
> 
> > > +	count = min(count, max_count);
> 
> it'd just check the needed length based on the given count, and reject
> anything above that?

That might be better.

> Also, the whole sizeof(*resp) - sizeof(resp->params) etc. shouldn't be
> there, that should just be
> 
> 	offsetofend(resp, sta_list.tlv)

TIL. I don't recall seeing that macro before. Or at least, I didn't know
it well enough to recommend it.

> and then suddenly it becomes _way_ simpler:
> 
> 	if (resp_size < offsetofend(resp, sta_list.tlv))
> 		return -EINVAL;
> 	if (resp_size < offsetofend(resp, sta_list.tlv) +
> 			sizeof(*sta_info) * le16_to_cpu(sta_.list->sta_count))
> 		return -EINVAL;

Looks good to me.

> But regardless, I question the sanity of checking the size against the
> size the firmware said the whole thing was going to be, rather than
> checking against the actual buffer size ...

Admittedly, I get lost in this driver sometimes...
...but I think you have a very good point. AFAICT, we never do anything
to check the size of adapter->curr_cmd->resp_skb. We generally assume
it's big enough to fit 'struct host_cmd_ds_command' (since we allocate
it ourselves). But we don't ever go back to check these
dynamically-sized fields don't overflow it.

Brian

