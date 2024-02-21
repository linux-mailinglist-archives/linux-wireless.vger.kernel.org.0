Return-Path: <linux-wireless+bounces-3848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CD85D34B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 10:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFEA28541A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B03D3A1;
	Wed, 21 Feb 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kSKFmVBV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B43D386
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507188; cv=none; b=riK52Vi8TMdde15gc2VFmCb2AqRzJAbQWRWdLOsTkzzpV1dxT5kAQiUzMjGwyhDptQK3firJPy0px5JNckCjH3sBT/gYSxSoQrKVktLXu6SHgJPEDYkpiSFLED6qnNipWopXxDNFbToJal56znhcYyBCNN6RfjuVlg0iXq4/okI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507188; c=relaxed/simple;
	bh=aC5ixQCimMcAZfTUl+FvKCOJBEuX5/HLpzDRbIz6xjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gxJBOQrVTxKajdITAYegt7a585y0IXFLh/w+Umhz7rTIIRPvA3uLY8M/5hCDdYkSyTvz5GkrMvZcCykz61I9j+5Ia+QCao24v+Yp7q47hKU74MRTmoVNCgm6tY4aLUFB09ASM31HkKeLYwPkZ3cJkMKnKE5Flnjre00hYTgoloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kSKFmVBV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aC5ixQCimMcAZfTUl+FvKCOJBEuX5/HLpzDRbIz6xjg=;
	t=1708507186; x=1709716786; b=kSKFmVBV00nln0IsdsAYG2h7KslqYM200a/6m9IHFUyRcBI
	4TovqPNeSZ7Ky4wESmc3i4kEED6eULzCvXX9nM9q5FGWORPS5YvTgKitlWPSlqDj1KHPmJqKuN7C2
	nPNFqd7zxLT/TFHGjlHKshx6GSjXw0zCcyp9NbMxxNHEzV4z3VrFli6CaBZeAlKloCJNGfv7gpp5L
	gHexrwnYRnFtwiuTetXpUzXa3tGQO+V4aLhQ8AHHBM6IMQUc+ttvhSVxLxr00MJJ5Men9h0dSwL/B
	eCLiz0aMBnK4rzRxPcwhRb2rmITaCLTIXKVvmLZWeii6FW/Vk4iLpEf+PtEkZW0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rcilQ-000000028dU-0DvP;
	Wed, 21 Feb 2024 10:19:40 +0100
Message-ID: <8c9ed8e11060274f723b88f1300b2948b889f22f.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>, Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ryder Lee <ryder.lee@mediatek.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Felix Fietkau <nbd@nbd.name>
Date: Wed, 21 Feb 2024 10:19:38 +0100
In-Reply-To: <abd0dbbc9d174ffbaae4e0b34d65aa06@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
	 <00094ae0ca73461c88799c070ad9b55a@realtek.com>
	 <db8508eddbeb78bb59671b8c453588428e16f27b.camel@sipsolutions.net>
	 <9d3bea8152fe49278fe9804167ec8871@realtek.com>
	 <08a989730bbc456df481aee8ae278a5cd9b35f85.camel@sipsolutions.net>
	 <c0f3930196504d2080907c12864493d8@realtek.com>
	 <64d1af77e7392aa14a90273d4004dbc23a4ec8ed.camel@sipsolutions.net>
	 <abd0dbbc9d174ffbaae4e0b34d65aa06@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-02-21 at 09:17 +0000, Ping-Ke Shih wrote:
>=20
> > -----Original Message-----
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Sent: Wednesday, February 21, 2024 5:00 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>; Aditya Kumar Singh <quic_adisi@q=
uicinc.com>
> > Cc: linux-wireless@vger.kernel.org; Jeff Johnson <quic_jjohnson@quicinc=
.com>; Ilan Peer
> > <ilan.peer@intel.com>; Jouni Malinen <j@w1.fi>; Ryder Lee <ryder.lee@me=
diatek.com>; Arend van Spriel
> > <arend.vanspriel@broadcom.com>; Felix Fietkau <nbd@nbd.name>
> > Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel =
switch on link basis
> >=20
> > You _could_ also actually just implement probe response "offload" in th=
e
> > driver, then you get the template from hostapd/mac80211, and that shoul=
d
> > come with the offsets to fill in. Might be easier, overall.
>=20
> Agree. That will be easier. What I only concern is hostapd can still work=
 well
> without probe request, which is dropped by driver implementing offload.=
=20

That's what happens today, so yeah, that should work?

You need to not answer&drop certain P2P probe requests though. But since
we're talking about this in WiFi7 AP context, you could just make it
different depending on that, I think we get the templates all the time
in the kernel and just ignore them if not handled.

johannes

