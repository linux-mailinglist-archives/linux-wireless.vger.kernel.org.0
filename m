Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3DDA2BC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 02:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392867AbfJQAd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 20:33:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44583 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfJQAd5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 20:33:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id q12so363868lfc.11
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lhdmTahyTr9mpYPZPTU+eWGDK015qxZkpq+B1fY3Eaw=;
        b=jSYwoHuEyH/rMkNYINxtCdbgVMdlB0EmqtVi+LiOh9e5Sf3QhI8YiXmmK9vTF1T9l+
         7y76nsbFDMKjmqSVzgf1zCodJ6ewKaysPxSTxE6gzKMLOngWVxp3p9snwAhOOUGhE+CU
         SS5j7+KNOugQfRtsLoXFHmoChVh8olRDedIrm8IDKqGqJOifJ0NSfKFI3pAQC/nrRgyT
         0LA4T8ThKQDx1FIgxQefMfRwmzg80sJUzdPQeLVIYJmj1QbaFLDrmQ3ievbj/kU3mfAd
         IUZNRk6uiFE5z2xHtLslKWzo0MQ546U5VxOUKEHimAMkrXS4eaVofpFc9Up5D8+ehev2
         SGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lhdmTahyTr9mpYPZPTU+eWGDK015qxZkpq+B1fY3Eaw=;
        b=dDx0ph8mNjONTAk5od43l3lqTVLSzvWlBSmxsLmAv+zidc5dihyqHspHCnTFQ2HBW2
         Gu/h7dAka/BRqaoeW32djcwRrfMlOZltMbEMvvzN2ErIBqjHuoRtlnIuUpjxF5IpboK9
         0zdSvJODhyz1/nZ4y+1cepJYBOFlPdkAmkdKHDVAtEpxVKWX86BDBzo7wUaZP5xuADxq
         /rkrKVz+3goxDYJvFRclmc1xkRTjGcmW1naMTau8w3gC6KgzfsgWiQpqxacr7OWIpTlG
         c7MKg8LKih0I5W5pobqoVudza7GsqU4/CezhnlktmO5uoS1kNe1iUjyN+kPuMHIQC9my
         Mapg==
X-Gm-Message-State: APjAAAXjtEBifZ0g3CVa6pAMw/q1vplNZhWNZdvyfzZyGTRgq7p9aUID
        wxIsOgDH5wfKdBi84p1ijjzMAPmPuhus2uEIsyykXA==
X-Google-Smtp-Source: APXvYqxFJA6YhjLa9HJl0r0MT7p4BJuEERXHwbvwB4KvMwKw02WAPvCLR2U07Tnsg9ODjX9Dc7eRqdsP2xayt6SeY6o=
X-Received: by 2002:a19:7b08:: with SMTP id w8mr288466lfc.95.1571272434435;
 Wed, 16 Oct 2019 17:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115994190.2500430.14955682016008497593.stgit@toke.dk>
In-Reply-To: <157115994190.2500430.14955682016008497593.stgit@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 16 Oct 2019 17:33:43 -0700
Message-ID: <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
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

Hi Toke,

Thanks for getting this done! I will give it a try in the next few
days.  A few comments:

> The estimated airtime for each skb is stored in the tx_info, so we can
> subtract the same amount from the running total when the skb is freed or
> recycled.

Looks like ath10k driver zero out the info->status before calling
ieee80211_tx_status(...):
int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
                         const struct htt_tx_done *tx_done)
{
 ...
        info =3D IEEE80211_SKB_CB(msdu);
        memset(&info->status, 0, sizeof(info->status));
...
        ieee80211_tx_status(htt->ar->hw, msdu);
}

We need either restore the info->status.tx_time_est or calling
ieee80211_sta_update_pending_airtime() in ath10k before tx_time_est
get erased.

> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, t=
xq->sta,
> +                                                            skb->len + 3=
8);

I think it is better to put the "+  38" that takes care of the header
overhead inside ieee80211_calc_expected_tx_airtime().

Kan


On Tue, Oct 15, 2019 at 10:19 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
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
>  net/mac80211/tx.c     |   16 ++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index ab8ba5835ca0..ce990a1e9043 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -676,6 +676,33 @@ static void ieee80211_report_used_skb(struct ieee802=
11_local *local,
>         if (dropped)
>                 acked =3D false;
>
> +       if (info->status.tx_time_est) {
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
> +                                                    info->status.tx_time=
_est,
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
> +               if (info->status.tx_time_est) {
> +                       /* Do this here to avoid the expensive lookup of =
the sta
> +                        * in ieee80211_report_used_skb().
> +                        */
> +                       ieee80211_sta_update_pending_airtime(local, sta,
> +                                                            ieee80211_ac=
_from_tid(tid),
> +                                                            info->status=
.tx_time_est,
> +                                                            true);
> +                       info->status.tx_time_est =3D 0;
> +               }
> +
>                 if (!acked && ieee80211_is_back_req(fc)) {
>                         u16 control;
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 405f622b3fe0..b6b47171b340 100644
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
> @@ -3652,6 +3657,17 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80=
211_hw *hw,
>         }
>
>         IEEE80211_SKB_CB(skb)->control.vif =3D vif;
> +
> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, t=
xq->sta,
> +                                                            skb->len + 3=
8);
> +               if (airtime) {
> +                       info->control.tx_time_est =3D airtime;
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
