Return-Path: <linux-wireless+bounces-28402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E030AC1F15C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F3CA4E9BBF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5AE33891D;
	Thu, 30 Oct 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QpKwMHkj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F93337BA1
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814082; cv=none; b=cevsblolR5gBZ5QhuLs6TPy/rm3uvEPcUNBqGmjYa3QMIvFC7rOq7NqCfu3ptGOGn8moF+e9BMhGP1HwAisE26MLvWPL2THS+veFvo/MLB7ijLczC4lFkd58C3slRZDxMUvwbe6VMHT31ikt9fErEuwWQtgi54u46KQXo8Q7MMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814082; c=relaxed/simple;
	bh=3Hf+wEBwc7Rzr1pIbO2ZOzrCbf45iMRZH1tYzls+nMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiHJrohHzBZK+2fWuA14ePDhskHRY/TwZui0fX6XQLTFG+nTRB9FHBVlSijFprWKBiaMPk/G79NHGV/2HL3ZQAS0eQCtAjUzkdOJiOET6c+zgYsQGOtXfX5ZVxNEEM7KxU2XmPNCe6IhOxO03G4nprLaRWXBnYatOjCP1LuDqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QpKwMHkj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3Hf+wEBwc7Rzr1pIbO2ZOzrCbf45iMRZH1tYzls+nMg=;
	t=1761814081; x=1763023681; b=QpKwMHkj8wEL1QkP3lOv/Moxi48bMPE3ZjzXcTeTdGvvsyv
	2Dnj0Ys7nfY+P7DN8jUSp6RVpnV3g65IvN97lhyan9dLsz5hKsOr/irKH1lckgN/y0NvgvzRCtl8w
	CMEp44zJ/xWJI9wSf4AoV420speeob0QogZAhleUryKXleJ4PCj26NiIFp5Z6ftlWnCisNyVjdc/D
	KMoVxajfrA2g+yx63Vc6K1jMx3Pb+uuXlOG4KVMwEwv8ujylI7vUpk0G+HB7XdBd4M2SDEhlnrR+j
	bPRrY9ZGJZRpobL7d9oNWJ9H7ZdtRCGVpoplPJWOnuXkSpDv7zIq8a6DZl64dwXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vEOK4-0000000GDBZ-1Lgp;
	Thu, 30 Oct 2025 09:47:56 +0100
Message-ID: <b6a9de98b9b09c73003b89331ba235c3a959c3fd.camel@sipsolutions.net>
Subject: Re: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8
 Seamless Mobility Domain (SMD)
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Aditya Sathish <quic_asathish@quicinc.com>, Johannes Berg
	 <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	hostap@lists.infradead.org
Date: Thu, 30 Oct 2025 09:47:55 +0100
In-Reply-To: <fb0a1ddb-af24-47f9-9d75-0a8f2e346d81@quicinc.com>
References: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
	 <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
	 <30403bb70a2a017c90b1d4a5a1a07514bb670822.camel@sipsolutions.net>
	 <fb0a1ddb-af24-47f9-9d75-0a8f2e346d81@quicinc.com>
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

Hi,

On Wed, 2025-10-29 at 16:17 -0700, Aditya Sathish wrote:
> [SNIP]
>=20
> > A good part of this argument - "pending management frames" - really goe=
s
> > back to hostapd's architecture and single-threadedness, but really I
> > don't think "hostapd's current architecture implies more latency"
> > implies "we must put this into the kernel."
> >=20
> > Continuing that thought: I think that hostapd's architecture currently
> > leaves a lot to be desired, in particular around how MLD works, and
> > obviously, at least to some extent, being single-threaded is an
> > architectural advantage in hostapd.
> >=20
> > However, user space also affords far more flexibility than kernel space=
,
> > for example some things could be written in rust (with its "fearless
> > concurrency", which I can attest to), split out to a separate thread or
> > process, etc.
> >=20
> > Anyway ... I guess in a way I'm using the opportunity here to lament th=
e
> > lack of architectural work in hostapd which isn't necessarily related t=
o
> > this, but I suspect that had hostapd historically had more architectura=
l
> > flexibility we might not even be having this discussion?
> On hostapd architecture: we have had internal discussions with Jouni and
> recognize the limitations of its single-threaded model at least in contex=
t
> of SMD roaming. We are yet to identify any features outside of SMD which
> holds a critical latency requirement. As such, we see _full_ multi-thread=
ing
> as a significant undertaking without any users of this benefit outside of
> SMD (at least at this time).
>=20
> Given this, we are exploring an alternative approach =E2=80=94 introducin=
g worker
> threads for low-priority kernel events while enabling prioritized handlin=
g
> for sequences like ST Execution and the inter-AP messaging in the main
> thread. This could offer a tractable path to bring multi-threading withou=
t
> having to do a deep-dive study on the impact of parallelism on existing
> features.

Do we have a clear picture of what the performance issues might be?

To me, it seems a bit that talking about threading might be a red
heering. It could be that the primary issue is the prioritization of
events when there is a burst of activity.

We should not need threading as long as each individual event can be
processed quickly and hostapd is able to keep up overall. In that case,
we have an event ordering issue which can likely be solved by using
multiple nl80211 sockets and giving them different priorities in the
mainloop. By doing that, you can effectively pull all time-critical
events to the front of the queue and ensure they are processed with
only a short delay.

Now, that doesn't invalidate your point at all. If we do have tasks
that take a long time (crypto?, external requests?), then it can make
sense to push just the slow part into a separate thread and pick up
processing in the main thread once it has finished.

Benjamin

> To summarize,
> (1) We will defer offloading the ST Execution and inter-AP communication
> =C2=A0=C2=A0=C2=A0 to mac80211 until we are ready to demonstrate the need=
. Until then,
> =C2=A0=C2=A0=C2=A0 we will proceed with hostapd-based ST Preparation, ST =
Execution and
> =C2=A0=C2=A0=C2=A0 inter-AP communication.
> (2) We are planning to explore the introduction of worker threads for low=
-
> =C2=A0=C2=A0=C2=A0 priority kernel events while enabling prioritized hand=
ling for
> =C2=A0=C2=A0=C2=A0 sequences like ST Execution in the main thread.
>=20
> Regards,
> Aditya
>=20
> Regards,
> Aditya
>=20
>=20
> _______________________________________________
> Hostap mailing list
> Hostap@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/hostap

