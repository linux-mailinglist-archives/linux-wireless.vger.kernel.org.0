Return-Path: <linux-wireless+bounces-30307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7ADCEFBC1
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 07:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E1D300E146
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7427467F;
	Sat,  3 Jan 2026 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4mdZLoV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B775270EDF
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767421571; cv=none; b=SBWJZ/grDms1kpxzxspwouDzR7iEjetutlbl3WeR7R+wAZjw0t57zpQCz8r/XYqtkV2o35ZDKq/IxLtCCNIG8HrXJjSSKoQdvE1oxUTKzIq9W+vifdXW06pHOhmZLrpuch3Qi4WIQuOUVsXRP4QudEzFH9I73/t6XDzlXmT2RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767421571; c=relaxed/simple;
	bh=SLze2gTF42yO4IIx2KddPtEk7ZhsAAPsNfM5CoYTqQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guDe/QxScamOGp59VyLwY2lbW0MUZs6Aj6tSv9YRNV8PXE0mq66hAQfrPit/2KO98ffkAeUP0juilPQLpYpqiqMS/ODJUCcJ1gn00905FOSMBycBAwgCJe8+yXM1KTQMNxDgwoh4zx0x/yX7YgJ9Zotjc3TVA2EZptLovAzjQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4mdZLoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57ECC19422
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 06:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767421570;
	bh=SLze2gTF42yO4IIx2KddPtEk7ZhsAAPsNfM5CoYTqQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S4mdZLoVfsDrCbT39OVeJAlkRY41LdUQxy4H+yOwHxra5n0kuuTAoglbqurTqI8CG
	 h02g1G1cxvVqKZFebnrzgvDU00NZ8Di7+jzGnz+BDOsBJcGO9nCxRtpZkt3muLtGdx
	 KCBESCORcCaK0QH0zbCmPE1gevolchyznk5waqPAmoLj+NdCba8T6rpW9FPJL4UzIL
	 8gihOr+KXxfhF79iCkLQKmsTijwxuqUqIsyIZ6sHCeq8kaR5jsCbqstnzlB+jZmwU0
	 7TfeInTKx6wiHRmct728s10jNCBAU+X1e6CnLKTZbLOUcsW6k6Tfnfo8bZctN7gVDt
	 509woKdpC74WQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so10386195e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 22:26:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxp7Nt6sgjUYxvGlF6xb6nR6DjnGRFQd6vySiQGUZ+CEP40BppKdFo3VZKUUwbXbmPFzcNwAKbtrrzI6P0Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94ikNNHeGqWi49Hj65D9eZER1LPzyrGsyDocf5rPiCLTReCup
	ym5OCHj6LxjQr5R1rOEXUh+hBT3XHBTKHWiQI7ap7bVtZsUfbY8WyGIKccKFjCnKYjW8LGA/ldV
	7P4pbsQK1r5vrMc1iXHHwFrnFHST11z4=
X-Google-Smtp-Source: AGHT+IEAR5Ki7zr/XOXsOxD1TKY3Olq4C34632B9rFlp0KdQk12O+G0J2mwpMJ/qMh1uyAyCGgpfyN0HDozt6JEOGxw=
X-Received: by 2002:a05:6512:3b86:b0:595:8258:ccc5 with SMTP id
 2adb3069b0e04-59a17d3dd35mr15182661e87.26.1767421568911; Fri, 02 Jan 2026
 22:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102200315.290015-1-zbowling@gmail.com> <20260102200524.290779-1-zbowling@gmail.com>
In-Reply-To: <20260102200524.290779-1-zbowling@gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Sat, 3 Jan 2026 00:25:58 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzozp3-hG9vJ85a5zmM13+VdSJvn3jqeU1L4mdTu3N2+7g@mail.gmail.com>
X-Gm-Features: AQt7F2qtDR5kydu5ace_3DeVwtACos09ogNEdlGcR6GprZLfIKCjDpRFGViYDMA
Message-ID: <CAGp9Lzozp3-hG9vJ85a5zmM13+VdSJvn3jqeU1L4mdTu3N2+7g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7925: comprehensive stability fixes
To: Zac Bowling <zbowling@gmail.com>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zac,

Thanks for the extensive work digging into the MT7925 stability issues
the problems you=E2=80=99re addressing are real and definitely worth fixing=
.

For upstream review, it would help a lot to align with a few common practic=
es:

1) One patch should handle one issue. Splitting this into smaller,
   self-contained patches makes review easier and allows safe reverts.

2) For fixes of runtime failures (panic, NULL deref, hangs), please include
   the relevant dmesg or crash log in the commit message so reviewers and
   downstream users can clearly see the failure being addressed and
   determine whether they are hitting the same issue.

3) If a fix comes from static analysis (e.g. clang static analyzer), that=
=E2=80=99s
   perfectly fine, just mention it in the commit message and briefly explai=
n
   why the state or pointer can be invalid at runtime.

4) For review, it would also be helpful to aggregate the fixes from v1, v2,
   and this one into a clean v3 series based on the current wireless
   tree (https://github.com/nbd168/wireless.git).

                   Sean

On Fri, Jan 2, 2026 at 2:05=E2=80=AFPM Zac Bowling <zbowling@gmail.com> wro=
te:
>
> From: Zac Bowling <zac@zacbowling.com>
>
> This unified patch combines all MT7925 driver fixes for kernel stability:
>
> 1. NULL pointer dereference fixes in vif iteration, TX path, and MCU func=
tions
> 2. Missing mutex protection in reset, ROC, PM, and resume paths
> 3. Error handling for MCU commands (AMPDU, BSS info, key setup)
> 4. lockdep assertions for debugging
> 5. MLO (Multi-Link Operation) improvements for roaming and AP mode
> 6. Firmware reload recovery after crashes
>
> These fixes address kernel panics and system hangs that occur during:
> - WiFi network switching and BSSID roaming
> - Suspend/resume cycles
> - MLO link state transitions
> - Firmware recovery after crashes
>
> Tested on Framework Desktop (AMD Ryzen AI Max 300) with MT7925 (RZ717).
>
> Individual patches and detailed analysis available at:
> https://github.com/zbowling/mt7925
>
> Signed-off-by: Zac Bowling <zac@zacbowling.com>
> ---
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/init.c
> index d7d5afe365ed..f800112ccaf7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> @@ -162,10 +162,17 @@ void mt7925_regd_update(struct mt792x_dev *dev)
>         if (!dev->regd_change)
>                 return;
>
> -       mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
> +       if (mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env) < =
0)
> +               dev_warn(dev->mt76.dev, "Failed to set CLC\n");
> +
>         mt7925_regd_channel_update(wiphy, dev);
> -       mt7925_mcu_set_channel_domain(hw->priv);
> -       mt7925_set_tx_sar_pwr(hw, NULL);
> +
> +       if (mt7925_mcu_set_channel_domain(hw->priv) < 0)
> +               dev_warn(dev->mt76.dev, "Failed to set channel domain\n")=
;
> +
> +       if (mt7925_set_tx_sar_pwr(hw, NULL) < 0)
> +               dev_warn(dev->mt76.dev, "Failed to set TX SAR power\n");
> +
>         dev->regd_change =3D false;
>  }
>  EXPORT_SYMBOL_GPL(mt7925_regd_update);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mac.c
> index 1e44e96f034e..a4109dc72163 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> @@ -1270,6 +1270,12 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
>                 bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
>                 mconf =3D mt792x_vif_to_link(mvif, i);
>
> +               /* Skip links that don't have bss_conf set up yet in mac8=
0211.
> +                * This can happen during HW reset when link state is inc=
onsistent.
> +                */
> +               if (!bss_conf)
> +                       continue;
> +
>                 mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf-=
>mt76,
>                                             &mvif->sta.deflink.wcid, true=
);
>                 mt7925_mcu_set_tx(dev, bss_conf);
> @@ -1324,9 +1330,11 @@ void mt7925_mac_reset_work(struct work_struct *wor=
k)
>         dev->hw_full_reset =3D false;
>         pm->suspended =3D false;
>         ieee80211_wake_queues(hw);
> +       mt792x_mutex_acquire(dev);
>         ieee80211_iterate_active_interfaces(hw,
>                                             IEEE80211_IFACE_ITER_RESUME_A=
LL,
>                                             mt7925_vif_connect_iter, NULL=
);
> +       mt792x_mutex_release(dev);
>         mt76_connac_power_save_sched(&dev->mt76.phy, pm);
>
>         mt792x_mutex_acquire(dev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index ac3d485a2f78..b6e3002faf41 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -596,6 +596,17 @@ static int mt7925_set_link_key(struct ieee80211_hw *=
hw, enum set_key_cmd cmd,
>         link_sta =3D sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NU=
LL;
>         mconf =3D mt792x_vif_to_link(mvif, link_id);
>         mlink =3D mt792x_sta_to_link(msta, link_id);
> +
> +       if (!link_conf || !mconf || !mlink) {
> +               /* During MLO roaming, link state may be torn down before
> +                * mac80211 requests key removal. If removing a key and
> +                * the link is already gone, consider it successfully rem=
oved.
> +                */
> +               if (cmd !=3D SET_KEY)
> +                       return 0;
> +               return -EINVAL;
> +       }
> +
>         wcid =3D &mlink->wcid;
>         wcid_keyidx =3D &wcid->hw_key_idx;
>
> @@ -625,8 +636,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *=
hw, enum set_key_cmd cmd,
>                 struct mt792x_phy *phy =3D mt792x_hw_phy(hw);
>
>                 mconf->mt76.cipher =3D mt7925_mcu_get_cipher(key->cipher)=
;
> -               mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf,
> -                                       link_sta, true);
> +               err =3D mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, lin=
k_conf,
> +                                             link_sta, true);
> +               if (err)
> +                       goto out;
>         }
>
>         if (cmd =3D=3D SET_KEY)
> @@ -743,9 +756,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
>         bool monitor =3D !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
>
>         pm->enable =3D pm->enable_user && !monitor;
> +       mt792x_mutex_acquire(dev);
>         ieee80211_iterate_active_interfaces(hw,
>                                             IEEE80211_IFACE_ITER_RESUME_A=
LL,
>                                             mt7925_pm_interface_iter, dev=
);
> +       mt792x_mutex_release(dev);
>         pm->ds_enable =3D pm->ds_enable_user && !monitor;
>         mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
>  }
> @@ -848,12 +863,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev =
*mdev,
>
>         msta =3D (struct mt792x_sta *)link_sta->sta->drv_priv;
>         mlink =3D mt792x_sta_to_link(msta, link_id);
> +       if (!mlink)
> +               return -EINVAL;
>
>         idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1)=
;
>         if (idx < 0)
>                 return -ENOSPC;
>
>         mconf =3D mt792x_vif_to_link(mvif, link_id);
> +       if (!mconf)
> +               return -EINVAL;
> +
>         mt76_wcid_init(&mlink->wcid, 0);
>         mlink->wcid.sta =3D 1;
>         mlink->wcid.idx =3D idx;
> @@ -879,15 +899,20 @@ static int mt7925_mac_link_sta_add(struct mt76_dev =
*mdev,
>                                MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
>
>         link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
> +       if (!link_conf)
> +               return -EINVAL;
>
>         /* should update bss info before STA add */
>         if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->td=
ls) {
>                 if (ieee80211_vif_is_mld(vif))
> -                       mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ct=
x,
> -                                               link_conf, link_sta, link=
_sta !=3D mlink->pri_link);
> +                       ret =3D mt7925_mcu_add_bss_info(&dev->phy, mconf-=
>mt76.ctx,
> +                                                     link_conf, link_sta=
,
> +                                                     link_sta !=3D mlink=
->pri_link);
>                 else
> -                       mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ct=
x,
> -                                               link_conf, link_sta, fals=
e);
> +                       ret =3D mt7925_mcu_add_bss_info(&dev->phy, mconf-=
>mt76.ctx,
> +                                                     link_conf, link_sta=
, false);
> +               if (ret)
> +                       return ret;
>         }
>
>         if (ieee80211_vif_is_mld(vif) &&
> @@ -985,18 +1010,29 @@ mt7925_mac_set_links(struct mt76_dev *mdev, struct=
 ieee80211_vif *vif)
>  {
>         struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev, =
mt76);
>         struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> -       struct ieee80211_bss_conf *link_conf =3D
> -               mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
> -       struct cfg80211_chan_def *chandef =3D &link_conf->chanreq.oper;
> -       enum nl80211_band band =3D chandef->chan->band, secondary_band;
> +       struct ieee80211_bss_conf *link_conf;
> +       struct cfg80211_chan_def *chandef;
> +       enum nl80211_band band, secondary_band;
> +       u16 sel_links;
> +       u8 secondary_link_id;
> +
> +       link_conf =3D mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
> +       if (!link_conf)
> +               return;
> +
> +       chandef =3D &link_conf->chanreq.oper;
> +       band =3D chandef->chan->band;
>
> -       u16 sel_links =3D mt76_select_links(vif, 2);
> -       u8 secondary_link_id =3D __ffs(~BIT(mvif->deflink_id) & sel_links=
);
> +       sel_links =3D mt76_select_links(vif, 2);
> +       secondary_link_id =3D __ffs(~BIT(mvif->deflink_id) & sel_links);
>
>         if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
>                 return;
>
>         link_conf =3D mt792x_vif_to_bss_conf(vif, secondary_link_id);
> +       if (!link_conf)
> +               return;
> +
>         secondary_band =3D link_conf->chanreq.oper.chan->band;
>
>         if (band =3D=3D NL80211_BAND_2GHZ ||
> @@ -1024,6 +1060,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_d=
ev *mdev,
>
>         msta =3D (struct mt792x_sta *)link_sta->sta->drv_priv;
>         mlink =3D mt792x_sta_to_link(msta, link_sta->link_id);
> +       if (!mlink)
> +               return;
>
>         mt792x_mutex_acquire(dev);
>
> @@ -1033,12 +1071,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76=
_dev *mdev,
>                 link_conf =3D mt792x_vif_to_bss_conf(vif, vif->bss_conf.l=
ink_id);
>         }
>
> -       if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->td=
ls) {
> +       if (link_conf && vif->type =3D=3D NL80211_IFTYPE_STATION && !link=
_sta->sta->tdls) {
>                 struct mt792x_bss_conf *mconf;
>
>                 mconf =3D mt792x_link_conf_to_mconf(link_conf);
> -               mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
> -                                       link_conf, link_sta, true);
> +               if (mconf)
> +                       mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ct=
x,
> +                                               link_conf, link_sta, true=
);
>         }
>
>         ewma_avg_signal_init(&mlink->avg_ack_signal);
> @@ -1085,6 +1124,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_=
dev *mdev,
>
>         msta =3D (struct mt792x_sta *)link_sta->sta->drv_priv;
>         mlink =3D mt792x_sta_to_link(msta, link_id);
> +       if (!mlink)
> +               return;
>
>         mt7925_roc_abort_sync(dev);
>
> @@ -1098,10 +1139,12 @@ static void mt7925_mac_link_sta_remove(struct mt7=
6_dev *mdev,
>
>         link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
>
> -       if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->td=
ls) {
> +       if (link_conf && vif->type =3D=3D NL80211_IFTYPE_STATION && !link=
_sta->sta->tdls) {
>                 struct mt792x_bss_conf *mconf;
>
>                 mconf =3D mt792x_link_conf_to_mconf(link_conf);
> +               if (!mconf)
> +                       goto out;
>
>                 if (ieee80211_vif_is_mld(vif))
>                         mt792x_mac_link_bss_remove(dev, mconf, mlink);
> @@ -1109,6 +1152,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_=
dev *mdev,
>                         mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ct=
x, link_conf,
>                                                 link_sta, false);
>         }
> +out:
>
>         spin_lock_bh(&mdev->sta_poll_lock);
>         if (!list_empty(&mlink->wcid.poll_list))
> @@ -1247,22 +1291,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, stru=
ct ieee80211_vif *vif,
>         case IEEE80211_AMPDU_RX_START:
>                 mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, =
ssn,
>                                    params->buf_size);
> -               mt7925_mcu_uni_rx_ba(dev, params, true);
> +               ret =3D mt7925_mcu_uni_rx_ba(dev, params, true);
>                 break;
>         case IEEE80211_AMPDU_RX_STOP:
>                 mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
> -               mt7925_mcu_uni_rx_ba(dev, params, false);
> +               ret =3D mt7925_mcu_uni_rx_ba(dev, params, false);
>                 break;
>         case IEEE80211_AMPDU_TX_OPERATIONAL:
>                 mtxq->aggr =3D true;
>                 mtxq->send_bar =3D false;
> -               mt7925_mcu_uni_tx_ba(dev, params, true);
> +               ret =3D mt7925_mcu_uni_tx_ba(dev, params, true);
>                 break;
>         case IEEE80211_AMPDU_TX_STOP_FLUSH:
>         case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
>                 mtxq->aggr =3D false;
>                 clear_bit(tid, &msta->deflink.wcid.ampdu_state);
> -               mt7925_mcu_uni_tx_ba(dev, params, false);
> +               ret =3D mt7925_mcu_uni_tx_ba(dev, params, false);
>                 break;
>         case IEEE80211_AMPDU_TX_START:
>                 set_bit(tid, &msta->deflink.wcid.ampdu_state);
> @@ -1271,8 +1315,9 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct=
 ieee80211_vif *vif,
>         case IEEE80211_AMPDU_TX_STOP_CONT:
>                 mtxq->aggr =3D false;
>                 clear_bit(tid, &msta->deflink.wcid.ampdu_state);
> -               mt7925_mcu_uni_tx_ba(dev, params, false);
> -               ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
> +               ret =3D mt7925_mcu_uni_tx_ba(dev, params, false);
> +               if (!ret)
> +                       ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, t=
id);
>                 break;
>         }
>         mt792x_mutex_release(dev);
> @@ -1293,12 +1338,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ie=
ee80211_vif *vif)
>         if (mvif->mlo_pm_state !=3D MT792x_MLO_CHANGED_PS)
>                 return;
>
> -       mt792x_mutex_acquire(dev);
>         for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
>                 bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
> +               if (!bss_conf)
> +                       continue;
>                 mt7925_mcu_uni_bss_ps(dev, bss_conf);
>         }
> -       mt792x_mutex_release(dev);
>  }
>
>  void mt7925_mlo_pm_work(struct work_struct *work)
> @@ -1307,9 +1352,11 @@ void mt7925_mlo_pm_work(struct work_struct *work)
>                                               mlo_pm_work.work);
>         struct ieee80211_hw *hw =3D mt76_hw(dev);
>
> +       mt792x_mutex_acquire(dev);
>         ieee80211_iterate_active_interfaces(hw,
>                                             IEEE80211_IFACE_ITER_RESUME_A=
LL,
>                                             mt7925_mlo_pm_iter, dev);
> +       mt792x_mutex_release(dev);
>  }
>
>  static bool is_valid_alpha2(const char *alpha2)
> @@ -1645,6 +1692,8 @@ static void mt7925_ipv6_addr_change(struct ieee8021=
1_hw *hw,
>
>         for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
>                 bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
> +               if (!bss_conf)
> +                       continue;
>                 __mt7925_ipv6_addr_change(hw, bss_conf, idev);
>         }
>  }
> @@ -1706,6 +1755,9 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif,
>                     [IEEE80211_AC_BK] =3D 1,
>         };
>
> +       if (!mconf)
> +               return -EINVAL;
> +
>         /* firmware uses access class index */
>         mconf->queue_params[mq_to_aci[queue]] =3D *params;
>
> @@ -1876,6 +1928,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211=
_hw *hw,
>         if (changed & BSS_CHANGED_ARP_FILTER) {
>                 for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) =
{
>                         bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
> +                       if (!bss_conf)
> +                               continue;
>                         mt7925_mcu_update_arp_filter(&dev->mt76, bss_conf=
);
>                 }
>         }
> @@ -1891,6 +1945,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211=
_hw *hw,
>                         } else if (mvif->mlo_pm_state =3D=3D MT792x_MLO_C=
HANGED_PS) {
>                                 for_each_set_bit(i, &valid, IEEE80211_MLD=
_MAX_NUM_LINKS) {
>                                         bss_conf =3D mt792x_vif_to_bss_co=
nf(vif, i);
> +                                       if (!bss_conf)
> +                                               continue;
>                                         mt7925_mcu_uni_bss_ps(dev, bss_co=
nf);
>                                 }
>                         }
> @@ -1912,7 +1968,12 @@ static void mt7925_link_info_changed(struct ieee80=
211_hw *hw,
>         struct ieee80211_bss_conf *link_conf;
>
>         mconf =3D mt792x_vif_to_link(mvif, info->link_id);
> +       if (!mconf)
> +               return;
> +
>         link_conf =3D mt792x_vif_to_bss_conf(vif, mconf->link_id);
> +       if (!link_conf)
> +               return;
>
>         mt792x_mutex_acquire(dev);
>
> @@ -2033,6 +2094,11 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, s=
truct ieee80211_vif *vif,
>                 mlink =3D mlinks[link_id];
>                 link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
>
> +               if (!link_conf) {
> +                       err =3D -EINVAL;
> +                       goto free;
> +               }
> +
>                 rcu_assign_pointer(mvif->link_conf[link_id], mconf);
>                 rcu_assign_pointer(mvif->sta.link[link_id], mlink);
>
> @@ -2113,9 +2179,14 @@ static int mt7925_assign_vif_chanctx(struct ieee80=
211_hw *hw,
>
>         if (ieee80211_vif_is_mld(vif)) {
>                 mconf =3D mt792x_vif_to_link(mvif, link_conf->link_id);
> +               if (!mconf) {
> +                       mutex_unlock(&dev->mt76.mutex);
> +                       return -EINVAL;
> +               }
> +
>                 pri_link_conf =3D mt792x_vif_to_bss_conf(vif, mvif->defli=
nk_id);
>
> -               if (vif->type =3D=3D NL80211_IFTYPE_STATION &&
> +               if (pri_link_conf && vif->type =3D=3D NL80211_IFTYPE_STAT=
ION &&
>                     mconf =3D=3D &mvif->bss_conf)
>                         mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link=
_conf,
>                                                 NULL, true);
> @@ -2144,6 +2215,10 @@ static void mt7925_unassign_vif_chanctx(struct iee=
e80211_hw *hw,
>
>         if (ieee80211_vif_is_mld(vif)) {
>                 mconf =3D mt792x_vif_to_link(mvif, link_conf->link_id);
> +               if (!mconf) {
> +                       mutex_unlock(&dev->mt76.mutex);
> +                       return;
> +               }
>
>                 if (vif->type =3D=3D NL80211_IFTYPE_STATION &&
>                     mconf =3D=3D &mvif->bss_conf)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.c
> index 8eda407e4135..cf38e36790e7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -1722,6 +1722,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
>
>         link_conf =3D mt792x_vif_to_bss_conf(vif, link_sta->link_id);
>         mconf =3D mt792x_vif_to_link(mvif, link_sta->link_id);
> +
> +       if (!link_conf || !mconf)
> +               return;
> +
>         chandef =3D mconf->mt76.ctx ? &mconf->mt76.ctx->def :
>                                     &link_conf->chanreq.oper;
>
> @@ -1800,6 +1804,10 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
>
>         link_conf =3D mt792x_vif_to_bss_conf(vif, link_sta->link_id);
>         mconf =3D mt792x_vif_to_link(mvif, link_sta->link_id);
> +
> +       if (!link_conf || !mconf)
> +               return;
> +
>         chandef =3D mconf->mt76.ctx ? &mconf->mt76.ctx->def :
>                                     &link_conf->chanreq.oper;
>         band =3D chandef->chan->band;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/pci.c
> index 8eb1fe1082d1..b6c90c5f7e91 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> @@ -454,7 +454,9 @@ static int mt7925_pci_suspend(struct device *device)
>         cancel_delayed_work_sync(&pm->ps_work);
>         cancel_work_sync(&pm->wake_work);
>
> +       mt792x_mutex_acquire(dev);
>         mt7925_roc_abort_sync(dev);
> +       mt792x_mutex_release(dev);
>
>         err =3D mt792x_mcu_drv_pmctrl(dev);
>         if (err < 0)
> @@ -581,10 +583,12 @@ static int _mt7925_pci_resume(struct device *device=
, bool restore)
>         }
>
>         /* restore previous ds setting */
> +       mt792x_mutex_acquire(dev);
>         if (!pm->ds_enable)
>                 mt7925_mcu_set_deep_sleep(dev, false);
>
>         mt7925_regd_update(dev);
> +       mt792x_mutex_release(dev);
>  failed:
>         pm->suspended =3D false;
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/n=
et/wireless/mediatek/mt76/mt792x_core.c
> index 9cad572c34a3..0170a23b0529 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -95,6 +95,8 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee8021=
1_tx_control *control,
>                                        IEEE80211_TX_CTRL_MLO_LINK);
>                 sta =3D (struct mt792x_sta *)control->sta->drv_priv;
>                 mlink =3D mt792x_sta_to_link(sta, link_id);
> +               if (!mlink)
> +                       goto free_skb;
>                 wcid =3D &mlink->wcid;
>         }
>
> @@ -113,9 +115,12 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee8=
0211_tx_control *control,
>                 link_id =3D wcid->link_id;
>                 rcu_read_lock();
>                 conf =3D rcu_dereference(vif->link_conf[link_id]);
> -               memcpy(hdr->addr2, conf->addr, ETH_ALEN);
> -
>                 link_sta =3D rcu_dereference(control->sta->link[link_id])=
;
> +               if (!conf || !link_sta) {
> +                       rcu_read_unlock();
> +                       goto free_skb;
> +               }
> +               memcpy(hdr->addr2, conf->addr, ETH_ALEN);
>                 memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
>
>                 if (vif->type =3D=3D NL80211_IFTYPE_STATION)
> @@ -136,6 +141,10 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee8=
0211_tx_control *control,
>         }
>
>         mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
> +       return;
> +
> +free_skb:
> +       ieee80211_free_txskb(hw, skb);
>  }
>  EXPORT_SYMBOL_GPL(mt792x_tx);
>
>

