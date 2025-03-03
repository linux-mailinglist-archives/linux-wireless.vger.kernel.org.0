Return-Path: <linux-wireless+bounces-19708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50ECA4C3BB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0249170E7B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0A142E6F;
	Mon,  3 Mar 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="lKlxEGz5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FA1F473A;
	Mon,  3 Mar 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013175; cv=none; b=tGDPpYNA9h/c7OZjiXAtviiwtLFsQ2N6vdls8tEzh0msQ+8IlMHxkctiYidewGl7RUjWCVVzZ4WysRDg712Au2S0v4z0J4ox8K2qDFUVbapxl/SaypXc3Rb/j8hYWQtt3Ujk6bviyEznqag5RB5XgsXOUSRt2X2SrObWueJACJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013175; c=relaxed/simple;
	bh=YIncpWxTPuCqORsp3tLYGUXftZ2GUuoaDsSV9GweXH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC62lA1QRdOMQyMC2SlaCSyBMje9pfDwS0hjZtqkdz6e/AZtWsnOpwAYm7zx0sArxh5e58eRiEx3yDTWrj1Ofn0I7MJMMsOyDYV9JWh5+cNcEwT7IYJmO13nLXN22Ygu97EjOlJ45RgeMwWKbtSU8/kvSMIigjV0AyNm2JQbsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=lKlxEGz5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1741013157; x=1741617957; i=ps.report@gmx.net;
	bh=lNYNMfF+jTDzLVW8608KEeCxEFIshIP9ukCWf/tuSYo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lKlxEGz5BeYGhunB3zRChQD4xVSF3uHrpSxfUlaPkWo7CVp5x5RUmWvUzhdvbYyA
	 ckciuu8bj3xEVe90H6MxzL6lKMt/JtysImg8tyX+EVO4zN+lyxplPDyRhipsaX8Cc
	 VoyC7peLwF5ANuOHdOIYHgFkuOmZ98+NtObJWjqNRpa1M4EWIpDCqdtmMNm5nIjKh
	 1gOBow9+6iF3J1H5pnnqBqDZeIDG+UWm5DxjeEZUzB7vS9motKAxlYU7jffNLqzl7
	 FwpkPk9Rhvc6Tav+qbjZHGP7eXpeD5fWBE+lp6uwFGqc6TGSiKyOoWnaEulv/sEq+
	 UC5ZuOIcqdfJmDXtDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.38]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1t2nxe2K6V-00tVYS; Mon, 03
 Mar 2025 15:45:57 +0100
Date: Mon, 3 Mar 2025 15:45:55 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: sean.wang@kernel.org
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
 deren.wu@mediatek.com, mingyen.hsieh@mediatek.com,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, Caleb Jorden <cjorden@gmail.com>
Subject: Re: [PATCH v4 1/6] Revert "wifi: mt76: mt7925: Update
 mt7925_mcu_uni_[tx,rx]_ba for MLO"
Message-ID: <20250303154555.1c30150b@gmx.net>
In-Reply-To: <20250226025647.102904-1-sean.wang@kernel.org>
References: <20250226025647.102904-1-sean.wang@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:836C044Eg2UJLCy9pN4JUDK8y5DgKT703fQVi6O115P8SRA5667
 iuQkJJXxSnGk/bGIYqVNRkH3a3f7crtii7vmwpHMNlONV89bkpYapyPWjO9YM+JSX/QH1pe
 vv6hBhkntiohazCTEMa8N1Pq4oS9nQL3YplzyzsrwgfdzGpppbhyhkzmpI9/Icfy9jh2RKZ
 N6MpP+osdIsTWWKLou2ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JTu01PcOoyg=;RH9N20BrApwxaQGskNc9JlGRep2
 gAVcwauIGA+tuFgO3S8dABeSE6Q/L56AHkGmfV6QRixvhsDWP+P0YQw+DAOMhNXRS4uzXEwub
 RFPpUXUv2kvNcrOvBoPaaIc9D7Gugbkjch2cF3ah9lOsy+XS5ujSl0/RuPGsgmIYNY9Klo6iY
 WoJJWJVpcSoEoNEe/oaz3xcVSI5kJvs2mUg17oHOj4jKRyArDOVgT3m2NgtuoNeCYrTQhpWBY
 z+TCWSNZtJld2xYHWH/XlfRXY5vjqBHURbV/dkzku+oVDxfQ5yO+F7hX4buD9QREjIW7h6yW7
 llAoW6VlbYVf/bgkyuyCmUyKJ6ubSXwfqvTixPEYdL9QgQtVEAK+oB+jCH1ezZnSMgHot7T7T
 ElUpIvb+nBFMnvGaSB/Kax4FM6GK9Rfxl1C0/ZGL+36QLjIP45GdYUQ636ngjyj2CYrXEyS3j
 juS97eW1kVt1aoHmylhuN/gI6rnHbHY+dERqZgLbvPFu7va2aRYn0/UBEU9G3nDbRibQ0BP5K
 QTmWcH0OZwiHvoMOURWrIahdBxOm1/zgsWGPTAlhHVb73OWNp8DhoB8EVhoRXSnfuKgGE25D5
 OlTWDXcOmD9xgFVubRDMx5a7l6AyFRyApVFM05O4ll/vo1tdhjYccqvydvjAeDrS5C/1iCqo3
 JoVweiDmWoU+SXvDNVw+6CNnBSoehQZ2V6Loh7xVOkekP90WK5RUs1UANG/+dLjfH15AkxJrW
 rn/8dRJiQDnZOU0U0Ph38zg1Bu4xVQE5bcBB3/GPAqCcv9EfLK7+psZ+hZsDnbR6+h+nI6qH+
 ETqkbJKWRzGvOPxIg1yq3r6hhRGmXg3h6/8wMf9xD4JrNC7bY5SvnxLS+/bBM6YAekHU4AJWm
 TSI1+JwyKEvyT2RB0pk3vnOTrqZxXMkmfbXN2QXDV5swkJ7WxXHjgVIYrNROMDuPgU56ybr2R
 lqMVhNHz1gyHlcf2AUv446U11gkLngjtXnE5xy7KTA0QrK8jsBk4lxu5xZmPcZI7KHPVLgESg
 AopchiQmq/gXggZIaa8FZYWmITZHB3hSU3QglGEw8WLg3g45fyEoG15yk9oWklkzU58lfDaFr
 +nmC7PABNhMLQCFgOCfFB5LoRaMPGe3kiPMWj+z+xiYF4wHd3URrfoOGSptO3vu6TK6RalILd
 9rrKyAXS2Vo0qBM5N+RWHJ4qYU3lteWdVDEsU2Igt0bxGK6QpYwF4h8zPkQv/OYDITMTZKLZp
 zFHtEQary1+GgUH/E9OQd2ebC4f0FCX+uMJKXvjP/Y8PPL85Ts3K0OhvKEHxRS80yGpwH/W8L
 I243PIMA8SOfL2ldW9XKhR4o9MF2r6WWlzpQJ8wAKu76GOYdT7m3BlV8la5IfcSSZA1V0tfQR
 gjE84wpJyfrQ0GSzA3zYqetSsjfZ4H32fCubgjKrlbxdGcEFbX7w4Lk0hO

Hello *,

On Tue, 25 Feb 2025 18:56:42 -0800, sean.wang@kernel.org wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> For MLO, mac80211 will send the BA action for each link to
> the driver, so the driver does not need to handle it itself.
> Therefore, revert this patch.
>
> Fixes: e38a82d25b08 ("wifi: mt76: connac: Extend mt76_connac_mcu_uni_add=
_dev for MLO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Tested-by: Caleb Jorden <cjorden@gmail.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Seems there is some interest/testcase for this revert here [1] too...

	https://lore.kernel.org/linux-wireless/b994a256-ee2f-4831-ad61-288ae7bc86=
4b@heusel.eu/t/#u

Regards,
Peter


> ---
> v2:
>   1) generate the patch based on the latest mt76 tree
>   2) update the commit message
> v3:
>   1) fixed the merge conflict
> v4:
>   1) added tested-by tag
> ---
>  .../net/wireless/mediatek/mt76/mt7925/main.c  | 10 ++--
>  .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 50 ++++---------------
>  .../wireless/mediatek/mt76/mt7925/mt7925.h    |  2 -
>  3 files changed, 15 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/=
net/wireless/mediatek/mt76/mt7925/main.c
> index 98daf80ac131..8dba17c8697c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -1289,22 +1289,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, str=
uct ieee80211_vif *vif,
>  	case IEEE80211_AMPDU_RX_START:
>  		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
>  				   params->buf_size);
> -		mt7925_mcu_uni_rx_ba(dev, vif, params, true);
> +		mt7925_mcu_uni_rx_ba(dev, params, true);
>  		break;
>  	case IEEE80211_AMPDU_RX_STOP:
>  		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
> -		mt7925_mcu_uni_rx_ba(dev, vif, params, false);
> +		mt7925_mcu_uni_rx_ba(dev, params, false);
>  		break;
>  	case IEEE80211_AMPDU_TX_OPERATIONAL:
>  		mtxq->aggr =3D true;
>  		mtxq->send_bar =3D false;
> -		mt7925_mcu_uni_tx_ba(dev, vif, params, true);
> +		mt7925_mcu_uni_tx_ba(dev, params, true);
>  		break;
>  	case IEEE80211_AMPDU_TX_STOP_FLUSH:
>  	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
>  		mtxq->aggr =3D false;
>  		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
> -		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
> +		mt7925_mcu_uni_tx_ba(dev, params, false);
>  		break;
>  	case IEEE80211_AMPDU_TX_START:
>  		set_bit(tid, &msta->deflink.wcid.ampdu_state);
> @@ -1313,7 +1313,7 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struc=
t ieee80211_vif *vif,
>  	case IEEE80211_AMPDU_TX_STOP_CONT:
>  		mtxq->aggr =3D false;
>  		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
> -		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
> +		mt7925_mcu_uni_tx_ba(dev, params, false);
>  		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
>  		break;
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/mcu.c
> index 15815ad84713..4c133200c70b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -607,60 +607,30 @@ mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt7=
6_vif_link *mvif,
>
>  /** starec & wtbl **/
>  int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
> -			 struct ieee80211_vif *vif,
>  			 struct ieee80211_ampdu_params *params,
>  			 bool enable)
>  {
>  	struct mt792x_sta *msta =3D (struct mt792x_sta *)params->sta->drv_priv=
;
> -	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> -	struct mt792x_link_sta *mlink;
> -	struct mt792x_bss_conf *mconf;
> -	unsigned long usable_links =3D ieee80211_vif_usable_links(vif);
> -	struct mt76_wcid *wcid;
> -	u8 link_id, ret;
> -
> -	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) =
{
> -		mconf =3D mt792x_vif_to_link(mvif, link_id);
> -		mlink =3D mt792x_sta_to_link(msta, link_id);
> -		wcid =3D &mlink->wcid;
> -
> -		if (enable && !params->amsdu)
> -			mlink->wcid.amsdu =3D false;
> +	struct mt792x_vif *mvif =3D msta->vif;
> +	struct mt76_wcid *wcid =3D &mvif->sta.deflink.wcid;
>
> -		ret =3D mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
> -					enable, true);
> -		if (ret < 0)
> -			break;
> -	}
> +	if (enable && !params->amsdu)
> +		msta->deflink.wcid.amsdu =3D false;
>
> -	return ret;
> +	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, wcid,
> +				 params, enable, true);
>  }
>
>  int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
> -			 struct ieee80211_vif *vif,
>  			 struct ieee80211_ampdu_params *params,
>  			 bool enable)
>  {
>  	struct mt792x_sta *msta =3D (struct mt792x_sta *)params->sta->drv_priv=
;
> -	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> -	struct mt792x_link_sta *mlink;
> -	struct mt792x_bss_conf *mconf;
> -	unsigned long usable_links =3D ieee80211_vif_usable_links(vif);
> -	struct mt76_wcid *wcid;
> -	u8 link_id, ret;
> -
> -	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) =
{
> -		mconf =3D mt792x_vif_to_link(mvif, link_id);
> -		mlink =3D mt792x_sta_to_link(msta, link_id);
> -		wcid =3D &mlink->wcid;
> -
> -		ret =3D mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
> -					enable, false);
> -		if (ret < 0)
> -			break;
> -	}
> +	struct mt792x_vif *mvif =3D msta->vif;
> +	struct mt76_wcid *wcid =3D &mvif->sta.deflink.wcid;
>
> -	return ret;
> +	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, wcid,
> +				 params, enable, false);
>  }
>
>  static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/driver=
s/net/wireless/mediatek/mt76/mt7925/mt7925.h
> index 8707b5d04743..fd5f9d4ea4a7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
> @@ -263,11 +263,9 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev =
*dev,
>  				 struct ieee80211_vif *vif,
>  				 bool enable);
>  int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
> -			 struct ieee80211_vif *vif,
>  			 struct ieee80211_ampdu_params *params,
>  			 bool enable);
>  int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
> -			 struct ieee80211_vif *vif,
>  			 struct ieee80211_ampdu_params *params,
>  			 bool enable);
>  void mt7925_scan_work(struct work_struct *work);


