Return-Path: <linux-wireless+bounces-12070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491C96133E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 17:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0361F21FCE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E81C93A3;
	Tue, 27 Aug 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e8xNCrmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698B1C57B1
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773868; cv=none; b=HgGLeygUit75Wtajl3Lv3DT8+1axsETYNV8S/cs9hHIbdPI6kATnY3xtC6eBNPLjT+qBOkmY/Ptnw4WTHVSp02uxhyOnwnMJhx1s3iZ6qPg3a/mKoKLNeEjewyq0OOgK5MKczg3PZwvQZWf1Dz16/+UWn9YfRUF4IKd70UoUkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773868; c=relaxed/simple;
	bh=YA41laJCh1u/LcqkTiTGdlZaky9USGb8R2hoUh9zBWc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tiz/X4mjPv+/9/jAFwJf4nkjKO72mBbdy5vZ3pRuR3k1Rj9EPJsX6C0CW8bR7WR/p5r84cq6lbq2XmkWzGJsZemwRtIPSYdbP3gp2WJh9xxJM70O1HRmGwnc+c6Yidrx4iSRrfcd+TSDtTOCVBqVmtG9OEaB5zkS6kUF2hufU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e8xNCrmw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BMG5ZHed9MJUbHIIqaZMfRKy6fBXmXCfporxolLhWx4=;
	t=1724773865; x=1725983465; b=e8xNCrmwHg46EwkjpO7MnIBws42wEbiTIxhFpMT57R2VgLT
	JfBBTqRk/9Sf3lzZIh3Km/U4q1D2FWTeqq/h1Fz0siQ9+hQWUdhgRp4O8E8IIywmyrJZ37Jv9HbZD
	qjzv+tUk9c1uMk8pn/Yu2n/mTitL1AV4RlQLnaNjiL66zIslcjXKSoPRDLLBwwYrSTUFpIpmbcZbX
	Y07FF0FL0AgXeaS09Xhq0SDBY+INJbHIwGHXboQfdBXr7Dn9YwmV37I32PV8vKnrdiKcGgukHKrVk
	vDmov2eaeode//wdVVLKz538JsBLJAcqccRmByB0dKrIkt266X75x0panLD1JAow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1siyTG-0000000508C-2EKT;
	Tue, 27 Aug 2024 17:51:02 +0200
Message-ID: <4c6891c3bf91876a6ad64849b5bb7624ed5a0305.camel@sipsolutions.net>
Subject: Re: HACK/RFC: Fix link_sta->rx_nss == 0 in iwlwifi upon eMLSR link
 change.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Aug 2024 17:51:01 +0200
In-Reply-To: <d42ef01b-996b-a645-d59e-f3dec5a974a9@candelatech.com>
References: <d42ef01b-996b-a645-d59e-f3dec5a974a9@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-07-16 at 16:25 -0700, Ben Greear wrote:
> While poking around at some instability and poor performance seen in down=
load
> direction, I noticed that the rate-ctrl was probably set incorrectly in
> the iwlwifi driver due to link_sta->rx_nss being zero when changing activ=
e link
> to the secondary link (the one we didn't originally associate with).
>=20
> After debugging, I found that the hack below will make this problem
> go away.  I sincerely doubt this is the correct approach, but I'm not
> sure how it is all supposed to work in the first place.

Andrei came up with this, which does seem better, but probably wouldn't
address the AP side:

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d624c51d0bd1..8d32adf7502d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5744,6 +5744,7 @@ static bool ieee80211_assoc_success(struct ieee80211_=
sub_if_data *sdata,
 		}
=20
 		if (link_id !=3D assoc_data->assoc_link_id) {
+			ieee80211_sta_init_nss(link_sta);
 			err =3D ieee80211_sta_activate_link(sta, link_id);
 			if (err)
 				goto out_err;

Care to test it?

In general I think we should probably remove the call to
ieee80211_sta_init_nss() from rate_control_rate_init() and call it
explicitly wherever needed, since with MLO we require offloaded rate
control and rate_control_rate_init() doesn't really do anything (except
this for the deflink, which is then questionable)

johannes

