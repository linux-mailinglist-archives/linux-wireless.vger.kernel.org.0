Return-Path: <linux-wireless+bounces-23296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61373AC08D9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B590E18969AD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5021ADA0;
	Thu, 22 May 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r2ZqILTy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDA33DB
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906553; cv=none; b=T4k6biWKTum+kDVQA0m1WuwqM1xugPjex0awkyJlBRI+8KKDxi/GHgFLCyA+8SCdvtRQs4BdYmU9xlIFSKQr0XQYmnKQCDhhYLTOgl7vm+X8vQjFwnTN/cOeOSHn9eGUMqLR4MHQsBHnP/AJ8xAUQbF0e5QJ8V/XLsf/N8tG8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906553; c=relaxed/simple;
	bh=1kiUEQ3fMBCs0h0E/JnWI3Pm5vyH/RitM05GS73Lb90=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idri8qnO70WeQqWJeqgzjAk+ckBCrfH6ID77mXJf1KmVW0NSe1S1LW4SLphKRfyhQF4WulXNH5j8ticzbmFrWN2R7eATSAfaj833+MuT0HZ05qcJAPkzNExhHJ1m40UUHyeGViGoAmo64PxYhRZRxEdztCeSyRfEE+kjd9Qp+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r2ZqILTy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g3fud9tGDujnjXyvQ5FeL8D8/ZdvZLj+1JZXjlACHwc=;
	t=1747906551; x=1749116151; b=r2ZqILTyNJRoNevFeZMwW1qCy9LU9iO36LT5KWlWwYn91k7
	X1sKE9KJUUj3FNv8VvjyK3PNz9rHBMaD3mIu5nFG/vZ4NnPDzvlTRhtzeZU6lWjxRYbMzveACjhU8
	RMH3QXoRdxSJCHLX6norCD/hna9XRmIOcXcOaQRtYJ9RY5enUHKxAtOjQsKiIQW9RIjzXlLJd9A0Z
	vDfRHllZrMYvHf1TeeUtQ0T7FkTleclrKniRbiimiPHcwSUwawHaCo8nil+/xrwdRiDrqJnob0NUf
	BHhxKQkL2SVjWR+CFp8dIsQdLSCg1tTMEeMTo2byVRHrHV4OmFiJ2enbjAKkwkmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uI2Kz-0000000GaBk-3LnW;
	Thu, 22 May 2025 11:35:41 +0200
Message-ID: <c8a6f706bc0aec46f7619ba3eb373f13d0c94969.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 22 May 2025 11:35:41 +0200
In-Reply-To: <9be5a453-730f-4ed9-b9fc-1e703f38f9f0@quicinc.com>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
	 <20250522085601.2741458-4-quic_sarishar@quicinc.com>
	 <9be5a453-730f-4ed9-b9fc-1e703f38f9f0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-22 at 14:33 +0530, Sarika Sharma wrote:
>=20
> > +	if (sinfo->valid_links) {
> > +		links =3D nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
> > +		if (!links)
> > +			goto nla_put_failure;
> > +
> > +		for_each_valid_link(sinfo, link_id) {
> > +			link_sinfo =3D sinfo->links[link_id];
> > +
> > +			if (!link_sinfo)
> > +				continue;
>=20
> I have removed the WARN_ON_ONCE() check for !link_sinfo because=20
> link_sinfo can be NULL during sta_destroy.
> It appears that nl80211_dump_station is being invoked during sta=20
> destroy, though it's not very clear why this happens in that context.
> Introduced in patch " mac80211: avoid excessive stack usage in sta_info".
>=20
> Since link_sinfo memory isn't allocated during sta_destroy, there's a=20
> valid chance it remains uninitialized,
> which triggers the WARN_ON_ONCE() and causes hw_sim test cases to fail.
>=20
> Let me know if I am missing the requirement to allocate link_sinfo=20
> memory during sta destroy.

Probably not, though maybe we do want the link addresses in the station
delete message to userspace?

But the warning was just an inconsistency issue - why should users set
the valid bits for a link but then not have any link data? That seems
wrong?

johannes

