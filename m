Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC821154B
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEBIYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 04:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfEBIYh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 04:24:37 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5B720873;
        Thu,  2 May 2019 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556785475;
        bh=JNjqaKXVe8FytJFhtrZXqndKAbmipbOuH25cPZ+hdOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvXW97geaHdRvBZRAj2tkluwv4QHvSmMDF+9iNISBsAZGmLOOyLlzX2WFjK60idp8
         G3w/1pKOUHUNbuvY9pn3yxaKJEc2kcyeHbXeLlhgACVbZEb98N07HKW88L/cPwHTke
         sWjNWZlEqXukk0C8L2bPbXsUkgZwd2Yzku5ZUFoc=
Date:   Thu, 2 May 2019 10:24:30 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, royluo@google.com
Subject: Re: [RFC 12/17] mt7615: mcu: do not use function pointer whenever
 possible
Message-ID: <20190502082429.GA21503@localhost.localdomain>
References: <cover.1556726268.git.lorenzo@kernel.org>
 <0feb5dd8f162e2c8bdb8629b6c8cac96e3f3b515.1556726268.git.lorenzo@kernel.org>
 <1556764062.12176.2.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1556764062.12176.2.camel@mtkswgap22>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 2019-05-01 at 18:07 +0200, Lorenzo Bianconi wrote:
> > Remove function pointer in mt7615_mcu_set_bss_info and run function
> > directly. Moreover remove __mt7615_mcu_set_bss_info since it is run just
> > by mt7615_mcu_set_bss_info and remove duplicated istructions
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 220 +++++++++---------
> >  1 file changed, 105 insertions(+), 115 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/=
net/wireless/mediatek/mt76/mt7615/mcu.c
> > index c90ae77db22b..b3fb3d731129 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > @@ -676,154 +676,107 @@ int mt7615_mcu_set_dev_info(struct mt7615_dev *=
dev,
> >  	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE);
> >  }
> > =20
> > -static void bss_info_omac_handler (struct mt7615_dev *dev,
> > -				   struct bss_info *bss_info,
> > -				   struct sk_buff *skb)
> > +static void
> > +mt7615_mcu_bss_info_omac_header(struct mt7615_vif *mvif, u8 *data,
> > +				u32 conn_type)
> >  {
> > -	struct bss_info_omac tlv =3D {0};
> > -
> > -	tlv.tag =3D cpu_to_le16(BSS_INFO_OMAC);
> > -	tlv.len =3D cpu_to_le16(sizeof(tlv));
> > -	tlv.hw_bss_idx =3D (bss_info->omac_idx > EXT_BSSID_START) ?
> > -			 HW_BSSID_0 : bss_info->omac_idx;
> > -	tlv.omac_idx =3D bss_info->omac_idx;
> > -	tlv.band_idx =3D bss_info->band_idx;
> > -	tlv.conn_type =3D cpu_to_le32(bss_info->conn_type);
> > -
> > -	memcpy(skb_put(skb, sizeof(tlv)), &tlv, sizeof(tlv));
> > +	struct bss_info_omac *hdr =3D (struct bss_info_omac *)data;
> > +	u8 idx;
> > +
> > +	idx =3D mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_id=
x;
> > +	hdr->tag =3D cpu_to_le16(BSS_INFO_OMAC);
> > +	hdr->len =3D cpu_to_le16(sizeof(struct bss_info_omac));
> > +	hdr->hw_bss_idx =3D idx;
> > +	hdr->omac_idx =3D mvif->omac_idx;
> > +	hdr->band_idx =3D mvif->band_idx;
> > +	hdr->conn_type =3D cpu_to_le32(conn_type);
> >  }
> > =20
> > -static void bss_info_basic_handler (struct mt7615_dev *dev,
> > -				    struct bss_info *bss_info,
> > -				    struct sk_buff *skb)
> > +static void
> > +mt7615_mcu_bss_info_basic_header(struct ieee80211_vif *vif, u8 *data,
> > +				 u32 net_type, u8 tx_wlan_idx,
> > +				 bool enable)
> >  {
> > -	struct bss_info_basic tlv =3D {0};
> > -
> > -	tlv.tag =3D cpu_to_le16(BSS_INFO_BASIC);
> > -	tlv.len =3D cpu_to_le16(sizeof(tlv));
> > -	tlv.network_type =3D cpu_to_le32(bss_info->network_type);
> > -	tlv.active =3D bss_info->enable;
> > -	tlv.bcn_interval =3D cpu_to_le16(bss_info->bcn_interval);
> > -	memcpy(tlv.bssid, bss_info->bssid, ETH_ALEN);
> > -	tlv.wmm_idx =3D bss_info->wmm_idx;
> > -	tlv.dtim_period =3D bss_info->dtim_period;
> > -	tlv.bmc_tx_wlan_idx =3D bss_info->bmc_tx_wlan_idx;
> > -
> > -	memcpy(skb_put(skb, sizeof(tlv)), &tlv, sizeof(tlv));
> > +	struct mt7615_vif *mvif =3D (struct mt7615_vif *)vif->drv_priv;
> > +	struct bss_info_basic *hdr =3D (struct bss_info_basic *)data;
> > +
> > +	hdr->tag =3D cpu_to_le16(BSS_INFO_BASIC);
> > +	hdr->len =3D cpu_to_le16(sizeof(struct bss_info_basic));
> > +	hdr->network_type =3D cpu_to_le32(net_type);
>=20
> If I read this patch correctly, it seems nobody sets the net_type?
>=20

Hi Ryder,

you are right, I swapped the initialization of conn_type and net_type.
I will fix it, thx

Regards,
Lorenzo

> > +	hdr->active =3D enable;
> > +	hdr->bcn_interval =3D cpu_to_le16(vif->bss_conf.beacon_int);
> > +	memcpy(hdr->bssid, vif->bss_conf.bssid, ETH_ALEN);
> > +	hdr->wmm_idx =3D mvif->wmm_idx;
> > +	hdr->dtim_period =3D vif->bss_conf.dtim_period;
> > +	hdr->bmc_tx_wlan_idx =3D tx_wlan_idx;
> >  }
> > =20
> > -static void bss_info_ext_bss_handler (struct mt7615_dev *dev,
> > -				      struct bss_info *bss_info,
> > -				      struct sk_buff *skb)
> > +static void
> > +mt7615_mcu_bss_info_ext_header(struct mt7615_vif *mvif, u8 *data)
> >  {
> >  /* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
> >  #define BCN_TX_ESTIMATE_TIME (4096 + 20)
> > -	struct bss_info_ext_bss tlv =3D {0};
> > +	struct bss_info_ext_bss *hdr =3D (struct bss_info_ext_bss *)data;
> >  	int ext_bss_idx;
> > =20
> > -	ext_bss_idx =3D bss_info->omac_idx - EXT_BSSID_START;
> > -
> > +	ext_bss_idx =3D mvif->omac_idx - EXT_BSSID_START;
> >  	if (ext_bss_idx < 0)
> >  		return;
> > =20
> > -	tlv.tag =3D cpu_to_le16(BSS_INFO_EXT_BSS);
> > -	tlv.len =3D cpu_to_le16(sizeof(tlv));
> > -	tlv.mbss_tsf_offset =3D ext_bss_idx * BCN_TX_ESTIMATE_TIME;
> > -
> > -	memcpy(skb_put(skb, sizeof(tlv)), &tlv, sizeof(tlv));
> > +	hdr->tag =3D cpu_to_le16(BSS_INFO_EXT_BSS);
> > +	hdr->len =3D cpu_to_le16(sizeof(struct bss_info_ext_bss));
> > +	hdr->mbss_tsf_offset =3D ext_bss_idx * BCN_TX_ESTIMATE_TIME;
> >  }
> > =20
> > -static struct bss_info_tag_handler bss_info_tag_handler[] =3D {
> > -	{BSS_INFO_OMAC, sizeof(struct bss_info_omac), bss_info_omac_handler},
> > -	{BSS_INFO_BASIC, sizeof(struct bss_info_basic), bss_info_basic_handle=
r},
> > -	{BSS_INFO_RF_CH, sizeof(struct bss_info_rf_ch), NULL},
> > -	{BSS_INFO_PM, 0, NULL},
> > -	{BSS_INFO_UAPSD, 0, NULL},
> > -	{BSS_INFO_ROAM_DETECTION, 0, NULL},
> > -	{BSS_INFO_LQ_RM, 0, NULL},
> > -	{BSS_INFO_EXT_BSS, sizeof(struct bss_info_ext_bss), bss_info_ext_bss_=
handler},
> > -	{BSS_INFO_BMC_INFO, 0, NULL},
> > -	{BSS_INFO_SYNC_MODE, 0, NULL},
> > -	{BSS_INFO_RA, 0, NULL},
> > -	{BSS_INFO_MAX_NUM, 0, NULL},
> > -};
> > -
> > -static int __mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> > -				     struct bss_info *bss_info)
> > +int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> > +			    struct ieee80211_vif *vif, int en)
> >  {
> > +	struct mt7615_vif *mvif =3D (struct mt7615_vif *)vif->drv_priv;
> >  	struct req_hdr {
> >  		u8 bss_idx;
> >  		u8 rsv0;
> >  		__le16 tlv_num;
> >  		u8 is_tlv_append;
> >  		u8 rsv1[3];
> > -	} __packed req_hdr =3D {0};
> > +	} __packed;
> > +	int len =3D sizeof(struct req_hdr) + sizeof(struct bss_info_basic);
> > +	int ret, i, features =3D BIT(BSS_INFO_BASIC), ntlv =3D 1;
> > +	u32 conn_type =3D NETWORK_INFRA, net_type =3D 0;
> > +	u8 *buf, *data, tx_wlan_idx =3D 0;
> > +	struct req_hdr *hdr;
> >  	struct sk_buff *skb;
> > -	u16 tlv_num =3D 0;
> > -	u32 size =3D 0;
> > -	int i;
> > =20
> > -	for (i =3D 0; i < BSS_INFO_MAX_NUM; i++)
> > -		if ((BIT(bss_info_tag_handler[i].tag) & bss_info->feature) &&
> > -		    bss_info_tag_handler[i].handler) {
> > -			tlv_num++;
> > -			size +=3D bss_info_tag_handler[i].len;
> > +	if (en) {
> > +		len +=3D sizeof(struct bss_info_omac);
> > +		features |=3D BIT(BSS_INFO_OMAC);
> > +		if (mvif->omac_idx > EXT_BSSID_START) {
> > +			len +=3D sizeof(struct bss_info_ext_bss);
> > +			features |=3D BIT(BSS_INFO_EXT_BSS);
> > +			ntlv++;
> >  		}
> > -
> > -	skb =3D mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) + size);
> > -
> > -	req_hdr.bss_idx =3D bss_info->bss_idx;
> > -	req_hdr.tlv_num =3D cpu_to_le16(tlv_num);
> > -	req_hdr.is_tlv_append =3D tlv_num ? 1 : 0;
> > -
> > -	memcpy(skb_put(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
> > -
> > -	for (i =3D 0; i < BSS_INFO_MAX_NUM; i++)
> > -		if ((BIT(bss_info_tag_handler[i].tag) & bss_info->feature) &&
> > -		    bss_info_tag_handler[i].handler)
> > -			bss_info_tag_handler[i].handler(dev, bss_info, skb);
> > -
> > -	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE);
> > -}
> > -
> > -int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> > -			    struct ieee80211_vif *vif, int en)
> > -{
> > -	struct mt7615_vif *mvif =3D (struct mt7615_vif *)vif->drv_priv;
> > -	struct bss_info bss_info =3D {
> > -		.bss_idx =3D mvif->idx,
> > -		.omac_idx =3D mvif->omac_idx,
> > -		.band_idx =3D mvif->band_idx,
> > -		.bcn_interval =3D vif->bss_conf.beacon_int,
> > -		.dtim_period =3D vif->bss_conf.dtim_period,
> > -		.enable =3D en,
> > -		.feature =3D BIT(BSS_INFO_BASIC),
> > -		.wmm_idx =3D mvif->wmm_idx,
> > -	};
> > +		ntlv++;
> > +	}
> > =20
> >  	switch (vif->type) {
> >  	case NL80211_IFTYPE_AP:
> > -		bss_info.bmc_tx_wlan_idx =3D mvif->sta.wcid.idx;
> > -		bss_info.network_type =3D NETWORK_INFRA;
> > -		bss_info.conn_type =3D CONNECTION_INFRA_AP;
> > +		tx_wlan_idx =3D mvif->sta.wcid.idx;
> > +		conn_type =3D CONNECTION_INFRA_AP;
> >  		break;
> >  	case NL80211_IFTYPE_STATION: {
> > -		/* find the unicast entry for sta mode bmc tx */
> > -		struct ieee80211_sta *ap_sta;
> > +		struct ieee80211_sta *sta;
> >  		struct mt7615_sta *msta;
> > =20
> >  		rcu_read_lock();
> > =20
> > -		ap_sta =3D ieee80211_find_sta(vif, vif->bss_conf.bssid);
> > -		if (!ap_sta) {
> > +		sta =3D ieee80211_find_sta(vif, vif->bss_conf.bssid);
> > +		if (!sta) {
> >  			rcu_read_unlock();
> >  			return -EINVAL;
> >  		}
> > =20
> > -		msta =3D (struct mt7615_sta *)ap_sta->drv_priv;
> > -		bss_info.bmc_tx_wlan_idx =3D msta->wcid.idx;
> > -		bss_info.network_type =3D NETWORK_INFRA;
> > -		bss_info.conn_type =3D CONNECTION_INFRA_STA;
> > +		msta =3D (struct mt7615_sta *)sta->drv_priv;
> > +		tx_wlan_idx =3D msta->wcid.idx;
> > +		conn_type =3D CONNECTION_INFRA_STA;
> > =20
> >  		rcu_read_unlock();
> >  		break;
> > @@ -832,15 +785,52 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *de=
v,
> >  		WARN_ON(1);
> >  		break;
> >  	}
> > -	memcpy(bss_info.bssid, vif->bss_conf.bssid, ETH_ALEN);
> > =20
> > -	if (en) {
> > -		bss_info.feature |=3D BIT(BSS_INFO_OMAC);
> > -		if (mvif->omac_idx > EXT_BSSID_START)
> > -			bss_info.feature |=3D BIT(BSS_INFO_EXT_BSS);
> > +	buf =3D kzalloc(len, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	hdr =3D (struct req_hdr *)buf;
> > +	hdr->bss_idx =3D mvif->idx;
> > +	hdr->tlv_num =3D cpu_to_le16(ntlv);
> > +	hdr->is_tlv_append =3D 1;
> > +
> > +	data =3D buf + sizeof(*hdr);
> > +	for (i =3D 0; i < BSS_INFO_MAX_NUM; i++) {
> > +		int tag =3D ffs(features & BIT(i)) - 1;
> > +
> > +		switch (tag) {
> > +		case BSS_INFO_OMAC:
> > +			mt7615_mcu_bss_info_omac_header(mvif, data,
> > +							conn_type);
> > +			data +=3D sizeof(struct bss_info_omac);
> > +			break;
> > +		case BSS_INFO_BASIC:
> > +			mt7615_mcu_bss_info_basic_header(vif, data, net_type,
> > +							 tx_wlan_idx, en);
> > +			data +=3D sizeof(struct bss_info_basic);
> > +			break;
> > +		case BSS_INFO_EXT_BSS:
> > +			mt7615_mcu_bss_info_ext_header(mvif, data);
> > +			data +=3D sizeof(struct bss_info_ext_bss);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	skb =3D mt7615_mcu_msg_alloc(buf, len);
> > +	if (!skb) {
> > +		ret =3D -ENOMEM;
> > +		goto out;
> >  	}
> > =20
> > -	return __mt7615_mcu_set_bss_info(dev, &bss_info);
> > +	ret =3D mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE);
> > +
> > +out:
> > +	kfree(buf);
> > +
> > +	return ret;
> >  }
> > =20
> >  static int
>=20
>=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXMqpOQAKCRA6cBh0uS2t
rGHXAQDjWzsASB5Vy/OaGSwI5x1SKfeKdz2R8eVb80W8V+zaFwEAmQMsiqOZGTPf
vosxnl+6nrOVCkyH5+cev888r7tCmQM=
=pmAl
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
