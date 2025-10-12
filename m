Return-Path: <linux-wireless+bounces-27946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE3BD02F9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 15:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1133D3BC1A7
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C12737FD;
	Sun, 12 Oct 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cFaeUfhZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3A2741CB
	for <linux-wireless@vger.kernel.org>; Sun, 12 Oct 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277582; cv=none; b=JZ9wXegGSXC5xzhqwE9KlYLD5pY1a6z4jR8bf3PQR6m3mO+RopRgi12WHzec57caCtJsAsvsgddqtmF1CWGOQsNJjm9D/UOyClLqVHLCwSpzN6qBC/ruaengrxPH3hiIcib0fZSFBy32W3Ns8YYgEa8uHTyFznJv24ANfUVOEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277582; c=relaxed/simple;
	bh=G2x4pWvUiFVWFG2PcNA4gws3V9CjQUeQbG4WlfjZhXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0jawcZFUyhFMaAzNmasNvNMEh6OqvbuRiy+alSPMOgbBNg4vj0Jm45uYUwAnGg+bvDP/enLKlP53/mZzbuNGWgcUWVUrD0w+e+GP3D5OoZm+OV4ZPHNd8aMBEttbeaz4Mk33uJLI+iagj97TgjIA6MGIZVSvMsZ00pU2Z2RQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cFaeUfhZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rGMyGxMjkQ+b3vCIVngK9ivzNaspS3b1SY6lwz20Bmk=;
	t=1760277581; x=1761487181; b=cFaeUfhZXIir1JJ5A/QuvpAEILKWrGRVs3nmKNfpWiwMQe7
	ZrvH/f3Cfo7MEexnqain12nZtQ/DNSNaPQxNioy7sJP2AIcf3zS2jGwLCbNB/mBcqxckRefI18osn
	X5GJiFmJkP5b3TSZOGC41AJ2wxdgj1EP3yj316ctWwBErwNMdkAzuA9/9+qfSGene11Ipohb3NODA
	xhsUNmdoV39VDxW2KXUEHi4CYmk2uwumGzFvub6HUiwi7ld1btWJQq1rDpPK3bLyTng7K4Gyg7Q5u
	3z4/XMvfYvGv7pp/8HaQamF/yMgykwkS4Qm+6nlOoQPlgWfX4d2UOVOYECvV54Uw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v7wbo-00000008FIA-3lws;
	Sun, 12 Oct 2025 15:59:37 +0200
Message-ID: <30403bb70a2a017c90b1d4a5a1a07514bb670822.camel@sipsolutions.net>
Subject: Re: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8
 Seamless Mobility Domain (SMD)
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Sathish <quic_asathish@quicinc.com>, ath12k@lists.infradead.org, 
	hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Sun, 12 Oct 2025 15:59:36 +0200
In-Reply-To: <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
References: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
	 <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
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

On Sun, 2025-10-12 at 15:51 +0200, Johannes Berg wrote:
> > 	DL/UL traffic transition latency to the target AP MLD depends on the I=
AP
> > 	messages and the ST Execution Response arriving on time. Therefore, th=
ese
> > 	actions should not have to wait for pending management frames to be ha=
ndled.
>=20
> A good part of this argument - "pending management frames" - really goes
> back to hostapd's architecture and single-threadedness, but really I
> don't think "hostapd's current architecture implies more latency"
> implies "we must put this into the kernel."

Continuing that thought: I think that hostapd's architecture currently
leaves a lot to be desired, in particular around how MLD works, and
obviously, at least to some extent, being single-threaded is an
architectural advantage in hostapd.

However, user space also affords far more flexibility than kernel space,
for example some things could be written in rust (with its "fearless
concurrency", which I can attest to), split out to a separate thread or
process, etc.

Anyway ... I guess in a way I'm using the opportunity here to lament the
lack of architectural work in hostapd which isn't necessarily related to
this, but I suspect that had hostapd historically had more architectural
flexibility we might not even be having this discussion?

johannes

