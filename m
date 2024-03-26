Return-Path: <linux-wireless+bounces-5294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4BB88CC13
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75C51C397D1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4553127B53;
	Tue, 26 Mar 2024 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BIKoROEB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0186366
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477980; cv=none; b=p+Ljtja7l1Po1/VbQ0NN8fTRegiRHHIlRZ6uztGPEaZ+GiAoCXnQUfJk+LUUmzyVPVQCLzTKPU2pYQFHV3fbs/hGJvFyAa0iD2bsLVGA11i8Q7NwZLTH4mLbqjdNrzAB0eKbf65fFFiDAbbErHd0rPBWWcD/L7ZZf/qfHnqSI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477980; c=relaxed/simple;
	bh=4D4fEDCvRg6sOC5qGrHWBNcYawItwTloAEkB4y21Yuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8GyWezYc52PpD81qwTx9VTPZe2PFiR2tsbGWXXgE3s7fzwrqOizEjGPu9kcS4k634iUVph7uhRbTzGbIAOeoVI/PCz7s2mRLWALX1yac03MiiIn6aSdKlONA6khr1835Dyw56FyENz4z24cSl1KaS9Fyp54kFEdTL9MgTFS538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BIKoROEB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v/2CwER7eN94A/ZCQZv0fy/PugSq6elQ9dUZaLkyi4A=;
	t=1711477979; x=1712687579; b=BIKoROEB1CohKtQHa+IRq2x8ZSVDXE5yw+uFTuDrgllXAUa
	xoKPJrKy170XMUCgGR4rZ2hOLJbXEbg0KUNBkF3sXcdc5mgNtdFFJVIu8RrCRfPrKLRxsKBQy/UA7
	ur97jYLLLxE72UT5pmRGSm1UtLDQgS2DIPLMFH7Y01u42+J3ti2Q9mxo6nNAAi/pzXQMNMKzEXuys
	lOlvpcNxEHvN6eZHyqE/kQXNKfWzuvCqEK17WYMYD0k+haZaKWyXM4hRO73hc12QP9IyPunEJHkoe
	3OQlaUXttmENmU+yJDc6UmEQ1rwpoSN/KA3yTZ5ClLKcZBFgMVmDkolCE3vzw22Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpBbO-0000000Ftbs-1wiK;
	Tue, 26 Mar 2024 19:32:50 +0100
Message-ID: <a313c313ab41325843092dc8445386dd802ed115.camel@sipsolutions.net>
Subject: Re: [PATCH 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
From: Johannes Berg <johannes@sipsolutions.net>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 26 Mar 2024 19:32:49 +0100
In-Reply-To: <b4fb2e9f-b7af-42da-be97-9ae1560ebad2@quicinc.com>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
	 <20240325201031.10837-2-quic_pradeepc@quicinc.com>
	 <8efc258b698acd504c1fc699d026b906bf383894.camel@sipsolutions.net>
	 <b4fb2e9f-b7af-42da-be97-9ae1560ebad2@quicinc.com>
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

On Tue, 2024-03-26 at 11:31 -0700, Pradeep Kumar Chitrapu wrote:
>=20
> On 3/26/2024 6:00 AM, Johannes Berg wrote:
> > On Mon, 2024-03-25 at 13:10 -0700, Pradeep Kumar Chitrapu wrote:
> > > Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
> > > to pass EHT MU-MIMO configurations from user space to driver in
> > > AP mode.
> >=20
> > This ^^ doesn't match this:
> >=20
> > > + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception=
 (AP) or transmission
> > > + *	(non-AP STA) of an EHT TB PPDU on an RU that spans the entire PPD=
U
> > > + *	bandwidth
> > >=20
> >=20
> > which doesn't match the implementation ... Wouldn't be a bad idea to
> > actually do what it documents though, I guess?
> >=20
> Thanks Johannes for review.
> can you please help clarify what you meant by "actually do what it=20
> documents"? This will help me to amend next revision appropriately.
>=20
> I have tried to describe what this flag is trying to represent.

Yes but ... you document AP and non-AP STA, but only implemented it for
AP?

johannes

