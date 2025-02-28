Return-Path: <linux-wireless+bounces-19579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC1A499ED
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E391899BDD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7506826FDB2;
	Fri, 28 Feb 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tYci9Pm9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9D26FD84
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747054; cv=none; b=tMuTIc4nak7ZXWpEthYXBSKfWY78Lc2M7N3QP4IDNGe0OzAy5kpbT7RAhKG0C5T/caLSQvZiTzQygK6s8MuKDKbQKJ6eTtfSQPfSDusS4M74KS157/gR5vtmXGU2+H0/ECklTtqZnToWU4lPfja7PVBQ++mbsaxn1ex7UhpG/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747054; c=relaxed/simple;
	bh=CN4rin8WqANXwaswqyZbu1wwfR5z8XHqsLMKwBO/EMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZG6DXZjEMza0C0hVgWJDsYyE+NYMQXdMnmpexBg94kO01qnrigd6NaPXKktlRu8ydpphLwrd1D5BdrVkoZ51gql9qBK246P7w5Tn+VJ3ZUdeZmIG9Me3FNTrgP8RA7eSXVdaaudnqxtFerIqREpZm2Weno5XcTMY8Ykl/852Qbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tYci9Pm9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7ReyW+DNUok9cd7QSjT+X/Cl+qVvFsukoAVHB7IhmtU=;
	t=1740747052; x=1741956652; b=tYci9Pm9BHRV5Q1X6VFdoLxtUTOrAQw4tZ38nMBdUP2cCBF
	Ip8TVe7g+zRHg2e0HYwVM7WSUrYOHsGUGJOIzLZwogkXoBiyMfTu4BV7B6vPN1t256pgBX5rEd/yG
	vfAUpiAwMutyT+GxKgSyfIXPaCU0AEEhpzd6E1TzaEYiRW+0KfZ4auqW+BcZ+E6USHttK7U8A7uMd
	mpvNCxLLopWVYu7JbwLe6Mdx8yXUf9FzP2eZSYN9Mql2AftoRTWE5G4rrvjR8CyQU8Zp+Xa3KJhL3
	dYGC6xG4/RtpNV20lhk5lrCCYTBYEI7Na3DXWtMv/DopgcQCgoSItjzakZibP0GA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnzpJ-0000000DjpY-1pNI;
	Fri, 28 Feb 2025 13:50:49 +0100
Message-ID: <61c22a40a2b8bfe28175c2e7031b0a22fff2ca06.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: Allow monitor creation in
 NO_VIRTUAL_MONITOR mode with active AP
From: Johannes Berg <johannes@sipsolutions.net>
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 13:50:48 +0100
In-Reply-To: <20250123010950.1958211-2-quic_nithp@quicinc.com>
References: <20250123010950.1958211-1-quic_nithp@quicinc.com>
	 <20250123010950.1958211-2-quic_nithp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-01-23 at 06:39 +0530, Nithyanantham Paramasivam wrote:
> Currently, in NO_VIRTUAL_MONITOR mode, when creating an
> AP/STA + monitor, there is a restriction: if the AP/STA is running,
> setting the channel for the monitor is not allowed. For example,
> in a scenario with three supported radios where the AP uses only the
> 2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
> due to the restriction that rdev->num_running_ifaces must equal
> rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
> we are unable to create the monitor interface.
>=20
> cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()
>=20
> static inline bool cfg80211_has_monitors_only() {
> ...
>    return rdev->num_running_ifaces =3D=3D rdev->num_running_monitor_iface=
s
>         && rdev->num_running_ifaces > 0;
> }
>=20
> To address this, add the new wiphy flag
> WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR to advertise no virtual monitor
> support to cfg80211. This flag will allow the creation of a monitor
> interface by bypassing the cfg80211_has_monitors_only() function.

I think it would make sense to call this differently in cfg80211, per
what it actually _achieves_, rather than per the *mac80211* logic about
it...

> There is no need for special handling after this, as
> cfg80211_set_monitor_channel() will manage all interface combinations
> and allowed radio conditions.

This sentence just can't be right - you're changing
cfg80211_set_monitor_channel() and there's no more code after it?

johannes


