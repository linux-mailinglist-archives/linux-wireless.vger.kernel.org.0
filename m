Return-Path: <linux-wireless+bounces-12906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E997ACAF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31897B29FFD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19120149C7A;
	Tue, 17 Sep 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rYmyeIlx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF61DFE1
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560806; cv=none; b=tg/l3YqhF1WSZ43Pl2zvUkpuzYGmYnRl73ee+p73a8GwSEbDY0uZ33zYfmKgzDo6ZlocikNDffkg1FgM3Ux7A5iu8msvjaeQV7srs8O+ZIZV+VvLOOr01LeDKNdJyQzlCGvTwmnlLOG70SiLSPVyqHQs2C3UcKdvjulOmGhi7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560806; c=relaxed/simple;
	bh=pj4frwwu52K+aTzOn3yxWOvpsWTDxTV4bX2Oa9loN78=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5VXeq7tryVV9lWA7cnf0QFFhtt00grbqFu2TzqgVDI7g2sbJYWWsjnRnplD0DFqwdMoaco4X0lrlN4SjLP/ucfStJHEjy0zudwI+SyIVm4qVIP+k1HvirZIYpcsdCdS4PqVXz4PKMdXXNIPa6BGbxsx0aYfFk1WJEtipRSAzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rYmyeIlx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pj4frwwu52K+aTzOn3yxWOvpsWTDxTV4bX2Oa9loN78=;
	t=1726560804; x=1727770404; b=rYmyeIlxbbUQbLrSbgA3AglX2x0cv7VvUpEk3XFyPDFL3Gw
	F8WOjWfNsQyN8Xkz0jx7zIApsLIgvdmfmweBubPq1f/fm7uwytdw0O4wz3L1S6TDHD+nEs9k0UltV
	hzUb/GDj42WcQ6IWY3TEApiv9b1qCCjj2WNrrWpRQjg+33u+0zt8EnuQtViOKewFH6/SFFm8od26E
	s0ZNLm3ILrXU6hHeexgvvV3IG8ChOy1wkJsJ4eWLETHVABec2tImcUffGlMT/L8BU5ZYaef6Y4Agb
	olbs7sxMa9uOTUEnSPfEeEfYpwcKT+CWYnKQeWW93su7FVwQC2tLP+sxq0rVbR3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sqTKl-0000000E0Ec-1fqY;
	Tue, 17 Sep 2024 10:13:15 +0200
Message-ID: <8a0cb794de71bab324bdc1bb68ba58488ab925b3.camel@sipsolutions.net>
Subject: Re: [RFC 3/6] wifi: mac80211: notify driver about per-radio monitor
 enabled state
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 17 Sep 2024 10:13:14 +0200
In-Reply-To: <47BF11DD-ECD1-4314-AD1B-B58A99724DFB@nbd.name>
References: 
	<8b11fddca38ea82b48ebe93a898582e698069f14.camel@sipsolutions.net>
	 <47BF11DD-ECD1-4314-AD1B-B58A99724DFB@nbd.name>
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

On Fri, 2024-08-23 at 13:26 +0200, Felix Fietkau wrote:
>=20
> > On 23. Aug 2024, at 12:16, Johannes Berg <johannes@sipsolutions.net> wr=
ote:
> >=20
> > =EF=BB=BFOn Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> > > This allows monitoring on one or more radios while minimizing perform=
ance
> > > impact on the others.
> >=20
> > But why are you doing it this way? You could already solve this entirel=
y
> > with the driver by setting WANT_MONITOR_VIF and dealing with that, I'd
> > think? At least after this series.
> >=20
> > I generally don't like hw->conf, it just hasn't really matched reality
> > for years with all kinds of new concurrency capabilities. At the very
> > least you'd have to write more text here to convince me that we want to
> > add something to it ... :)
>=20
> I really don=E2=80=99t see how WANT_MONITOR_VIF helps. It seems completel=
y unrelated to me, since it only creates a single driver visible vif, if th=
ere are no non-monitor vifs on the phy.

Well, it's true that it only creates one towards the driver, but that
one vif can also only be bound to a single channel context, and
therefore a single radio.

If we actually want(ed) to support monitoring on different radios
simultaneously we'd have to change mac80211 quite a bit, and probably
introduce multiple virtual monitor interfaces. Internally, we _always_
have it now, to be able to bind a channel context, so we'd actually need
multiple - one for each possible parallel channel.

So that's why I think having WANT_MONITOR_VIF helps - you can assume
today that only one chanctx can be used for monitoring, and once you
have the monitor vif in hand, you know which one it is. Therefore you
know which radio it is, and can adjust your offloads/etc. accordingly.

> I want to be able to control, which radios I want to capture on, regardle=
ss of which vifs are already active on the same phy.

Sure.

> A global monitor enable/disable status means that I can=E2=80=99t prevent=
 monitor-incompatible offloads from being disabled on radios that I=E2=80=
=99m not monitoring on.
>=20

Yeah I'd just say don't use that state, but the presence of the monitor
vif, and you can figure out which radio it's present on.

johannes

