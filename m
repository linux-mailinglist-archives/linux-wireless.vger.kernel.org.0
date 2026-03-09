Return-Path: <linux-wireless+bounces-32762-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIngDb6Srml0GQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32762-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 10:28:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F93B23627D
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794023085C21
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC073783CA;
	Mon,  9 Mar 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="y5SspIY5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58473793AD
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048198; cv=none; b=YgznHXK14r+7REAA7lQ19HlczxRr+kJjCQXbbbnbFTQdA+UVg3xEKBggJtWB8f6aaDIhVJR2jn6gjJYe+kfbQyOtiYhZicMYO1GbD+o2Gdio9baN9WtOTfhIdiMcIZEhJRUjsuUbbn4G5SDPVvDmOkFzjp8+bR//OZWMpjoyk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048198; c=relaxed/simple;
	bh=a0y+m2PQMY6z3eSgh5i0Kmn9GORKQJPH2373Q3cX7zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6MJr/4c/KJ1dmeWOwLSyrbZhmNrwNqn6caq/EcE2/fIYiz+duDKiaJBnOkjorrhnq7LA8qfZ71AYlFEfWu03+j+lPTULqbRMgkjGA2C3zfmbo1qOG0J5i19+wY9kY4M29yKF822rAGdaTl8OWjCTNQaNiM43v9Bu7OxCv4kxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=y5SspIY5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829a568f3ccso1352785b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773048196; x=1773652996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXD783f8Pez/jH334gFdEZHgloHuUzIAsg4mMahznz4=;
        b=y5SspIY5DWwta4QTkMf57XJHp4biTNX8Lp9pshV5JfIsBHA+nm00Zuy1XIg1PcP4qk
         iYloF9JTpqQL6kbD5HDTcBcTabWfXPBLmAznyvEwToSFd/S7nm1DF8ew7qOUwIzay6WJ
         WSNVotdHIXftY0bXAIall5xPPvvrTXTY0SrSERsCvHcV+B/kBs22jQI5g2tuSt9WgKCP
         wxbJ4IbQ4TAQK+12giOvL9njmLByxaGcvtRBnhW97b5DijYVSAieh67lD8tTq2H/mXVe
         kxwtKuottOv6raeXBMByGgqIb7degoAMlmsj2NtftTGj364Z974iBgTy/lSMCtI8rJoi
         hxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048196; x=1773652996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXD783f8Pez/jH334gFdEZHgloHuUzIAsg4mMahznz4=;
        b=F2LqwmhySbngen4uMrmmDpj0OZxJspnB/Eoxgu2v6l8pSKbApOQy4c5fi056ovUlqT
         241KjmRXADOENKdfXoZTU7uQVJ/PnWkTVX5eNEqX059NDzPHAW3cO14j6flHkqU6Fwi3
         VAJ+JbeB3vZqTYfmpddmJ9Rhva4B9tFZvIWKcgZ/Fd70+u+EBqiHu+0vI0bmuwJ/FUEX
         PDmujNmSgZwdsjQKtK/X7DjRc84mFAVT1OaxNTVBSO8/zfG0lhuq/46U9uwHQeI9X37P
         diIm1nwfjcdBYy1gGXjq5y+3jNcHG3/WfVmN+mSW9vZlMSycI0CxIohh/BHwJIy8btva
         QDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJI2GCLrNYegqkdOE0hqu1oGKDGcLKdN6NWc/HKQasM+Z9ulmMYxSeyAIyMP6b93R8GebXKRT9yc2sGXiHUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEQk2C1NRsLQkdUewx0yNTxakyi72Jw4S2HaxfPxYSwID/pmc
	NtHcFHuUIh5uFXasyBmVd8uehqeRYzuzGhfPkr4+BcQrZnCBsV05IbSKG9uxJAcrSOM=
X-Gm-Gg: ATEYQzzIGlRM8S9EWXyNAZGYiSZQXLzF18X9cfMQQgR839GUapWCV6bRMXysQKkOHDA
	HizLg32iFv+qXRfeCorL4MByfBk20yCk22Z3pthoNTLZjdXaBwK4P6KnjcoW5VdtS3hL/kQPQPr
	2I3VuhzDhF5UN5mRNFMEZBbf3ZLwb7M8D7lHjIpYS3cJYiH5ucPAu7E0lTGbMSJ0zH7NRJYD8kq
	K0jL9rvgGPDEGRpIEnlobPgozR+EAkdGVGY9E8JsbY28NHbfM05y8jA94zqNCaLDj2Fqmb+9D8P
	P96YgQVohC2aqxNMIqJZKMPx592K5oJLfYdDUD2m1y5lu9flhKakR58GLz4Opv0rvp87KBkGaH+
	jQI1QVOSWMZdicRYHe9GvP0DtkVA1F70QIM+tQS5T9GQ418GW1eIYTFqbG05IIlF3i1w9uf56RB
	UwoV+SpvnpjEkl2lUuLRYHA9nZP/SHVtyU8FYdP3IMGqNE1FbaMXwKgnaJtcq2efkD
X-Received: by 2002:a05:6a00:1815:b0:821:8492:7f66 with SMTP id d2e1a72fcca58-829a2ded871mr9181948b3a.22.1773048196282;
        Mon, 09 Mar 2026 02:23:16 -0700 (PDT)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a249bsm9732419b3a.44.2026.03.09.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:23:15 -0700 (PDT)
Date: Mon, 9 Mar 2026 20:23:12 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, 
	Arien Judge <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
Message-ID: <zcuk2lw4crrx77pel7rjzy6g4dae77psra3sfiytto4ap3b2nt@io3xv6gob7dz>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
 <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
 <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj>
 <1ca86ec4a1af1edfb791ca65023ab1979507c5bc.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca86ec4a1af1edfb791ca65023ab1979507c5bc.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 8F93B23627D
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32762-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 08:08:53AM +0100, Johannes Berg wrote:
> On Mon, 2026-03-09 at 15:43 +1100, Lachlan Hodges wrote:
> > >  2) Are you going to incur the wrath of mm/ folks, where instances of
> > >     'struct mm_struct' are commonly called 'mm'? I can find a few
> > >     examples of others (struct drm_buddy *mm, struct mqd_manager *mm),
> > >     but you'd double the instances.
> > 
> > This.. is definitely something I did not think of. I have no issue with
> > renaming to something else.. maybe mx? I'm not sure.
> 
> Yeah I really don't know. There's no 'mm->lock' (any more? for some
> reason _that_ was what caught my eye wrt. the naming) in mm/, and I
> guess soon also not in your driver. I'll try to ask around, but it's
> probably safer to rename, and shouldn't be _that_ hard with spatch I
> guess. I guess 'mx' seems reasonable, 'mmx' is also confusing perhaps,
> and 'mm81x' doesn't lend itself to obvious other abbreviations.

Thanks. Although not a huge deal at all of course. I just copied
what atheros does with ar :-) so mx seems good enough.

> > can we confirm that this means
> > we are to submit subsequent patchset revisions in the same per-file
> > format until everyone is happy with the driver, and then raise the PR?
> 
> I wouldn't necessarily way _everyone_, you can probably always find
> someone willing to nitpick if you look hard enough ;-)

:)

> Obviously I hope/expect you're going to continue to maintaining the
> driver and we'll have to figure out the workflow for that

That's the goal of course. As for future work, right now both the
kernel support + this driver is about as barebones as you get so we
intend to continue expanding that. It felt best to push the driver
now as the bare minimum such that people can start using the upstream
S1G work. We have a lot more to do.

> perhaps depending on how much work you're planning to put 
> into it.

We expect to see some larger features - including monitor mode, and
mesh in the near to mid-term future within the driver itself, but the
core development will still remain in mac80211 & cfg80211 as we
extend the S1G implementation. As for workflows, we are still figuring
that out for ourselves.

lachlan

