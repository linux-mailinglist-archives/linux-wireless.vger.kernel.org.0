Return-Path: <linux-wireless+bounces-30565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D4D04A87
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117F6330B759
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1048AE21;
	Thu,  8 Jan 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JEiuPsr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234148AE2B
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876755; cv=none; b=CHWjhzq8YDUYHrVopsiP+ev+SXPz7e++NV7RCLX4lZWXJDS2ySrEJ9//FbYoGoOakyCSWptw4drmT6PGKqqf8FiorjN/plPzHovPunugHNhHI6EWJmEMgqAHi/GpJcrMC4bkhSAhInplvjMvQCrXqMkW5koXwcir5DTvjHquxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876755; c=relaxed/simple;
	bh=YUbNAMVvkKEXxxeP4e+YCkRxfEN254rgJ8OdxYqLh+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKKXSWIYYkMDQTKIvHbgYV6nurZawdaQZdZ2NQPvvabvbVAsbng9x3Nggh5rdHTkizQAemeTNCveFsePbW1SmNhjh77/VfYLenPBsOTwbzrh7yIchbw1FY7h6/TM9IeFVMaZgnQvppxSdCt+vFI0QLO28d+l6BVycR5WZ2ACsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JEiuPsr2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XrTJ5vkBrgjshnDoFVKN/JLXK3SxO4u/WDn6Mnnx6xg=;
	t=1767876754; x=1769086354; b=JEiuPsr2NiV/Sxwu002tjj7BWjm4V7ruRGlVnI81zv8jumf
	6ehR/k+WiTYizqTBm3edJj9xGYs6JS2u/lCqlfwk4o5JFJwLndcF+B8GP4zD3D6vgfREHCME5c9hV
	kcOSbqU6wwa9HzxxQPH7HPG6aw+H0RhbAM1Uo1NQqwwnoe5aUV8wHh0hgO+NJXckJD5zRP4xlxxi3
	7vKUnC+L/cqwQqoiW7sA4a2aCsqf+vFz0jmK2JkUeRVt/5e7k8JGMzWEE/nyKWyReFTNq8DNb2fej
	qTmsqu7HDM6svWwzaB5Ris2RNJYCfOVIzz58p0C5XTsckb5dmIAL4QZUEPakuoNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdpV8-00000006VVM-3oyQ;
	Thu, 08 Jan 2026 13:52:31 +0100
Message-ID: <5ff51b07b69284ca9b477dfcbe08890167c7ed14.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce computation
 for management frames with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Rohan Dutta <quic_drohan@quicinc.com>
Date: Thu, 08 Jan 2026 13:52:30 +0100
In-Reply-To: <20251211123612.2470117-1-sai.magam@oss.qualcomm.com>
References: <20251211123612.2470117-1-sai.magam@oss.qualcomm.com>
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

On Thu, 2025-12-11 at 18:06 +0530, Sai Pratyusha Magam wrote:
> Per IEEE Std 802.11be-2024, 12.5.2.3.3, if the MPDU is an
> individually addressed Data frame between an AP MLD and a
> non-AP MLD associated with the AP MLD, then A1/A2/A3
> will be MLD MAC addresses. Otherwise, Al/A2/A3 will be
> over-the-air link MAC addresses.
>=20
> Currently, during AAD and Nonce computation for software based
> encryption/decryption cases, mac80211 directly uses the addresses it
> receives in the skb frame header. However, after the first
> authentication, management frame addresses for non-AP MLD stations
> are translated to MLD addresses from over the air link addresses in
> software. This means that the skb header could contain translated MLD
> addresses, which when used as is, can lead to incorrect AAD/Nonce
> computation.

Make sense ... we translate them internally because of all the matching
to interfaces etc.

>  net/mac80211/wpa.c | 167 +++++++++++++++++++++++++++++++++++++++++----

This seems rather complex.

I believe the translation generally happens in mac80211 itself, in
ieee80211_prepare_and_rx_handle, couldn't we stash away the 18 bytes of
the three addresses in struct ieee80211_rx_data and then just
*unconditionally* use those, instead of all this conditional logic?

I can see the value in putting something only into the SW crypto so it
doesn't affect anything else, but also the address rewriting that
happens is pretty rare, so maybe that means we also have a flag there if
using the original 18 bytes is needed or not, but that should all still
be far less complex?

johannes

