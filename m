Return-Path: <linux-wireless+bounces-9602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE2F9180EB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63681F22DB9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9428C17E911;
	Wed, 26 Jun 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UHhAR+n3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DE1802A7
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404653; cv=none; b=gPiVsXhdkqT3T3UxnLz+c2j4etywWx2kzZ28cnOrNhuCTVpA2TxNzcb2UlpyKbFwczrmWBPNJUXYZmJ9LVGHHUqEP7mhNCvg8xGDlsO6FDhdBfCKhHSVP2krNGUsSmbJvcdZyPx251QWyVlYYvo73Fig1oNUkEkoFoDvsHqh178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404653; c=relaxed/simple;
	bh=K0WRMe57NsDPzn/dCxc2TeueZW0L6e0I6BjAiQZ+v9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNKALVmSrfF4c/quV6kS3pB92QZ9Nee+hv9yOZiJhF0EhG3ZMYDcySLBnKN6xeL2rbj9EZwVMGju19tZ6WE8tdfeuC37YRB+DfsEan9eow6BhrvuHAEv25c3qXVM1TQFtjnAJ74Jnz/MUopXNAI2rRlBurD8YUqKEeSqrCKzNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UHhAR+n3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K0WRMe57NsDPzn/dCxc2TeueZW0L6e0I6BjAiQZ+v9Y=;
	t=1719404651; x=1720614251; b=UHhAR+n3FBpbkdCIgZqQwQTIfLyFlRu2/vYVWxFQWTjbsnt
	IXhGJh9g5BtGy4eFQEXNL385UEPYOSKSpUOzXxRygvQl8y9lg2Ib1AklTorhGxKtzo52HvuGvGWaf
	1/nejaiASaajNiXzNZPz2HkLBXcfuUyupCtXeJlpJbhUgGoNUQZIF3m3MUigCb8rPo5MoMCiCXV6z
	AmH7p8plONsRXxsT3013+Oa/TvxDn1OnzpC2EeA71w8U8vnkR7vkui8NYm4KO17mNi6wc0yd7Kuxt
	5LQza8ZcP1hn5l2+LKITUHZb8FggTtT9AldlIXgk5XUNL+7JA3DAEnh+ULKTAxwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMRh2-00000003biS-0uL7;
	Wed, 26 Jun 2024 14:24:08 +0200
Message-ID: <fe16681268e2a2c9a69867fc954f3d6e777dcaf4.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/9] wifi: cfg80211: move DFS related members to
 links[] in wireless_dev
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 26 Jun 2024 14:24:07 +0200
In-Reply-To: <20240626045216.3754013-3-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>=20
> Since currently, link ID is not known at all places, use default value of
> 0 for now. If link ID is available, use that instead is such places.

I think you're playing with fire a bit this way ... now you can e.g.
actually start radar detection but it'll use link 0 in
nl80211_start_radar_detection(), but then start an AP and actually check
that you're not doing radar detection on _that link_ in
nl80211_start_ap(), all while mac80211 (only 'driver' possibly
supporting any of this right now) still hasn't actually been updated to
do anything per link ...

Now we could argue that it doesn't really matter since hwsim is the only
driver right now (though iwlwifi will enable MLO soon now).

But also, it seems unnecessary? Why not add the link ID to APIs and
mac80211 first, and then actually switch over to using it? I may be
wrong, but naively I'd think it's just a question of ordering and/or
recombining the patches differently, more or less?

Certainly you could have patch 5 first, and just ignore the link ID in
cfg80211 for now, and switch over to actually being able to start CAC
etc. on links other than 0 (and checking against the correct link) as
the last patch?

johannes

