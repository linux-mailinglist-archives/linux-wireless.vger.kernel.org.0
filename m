Return-Path: <linux-wireless+bounces-6063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932089EB55
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52409B248B0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 06:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDDA13AD00;
	Wed, 10 Apr 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pDwGiQuH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5B374D9
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732363; cv=none; b=qQwqZE/yPw7e/+fmobUqazRoQvi/78y+8xfrQt4zIfw5oQUBTqVzJVFPHdN3AgYp7Qj5fCmRphRv4NFRbTi5bkD1FWL7w7mKA1qsEDtxtuSZyUggXzaKBIA4Ozmx57LkKW5omQ82/kgqOWoxA9nubSwWc2mGeGudP7MEaYcBDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732363; c=relaxed/simple;
	bh=QsGKRacQhT1Zyyw5hH5C6x0DL071LopwfNI1iyVTAZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p78KvsUH98CP2TPEdifctYEj7afmpJ1JZ7OcQ6qY/uE3tYtro1j3WVkN8GdgH6HyOzT/4hE5WT1/IS7ZGIl0O2pSFjQ5hihRZwXV2+rDJwJV2YuIsW4PvJSTK5mVuBwnTEPAYw68qExEu4FCs4ylACfWQPWOtxPIBrNcyUonzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pDwGiQuH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4vrhE4tKbLahCAkQehQfWkPykNqCr9lzHvLBR7qefoE=;
	t=1712732359; x=1713941959; b=pDwGiQuHj3NUhrQ/nlB+FRK975DLvu/QmVdKWC5uKBZOPwz
	8O+016RkrQ9YN2UJ1qRxQoI+5948qTMqv9EZRheoF7l+RsEe6TDfzrtn6GGcbefExUdA8itUjTRyk
	Rs32cvj9HtYZk+bDB23WMX8bSPjuRmP9appHZXBm844ll68vnjTCzNS59cBS36617h6n710NEqmhv
	nWFPkaqFBQm/lCXJ2fSXW/XZx6cVlGojMiRpEUNz57zftMBDFoyXb++0nqNGk+AmJJ7ML9Yx36P5+
	MqODvXq7ZS6F5g1QE3kOKaHZgkdDk+23P2UjXQMjCGaQ2/UYMPqRVe2J2BF+sE+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ruRvH-00000001Ce8-3QgS;
	Wed, 10 Apr 2024 08:59:09 +0200
Message-ID: <1ab360a11f618ba16a3fb23f368c568f8ff57d36.camel@sipsolutions.net>
Subject: Re: [PATCH 06/13] wifi: nl80211: send iface combination to user
 space in multi-hardware wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, Vasanthakumar
	Thiagarajan <quic_vthiagar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Apr 2024 08:59:06 +0200
In-Reply-To: <13bbfe51-5a91-3c67-9b11-2f30a43f38ff@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-7-quic_periyasa@quicinc.com>
	 <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
	 <14909268-53de-a686-eecd-443ce153c756@quicinc.com>
	 <13bbfe51-5a91-3c67-9b11-2f30a43f38ff@quicinc.com>
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

On Wed, 2024-04-10 at 09:40 +0530, Karthikeyan Periyasamy wrote:
> > I agree, more duplication. So we have to have the per_hw_comb_attrs
> > defines like below?
> >=20
> > enum nl80211_if_comb_per_hw_comb_attrs {
> >  =C2=A0=C2=A0=C2=A0=C2=A0NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
> >  =C2=A0=C2=A0=C2=A0=C2=A0NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX =3D
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NL8=
0211_IFACE_COMB_NUM_CHANNELS + 1,
> >  =C2=A0=C2=A0=C2=A0=C2=A0/* keep last */
> >  =C2=A0=C2=A0=C2=A0=C2=A0NUM_NL80211_IFACE_COMB_PER_HW_COMB,
> >  =C2=A0=C2=A0=C2=A0=C2=A0MAX_NL80211_IFACE_COMB_PER_HW_COMB =3D
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NUM=
_NL80211_IFACE_COMB_PER_HW_COMB - 1
> > };
> >=20
>=20
> @johannes Berg
>=20
>=20
> Any comments on the vasanth suggested approach ?

Think about it, do you have any comments? I mean, you've _already_ sent
an email, why not actually say something about the topic?

johannes

