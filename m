Return-Path: <linux-wireless+bounces-24938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723CAFCA5A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DC63B82B6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1AC35959;
	Tue,  8 Jul 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="azARzAK3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DFA282EE
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977465; cv=none; b=b6eJHAfRS9FB8MFYKpMMogAPydaOGYbkBrQbfastGGJxC11GtUMdnZ2D+oZHq22HinlOP5x36HaZjNRtF6l6u2B9u9by17oa5x34rxrMDaQiP/oJE0JnDuLySUwkSQTx/0D9/Fsx63Kiomnj/By1ZUpKsVAjSNkCVYCdZB0IdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977465; c=relaxed/simple;
	bh=DLmadgNY8ajnnaq1U5474830LbLZZJXQYAp2CScc3Uw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUnU3KKfVweQwXC2d1inPk1ePRIK1gZybCSmydWz9MoNqAItlBWS5TOtah9VboivRKsJg4Zjjx5SiXcoAMUI4d7Zatze+665aXnV1yOnd4E+sTk4yLVCCx8kCbvhCWRKrDzb7GtApzMdPffTtM7q4byDXVjkkuvwdn/OYlNDSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=azARzAK3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DLmadgNY8ajnnaq1U5474830LbLZZJXQYAp2CScc3Uw=;
	t=1751977464; x=1753187064; b=azARzAK3GnF7fDTyeTSjADHnj1Iwc8FpvgH6u5LUC6SMjNn
	wjf5l75Jb1s4kHzprRle3n4deaSqZDIf7BBhFhrvAa2rFnZN9kkDCVTErJfrgcG1bvCQeug/j+pPC
	J2VqS6imBELTLP+uieMY2ilFphliG/qJdifj4HHd2TJ/a1m9sostQxDXYFwMAtP0rQiNz8miHiqx+
	oBy8I29IoGMtsOjTJrobNC4eitiItP/jnc/Hchyicn00ohzIx68TfYGo7OEfOCp1aZvSmbbiJC3Ur
	YTlRldQzSEunb7bltg7p1MXdeJzm3lMtkvxcxpCqBjMfLB4ZdRSZvFFwqOaty0eQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ7Mz-0000000BsUH-07aP;
	Tue, 08 Jul 2025 14:24:21 +0200
Message-ID: <afd988d56f95b5041ee9ee30d59f168f3fdc9aa0.camel@sipsolutions.net>
Subject: Re: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN
 commands
From: Johannes Berg <johannes@sipsolutions.net>
To: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date: Tue, 08 Jul 2025 14:24:20 +0200
In-Reply-To: <SJ1PR11MB625216838B22D946DC359C74F54EA@SJ1PR11MB6252.namprd11.prod.outlook.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
		 <20250622222444.356435-2-andrei.otcheretianski@intel.com>
		 (sfid-20250623_002839_326397_7F85850C) <e39611e7990541138e7d82809fee924433274912.camel@sipsolutions.net>
	 <SJ1PR11MB625216838B22D946DC359C74F54EA@SJ1PR11MB6252.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-08 at 12:00 +0000, Otcheretianski, Andrei wrote:
> >=20
> > When we have "nan_supported_bands", it seems to me these should really =
be
> > by arbitrary band, and bitmap of bands to enable scan on, or something =
like
> > that ... also this really applies to the nl80211 API.
>=20
> NAN synchronization is only defined for 2.4 and 5 GHZ bands.
> Now, "bands" (supported bands) field existed before, and I didn't want to=
 change it.
> Having an array of band_configs imho looks overkill.

Sure, there are any number of things that are not (yet!) defined. I
still don't think that's a good way to do software architecture. We
didn't _need_ to support MLO for P2P, but in software architecture,
handling everything as the currently supported special cases mostly ends
up hurting in my experience.

And Vinay was just also asking for a 6G support flag. Am I supposed to
believe NAN operation there is only unsynchronised, or how does that
match?

> Regarding enable_hb_scan (if this comment refers to this field),
> it can't be for "arbitrary" band, as disabling scanning on 2.4GHz is not =
allowed.

We can still represent it that way ("scan bands"?) and just forbid
certain values, that's not really much of an argument either?

johannes

