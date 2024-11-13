Return-Path: <linux-wireless+bounces-15273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479869C77D6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 16:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BF11F21238
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D715B130;
	Wed, 13 Nov 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J1jbnrB2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A415AAC1;
	Wed, 13 Nov 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512951; cv=none; b=sR1odcfZQ7dOuc3LjR4IV/+gxAorPn3AHDTlTLBkafiscXmR+6f/1Nc/Rm9tggjTxLu/8w+54F5qrqGHgpRf4JQ9Zg8+KFk6G0GY/8GByG2xfNm3s9fdlIMokOmdltvfXsPq6rGBSIV8kH5n0S8+wC1oaMkwThPBMP990bQiEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512951; c=relaxed/simple;
	bh=+QiNbq/ncgEeIIZal9GuY+cJkz3gyibPzGvuc/TlFtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZwWOYzPOyErSVWYy1Y7eHZfrybBD8A3GBtlWh8jU/wLqYNhE3ksVxgI25O8Xw7USYzcQ44VE/fMCvF8oQiJo+PWow++/RxC1R7N1085XEDRmR3pcA7vyxxlg8jRBCcpvWlACBDOV6pzoufxpYmpgfFTJmH3q+zLS0YXukF7YwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J1jbnrB2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=F8q1bykgWYZ3SXIlGtZYQzZ4/a15gbuKD+cXU4a6HBM=;
	t=1731512949; x=1732722549; b=J1jbnrB2OjGYDsnaVyK3iw5aZozRk8P91DCkPXQEi7nNjq7
	PXVvelzgJCKycJDlAL0ciy+5xYvas39WuQRMVy9YP3Jr/f8eOji+v1qJTBRfRo675C9rOeUKJT0pP
	p4BJAodpZazxyhp72Yw09qE1kaxn9awtK4G2UiBOGcSgcyMw6EBzV1ihKMtk/Mr7J63wpfpatIzxz
	0771coO3h6z5KFSPcAFcPpVFMYGqFClHfwxmfttZx8cxgqKXdvVxxU/iKpHNKLyAi6XLb2QeYSCA1
	nuuUa0svhFZjinXHu8F7kupoo6M/QZ1Hql+uN375L6QQkhWS3yjTdlZ+FjvaTAnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBFc3-00000003wM5-2Cqm;
	Wed, 13 Nov 2024 16:49:00 +0100
Message-ID: <6b59e7a5f90b85dfc9146fa2cbdfe56c0a307a3e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix WARN_ON during CAC cancelling
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Nov 2024 16:48:58 +0100
In-Reply-To: <383a616d-50c7-4538-9e94-fc8526405c94@quicinc.com>
References: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
	 <d0eb18d4a302e4be5251106fbfa8f5e10dd36477.camel@sipsolutions.net>
	 <383a616d-50c7-4538-9e94-fc8526405c94@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-11-13 at 20:13 +0530, Aditya Kumar Singh wrote:
> On 11/13/24 14:59, Johannes Berg wrote:
> > >=20
> > > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > > index a5eb92d93074e6ce1e08fcc2790b80cf04ff08f8..2a932a036225a3e0587cf=
5c18a4e80e91552313b 100644
> > > --- a/net/wireless/mlme.c
> > > +++ b/net/wireless/mlme.c
> > > @@ -1112,10 +1112,6 @@ void cfg80211_cac_event(struct net_device *net=
dev,
> > >   	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
> > >   	unsigned long timeout;
> > >  =20
> > > -	if (WARN_ON(wdev->valid_links &&
> > > -		    !(wdev->valid_links & BIT(link_id))))
> > > -		return;
> > > -
> > >   	trace_cfg80211_cac_event(netdev, event, link_id);
> > >  =20
> > >   	if (WARN_ON(!wdev->links[link_id].cac_started &&
> > >=20
> >=20
> > This really doesn't seem right.
> >=20
> > Perhaps the order in teardown should be changed?
>=20
> I thought about it but couldn't really come down to a convincing approach=
.
>=20
> The thing is when CAC in ongoing and hostapd process is killed, there is=
=20
> no specific event apart from link delete which hostapd sends.
>=20

so we do have link removal, why doesn't that work?

> Will it be=20
> okay to add a new NL command to stop radar detection? Something opposite=
=20
> of what start_radar_detection command does?
>=20

No, obviously not.

johannes

