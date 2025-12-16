Return-Path: <linux-wireless+bounces-29817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F3CC43F9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95A9630E04EC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796332DA76F;
	Tue, 16 Dec 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pmokieHy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C128CF6F
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901853; cv=none; b=NreuIl4/jImVHtpI/Km00efapgf13+NiiTplFbLjwik+TK7rQCkl4yK6ZvW8Y/+bcAUB4nKtNfkYvQEglgE+wLvp+rvJZj8l9/uNAjVufgWlnpZyQRiaF60a/nZ7hQNm66BDYXEeFfFvfWgZRyzZyWre+KBNGBFv6SDS2kfKcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901853; c=relaxed/simple;
	bh=fTuXKcXWHAyKwANqrHJydldxJfXLpDPsAvlXGi/2H1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHi/vRIkfxHELeR8XL0WwaWt2VS4kT2RfMdrv2AXOyzTzP3GRZ52sY17hX5DtH+vqSyIhinsyYsIpWE5JZDvi3wUSzb3oD9t8kVYGQ2I8lMuLFNxG46jTMNhbDaydA4gL1TEHtj1rCedfQQIvo5rRdq9RY3NiOceAW13IZmbmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pmokieHy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fTuXKcXWHAyKwANqrHJydldxJfXLpDPsAvlXGi/2H1Y=;
	t=1765901851; x=1767111451; b=pmokieHy5kNAlStAPRBt2mj9PxtNHmwQ82Fr57ZzHRGvzgb
	eLYJ0/k6LdkwnKwcZViCcFBa32lhZh6Udto31V1mOMuCxsZ4jwsi2lnCsO8aFNvgnsijlj6OiQfPS
	dZENXrhDyycCrg/4TDpmgn4x1qtMMynX2iH79B3onh8zWRJk9Uj74uxig1peQuP5AHdDbs+AFHfOA
	FqOypL+mpncnCSet4T0am0H15o1ukHbfClzfs8EVVhre3q2uRDsZ2GJfjByjqFA/l83WELhPuDhHx
	AJAjZjfT9+MaVGqZVAE8XgQEtY5IhT6fq150Ufw5Znb0no6YC+6Bvli/SSSiROUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVXjr-0000000Aa6U-3n5u;
	Tue, 16 Dec 2025 17:17:28 +0100
Message-ID: <3482331e71f5d2caed9a7e512062ae6ef916fd06.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 09/14] wifi: mac80211: add MIC generation
 support for EPPKE authentication in non-AP STA mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Tue, 16 Dec 2025 17:17:27 +0100
In-Reply-To: <2ab842f3-bcc2-409d-837c-5635e5e3feab@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
	 <20251211124051.3094878-10-kavita.kavita@oss.qualcomm.com>
	 <438a3bf3725c66615fb2a9922845a2bad0245993.camel@sipsolutions.net>
	 <2ab842f3-bcc2-409d-837c-5635e5e3feab@oss.qualcomm.com>
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

On Tue, 2025-12-16 at 20:43 +0530, Kavita Kavita wrote:
> We initially followed this approach because the MLME resides in mac80211=
=20
> and,
> in client mode, the final authentication frame is prepared by mac80211.=
=20
> Since
> mac80211 was already appending the MLE to the authentication frame, we=
=20
> assumed
> it would be cleaner for mac80211 to also append the MIC element, rather t=
han
> having userspace append the MLE.

Yeah, it does that, but really mostly for no good reason I guess. For
MLO connection we can't even do it with a non-updated wpa_s, since it
has to request and be able to deal with MLO too.

> However, we=E2=80=99re fine with the approach you suggested. We can move =
the MLE/MIC
> handling to userspace instead. On the mac80211 side, we can simply check =
for
> the presence of the MLE in the authentication frame, rather than
> appending it directly in mac80211.

As I see it, the only requirement is that we implement such a check
before claiming EPPKE support, so that it all works. Which is totally
fair. Since today wpa_s cannot add the MLE, we can implement a check-or-
add behaviour today since the check will always say "not present".

On the whole, I think that's preferable to having the crypto code in the
kernel and depending on specific kernel configs etc.

johannes

