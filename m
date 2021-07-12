Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808D53C4755
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 12:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhGLGcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 02:32:20 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:55606
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236626AbhGLGaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 02:30:19 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 258F8404A0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 06:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626070733;
        bh=RtjiaRn1J7xnCAz5c64rPrmdY4IFZ2fXVXNphP7I2r8=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=PoX5OFR7zV/EXf4ZNdAc032FnewFZ/pp6OdMII1B5zpKdVRvFhRZ0ylihk8Pcuwwz
         YdJHoQ90QCstPdnhBpHFJB2pw6iWEE2ai4FBcZcAbSyvCjFRq8uNuPNlHFJffyQNHZ
         DUSSaqDeJdGLxIqlJw1MislG1CrK464zg6oypM5OHQOrJyaHwULJ1Ep0OpXB8c7nmg
         g9rpCXMdLZChLCiKBLPKmUqvdfRspdMT6/R7VcS+0X/iZzG4wSamZz/TNSuW67cUKi
         6oBwovC0y2Xs7nfXVMcKb94j6lB7L5vudKCmPiwDAheDguZ9QOLhnoh3wS6Xl7zldt
         8v23Pdn9bGmMg==
Received: by mail-oi1-f199.google.com with SMTP id w18-20020a0568080d52b029023e3c1124c9so12300954oik.11
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jul 2021 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtjiaRn1J7xnCAz5c64rPrmdY4IFZ2fXVXNphP7I2r8=;
        b=FGBapmDSmispBEAww9oEwzsldg+jJWgPxU96GW+o4OBiRutPu5z88PGrkLyGMPzElm
         jBLTIgRuggEOh/S6IqTCGAWBCn4o8S8ZL7pDKgTug7f2cqjg/AHVHDzd1tJNicmL+S1C
         LAvzM1wRCwtpq8Aau5ot8d182Zvbdn9aKNuSyB8iwPkXOjo5b5Pjq7UGhjggk41uUAPe
         yrKhUqR3Uzer5IiZvTgm10Be9kZz8wSCHb+g7cAR0fm7CTiXZBprvwBJxA4dvd7hFL1l
         +AC4E1aFPc//qW+mK/zR13pLf3wKAPIz5Zrg1YyNdYqwVF13plXoTu23c5CBo/ZmVGA1
         djvQ==
X-Gm-Message-State: AOAM533J8plb8cfBFEd/5t76P1EpMvFpfcULEwGRDSmthF63+xfGHSqu
        u6pvhLH0HPW26g4HE+LPBqskF/q8Bp8QQ8iOq/sDVBsO3yoB9yHp0SsKQPMQ7ePOzRoaI8bmeJc
        cBsQFFHSEKHdWQIiEA0FS90nkuCh19GMXX6hXogoqyx1b4kknfm/7S63i55ho
X-Received: by 2002:a9d:3406:: with SMTP id v6mr37766047otb.347.1626070732031;
        Sun, 11 Jul 2021 23:18:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxA9Jql3O6KfluSO4TvCntaJA5kid7yqtgXbiloZZlEKG/c+AOhPizZ/fhkrmAaj++s8A8feLipZuakBYlhZ8=
X-Received: by 2002:a9d:3406:: with SMTP id v6mr37766029otb.347.1626070731813;
 Sun, 11 Jul 2021 23:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210630160151.28227-1-chris.chiu@canonical.com>
In-Reply-To: <20210630160151.28227-1-chris.chiu@canonical.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 12 Jul 2021 14:18:41 +0800
Message-ID: <CABTNMG1FJYP4O021mWgVU0ZJZJmBTvm-x3sM0_dHCfa0LbOYDA@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Fix the handling of TX A-MPDU aggregation
To:     Jes.Sorensen@gmail.com, Kalle Valo <kvalo@codeaurora.org>,
        davem@davemloft.net, kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 1, 2021 at 12:02 AM <chris.chiu@canonical.com> wrote:
>
> From: Chris Chiu <chris.chiu@canonical.com>
>
> The TX A-MPDU aggregation is not handled in the driver since the
> ieee80211_start_tx_ba_session has never been started properly.
> Start and stop the TX BA session by tracking the TX aggregation
> status of each TID. Fix the ampdu_action and the tx descriptor
> accordingly with the given TID.
>
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  2 ++
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 33 ++++++++++++++-----
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index d1a566cc0c9e..3f7ff84f2056 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1383,6 +1383,8 @@ struct rtl8xxxu_priv {
>         u8 no_pape:1;
>         u8 int_buf[USB_INTR_CONTENT_LENGTH];
>         u8 rssi_level;
> +       bool tx_aggr_started[IEEE80211_NUM_TIDS];
> +       DECLARE_BITMAP(tid_bitmap, IEEE80211_NUM_TIDS);
>         /*
>          * Only one virtual interface permitted because only STA mode
>          * is supported and no iface_combinations are provided.
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 9ff09cf7eb62..03c6ed7efe06 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4805,6 +4805,8 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>         struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
>         struct rtl8xxxu_priv *priv = hw->priv;
>         struct device *dev = &priv->udev->dev;
> +       u8 *qc = ieee80211_get_qos_ctl(hdr);
> +       u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
>         u32 rate;
>         u16 rate_flags = tx_info->control.rates[0].flags;
>         u16 seq_number;
> @@ -4828,7 +4830,7 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>
>         tx_desc->txdw3 = cpu_to_le32((u32)seq_number << TXDESC32_SEQ_SHIFT);
>
> -       if (ampdu_enable)
> +       if (ampdu_enable && test_bit(tid, priv->tid_bitmap))
>                 tx_desc->txdw1 |= cpu_to_le32(TXDESC32_AGG_ENABLE);
>         else
>                 tx_desc->txdw1 |= cpu_to_le32(TXDESC32_AGG_BREAK);
> @@ -4876,6 +4878,8 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>         struct rtl8xxxu_priv *priv = hw->priv;
>         struct device *dev = &priv->udev->dev;
>         struct rtl8xxxu_txdesc40 *tx_desc40;
> +       u8 *qc = ieee80211_get_qos_ctl(hdr);
> +       u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
>         u32 rate;
>         u16 rate_flags = tx_info->control.rates[0].flags;
>         u16 seq_number;
> @@ -4902,7 +4906,7 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>
>         tx_desc40->txdw9 = cpu_to_le32((u32)seq_number << TXDESC40_SEQ_SHIFT);
>
> -       if (ampdu_enable)
> +       if (ampdu_enable && test_bit(tid, priv->tid_bitmap))
>                 tx_desc40->txdw2 |= cpu_to_le32(TXDESC40_AGG_ENABLE);
>         else
>                 tx_desc40->txdw2 |= cpu_to_le32(TXDESC40_AGG_BREAK);
> @@ -5015,12 +5019,19 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>         if (ieee80211_is_data_qos(hdr->frame_control) && sta) {
>                 if (sta->ht_cap.ht_supported) {
>                         u32 ampdu, val32;
> +                       u8 *qc = ieee80211_get_qos_ctl(hdr);
> +                       u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
>
>                         ampdu = (u32)sta->ht_cap.ampdu_density;
>                         val32 = ampdu << TXDESC_AMPDU_DENSITY_SHIFT;
>                         tx_desc->txdw2 |= cpu_to_le32(val32);
>
>                         ampdu_enable = true;
> +
> +                       if (!priv->tx_aggr_started[tid] &&
> +                               !(skb->protocol == cpu_to_be16(ETH_P_PAE)))
> +                               if (!ieee80211_start_tx_ba_session(sta, tid, 0))
> +                                       priv->tx_aggr_started[tid] = true;
>                 }
>         }
>
> @@ -6089,6 +6100,7 @@ rtl8xxxu_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>         struct device *dev = &priv->udev->dev;
>         u8 ampdu_factor, ampdu_density;
>         struct ieee80211_sta *sta = params->sta;
> +       u16 tid = params->tid;
>         enum ieee80211_ampdu_mlme_action action = params->action;
>
>         switch (action) {
> @@ -6101,17 +6113,20 @@ rtl8xxxu_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>                 dev_dbg(dev,
>                         "Changed HT: ampdu_factor %02x, ampdu_density %02x\n",
>                         ampdu_factor, ampdu_density);
> -               break;
> +               return IEEE80211_AMPDU_TX_START_IMMEDIATE;
> +       case IEEE80211_AMPDU_TX_STOP_CONT:
>         case IEEE80211_AMPDU_TX_STOP_FLUSH:
> -               dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_STOP_FLUSH\n", __func__);
> -               rtl8xxxu_set_ampdu_factor(priv, 0);
> -               rtl8xxxu_set_ampdu_min_space(priv, 0);
> -               break;
>         case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
> -               dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_STOP_FLUSH_CONT\n",
> -                        __func__);
> +               dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_STOP\n", __func__);
>                 rtl8xxxu_set_ampdu_factor(priv, 0);
>                 rtl8xxxu_set_ampdu_min_space(priv, 0);
> +               priv->tx_aggr_started[tid] = false;
> +               clear_bit(tid, priv->tid_bitmap);
> +               ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
> +               break;
> +       case IEEE80211_AMPDU_TX_OPERATIONAL:
> +               dev_dbg(dev, "%s: IEEE80211_AMPDU_TX_OPERATIONAL\n", __func__);
> +               set_bit(tid, priv->tid_bitmap);
>                 break;
>         case IEEE80211_AMPDU_RX_START:
>                 dev_dbg(dev, "%s: IEEE80211_AMPDU_RX_START\n", __func__);
> --
> 2.20.1
>

Gentle ping. Any suggestion is welcome. Thanks

Chris
