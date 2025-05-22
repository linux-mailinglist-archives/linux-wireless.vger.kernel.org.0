Return-Path: <linux-wireless+bounces-23307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB5AC0A8B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 13:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D83A25B75
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE31288C0C;
	Thu, 22 May 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SAJ6FEXL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C412B9A9;
	Thu, 22 May 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913003; cv=none; b=kqTwM2DkOFzS6hmgqv+JhpGLBK511LFV/KyqCk/bc/caBY3C6gGOATIivDix7Ujh3FdY2TOIDYaW8OitYlcdm2ZmuGStnLlgG8qH7FgvfbfRE/SDyjjU+Ug8VuSi9Ba5YZhDAp52suELTUavhzAcVyD7usgRkW0bmOaDdAS1BCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913003; c=relaxed/simple;
	bh=9DOvodseAtkhj1FPlCJCI3dYj0L1ouxljdZeJQaHcDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGLX2jhx/8w+iFansCJ3h4pIA1a/sD5w4O8u+j/YSMQN2p+XeUtb7ghpxCxe4Qjh/h/MtyMDRFivHMf5UBfMmqGfHsdvNIlNeqm+AfdVpeFKZuTYl2VKyoNhaIiqnSdlIJcMgDn+MWQTGB0Q7Cu+Syblv2klcuEHno3qxkYobQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SAJ6FEXL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AUt4PGqakZkzIjDFuR4EXoZk716c/Pi23AsUXz1LtIU=;
	t=1747913002; x=1749122602; b=SAJ6FEXLbRlZ4PtxZbZtQZxLVPThoIxDqeij3O2BfA3Pfkx
	WhCquWg+0LHQWu9mpyPybk0CY6zsMrJ4TJY0i60mjoU4xnAWqiMmZ9AcJU7iqut643HCqsUkITyMv
	6JZqCRmQDn964wxAVuEfY/ChjoZZVfQ1tYm59kSTCAwpsZ2wwptucTenvoT6ikTYvhEIbzrM67WRO
	45F5+FWDjqxdSfhDpKFg8wTVkJvhLD5Jggb1XwzCKPXco7Bzkr4W/0BuJ0oeS4AU0dNfLDvR/37Xy
	zdNZnA2VJs69o5jikstzK7x5oBlEgD4cmNgMHqUOkPo7mYoatDkJeSQXag1Y7OGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uI418-0000000GkgW-3s9z;
	Thu, 22 May 2025 13:23:19 +0200
Message-ID: <f694233ea7378257fbc992bd3d6f10ac7f6d3695.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 2/3] wifi: mac80211: Allow scan on a radio
 while operating on DFS on another radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 May 2025 13:23:18 +0200
In-Reply-To: <a91c82f1-df99-4938-8f41-ce90e9e08ad8@quicinc.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
	 <20250514-mlo-dfs-acs-v1-2-74e42a5583c6@quicinc.com>
	 <d23e55879c6d8b6cabcc8357f153ae0622a4c53a.camel@sipsolutions.net>
	 <a91c82f1-df99-4938-8f41-ce90e9e08ad8@quicinc.com>
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

On Thu, 2025-05-22 at 16:10 +0530, Raj Kumar Bhagat wrote:
>=20
> I'm not sure If I fully understood the this comment.
>=20
> This patch assumes that multiple radios are grouped under a single wiphy.
> Each radio has its own list of frequencies it can scan, and there is no o=
verlap
> in frequencies between any two radios within the same wiphy.

Yeah I guess I'm just overly paranoid due to lack of familiarity with
all the multi-radio things.

> If this assumption holds, then if one radio is operating on a DFS channel=
 and a
> new scan request does not include any frequencies from that radio's list,=
 the
> scan should be allowed=E2=80=94since the DFS radio wouldn't be involved i=
n handling that
> scan request.

Agree.

> > > +	for (i =3D 0; i < scan_req->n_channels; i++) {
> > > +		chan =3D scan_req->channels[i];
> > > +		chan_radio_idx =3D cfg80211_get_radio_idx_by_chan(wiphy, chan);
> > > +		/*
> > > +		 * Skip channels with an invalid radio index and continue
> > > +		 * checking. If any channel in the scan request matches the
> > > +		 * given radio index, return true.
> > > +		 */
> > > +		if (chan_radio_idx < 0)
> > > +			continue;
> >=20
> > This seems ... wrong? If there's a channel in the scan request that
> > didn't map to _any_ radio then how are we even scanning there? And the
> > comment seems even stranger, why would we _want_ to ignore it (which it
> > conveniently doesn't answer)?
> >=20
>=20
> It seems, (chan_radio_idx < 0) should never be true because the chan is
> taken from the valid scan request. I should remove this check in next ver=
sion?

I'm not sure, why did you add it? Maybe it should be a WARN_ON and abort
the whole function? It just doesn't seem right to _ignore_.

johannes

