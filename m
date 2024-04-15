Return-Path: <linux-wireless+bounces-6327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D98A53A8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE501F21A35
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D0E763EC;
	Mon, 15 Apr 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D+5sr73E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88E76046
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191275; cv=none; b=bCmzZIHFcRYKeJxhZqza6BydJxq7iqSrBk01AEIUP1n0HdNoEiWbJERFvZnLU6o4hfAUlIQDbkiGhJKkjlaL3nl6ihrfrJRk6Xk1vdZ+5w27THhXaPDMaJvVKX1CXxqkPIwfaelLKOOqVUbBH9GocyoD7JSVUV4UgcsBYUwlX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191275; c=relaxed/simple;
	bh=yiIw0H+RddUK9ePj4qOpyB+aPGjI6w5qERhlb9Nfk1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCPHUv4gpENv3AHJcaZrOly0e/Q2mWKq94qrp2yOq/8B2G6S3GS64kkUbi98M7O5JZjsP/ytXE+rZPJYRgEVc6QYRM015QZgQpr3QyB1MirakhF/NPVaCx1Bq0b/PLG3snMTvmxu3whB9odd1cenT5JBAmeCLC+F1E/bkjTxLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D+5sr73E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HOqa0YfnR3nkXm1VRAGfM5py7wxw2EPMxlMmMQs0bZM=;
	t=1713191273; x=1714400873; b=D+5sr73EaF9YXc3+RPY1bRUhJI5GJttyOl5Zdya+CELiapJ
	0js+5L/+0OwQdOtHM/bT1SynWRgoQPn30V1SNZZau3y80fcgtZS/hQJ9tuBXc5K64FVxUQTuoYOGU
	pphLTIkz0PKHoDuVE+nBoT6z3K6R4NaeWz+VpzTe5W36BtS51pNQ7Lf/iZ8mc4okrxgkodO7AIDKQ
	lil/vMSkjwMFSiwqHGZV+kKmFpOKecLvd2zJtxjBbceyqRCqB1ov8zDAOfxT/hzcWsGOC4sRUtMKP
	iUiNyn7vj+WC2R5tDbQQbbqp1xc1EAD8I3mJfcr1C7hh7d5eAb7dxx87RR6SVWVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rwNJ9-00000007yTA-02Fs;
	Mon, 15 Apr 2024 16:27:43 +0200
Message-ID: <c58f318641ec2e836a23f8769eb32c67326643a5.camel@sipsolutions.net>
Subject: Re: [PATCH 06/13] wifi: nl80211: send iface combination to user
 space in multi-hardware wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, Vasanthakumar
	Thiagarajan <quic_vthiagar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 15 Apr 2024 16:27:41 +0200
In-Reply-To: <6147ac95-a572-62df-619d-33078d51ccc3@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-7-quic_periyasa@quicinc.com>
	 <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
	 <14909268-53de-a686-eecd-443ce153c756@quicinc.com>
	 <6147ac95-a572-62df-619d-33078d51ccc3@quicinc.com>
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

On Fri, 2024-04-12 at 10:57 +0530, Karthikeyan Periyasamy wrote:
> > > > + * @NL80211_IFACE_COMB_PER_HW_COMB_LIMITS: nested attribute=20
> > > > containing the
> > > > + *=C2=A0=C2=A0=C2=A0 limits for the given interface types, see
> > > > + *=C2=A0=C2=A0=C2=A0 &enum nl80211_iface_limit_attrs.
> > > > + * @NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM: u32 attribute giving t=
he=20
> > > > maximum
> > > > + *=C2=A0=C2=A0=C2=A0 number of interfaces that can be created in t=
his group. This=20
> > > > number
> > > > + *=C2=A0=C2=A0=C2=A0 does not apply to the interfaces purely manag=
ed in software.
> > > > + * @NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS: u32 attribute=20
> > > > specifying the
> > > > + *=C2=A0=C2=A0=C2=A0 number of different channels that can be used=
 in this group.
> > > > + * @NUM_NL80211_IFACE_COMB_PER_HW_COMB: number of attributes
> > > > + * @MAX_NL80211_IFACE_COMB_PER_HW_COMB: highest attribute number
> > > > + */
> > > > +enum nl80211_if_comb_per_hw_comb_attrs {
> > > > +=C2=A0=C2=A0=C2=A0 NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
> > > > +=C2=A0=C2=A0=C2=A0 NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
> > > > +=C2=A0=C2=A0=C2=A0 NL80211_IFACE_COMB_PER_HW_COMB_LIMITS,
> > > > +=C2=A0=C2=A0=C2=A0 NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
> > > > +=C2=A0=C2=A0=C2=A0 NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
> > >=20
> > > Almost all these attributes duplicate - including their docs -
> > > attributes from enum nl80211_if_combination_attrs. Is it really worth
> > > doing that, rather than adding NL80211_IFACE_COMB_HW_IDX and document=
ing
> > > the different uses of the attribute set?
> > >=20
> >=20
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
> I agree this approach. Instead of NUM_NL80211_IFACE_COMB_PER_HW_COMB,=20
> shall we have MAX_NL80211_IFACE_COMB like below so that hw_idx attribute=
=20
> value will not get conflict to any IFACE combination attributes
>=20
>   enum nl80211_if_comb_per_hw_comb_attrs {
>        NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
>        NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX =3D
>                MAX_NL80211_IFACE_COMB + 1,
>        /* keep last */
>        NUM_NL80211_IFACE_COMB_PER_HW_COMB,
>        MAX_NL80211_IFACE_COMB_PER_HW_COMB =3D
>                NUM_NL80211_IFACE_COMB_PER_HW_COMB - 1
> };
>=20

You haven't thought this through - what happens here if something is
added to enum nl80211_if_combination_attrs?

johannes

