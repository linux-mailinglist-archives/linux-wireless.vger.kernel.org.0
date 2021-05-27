Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A983927AF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 08:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhE0Gen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 02:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhE0Gem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 02:34:42 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2273C061574
        for <linux-wireless@vger.kernel.org>; Wed, 26 May 2021 23:33:08 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id n61so2210350uan.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 May 2021 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xydnmpXCoXyN1dGSUZuFfpkhGxCuQ5SYxSn4SXiZv8g=;
        b=FEIgL2eTCHo4C2bqPheR1hlACfg5+sbgczkdevVxQhkIEt1CQoJniVbHL5Lom2ZPS9
         NezDfy1ldJYjJ1cOclqyI1b2fWnZq6oabjgYxDIqtUeY17BxktrFhwwcsoU733s16FT2
         SFRZ1nOjYtix3C11bDzdShSA3CXLgFMSQQml2XGf4zxAAcAVNIcFx2StEBcavaXkNW6w
         Q0XIt/zaqRca5E3XwrzenRv/lmanILXWiuGfrKKmcNl9dZ+DuClB+I6JbxgzzhDpDRO/
         xF7rDgYWKERiqbXJ7g63vAcPv6c6HLqf1cLyBw6NG3cVj/FMHVZSiuMcvn2CZTZHn4Br
         MOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xydnmpXCoXyN1dGSUZuFfpkhGxCuQ5SYxSn4SXiZv8g=;
        b=VE6qm5CvqY+GnoRgLNXhxXsbyv690y841M0K4sce1CFcEklJlF7w8Qpc2pISF6FqmM
         /3mgswQJEpJzdcIDaA5JxsaWDLUAHbzd+cSxnp+lo60cDc9AwrDPpnLxr8VB25URjFZH
         66B5OQitX0Dnz0ifL5763/61ZqqHzf7LM/TTCKZW0dXPxHFkO9Obwrh0zxOicAAXgerR
         aeD7WmlZUWc3oKsbdOCcirpTCBxDahh4zmlWmKPAIWKOg3t2NqDwRsZtlKaa9/lv/JgC
         4o1pJFporgiTo61OCltugOzX0bekoMiF2ejxVwu6UFqlocmA3fWW6eWfYyM/sZkib+rK
         pIpg==
X-Gm-Message-State: AOAM5300wSNJl2Z+6XyKBdLUOGaceq9lVjdNCBLlkXUhWs8v87vWI5X8
        GDfap9yk/d1pOS2gQWn0xDOgjyqI9EosPZ+3fLrD+Tqv8NIx2A==
X-Google-Smtp-Source: ABdhPJxKkAYYmFuIV6wVwHktoy7Mx7diWzG54tfC2Et9TxirusEckHZSZLBqGGpFziahOL0cDSt/Qo75OfFGfIpinBI=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr955455vkd.15.1622097187886;
 Wed, 26 May 2021 23:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210524103130.66693-1-hujy652@gmail.com> <CAOw_LSHxiHR=Y_LsUmj=oWJwgWOTLsZyDsNrDoachGYMVoRtoQ@mail.gmail.com>
In-Reply-To: <CAOw_LSHxiHR=Y_LsUmj=oWJwgWOTLsZyDsNrDoachGYMVoRtoQ@mail.gmail.com>
From:   =?UTF-8?B?5ri45pm66Yie?= <hujy652@gmail.com>
Date:   Thu, 27 May 2021 14:32:58 +0800
Message-ID: <CAHGaMk_Qxyjz2HMCQeoxc=v1CiqzfVxgf3i-x7jcomM1kkPbog@mail.gmail.com>
Subject: Re: [RFC] ath10k: add tx hw 802.11 encapsulation offloading support
To:     Daniel Lenski <dlenski@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On Wed, May 26, 2021 at 2:23 AM Daniel Lenski <dlenski@gmail.com> wrote:
> >
> > On Mon, May 24, 2021 at 4:30 PM Zhijun You <hujy652@gmail.com> wrote:
> > > Currently only implement for 32bit target with 3-addr AP and STA mode.
> >
> > Any reason this couldn't be implemented for 64bit targets?
> > It looks like the 2-line changes to ath10k_htt_tx_32 would simply need
> > copying to ath10k_htt_tx_64.

Here the 64bit target means the chip not the host CPU.
If you look at the core.c only WCN3990 has target_64bit set to true.

I don't have that specific chip to test.

Best,
Zhijun


On Wed, May 26, 2021 at 2:23 AM Daniel Lenski <dlenski@gmail.com> wrote:
>
> On Mon, May 24, 2021 at 4:30 PM Zhijun You <hujy652@gmail.com> wrote:
> > Currently only implement for 32bit target with 3-addr AP and STA mode.
>
> Any reason this couldn't be implemented for 64bit targets?
> It looks like the 2-line changes to ath10k_htt_tx_32 would simply need
> copying to ath10k_htt_tx_64.
>
> I could test this on amd64 with QCA9377, if there are no other impediments.
>
> Dan
> > @@ -1436,15 +1439,17 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
> >         txbuf_paddr = htt->txbuf.paddr +
> >                       (sizeof(struct ath10k_htt_txbuf_32) * msdu_id);
> >
> > -       if ((ieee80211_is_action(hdr->frame_control) ||
> > -            ieee80211_is_deauth(hdr->frame_control) ||
> > -            ieee80211_is_disassoc(hdr->frame_control)) &&
> > -            ieee80211_has_protected(hdr->frame_control)) {
> > -               skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
> > -       } else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
> > -                  txmode == ATH10K_HW_TXRX_RAW &&
> > -                  ieee80211_has_protected(hdr->frame_control)) {
> > -               skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
> > +       if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
> > +               if ((ieee80211_is_action(hdr->frame_control) ||
> > +                    ieee80211_is_deauth(hdr->frame_control) ||
> > +                    ieee80211_is_disassoc(hdr->frame_control)) &&
> > +                    ieee80211_has_protected(hdr->frame_control)) {
> > +                       skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
> > +               } else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
> > +                          txmode == ATH10K_HW_TXRX_RAW &&
> > +                          ieee80211_has_protected(hdr->frame_control)) {
> > +                       skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
> > +               }
> >         }
> >
> >         skb_cb->paddr = dma_map_single(dev, msdu->data, msdu->len,
> > diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> > index bb6c5ee43ac0..ee64039c3726 100644
> > --- a/drivers/net/wireless/ath/ath10k/mac.c
> > +++ b/drivers/net/wireless/ath/ath10k/mac.c
> > @@ -3703,12 +3703,16 @@ ath10k_mac_tx_h_get_txmode(struct ath10k *ar,
> >                            struct sk_buff *skb)
> >  {
> >         const struct ieee80211_hdr *hdr = (void *)skb->data;
> > +       struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
> >         const struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(skb);
> >         __le16 fc = hdr->frame_control;
> >
> >         if (!vif || vif->type == NL80211_IFTYPE_MONITOR)
> >                 return ATH10K_HW_TXRX_RAW;
> >
> > +       if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
> > +               return ATH10K_HW_TXRX_ETHERNET;
> > +
> >         if (ieee80211_is_mgmt(fc))
> >                 return ATH10K_HW_TXRX_MGMT;
> >
> > @@ -3866,6 +3870,13 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
> >         bool noack = false;
> >
> >         cb->flags = 0;
> > +       cb->vif = vif;
> > +       cb->txq = txq;
> > +       cb->airtime_est = airtime;
> > +
> > +       if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
> > +               return;
> > +
> >         if (!ath10k_tx_h_use_hwcrypto(vif, skb))
> >                 cb->flags |= ATH10K_SKB_F_NO_HWCRYPT;
> >
> > @@ -3904,9 +3915,6 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
> >                 cb->flags |= ATH10K_SKB_F_RAW_TX;
> >         }
> >
> > -       cb->vif = vif;
> > -       cb->txq = txq;
> > -       cb->airtime_est = airtime;
> >         if (sta) {
> >                 arsta = (struct ath10k_sta *)sta->drv_priv;
> >                 spin_lock_bh(&ar->data_lock);
> > @@ -4015,6 +4023,9 @@ static int ath10k_mac_tx(struct ath10k *ar,
> >         const struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(skb);
> >         int ret;
> >
> > +       if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
> > +               goto skip_encap;
> > +
> >         /* We should disable CCK RATE due to P2P */
> >         if (info->flags & IEEE80211_TX_CTL_NO_CCK_RATE)
> >                 ath10k_dbg(ar, ATH10K_DBG_MAC, "IEEE80211_TX_CTL_NO_CCK_RATE\n");
> > @@ -4038,6 +4049,7 @@ static int ath10k_mac_tx(struct ath10k *ar,
> >                 }
> >         }
> >
> > +skip_encap:
> >         if (!noque_offchan && info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) {
> >                 if (!ath10k_mac_tx_frm_has_freq(ar)) {
> >                         ath10k_dbg(ar, ATH10K_DBG_MAC, "mac queued offchannel skb %pK len %d\n",
> > @@ -4087,6 +4099,7 @@ void ath10k_offchan_tx_work(struct work_struct *work)
> >         int ret;
> >         unsigned long time_left;
> >         bool tmp_peer_created = false;
> > +       struct ieee80211_tx_info *info;
> >
> >         /* FW requirement: We must create a peer before FW will send out
> >          * an offchannel frame. Otherwise the frame will be stuck and
> > @@ -4106,8 +4119,13 @@ void ath10k_offchan_tx_work(struct work_struct *work)
> >                 ath10k_dbg(ar, ATH10K_DBG_MAC, "mac offchannel skb %pK len %d\n",
> >                            skb, skb->len);
> >
> > -               hdr = (struct ieee80211_hdr *)skb->data;
> > -               peer_addr = ieee80211_get_DA(hdr);
> > +               info = IEEE80211_SKB_CB(skb);
> > +               if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
> > +                       peer_addr = skb->data;
> > +               } else {
> > +                       hdr = (struct ieee80211_hdr *)skb->data;
> > +                       peer_addr = ieee80211_get_DA(hdr);
> > +               }
> >
> >                 spin_lock_bh(&ar->data_lock);
> >                 vdev_id = ar->scan.vdev_id;
> > @@ -4639,7 +4657,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
> >         struct ieee80211_vif *vif = info->control.vif;
> >         struct ieee80211_sta *sta = control->sta;
> >         struct ieee80211_txq *txq = NULL;
> > -       struct ieee80211_hdr *hdr = (void *)skb->data;
> > +       struct ieee80211_hdr *hdr;
> >         enum ath10k_hw_txrx_mode txmode;
> >         enum ath10k_mac_tx_path txpath;
> >         bool is_htt;
> > @@ -4659,7 +4677,6 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
> >
> >         if (is_htt) {
> >                 spin_lock_bh(&ar->htt.tx_lock);
> > -               is_presp = ieee80211_is_probe_resp(hdr->frame_control);
> >
> >                 ret = ath10k_htt_tx_inc_pending(htt);
> >                 if (ret) {
> > @@ -4670,14 +4687,19 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
> >                         return;
> >                 }
> >
> > -               ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
> > -               if (ret) {
> > -                       ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
> > -                                  ret);
> > -                       ath10k_htt_tx_dec_pending(htt);
> > -                       spin_unlock_bh(&ar->htt.tx_lock);
> > -                       ieee80211_free_txskb(ar->hw, skb);
> > -                       return;
> > +               if (is_mgmt) {
> > +                       hdr = (struct ieee80211_hdr *)skb->data;
> > +                       is_presp = ieee80211_is_probe_resp(hdr->frame_control);
> > +
> > +                       ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
> > +                       if (ret) {
> > +                               ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
> > +                                          ret);
> > +                               ath10k_htt_tx_dec_pending(htt);
> > +                               spin_unlock_bh(&ar->htt.tx_lock);
> > +                               ieee80211_free_txskb(ar->hw, skb);
> > +                               return;
> > +                       }
> >                 }
> >                 spin_unlock_bh(&ar->htt.tx_lock);
> >         }
> > @@ -5441,6 +5463,36 @@ static int ath10k_mac_set_txbf_conf(struct ath10k_vif *arvif)
> >                                          ar->wmi.vdev_param->txbf, value);
> >  }
> >
> > +static void ath10k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
> > +                                            struct ieee80211_vif *vif)
> > +{
> > +       struct ath10k *ar = hw->priv;
> > +       struct ath10k_vif *arvif = (void *)vif->drv_priv;
> > +       u32 vdev_param, param_value;
> > +       int ret;
> > +
> > +       if (!ar->ethernetmode ||
> > +           (vif->type != NL80211_IFTYPE_STATION &&
> > +            vif->type != NL80211_IFTYPE_AP))
> > +               vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
> > +
> > +       if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
> > +               param_value = ATH10K_HW_TXRX_ETHERNET;
> > +       else
> > +               param_value = ATH10K_HW_TXRX_NATIVE_WIFI;
> > +
> > +       vdev_param = ar->wmi.vdev_param->tx_encap_type;
> > +       ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
> > +                                       param_value);
> > +
> > +       /* 10.X firmware does not support this VDEV parameter. Do not warn */
> > +       if (ret && ret != -EOPNOTSUPP) {
> > +               ath10k_warn(ar, "failed to set vdev %i TX encapsulation: %d\n",
> > +                           arvif->vdev_id, ret);
> > +               vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
> > +       }
> > +}
> > +
> >  /*
> >   * TODO:
> >   * Figure out how to handle WMI_VDEV_SUBTYPE_P2P_DEVICE,
> > @@ -5634,15 +5686,7 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
> >
> >         arvif->def_wep_key_idx = -1;
> >
> > -       vdev_param = ar->wmi.vdev_param->tx_encap_type;
> > -       ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
> > -                                       ATH10K_HW_TXRX_NATIVE_WIFI);
> > -       /* 10.X firmware does not support this VDEV parameter. Do not warn */
> > -       if (ret && ret != -EOPNOTSUPP) {
> > -               ath10k_warn(ar, "failed to set vdev %i TX encapsulation: %d\n",
> > -                           arvif->vdev_id, ret);
> > -               goto err_vdev_delete;
> > -       }
> > +       ath10k_mac_op_update_vif_offload(hw, vif);
> >
> >         /* Configuring number of spatial stream for monitor interface is causing
> >          * target assert in qca9888 and qca6174.
> > @@ -9327,6 +9371,7 @@ static const struct ieee80211_ops ath10k_ops = {
> >         .config                         = ath10k_config,
> >         .add_interface                  = ath10k_add_interface,
> >         .remove_interface               = ath10k_remove_interface,
> > +       .update_vif_offload             = ath10k_mac_op_update_vif_offload,
> >         .configure_filter               = ath10k_configure_filter,
> >         .bss_info_changed               = ath10k_bss_info_changed,
> >         .set_coverage_class             = ath10k_mac_op_set_coverage_class,
> > @@ -9936,6 +9981,8 @@ int ath10k_mac_register(struct ath10k *ar)
> >         ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
> >         ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
> >         ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
> > +       if (ar->ethernetmode)
> > +               ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
> >
> >         if (!test_bit(ATH10K_FLAG_RAW_MODE, &ar->dev_flags))
> >                 ieee80211_hw_set(ar->hw, SW_CRYPTO_CONTROL);
> > diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
> > index 7c9ea0c073d8..5876381f27cd 100644
> > --- a/drivers/net/wireless/ath/ath10k/txrx.c
> > +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> > @@ -51,6 +51,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
> >         struct ath10k_txq *artxq;
> >         struct sk_buff *msdu;
> >         u8 flags;
> > +       struct ieee80211_vif *vif;
> >
> >         ath10k_dbg(ar, ATH10K_DBG_HTT,
> >                    "htt tx completion msdu_id %u status %d\n",
> > @@ -80,6 +81,8 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
> >         }
> >
> >         flags = skb_cb->flags;
> > +       vif = skb_cb->vif;
> > +
> >         ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
> >         ath10k_htt_tx_dec_pending(htt);
> >         if (htt->num_pending_tx == 0)
> > @@ -130,7 +133,10 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
> >                 info->status.is_valid_ack_signal = true;
> >         }
> >
> > -       ieee80211_tx_status(htt->ar->hw, msdu);
> > +       if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
> > +               ieee80211_tx_status_8023(htt->ar->hw, vif, msdu);
> > +       else
> > +               ieee80211_tx_status(htt->ar->hw, msdu);
> >         /* we do not own the msdu anymore */
> >
> >         return 0;
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > ath10k mailing list
> > ath10k@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/ath10k
