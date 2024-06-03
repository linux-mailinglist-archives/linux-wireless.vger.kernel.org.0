Return-Path: <linux-wireless+bounces-8386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B52F8D7974
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 03:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344781F215FA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 01:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578FA34;
	Mon,  3 Jun 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tWYufJXx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B010E6;
	Mon,  3 Jun 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717376482; cv=none; b=jQY9JzdrCOp/qY2El5NInTBgSKnZSEyTBZc1nyZfvprpRQEbA3rMSwZ+YsAx3bwrEyLew0Y7RofZH1+Pa9kCgrrkHMl+l0x2AcWnzEna5YROY5j4aK8qUBo8/nImySTZCtNuVRU1shpHPbTWpp7rUfcEnnwvuPx1SWzJntZk4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717376482; c=relaxed/simple;
	bh=WsxmSnVOfFkU7amu/IfJK6x2Dv1B0lj8Xc7qDr+yCgY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Rw3/YaV/kzSpSvMszqNsAyoK8HekcIcuaHR1y1lAnc1zT5xcZ4SXQEKPAHIE0SgI0SP2Z1++kc6aOWsh8wZT3iraKmxN4SI9BT1iy8Q5mBy3I5moIQKzg+ck13TCCq5YiUh07DFlbfrLjgb5zfYRC4VbDUbL3QBg5iFbXrd0F2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tWYufJXx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1717376476;
	bh=mw8hyXSE9bFJ4MtVqvHaxGbgI57D2tjW39scQTVUe4I=;
	h=Date:From:To:Cc:Subject:From;
	b=tWYufJXxbRDZVSOCxft3qnO2eCpy2mpoyD0JSR/Wr8cbM+o9FWJV1M8rsJFnlY8h2
	 VGZdfi32jpPQUteH1MDesU+o8iMAt48vHB0jzKErNtYfrRithA3O3emQfNoaES7MQo
	 LFsJIQdKsLaLZ+slMtqSmUngk8jKJNxe36pvU9/77qRXYq29/2GZlDcEgvUu2yOHW3
	 4rY/YTjqw7R4xHd1jbilHZ1BQ3pIcSlwZyJCxwuewNKV/J5B9lEJwAMgluwMO7m+wO
	 uz8IKI4F+mdlXUf+UbFLkUvSZFESvANBCwtkJ8MKKiyEzUThqnilr7olzDCuoBBl/B
	 MVGujOHVX3R5Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VswQd00Gmz4wc8;
	Mon,  3 Jun 2024 11:01:12 +1000 (AEST)
Date: Mon, 3 Jun 2024 11:01:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Wireless <linux-wireless@vger.kernel.org>
Cc: Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20240603110023.23572803@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/05OeU/QARN9V22btBlEw4aP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/05OeU/QARN9V22btBlEw4aP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/net/wireless/microchip/wilc1000/netdev.c

between commit:

  ebfb5e8fc8b4 ("Revert "wifi: wilc1000: convert list management to RCU"")

from the wireless tree and commit:

  6fe46d5c0a84 ("wifi: wilc1000: set net device registration as last step d=
uring interface creation")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/wireless/microchip/wilc1000/netdev.c
index 710e29bea560,4e2698528a49..000000000000
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@@ -679,9 -669,9 +672,9 @@@ static int wilc_set_mac_addr(struct net
  			return 0;
  		}
  	}
 -	rcu_read_unlock();
 +	srcu_read_unlock(&wilc->srcu, srcu_idx);
 =20
- 	result =3D wilc_set_mac_address(vif, (u8 *)addr->sa_data);
+ 	result =3D wilc_set_mac_address(vif, addr->sa_data);
  	if (result)
  		return result;
 =20
@@@ -972,6 -959,28 +966,28 @@@ struct wilc_vif *wilc_netdev_ifc_init(s
  	vif->priv.wdev.iftype =3D type;
  	vif->priv.dev =3D ndev;
 =20
+ 	ndev->needs_free_netdev =3D true;
+ 	vif->iftype =3D vif_type;
+ 	vif->idx =3D wilc_get_available_idx(wl);
+ 	vif->mac_opened =3D 0;
+=20
+ 	memcpy(mac_address, wl->nv_mac_address, ETH_ALEN);
+ 	/* WILC firmware uses locally administered MAC address for the
+ 	 * second virtual interface (bit 1 of first byte set), but
+ 	 * since it is possibly not loaded/running yet, reproduce this behavior
+ 	 * in the driver during interface creation.
+ 	 */
+ 	if (vif->idx)
+ 		mac_address[0] |=3D 0x2;
+=20
+ 	eth_hw_addr_set(vif->ndev, mac_address);
+=20
+ 	mutex_lock(&wl->vif_mutex);
+ 	list_add_tail_rcu(&vif->list, &wl->vif_list);
+ 	wl->vif_num +=3D 1;
+ 	mutex_unlock(&wl->vif_mutex);
 -	synchronize_rcu();
++	synchronize_srcu(&wl->srcu);
+=20
  	if (rtnl_locked)
  		ret =3D cfg80211_register_netdevice(ndev);
  	else
@@@ -979,26 -988,17 +995,17 @@@
 =20
  	if (ret) {
  		ret =3D -EFAULT;
- 		goto error;
+ 		goto error_remove_vif;
  	}
 =20
- 	ndev->needs_free_netdev =3D true;
- 	vif->iftype =3D vif_type;
- 	vif->idx =3D wilc_get_available_idx(wl);
- 	vif->mac_opened =3D 0;
- 	mutex_lock(&wl->vif_mutex);
- 	list_add_tail_rcu(&vif->list, &wl->vif_list);
- 	wl->vif_num +=3D 1;
- 	mutex_unlock(&wl->vif_mutex);
- 	synchronize_srcu(&wl->srcu);
-=20
  	return vif;
 =20
- error:
- 	if (rtnl_locked)
- 		cfg80211_unregister_netdevice(ndev);
- 	else
- 		unregister_netdev(ndev);
+ error_remove_vif:
+ 	mutex_lock(&wl->vif_mutex);
+ 	list_del_rcu(&vif->list);
+ 	wl->vif_num -=3D 1;
+ 	mutex_unlock(&wl->vif_mutex);
 -	synchronize_rcu();
++	synchronize_srcu(&wl->srcu);
  	free_netdev(ndev);
  	return ERR_PTR(ret);
  }

--Sig_/05OeU/QARN9V22btBlEw4aP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZdFdgACgkQAVBC80lX
0Gwkfwf/drOmN75fgWcpn3xrxdrqng1PyF0wr1Vp4nKqgNlxKXEmK6jSqh5yDeN+
6A7OggoDlsGfYAakLCEghJ40a8LIVqEM8oLISXbRVRHi2kHQXt89WLCds3qbcuzS
dBY2gJWhwuMkGAnQWQ6PXr90atAYI7zZ07zunOX+cHYbYBMr2358SUX+ZaMGWRok
w3ZQ6ZiJQv3UtYVn3vWi6wsm2jmTIFFDwqF8L2ky0hMsj7/Rv8a4zt2/ebbWOvuB
BynFvvXX/TYpeluaQ5XEg+1QVO0LnYMmkbzkpiNCyM0iUu45sUUEG+lukgeBjW2a
3an4E0V8z9vgBG02IYFkk4iXlurb/Q==
=hvcf
-----END PGP SIGNATURE-----

--Sig_/05OeU/QARN9V22btBlEw4aP--

