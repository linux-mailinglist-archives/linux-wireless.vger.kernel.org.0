Return-Path: <linux-wireless+bounces-28506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFBC2B839
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2B63A24CE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66C303A2E;
	Mon,  3 Nov 2025 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jao7Sjet"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47C304969
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170388; cv=none; b=KpipOk5ZPgPEVgTNSrr8SkTGg6W6EyPoy7zfdGVG9Bia2tdOqgB/gcdnGCdnbBWAkf39uT8LN9DQzVq+G0eawIdWaFTFw1WviIsWEWpP0Fan9atLUmJBygmkeiOxDR1JqpbNv7/ZpfxuaHdC+0aNird0lRSQ51LGs5jP87qqjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170388; c=relaxed/simple;
	bh=ATTx8UWIQVorh5tzfcfkRLnebsxOTptgm+ternQ8VLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DN8vooQSJFg4dqvliGNKOG+hNZL93XEld44SZP9cwmqUNNBaEls0zdT8YoQbkPtlyCLoacDKAeMJAFAJwmBmYsPSiROteyfY0KzR2SsmAjSgJyvg68ZaC8XpRuaJp0AuH0rEAN0LpeJMz78liMs8iG5KqrFQC6bQ01vK+L438Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jao7Sjet; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ATTx8UWIQVorh5tzfcfkRLnebsxOTptgm+ternQ8VLM=;
	t=1762170386; x=1763379986; b=Jao7Sjetke7MgpuB56Lld6RJfqW60PMGnXVTAPkxzcbyfJB
	ggHmgL5fmlZWn+tAfjXExbMxtK4N3EpyQU7BaMgpVoInDwgfE33uTNboNBhF3TTyJq4hRNE6qHx9q
	DwL4Zs66Rn3C4YOPZ7BdQkLCsto6HwajuojMdTwRhq532szmI0VdJBvPFdUxFDQtQ4PIsdsMTlJ/j
	wS2WrqTPPHdV+woamfNf5dR/WWrs/B2NH2Og44jknNTV6ox8zBOJR3iQ9KuepOGhhG4V4EqsH+XPt
	AvPbs0CfpbRO7T3mJWziFEqHjGfdEUaaO4O/3f4ANcT2O5CMMpvDnHZPPFbOLR9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vFt0x-000000095bi-3RTK;
	Mon, 03 Nov 2025 12:46:24 +0100
Message-ID: <a4368b0ad60c28e143ff35df0b246759d72a6b62.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211_hwsim: Limit destroy_on_close
 radio removal to netgroup
From: Johannes Berg <johannes@sipsolutions.net>
To: Martin Willi <martin@strongswan.org>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 03 Nov 2025 12:46:23 +0100
In-Reply-To: <d2cbf9d01d80e8b42afb162e30f7ab6c72605f46.camel@strongswan.org>
References: <20251103082436.30483-1-martin@strongswan.org>
		 <e0027a727707215c279626548bd3bb2101ffd8a8.camel@sipsolutions.net>
	 <d2cbf9d01d80e8b42afb162e30f7ab6c72605f46.camel@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-11-03 at 12:12 +0100, Martin Willi wrote:
> > > As the portid is not unique across network
> > > namespaces, closing a socket in one namespace may remove radios in
> > > another if it has the destroy_on_close flag set.
> >=20
> > How did you find that? :)
>=20
> A test-case for our hwsim API runs in a container with PID namespaces,
> so portid is usually the same. Concurrent CI-runs of this test failed
> quite often...

Ah, OK, makes sense. We do most/all (kernel-level) testing in VMs or
UML, so haven't been affected I guess.

> > And then, how did you find it in hwsim only, there are surely other
> > places in wifi, see nl80211_netlink_notify, that have the same issue?
>=20
> Hm, I assumed it was just a shortcoming in my commit referenced in the
> Fixes tag :-/.

Well, I guess not "just", but I suppose it was in a way. But I didn't
notice it either, which is not surprising because I wasn't even aware of
it in general.

> Shall I send a patch for nl80211_netlink_notify(), skipping radios not
> in the netns of the closing socket?=C2=A0

Hm, yeah, we could do that? I was going to say it's more complex since
we'd need to track the netgroup for each "thing" we have there (that can
be owned by a socket), but I guess if a radio is only reachable from a
given netns then everything must be owned in there.

So I guess I haven't fully thought about it now, but patches definitely
welcome.

> What about regulatory_netlink_notify(), skip it if netns !=3D init_net?

I guess then we'd have to prevent nl80211_req_set_reg() from being
called outside init_net too? Hmm. I don't know right now how we should
handle this.

> Treewide, {nfqnl,nfulnl,nft}_rcv_nl_event() look fine, as they operate
> on per-net data. nfc_genl_rcv_nl_event() might need a fix as well.

It does seem a bit of a gotcha. Maybe the upper 32 bits of the portid
should have encoded the netns or something. But too late now, and it
seems it was really "always" this way.

johannes

