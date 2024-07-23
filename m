Return-Path: <linux-wireless+bounces-10451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF340939FFE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 13:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E171F23145
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91591509AF;
	Tue, 23 Jul 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cZ2PxFsl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984881514E9
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734541; cv=none; b=bGNFmPa7j0Louxwxk3scRSVzR/RYjcMZyw32ZhuPBdujpsgT6FT3FaSJweykY8i0qf0/FORfmV9sDHUCHR8ZBL0PyQsi02yXxzBjDdwLDXZwj+9voInKiK72apf6ChYRS7OeBxLjaRHhURwfavNrKxTAC8B0Lk/xCcdsF8H1uBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734541; c=relaxed/simple;
	bh=aocUrPksI14PkJFiUcTIs8zsOxmk/lZVnAIK69jQ1WU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kehy0ruK05bu2vW6obxiBx8eofc23gwrS9/3Y1yIIVOjZn0+e3MRYL4tLVizUKs6Wj/1XtfHo/QF+W4IwfOZHvpcPGmiTK8PWYMp4QwKtJ0+bAI5ivv3d7/bLkjoBY03BmC6m6C6IFUTXo+BjeKvW6Eq730TNq1bbrvvjKBX2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cZ2PxFsl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rj7VJ5HZy6s2/1zcFiJLmdGzTEZImvEkqTud+84HBSw=;
	t=1721734539; x=1722944139; b=cZ2PxFslgu7apXJ/nLuVVSTJLs0lH7uKj5Mgtr/cxW80gCd
	/s/RkYxEMaNOZfwl3R2XoVy4+RGRTgZqE7iIl0c2dKvE6N+NUlYCpTz0UxTvR6TNF9HPDaVbKJwcr
	qX+wPYf9IcIGohjNknEEHSq85QW+ECyowSRbSSLDS1giYrhnsV9n03y3YNsfCB3vkfm8rh9HfdIBZ
	t50TaOvlOP2WKOawmxUx7QqvtjXF5grbKJ7cn3Eyhcc/ZBVJH4BtEvD5sakzz9j5OIKM+OIk2uc0F
	PeGr+Go0mIQq6uiqBfGJ803TSbrFsit4SmsFAPUGWVjUEXv+x4EeXdUGJ2qu8aPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWDnq-0000000BBcd-1r6G;
	Tue, 23 Jul 2024 13:35:34 +0200
Message-ID: <6415e114cd05cc63fd9b82bed95c7bdf545bc805.camel@sipsolutions.net>
Subject: Re: Managing debugfs entries and
 https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>, "Berg, Benjamin"
	 <benjamin.berg@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "lvc-project@linuxtesting.org"
	 <lvc-project@linuxtesting.org>
Date: Tue, 23 Jul 2024 13:35:33 +0200
In-Reply-To: <e545816b-22ae-4837-9597-86483ad37374@yandex.ru>
References: <1ff58acb-4171-46ff-8a33-821600a8d8e4@yandex.ru>
	 <2e57365ad4b0a5e63bf1d54ff776d57d08d462b0.camel@intel.com>
	 <e545816b-22ae-4837-9597-86483ad37374@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-07-23 at 14:19 +0300, Dmitry Antipov wrote:
> On 7/19/24 12:38 PM, Berg, Benjamin wrote:
>=20
> > So, the simple way to prevent this error is to make sure that
> > ieee80211_debugfs_recreate_netdev is never called while we have a
> > station. In the case of this report we seem to be getting there via a
> > mac address change (i.e. ieee80211_change_mac) and the sane thing would
> > be to just return -EBUSY instead of permitting the operation to
> > continue.
>=20
> Just to check whether I understand this:
>=20
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index a3485e4c6132..d5adbe5b3e51 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1173,6 +1173,8 @@ struct ieee80211_sub_if_data {
>=20
>   	u16 restart_active_links;
>=20
> +	u32 sta_count;

That's probably one way of doing it, but it's rather ad-hoc, really what
we should be doing is check more things in whether we allow the change
or not, it looks like now it can only happen in the window between
starting auth/assoc and actually having a connection, which is anyway
wrong to allow it in.

So more like below.

johannes


--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -204,7 +204,6 @@ static int ieee80211_can_powered_addr_change(struct iee=
e80211_sub_if_data *sdata
 	struct ieee80211_roc_work *roc;
 	struct ieee80211_local *local =3D sdata->local;
 	struct ieee80211_sub_if_data *scan_sdata;
-	int ret =3D 0;
=20
 	lockdep_assert_wiphy(local->hw.wiphy);
=20
@@ -220,10 +219,8 @@ static int ieee80211_can_powered_addr_change(struct ie=
ee80211_sub_if_data *sdata
 		if (roc->sdata !=3D sdata)
 			continue;
=20
-		if (roc->started) {
-			ret =3D -EBUSY;
-			goto unlock;
-		}
+		if (roc->started)
+			return -EBUSY;
 	}
=20
 	/* And if this iface is scanning */
@@ -231,7 +228,7 @@ static int ieee80211_can_powered_addr_change(struct iee=
e80211_sub_if_data *sdata
 		scan_sdata =3D rcu_dereference_protected(local->scan_sdata,
 						       lockdep_is_held(&local->hw.wiphy->mtx));
 		if (sdata =3D=3D scan_sdata)
-			ret =3D -EBUSY;
+			return -EBUSY;
 	}
=20
 	switch (sdata->vif.type) {
@@ -240,13 +237,15 @@ static int ieee80211_can_powered_addr_change(struct i=
eee80211_sub_if_data *sdata
 		/* More interface types could be added here but changing the
 		 * address while powered makes the most sense in client modes.
 		 */
+		if (sdata->u.mgd.auth_data || sdata->u.mgd.assoc_data ||
+		    sdata->u.mgd.associated)
+			return -EBUSY;
 		break;
 	default:
-		ret =3D -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
=20
-unlock:
-	return ret;
+	return 0;
 }
=20
 static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,


