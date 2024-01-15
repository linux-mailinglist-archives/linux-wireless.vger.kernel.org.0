Return-Path: <linux-wireless+bounces-1919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D682D77A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 11:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BA42816D8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F5101EC;
	Mon, 15 Jan 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UBbpDjlw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0B2C699
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0wa17+crlsPrpTtPM/bWsnoOfURri5ucSyKPwfWoNOA=;
	t=1705314975; x=1706524575; b=UBbpDjlwD9f2Q43pSB5jUir57LlS3TJVln85MbOuUlZkJlT
	d4cpid+PVnLeAokrh2mV1Y9lrO5PkCoz/vhWVKGZnn4vollZ2Cn8UGtApesbWknt0qcNGUEAtMRfH
	BV6dMX28nTD22Cm3PM5Fz9aNwo9fbCCDOEw8mO95wfoormV9Vh3Qj/cyMWXucTU4agwGFnoSMV3x+
	F0P4/zHU/rfhCv1bJxAbZud9MIkDWqelCHynyzKMNwo272BFZT27iHBBn3I2HrpD4g7hA0DrPXQV0
	/38IKCTSltaknX3aXPyAFfGJvyDd/8c97oR2w9ZtPLxeJ41cJffwZCNl2pX1ve4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rPKKC-00000003PIh-3HZv;
	Mon, 15 Jan 2024 11:36:12 +0100
Message-ID: <ef5ea65e80aa0eb8d73d37505a26d2dbc32c2e0f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath11k: rely on mac80211 debugfs handling for vif
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, lenb@kernel.org,
 ath11k@lists.infradead.org
Date: Mon, 15 Jan 2024 11:36:11 +0100
In-Reply-To: <87a5pb9cxp.fsf@kernel.org>
References: <20240111170629.1257217-1-benjamin@sipsolutions.net>
	 <877ckfip1g.fsf@kernel.org> <87a5pb9cxp.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-12 at 10:24 +0200, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
>=20
> > benjamin@sipsolutions.net=C2=A0writes:
> >=20
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > >=20
> > > mac80211 started to delete debugfs entries in certain cases,
> > > causing a
> > > conflict between ath11k also trying to delete them later on. Fix
> > > this by
> > > relying on mac80211 to delete the entries when appropriate and
> > > adding
> > > them from the vif_add_debugfs handler.
> > >=20
> > > Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs
> > > entries as appropriate")
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D218364
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > Adding ath11k list so that the whole team sees this.
>=20
> Thanks, this patch passes my ath11k tests and I don't see crashes
> anymore. But what about other drivers, can we trust that they don't
> have
> similar problems? I'm just wondering should we consider reverting the
> mac80211 commit for the time being?

Good question.

I did have a look originally and I just went over all drivers (i.e.
debugfs_remove calls). None of these seem to be vif related. As such, I
would say we could just go ahead with this patch and leave in the fix.

That said, we could also revert 0a3d898ee9a8 for now. I don't think
that has any severe side effects other than a warning from debugfs
reappearing again for iwlwifi.

Benjamin

