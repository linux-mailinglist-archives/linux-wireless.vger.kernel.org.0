Return-Path: <linux-wireless+bounces-35507-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPwOEr7r8GmBbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35507-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:17:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98340489C32
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4693304149D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8C33F377;
	Tue, 28 Apr 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJDDRvoT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49A125AA
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396335; cv=none; b=A5paKhhBrvVP3+CRBgLgA955gzB4iNDQVsJcnjgXev+1gOXl09hqaNNwch7I/dG7aO6nRbgmIctkcRtTEa9f7Gk05Q4VLyAnhR/8S8qNItWafQ5bSsvVTzx/KqnOviVbJZwWFxyX7RcVuPIsTwWtw+R87gsU+KDFWo7RsXj2Kqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396335; c=relaxed/simple;
	bh=31OmypALgw6Aq6kNGR9mt8YsQuZjcj+PgdNPgtmbOX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG5E+5r1qSFoo2As61m75YruBgTv131dhygrM1ykZix6YMKe1jL0gP1Z2dghnjVv3pOIbF7zqPTicrwOqv3oLS9IsFWC+yOkZ+cOBmSk5afNcPWYgnaocAZuPSqU2GEScCPmcuvrRJkOE/9WzTBnHiNQ0HFAgO7I9JEwCWkVxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJDDRvoT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e936caafeso119729571fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396332; x=1778001132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPcsAOQUvm2NFAOixpYW914de8cadeaU2Eu3SiUW0yA=;
        b=kJDDRvoTYfF+vWyZu5U6Zq/tLwm5enQa1I9UQaH/bboZDlXgdpvUy9+OzHl66cIRTT
         viz4eDxuiOFzYLuDL1MiW0pOG949Oi6A8Sg3AcWr+c3+e75viNkUEP2M/9nCOUfU4n/j
         bPDyHMBouJqz5QnlunDXbLTUe0Ox/1zIr7C0ZJUYybDAt8V9a3OFtsIGVSVyemMnDoEL
         QnoNU7SanjB/Nacfa0w3rn6VDwXpZGbJzOMjjAyuXQyxJCJbzuJfUqFXlGuE27NAR6V/
         hD3tY9v3VgCBYqR0mZzBjlnbS7MEjX+/mPd7lf1whdCSR/LrKvH6mqcm/y7YMkO3cHYx
         ERzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396332; x=1778001132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPcsAOQUvm2NFAOixpYW914de8cadeaU2Eu3SiUW0yA=;
        b=EJktfeZL/MLE/624AxRtEZN+5nquX0ANCgeMU8BDpXboxRTFlqQ6MfoAEq7jllRBas
         asH2Ufu4C9XuKzXQv8m8LFby7Db83R6mf8my/VTSMvnDzG0d2C4NwTYRWyWuG1Yf9L85
         WScXwiHs+8MSy+FOj7iVpsjQtSwjzu9W5gZZUHmtRUhgvr/p4xX8U6aszw8+AaPppaZh
         hL2fFkwb0FOsB5lQO0x8WgmdMpb+4Q+yye66tXXTCG7swDeLNjzD5DbFd7n7MR/H9u64
         jtI3qQ3ru8K22w3Rjci/zIj8JMaWswAD4gW37sccQCSsCw6Os6UT2oHK0K/e7c4JnbmN
         EDEg==
X-Gm-Message-State: AOJu0YyNzocyjtdJBNBx5xLEJ4SJljSa8n70l6VmhL9PQo+OfKDWZLPa
	sC2JmeSYiMxBHOF56USXBbI3lBTw7h0U8nZMkifY2F+nAm87DvVhsnILFK3iNg==
X-Gm-Gg: AeBDietpNtf3KUYbT5AKoMdgYT84Nuk8tWntXkmvICyG5uVMM7Ii261qY9zDERpe4ix
	2CruJdVMR4pMpmmVXbYFI2FBJmvLjiQPf+9ARk5TTxaJllkLjXynoqsNPh8DpYMrRcEVdN4NZKF
	mATxWdF2k+GLs7kB4FSy1vg4y0jnF7eBvE21sJ9RGyCf/P+xciDa23kUPc/NVgFcSiUmdIl7dBr
	j6LE++KAFbe5HSlRDas+NVUyt28wtQuICc8uhTz0OZa1Gl6n0c1o1R5Jls4sXsXY1gK4hHuEcZn
	bgDbyJ2hCC+I3bwhH5MhBNVqk64aX8sFvE3AHJY5jpDxrI04UvZ3xh4jD+gOgvIF1SRrgi0MXdy
	EFqnSA+aeeAPNvSnbOI6QNsmsjVqsGBaoSCv/p/hUGNWuKC4ZvCeRq8AbJ7NjxLDLRub+tN+trO
	WWuEnb04EjtxeSthSr6x7xkAtK3KUTh3T5I0nDxPELzWzc8d+GVoCE4or1IvaWzkYBd0TvmLUUp
	c+aF0XStGd4
X-Received: by 2002:a05:6512:118c:b0:5a4:6a5:9900 with SMTP id 2adb3069b0e04-5a74662a687mr1854102e87.34.1777396331610;
        Tue, 28 Apr 2026 10:12:11 -0700 (PDT)
Received: from Thor.home (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi. [2001:99a:a58:9b00:9119:221d:45f0:de83])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a746408102sm752262e87.70.2026.04.28.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:12:11 -0700 (PDT)
Date: Tue, 28 Apr 2026 20:12:09 +0300
From: Maxin John <maxin.john@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iw: Makefile: support out-of-tree builds
Message-ID: <afDqaQc-Vxoz3OEL@Thor.home>
References: <20260423113154.1070521-1-maxin.john@gmail.com>
 <1672e78507b643f4610265f018ccddcb141ee726.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1672e78507b643f4610265f018ccddcb141ee726.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 98340489C32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35507-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxinjohn@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Johannes,

Thanks for the review comments.

On Mon, Apr 27, 2026 at 11:43:54AM +0200, Johannes Berg wrote:
> On Thu, 2026-04-23 at 14:31 +0300, Maxin John wrote:
> > Enable out-of-tree builds without modifying the source tree.
> > Out-of-tree builds are required by build frameworks such as OpenEmbedded.
> 
> You should probably say how this is intended to be used, clearly not in
> the O= way that the kernel has, for example.

I will clarify the intended usage in the next iteration.  

> > +SRCDIR := $(dir $(lastword $(MAKEFILE_LIST)))
> 
> That doesn't work if there's whitespace anywhere along the path.
> 
> > +CPPFLAGS += -I$(SRCDIR)
> > +CPPFLAGS += -I.
> 
> The "-I." seems questionable since you evidently intend to have "."
> *not* be the source dir?

The -I. was intended to ensure that generated files such as
nl80211-commands.inc, which are produced in the build directory,
 remain discoverable by the compiler. Agree that it doesn't look right
and I will update it. 

> 
> Overall it might be simpler to actually do it with the kernel-style O=
> so you just need to change all the outputs, rather than all the inputs?

Got it. I will update it as per your comments and send a v2.

> 
> johannes

Best Regards,
Maxin

