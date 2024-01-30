Return-Path: <linux-wireless+bounces-2815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C04842675
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B211F27BE3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CDE6BB4E;
	Tue, 30 Jan 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mOkjJbWU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45B6D1B3
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622710; cv=none; b=foBQg2cJyUS6rfUkxhDAGfwbyHa+SzqsuI9dO8Pmbwun0XoVpAncJ9Q8Jcq5FgNf2AfBZQuGtNkoWCiIBF3m4Pefq7YId8kTzGglMoM2x1GIUc+mu96z+FAy8RxMx63uU8RikcdCHNPSgrsg/X3j0xONW/v3JkZJyh/7ZHEA2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622710; c=relaxed/simple;
	bh=/tCliv7+71b01YQE1rEWBwOHRC+r5R0ook0p9XpZkgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJ3U49YZ2+Q0UclSQ4JpLV0mpO05BH3AeTF3l22AreFHL+KPPsmQyynLtx2uPynkfoM9EL8mG3R867TIFZfQ8L0AgR5m5dpoBBO0xQbkFcV+SrJilCq/piraPDfJ18LbMFFt8VyipLCIP1pHLgpkhv4yWMd+r12sXTJa3jfmSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mOkjJbWU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/tCliv7+71b01YQE1rEWBwOHRC+r5R0ook0p9XpZkgE=;
	t=1706622707; x=1707832307; b=mOkjJbWUR6Nvs9+diilaA7n1JUBu23C+TFOm25TuF+vV7h/
	qa055wquu6HFqXATLuucUy73BcQK6egbg2D8QJqDIY4opPNbeGZpWMr3GVCC8wpLMIIwuiJMTpPWD
	wIrAKqGap6rNXz2SqGoAcvx37WIm1lXzI2yhZ5ico+OImUNmysjLN2dPzzMEcBciOwvLkbpjLa0QM
	nPGddf+Qh9yPmJ3OH8qfXkt/az6bhKEqFyiuTL29xp3u4U3w9OKClZ90H5EAhp1vLbfFlYJbZkSaC
	OVfuEC7XZB5ChQsdc6ZIztZoWb/LyC0pq6DHKs4gUPadjfyLsXvJ1TNWDtGFobeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUoWX-0000000656K-46kY;
	Tue, 30 Jan 2024 14:51:38 +0100
Message-ID: <beaabd6f677eafbfb8abae30bf3cc19f43ac9b4c.camel@sipsolutions.net>
Subject: Re: [PATCH v7 3/5] wifi: mac80211: handle set csa/after_csa beacon
 on per link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 14:51:36 +0100
In-Reply-To: <3b37b302-aaf5-421c-af70-288aa8256685@quicinc.com>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
	 <20240130043225.942202-4-quic_adisi@quicinc.com>
	 <1e73c061653abf8e5f1671ae026e0905b2fb4ded.camel@sipsolutions.net>
	 <55d1aea6-8721-4774-9f09-549245461ba8@quicinc.com>
	 <3b37b302-aaf5-421c-af70-288aa8256685@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 19:20 +0530, Aditya Kumar Singh wrote:
> >=20
> > Correct. This patch's aim is to form the base - basically modify the=
=20
> > helper function to accept the link data argument. But at this point, CS=
A=20
> > is not started on per link basis hence in order to keep CSA working=20
> > still as it is before this patch, have used deflink here. Functionality=
=20
> > wise, this patch is not bringing any change yet.
>=20
> Any other comments? So that I can address those and send v8
>=20

Ah no, I didn't respond sorry, but that explanation makes sense.

johannes

