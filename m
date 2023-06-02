Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFC7208AC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjFBR4X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 13:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjFBR4X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 13:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C9E9F
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 10:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B35260F15
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 17:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633EAC433D2;
        Fri,  2 Jun 2023 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728580;
        bh=8yue4xilRyaQsMiVjlHlQeQYRo0FKrbIUqRhX5fye5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIChVH2dfBCLPa5DIf8NjAf41FokbariDuJFdZCQQBnEtDZ/ENaLfpdZpunuRZD9G
         gG2/s1ZRazl/+ZW/8Q/RjZ/LqnxKXofXTp6DZ778HdFshv9BsSwr5CfCXfL8fkz2vO
         GKNMw1iPXex9yDnZXP6IgzJVwvCDVOgAMIrgDPmlNSlDs20/M9F7deDdTipVWtUzUm
         HTpFLojCRj0gu9kEDYGnnYwpwiOxqQyiYT+bPEhVj8wh2TItemIuH8ZfHQSaZ+mpEw
         k4jVDlXfuUxSpzT6+2xuAojDfwY2V5HFm/61pnr/ed3EMT87ts030VvDwUftwEeNFy
         ++8UqMk485ITw==
Date:   Fri, 2 Jun 2023 19:56:17 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH 03/12] wifi: mt76: mt7996: add dsp firmware download
Message-ID: <ZHotQTUHbWOt/ibt@lore-desk>
References: <20230602152108.26860-1-shayne.chen@mediatek.com>
 <20230602152108.26860-3-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w0Vi6PSzLjcSP4bf"
Content-Disposition: inline
In-Reply-To: <20230602152108.26860-3-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--w0Vi6PSzLjcSP4bf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Peter Chiu <chui-hao.chiu@mediatek.com>
>=20
> Add DSP firmware for phy-related control. The firmware is transparent to
> driver, but it's necessary for the firmware download process.
>=20
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 94 ++++++++-----------
>  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  7 ++
>  .../net/wireless/mediatek/mt76/mt7996/pci.c   |  1 +
>  3 files changed, 49 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 88e2f9d0e513..243647dbd8c7 100644
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
> @@ -2195,8 +2197,10 @@ mt7996_mcu_send_ram_firmware(struct mt7996_dev *de=
v,
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
> @@ -2207,56 +2211,40 @@ static int mt7996_load_ram(struct mt7996_dev *dev)
>  	const struct firmware *fw;
>  	int ret;
> =20
> -	ret =3D request_firmware(&fw, MT7996_FIRMWARE_WM, dev->mt76.dev);
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
> -	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\=
n",
> -		 hdr->fw_ver, hdr->build_date);
> -
> -	ret =3D mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, false);
> -	if (ret) {
> -		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
> -		goto out;
> -	}
> -
> -	release_firmware(fw);
> -
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
> -
> -	ret =3D mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, true);
> -	if (ret) {
> -		dev_err(dev->mt76.dev, "Failed to start WA firmware\n");
> -		goto out;
> -	}
> -
> -	snprintf(dev->mt76.hw->wiphy->fw_version,
> -		 sizeof(dev->mt76.hw->wiphy->fw_version),
> -		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
> -
> -out:
> -	release_firmware(fw);
> +#define LOAD_RAM(_type) \

I think it would be better to used a regular function instead of a macro, t=
he
code would be much easier to read.

Regards,
Lorenzo

> +	do {									\
> +		ret =3D request_firmware(&fw, MT7996_FIRMWARE_##_type, dev->mt76.dev);\
> +		if (ret)							\
> +			return ret;						\
> +										\
> +		if (!fw || !fw->data || fw->size < sizeof(*hdr)) {		\
> +			dev_err(dev->mt76.dev, "Invalid firmware\n");		\
> +			release_firmware(fw);					\
> +			return -EINVAL;						\
> +		}								\
> +										\
> +		hdr =3D (const struct mt7996_fw_trailer *)			\
> +				(fw->data + fw->size - sizeof(*hdr));		\
> +										\
> +		dev_info(dev->mt76.dev,						\
> +			 "%s Firmware Version: %.10s, Build Time: %.15s\n",	\
> +			 #_type, hdr->fw_ver, hdr->build_date);			\
> +										\
> +		ret =3D mt7996_mcu_send_ram_firmware(dev, hdr, fw->data,		\
> +						   MT7996_RAM_TYPE_##_type);    \
> +		if (ret) {							\
> +			dev_err(dev->mt76.dev, "Failed to start %s firmware\n", #_type);\
> +			release_firmware(fw);					\
> +			return ret;						\
> +		}								\
> +										\
> +		release_firmware(fw);						\
> +	} while (0)
> +
> +	LOAD_RAM(WM);
> +	LOAD_RAM(DSP);
> +	LOAD_RAM(WA);
> +#undef LOAD_RAM
> =20
>  	return ret;
>  }
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

--w0Vi6PSzLjcSP4bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZHotQQAKCRA6cBh0uS2t
rI+2AP9JwztB0J7bhORcjbMstE48lPGB26xDTTFr7tbvsLKbkAEAtmtX3Sy925FL
IsSxPfB4cG4qVyfxcYwOQWlSHHbteQU=
=YhC5
-----END PGP SIGNATURE-----

--w0Vi6PSzLjcSP4bf--
