Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B87487623
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 12:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiAGLEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 06:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiAGLEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 06:04:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401EC061245
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jan 2022 03:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D1F60F41
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jan 2022 11:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05910C36AE0;
        Fri,  7 Jan 2022 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641553444;
        bh=hHRnJgF0n4XEHlCiBDccrPeUfq6UqlwVYpHA/C1Ogqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqhguKE2GiBKHvvR12kfYJDyH89G8R05Izix7Lwh60DVh2kDNd8AzqMhWSEmcHlZz
         HUjVF4Kyjve8vU84DEPk16fvslMg34/cOzBzk4R0akxSu00ugmFHp7Ykcf8zPpNfSk
         GuOebtXJLhQM+8IGYpnPOz3SQJuxTabWLTz3IhcEwRb1gZ+8Ri5FzqQD/UG/jPhumW
         CeZHuy0T3dGcXo37RtPa9mgc15Hj13IAta7upfxIF5RflHpbymMFFOefFeoWC/7L+P
         7F2BJoF3odKYHpH6LEdlT59WiEn870lkQarGOWjKlRGKBfaK/Z8SIS1PV6M7XA51D6
         t1chV7SMIS/XA==
Date:   Fri, 7 Jan 2022 12:04:02 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7915: add support for passing chip/firmware
 debug data to user space
Message-ID: <YdgeInxumJUyjHoK@localhost.localdomain>
References: <20220105111642.80333-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VGZXXzPvwK2aNwKM"
Content-Disposition: inline
In-Reply-To: <20220105111642.80333-1-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--VGZXXzPvwK2aNwKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This can be used to assist in debugging driver or firmware tx/rx issues.
> The data is streamed to user space using a relay file in debugfs
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 142 +++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   |   6 +
>  .../net/wireless/mediatek/mt76/mt7915/mac.h   |   1 +
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   7 +-
>  .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   2 +
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |   6 +
>  .../net/wireless/mediatek/mt76/mt7915/regs.h  |   2 +
>  7 files changed, 162 insertions(+), 4 deletions(-)

I guess we need to select RELAY in mt7915 Kconfig.

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index c59ef08a5306..dad25dfb946c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -1,9 +1,13 @@
>  // SPDX-License-Identifier: ISC
>  /* Copyright (C) 2020 MediaTek Inc. */
> =20
> +#include <linux/relay.h>
>  #include "mt7915.h"
>  #include "eeprom.h"
>  #include "mcu.h"
> +#include "mac.h"
> +
> +#define FW_BIN_LOG_MAGIC	0x44e98caf
> =20
>  /** global debugfs **/
> =20
> @@ -311,16 +315,31 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
>  		DEBUG_SPL,
>  		DEBUG_RPT_RX,
>  	} debug;
> +	bool tx, rx, en;
>  	int ret;
> =20
>  	dev->fw_debug_wm =3D val ? MCU_FW_LOG_TO_HOST : 0;
> =20
> -	ret =3D mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, dev->fw_debug_wm);
> +	if (dev->fw_debug_bin)
> +		val =3D 16;
> +	else
> +		val =3D dev->fw_debug_wm;
> +
> +	tx =3D dev->fw_debug_wm || (dev->fw_debug_bin & BIT(1));
> +	rx =3D dev->fw_debug_wm || (dev->fw_debug_bin & BIT(2));
> +	en =3D dev->fw_debug_wm || (dev->fw_debug_bin & BIT(0));
> +
> +	ret =3D mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, val);
>  	if (ret)
>  		return ret;
> =20
>  	for (debug =3D DEBUG_TXCMD; debug <=3D DEBUG_RPT_RX; debug++) {
> -		ret =3D mt7915_mcu_fw_dbg_ctrl(dev, debug, !!dev->fw_debug_wm);
> +		if (debug =3D=3D DEBUG_RPT_RX)
> +			val =3D en && rx;
> +		else
> +			val =3D en && tx;
> +
> +		ret =3D mt7915_mcu_fw_dbg_ctrl(dev, debug, val);
>  		if (ret)
>  			return ret;
>  	}
> @@ -376,6 +395,65 @@ mt7915_fw_debug_wa_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7915_fw_debug_wa_get,
>  			 mt7915_fw_debug_wa_set, "%lld\n");
> =20
> +static struct dentry *
> +create_buf_file_cb(const char *filename, struct dentry *parent, umode_t =
mode,
> +		   struct rchan_buf *buf, int *is_global)
> +{
> +	struct dentry *f;
> +
> +	f =3D debugfs_create_file("fwlog_data", mode, parent, buf,
> +				&relay_file_operations);
> +	if (IS_ERR(f))
> +		return NULL;
> +
> +	*is_global =3D 1;
> +
> +	return f;
> +}
> +
> +static int
> +remove_buf_file_cb(struct dentry *f)
> +{
> +	debugfs_remove(f);
> +
> +	return 0;
> +}
> +
> +static int
> +mt7915_fw_debug_bin_set(void *data, u64 val)
> +{
> +	static struct rchan_callbacks relay_cb =3D {
> +		.create_buf_file =3D create_buf_file_cb,
> +		.remove_buf_file =3D remove_buf_file_cb,
> +	};
> +	struct mt7915_dev *dev =3D data;
> +
> +	if (!dev->relay_fwlog)
> +		dev->relay_fwlog =3D relay_open("fwlog_data", dev->debugfs_dir,
> +					    1500, 512, &relay_cb, NULL);
> +	if (!dev->relay_fwlog)
> +		return -ENOMEM;
> +
> +	dev->fw_debug_bin =3D val;
> +
> +	relay_reset(dev->relay_fwlog);
> +
> +	return mt7915_fw_debug_wm_set(dev, dev->fw_debug_wm);
> +}
> +
> +static int
> +mt7915_fw_debug_bin_get(void *data, u64 *val)
> +{
> +	struct mt7915_dev *dev =3D data;
> +
> +	*val =3D dev->fw_debug_bin;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_bin, mt7915_fw_debug_bin_get,
> +			 mt7915_fw_debug_bin_set, "%lld\n");
> +
>  static int
>  mt7915_fw_util_wm_show(struct seq_file *file, void *data)
>  {
> @@ -757,6 +835,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
>  	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
>  	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
>  	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
> +	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
>  	debugfs_create_file("fw_util_wm", 0400, dir, dev,
>  			    &mt7915_fw_util_wm_fops);
>  	debugfs_create_file("fw_util_wa", 0400, dir, dev,
> @@ -775,9 +854,68 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
>  				    &fops_radar_trigger);
>  	}
> =20
> +	if (!ext_phy)
> +		dev->debugfs_dir =3D dir;
> +
>  	return 0;
>  }
> =20
> +static void
> +mt7915_debugfs_write_fwlog(struct mt7915_dev *dev, const void *hdr, int =
hdrlen,
> +			 const void *data, int len)
> +{
> +	static DEFINE_SPINLOCK(lock);
> +	unsigned long flags;
> +	void *dest;
> +
> +	spin_lock_irqsave(&lock, flags);
> +	dest =3D relay_reserve(dev->relay_fwlog, hdrlen + len + 4);
> +	if (dest) {
> +		*(u32 *)dest =3D hdrlen + len;
> +		dest +=3D 4;
> +
> +		if (hdrlen) {
> +			memcpy(dest, hdr, hdrlen);
> +			dest +=3D hdrlen;
> +		}
> +
> +		memcpy(dest, data, len);
> +		relay_flush(dev->relay_fwlog);
> +	}
> +	spin_unlock_irqrestore(&lock, flags);
> +}
> +
> +void mt7915_debugfs_rx_ics(struct mt7915_dev *dev, const void *data, int=
 len)
> +{
> +	struct {
> +		__le32 magic;
> +		__le32 timestamp;
> +		__le16 msg_type;
> +		__le16 len;
> +	} hdr =3D {
> +		.magic =3D cpu_to_le32(FW_BIN_LOG_MAGIC),
> +		.msg_type =3D PKT_TYPE_RX_ICS,
> +	};
> +
> +	if (!dev->relay_fwlog)
> +		return;
> +
> +	hdr.timestamp =3D mt76_rr(dev, MT_LPON_FRCR(0));
> +	hdr.len =3D *(__le16 *)data;
> +	mt7915_debugfs_write_fwlog(dev, &hdr, sizeof(hdr), data, len);
> +}
> +
> +bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int=
 len)
> +{
> +	if (get_unaligned_le32(data) !=3D FW_BIN_LOG_MAGIC)
> +		return false;
> +
> +	if (dev->relay_fwlog)
> +		mt7915_debugfs_write_fwlog(dev, NULL, 0, data, len);
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_MAC80211_DEBUGFS
>  /** per-station debugfs **/
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index e0200f84a2f9..a6770fd40b34 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1691,6 +1691,9 @@ bool mt7915_rx_check(struct mt76_dev *mdev, void *d=
ata, int len)
>  		for (rxd +=3D 2; rxd + 8 <=3D end; rxd +=3D 8)
>  		    mt7915_mac_add_txs(dev, rxd);
>  		return false;
> +	case PKT_TYPE_RX_ICS:
> +		mt7915_debugfs_rx_ics(dev, data, len);
> +		return false;
>  	default:
>  		return true;
>  	}
> @@ -1722,6 +1725,9 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enu=
m mt76_rxq_id q,
>  		    mt7915_mac_add_txs(dev, rxd);
>  		dev_kfree_skb(skb);
>  		break;
> +	case PKT_TYPE_RX_ICS:
> +		mt7915_debugfs_rx_ics(dev, skb->data, skb->len);
> +		break;
>  	case PKT_TYPE_NORMAL:
>  		if (!mt7915_mac_fill_rx(dev, skb)) {
>  			mt76_rx(&dev->mt76, q, skb);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.h
> index d79f0a56535f..7fef2f8fad65 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
> @@ -23,6 +23,7 @@ enum rx_pkt_type {
>  	PKT_TYPE_RETRIEVE,
>  	PKT_TYPE_TXRX_NOTIFY,
>  	PKT_TYPE_RX_EVENT,
> +	PKT_TYPE_RX_ICS =3D 0x0c,
>  };
> =20
>  /* RXD DW1 */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 74cdfd3d13b9..66f8daf3168c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -368,9 +368,13 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, st=
ruct sk_buff *skb)
>  	struct mt7915_mcu_rxd *rxd =3D (struct mt7915_mcu_rxd *)skb->data;
>  	const char *data =3D (char *)&rxd[1];
>  	const char *type;
> +	int len =3D skb->len - sizeof(*rxd);
> =20
>  	switch (rxd->s2d_index) {
>  	case 0:
> +		if (mt7915_debugfs_rx_log(dev, data, len))
> +			return;
> +
>  		type =3D "WM";
>  		break;
>  	case 2:
> @@ -381,8 +385,7 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, str=
uct sk_buff *skb)
>  		break;
>  	}
> =20
> -	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type,
> -		   (int)(skb->len - sizeof(*rxd)), data);
> +	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type, len, data);
>  }
> =20
>  static void
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/mmio.c
> index f1568f9059d8..e8ff686bd3f3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -50,6 +50,7 @@ static const u32 mt7915_offs[] =3D {
>  	[AGG_ATCR3]		=3D 0x0f4,
>  	[LPON_UTTR0]		=3D 0x080,
>  	[LPON_UTTR1]		=3D 0x084,
> +	[LPON_FRCR]		=3D 0x314,
>  	[MIB_SDR3]		=3D 0x014,
>  	[MIB_SDR4]		=3D 0x018,
>  	[MIB_SDR5]		=3D 0x01c,
> @@ -121,6 +122,7 @@ static const u32 mt7916_offs[] =3D {
>  	[AGG_ATCR3]		=3D 0x080,
>  	[LPON_UTTR0]		=3D 0x360,
>  	[LPON_UTTR1]		=3D 0x364,
> +	[LPON_FRCR]		=3D 0x37c,
>  	[MIB_SDR3]		=3D 0x698,
>  	[MIB_SDR4]		=3D 0x788,
>  	[MIB_SDR5]		=3D 0x780,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index 5adde022d4e2..fff3065a3453 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -291,6 +291,10 @@ struct mt7915_dev {
>  	bool ibf;
>  	u8 fw_debug_wm;
>  	u8 fw_debug_wa;
> +	u8 fw_debug_bin;
> +
> +	struct dentry *debugfs_dir;
> +	struct rchan *relay_fwlog;
> =20
>  	void *cal;
> =20
> @@ -537,6 +541,8 @@ void mt7915_update_channel(struct mt76_phy *mphy);
>  int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enable);
>  int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms);
>  int mt7915_init_debugfs(struct mt7915_phy *phy);
> +void mt7915_debugfs_rx_ics(struct mt7915_dev *dev, const void *data, int=
 len);
> +bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int=
 len);
>  #ifdef CONFIG_MAC80211_DEBUGFS
>  void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vi=
f *vif,
>  			    struct ieee80211_sta *sta, struct dentry *dir);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7915/regs.h
> index aa19e5940070..6a0f68180396 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
> @@ -50,6 +50,7 @@ enum offs_rev {
>  	AGG_ATCR3,
>  	LPON_UTTR0,
>  	LPON_UTTR1,
> +	LPON_FRCR,
>  	MIB_SDR3,
>  	MIB_SDR4,
>  	MIB_SDR5,
> @@ -238,6 +239,7 @@ enum offs_rev {
> =20
>  #define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, __OFFS(LPON_UTTR0))
>  #define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, __OFFS(LPON_UTTR1))
> +#define MT_LPON_FRCR(_band)		MT_WF_LPON(_band, __OFFS(LPON_FRCR))
> =20
>  #define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 +	\
>  						   (((n) * 4) << 1))
> --=20
> 2.34.1
>=20

--VGZXXzPvwK2aNwKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYdgeHgAKCRA6cBh0uS2t
rFzNAP9QsIIQn+2k6Tt++zhTpREOMymN6D2Ylzo995Upylkp6AEA6Yi+4JdXp6tE
5uRsTs5YEnl61He1mgUpuAQhh0bZOQA=
=DH+i
-----END PGP SIGNATURE-----

--VGZXXzPvwK2aNwKM--
