Return-Path: <linux-wireless+bounces-36497-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGVyAI9KB2rqwgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36497-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 18:32:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 252325535BE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F116430091E3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6C3B1029;
	Fri, 15 May 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwd3rteZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B23F6C51
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862551; cv=none; b=WiURRlQJBr5zYdnpXWenfu73Xizi+ds3Q0JGWST7jlOd+4dVhsYu9+eTBwJL8+wBzvxQqfCBYbBs6kTFFkpIGvQ4m14ncNiliZ9aypH6tuIfPfe6lQ3kD5RzCqwtrnoCQYsbU+mRbPFOLCHJJ5o4yO6+0QjupmNN0EhHpwKEDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862551; c=relaxed/simple;
	bh=H2dJS45yuccfLIX2GnQ84V5mty7Z2RwFGQ1Zo0DGIx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9FRl7hDaL0kS1I6mB3xu7J9axBHnvuYg5x6kziNYXOAaFLQobdOLCnGr0yj1WpS4TjhCRW/LksvDpQux6ien6ZUAiskqcVYYSTam16TYpQfuZ6Rn6kYPuCPFEz7YqQmXm8Uhl11BsqxBhMIlnw7KrMAun1pLUKiYQz+M84DGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwd3rteZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484EAC2BCB0;
	Fri, 15 May 2026 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778862550;
	bh=H2dJS45yuccfLIX2GnQ84V5mty7Z2RwFGQ1Zo0DGIx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwd3rteZho7H1aOOW3C8TM3pmk/F77ul+HYJiFT/5SYevKp6JJLpHnnCbNfI2Blwy
	 UDsqbtnc6bvH2PNiiHeUkh2AHs3zFtfN+ViNkNLcCKuxFDUBdcMplP+xUZUpUEIuul
	 cD13N1oI2Lhwy6AIWeS1jSk973jtJ9FtMACzCfXj9UPkBRF1RUWtE/SH0zGFUE6jhC
	 YT/p7E/8P1jl9omIR1/y9+i/JOMVTQ3QlopvpnC3MXonNNNSLosfGvBefB215matPm
	 uy8xULkbr1M+ahi+7XAxwuAIlYs4UkZ+sOgxDzFkgk/4vzOlBjmAFzVTb+ANy+h17/
	 OAbW3V4EB9NsQ==
Date: Fri, 15 May 2026 18:29:08 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Shayne Chen <shayne.chen@mediatek.com>,
	Roy Luo <roy-ch.luo@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid memset overwriting
 tx_info->control.flags
Message-ID: <agdJ1EtZjjWh2R1h@lore-desk>
References: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NcgmQ1uTJOYhYVzG"
Content-Disposition: inline
In-Reply-To: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
X-Rspamd-Queue-Id: 252325535BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36497-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--NcgmQ1uTJOYhYVzG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt76_tx_status_skb_add uses memset on status.status_driver_data, which
> overwrite  info->control.flags in ieee80211_tx_info. Copy tx_info before
> calling mt76_tx_status_skb_add to ensure control fields are preserved
> and remain valid for later processing.
>=20
> Reported-By: Roy Luo <roy-ch.luo@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Hi Ryder,

I have not completely got the issue here:

struct ieee80211_tx_info {
        u32                        flags;                /*     0     4 */
        u32                        band:3;               /*     4: 0  4 */
        u32                        status_data_idr:1;    /*     4: 3  4 */
        u32                        status_data:13;       /*     4: 4  4 */
        u32                        hw_queue:4;           /*     4:17  4 */
        u32                        tx_time_est:10;       /*     4:21  4 */

        /* XXX 1 bit hole, try to pack */

        union {
                struct {
                        union {
                                struct {
                                        struct ieee80211_tx_rate rates[4]; =
/*     8    12 */
                                        s8     rts_cts_rate_idx; /*    20  =
   1 */
                                        u8     use_rts:1; /*    21: 0  1 */
                                        u8     use_cts_prot:1; /*    21: 1 =
 1 */
                                        u8     short_preamble:1; /*    21: =
2  1 */
                                        u8     skip_table:1; /*    21: 3  1=
 */
                                        u8     antennas:2; /*    21: 4  1 */
                                };                       /*     8    14 */
                                long unsigned int jiffies; /*     8     8 */
                        };                               /*     8    16 */
                        struct ieee80211_vif * vif;      /*    24     8 */
                        struct ieee80211_key_conf * hw_key; /*    32     8 =
*/
                        u32        flags;                /*    40     4 */
                        codel_time_t enqueue_time;       /*    44     4 */
                } control;                               /*     8    40 */
                struct {
                        u64        cookie;               /*     8     8 */
                } ack;                                   /*     8     8 */
                struct {
                        struct ieee80211_tx_rate rates[4]; /*     8    12 */
                        s32        ack_signal;           /*    20     4 */
                        u8         ampdu_ack_len;        /*    24     1 */
                        u8         ampdu_len;            /*    25     1 */
                        u8         antenna;              /*    26     1 */
                        u8         pad;                  /*    27     1 */
                        u16        tx_time;              /*    28     2 */
                        u8         flags;                /*    30     1 */
                        u8         pad2;                 /*    31     1 */
                        void *     status_driver_data[2]; /*    32    16 */
                } status;                                /*     8    40 */
                struct {
                        struct ieee80211_tx_rate driver_rates[4]; /*     8 =
   12 */
                        u8         pad[4];               /*    20     4 */
                        void *     rate_driver_data[3];  /*    24    24 */
                };                                       /*     8    40 */
                void *             driver_data[5];       /*     8    40 */
        };                                               /*     8    40 */

        /* size: 48, cachelines: 1, members: 7 */
        /* sum members: 44 */
        /* sum bitfield members: 31 bits, bit holes: 1, sum bit holes: 1 bi=
ts */
        /* last cacheline: 48 bytes */
};

According to pahole, the size of the control inner union is actually 16 byt=
es
since the compiler adds 2 bytes of padding. Since mt76_tx_status_skb_add()
meset to 0 just mt76_tx_cb size (that is 16 bytes) I can't see how
control.flags is overwritten. Am I missing something?

struct mt76_tx_cb {
        long unsigned int          jiffies;              /*     0     8 */
        u16                        wcid;                 /*     8     2 */
        u8                         pktid;                /*    10     1 */
        u8                         flags;                /*    11     1 */

        /* size: 16, cachelines: 1, members: 4 */
        /* padding: 4 */
        /* last cacheline: 16 bytes */
};

Regards,
Lorenzo

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 17 +++++++++--------
>  .../net/wireless/mediatek/mt76/mt7996/mt7996.h  |  2 +-
>  2 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index e2a83da3a09c..a59c14c8f2af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -855,11 +855,12 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev,=
 __le32 *txwi,
> =20
>  void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
>  			   struct sk_buff *skb, struct mt76_wcid *wcid,
> -			   struct ieee80211_key_conf *key, int pid,
> +			   struct ieee80211_tx_info *tx_info, int pid,
>  			   enum mt76_txq_id qid, u32 changed)
>  {
>  	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
> -	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +	struct ieee80211_key_conf *key =3D tx_info ? tx_info->control.hw_key : =
NULL;
> +	struct ieee80211_tx_info *info =3D tx_info ? tx_info : IEEE80211_SKB_CB=
(skb);
>  	struct ieee80211_vif *vif =3D info->control.vif;
>  	u8 band_idx =3D (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
>  	u8 p_fmt, q_idx, omac_idx =3D 0, wmm_idx =3D 0;
> @@ -1006,15 +1007,15 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, =
void *txwi_ptr,
>  {
>  	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)tx_info->skb->dat=
a;
>  	struct mt7996_dev *dev =3D container_of(mdev, struct mt7996_dev, mt76);
> -	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->skb);
> -	struct ieee80211_key_conf *key =3D info->control.hw_key;
> -	struct ieee80211_vif *vif =3D info->control.vif;
> +	struct ieee80211_tx_info info =3D *IEEE80211_SKB_CB(tx_info->skb);
> +	struct ieee80211_key_conf *key =3D info.control.hw_key;
> +	struct ieee80211_vif *vif =3D info.control.vif;
>  	struct mt7996_vif *mvif =3D vif ? (struct mt7996_vif *)vif->drv_priv : =
NULL;
>  	struct mt7996_sta *msta =3D sta ? (struct mt7996_sta *)sta->drv_priv : =
NULL;
>  	struct mt76_vif_link *mlink =3D NULL;
>  	struct mt76_txwi_cache *t;
>  	int id, i, pid, nbuf =3D tx_info->nbuf - 1;
> -	bool is_8023 =3D info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
> +	bool is_8023 =3D info.flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
>  	__le32 *ptr =3D (__le32 *)txwi_ptr;
>  	u8 *txwi =3D (u8 *)txwi_ptr;
>  	u8 link_id;
> @@ -1031,7 +1032,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, vo=
id *txwi_ptr,
> =20
>  		link_id =3D (tid % 2) ? msta->seclink_id : msta->deflink_id;
>  	} else {
> -		link_id =3D u32_get_bits(info->control.flags,
> +		link_id =3D u32_get_bits(info.control.flags,
>  				       IEEE80211_TX_CTRL_MLO_LINK);
>  	}
> =20
> @@ -1095,7 +1096,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, vo=
id *txwi_ptr,
>  	memset(txwi_ptr, 0, MT_TXD_SIZE);
>  	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
>  	if (!is_8023 || pid >=3D MT_PACKET_ID_FIRST)
> -		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
> +		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, &info,
>  				      pid, qid, 0);
> =20
>  	/* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers=
/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index bdcf72457954..319fcc4fb469 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -854,7 +854,7 @@ void mt7996_mac_cca_stats_reset(struct mt7996_phy *ph=
y);
>  void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
>  void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
>  			   struct sk_buff *skb, struct mt76_wcid *wcid,
> -			   struct ieee80211_key_conf *key, int pid,
> +			   struct ieee80211_tx_info *tx_info, int pid,
>  			   enum mt76_txq_id qid, u32 changed);
>  void mt7996_mac_update_beacons(struct mt7996_phy *phy);
>  void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
> --=20
> 2.45.2
>=20
>=20

--NcgmQ1uTJOYhYVzG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagdJ1AAKCRA6cBh0uS2t
rFMMAP0VjNblyad/FBjgZnzBbhhUCJd4xORr3NXP+radz7N9sgD/S4OSSd3y7HTU
FyEoGFraOOjdYDoJIkwjzf22J366Rw0=
=MyVu
-----END PGP SIGNATURE-----

--NcgmQ1uTJOYhYVzG--

