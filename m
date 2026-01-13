Return-Path: <linux-wireless+bounces-30744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0694D187AA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 12:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0688D3008881
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580438A711;
	Tue, 13 Jan 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sswW+qVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A612352F90
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303612; cv=none; b=NwNgOZScFWGVO54o64GJeMRaMWdNJT0uSg9e5IFwr+xa1xn1DyhFstj4oMlrowGJtRy8SluqnHqLwWHlh/GbRPc28DDciPW2Zmzcno6vnvgyG+bxBdYIi/xLbATeL+JvWYOUHiseTF3ygcSh9ybCHCeWUHMqzupgcbDw7KD3BnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303612; c=relaxed/simple;
	bh=QrKbveT7vmt/y5MphIP6Ts/litdIn8GeoxwVt/E8cgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSbnFd3yE5SdfPgi9oSYCYi3G7HmfgzaC8cR0ptzaePja5/D7n/vkOFNwVoWpFKiIm4CSuXJ/0UdHE7DPqHjGJWGseHdkqGYEQqbHQe5F+/TPScZVY8TrApXAl4jhr6ozVTlCEVn6Wao+Q0ML11z8GAxs363CSdqOONAK25YyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sswW+qVT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QrKbveT7vmt/y5MphIP6Ts/litdIn8GeoxwVt/E8cgw=;
	t=1768303611; x=1769513211; b=sswW+qVTaVmjgn6n/EC4UiIW9abUWgofEd1pueb6qz9IAnU
	gmFYgfpL2M1eIt08CjPLfLqocBch/w8Amtwh5P8Dp4BvWd1NAbLv+QEOeJ5zCNGVCTPRgso7sDt5l
	RP1xft690HoWiU8fZJtzBZRyDJFQ9FENEHUZPm42L4r4hqAuoUvH05j4NFTJ4M8RaBlXsFV6Z9mgJ
	Ee9Kkdb65JECf0IAiqW17+8RwSra8+HjIWGP/paLusraKEUWU3uPCXUYjlLzFy/222oS9lJFfb1Wl
	aDz3agkLWhKRb95l18OdGZgR3Bw7UJ982H/S6F+W/YkWiZFm+riHYrpWhyTm6OMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfcXv-0000000AjqN-36DJ;
	Tue, 13 Jan 2026 12:26:48 +0100
Message-ID: <f2292ae64dc0da7e68e025a13327270d4a65cd87.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 4/9] wifi: nl80211: Add new NL
 attributes to support (Re)Association frame encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>, Kavita Kavita
	 <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	quic_drohan@quicinc.com
Date: Tue, 13 Jan 2026 12:26:47 +0100
In-Reply-To: <036322aa-0c90-4735-88cf-76fa831a9ec3@oss.qualcomm.com> (sfid-20260113_050745_660998_F8C7BDF5)
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
	 <20260106152503.223216-5-kavita.kavita@oss.qualcomm.com>
	 <16099966d1cbdccc5160c6aa7a2615dcfd0060d6.camel@sipsolutions.net>
	 <036322aa-0c90-4735-88cf-76fa831a9ec3@oss.qualcomm.com>
	 (sfid-20260113_050745_660998_F8C7BDF5)
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

On Tue, 2026-01-13 at 09:37 +0530, Sai Pratyusha Magam wrote:
>=20
> EPP flags contain the negotiated per peer Extended RSN capabilities.

Sure, but why?

> 11bi Specification has introduced many of them as per IEEE=20
> P802.11bi/D3.0, 9.4.2.240. Since few of these Extended RSN capabilities=
=20
> are driver dependent and hence need to be communicated to the driver for=
=20
> future use, which would subsequently be implemented.

Yeah but the existing ones aren't used?

> In case your guidance is
> to remove the epp flags since only one is used((Re)Association=20
> Req/Response frame encryption) currently, I will do the required=20
> cleanup.

I guess? At least right now I don't see why the ones you're adding would
be required. And "driver dependent" doesn't make sense for peer flags,
they're clearly dependent only on the peer. Something doesn't feel right
to me here.

So yeah, I'd prefer if the flags are removed until we have a clear use
case. The "is it EPP peer" flag is clearly needed, but the other two at
least right now aren't used and don't even seem useful, the ".1X over
auth" seems mostly of irrelevant if we have an ability to send arbitrary
auth frames anyway, and the "is it assoc encryption" seems obvious if a
key is installed, so I don't even see how they _could_ add any value to
the driver or anything else?

To some extent it _feels_ to me that you're arguing they do have value
to the driver and I just don't see it, but then can you please explain?
Or maybe you're just arguing "we may need flags in the future", but then
why add the two unused ones now?

johannes

