Return-Path: <linux-wireless+bounces-27606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0AFB951B2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 11:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7631F446730
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9934A21;
	Tue, 23 Sep 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hvp/Jxqm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236D30FC04
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618057; cv=none; b=NCPrUBVHtn6327uE6oeyDqHusxAll6T8D5BtAr1jKWQZ6AhqWSapiVEjUp3JDmt/VRxN9D/uOK36rB1ymgpT902K6sNVlTiXHQLbbzbp72TWtC7rBe5H8T9jXprvVtfsndy2NzuGEzq5IBsG3hiNEHt4jYHGjPZf2cwUQ8O7Ook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618057; c=relaxed/simple;
	bh=sRfg5AFLXBeZxrPkGOHM6xOS6q8lO66begeDzWc4OKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhFSADH56r3twKwtPpwUNzB5uLEHxRy+VGo+aNi0s1zmkeOqTxr/sZ9HrkHiO6Wh2rMa1jDuWMUcPsdR/2/wDm0L3YfpLYToPBTZopr7xRIZ0SDxuYTOn39g0uQlgLVOrdauQc4qLG9VMCsRUfFB1MOnDjHljGuPik9nEu9IfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Hvp/Jxqm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sRfg5AFLXBeZxrPkGOHM6xOS6q8lO66begeDzWc4OKU=;
	t=1758618055; x=1759827655; b=Hvp/JxqmxerRlBBfXDu4lWRfG2Fs3J3wCLDFt6xhI8kgYMT
	vEE1kkiy8KxfirjZoVRVPeQNSUlquAEVPxC5ivMaXVqhNvkM8wom+HKavzbRRp6QvvgUaOFLfwISN
	ockiuAlVxffGfFsJxz6wtG2cQc2iGyxpJKrp2zk562Yb38XNX7iMQYdyhl7JBwgN9Sfh2AXWNn/s/
	lU7iYSXgGpKichmy6Mp6rcnHb2Mftb0dMOn06LCtlIEIRZOZbZKiIv+x8sy88okXtt4tIDgZgIniq
	mKBjbtpYWI5Lv5Uyzp6ro4RKxouuSscxnVumc8HcuxWJ/VcpO8+/+C55yBQ8g1eQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v0ytG-00000006FB3-3Soe;
	Tue, 23 Sep 2025 11:00:51 +0200
Message-ID: <fc58639b6e910e93b103cb8abcf2a5edefa70913.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 0/3] wifi: cfg80211/mac80211: add
 support to handle incumbent signal detected event
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Date: Tue, 23 Sep 2025 11:00:50 +0200
In-Reply-To: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
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

On Tue, 2025-09-23 at 13:05 +0530, Amith A wrote:
> This patch series adds support to handle incumbent signal interference
> detected event in 6 GHz band. When an incumbent signal is detected by an
> AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
> vacate the channels affected by it.
>=20
> Driver is expected to call the newly introduced API with required
> information to notify the interference detection. This information will b=
e
> ultimately sent to user space via NL802111 command. User space is expecte=
d
> to process it and take further action - vacate the channel, or reduce the
> bandwidth.

I am wondering a bit whether cfg80211 should enforce some AP behaviour
here. Like marking the channels as incumbent internally and stopping
the interface if userspace does not vacate them within a certain period
of time.

As-is, userspace seems to be able to simply ignore the event or
misbehave in other ways and cause an incumbent channel to be used even
though it is prohibited by regulatory rules.

Another question may be whether cfg80211 needs to verify that the
driver/hardware is doing incumbent signal detection before it uses
channels that may be affected.

Benjamin

>=20
> Aditya Kumar Singh (1):
> =C2=A0 wifi: mac80211_hwsim: add incumbent signal interference detection
> =C2=A0=C2=A0=C2=A0 support
>=20
> Hari Chandrakanthan (2):
> =C2=A0 wifi: cfg80211: add support to handle incumbent signal detected ev=
ent
> =C2=A0=C2=A0=C2=A0 from mac80211/driver
> =C2=A0 wifi: mac80211: add support to handle incumbent signal detected ev=
ent
> =C2=A0=C2=A0=C2=A0 from driver
> ---
> Changes in v3:
> =C2=A0- Removed the workqueue mechanism in ieee80211_incumbent_signal_det=
ected(),
> =C2=A0=C2=A0 exported the cfg80211_ function that sends the NL80211 comma=
nd and called
> =C2=A0=C2=A0 it from ieee80211_incumbent_signal_detected() directly.
> =C2=A0- Renamed nl80211_incumbent_signal_notify() to
> =C2=A0=C2=A0 cfg80211_incumbent_signal_notify() and removed the gfp argum=
ent from it.
>=20
> Changes in v2:
> =C2=A0- Updated the kernel doc of NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERE=
NCE_BITMAP
> =C2=A0=C2=A0 to include details of how it interacts with puncturing.
> =C2=A0- Rebased on ToT
> ---
> =C2=A0drivers/net/wireless/virtual/mac80211_hwsim.c | 33 ++++++++++++++++
> =C2=A0drivers/net/wireless/virtual/mac80211_hwsim.h |=C2=A0 4 ++
> =C2=A0include/net/cfg80211.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 ++++++++
> =C2=A0include/net/mac80211.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 18 +++++++++
> =C2=A0include/uapi/linux/nl80211.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 ++++++=
+++
> =C2=A0net/mac80211/ieee80211_i.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 5 +++
> =C2=A0net/mac80211/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> =C2=A0net/mac80211/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 +++++++++++++
> =C2=A0net/mac80211/util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 +++++++++++++++++++
> =C2=A0net/wireless/mlme.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++
> =C2=A0net/wireless/nl80211.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 35 +++++++++++++++++
> =C2=A0net/wireless/nl80211.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++
> =C2=A012 files changed, 215 insertions(+)
>=20
>=20
> base-commit: e3ac93e9d916ebae0711a42f524429dad89c4887

