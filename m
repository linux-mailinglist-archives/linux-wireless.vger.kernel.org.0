Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806C0715083
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjE2UWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjE2UW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 16:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42BDB
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 13:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE9A6286A
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 20:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F78C433D2;
        Mon, 29 May 2023 20:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685391745;
        bh=IxieHFKdleRTome4+rqjwTxmC1HoEPJDhWdJdJ34eSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6imlqs38OR3ciBtGbHwgPs/2iU5pLRW4XZO6AOIJcDltXIA1W3XnXQEOT7un3VFn
         YOlFcPOGEIWakakb4VCMMhVg9PrUAwz6IEOIP7EOBJb2QTzdrWqpK/aKecahzuYwAt
         8PZ3BQeEd1VXf6pWpQdEUpLrHqPoSPanmjIownIbGdbVnOwqqN/ICOpaeBxdJ0B9OR
         I7aYEr0cEaeRerVj6VWR7YXFL5sn8DjvGckEtQomUbif4x1O/hzbINAcc+fxwljCfg
         QYq3RW/VzCs9FbtNG3re4NqByWupahpwTRsc/Bpe0vaVgUx+iqTfqwWdyHaN+3lZYw
         9YV4NjGxujktQ==
Date:   Mon, 29 May 2023 22:22:21 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Rany Hany <rany_hany@riseup.net>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 04/13] wifi: mt76: mt7615: rely on shared sta_poll_list
 and sta_poll_lock
Message-ID: <ZHUJfSxIEOzjZnYt@lore-desk>
References: <cover.1685356673.git.lorenzo@kernel.org>
 <ed7b5c338fe5eb4084b98e08170a1d8bcda67181.1685356673.git.lorenzo@kernel.org>
 <f99f3a85-494a-b796-189a-99cf5976c3be@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4SZX1n0B3xMr+u1j"
Content-Disposition: inline
In-Reply-To: <f99f3a85-494a-b796-189a-99cf5976c3be@riseup.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--4SZX1n0B3xMr+u1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,

Hi,

>=20
> On 5/29/23 13:40, Lorenzo Bianconi wrote:
> > Rely on sta_poll_list and sta_poll_lock fields in mt76_dev structure
> > and get rid of private copies.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 --
> >  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 19 ++++++++++---------
> >  .../net/wireless/mediatek/mt76/mt7615/main.c  |  8 ++++----
> >  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 ---
> >  4 files changed, 14 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers=
/net/wireless/mediatek/mt76/mt7615/init.c
> > index 621e69f07e3c..155931978ed8 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > @@ -626,8 +626,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
> >  	INIT_DELAYED_WORK(&dev->coredump.work, mt7615_coredump_work);
> >  	skb_queue_head_init(&dev->phy.scan_event_list);
> >  	skb_queue_head_init(&dev->coredump.msg_list);
> > -	INIT_LIST_HEAD(&dev->sta_poll_list);
> > -	spin_lock_init(&dev->sta_poll_lock);
> >  	init_waitqueue_head(&dev->reset_wait);
> >  	init_waitqueue_head(&dev->phy.roc_wait);
> > =20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/=
net/wireless/mediatek/mt76/mt7615/mac.c
> > index d90378a30d15..a6d267c56dd4 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> > @@ -387,10 +387,11 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *=
dev, struct sk_buff *skb)
> >  		struct mt7615_sta *msta;
> > =20
> >  		msta =3D container_of(status->wcid, struct mt7615_sta, wcid);
> > -		spin_lock_bh(&dev->sta_poll_lock);
> > +		spin_lock_bh(&dev->mt76.sta_poll_lock);
> >  		if (list_empty(&msta->poll_list))
> > -			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
> > -		spin_unlock_bh(&dev->sta_poll_lock);
> > +			list_add_tail(&msta->poll_list,
> > +				      &dev->mt76.sta_poll_list);
> > +		spin_unlock_bh(&dev->mt76.sta_poll_lock);
> >  	}
> > =20
> >  	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) =3D=3D csum_mask &&
> > @@ -905,9 +906,9 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
> >  	int i;
> > =20
> >  	INIT_LIST_HEAD(&sta_poll_list);
> > -	spin_lock_bh(&dev->sta_poll_lock);
> > -	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
> > -	spin_unlock_bh(&dev->sta_poll_lock);
> > +	spin_lock_bh(&dev->mt76.sta_poll_lock);
> > +	list_splice_init(&dev->mt76.sta_poll_list, &sta_poll_list);
> > +	spin_unlock_bh(&dev->mt76.sta_poll_lock);
> > =20
> >  	while (!list_empty(&sta_poll_list)) {
> >  		bool clear =3D false;
> > @@ -1539,10 +1540,10 @@ static void mt7615_mac_add_txs(struct mt7615_de=
v *dev, void *data)
> >  	msta =3D container_of(wcid, struct mt7615_sta, wcid);
> >  	sta =3D wcid_to_sta(wcid);
> > =20
> > -	spin_lock_bh(&dev->sta_poll_lock);
> > +	spin_lock_bh(&dev->mt76.sta_poll_lock);
> >  	if (list_empty(&msta->poll_list))
> > -		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
> > -	spin_unlock_bh(&dev->sta_poll_lock);
> > +		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
> > +	spin_unlock_bh(&dev->mt76.sta_poll_lock);
> > =20
> >  	if (mt7615_mac_add_txs_skb(dev, msta, pid, txs_data))
> >  		goto out;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers=
/net/wireless/mediatek/mt76/mt7615/main.c
> > index ab4c1b4478aa..2a5462bd54c2 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > @@ -274,10 +274,10 @@ static void mt7615_remove_interface(struct ieee80=
211_hw *hw,
> > =20
> >  	mt7615_mutex_release(dev);
> > =20
> > -	spin_lock_bh(&dev->sta_poll_lock);
> > +	spin_lock_bh(&dev->mt76.sta_poll_lock);
> >  	if (!list_empty(&msta->poll_list))
> >  		list_del_init(&msta->poll_list);
> > -	spin_unlock_bh(&dev->sta_poll_lock);
> > +	spin_unlock_bh(&dev->mt76.sta_poll_lock);
> > =20
> >  	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
> >  }
> > @@ -677,10 +677,10 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev,=
 struct ieee80211_vif *vif,
> >  	if (vif->type =3D=3D NL80211_IFTYPE_STATION && !sta->tdls)
> >  		mt7615_mcu_add_bss_info(phy, vif, sta, false);
> > =20
> > -	spin_lock_bh(&dev->sta_poll_lock);
> > +	spin_lock_bh(&mdev->sta_poll_lock);
> >  	if (!list_empty(&msta->poll_list))
> >  		list_del_init(&msta->poll_list);
> > -	spin_unlock_bh(&dev->sta_poll_lock);
> > +	spin_unlock_bh(&mdev->sta_poll_lock);
> > =20
> >  	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
> >  }
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drive=
rs/net/wireless/mediatek/mt76/mt7615/mt7615.h
> > index 0381c53bc96a..7386495f8299 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> > @@ -262,9 +262,6 @@ struct mt7615_dev {
> >  	wait_queue_head_t reset_wait;
> >  	u32 reset_state;
> > =20
> > -	struct list_head sta_poll_list;
> > -	spinlock_t sta_poll_lock;
> > -
> >  	struct {
> >  		u8 n_pulses;
> >  		u32 period;
>=20
> From code review on GitHub, you did not update to use the shared sta_poll=
_lock in line 919 and 921.

The fix below is not part of wireless-next yet:

commit 30bc32c7c1f975cc3c14e1c7dc437266311282cf
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Wed May 24 16:39:32 2023 +0200

    wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll

I will repost when it is merged in wireless-next/Felix's tree.

Regards,
Lorenzo

--4SZX1n0B3xMr+u1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZHUJfQAKCRA6cBh0uS2t
rGDqAQDDd2ENMEUe0cmotTJapwxZwHI2qfYi7ygNpET4scsrzwD+Knoex1okLxnz
3qTifT8hTQta8ipjGQzfbd9mCd9MhA8=
=/DRg
-----END PGP SIGNATURE-----

--4SZX1n0B3xMr+u1j--
