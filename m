Return-Path: <linux-wireless+bounces-33058-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIXuNL1dsmkZMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33058-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:31:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751CA26DC63
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D20E304788D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430737CD34;
	Thu, 12 Mar 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goM+nwed"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6B2550AF
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297018; cv=none; b=TRplitNfhFWaZE0+NrgP0o9d2cpgiTeSlU5cfQaBmWGxv383tVFYipOcuz22F/HYIJ6QbzyuON3nK6xEwrFAS7URjD2JsY0QtKaX/dRPJ2K4iIBA0LpQ7v1IC7X5NBqPtKinH8N3ta2kavCCZ6b4MWV5QkZxYRTJQcQWkMsspvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297018; c=relaxed/simple;
	bh=Gke2pLzQAgmdS7PYe/SUyBC8YFMlx/zEgfsW7rM/rIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1QEHxIqJ0foY/rQoHYRNHnYZRAw/BWR3UJ7b28p+uCrVuTpZ+tbL6aTYOKTkec4bWcbFZvHwF796CDf9pMIubb3yBdTjf5fCESeKvKOumIgViOKQITiahMVFEsqvPWaANf5hiYZQoWJTZ5EmbNV7zN0NFoXmGS6ItH3yAvUmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goM+nwed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE29C2BCB1
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773297018;
	bh=Gke2pLzQAgmdS7PYe/SUyBC8YFMlx/zEgfsW7rM/rIM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=goM+nwed851e+KZUKUT51HHknPL8cro6TWQNe3hOJr52iZS1BbNXjOgAfUWik41aM
	 DfTcWu9KFjAYRmtF+ZIW8BJ/qlwJiAJfNLVutsgI3viKZSagTvnHByuRYslayBucl6
	 ONUMo6R95mO732t2m+wDzCaaLkWSm5wJvIB/hgrPNJ/lXKFlmqppgXOV6mBWET69SQ
	 f2HZvaA5/AQlZC3/5ROhLW2ldmXTg5wXWRYxMMK1czvXoRatP1pmyUpzWwP/D5yW26
	 owE9VJbc65SSZ8UQc8wdX0k1iDm3qVtHbsOc0bi/7jdUNrKrQxum+QNU1WpZ+kwmZl
	 jAbAZuqJNnSMg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so2736051fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:30:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhUrECW/7fL8Utag2itb8CoxF2yuey9/9y4OjyIYFiivUvfEtTP5D7tCPDUF5JlUnH+Kpo+9IZstKt/ApkmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlapAvN3zG83KBaQBrZ2/iYpJm6xMo8XQqWOYQticp3AiLPT7O
	paEfa3oSTBWTeUtT4tyTd9YgcEhNQffA30LyK8tb4jSURNdIfq5A9UhXn9dratUN1cxhjGLdbKq
	WdGsv46UZJho7yJ+df/t6RNQzVz2Grto=
X-Received: by 2002:a2e:a104:0:b0:386:fc3d:e42e with SMTP id
 38308e7fff4ca-38a67e89b29mr16094491fa.41.1773297016643; Wed, 11 Mar 2026
 23:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311085141.1634383-1-wens@kernel.org> <CAHrRpunHZhCfBwueaXQS46SA5JzAbbW5DVL2MF+m2tKvKyMZAQ@mail.gmail.com>
In-Reply-To: <CAHrRpunHZhCfBwueaXQS46SA5JzAbbW5DVL2MF+m2tKvKyMZAQ@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 12 Mar 2026 14:30:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v67+CMC=6Hvn50RRzHxa1Syi+gj4WOpE3LJhNyrxxe5Hrw@mail.gmail.com>
X-Gm-Features: AaiRm5370bYNn4wAy9VxsmXrELY1dZ-bGs99v7aLi-FwcBnGOr3XDgIw5HqyiAg
Message-ID: <CAGb2v67+CMC=6Hvn50RRzHxa1Syi+gj4WOpE3LJhNyrxxe5Hrw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for India (IN) on 6GHz
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: druth@google.com, Ping-Ke Shih <pkshih@realtek.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Gaurav Kansal <gaurav.kansal@nic.gov.in>, 
	Degrader Snehil <degradersnehil@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,realtek.com,lists.infradead.org,vger.kernel.org,sipsolutions.net,nic.gov.in,gmail.com];
	TAGGED_FROM(0.00)[bounces-33058-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cra.ir:url,mail.gmail.com:mid,nic.gov.in:email,realtek.com:email,dot.gov.in:url]
X-Rspamd-Queue-Id: 751CA26DC63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 2:17=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > The Government of India has officially opened this band for licence-exe=
mpt
> > use via Gazette Notification G.S.R. 47(E), dated January 20, 2026,
> > published January 21, 2026, issued by the Ministry of Communications
> > under the Indian Telegraph Act, 1885 and the Indian Wireless Telegraphy
> > Act, 1933.
> >
> > Gazette details:
> >   Title   : Use of Low Power and Very Low Power Wireless Access System
> >             including Radio Local Area Network in Lower 6 GHz Band
> >             (Exemption from Licensing Requirement) Rules, 2026
> >   File No : 24-04/2025-UBB
> >   Gazette : No. 47, CG-DL-E-21012026-269488
> >   Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communicat=
ions
> >   URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f690=
7934d17d0015ab5.pdf
> >
> > The Gazette defines two device classes for 5925=E2=80=936425 MHz:
> >
> >   1. Low power indoor
> >      - Max EIRP         : 30 dBm
> >      - Max PSD          : 11 dBm/MHz
> >      - Max bandwidth    : 320 MHz
> >      - Restriction      : Indoor use only (Rule 5)
> >
> >   2. Very low power outdoor
> >      - Max EIRP         : 14 dBm
> >      - Max PSD          : 1 dBm/MHz
> >      - Max bandwidth    : 320 MHz
> >      - Restriction      : None
> >
> > Additional operational restrictions per Rule 5 of the Gazette:
> >   - Band is prohibited on oil platforms
> >   - Indoor use prohibited on land vehicles, boats and aircraft below 10=
,000 ft
> >   - Communication with and control of drones/UAS is prohibited
> >   - Contention-based protocol is mandatory for all devices (Rule 4)
> >
> > Out-of-band emission limit: -27 dBm/MHz outside 5925=E2=80=936425 MHz (=
Rule 6)
> >
> > For now, add a rule for 6 GHz LPI. As the database does not support PSD
> > information, the EIRP needs to be limited so that transmissions over a
> > 20 MHz channel does not exceed the PSD requirements. This limits the
> > max EIRP to just 24 dBm.
> >
> > Reported-by: Gaurav Kansal <gaurav.kansal@nic.gov.in>
> > Reported-by: Degrader Snehil <degradersnehil@gmail.com>
> > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
>
> Listed regulation in this patch matches official URL page (translated
> by Google translation).

The PDF actually has an English part which is nice.

> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
>
> > ---
> >  db.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/db.txt b/db.txt
> > index e2842db..d54ef78 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -985,6 +985,7 @@ country IN:
> >         (5250 - 5350 @ 80), (24), DFS
> >         (5470 - 5725 @ 160), (24), DFS
> >         (5725 - 5875 @ 80), (30)
> > +       (5925 - 6425 @ 320), (24), NO-OUTDOOR
> >
> >  # Source:
> >  # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-=
968f-0050569b0899
> > --
> > 2.47.3
> >
> >

