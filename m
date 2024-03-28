Return-Path: <linux-wireless+bounces-5474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD218904C7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8671C29C4F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AACA131BA0;
	Thu, 28 Mar 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E5ja7GWY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576513172F;
	Thu, 28 Mar 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642664; cv=none; b=PIt6WC2ZAUanugKqk8stwDTH2uPHHIeVa35yVHuWg430jSZeMBYtv6FScprbaHiOG0n2ty1fzBoesLF4AzFGIs4y147zwtL56Olhb8iJRIHQeI1KMCG8VZCcm+Ct/ksvXWxQukNG8Zc/o69SFgoQrS8+bvmu5FAYyhOPOZ1LcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642664; c=relaxed/simple;
	bh=3bEh8pMuO7/YkXZZAvcj6nn2I/pQdQYEtIYGN/UIft4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0L952mlXrbGm+xAf/v3p3dtWZlywfaEoyBZE7ctRZ6MtZi+MfL0+e5tGMTGc9qO579MpEu5hF2cH+Nsb1N6d7Ma1Au3jAyVCvoCnh73ZcLhwOxkRWTZJXp/bjV1A/mEjoT0wijMz0Kl/qSAcRKqRLxfVDB7gV/32DTVEjMF/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E5ja7GWY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3bEh8pMuO7/YkXZZAvcj6nn2I/pQdQYEtIYGN/UIft4=;
	t=1711642662; x=1712852262; b=E5ja7GWY06L1i4KIPMMyCLwn2ZFX1CIaKl7152iYQai7/fh
	RG9hRS42tu9cC74lRRR783RFSNrsEf+vUISd4WMWLjRzCWBYXJNvnU3S9ifF7liKTLupv9yrV94lH
	D9ZZCDTF2U5zUuRykNzW9XjMv7X8yk1LZtJu9AxACiSxpaXxvuZNaxc5K0ibf2xaYp/L/QgodxuQE
	txc6SgwDnPmkihO5o8/z1DWurq7FK+uwlGv4/VJW3GDA7LKI1bLwKYJ9IJA2ylmG6sKYKyV/P/dXw
	Xy0PtDAt7RVJfxkyZJg0SoVnffBA0EHn+5PQwu6vNECumJj7nMZTeDrlGDyBG4Ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpsRe-000000017mB-17cw;
	Thu, 28 Mar 2024 17:17:38 +0100
Message-ID: <3cc984766a2cf1452ac44054cd736c913c356469.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Karthikeyan Periyasamy
	 <quic_periyasa@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org, Jakub Kicinski
	 <kuba@kernel.org>
Date: Thu, 28 Mar 2024 17:17:37 +0100
In-Reply-To: <2b5fdc14-85f0-48ba-9797-c1f43ecab86e@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
	 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
	 <14b739c9-18da-0d58-b58d-cccebc505950@quicinc.com>
	 <3f61f18fbf3372ff88da54cdfbd309e74b2aa4e9.camel@sipsolutions.net>
	 <2b5fdc14-85f0-48ba-9797-c1f43ecab86e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 09:14 -0700, Jeff Johnson wrote:
> On 3/28/2024 9:09 AM, Johannes Berg wrote:
> > On Thu, 2024-03-28 at 20:40 +0530, Karthikeyan Periyasamy wrote:
> > >=20
> > > Can you point to any attribute constructed in this way from kernelspa=
ce=20
> > > for the reference to explore more ?
> >=20
> > I don't have anything directly, looking at the code finds e.g.
> > devlink_dpipe_entry_ctx_append() but honestly that's really quite
> > trivial, it just adds that new attribute while iterating whatever list
> > you have.
>=20
> Note that we are trying to maintain the same structure used by the curren=
t
> wiphy global advertisement since we actually refactor and reuse the exist=
ing code.

Partially, yes. That's not true for the one I was discussing _here_,
notably nl80211_put_multi_hw_support(), however.

It's partially true for patch 6, though even there
nl80211_put_per_hw_iface_combinations() doesn't need to do it that way,
since that's a whole new attribute (NL80211_IFACE_COMB_PER_HW_COMB) and
can define the content anew, as long as the part *inside*
NL80211_IFACE_COMB_PER_HW_COMB_LIMITS remains the same to be able to
call nl80211_put_iface_limits().

johannes

