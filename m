Return-Path: <linux-wireless+bounces-29718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8118CCB8D38
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 13:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50C4430A6010
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8389B1DC9B3;
	Fri, 12 Dec 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="reg1v19K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD529A2
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543559; cv=none; b=BpkujV5J/pZr8V3/ggdkX99lrxQxI91dvCRkZ9WKsxqd75iXWeeRVRfOdbDux64y4GZpevYAhLccIB5l2SJxAgwCrx9R2KTyObf3UJAMoRv/N31gQBKB17LTYgRfowCw9c+3ug9FjItCklbDl7pm5cSnzkh5xoj87nFS56NbFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543559; c=relaxed/simple;
	bh=AO1qSdiEH1qAnJxtcc1BLVcI/8G8WcBJV3GT9JV/ik4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C07QU+0fmdVX/Y57DR4+y4lPMc6eCt/iH1oWpIVgwbh3TTz1UNUAxoMRloi5erjxJLBFCfH/gMDu4XVBViGz0s6UPP1x2Up0HjBE6v6OP9gBfqWUL52/3vIpMQqAKKachF4s9Z1VFDVwVT6hU5rUci2fO7EFqT5mFN251jncqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=reg1v19K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AO1qSdiEH1qAnJxtcc1BLVcI/8G8WcBJV3GT9JV/ik4=;
	t=1765543558; x=1766753158; b=reg1v19KG67dwYefDGiWg+mHAhDo6W2nNog+Ib7VFmudsA3
	kIrLYnj8pc0GkmViO4N1Su/7qlgcYI6ZvLLxSbDCGGRU1XMK4kIwWalIQc/HxO6ER5YoePhKdiyUD
	05dZHSxpDN7UtOKsAOdgNtYyTQG3zvYgD8tZRXxMBniG445rhYz1JvEMnufAmfemh4GsiAlAtCoXB
	/xf7y+ta6fQJhfjfqELtg4t+lWWVmdnF471vnmcUAVeV423zKBYNHEtf3bYBeJ1XyJOseeXvxvDuk
	ABr05LU80ktpnvHfRslFk0/+9BB1EiyQ+cUgqRN10/rSHwNyC026CH7EK8h557Sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vU2Wv-00000003Une-3egr;
	Fri, 12 Dec 2025 13:45:54 +0100
Message-ID: <ae7514eb20734bacba9e617791978b1b891f3ee1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 11/14] wifi: nl80211: Add new NL
 attributes to support (Re)Association frame encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 12 Dec 2025 13:45:53 +0100
In-Reply-To: <20251211124051.3094878-12-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
	 <20251211124051.3094878-12-kavita.kavita@oss.qualcomm.com>
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

On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
> From: Sai Pratyusha Magam <quic_smagam@quicinc.com>
>=20
> Introduce new netlink attributes for the userspace to indicate
> following to the driver in AP mode:
>=20
> A new netlink attribute NL80211_ATTR_EPP_PEER for NL80211_CMD_NEW_STA
> and NL80211_CMD_ADD_LINK_STA to indicate that it is an
> Enhanced Privacy Protection (EPP) peer.

Seems reasonable.

> A new netlink attribute NL80211_ATTR_EPP_FLAGS for
> NL80211_CMD_SET_STATION to indicate the negotiated EPP capabilities of
> an EPP AP and an EPP non-AP STA

You don't use that.

> The Extended RSN capabilities for EPP that an EPP AP and an EPP
> non-AP STA can negotiate are as per "IEEE P802.11bi/D3.0, 9.4.2.240"
> (RSNXE), few of which are driver dependent, hence need them to be
> communicated from userspace for later use.

Don't follow?

johannes

