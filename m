Return-Path: <linux-wireless+bounces-36088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G4IFE/Z/GkgUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 20:26:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540B54ED65D
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 20:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 707063002505
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4331E824;
	Thu,  7 May 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QZB5hK0z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC62BCF4C
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178378; cv=none; b=qjNkzBkgPUPDKYzsyPfnRUX+tnSfQ5ConW1tGGIjE7aF7MmivaMaNHdAxhkt/vjlK8BgQ6JJKCLiPiuPT+yCaQIO43CAlcey9Zk+yoADcpkXj/IbWUC9TUzPALTZEqoXf/COGohd/4jEoZZf8E7jDiavjowjHDrhUXojDrLpjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178378; c=relaxed/simple;
	bh=neRrY21R+GHrULaZM86q5cmvbIA3qdx+eZpjHML5pCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCRGvK7C7PRtuz+ODLW/7E7aZ8Sj8u1OhSxPhQP8wv+5Ovu+wjLDLGcKTfCQf0ByYSt8J8lSWg58tKOEyTQMMIhtTlXK/YTcw9UFwxbgmNkch9gWaCjgtUuSTeGyUxIbxJ5iI8IZM6lTnpp/R1zuGI2IvtsVay/UCuilL4X4d+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QZB5hK0z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GaXb/2nrWWRhSCIBDS6/VHMjhtS0soG7Xw53BfdGC0s=;
	t=1778178375; x=1779387975; b=QZB5hK0z1Igm/9NUFR/7POsIO4Nq0T2rMPio11aVeXtV4gS
	hrqZnAo3uHiTh7kbaVlgbnpajlgLPmJG8CXAMGZhM36DDUwtCOG0cPP0iIY8dFViVoHZq7SBOyzyZ
	7XbWuYr5em85nXM2d7dV4MgMwUWhc+a6gJabVMyvuXIUSoLIVBlp7t02B/zgNYVLCWImplK7TvpJ7
	Xkd15Qgwv6ak6lbiISaTcpmMZOBEOHLKeX/Cog4Zc9/X1kcyKgTF62FZeq3ZyjId5MToosa0nczKs
	zZGhE3nT1GI8B5r2Fba+Vn9+hzsaHjnR87FcbAe5+VST7g6wBa6AEy/Zw9eHa6lg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wL3QJ-00000004K4e-0WRJ;
	Thu, 07 May 2026 20:26:11 +0200
Message-ID: <a5b6798819178dd2995c34ec817457e90985708e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix ADDBA request
 rejection after MLD link removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Hari Naraayana Desikan Kannan
	 <hnaraaya@qti.qualcomm.com>
Date: Thu, 07 May 2026 20:26:10 +0200
In-Reply-To: <1d06b2a3-66d8-4c27-b965-6c21f80b7539@oss.qualcomm.com>
References: <20260415-addba-req-v1-1-6eb9a33d8ca6@oss.qualcomm.com>
	 <1f57207139c3fb955459425deda4d06c374ae212.camel@sipsolutions.net>
	 <1d06b2a3-66d8-4c27-b965-6c21f80b7539@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 540B54ED65D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36088-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Action: no action

Hi,

Sorry, I've definitely fallen behind on some topics.

> With link reconfiguration, not handling the update requests sent on the=
=20
> remaining links causes throughput drop, that's why went with handling=20
> the update requests even-though the session is valid.

I'm not sure I see the relation right now, how does link reconfiguration
relate to AddBA re-negotiation? Are there implementations that
necessarily combine the two somehow?

> Please let us know if we need to clear the old session and then proceed=
=20
> with the update request to avoid breaking the other drivers.

I'm not sure what you're trying to achieve, so I'm not entirely sure
what to say. I thought we were starting from "we should accept no-op
updates".

> > > Note: A similar fix has been proposed in [1]. This patch also fixes t=
he
> > > issue mentioned there. The difference in approach is to keep a simila=
r
> > > flow when the dialog_token matches. Previously only the timeout value
> > > is checked, updated that to check the timeout only for the hardware t=
hat
> > > doesn't set SUPPORT_REORDERING_BUFFER. In [1], it was changed to invo=
ke
> > > driver unconditionally when SUPPORT_REORDERING_BUFFER is set.
> > >=20
> > > https://lore.kernel.org/all/5806bab7e46506d3c300ab4eb66989d42936aeb0.=
1771323902.git.repk@triplefau.lt/
> > >=20
> > What was wrong with the approach we discussed there, other than nobody
> > implementing it?
> >=20
> > johannes
>=20
> Not a major different between the other change, thought of keeping the=
=20
> similar version that we validated in the internal tree.

I don't think it _is_ that similar though? Or maybe it is, but I didn't
think the other patch was correct (either).

Basically I'm concerned that calling drv_ampdu_action() with
IEEE80211_AMPDU_RX_START when the session is already active may break
things depending on the driver.

If you think there's a need to _really_ update parameters, then we
should probably add a IEEE80211_AMPDU_RX_UPDATE operation, and implement
it in drivers, and of course in some drivers that might just be
equivalent to IEEE80211_AMPDU_RX_START (though that seems unlikely in
general, given you may have to allocate reorder buffers etc.)

Regardless of that, if you think we need to accept no-op updates (I
don't think we've seen the need so far), then the code shouldn't really
(need to) call the driver at all, since things don't really change. For
that I'd argue we should go with the approached discussed in the thread
of [1], but not really that change itself.

[1] https://lore.kernel.org/all/5806bab7e46506d3c300ab4eb66989d42936aeb0.17=
71323902.git.repk@triplefau.lt/

I'm perfectly willing to believe the need for both, but I'd argue that
 - no-op updates can be handled by mac80211 entirely by itself, as
  =C2=A0discussed in that thread, just someone needs to implement it
 - updates with changes need a separate call to the driver, which might
   fail (either because of the change, or because it's not implemented)

As is, I don't think the code is safe in general. It may be that you
validated it against your driver, but then I'd argue that it worked for
your driver only because a new IEEE80211_AMPDU_RX_UPDATE would be
equivalent to IEEE80211_AMPDU_RX_START for that driver for some reason,
not because there's a general reason that this should work.

johannes

