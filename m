Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9706CBD2E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjC1LMl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1LMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 07:12:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD9A8A50
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 04:12:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so12112430pjz.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1680001933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+gglQuL5EL6YGbHawiJrGpom3mzhVzz6b3vo0wFrdc=;
        b=uBi4fot3bWTRd5yB2VNrh3knp25BmmyjAyd7aRD+ZeZmfScj2dGWYalMi5Kvt1XywQ
         Bkht//Vtmm4ahgBvjDfaz0HUpE3Ux3ZC987QnSoOCKb96iYAVYPJC3QAop2d2zDCS6OS
         5rwWYravOcRmQ1HDoqAzJBqFbKM96Ye1eJ6/wOJAHUQya7ZQHRE6L5F7yu1T8iEtsOga
         4Ng7merTx8UU+6WU9MkhGoxARsdMpJv6RxhMCqNR8CUWmycoyOKDNo37v9NY+UhC6QhT
         Y9bu0HQ72KYOTOKdHqTCQYsSulu8SDGWv0qpSX7EqBjEhjeJJMcRQzww2gDXk1fA/zws
         i/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680001933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+gglQuL5EL6YGbHawiJrGpom3mzhVzz6b3vo0wFrdc=;
        b=Dkpd7bKFNkPZtDwCcHRl2IyMohA6pike5QF151wKsaJnHOnGTwv2piCwGVbvRtuPEG
         ZYxdiQ7FV9Ju5k6boMCW9JAv++xyxMsEms5QA4ZOsL8Ank7fpCN/QIvp7X6cSAlWkbAg
         yjZXa6+7479ieG/pFalUPlj9USvUUaTrMP2Ic7TbRLp26CACLTxbbjRG2DntvBoqcF09
         exMv25N0NcsrpllpZFFhfXFgssCOdvgEHE8LmG/bR3Xm0dq5CihmYfCwV0ByE9mXN+D6
         NTADPg+q0IvAj0lPnY+zqvtHsNTAU2paK8vl+KtVc/vrB5XDiYwpabwa50KnTIYIb3JI
         VsKg==
X-Gm-Message-State: AAQBX9cjXlTSw8oenF+PxZgCEl7VmnyvNB1t34Lhs2K6h4NCUejetqW1
        hIcbMlh01ZOTkOrdbs3cFS9YS68a2Yy8csXsKcDyQg==
X-Google-Smtp-Source: AKy350alfhbYOlgnMOAoUPFVCXfFnbIdafyl+9kW09mei69kq7dok9zLI/EImm1m8swKdPQ47fezqj7TMQ95IEd1x0A=
X-Received: by 2002:a17:902:b196:b0:19f:36ab:c34 with SMTP id
 s22-20020a170902b19600b0019f36ab0c34mr5238774plr.10.1680001932983; Tue, 28
 Mar 2023 04:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com> <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
In-Reply-To: <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 28 Mar 2023 13:11:22 +0200
Message-ID: <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 18, 2022 at 11:28=E2=80=AFPM Muna Sinada <quic_msinada@quicinc.=
com> wrote:
>
> In the previous behaviour only HE IE in management frames are changed
> regarding MU-MIMO configurations and not in hardware. Adding push of
> MU-MIMO configurations to the hardware as well.
>
> This patch is dependant on mac80211 patchset:
> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D683322=
&state=3D%2A&archive=3Dboth
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 199 +++++++++++++++++++++-------=
------
>  drivers/net/wireless/ath/ath11k/wmi.h |   3 +
>  2 files changed, 129 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless=
/ath/ath11k/mac.c
> index 6d83a178a891..83d4a565fe84 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -2697,6 +2697,117 @@ static int ath11k_setup_peer_smps(struct ath11k *=
ar, struct ath11k_vif *arvif,
>                                          ath11k_smps_map[smps]);
>  }
>
> +static bool ath11k_mac_set_he_txbf_conf(struct ath11k_vif *arvif)
> +{
> +       struct ath11k *ar =3D arvif->ar;
> +       u32 param, value;
> +       int ret;
> +
> +       if (!arvif->vif->bss_conf.he_support)
> +               return true;
> +
> +       param =3D WMI_VDEV_PARAM_SET_HEMU_MODE;
> +       value =3D 0;
> +       if (arvif->vif->bss_conf.he_su_beamformer) {
> +               value |=3D FIELD_PREP(HE_MODE_SU_TX_BFER, HE_SU_BFER_ENAB=
LE);
> +               if (arvif->vif->bss_conf.he_mu_beamformer &&
> +                   arvif->vdev_type =3D=3D WMI_VDEV_TYPE_AP)
> +                       value |=3D FIELD_PREP(HE_MODE_MU_TX_BFER, HE_MU_B=
FER_ENABLE);
> +       }
> +
> +       if (arvif->vif->type !=3D NL80211_IFTYPE_MESH_POINT) {
> +               value |=3D FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_ENA=
BLE) |
> +                        FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENABL=
E);
> +
> +               if (arvif->vif->bss_conf.he_full_ul_mumimo)
> +                       value |=3D FIELD_PREP(HE_MODE_UL_MUMIMO, HE_UL_MU=
MIMO_ENABLE);
> +
> +               if (arvif->vif->bss_conf.he_su_beamformee)
> +                       value |=3D FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_B=
FEE_ENABLE);
> +       }
> +
> +       ret =3D ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param, =
value);
> +       if (ret) {
> +               ath11k_warn(ar->ab, "failed to set vdev %d HE MU mode: %d=
\n",
> +                           arvif->vdev_id, ret);
> +               return false;
> +       }
> +
> +       param =3D WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE;
> +       value =3D FIELD_PREP(HE_VHT_SOUNDING_MODE, HE_VHT_SOUNDING_MODE_E=
NABLE) |
> +               FIELD_PREP(HE_TRIG_NONTRIG_SOUNDING_MODE,
> +                          HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE);
> +       ret =3D ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +                                           param, value);
> +       if (ret) {
> +               ath11k_warn(ar->ab, "failed to set vdev %d sounding mode:=
 %d\n",
> +                           arvif->vdev_id, ret);
> +               return false;
> +       }
> +       return true;
> +}
> +
> +static bool ath11k_mac_vif_recalc_sta_he_txbf(struct ath11k *ar,
> +                                             struct ieee80211_vif *vif,
> +                                             struct ieee80211_sta_he_cap=
 *he_cap)
> +{
> +       struct ath11k_vif *arvif =3D (void *)vif->drv_priv;
> +       struct ieee80211_he_cap_elem he_cap_elem =3D {0};
> +       struct ieee80211_sta_he_cap *cap_band =3D NULL;
> +       struct cfg80211_chan_def def;
> +       u32 param =3D WMI_VDEV_PARAM_SET_HEMU_MODE;
> +       u32 hemode =3D 0;
> +       int ret;
> +
> +       if (!vif->bss_conf.he_support)
> +               return true;
> +
> +       if (vif->type !=3D NL80211_IFTYPE_STATION)
> +               return false;
> +
> +       if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
> +               return false;
> +
> +       if (def.chan->band =3D=3D NL80211_BAND_2GHZ)
> +               cap_band =3D &ar->mac.iftype[NL80211_BAND_2GHZ][vif->type=
].he_cap;
> +       else
> +               cap_band =3D &ar->mac.iftype[NL80211_BAND_5GHZ][vif->type=
].he_cap;
> +
> +       memcpy(&he_cap_elem, &cap_band->he_cap_elem, sizeof(he_cap_elem))=
;
> +
> +       if (HECAP_PHY_SUBFME_GET(he_cap_elem.phy_cap_info)) {
> +               if (HECAP_PHY_SUBFMR_GET(he_cap->he_cap_elem.phy_cap_info=
))
> +                       hemode |=3D FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_=
BFEE_ENABLE);
> +               if (HECAP_PHY_MUBFMR_GET(he_cap->he_cap_elem.phy_cap_info=
))
> +                       hemode |=3D FIELD_PREP(HE_MODE_MU_TX_BFEE, HE_MU_=
BFEE_ENABLE);
> +       }
> +
> +       if (vif->type !=3D NL80211_IFTYPE_MESH_POINT) {
> +               hemode |=3D FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_EN=
ABLE) |
> +                         FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENAB=
LE);
> +
> +               if (HECAP_PHY_ULMUMIMO_GET(he_cap_elem.phy_cap_info))
> +                       if (HECAP_PHY_ULMUMIMO_GET(he_cap->he_cap_elem.ph=
y_cap_info))
> +                               hemode |=3D FIELD_PREP(HE_MODE_UL_MUMIMO,
> +                                                    HE_UL_MUMIMO_ENABLE)=
;
> +
> +               if (FIELD_GET(HE_MODE_MU_TX_BFEE, hemode))
> +                       hemode |=3D FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_=
BFEE_ENABLE);
> +
> +               if (FIELD_GET(HE_MODE_MU_TX_BFER, hemode))
> +                       hemode |=3D FIELD_PREP(HE_MODE_SU_TX_BFER, HE_SU_=
BFER_ENABLE);
> +       }
> +
> +       ret =3D ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param, =
hemode);
> +       if (ret) {
> +               ath11k_warn(ar->ab, "failed to submit vdev param txbf 0x%=
x: %d\n",
> +                           hemode, ret);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
>  static void ath11k_bss_assoc(struct ieee80211_hw *hw,
>                              struct ieee80211_vif *vif,
>                              struct ieee80211_bss_conf *bss_conf)
> @@ -2707,6 +2818,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *h=
w,
>         struct ieee80211_sta *ap_sta;
>         struct ath11k_peer *peer;
>         bool is_auth =3D false;
> +       struct ieee80211_sta_he_cap  he_cap;
>         int ret;
>
>         lockdep_assert_held(&ar->conf_mutex);
> @@ -2723,6 +2835,8 @@ static void ath11k_bss_assoc(struct ieee80211_hw *h=
w,
>                 rcu_read_unlock();
>                 return;
>         }
> +       /* he_cap here is updated at assoc success for sta mode only */
> +       he_cap  =3D ap_sta->deflink.he_cap;
>
>         ath11k_peer_assoc_prepare(ar, vif, ap_sta, &peer_arg, false);
>
> @@ -2751,6 +2865,12 @@ static void ath11k_bss_assoc(struct ieee80211_hw *=
hw,
>                 return;
>         }
>
> +       if (!ath11k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap)) {
> +               ath11k_warn(ar->ab, "failed to recalc he txbf for vdev %i=
 on bss %pM\n",
> +                           arvif->vdev_id, bss_conf->bssid);
> +               return;
> +       }
> +
>         WARN_ON(arvif->is_up);
>
>         arvif->aid =3D vif->cfg.aid;
> @@ -3200,6 +3320,8 @@ static void ath11k_mac_op_bss_info_changed(struct i=
eee80211_hw *hw,
>                 ether_addr_copy(arvif->bssid, info->bssid);
>
>         if (changed & BSS_CHANGED_BEACON_ENABLED) {
> +               if (info->enable_beacon)
> +                       ath11k_mac_set_he_txbf_conf(arvif);
>                 ath11k_control_beaconing(arvif, info);
>
>                 if (arvif->is_up && vif->bss_conf.he_support &&
> @@ -5369,6 +5491,10 @@ static int ath11k_mac_copy_he_cap(struct ath11k *a=
r,
>
>                 he_cap_elem->mac_cap_info[1] &=3D
>                         IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
> +               he_cap_elem->phy_cap_info[0] &=3D
> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_I=
N_5G;
> +               he_cap_elem->phy_cap_info[0] &=3D
> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80=
_MHZ_IN_5G;

Hi,
This is causing a regression for us in OpenWrt at least on IPQ8074 but
probably on all ath11k-supported HW.
Cause 80+80 and 160MHz support bits are being cleared here so 160MHz
is not being advertised after this patch.

I fail to understand why are 80+80 and 160 MHz feature flags being cleared?

Regards,
Robert

>
>                 he_cap_elem->phy_cap_info[5] &=3D
>                         ~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UND=
ER_80MHZ_MASK;
> @@ -6003,69 +6129,6 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_=
vif *arvif,
>         }
>  }
>
> -static u32
> -ath11k_mac_prepare_he_mode(struct ath11k_pdev *pdev, u32 viftype)
> -{
> -       struct ath11k_pdev_cap *pdev_cap =3D &pdev->cap;
> -       struct ath11k_band_cap *cap_band =3D NULL;
> -       u32 *hecap_phy_ptr =3D NULL;
> -       u32 hemode =3D 0;
> -
> -       if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP)
> -               cap_band =3D &pdev_cap->band[NL80211_BAND_2GHZ];
> -       else
> -               cap_band =3D &pdev_cap->band[NL80211_BAND_5GHZ];
> -
> -       hecap_phy_ptr =3D &cap_band->he_cap_phy_info[0];
> -
> -       hemode =3D FIELD_PREP(HE_MODE_SU_TX_BFEE, HE_SU_BFEE_ENABLE) |
> -                FIELD_PREP(HE_MODE_SU_TX_BFER, HECAP_PHY_SUBFMR_GET(heca=
p_phy_ptr)) |
> -                FIELD_PREP(HE_MODE_UL_MUMIMO, HECAP_PHY_ULMUMIMO_GET(hec=
ap_phy_ptr));
> -
> -       /* TODO WDS and other modes */
> -       if (viftype =3D=3D NL80211_IFTYPE_AP) {
> -               hemode |=3D FIELD_PREP(HE_MODE_MU_TX_BFER,
> -                         HECAP_PHY_MUBFMR_GET(hecap_phy_ptr)) |
> -                         FIELD_PREP(HE_MODE_DL_OFDMA, HE_DL_MUOFDMA_ENAB=
LE) |
> -                         FIELD_PREP(HE_MODE_UL_OFDMA, HE_UL_MUOFDMA_ENAB=
LE);
> -       } else {
> -               hemode |=3D FIELD_PREP(HE_MODE_MU_TX_BFEE, HE_MU_BFEE_ENA=
BLE);
> -       }
> -
> -       return hemode;
> -}
> -
> -static int ath11k_set_he_mu_sounding_mode(struct ath11k *ar,
> -                                         struct ath11k_vif *arvif)
> -{
> -       u32 param_id, param_value;
> -       struct ath11k_base *ab =3D ar->ab;
> -       int ret =3D 0;
> -
> -       param_id =3D WMI_VDEV_PARAM_SET_HEMU_MODE;
> -       param_value =3D ath11k_mac_prepare_he_mode(ar->pdev, arvif->vif->=
type);
> -       ret =3D ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> -                                           param_id, param_value);
> -       if (ret) {
> -               ath11k_warn(ab, "failed to set vdev %d HE MU mode: %d par=
am_value %x\n",
> -                           arvif->vdev_id, ret, param_value);
> -               return ret;
> -       }
> -       param_id =3D WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE;
> -       param_value =3D
> -               FIELD_PREP(HE_VHT_SOUNDING_MODE, HE_VHT_SOUNDING_MODE_ENA=
BLE) |
> -               FIELD_PREP(HE_TRIG_NONTRIG_SOUNDING_MODE,
> -                          HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE);
> -       ret =3D ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> -                                           param_id, param_value);
> -       if (ret) {
> -               ath11k_warn(ab, "failed to set vdev %d HE MU mode: %d\n",
> -                           arvif->vdev_id, ret);
> -               return ret;
> -       }
> -       return ret;
> -}
> -
>  static void ath11k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
>                                              struct ieee80211_vif *vif)
>  {
> @@ -6734,7 +6797,6 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *ar=
vif,
>         struct ath11k_base *ab =3D ar->ab;
>         struct wmi_vdev_start_req_arg arg =3D {};
>         const struct cfg80211_chan_def *chandef =3D &ctx->def;
> -       int he_support =3D arvif->vif->bss_conf.he_support;
>         int ret =3D 0;
>
>         lockdep_assert_held(&ar->conf_mutex);
> @@ -6775,15 +6837,6 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *a=
rvif,
>                 spin_lock_bh(&ab->base_lock);
>                 arg.regdomain =3D ar->ab->dfs_region;
>                 spin_unlock_bh(&ab->base_lock);
> -
> -               if (he_support) {
> -                       ret =3D ath11k_set_he_mu_sounding_mode(ar, arvif)=
;
> -                       if (ret) {
> -                               ath11k_warn(ar->ab, "failed to set he mod=
e vdev %i\n",
> -                                           arg.vdev_id);
> -                               return ret;
> -                       }
> -               }
>         }
>
>         arg.channel.passive |=3D !!(chandef->chan->flags & IEEE80211_CHAN=
_NO_IR);
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless=
/ath/ath11k/wmi.h
> index 368b7755e800..7e1eea784eb5 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -2895,8 +2895,11 @@ struct rx_reorder_queue_remove_params {
>  #define HE_DL_MUOFDMA_ENABLE   1
>  #define HE_UL_MUOFDMA_ENABLE   1
>  #define HE_DL_MUMIMO_ENABLE    1
> +#define HE_UL_MUMIMO_ENABLE    1
>  #define HE_MU_BFEE_ENABLE      1
>  #define HE_SU_BFEE_ENABLE      1
> +#define HE_MU_BFER_ENABLE      1
> +#define HE_SU_BFER_ENABLE      1
>
>  #define HE_VHT_SOUNDING_MODE_ENABLE            1
>  #define HE_SU_MU_SOUNDING_MODE_ENABLE          1
> --
> 2.7.4
>
>
> --
> ath11k mailing list
> ath11k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath11k



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
