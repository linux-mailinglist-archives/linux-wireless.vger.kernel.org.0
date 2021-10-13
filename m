Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE29D42C954
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 21:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhJMTIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 15:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236537AbhJMTII (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 15:08:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B5B6610FE;
        Wed, 13 Oct 2021 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634151964;
        bh=d2qwMKyYLa/NzGfeio4asesbymsJzfxOP2NnhD6p3Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtYy7GvOoPnVTFPXdZJhShOsk8jSrqUnI2Mk1iRsBPODxWtwW55IHeiIoPOTnPOzW
         bc4UWy4XQwkBjCRgkSyydx/ffR/T9tcLI5OULvsbIzhAbzuxyMVrqTsbjfkUjbvhYQ
         1ZdV6b+zq9AI/+uZbzvOOsXEAjKclOJciOb2+qcZwSvK2Pf4w036T70NmGs0THDO00
         GzHf/Y+Ks9Sg8P2b7M9Ga/sdOd6xiWy+ykcK8bliMl9DkkT7WQY4U9YHbyXg0IAxb0
         bSTmhxMQqHQb3sR2hqWuHiNUJKlkgxQ+gBmBSCuScrUwQ06twszjBS6kO1y8sw7rse
         FBO99kZDSr7OA==
Date:   Wed, 13 Oct 2021 21:06:01 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 11/16] mt76: sdio: extend sdio module to support
 CONNAC2
Message-ID: <YWcuGcFPGCtaPh+2@lore-desk>
References: <YWcJe27HQMS7B85j@lore-desk--annotate>
 <1634147793-9956-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QAdqLtfNevhfWH71"
Content-Disposition: inline
In-Reply-To: <1634147793-9956-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--QAdqLtfNevhfWH71
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> In the current driver, we can see we only created one Rx queue (dev->q_rx=
 with qid =3D 0)
> in mt76s_alloc_queues for processing all incoming packets including MCU e=
vents and wifi packets.
>=20
> And from the point of view of the device,
> mt7663s use the hardware queue 0 for all MCU events and wifi packets;
> mt7921s use the hardware queue 1 for all MCU events and wifi packets.
>=20
> So if we don't remap from hardware queue 1 to dev->q_rx[0] for mt7921s to=
 handle incoming packets,
> we will get the kernel panic on accessing the invalid pointer on dev->q_r=
x[1].
>=20
> 	Sean
>=20
> >Regards,
> >Lorenzo
> >
>=20
> <snip>

ok, what about doing something like the patch below?
If it works for you, I will post a formal patch.

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wirele=
ss/mediatek/mt76/mt76.h
index 792573dad2e1..25524a21dffa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1254,7 +1254,8 @@ void mt76u_queues_deinit(struct mt76_dev *dev);
=20
 int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops);
-int mt76s_alloc_queues(struct mt76_dev *dev);
+int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid);
+int mt76s_alloc_tx(struct mt76_dev *dev);
 void mt76s_deinit(struct mt76_dev *dev);
 void mt76s_sdio_irq(struct sdio_func *func);
 void mt76s_txrx_worker(struct mt76_sdio *sdio);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net=
/wireless/mediatek/mt76/mt7615/sdio.c
index c3bd163e0278..577561aaee31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -147,7 +147,11 @@ static int mt7663s_probe(struct sdio_func *func,
 		}
 	}
=20
-	ret =3D mt76s_alloc_queues(&dev->mt76);
+	ret =3D mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
+	if (ret < 0)
+		goto error;
+
+	ret =3D mt76s_alloc_tx(mdev);
 	if (ret)
 		goto error;
=20
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wirele=
ss/mediatek/mt76/sdio.c
index bb40cc3e9c2b..c99acc21225e 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -299,8 +299,7 @@ int mt76s_hw_init(struct mt76_dev *dev, struct sdio_fun=
c *func, int hw_ver)
 }
 EXPORT_SYMBOL_GPL(mt76s_hw_init);
=20
-static int
-mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
+int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 {
 	struct mt76_queue *q =3D &dev->q_rx[qid];
=20
@@ -317,6 +316,7 @@ mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rx=
q_id qid)
=20
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt76s_alloc_rx_queue);
=20
 static struct mt76_queue *mt76s_alloc_tx_queue(struct mt76_dev *dev)
 {
@@ -338,7 +338,7 @@ static struct mt76_queue *mt76s_alloc_tx_queue(struct m=
t76_dev *dev)
 	return q;
 }
=20
-static int mt76s_alloc_tx(struct mt76_dev *dev)
+int mt76s_alloc_tx(struct mt76_dev *dev)
 {
 	struct mt76_queue *q;
 	int i;
@@ -361,18 +361,7 @@ static int mt76s_alloc_tx(struct mt76_dev *dev)
=20
 	return 0;
 }
-
-int mt76s_alloc_queues(struct mt76_dev *dev)
-{
-	int err;
-
-	err =3D mt76s_alloc_rx_queue(dev, MT_RXQ_MAIN);
-	if (err < 0)
-		return err;
-
-	return mt76s_alloc_tx(dev);
-}
-EXPORT_SYMBOL_GPL(mt76s_alloc_queues);
+EXPORT_SYMBOL_GPL(mt76s_alloc_tx);
=20
 static struct mt76_queue_entry *
 mt76s_get_next_rx_entry(struct mt76_queue *q)

--QAdqLtfNevhfWH71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYWcuGQAKCRA6cBh0uS2t
rJNnAQCwNHMHstCiqQtMr+bDWCW9idvTbolYG9YzPJuyC5fJEwD/Q0pLyoJmQ9Uh
0TCc/b8PopeGLYKwrPGfSwaCentLTQY=
=TnM+
-----END PGP SIGNATURE-----

--QAdqLtfNevhfWH71--
