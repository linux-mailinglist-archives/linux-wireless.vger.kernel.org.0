Return-Path: <linux-wireless+bounces-36042-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K4WJzSj+2mvegMAu9opvQ
	(envelope-from <linux-wireless+bounces-36042-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 22:23:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A2E4E0227
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 22:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29A53007F63
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 20:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403043128CA;
	Wed,  6 May 2026 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn84xYbS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82D131E49
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098994; cv=none; b=HRkKdTyKIoguA/iJ4Srqx+L4so5hbtGiAL1w2BBSis31pR8ZqJsI+BNF70SShdOZaPe9OIvAjEz6vAvVfX7sMWLyxl9huIe6da0B+6gSLcdn6QZtvIXEFzceMU6ZsGvO4mal1Dn3rmTwHuSVHae4cZ2cFDx5jJ4u+jjQhmnRlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098994; c=relaxed/simple;
	bh=Siu9sv8+Et6ROYSfq3g/Mzatj+4CNxewMbURJRWAVb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4ffu3H/RxcVq9lav1fhNuQVFsNmxpMl0d3t3+TgQjZz9gZaW80DTpno5Ar+zbrkL6jC2Z+pX944hC/BjxjFYIhpPLVjWrOOdNQmAUu2rjEFzyjBopgAcAaAwCRC2m0SJ6UVyntg0k7CnBMGruQqOijh/mzE+DLE+SVjyUF++ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rn84xYbS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a86c1fe573so16921e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778098991; x=1778703791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/P0Aph1wAQ3XWsOraX0sVIJSBkb9IvsSRZW7RubQb4M=;
        b=rn84xYbSDLNxE47RtnS7y1DmxXZhJHu5slw+tP0bwjsdHpI3FtGqPYgcMuVPTz4C8Z
         5et7SHw2R21vULuoFQUmSCpRignTffqEPbkNrFLtPsdO3ezKHX3e8Yh4LJEwpLwdvmaH
         BDw1izDL47WcXIkCpGOozg4hQbw42VaA3ACNAi7vBG7lRvoTy2jkx/LN/4o+Epsi2JHH
         RD3cQf9gYUa/pgnrohUrC2R9s19lfgX/KRux5HGyYibgUWUTw6Mx9M+IqFV1t2l0sgp/
         Ge4vRze/hDsFt0CshVVpjM60yugwIpUGQvST21/CUdTpCb2tQLcFT92B95GjfxZUVgDD
         IiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778098991; x=1778703791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/P0Aph1wAQ3XWsOraX0sVIJSBkb9IvsSRZW7RubQb4M=;
        b=eZRF+RQnXSJ+jDMV4CdEVCSjdXHd/WATrbVu+ZGpVa9KnNxzw3T8VTMw504LLj+CpR
         2FzU7ENgNH99nhkgwbCK8aGWF+L0OexDJLxCzF+55e7CFASFyT+K/VN7cxip1eCFPih7
         skxftEazCgfkM8YllG9KE7wr3p6REGILKFI2bh9YIdnK141BlI00O/KEJHNuk69ue4Cg
         TG0QB51fcm4M+/7mck/tnOrUMlapdEXfHNWJ1KHDLCLT46c9eWP6FoZYK2hLby9g1fzv
         UW/d2EA5xM3Xc5dPoTfEHYdb9axMXGyytcJp0fNr7Oxu/xw/YWjv6O52DKnXYVejGL7j
         Egsg==
X-Gm-Message-State: AOJu0YxWaHzTKjEUmhbdCPdIjV0Erw40h1MUbPF30k/Hs5GVcjfiAYS1
	MdSYjSzs3HJkjeN+f9mtOHUKTgzVPXPg8Vb7dEGouQ8eRIQwrhloFErn
X-Gm-Gg: AeBDievQK3zyuY7FffgUdhjJLnRLXNzcW3dTj7b/rG6Vzkh4pFeK2dUUNPz96TzYNCP
	X5wyExk8rRrvkI0F11wMVzQTv7u6fbJVbwz7VIR8ufcuobqKrC1ocCGDqE0OziAcHVJJ+ZBib+N
	YY5sfFgO+77wcPJ7bwDDtaRJvV7L4h4dDDmxLIVVa6ek8/EfpYyZWcm/APXbQYrLr2vMSojYUGU
	c1qe3QXDhIptYFVyGJ6Fr2JrIbiMnIYhOJdkg+G/tJavGcC+63UuZPO8cRihn71Dyqlzs3tISBz
	35m8sraqV7nDSrQ4FYzLdCkgSg7zV/2lIPW8CDwsJkC7av4xNaeBRUugLrAyjx3bfs8yUbH6nOB
	tdZvC69pEnSS+mGdgCCBN6e0TzvpEvJnlreJ8jtpFRKKtMM65Qvl1zuKPdRoK/02RGdFLEXqojw
	83ZDnL/khXpbiZm09g9FNmj9jBb3U0w/nbUUF36h1XNkBzlXGq+p2nCaiEtU97e90RZuI9r89Zv
	/Ue5SlLzIMR
X-Received: by 2002:a05:6512:3da8:b0:5a3:eb4b:37a7 with SMTP id 2adb3069b0e04-5a887adcd69mr2337365e87.6.1778098990756;
        Wed, 06 May 2026 13:23:10 -0700 (PDT)
Received: from Thor.home (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi. [2001:99a:a58:9b00:9119:221d:45f0:de83])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a870f96cb1sm3114134e87.22.2026.05.06.13.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:23:10 -0700 (PDT)
Date: Wed, 6 May 2026 23:23:07 +0300
From: Maxin John <maxin.john@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] iw: Makefile: support out-of-tree builds
Message-ID: <afujK_-G8ty4LnBD@Thor.home>
References: <20260429210808.1497335-1-maxin.john@gmail.com>
 <6d1b6079bd0c0318e4311bc41a35fc2169a0b4e8.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1b6079bd0c0318e4311bc41a35fc2169a0b4e8.camel@sipsolutions.net>
X-Rspamd-Queue-Id: F1A2E4E0227
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
	TAGGED_FROM(0.00)[bounces-36042-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Thor.home:mid]

Hi,

On Tue, May 05, 2026 at 12:35:16PM +0200, Johannes Berg wrote:
> On Thu, 2026-04-30 at 00:08 +0300, Maxin John wrote:
> 
> 
> >   - Add support for kernel-style out-of-tree builds using:
> >       make O=<builddir>
> >   - Make SRCDIR computation whitespace-safe by switching to realpath
> >   - Remove ambiguous use of "-I." from CPPFLAGS
> 
> Thanks for fixing that.
> 
> Right now I don't really see _why_ it doesn't work, but it seems
> confusing that if you build in-tree first and then try to build out-of-
> tree, it just says
> 
> 	make[1]: Nothing to be done for 'all'.
> 
> Maybe that should abort? Or work?

Thanks for sharing this observation. Yes, this is not ideal. I will update that
part based on your suggestion.

> It seems that removing VPATH and changing the %.o rule
> 
> -%.o: %.c iw.h nl80211.h nl80211-commands.inc
> +%.o: $(SRCDIR)/%.c $(SRCDIR)/iw.h $(SRCDIR)/nl80211.h nl80211-commands.inc
> 
> makes that work?
> 
> I'll leave it to you though.

I will send a v3 to fix it.
 
> johannes

Best Regards,
Maxin

