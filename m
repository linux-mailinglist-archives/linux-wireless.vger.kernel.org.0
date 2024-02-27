Return-Path: <linux-wireless+bounces-4059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD118689E1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 08:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C684A1F21DA6
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31054776;
	Tue, 27 Feb 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sOntOl1t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF25465C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019176; cv=none; b=b7Q3G7cnoYeAZQF3Ouh83zJHv+MRrej/g8RS+5ODEeBW6V081fNnutkS7vb6gSNL2dL2mDtsBywEXRaVb52nrTBenBRByph1GW7Du5q5mowG5uxe0AgcWZgDKGb44WiNU51lrzP3dX+dK2mSAq91eVRAbuvJuW6b7GXN1JB63OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019176; c=relaxed/simple;
	bh=we4iIof7ubR2V8Vz2TCc15JGiUi21UUfmA3W6qPGWUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWnz/3GMSwotQqJ59LGfJJwvbKS7T+3SY6U23huIJoyTNVSHVKoxJpfwsrKao2dyuQc386Zc9SJplb+ifnoZfM7jY5Ss5JSkaHSfnvqsHMXoZEJ/sZcsrdG2uM+eCyzjupcxZZrXhQA6KVEmMx3/VkbVsssmjwbQzxvThuQgZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sOntOl1t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ddim0juEYH9dYsDYFVcggUBT7rEqhWT1XS3J5aa+pGY=;
	t=1709019173; x=1710228773; b=sOntOl1t8nnJgWcejlPiK2nHhU37iEG9rUrb7h79JLylGm8
	j0qngOXvqrve5GYEOHa5U+6rAIjS7y5VDN4ZuQz1e+tjMtPXn9r7IUlRyaYSLU/HqIk4DmEeGwBGz
	t1PV/Rgl76PMJ3v7sZf7coToqcx976l+xI6UurNBJD9GLCz6lIaflw+LG9Jh093Bthjp8zpAIDtY/
	KKKzzB7SVvurvVNUqEXwqdK0GG3ACmswnepJwPNEsfV4TZ1g5hmFQSKG+4nbViibfmvSl8WOJZI+t
	d1EkdsCsBbumrxT5CqF7VYj/DV8LZaYEzELWuvdrEfUOnVKvQq0ED4m6AoprLCDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rerxJ-0000000AUNd-39S9;
	Tue, 27 Feb 2024 08:32:49 +0100
Message-ID: <5c5ad99d3c2f3b9915b440057eab6618639cd31f.camel@sipsolutions.net>
Subject: Re: [PATCH 2/6] wifi: ath11k: add P2P IE in beacon template
From: Johannes Berg <johannes@sipsolutions.net>
To: Kang Yang <quic_kangyang@quicinc.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 27 Feb 2024 08:32:48 +0100
In-Reply-To: <b20fc717-654d-4e64-920f-699fe3ec5598@quicinc.com>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
	 <20240226060203.2040444-3-quic_kangyang@quicinc.com>
	 <42652a06-33f3-445a-bd8a-da4633fa52f8@quicinc.com>
	 <b20fc717-654d-4e64-920f-699fe3ec5598@quicinc.com>
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

On Tue, 2024-02-27 at 14:58 +0800, Kang Yang wrote:
>=20
> > > +	if (arvif->vif->type !=3D NL80211_IFTYPE_AP || !arvif->vif->p2p)
> >=20
> > this logic isn't applicable for NL80211_IFTYPE_P2P_GO ?
>=20
> The original intention here is to determine if it is P2P GO, if yes,=20
> continue, otherwise return.
>=20
>=20
> Maybe this judgment is a bit misleading, let me replace with
> if (arvif->vdev_subtype !=3D WMI_VDEV_SUBTYPE_P2P_GO) ?

There's also

	ieee80211_vif_type_p2p(arvif->vif) !=3D NL80211_IFTYPE_P2P_GO

if you wanted to write it that way.

@Jeff: NL80211_IFTYPE_P2P_GO is not used by mac80211 internally, it
translates that to vif->type=3D=3DNL80211_IFTYPE_AP && vif->p2p=3D=3Dtrue.

johannes


