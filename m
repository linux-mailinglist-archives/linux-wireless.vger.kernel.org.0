Return-Path: <linux-wireless+bounces-14652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5852D9B4EC9
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C44C1C21FEB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F33234;
	Tue, 29 Oct 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KDQ4SJNo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0C802
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217772; cv=none; b=Y/EugMp7dK2pDgKoM31z5F+shx2QtwMW95uhwTtwZ0gT8nM2qw+neWU6oX+naos2stX0Ll2dMy+SDTFfX5+cjJOYYLu+9v6PRSGFJC/DnKj/K73NBDsSCq5QrrmyGzdY2VbdXT7YcP3YY86CnadV1w+n1jAPc6LRbnvnxk1EQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217772; c=relaxed/simple;
	bh=9tpX7XqLAKZkoIs5DMdXAW2cl1bd1XcvVV3LwEEFaNM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VLvdQFTIN+qBewaDP4TSQT4kRGESc0az5VKIAjsMLYVeN0/uCnPS2il0qaUgfy4PHoUf7X9+5GkrW37j6sRtcdqAlMY+KhpD5Z0V0B41mQdG/o90jjpyDa23ujwmYtoxPeDGy4FDnC5c0XcDyyCQJ2Ck2C/qJ+pt8M+gOLl8PH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KDQ4SJNo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dtUtIMGX7HLnZUV77fr33a6T2hxFbj1NQw5gxFIf5rU=;
	t=1730217770; x=1731427370; b=KDQ4SJNotZipjqFDiInCDVkzO0xXCRomY+VOyYxN6ko7bnh
	M0fsJ7RhflYPNOxvaICGcyuim5ofAtpg+jBQ29JCfOCPWZKbrqspJJ3rSUXHWF9Kfr7nJpuHS2/F+
	vmWRpxVPnohEtVVl7p+vL+9Wznv3RgITU7Q58K9/8DJof9DOxi63UMHZeCyBqFhy1T8NPvy/fj5QJ
	gst1p3rqLFtRjhaWCADcSpsqjCbX8PZqU10DerDroRX6T26KgwJ9gwrP6s+IU4l0a5nYTGPhe3IFL
	2xKSJaThspvc2wpDim1RXg/NNmBehTx8B88kgTLwACSQ/DwaIOrbz0fmsUH4eHPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t5ogB-00000008Mu2-2x5Q;
	Tue, 29 Oct 2024 17:02:47 +0100
Message-ID: <10ef9bc82600e0ee0ccf763b842f056bcb1e2fdb.camel@sipsolutions.net>
Subject: Re: Question on iwlwifi iwl_mvm_mac_itxq_xmit, possible busy-spin.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 29 Oct 2024 17:02:46 +0100
In-Reply-To: <9cfa23e6-3c4e-4c45-b6db-2148c9bdd2b0@candelatech.com>
References: <8dce89a1-350c-4885-afcc-0eda162fd76c@candelatech.com>
	 <1f6d998c16510426e57b774c42358dcef7a5cd31.camel@sipsolutions.net>
	 <9cfa23e6-3c4e-4c45-b6db-2148c9bdd2b0@candelatech.com>
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

On Tue, 2024-10-29 at 08:55 -0700, Ben Greear wrote:
> >=20
> > Not really? It should only get here from two places: userspace
> > (serialized, so you're not going to get to this point with two threads
> > from there), and the "queue no longer full" logic I mentioned above. Oh=
,
> > maybe technically a third at the beginning after allocating a new queue=
.
>=20
> How is user-space serialized here?  The comments in the code seem to assu=
me
> that multiple threads/whatever calling into this is expected (ie, the who=
le
> 3-state atomic counter).

Well mac80211, certainly serialized per iTXQ, but since we don't have
LLTX (yet) also through a single netdev queue.

> > I guess I could sort of see a scenario where
> >=20
> >   - queues got full
> >   - queues got not full
> >   - we kick this logic via "queue not full"
> >   - while this is running, userspace TX permanently bumps
> >     tx_request from 1 to 2, this decrements it again, etc.
>=20
> Considering GSO and KASAN slowness and highly loaded system, perhaps unde=
r memory pressure too,
> maybe upper stack could feed the txq fast enough that something is always=
 bumping
> tx_requests to 2 before inner loop can finish?

Maybe? But at some point the socket buffers are full too. You can't
indefinitely queue packets.

> > What thread is the soft lockup in that you see?
>=20
> I believe this below is the culprit.  Other threads are blocked on trying=
 to grab xmit lock on
> netdev and sock locks on tcp socket(s).

That seems odd though - it's locked up at a different place, and also
coming in from userspace - but that's serialized against other
userspace, and the "queue not full" thread can only run once really?

OTOH if it's deadlocked at that level you could get interrupted at any
level below...

I guess it's still possible that you end up pushing a packet down, it
gets transmitted, space becomes available, and then we run this again to
push more packets all while the original loop didn't finish? But that
seem pretty unlikely?

Hard to tell what's going on.

johannes

