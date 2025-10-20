Return-Path: <linux-wireless+bounces-28103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C4BF1BCC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A79734F7025
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61FF31DDB7;
	Mon, 20 Oct 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IogG0n4A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2783195FC;
	Mon, 20 Oct 2025 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969178; cv=none; b=Fdqy/gFcdq6/dHpZJDu4R1W1jWtzmNUolicRqGw+Ykt1zq0OAfpG3l6a+iXau1e9AVh4GzF95kZbjk+mkWo18CXQsHT/ozqBy5YAJ95lCD/ZYOOJ7cfRce5ftwHYvYjAxgjDKQf3mh5a80BBX/SOUJwu2wjD/pS0cg8bz+YHd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969178; c=relaxed/simple;
	bh=HIyIIlju/zLT3pD7maDmp8NHUufmmLO6o6vNmfoogCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hWckUcPdB9F7hV/r+P4igDhAHcQxtjB8y4AjsRWIwJ0HBeEriEDcInJBoHrmJvFT9YpxmeFGaCf8ntqcvNQpkAk8wbgHSMpMs0uNcSJGpLvEZm+r9Wc/LbxxG+brKMicLobsKxRUSJDYFphb9VenfTRPgUgnLxYKaZ4UxULPa54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IogG0n4A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Iy43j39S6GT0DI6tiMO3YWwrLT1nVSSoSiIL3AN3a5s=;
	t=1760969177; x=1762178777; b=IogG0n4AZmHi79rxsRN+U4BfzAkbPtKhFab6KJ96FLSJcA7
	fhUfk9DVsfKQ8LmKLpdQLDlCJWLKJB60MD8rwlQxcELNhX3BdkuBaOIi1PByTl3QPounwViatkyCo
	UWlLs6MUTm7SBJ/9NRbB9k4E/M3GEfK47vLyhXJEOIsFVWQ+y128kKXxhi8+G/Oo87rVUFjSOZhG7
	KdBIHETpmvqmr4VpkfJckpMcXNmIRwaqN6SQd8ur4I739Pqx9InzpusVfhePMlcWsHEh/Tv4eiqeO
	glkrMebbeprOaaAu/BBVhsB1zbnSfjSEPHNMNmq45P7EwPLfpZuemWzU6lV/wEKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAqWc-000000092cG-1a6g;
	Mon, 20 Oct 2025 16:06:14 +0200
Message-ID: <30b9e7eebfc99330857f7a81c72b9eb23ea6406d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Remove unused wdev_to_ieee80211_vif
From: Johannes Berg <johannes@sipsolutions.net>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, 
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 20 Oct 2025 16:06:13 +0200
In-Reply-To: <aOvZ8FHp7-tliei2@gallifrey>
References: <20250619005229.291961-1-linux@treblig.org>
	 <aOvZ8FHp7-tliei2@gallifrey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-10-12 at 16:40 +0000, Dr. David Alan Gilbert wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >=20
> > wdev_to_ieee80211_vif() was added in 2013 by
> > commit ad7e718c9b4f ("nl80211: vendor command support")
> > but has remained unused.
> >=20
> > Remove it.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>=20
> Hi,
>   Gentle ping on this one please.

This was/is used elsewhere out-of-tree, so I had dropped this change, at
least for now. I guess that's really not a good excuse though.

I guess drivers could instead ieee80211_iterate_active_interfaces_mtx()
and find the right wdev from that list, like


struct wdev_find_vif_iter {
	struct wireless_dev *wdev;
	struct ieee80211_vif *vif;
};

static void wdev_find_vif_iter_fn(void *data, u8 *mac, struct ieee80211_vif=
 *vif)
{
	struct wdev_find_vif_iter *iter =3D data;

	if (ieee80211_vif_to_wdev(vif) =3D=3D iter->wdev)
		iter->vif =3D vif;
}

struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev)
{
	struct wdev_find_vif_iter iter =3D {
		.wdev =3D wdev,
	};

	ieee80211_iterate_active_interfaces_mtx(wiphy_to_ieee80211_hw(wdev->wiphy)=
,
						IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
						wdev_find_vif_iter_fn, &iter);

	return iter.vif;
}


but I guess I'm not sure it's really better for drivers to have that vs.
upstream carrying the unused function.

johannes

