Return-Path: <linux-wireless+bounces-23058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102CAB96E5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 09:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B87B8551
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF2F22A80E;
	Fri, 16 May 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Uaj+CAGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AA22A1D1;
	Fri, 16 May 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381955; cv=none; b=U0ckUp2cLleMfo2vrKCZ7ezKYhU2Nne8qhyMRWFpR3dv3o/0fQ+c+8U8VtSkni/zwvrITAxJwlgHkz1nJSzdfJpU28nan+6J9f8VjsXUPQIa2xw4Sd1qwMaGnVsQzIfJLOxfsfC4yrKfnBvt0oqsyLhzASNqgA8I9Uab8kbyClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381955; c=relaxed/simple;
	bh=4GT08zDi3YFG+c+N8suntnGoDRZMlMwItlwgruR1WZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8m9WfRhvjf33f/pqMOx+VzseT30FgQINaKYtiZJ9GHzLqUQ0KsuZwDATiFfwLyyILE4u9w9YS257ZDnn70w46kAsw8i0TKNd7AJEmQIHqZae27yPo36/9kHikIQutzGwWTMPAuUJr19ndjJrqp6uZKD1aJLRzhA0+0aOZnyMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Uaj+CAGa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Xms+tkcDaN+RlNm1G2zpjrj1zA/9AsVP/+rb2sFb2cY=;
	t=1747381954; x=1748591554; b=Uaj+CAGaA5Ht26yU6re7E+L29bWS2clhJYjVScLA+vZtPVH
	vKwC/maj5hT49hsuvro7Gv2VckryC7hWmatSAGOEfFgtEtt5tAeFX+hzOag4vlr7lEm6Bim26w3dQ
	/rfn3rT6/VRj3ZHJcvERf5zgcm4N02PE7Ge2v4dXlvlb45Il2pIoD/GEQaHjSskcaFWLGheXKw4iq
	He1ATxu7l9ttw5vW8LdgTbWB+LvCrg1E9Dg0fEH/m38ajh6qlQJYt2oAvOjryHwv6sa1dZmIZB74s
	fviVAJGmmcUebpQQGpjOMXcRm7xaO+UKQiGEP48/7C4QyFvvPCFDzXvaZ+0UY9mw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFpro-0000000E0QC-2YSK;
	Fri, 16 May 2025 09:52:28 +0200
Message-ID: <8f133266a906c5b57f3294b71c7e5bae57298ad1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/3] wifi: cfg80211: Add utility API to
 get radio index from channel
From: Johannes Berg <johannes@sipsolutions.net>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Date: Fri, 16 May 2025 09:52:27 +0200
In-Reply-To: <37f00d636e1ffb68e383e0784b30e7e5cf48b4dd.camel@sipsolutions.net>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
		 <20250514-mlo-dfs-acs-v1-1-74e42a5583c6@quicinc.com>
	 <37f00d636e1ffb68e383e0784b30e7e5cf48b4dd.camel@sipsolutions.net>
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

On Fri, 2025-05-16 at 09:51 +0200, Johannes Berg wrote:
> On Wed, 2025-05-14 at 16:58 +0530, Raj Kumar Bhagat wrote:
> >=20
> > +int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
> > +				   const struct ieee80211_channel *chan)
> > +{
> > +	const struct wiphy_radio *radio;
> > +	int i, j;
> > +	u32 freq;
> > +
> > +	if (!chan)
> > +		return -EINVAL;
> > +
> > +	freq =3D ieee80211_channel_to_khz(chan);
> > +	for (i =3D 0; i < wiphy->n_radio; i++) {
> > +		radio =3D &wiphy->radio[i];
> > +		for (j =3D 0; j < radio->n_freq_range; j++) {
> > +			if (freq >=3D radio->freq_range[j].start_freq &&
> > +			    freq <=3D radio->freq_range[j].end_freq)
> > +				return i;
> >=20
>=20
> I believe we also discussed this in the past elsewhere, but I don't
> think the the >=3D and <=3D can simultaneously be wrong. If the frequency

"simultaneously be correct". I meant "correct", not "wrong"...

johannes

