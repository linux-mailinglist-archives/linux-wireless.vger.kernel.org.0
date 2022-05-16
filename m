Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4E5292A7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348613AbiEPVOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349469AbiEPVL0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 17:11:26 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A34AE6F
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 13:57:46 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id bc42so8115481vkb.12
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rneFECe0WdCdTO+pXzR0vTp36w5ITL2tNrXp2IqQl04=;
        b=QGpM2vLqJadQax9o7erYEBrVDEef4JzoBn/aIXh54JpYzmtrDW/cI0OHn3tLirbv2Y
         hU1XVsk+b2JaUW2TTqXO8JEmKyTxcWdSD0s7UKtjDRUE1shE1UYzVMtF2JOgdpZ2uppx
         vGSAMM8O9NbayBBJ/cNvrIkC8eyEGI6hC0/dk/3EtqqeTcfAS+9mijiuOr3JE9UuFfwN
         6DyuaARR5rbIpMiVkz7goJcWTm6cqSZPXQKxej4oUPuMIvavzDPHov1W3zAO0KMvNhS6
         7YW/Cx2pZ6BzXi/MKmOhOQmiru+WKPUOwQhmefC5TqBGMV6ktxPA09fcfvBDHvkYdoJk
         XTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rneFECe0WdCdTO+pXzR0vTp36w5ITL2tNrXp2IqQl04=;
        b=Ri44WZuKT0e4GJh33QmEZTW+ooS15rokWLmVTjgreBHtswx0b4G247SpDl4LYZmYox
         qX3/OYltenntFLIBwzABFroKM4L36oB22u/yUS8XEsjq+m7URCFzsiDNrHBnfNAULzsy
         iSR99A4sEYCl5fGICf9Hu90s3frUXwDnGWo0ySUreF53k+dfuFDy2VSzWDE8pxFmXTMd
         TmCLIXjs1E8K4DLXjAVvk4RYSYJfoNAK1EwYj9h/2Nz/IgLQyIkzBVMcP8PlDwHzN58e
         +NmwNii1Jn1i4xmRmnxZUH7s/J2SCU4ZAZ7kuxIU/+hR2m/q0wzKFHwagUGKocjs97Qd
         biBw==
X-Gm-Message-State: AOAM530BAKYZBEhGU1cRkacK1ghhaagkmyrdsW0KFh+TQnLTB8YrKNgW
        3VRMZh9xaNmTRx3Xub74Z7Qv2KeZsnzP9D6+fko=
X-Google-Smtp-Source: ABdhPJymoMzayaZSmuQTg2xaF4WJu7vYrD74BO8PKS+IzydafbThZjJnGHrG98eGzYSVkdAxThqsfEuNoocfhsSPfz8=
X-Received: by 2002:a05:6122:890:b0:352:b096:d44b with SMTP id
 16-20020a056122089000b00352b096d44bmr7086174vkf.41.1652734665510; Mon, 16 May
 2022 13:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com> <20220516032519.29831-2-ryazanov.s.a@gmail.com>
In-Reply-To: <20220516032519.29831-2-ryazanov.s.a@gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Mon, 16 May 2022 23:57:34 +0300
Message-ID: <CAHNKnsS2_vVPZT-PSjNDzfQmyXEaOJNO8MHqVfntN=GSG3P_Ng@mail.gmail.com>
Subject: Re: [PATCH 1/4] ath10k: improve tx status reporting
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?B?T2xkxZlpY2ggSmVkbGnEjWth?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 16, 2022 at 6:25 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wr=
ote:
> We use ieee80211_tx_status() to report each completed tx frame.
> Internally, this function calls sta_info_get_by_addrs(), what has a
> couple of drawbacks:
> 1. additional station lookup causes a performance degradation;
> 2. mac80211 can not properly account Ethernet encapsulated frames due
>    to the inability to properly determine the destination (station) MAC
>    address since ieee80211_tx_status() assumes the frame has a 802.11
>    header.
>
> The latter is especially destructive if we want to use hardware frames
> encapsulation.
>
> To fix both of these issues, replace ieee80211_tx_status() with
> ieee80211_tx_status_ext() call and feed it station pointer from the tx
> queue associated with the transmitted frame.
>
> Tested-on: QCA9888 hw 2.0 10.4-3.9.0.2-00131
> Tested-on: QCA6174 hw 3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Tested-by: Old=C5=99ich Jedli=C4=8Dka <oldium.pro@gmail.com> # TP-Link Ar=
cher C7 v4 & v5 (QCA9563 + QCA9880)
> Tested-by: Edward Matijevic <motolav@gmail.com> # TP-Link Archer C2600 (I=
PQ8064 + QCA9980 10.4.1.00030-1)
> Tested-by: Edward Matijevic <motolav@gmail.com> # QCA9377 PCI in Sta mode
> Tested-by: Zhijun You <hujy652@gmail.com> # NETGEAR R7800 (QCA9984 10.4-3=
.9.0.2-00159)
> ---
>
> Changes since RFC:
>  * new Tested-on and Tested-by tags
>
>  drivers/net/wireless/ath/ath10k/txrx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireles=
s/ath/ath10k/txrx.c
> index 10123974c3da..72540434c75b 100644
> --- a/drivers/net/wireless/ath/ath10k/txrx.c
> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> @@ -43,6 +43,7 @@ static void ath10k_report_offchan_tx(struct ath10k *ar,=
 struct sk_buff *skb)
>  int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>                          const struct htt_tx_done *tx_done)
>  {
> +       struct ieee80211_tx_status status;
>         struct ath10k *ar =3D htt->ar;
>         struct device *dev =3D ar->dev;
>         struct ieee80211_tx_info *info;
> @@ -128,7 +129,16 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>                 info->status.flags |=3D IEEE80211_TX_STATUS_ACK_SIGNAL_VA=
LID;
>         }
>
> -       ieee80211_tx_status(htt->ar->hw, msdu);
> +       memset(&status, 0, sizeof(status));
> +       status.skb =3D msdu;
> +       status.info =3D info;
> +
> +       rcu_read_lock();
> +       if (txq && txq->sta)
> +               status.sta =3D txq->sta;

Just noticed that since we do not dereference the txq->sta pointer
here, the above code can be simplified to:

if (txq)
        status.sta =3D txq->sta;

Kalle, should I send V2 or can you change this in your tree?

> +       ieee80211_tx_status_ext(htt->ar->hw, &status);
> +       rcu_read_unlock();
> +
>         /* we do not own the msdu anymore */
>
>         return 0;

--=20
Sergey
