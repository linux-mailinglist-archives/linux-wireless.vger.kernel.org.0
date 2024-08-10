Return-Path: <linux-wireless+bounces-11265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C494DF33
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125BCB21491
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2A22083;
	Sat, 10 Aug 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="wOqAuDXK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F7C8D1
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723330685; cv=none; b=GK71L2gPxgeud2fxIZ1FMULsy80CqSV6eosxkD5MwwQ8iCmH+IM3bgNT6YJnmS+wwVc7TULBXFx+/s4KQK8ieC23eDgYTzKkL2JmZrA8sEiD0LD3RgCKQRmxLpPyFLEQbSjrgixxNObT2yMLjmd0ZfWvfiWb/NEYYKJsri9h4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723330685; c=relaxed/simple;
	bh=xZNDz7XPut6o28s96ot8TUPxGrjHugbe3xxgzrMgl2w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rA/YNz9ZkgO1K7N2In3KAI355A6vGWounzdCAhr9ghPJ9+ZOImTRSQIS/xmmUSJEWxKbPu1Wu0FfcoRtgj01cJAiGliDbJ09S4caWhU44WGzXbZDfr4MU6LFLmpCfzrYXuJK/bkVQoGDpSeXLGtlNFqvx1zCJawWmO5KJq9+sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=wOqAuDXK; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1723330675; x=1723589875;
	bh=o9XieD+GUAISQdUmloBhC79e+SsYWnBMl/YvUxOjETQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wOqAuDXKJ2WDqghwlmaLdo3TqJdzsSWeJUUXHgE/6HfuNd28H3QR07TVGu+B2vJu4
	 OD/ePVJMhTaIxGJLjwtfSuGnZy/lHZplsAc9i3e8sRAg16ZoMbO67sszb4zIWuqqw7
	 9hRC88afh9MeOwvV3x2ayXE6nSVTSe8vrkOMOQqfbuBoOUT7Q733Al9VemEd/F5trO
	 NJpnvzLH482+vbbG2e2wtlj54ULhrgTMKIRd4qk0Yb2+b55qUfQnssL0HOa+iFNs0Z
	 LUdOoiZyjo77LeBs6OKdJBisDgp5a/iaO6QbT0KL3oT8If0Jh54thhkgL9nYcaiutp
	 oeSMTeanMrosQ==
Date: Sat, 10 Aug 2024 22:57:53 +0000
To: Luca Coelho <luca@coelho.fi>
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, linux-wireless@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH 11/17] iwlwifi: move iwl_enable_{rx,tx}_ampdu to iwl-modparams.h
Message-ID: <Q1PcV8dOFxXbtBYY8g8WqiRz5ruU2PiA148IHZgcwScLKZatSOI0_2z1ZDR3K9jaPB7RNSjD4XwZy-mVCIJab15Qc975K_q6AA5ekRcs5Uo=@protonmail.com>
In-Reply-To: <20190125201305.5616-12-luca@coelho.fi>
References: <20190125201305.5616-1-luca@coelho.fi> <20190125201305.5616-12-luca@coelho.fi>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 53782301ead55b33a0078b1fef74567699aa8138
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

if I am not mistaken this patch changes the behaviour, but the commit messa=
ge
does not mention it. dvm/mac80211.c:iwl_enable_tx_ampdu() returned false by=
 default,
while mvm/mac80211.c:iwl_enable_tx_ampdu() returned true by default.

After the change, however, the default return value is true, so this change
essentially undoes what 205e2210daa975d92ace485a65a31ccc4077fe1a
("iwlwifi: disable TX AMPDU by default for iwldvm") did.


Regards,
Barnab=C3=A1s P=C5=91cze


2019. janu=C3=A1r 25., p=C3=A9ntek 21:12 keltez=C3=A9ssel, Luca Coelho <luc=
a@coelho.fi> =C3=ADrta:

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> These inlines just check the module parameters, so they don't
> need a configuration parameter and can move to a better place.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  .../net/wireless/intel/iwlwifi/dvm/mac80211.c | 23 +++----------------
>  .../wireless/intel/iwlwifi/iwl-modparams.h    | 18 +++++++++++++++
>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 22 ++----------------
>  3 files changed, 23 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/=
net/wireless/intel/iwlwifi/dvm/mac80211.c
> index 49b71dbf8490..54b759cec8b3 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
> @@ -1,6 +1,7 @@
>  /***********************************************************************=
*******
>   *
>   * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
> + * Copyright (C) 2018 Intel Corporation
>   *
>   * Portions of this file are derived from the ipw3945 project, as well
>   * as portions of the ieee80211 subsystem header files.
> @@ -710,24 +711,6 @@ static int iwlagn_mac_set_key(struct ieee80211_hw *h=
w, enum set_key_cmd cmd,
>  =09return ret;
>  }
>=20
> -static inline bool iwl_enable_rx_ampdu(const struct iwl_cfg *cfg)
> -{
> -=09if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_RXAGG)
> -=09=09return false;
> -=09return true;
> -}
> -
> -static inline bool iwl_enable_tx_ampdu(const struct iwl_cfg *cfg)
> -{
> -=09if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_TXAGG)
> -=09=09return false;
> -=09if (iwlwifi_mod_params.disable_11n & IWL_ENABLE_HT_TXAGG)
> -=09=09return true;
> -
> -=09/* disabled by default */
> -=09return false;
> -}
> -
>  static int iwlagn_mac_ampdu_action(struct ieee80211_hw *hw,
>  =09=09=09=09   struct ieee80211_vif *vif,
>  =09=09=09=09   struct ieee80211_ampdu_params *params)
> @@ -752,7 +735,7 @@ static int iwlagn_mac_ampdu_action(struct ieee80211_h=
w *hw,
>=20
>  =09switch (action) {
>  =09case IEEE80211_AMPDU_RX_START:
> -=09=09if (!iwl_enable_rx_ampdu(priv->cfg))
> +=09=09if (!iwl_enable_rx_ampdu())
>  =09=09=09break;
>  =09=09IWL_DEBUG_HT(priv, "start Rx\n");
>  =09=09ret =3D iwl_sta_rx_agg_start(priv, sta, tid, *ssn);
> @@ -764,7 +747,7 @@ static int iwlagn_mac_ampdu_action(struct ieee80211_h=
w *hw,
>  =09case IEEE80211_AMPDU_TX_START:
>  =09=09if (!priv->trans->ops->txq_enable)
>  =09=09=09break;
> -=09=09if (!iwl_enable_tx_ampdu(priv->cfg))
> +=09=09if (!iwl_enable_tx_ampdu())
>  =09=09=09break;
>  =09=09IWL_DEBUG_HT(priv, "start Tx\n");
>  =09=09ret =3D iwlagn_tx_agg_start(priv, vif, sta, tid, ssn);
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers=
/net/wireless/intel/iwlwifi/iwl-modparams.h
> index 73b1c46f1158..0cae2ef9b9df 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
> @@ -152,4 +152,22 @@ struct iwl_mod_params {
>  =09bool enable_ini;
>  };
>=20
> +static inline bool iwl_enable_rx_ampdu(void)
> +{
> +=09if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_RXAGG)
> +=09=09return false;
> +=09return true;
> +}
> +
> +static inline bool iwl_enable_tx_ampdu(void)
> +{
> +=09if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_TXAGG)
> +=09=09return false;
> +=09if (iwlwifi_mod_params.disable_11n & IWL_ENABLE_HT_TXAGG)
> +=09=09return true;
> +
> +=09/* enabled by default */
> +=09return true;
> +}
> +
>  #endif /* #__iwl_modparams_h__ */
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/=
net/wireless/intel/iwlwifi/mvm/mac80211.c
> index ebb3814dd922..78b35c9595a3 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -943,24 +943,6 @@ static void iwl_mvm_mac_wake_tx_queue(struct ieee802=
11_hw *hw,
>  =09schedule_work(&mvm->add_stream_wk);
>  }
>=20
> -static inline bool iwl_enable_rx_ampdu(const struct iwl_cfg *cfg)
> -{
> -=09if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_RXAGG)
> -=09=09return false;
> -=09return true;
> -}
> -
> -static inline bool iwl_enable_tx_ampdu(const struct iwl_cfg *cfg)
> -{
> -=09if (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_TXAGG)
> -=09=09return false;
> -=09if (iwlwifi_mod_params.disable_11n & IWL_ENABLE_HT_TXAGG)
> -=09=09return true;
> -
> -=09/* enabled by default */
> -=09return true;
> -}
> -
>  #define CHECK_BA_TRIGGER(_mvm, _trig, _tid_bm, _tid, _fmt...)=09=09\
>  =09do {=09=09=09=09=09=09=09=09\
>  =09=09if (!(le16_to_cpu(_tid_bm) & BIT(_tid)))=09=09\
> @@ -1073,7 +1055,7 @@ static int iwl_mvm_mac_ampdu_action(struct ieee8021=
1_hw *hw,
>  =09=09=09mvmvif =3D iwl_mvm_vif_from_mac80211(vif);
>  =09=09=09cancel_delayed_work(&mvmvif->uapsd_nonagg_detected_wk);
>  =09=09}
> -=09=09if (!iwl_enable_rx_ampdu(mvm->cfg)) {
> +=09=09if (!iwl_enable_rx_ampdu()) {
>  =09=09=09ret =3D -EINVAL;
>  =09=09=09break;
>  =09=09}
> @@ -1085,7 +1067,7 @@ static int iwl_mvm_mac_ampdu_action(struct ieee8021=
1_hw *hw,
>  =09=09=09=09=09 timeout);
>  =09=09break;
>  =09case IEEE80211_AMPDU_TX_START:
> -=09=09if (!iwl_enable_tx_ampdu(mvm->cfg)) {
> +=09=09if (!iwl_enable_tx_ampdu()) {
>  =09=09=09ret =3D -EINVAL;
>  =09=09=09break;
>  =09=09}
> --
> 2.20.1
> 

