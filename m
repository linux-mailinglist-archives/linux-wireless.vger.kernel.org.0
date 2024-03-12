Return-Path: <linux-wireless+bounces-4607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2798F8791C1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 11:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597561C22061
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729F7828D;
	Tue, 12 Mar 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BxfWG7iw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5677F34
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238660; cv=none; b=UG3B5chqBCBYAlpJKxR8+HotVGkomkm3xxKZ4N7H20ZBQPUOSHTj/FbCW3apU91U+WpvbeFlqg8PZoyffrB/9rljJgukGQ5r5eFKFPtxoPbkdfVHEqHiRG/BsdIjns/CzUGkjpIuWZdaA7+say5Jj3Z/PTH2Iw9IURdzQ4ecFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238660; c=relaxed/simple;
	bh=4pGjI9oKZCB4wqhNgGSmY1JvKeg2YfoJocYC/kShyN8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrV5/Q3gUGTLTNLyLF1pU5Ly2/2467q4r44U0yFbNTs7OT+uincthYF1rZLFma2o2GiH3NYB1sMGQnF71tOmyAMir1hdQARVeP1yC9+KKVbZUPgRhU271zigfzTfjQGo+v/vW2rq8pgfxqtU9ZIdxuzSqefvudP/zcwu7wa5Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BxfWG7iw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4pGjI9oKZCB4wqhNgGSmY1JvKeg2YfoJocYC/kShyN8=;
	t=1710238657; x=1711448257; b=BxfWG7iwzaXAGCOuL/Fsc+rooBq1s0V/YCoR7uQqMBk57cC
	8gHPj8yr96XcT1QXaOXuFsCorAedDzoO6tOTPT+JRMJvlQnYBp7li9STS3/521a30UWrszXqElbUg
	ojjkCPyv9k9c3pSIojRkSqK0udAkEwVjtUzdNIqK4xuEVUIhLnFr+AhGPHB1TywwXy1B/9SdYXNVF
	zCasRer6WQwQF5cU4gvPySZwCxjwpRBHBxQsOQZmEDzf3mp7z79ypCm2rwQPlRVbQsuGIV457PAlE
	IWAUdPWRNl9jph8vNsoK9jdO28Ji6sqz4CyCwe/IyS0VsbE82YdEzaG+qRiwJsbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rjzCQ-0000000DndJ-3rMY;
	Tue, 12 Mar 2024 11:17:35 +0100
Message-ID: <84b85c7f409ec38a34ffe040f4d1e90253854c21.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: supplement parsing of puncturing
 bitmap
From: Johannes Berg <johannes@sipsolutions.net>
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 12 Mar 2024 11:17:33 +0100
In-Reply-To: <4c1adfca-96aa-4b41-86b0-2fe5ad3e6cfb@quicinc.com>
References: <20240312045947.576231-1-quic_kangyang@quicinc.com>
	 <20240312045947.576231-2-quic_kangyang@quicinc.com>
	 <8cc7e7f7b2914385b481ecfdd7bc3f67fc4546b3.camel@sipsolutions.net>
	 <4c1adfca-96aa-4b41-86b0-2fe5ad3e6cfb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-12 at 17:22 +0800, Kang Yang wrote:
>=20
> On 3/12/2024 4:16 PM, Johannes Berg wrote:
> > On Tue, 2024-03-12 at 12:59 +0800, Kang Yang wrote:
> > > Current mac80211 won't parsing puncturing bitmap when process EHT
> > > Operation element in 6 GHz band or Bandwidth Indication element. This
> > > leads to puncturing bitmap cannot be updated in related situations, s=
uch
> > > as connecting to an EHT AP in 6 GHz band.
> > >=20
> > > So supplement parsing of puncturing bitmap for these elements.
> >=20
> > Hah, yes, I just noticed that too and fixed the second part yesterday,
> > and was still thinking about how I could test the first part :-)
> >=20
>=20
> Should we add validation for puncturing bitmap in=20
> validate_chandef_by_6ghz_he_eht_oper()?
>=20

We already have, no?

It calls ieee80211_chandef_he_6ghz_oper(), which checks
cfg80211_chandef_valid(), which includes puncturing.

johannes

