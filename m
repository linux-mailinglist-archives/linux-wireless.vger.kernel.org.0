Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F473636D3
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhDRQs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhDRQs4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:48:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B66E61245;
        Sun, 18 Apr 2021 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764508;
        bh=hGK/bKp5Rc2fWGkeOakaqJlW7ekqkPbHFVW5k9rfNss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkwhqnwj0EnmZo/2nGY1yHlc60munrbGIyicCBgB6ITJEt8tWOVn5I+PitFgSN0pF
         y6DAwOmRjAzQ4aJZ5fLrA/xi9l4ZR3ZcnvzWYg+Skc36vL8HYajzQSeo2tsygZX2fx
         ge+19jEQ+8v2ZWXR8bkX4oPrMGjNDQ+Cmr40sY6clGUxNJZ4kmuHm1I6gRoFX6NKNn
         5LpDBs+MwAovEttBOPjWZHa8MFZ3W+IwNVmSLL0Xqt/nQWZhaCCU41maKYP1tVDAA0
         mUzh4oaMZpwcHKJwdkiA83r7KherA5q6naYkn9guqGzGwrm1BOA/DwREgyUE6AuMUZ
         4m8DYrRz6TJyw==
Date:   Sun, 18 Apr 2021 18:48:23 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/6] mt76: mt7921: introduce mt7921_wpdma_reinit_cond
 utility routine
Message-ID: <YHxi1+jRHIfAuKJa@lore-desk>
References: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
 <1618763767-1292-5-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P/CfuldqDC55MrOp"
Content-Disposition: inline
In-Reply-To: <1618763767-1292-5-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--P/CfuldqDC55MrOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>

I guess here we should use my 'From' tag

Regards,
Lorenzo

>=20
> Add mt7921_wpdma_reinit_cond to check dummy reg if driver needs to
> reinitialized WPDMA after driver_own operation
>=20
> Co-developed-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt76_connac.h  |  4 +++
>  .../wireless/mediatek/mt76/mt7921/debugfs.c   | 13 ++++++++++
>  .../net/wireless/mediatek/mt76/mt7921/dma.c   | 25 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  6 +++++
>  4 files changed, 48 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index b811f3c410a1..3b5bff80a462 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -58,6 +58,10 @@ struct mt76_connac_pm {
>  	struct delayed_work ps_work;
>  	unsigned long last_activity;
>  	unsigned long idle_timeout;
> +
> +	struct {
> +		unsigned int lp_wake;
> +	} stats;
>  };
> =20
>  struct mt76_connac_coredump {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/debugfs.c
> index 5a54cd8d2ce4..bd2aca654767 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> @@ -256,6 +256,17 @@ mt7921_pm_get(void *data, u64 *val)
> =20
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7921_pm_get, mt7921_pm_set, "%lld\n"=
);
> =20
> +static int
> +mt7921_pm_stats(struct seq_file *s, void *data)
> +{
> +	struct mt7921_dev *dev =3D dev_get_drvdata(s->private);
> +	struct mt76_connac_pm *pm =3D &dev->pm;
> +
> +	seq_printf(s, "low power wakes: %9d\n", pm->stats.lp_wake);
> +
> +	return 0;
> +}
> +
>  static int
>  mt7921_pm_idle_timeout_set(void *data, u64 val)
>  {
> @@ -322,6 +333,8 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
>  	debugfs_create_file("idle-timeout", 0600, dir, dev,
>  			    &fops_pm_idle_timeout);
>  	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
> +	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
> +				    mt7921_pm_stats);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/dma.c
> index 8c556ff3ae93..72f5704f8f11 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> @@ -329,6 +329,31 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool =
force)
>  	return 0;
>  }
> =20
> +int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
> +{
> +	struct mt76_connac_pm *pm =3D &dev->pm;
> +	int err;
> +
> +	/* check if the wpdma must be reinitialized */
> +	if (mt7921_dma_need_reinit(dev)) {
> +		/* disable interrutpts */
> +		mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
> +		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
> +
> +		err =3D mt7921_wpdma_reset(dev, false);
> +		if (err) {
> +			dev_err(dev->mt76.dev, "wpdma reset failed\n");
> +			return err;
> +		}
> +
> +		/* enable interrutpts */
> +		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
> +		pm->stats.lp_wake++;
> +	}
> +
> +	return 0;
> +}
> +
>  int mt7921_dma_init(struct mt7921_dev *dev)
>  {
>  	/* Increase buffer size to receive large VHT/HE MPDUs */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 06a85d2d1c6f..bb4961d3969a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -254,6 +254,7 @@ int mt7921_eeprom_get_target_power(struct mt7921_dev =
*dev,
>  void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
>  int mt7921_dma_init(struct mt7921_dev *dev);
>  int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
> +int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
>  void mt7921_dma_cleanup(struct mt7921_dev *dev);
>  int mt7921_run_firmware(struct mt7921_dev *dev);
>  int mt7921_mcu_init(struct mt7921_dev *dev);
> @@ -317,6 +318,11 @@ mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 =
mask, u32 val)
>  #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
>  #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
> =20
> +static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
> +{
> +	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
> +}
> +
>  void mt7921_mac_init(struct mt7921_dev *dev);
>  bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
>  void mt7921_mac_reset_counters(struct mt7921_phy *phy);
> --=20
> 2.25.1
>=20

--P/CfuldqDC55MrOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHxi0wAKCRA6cBh0uS2t
rIccAP9f22Fh/Hgkh5U4dHrEZ1CL0QW1qBlhR5ixaZEb8dVmewD+LiyFwP0xi52s
3M//eDzUTLAdcWShx9DQl/5SHJN/dAs=
=NgMi
-----END PGP SIGNATURE-----

--P/CfuldqDC55MrOp--
