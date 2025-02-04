Return-Path: <linux-wireless+bounces-18420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2934A273EC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 15:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C956188B6D6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8FB20DD5D;
	Tue,  4 Feb 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mKStievk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D629CEB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677216; cv=none; b=Xc1+rRc5qDpLovQQb6lOY2e91YHSxrlI3naz6/EyzQTXN9fuZ+ijfhY/UoumK54AwS/zjjx+cgRCRMA9ODhBXjXnvLjw5bU76FtLG85SHrUWbWzboOsLLGoDSsYAkCe+4tgyQ0WRy49KRV3+T+JgnkJw1dphnRjb5kwt8g63ScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677216; c=relaxed/simple;
	bh=fywqwPY791V5xKqXNAsuKLAKkiOWE0xy080BMVJWCJM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXOR5YKS9kBfnGruQoK9ft70MXPMPn+hvh8pkapjQk4ra97dUmRoiQXbc7NfVYoKqOXxJfTrWU4QGOeXBRfZPlJBSoRc0xSVTs4cLxOjP04druiVjatx3omSKI02TMNJX+cf9VDV5EFquDD42nCm5Yz1c44nm09XMRRJ3VtxDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mKStievk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fywqwPY791V5xKqXNAsuKLAKkiOWE0xy080BMVJWCJM=;
	t=1738677215; x=1739886815; b=mKStievkqt+mxJRK7hqt1Mo59sisgY90AEMR+5wCEElkHVK
	vGZcEO4pflZFBGkrp/Q2PN0ETg63eLTeHKs59VeA65DwSkfTfrA5t6QHVGcvBzIJWqtyGeyeY1MP7
	IEeRqkCwE3NnFDjYuYkhKscibGIx2UoxSnKi/y1hzfNHLscCRSvF1Oxx3vhybszISmPaiziHW5/bO
	00yv03z3skjddOlYaAbWKd9Oet6pg9YXEmP+ce2wYlfWFlifKUop1ANkh0ZyE+timn+VRusTxQ76X
	HO8ANB2I0SnEMyoOJHUIag1ZGvMVOpADWA5jwWgXjj67l7Z+8ci2rpaik94XInkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfJMp-00000002iIs-2fhp;
	Tue, 04 Feb 2025 14:53:32 +0100
Message-ID: <f315dd52354e4b40fa86b9f7a227b307f7e462e3.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Debugfs handling for virtual monitor
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Tue, 04 Feb 2025 14:53:30 +0100
In-Reply-To: <955d9e2b-17d4-4679-8886-30db6e376763@wetzel-home.de>
References: <20250204122617.8976-1-Alexander@wetzel-home.de>
	 <9e60d3a81e87649eb25e9bbeb599e1ed24050134.camel@sipsolutions.net>
	 <955d9e2b-17d4-4679-8886-30db6e376763@wetzel-home.de>
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

On Tue, 2025-02-04 at 14:51 +0100, Alexander Wetzel wrote:
> > Started wondering, maybe it should just not have debugfs at all? That'd
> > also avoid the potential name clash, and there isn't really anything of
> > value there in the first place?
>=20
> Knowing that we do have an internal virtual monitor interface may be=20
> interesting in itself. But that's hardly something we can call "real=20
> value":-) And that way we would solve any name conflict...

:)

> Not creating it would just require us to skip=20
> ieee80211_debugfs_recreate_netdev() in drv_remove_interface() for=20
> virtual monitor.

Right, should be simple.

> When you prefer that, I can send an alternate patch doing that.
> Do you want that as standalone patch or as a v2 of with a new name?

I don't really care, let's do whatever makes more sense? In this case
I'd argue it probably makes more sense as "remove debugfs dir for
virtual monitor" or something like that?

johannes

