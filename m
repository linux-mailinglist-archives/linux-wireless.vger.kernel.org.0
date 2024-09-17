Return-Path: <linux-wireless+bounces-12909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7A97AD7E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBC1C2110C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452915C138;
	Tue, 17 Sep 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Za0DVAOP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8415748F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563814; cv=none; b=q2STmtvy7bfvkAij+tqY+y4jCjJCJQXbR+WZE8h3jDyaPMHLZODw6tujYelQD4kqLFiVfSPrevaFWhRhME3lQaBr54rhRrXvakQb+BTikDztfPz8QXsy72H9N4l4POTQ4x1lupxspWQAKZlmsJf5FoG/BV+uaT0C7ORWg6LON24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563814; c=relaxed/simple;
	bh=gDb6is9h3aygCvo98TjzWRCzIca3atfYq0oXyXuGF/4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzdNJ/sxow12oAm4pi9sCXar1pYGIj/QjYhcMDlK1jsVkjx3xoMN42gg5BA5Jvo0TXxARP1hyoRrxFY3LlbabMMPXxY6mhJEtjAIrWmppm2u6ZgyH0AZHTOSKynn8NuxYXj1/1baxK5OfkQgehJkpyNh0kqto8i62yYuht1KaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Za0DVAOP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gDb6is9h3aygCvo98TjzWRCzIca3atfYq0oXyXuGF/4=;
	t=1726563813; x=1727773413; b=Za0DVAOPpZxXWObZAJocJwfX4WIfvU2tu34JtgQMXd5yHZ7
	WTzhstsqYp13xrCUPtE8Ccuestlu5qLoi0xcFlPONUCsW+dNEkBhg9XtcgGQC/S9WfpNuz5nstNgi
	Jt1c4X3lAIaoGOFtH8jv/nZ+svfVNBNaa6wJCw39RDm/8U7s/xjvlkwSgYmXLYNA31yvvQxF7Ehd9
	rv8EUkPGH+rkBD1MzCrHz/7oGN9E1VDsAgR/WeU0aUMzPNGOkOwzL6uq2MGBDhC4daHYOPRPO4aDQ
	GdPJiyTGv8dAoEMDi5WB67/etHPyv5cuKl/twn6in8mhoYKY5pNRLdJGWP94DA8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sqU7O-0000000E6ei-2uTn;
	Tue, 17 Sep 2024 11:03:31 +0200
Message-ID: <88acd1fa81f534643bc2d94c909673375f2973ad.camel@sipsolutions.net>
Subject: Re: [RFC 6/6] wifi: mac80211: check vif radio_mask for monitor mode
 rx
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Tue, 17 Sep 2024 11:03:29 +0200
In-Reply-To: <bae46387-ad36-4541-838f-8cbab20557a5@nbd.name>
References: 
	<cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
	 <7d713206957ec56dc297d5645203b45341578588.1722885720.git-series.nbd@nbd.name>
	 <01d7528bc15ee682fbe2f200bdbf39066b39309a.camel@sipsolutions.net>
	 <bae46387-ad36-4541-838f-8cbab20557a5@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-08-23 at 19:33 +0200, Felix Fietkau wrote:
> On 23.08.24 12:23, Johannes Berg wrote:
> > On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> > > When restricting a monitor vif to only operate on a specific set of r=
adios,
> > > filter out rx packets belonging to other radios. This only works if d=
rivers
> > > fill in radio_valid and radio_idx in the rx status.
> >=20
> > Why does the driver need to provide the radio, it already provides the
> > frequency?
> >=20
> > But then I wonder if this doesn't go a step too far? This is pretty muc=
h
> > pretending that monitor only exists on a specific sub-radio, but ...
> > what for? Even userspace could filter on the frequency.
> >=20
> > I mean ... I get that you're trying to preserve a notion that you had
> > that an interface exists on a given PHY and they're all separate, but
> > they're not really separate any more, get used to it?
>=20
> Well, there's a performance aspect as well.

Which I'd firmly put into the "premature optimisation" basket at this
stage though.

johannes

