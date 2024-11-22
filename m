Return-Path: <linux-wireless+bounces-15594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7939D5AB3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 09:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C056A1F238F4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC5179954;
	Fri, 22 Nov 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m7o4mYIK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE823172777
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262930; cv=none; b=EfnhKETil6pBOBfaFJni89t+72bSYrjvChyBYy/oREGEmHEmUN2kd2HgvNC/jvqXLIK3Xz+zJaBCdJ4ytVHWAYT7NyD2T49/QyKmMbgawdJoFuCWcqgGZ06Ik1/Rggk+bFY4PGvy8AZ3jVzDnyA5qO/3WsHLO9tSIWYnLYvSLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262930; c=relaxed/simple;
	bh=WIF3IGz0f92Nquy/+AYcrmxjSkY56jl8oCFbe+rvLkE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CnR3XXovwhKrDmeyFtC+Labdr0tz/ACOMrnQx8TYfTjTa9iPBfnHx9W4kMAN4F0lu61+SgzSDeFrXP6aVwCGQQJJ+8gvGGEIMazYEo4Lf6mo+JoEnekua4qJ3rrvsY69zi6oGt8wTael654aStf9cuqhH2jws9HWp0lHW64jtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m7o4mYIK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WIF3IGz0f92Nquy/+AYcrmxjSkY56jl8oCFbe+rvLkE=;
	t=1732262928; x=1733472528; b=m7o4mYIKoL14fgkNRCgysxN50PeSiKRe823U2hAkXLIoUny
	6dK1C8U8VbufnnERnFu5uabH+xCxNHa67gGWUGvUBDYAZ8W73280CPtKuO8h5cCXsKE8DKb4IePs5
	Hk42HIjKdZGaXpKigotYT/BGpnDkjoSo4VOf29wtY4BWEHZgLsNWrTHUy1Q2EdssQ63zHQ/N636qq
	s2KcGXGf8TYwnHaPuSfvaLErBZUA2/X17HAokmnLAalSvEvRlPM67r0/HsDBpZ4/8s1vTe90b058P
	7yJp9RZswOQMinWYfdyzTg8dAMlLRSm68ga7ui1koFCyiGJW95qYkLH4KqLPTlfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tEOia-0000000BTzh-25Pt;
	Fri, 22 Nov 2024 09:08:44 +0100
Message-ID: <22c98cda2d98520f45fc75404dcb5454017efb3e.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211: use wiphy guard
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org
Date: Fri, 22 Nov 2024 09:08:43 +0100
In-Reply-To: <af6d174f-2990-46ed-b195-b5049e6765e2@quicinc.com>
References: 
	<20241121231136.4fede74dcb60.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
	 <20241121231136.9e02d2b88f8e.I5b06810b7a71860fe3c2efa92ac09f2a13e30d7b@changeid>
	 <4c8570c2-bafd-4072-81f2-b1d87c1f2b93@quicinc.com>
	 <af6d174f-2990-46ed-b195-b5049e6765e2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-21 at 20:52 -0800, Jeff Johnson wrote:
> On 11/21/2024 8:27 PM, Jeff Johnson wrote:
> > On 11/21/2024 2:11 PM, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >=20
> > > The wiphy guard simplifies some code here, so use it.
> > >=20
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >=20
> >=20
> > Now we just need guard(rtnl) :)
>=20
> wrote before I looked, it already exists...
>=20
> DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())
>=20
Actually, now that I see that I added it ... I did it exactly because of
this, but looks like it was removed again for some reason.

johannes

