Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7464D0B63
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 23:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiCGWtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 17:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbiCGWs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 17:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91AA656C2E
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 14:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646693281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4l17NtUg/2qSB9utxPA3lCpWe8wKiOV5UHWKOcozVk=;
        b=CCYUeXDBEOskkSJAXOni0auZ4fVmMp7ZXDYYfVjvIBQM7d/zBRC/MSz8CRoYuPfDO50BAL
        8jw1L1WVceRuodMgFtDPSwhXhoejG0FTI0lOvnTTQIB9QZeYAWF1X0LvIs5bhX7+y66JuK
        haWqDNavmQO4ZPyyEBKHztqPkLcfGD4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-g6ugnZ0INjuJW2xluCOt6g-1; Mon, 07 Mar 2022 17:48:00 -0500
X-MC-Unique: g6ugnZ0INjuJW2xluCOt6g-1
Received: by mail-qk1-f198.google.com with SMTP id s71-20020a37a94a000000b00648c7f2b289so12745537qke.12
        for <linux-wireless@vger.kernel.org>; Mon, 07 Mar 2022 14:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4l17NtUg/2qSB9utxPA3lCpWe8wKiOV5UHWKOcozVk=;
        b=CLr7yqHdAlt9OCRsQGLXxs2W3pb1yTfQtO4rS6/EFI95Ck7FyUjGhcUl3XSTp6eGxe
         uEJSX6eMsn36BwJtWcplh0HzIjlrL6FpW4F68Qll1tKTDVQOKXe0a+sAVzL8b7UB2BIk
         XKfn93wXdgOZgtojLiCA1QnRC5c/MWTWnozIl93JOLvX3v7ZH3aLb50x7y+iuHnaQOjU
         hYc4unN1+d+co4XOOb1ECSEE2Hr9llmNltAcZtMFJayxKJcwGVj0vEhCbUUuPkno5XDy
         Qehi9ZwJPGSS4IaTbDxlzVPqsA0Bpq4/TZIlW0ipIn8WMtsw/LXTkWBsp34cjePjC1lI
         gt5Q==
X-Gm-Message-State: AOAM530B5pc89gePdDWs3pa7V4at065652SeoKZJ2IJNiYNYeinNkFNN
        jTtWFxMKx7gl1JuegC8cfRnlLXt4Tjo/IDXMPD2hp8ea4RqxrVUcq0A36oPAFvh4KLno3gGTi3L
        XvnQr3YUYzL6eUD0ZWMVWiUE0hWg=
X-Received: by 2002:ac8:4e46:0:b0:2cb:28cc:2157 with SMTP id e6-20020ac84e46000000b002cb28cc2157mr11399621qtw.167.1646693274922;
        Mon, 07 Mar 2022 14:47:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcgJP//sec9YUVIExe+YiSKE3N/wCsSa0MisM99MctdIJrdqhtw9gN3bVHYVXe6E/ckFThWg==
X-Received: by 2002:ac8:4e46:0:b0:2cb:28cc:2157 with SMTP id e6-20020ac84e46000000b002cb28cc2157mr11399606qtw.167.1646693274646;
        Mon, 07 Mar 2022 14:47:54 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id q9-20020a05622a030900b002dd2c3a9fccsm9812369qtw.38.2022.03.07.14.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:47:54 -0800 (PST)
Date:   Mon, 7 Mar 2022 23:47:51 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Deren.Wu@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: move mt7921_init_hw in a dedicated work
Message-ID: <YiaLl++oijKrByBA@lore-desk>
References: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
 <1646689596-21189-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4rL/TNDZ89nVV1r"
Content-Disposition: inline
In-Reply-To: <1646689596-21189-1-git-send-email-sean.wang@mediatek.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--G4rL/TNDZ89nVV1r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >Firmware initialization can take a while. Move mt7921_init_hw routine in=
 a dedicated work in order to not slow down bootstrap process.
>=20
> Hi, Lore

Hi Sean,

>=20
> I don't think the patch is really needed and it creates the different sta=
te of the driver after mt7921_*_probe between without and with the patch
> we should be careful to handle it.
>=20
> For example.
>=20
> 1) It is possible that ieee80211_ops mt7921_ops is working while mt7921_i=
nit_work is not completed, so that creates the race issue between ieee80211=
_ops mt7921_ops and mt7921_init_work still in progress

Can you please elaborate on this? The device will not be "visible" to mac80=
211
till init_work completes since we run mt76_register_device() in
mt7921_init_work().

>=20
> 2) mt7921[k,s,e].ko are always successful probed ( the .ko are always sho=
wn in `lsmod` ) that would confuse the users even when we actually got the =
failure of hardware initialization in mt7921_init_work

If mt7921_init_work fails, we will remove the wiphy, so it will not be visi=
ble
to the user.

>=20
> so I would prefer to wait a while in mt7921_*_proble until the hardware i=
s ready to be working to get rid of the extra synchronization to be added a=
s well as keep the driver much simple.

In the current codebase the time needed for device probing is quite visible=
 on
usb (afaiu this time is needed for fw initialization).

Regards,
Lorenzo

>=20
>         Sean
>=20
> >
> >Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >---
> > .../net/wireless/mediatek/mt76/mt7921/init.c  | 66 +++++++++++++------
> > .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
> > 2 files changed, 49 insertions(+), 19 deletions(-)
> >
> >diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/init.c
> >index fa6af85bba7b..332af886b95a 100644
> >--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> >+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> >@@ -165,7 +165,7 @@ static int __mt7921_init_hardware(struct mt7921_dev =
*dev)
> >
> > static int mt7921_init_hardware(struct mt7921_dev *dev)  {
> >-	int ret, idx, i;
> >+	int ret, i;
> >
> >	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
> >
> >@@ -182,6 +182,13 @@ static int mt7921_init_hardware(struct mt7921_dev *=
dev)
> >		return ret;
> >	}
> >
> >+	return 0;
> >+}
> >+
> >+static int mt7921_init_wcid(struct mt7921_dev *dev) {
> >+	int idx;
> >+
> >	/* Beacon and mgmt frames should occupy wcid 0 */
> >	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
> >	if (idx)
> >@@ -195,6 +202,42 @@ static int mt7921_init_hardware(struct mt7921_dev *=
dev)
> >	return 0;
> > }
> >
> >+static void mt7921_init_work(struct work_struct *work) {
> >+	struct mt7921_dev *dev =3D container_of(work, struct mt7921_dev,
> >+					      init_work);
> >+	int ret;
> >+
> >+	ret =3D mt7921_init_hardware(dev);
> >+	if (ret)
> >+		return;
> >+
> >+	mt76_set_stream_caps(&dev->mphy, true);
> >+	mt7921_set_stream_he_caps(&dev->phy);
> >+
> >+	ret =3D mt76_register_device(&dev->mt76, true, mt76_rates,
> >+				   ARRAY_SIZE(mt76_rates));
> >+	if (ret) {
> >+		dev_err(dev->mt76.dev, "register device failed\n");
> >+		return;
> >+	}
> >+
> >+	ret =3D mt7921_init_debugfs(dev);
> >+	if (ret) {
> >+		dev_err(dev->mt76.dev, "debugfs register failed\n");
> >+		goto error;
> >+	}
> >+
> >+	ret =3D mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
> >+	if (ret)
> >+		goto error;
> >+
> >+	dev->hw_init_done =3D true;
> >+	return;
> >+error:
> >+	mt76_unregister_device(&dev->mt76);
> >+}
> >+
> > int mt7921_register_device(struct mt7921_dev *dev)  {
> >	struct ieee80211_hw *hw =3D mt76_hw(dev); @@ -222,6 +265,7 @@ int mt792=
1_register_device(struct mt7921_dev *dev)
> >	spin_lock_init(&dev->sta_poll_lock);
> >
> >	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
> >+	INIT_WORK(&dev->init_work, mt7921_init_work);
> >
> >	dev->pm.idle_timeout =3D MT7921_PM_TIMEOUT;
> >	dev->pm.stats.last_wake_event =3D jiffies; @@ -234,7 +278,7 @@ int mt79=
21_register_device(struct mt7921_dev *dev)
> >	if (mt76_is_sdio(&dev->mt76))
> >		hw->extra_tx_headroom +=3D MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
> >
> >-	ret =3D mt7921_init_hardware(dev);
> >+	ret =3D mt7921_init_wcid(dev);
> >	if (ret)
> >		return ret;
> >
> >@@ -262,23 +306,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
> >	dev->mphy.hw->wiphy->available_antennas_rx =3D dev->mphy.chainmask;
> >	dev->mphy.hw->wiphy->available_antennas_tx =3D dev->mphy.chainmask;
> >
> >-	mt76_set_stream_caps(&dev->mphy, true);
> >-	mt7921_set_stream_he_caps(&dev->phy);
> >-
> >-	ret =3D mt76_register_device(&dev->mt76, true, mt76_rates,
> >-				   ARRAY_SIZE(mt76_rates));
> >-	if (ret)
> >-		return ret;
> >-
> >-	ret =3D mt7921_init_debugfs(dev);
> >-	if (ret)
> >-		return ret;
> >-
> >-	ret =3D mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
> >-	if (ret)
> >-		return ret;
> >-
> >-	dev->hw_init_done =3D true;
> >+	queue_work(system_wq, &dev->init_work);
> >
> >	return 0;
> > }
> >diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/driver=
s/net/wireless/mediatek/mt76/mt7921/mt7921.h
> >index 394a677140da..b6c8f84acb64 100644
> >--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> >+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> >@@ -204,6 +204,8 @@ struct mt7921_dev {
> >	struct list_head sta_poll_list;
> >	spinlock_t sta_poll_lock;
> >
> >+	struct work_struct init_work;
> >+
> >	u8 fw_debug;
> >
> >	struct mt76_connac_pm pm;
> >--
> >2.35.1
> >
> >
> >
>=20

--G4rL/TNDZ89nVV1r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYiaLlwAKCRA6cBh0uS2t
rINRAPwMEqqJSqZrKkBMHnZCGKdl0qG2LgtbR+2tHRFZb/NW+gEA5LiyDV3v8BRa
zfjJ/6daLh/EcA8bJGgw2xEvs6FUBQw=
=aVQc
-----END PGP SIGNATURE-----

--G4rL/TNDZ89nVV1r--

