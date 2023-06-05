Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6656972212B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjFEIid (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 04:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjFEIic (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 04:38:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBABB0
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 01:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 574F760F08
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 08:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374E7C433EF;
        Mon,  5 Jun 2023 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685954309;
        bh=FpfnvUQhWVZaybmqz1YUMo//OZ9kl1EufoIqVMKrzbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfUI7Iz2cw0pAgFr8VG6BTB4CP1ZUe6qhGfWPvstY8DFESSiwV+XUgZsielDD+aSd
         7b9yC0EPrvmchLLYUIvH7Bkazzemg9lZkx6SaUrszR5L/m50Xo0DueqkXp7J9TDWrG
         fDus9a4LQ+1uJlUQBvUv4bblG4BbM+9vnXH0UZIdMeQeXKjoUN7nn5qQQDyVTV3y4l
         rrmBYMDdooegXX6KyqmOHoc8WFnPTY+IF0ddY0pVsaWRommvTzfVgME5MP2WYAUWUs
         5eiaUHopT2O0Ca6MEI0ChqIf+ZnlsAg2G2c8PYw7FGwB3yIEAuWcQP94VkPeVAfJNy
         NdC0tC6+lY18A==
Date:   Mon, 5 Jun 2023 10:38:25 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH v2 02/10] wifi: mt76: connac: add support for dsp
 firmware download
Message-ID: <ZH2fAWYfp2rdurwT@lore-desk>
References: <20230605081947.12804-1-shayne.chen@mediatek.com>
 <20230605081947.12804-2-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BH+RWSTZYkM9p1ri"
Content-Disposition: inline
In-Reply-To: <20230605081947.12804-2-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--BH+RWSTZYkM9p1ri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Peter Chiu <chui-hao.chiu@mediatek.com>
>=20
> Add FW_START_WORKING_PDA_DSP for the indication of starting DSP
> firmware download, which is for phy-related control.
> The firmware is transparent to the driver, but it's necessary for the
> firmware download process.
>=20
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
> v2:
>   - merge two commits:
>     - wifi: mt76: connac: add a setting bit for dsp firmware
>     - wifi: mt76: mt7996: add dsp firmware download
>   - move main code for loading ram to a regular function
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 70 +++++++++----------
>  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  7 ++
>  .../net/wireless/mediatek/mt76/mt7996/pci.c   |  1 +
>  4 files changed, 43 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index ca1ce97a6d2f..4a21c237ea6e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -22,6 +22,7 @@
> =20
>  #define FW_START_OVERRIDE		BIT(0)
>  #define FW_START_WORKING_PDA_CR4	BIT(2)
> +#define FW_START_WORKING_PDA_DSP	BIT(3)
> =20
>  #define PATCH_SEC_NOT_SUPPORT		GENMASK(31, 0)
>  #define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 88e2f9d0e513..28930693a75a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -2155,7 +2155,7 @@ static int mt7996_load_patch(struct mt7996_dev *dev)
>  static int
>  mt7996_mcu_send_ram_firmware(struct mt7996_dev *dev,
>  			     const struct mt7996_fw_trailer *hdr,
> -			     const u8 *data, bool is_wa)
> +			     const u8 *data, enum mt7996_ram_type type)
>  {
>  	int i, offset =3D 0;
>  	u32 override =3D 0, option =3D 0;
> @@ -2167,8 +2167,10 @@ mt7996_mcu_send_ram_firmware(struct mt7996_dev *de=
v,
> =20
>  		region =3D (const struct mt7996_fw_region *)((const u8 *)hdr -
>  			 (hdr->n_region - i) * sizeof(*region));
> +		/* DSP and WA use same mode */
>  		mode =3D mt76_connac_mcu_gen_dl_mode(&dev->mt76,
> -						   region->feature_set, is_wa);
> +						   region->feature_set,
> +						   type !=3D MT7996_RAM_TYPE_WM);
>  		len =3D le32_to_cpu(region->len);
>  		addr =3D le32_to_cpu(region->addr);
> =20
> @@ -2195,19 +2197,22 @@ mt7996_mcu_send_ram_firmware(struct mt7996_dev *d=
ev,
>  	if (override)
>  		option |=3D FW_START_OVERRIDE;
> =20
> -	if (is_wa)
> +	if (type =3D=3D MT7996_RAM_TYPE_WA)
>  		option |=3D FW_START_WORKING_PDA_CR4;
> +	else if (type =3D=3D MT7996_RAM_TYPE_DSP)
> +		option |=3D FW_START_WORKING_PDA_DSP;
> =20
>  	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
>  }
> =20
> -static int mt7996_load_ram(struct mt7996_dev *dev)
> +static int __mt7996_load_ram(struct mt7996_dev *dev, const char *fw_type,
> +			     const char *fw_file, enum mt7996_ram_type ram_type)
>  {
>  	const struct mt7996_fw_trailer *hdr;
>  	const struct firmware *fw;
>  	int ret;
> =20
> -	ret =3D request_firmware(&fw, MT7996_FIRMWARE_WM, dev->mt76.dev);
> +	ret =3D request_firmware(&fw, fw_file, dev->mt76.dev);
>  	if (ret)
>  		return ret;
> =20
> @@ -2217,48 +2222,41 @@ static int mt7996_load_ram(struct mt7996_dev *dev)
>  		goto out;
>  	}
> =20
> -	hdr =3D (const struct mt7996_fw_trailer *)(fw->data + fw->size - sizeof=
(*hdr));
> -
> -	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\=
n",
> -		 hdr->fw_ver, hdr->build_date);
> +	hdr =3D (const void *)(fw->data + fw->size - sizeof(*hdr));
> +	dev_info(dev->mt76.dev, "%s Firmware Version: %.10s, Build Time: %.15s\=
n",
> +		 fw_type, hdr->fw_ver, hdr->build_date);
> =20
> -	ret =3D mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, false);
> +	ret =3D mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, ram_type);
>  	if (ret) {
> -		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
> +		dev_err(dev->mt76.dev, "Failed to start %s firmware\n", fw_type);
>  		goto out;
>  	}
> =20
> +out:
>  	release_firmware(fw);
> =20
> -	ret =3D request_firmware(&fw, MT7996_FIRMWARE_WA, dev->mt76.dev);
> -	if (ret)
> -		return ret;
> -
> -	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
> -		dev_err(dev->mt76.dev, "Invalid firmware\n");
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -
> -	hdr =3D (const struct mt7996_fw_trailer *)(fw->data + fw->size - sizeof=
(*hdr));
> -
> -	dev_info(dev->mt76.dev, "WA Firmware Version: %.10s, Build Time: %.15s\=
n",
> -		 hdr->fw_ver, hdr->build_date);
> +	return ret;
> +}
> =20
> -	ret =3D mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, true);
> -	if (ret) {
> -		dev_err(dev->mt76.dev, "Failed to start WA firmware\n");
> -		goto out;
> -	}
> +static int mt7996_load_ram(struct mt7996_dev *dev)
> +{
> +	int ret;
> =20
> -	snprintf(dev->mt76.hw->wiphy->fw_version,
> -		 sizeof(dev->mt76.hw->wiphy->fw_version),
> -		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);

doing so we do not advertise fw version through ethtool as before.

> +#define LOAD_RAM(_type) \
> +	do {								\
> +		ret =3D __mt7996_load_ram(dev, #_type,			\
> +					MT7996_FIRMWARE_##_type,	\
> +					MT7996_RAM_TYPE_##_type);	\
> +		if (ret)						\
> +			return ret;					\
> +	} while (0)
> =20
> -out:
> -	release_firmware(fw);
> +	LOAD_RAM(WM);
> +	LOAD_RAM(DSP);
> +	LOAD_RAM(WA);

can you please run the function directly instead of using macros?

Regards,
Lorenzo

> +#undef LOAD_RAM
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static int
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers=
/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index 4d7dcb95a620..7dfdc7384056 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -29,6 +29,7 @@
> =20
>  #define MT7996_FIRMWARE_WA		"mediatek/mt7996/mt7996_wa.bin"
>  #define MT7996_FIRMWARE_WM		"mediatek/mt7996/mt7996_wm.bin"
> +#define MT7996_FIRMWARE_DSP		"mediatek/mt7996/mt7996_dsp.bin"
>  #define MT7996_ROM_PATCH		"mediatek/mt7996/mt7996_rom_patch.bin"
> =20
>  #define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
> @@ -52,6 +53,12 @@ struct mt7996_sta;
>  struct mt7996_dfs_pulse;
>  struct mt7996_dfs_pattern;
> =20
> +enum mt7996_ram_type {
> +	MT7996_RAM_TYPE_WM,
> +	MT7996_RAM_TYPE_WA,
> +	MT7996_RAM_TYPE_DSP,
> +};
> +
>  enum mt7996_txq_id {
>  	MT7996_TXQ_FWDL =3D 16,
>  	MT7996_TXQ_MCU_WM,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/pci.c
> index 64aee3fb5445..c5301050ff8b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
> @@ -219,4 +219,5 @@ MODULE_DEVICE_TABLE(pci, mt7996_pci_device_table);
>  MODULE_DEVICE_TABLE(pci, mt7996_hif_device_table);
>  MODULE_FIRMWARE(MT7996_FIRMWARE_WA);
>  MODULE_FIRMWARE(MT7996_FIRMWARE_WM);
> +MODULE_FIRMWARE(MT7996_FIRMWARE_DSP);
>  MODULE_FIRMWARE(MT7996_ROM_PATCH);
> --=20
> 2.39.2
>=20

--BH+RWSTZYkM9p1ri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZH2fAQAKCRA6cBh0uS2t
rN0xAQCc/tEdcIcDtbomC+lWHkhiOCA+vTqvGAgwPgRIh2VrfQEArKxaJshTgBCE
IDKOHKkWjVMByTTJc0/LNo/fx3O26wg=
=+96M
-----END PGP SIGNATURE-----

--BH+RWSTZYkM9p1ri--
