Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2E149AB1
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 14:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgAZNNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 08:13:39 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:37829 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgAZNNi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 08:13:38 -0500
Received: by mail-vs1-f45.google.com with SMTP id x18so4050336vsq.4
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2020 05:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpre6bFkxJYq264Ew4FQ3RMoiNJYB22K4VqY32TBCpA=;
        b=CD9VBFoHmzkQbEWoCtNbnIK+ZUdCJtn78Ff3UvewjPM32luM8xk/8KP9X/8l1IuF3B
         XuRaUIHk1mZedV45ILoB8y/fHWy5z5oiEuylO0+sBpOwiTCt2gWSLaEXkaZOtRZMpdxB
         kKab5dNqsnKQgDVvFuL3ybujuoJBGSxqg2SYDIyTitLHhcYXs8557ruP7eqnSxVO4Xry
         Fy2JJLg6nmj82lZ5JAslZOQaD6OLxsxy6uG8zRTn9EyUL6OzPs2ksZw/a+J9nFNpj/xG
         CCf3do5WXl4zV3aPNUo7OWdFktnXXHnM7U5AIj4vFShEApws0VgYtaqzRs1Eq979A40Y
         LPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpre6bFkxJYq264Ew4FQ3RMoiNJYB22K4VqY32TBCpA=;
        b=qlQPWo0JSVastCd897WH37HAoekvwmVIzPJWt3GI5RVAEheSnkhXpPjO2VXBdWyACB
         5TdHsYaHcSRWIUyyd10DBa5wg/KJBmqDZ3NCkeOWUPrEV0fp/kvvhHr+qPkxhtGbKIP9
         AtIROoH628G9hpvByDlhN0OtjeOEdriSclKeYE+VHIEKLHwn9cTJNIEPyc68N4fvNt2e
         SHpVZlBJTKHbjtzK5501ldWDLMuzWMgRCwe8cfrNuRyLVPK6Ri2c+5LSKos7Jtfg1AoI
         oLIdGbKtPfPRNV0UAIoz/cPIXsRFVde7pqx7YcqMLwX7plucFBjDLIGI36l9TF5DTXSx
         LTqg==
X-Gm-Message-State: APjAAAWx+bEBDVr7sRwfZ0mQ9yT48zQmnqlTZ7zWrGhlNOY4urgKiqcf
        rEhJcwougthVPrtLBKB7pq2ZhOUBn7Y8UbmZK9E=
X-Google-Smtp-Source: APXvYqzG6xjka8KVSy9tKEw533YPLbzSupa8iQ4fwmkAoLYVP7r6wMRrLmPnQwvaIAdBDGTpBtOZIUt6E9tP7hpYuwM=
X-Received: by 2002:a67:f315:: with SMTP id p21mr7368695vsf.39.1580044417237;
 Sun, 26 Jan 2020 05:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20200122142930.19239-1-john@phrozen.org>
In-Reply-To: <20200122142930.19239-1-john@phrozen.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Sun, 26 Jan 2020 05:13:24 -0800
Message-ID: <CAMrEMU-0qBk+5eKTi2P82NdkPx0F1pOyMidapAAkksY8-zZnVg@mail.gmail.com>
Subject: Re: [RESEND] ath11k: add tx hw 802.11 encapusaltion offloading support
To:     John Crispin <john@phrozen.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>  ath11k_dp_tx_get_encap_type(struct ath11k_vif *arvif, struct sk_buff *skb)
>  {
> -       /* TODO: Determine encap type based on vif_type and configuration */
> +       struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
> +
> +       if (tx_info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
> +               return HAL_TCL_ENCAP_TYPE_ETHERNET;
> +
>         return HAL_TCL_ENCAP_TYPE_NATIVE_WIFI;
>  }

Would reserving some bits/separating encapsulation so a mask/shift
could allow for enum/switch? I second Karthikeyan's idea of the
generic module_param--- If you look at the ath10k codebase they have
separate flags for sw/hwcrypto and ethernet and it resulted in needing
to check for the mutually exclusive options

> @@ -39,8 +43,11 @@ static void ath11k_dp_tx_encap_nwifi(struct sk_buff *skb)
> +       if (cb->flags & ATH11K_SKB_HW_80211_ENCAP)
> +               return skb->priority % IEEE80211_QOS_CTL_TID_MASK;

Maybe use & to be consistent with other _MASKs instead of %?

>         pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);

Not part of the patch but would "min" be better here?

>         case HAL_TCL_ENCAP_TYPE_802_3:\

+default? (Take care of that todo:?)


> +static unsigned int ath11k_ethernet_mode;
> +module_param_named(ethernet_mode, ath11k_ethernet_mode, uint, 0644);
> +MODULE_PARM_DESC(ethernet_mode, "Use ethernet frame datapath");

See above

>         if (buf_id < 0)
>                 return -ENOSPC;

Again not part of your patch but, why is this not just unsigned then,
or are negatives used to invalidate? Haven't looked through the code
enough yet

> +       info = IEEE80211_SKB_CB(skb);

Could this be done at at initialization?


> +       if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)) {
> +               if ((ieee80211_is_action(hdr->frame_control) ||
> +                    ieee80211_is_deauth(hdr->frame_control) ||
> +                    ieee80211_is_disassoc(hdr->frame_control)) &&
> +                    ieee80211_has_protected(hdr->frame_control)) {
> +                       skb_put(skb, IEEE80211_CCMP_MIC_LEN);

Maybe just skip/goto past this if offloading? Totally a style thing,
but if more encapsulation/offloading is added later it might pave the
way for cleaner code?

Totally trivial/not a real issue, but I had the thought that if it
were written in the reverse order, protected && (action || deauth ||
dissassoc), it could shortcut quicker potentially?

> @@ -3745,6 +3753,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
>                              struct ieee80211_tx_control *control,
>                              struct sk_buff *skb)
>  {
> +       struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB((struct sk_buff *)skb);

I don't think this cast is needed.

> @@ -4028,6 +4040,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
> +       int hw_encap = 0;

Another spot where the possibility of having an enum for the
encapsulation/flags could be handy?


-       if (ieee80211_is_mgmt(hdr->frame_control)) {
+       skb_cb->flags = 0;
+       if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+               skb_cb->flags = ATH11K_SKB_HW_80211_ENCAP;
+       } else if (ieee80211_is_mgmt(hdr->frame_control)) {

Should this maybe be future proofed, something like skb_cb->flags |=
ATH11K_SKB_HW_80211_ENCAP or perhaps even masking the encapsulation
bits as to not reset all the flags ( =0)



> +       switch (vif->type) {
> +       case NL80211_IFTYPE_STATION:
> +       case NL80211_IFTYPE_AP_VLAN:
> +       case NL80211_IFTYPE_AP:
> +               hw_encap = 1;
> +               break;
> +       default:
> +               break;

No mesh?



> +static unsigned int ath11k_ethernet_mode;
> +module_param_named(ethernet_mode, ath11k_ethernet_mode, uint, 0644);
> +MODULE_PARM_DESC(ethernet_mode, "Use ethernet frame datapath");

> +
>  static const struct ieee80211_channel ath11k_2ghz_channels[] = {
>         CHAN2G(1, 2412, 0),
>         CHAN2G(2, 2417, 0),
> @@ -3633,6 +3637,7 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
>  {
>         struct ath11k_base *ab = ar->ab;
>         struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> +       struct ieee80211_tx_info *info;
>         dma_addr_t paddr;
>         int buf_id;
>         int ret;
> @@ -3644,11 +3649,14 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
>         if (buf_id < 0)
>                 return -ENOSPC;
>
> -       if ((ieee80211_is_action(hdr->frame_control) ||
> -            ieee80211_is_deauth(hdr->frame_control) ||
> -            ieee80211_is_disassoc(hdr->frame_control)) &&
> -            ieee80211_has_protected(hdr->frame_control)) {
> -               skb_put(skb, IEEE80211_CCMP_MIC_LEN);
> +       info = IEEE80211_SKB_CB(skb);
> +       if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)) {
> +               if ((ieee80211_is_action(hdr->frame_control) ||
> +                    ieee80211_is_deauth(hdr->frame_control) ||
> +                    ieee80211_is_disassoc(hdr->frame_control)) &&
> +                    ieee80211_has_protected(hdr->frame_control)) {
> +                       skb_put(skb, IEEE80211_CCMP_MIC_LEN);
> +               }
>         }
>
>         paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
> @@ -3745,6 +3753,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
>                              struct ieee80211_tx_control *control,
>                              struct sk_buff *skb)
>  {
> +       struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB((struct sk_buff *)skb);
>         struct ath11k *ar = hw->priv;
>         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
>         struct ieee80211_vif *vif = info->control.vif;
> @@ -3753,7 +3762,10 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
>         bool is_prb_rsp;
>         int ret;
>
> -       if (ieee80211_is_mgmt(hdr->frame_control)) {
> +       skb_cb->flags = 0;
> +       if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
> +               skb_cb->flags = ATH11K_SKB_HW_80211_ENCAP;
> +       } else if (ieee80211_is_mgmt(hdr->frame_control)) {
>                 is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
>                 ret = ath11k_mac_mgmt_tx(ar, skb, is_prb_rsp);
>                 if (ret) {
> @@ -4028,6 +4040,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
>         struct vdev_create_params vdev_param = {0};
>         struct peer_create_params peer_param;
>         u32 param_id, param_value;
> +       int hw_encap = 0;
>         u16 nss;
>         int i;
>         int ret;
> @@ -4119,7 +4132,21 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
>         spin_unlock_bh(&ar->data_lock);
>
>         param_id = WMI_VDEV_PARAM_TX_ENCAP_TYPE;
> -       param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
> +       switch (vif->type) {
> +       case NL80211_IFTYPE_STATION:
> +       case NL80211_IFTYPE_AP_VLAN:
> +       case NL80211_IFTYPE_AP:
> +               hw_encap = 1;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (ieee80211_set_hw_80211_encap(vif, ath11k_ethernet_mode && hw_encap))
> +               param_value = ATH11K_HW_TXRX_ETHERNET;
> +       else
> +               param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
> +
>         ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
>                                             param_id, param_value);
>         if (ret) {
> --
> 2.20.1
>
