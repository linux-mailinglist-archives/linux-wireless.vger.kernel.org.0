Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200C5DD12B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440418AbfJRV0J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 17:26:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42545 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfJRV0I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 17:26:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id z12so5720031lfj.9
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Up8Gwyf2iZnRutPZhnyYKV6yPtTDybg21nimSnweeU=;
        b=DO5sbPJ3KT5w7eZ8ZFGjS6kfqG5LY9WT8IS4j5JitX0ihljkLwZSmPqegQujlCweo/
         fGd3MSFRvrFRkKfGp2Eb8KKsNVHFwYzUGAsfkix5a+ZEYaEaexTf3EjGK3dPYGcp2jlU
         YSfTJDBLFL5HlAWxbBg/0cMID3ogTM2lqstSBz17Y1WKzSV5594cUo4LaxC9MVddcTzo
         0GGZTFH0FN974RQO1CABlhl39JmjXWvabQJWRWQNf2dDxxJRUbK2SD8ELa8YWuQ23Et/
         kGx4uUm15nDgjkz4otNP3yUM0VVNMpDlMm22ijGADdFvR7nLajYNUUrWLAtX27CB6s3u
         eTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Up8Gwyf2iZnRutPZhnyYKV6yPtTDybg21nimSnweeU=;
        b=HiaqJUh5fT3te48nnVDWuADCmENPJF1BbZ6KMbwL/QZoH1kcO3LprV5JkyMqeFHNsm
         epn0vayILRVD3mT28bxuXX3OxMlJPKSY/tCVL2mENnxABFgSt7Cv/ce9HSYa8ozBKmS0
         bqdH/lerPSBZSWOTP7t7oV4Xztie2fYgcG8TX0oG/NwxMHHK9CB2wO8cr+N1rHC8JCDq
         W1a1lxkw72tc5M/5FoDjtmNI5uJ2mN8o0RLlR0hN2RTf51iAcwTXdm7z1TE2WHQ9vm3S
         VGSDRG/PZ9eYUzhtyA4jgHtfUtelxaNqJQG9SWm5XI3nP6dUckiNZGVCbooc0rFXPwO7
         iGmQ==
X-Gm-Message-State: APjAAAWXJ5gqctLlsUEbdBs43Jg3tzhJ6JjkRVgMvcS2oMh0yULjQPOr
        GlgVrcHwztU1SnIp0eOF+lqvPunUTEw85eUeRfz5sg==
X-Google-Smtp-Source: APXvYqyTnANwrAfiEJAtZi6lCBu2WZC15AbYHqhBi0/lAQnLeSMRlARVOHYFbr9G2RecV9d00MH3gdMP9+vXbh1O0ik=
X-Received: by 2002:ac2:5610:: with SMTP id v16mr7187855lfd.93.1571433965266;
 Fri, 18 Oct 2019 14:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <157140962094.2866668.3383184317264069493.stgit@toke.dk> <157140962534.2866668.1182822483250825739.stgit@toke.dk>
In-Reply-To: <157140962534.2866668.1182822483250825739.stgit@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Fri, 18 Oct 2019 14:25:53 -0700
Message-ID: <CA+iem5sCTsPe4PW=0j20NoAratvdCvB0ss7zO3wMWLcirXsLgg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, t=
xq->sta,
> +                                                            skb->len);
> +               if (airtime) {
> +                       /* We only have 10 bits in tx_time_est, so store =
airtime
> +                        * in increments of 4 us and clamp that to 2**10.
> +                        */
> +                       info->tx_time_est =3D min_t(u32, airtime >> 2, 1 =
<< 10);
> +                       ieee80211_sta_update_pending_airtime(local, tx.st=
a, ac,
> +                                                            airtime, fal=
se);
> +               }
> +       }
> +

It should be:
                         ieee80211_sta_update_pending_airtime(local, tx.sta=
, ac,

info->tx_time_est << 2, false);

The airtime rounded to 4us (info->tx_time_est << 2), instead of the
original airtime should be used when registering the pending airtime,
to keep it consistent with airtime subtracted when the skb is freed.


On Fri, Oct 18, 2019 at 7:40 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> The previous commit added the ability to throttle stations when they queu=
e
> too much airtime in the hardware. This commit enables the functionality b=
y
> calculating the expected airtime usage of each packet that is dequeued fr=
om
> the TXQs in mac80211, and accounting that as pending airtime.
>
> The estimated airtime for each skb is stored in the tx_info, so we can
> subtract the same amount from the running total when the skb is freed or
> recycled. The throttling mechanism relies on this accounting to be
> accurate (i.e., that we are not freeing skbs without subtracting any
> airtime they were accounted for), so we put the subtraction into
> ieee80211_report_used_skb(). As an optimisation, we also subtract the
> airtime on regular TX completion, zeroing out the value stored in the
> packet afterwards, to avoid having to do an expensive lookup of the
> station from the packet data on every packet.
>
> This patch does *not* include any mechanism to wake a throttled TXQ again=
,
> on the assumption that this will happen anyway as a side effect of whatev=
er
> freed the skb (most commonly a TX completion).
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/mac80211/status.c |   38 ++++++++++++++++++++++++++++++++++++++
>  net/mac80211/tx.c     |   19 +++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index ab8ba5835ca0..905b4afd457d 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -676,6 +676,33 @@ static void ieee80211_report_used_skb(struct ieee802=
11_local *local,
>         if (dropped)
>                 acked =3D false;
>
> +       if (info->tx_time_est) {
> +               struct ieee80211_sub_if_data *sdata;
> +               struct sta_info *sta =3D NULL;
> +               u8 *qc, ac;
> +               int tid;
> +
> +               rcu_read_lock();
> +
> +               sdata =3D ieee80211_sdata_from_skb(local, skb);
> +               if (sdata)
> +                       sta =3D sta_info_get_bss(sdata, skb_mac_header(sk=
b));
> +
> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
> +                       qc =3D ieee80211_get_qos_ctl(hdr);
> +                       tid =3D qc[0] & 0xf;
> +                       ac =3D ieee80211_ac_from_tid(tid);
> +               } else {
> +                       ac =3D IEEE80211_AC_BE;
> +               }
> +
> +               ieee80211_sta_update_pending_airtime(local, sta, ac,
> +                                                    info->tx_time_est <<=
 2,
> +                                                    true);
> +               rcu_read_unlock();
> +
> +       }
> +
>         if (info->flags & IEEE80211_TX_INTFL_MLME_CONN_TX) {
>                 struct ieee80211_sub_if_data *sdata;
>
> @@ -930,6 +957,17 @@ static void __ieee80211_tx_status(struct ieee80211_h=
w *hw,
>                         tid =3D qc[0] & 0xf;
>                 }
>
> +               if (info->tx_time_est) {
> +                       /* Do this here to avoid the expensive lookup of =
the sta
> +                        * in ieee80211_report_used_skb().
> +                        */
> +                       ieee80211_sta_update_pending_airtime(local, sta,
> +                                                            ieee80211_ac=
_from_tid(tid),
> +                                                            info->tx_tim=
e_est << 2,
> +                                                            true);
> +                       info->tx_time_est =3D 0;
> +               }
> +
>                 if (!acked && ieee80211_is_back_req(fc)) {
>                         u16 control;
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 12653d873b8c..bd8284f04361 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3539,9 +3539,14 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80=
211_hw *hw,
>         struct ieee80211_tx_data tx;
>         ieee80211_tx_result r;
>         struct ieee80211_vif *vif =3D txq->vif;
> +       u8 ac =3D txq->ac;
> +       u32 airtime;
>
>         WARN_ON_ONCE(softirq_count() =3D=3D 0);
>
> +       if (!ieee80211_txq_airtime_check(hw, txq))
> +               return NULL;
> +
>  begin:
>         spin_lock_bh(&fq->lock);
>
> @@ -3652,6 +3657,20 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80=
211_hw *hw,
>         }
>
>         IEEE80211_SKB_CB(skb)->control.vif =3D vif;
> +
> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, t=
xq->sta,
> +                                                            skb->len);
> +               if (airtime) {
> +                       /* We only have 10 bits in tx_time_est, so store =
airtime
> +                        * in increments of 4 us and clamp that to 2**10.
> +                        */
> +                       info->tx_time_est =3D min_t(u32, airtime >> 2, 1 =
<< 10);
> +                       ieee80211_sta_update_pending_airtime(local, tx.st=
a, ac,
> +                                                            airtime, fal=
se);
> +               }
> +       }
> +
>         return skb;
>
>  out:
>
