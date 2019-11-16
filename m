Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747F9FEA4C
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 03:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfKPCvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 21:51:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37268 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKPCvi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 21:51:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id d5so12690798ljl.4
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 18:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sdKzXv63ut5ycRGBDasjRVtrIZ7lx7BKgWbHQ31JIUs=;
        b=Y85KjM8pLwk8II2O1yNOR9uNu2jlGzWakcj38h+Qzph8yKwYwXWEDZbf8xKhC6gdnm
         11Gw1cX9jeV2/BtDa22RaGxjWZ0pliCeFfQuZKH9Hi8FMvBUJa99lRKpFHiL06DgyGKw
         HXQzQo0U4BprYVtPjNJvyxa9hRRKamgQ84lixPAAOeqhDebCuXmzg/GHgS9AwC03uwXt
         40OpTCGn6WwSoPCLuw0qmtH4drUOe+qMkaZHlKZJi60NZewYvOKElfQk6qSsv0PJJ40q
         4wNo+ubMFnHKX8DYixRgW2w2pxelzvvJT33m4CjM6rctuyQCvZCGBKuzwtKMKpTlQBH1
         fgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sdKzXv63ut5ycRGBDasjRVtrIZ7lx7BKgWbHQ31JIUs=;
        b=VSFpNPSdyCVwVD8siGTuJqPpoIXQfF9ZONMHBN/WsnfuIcl6T/AKegpz/T/1WdlhIv
         D9qBq3QX9qcmI0GpZbfQyvdk7Np9wg2OhZGQzgYbzT0wK/nncdNGpn5NbEay+0awvqar
         v1e/PN8gz7JJTDJEZiesEdy3ZsMwx22WSa45C1MvtbKCrIPrBAh/s2YU7Mv69gx1/J03
         wVIKrC3953hPJXLGgymZMXtm9Gd4KZKNTz6j/cEh/xTagycEoiMwv8X72+aXZ6VEdfMm
         aAyO8LTn4aHZ0hiZ4VWRLl6zeIUTr8cVElaIaUT0D7Mr+FRkKK4+YXdcEhIapLudEne7
         8FtA==
X-Gm-Message-State: APjAAAUxL4yCr0vr7RYLvDEzlr8jghkGVIfwz2G2724DS5QDpTxISNrU
        gstaLY/6eUvnoJa06lo5nVyty5glP14rvmWF2ikK3g==
X-Google-Smtp-Source: APXvYqwjluY++F6OSaQv00r/ChhGimpTe8y6dBoea0XPVWP0l6+6ziAqfoXDD9c5KgYidFnDRA4I0wr5o6ncAKvaDFA=
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr10220733ljp.119.1573872694638;
 Fri, 15 Nov 2019 18:51:34 -0800 (PST)
MIME-Version: 1.0
References: <157382403672.580235.12525941420808058808.stgit@toke.dk> <157382404118.580235.14216392299709793599.stgit@toke.dk>
In-Reply-To: <157382404118.580235.14216392299709793599.stgit@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Fri, 15 Nov 2019 18:51:23 -0800
Message-ID: <CA+iem5tF+TN-osfGxu=EU5Xt1Uq+PcKgBVaoAmZY3a3JzS5JzQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
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

> +static inline u16
> +ieee80211_info_set_tx_time_est(struct ieee80211_tx_info *info, u16 tx_ti=
me_est)
> +{
> +       /* We only have 10 bits in tx_time_est, so store airtime
> +        * in increments of 4us and clamp the maximum to 2**12-1
> +        */
> +       info->tx_time_est =3D min_t(u16, tx_time_est, 4095) >> 2;
> +       return info->tx_time_est;
> +}
> +
> +static inline u16
> +ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
> +{
> +       return info->tx_time_est << 2;
> +}
> +

set_tx_time_est() returns airtime in different units (4us) than
get_tx_time_est(), this will cause the pending_airtime out of whack.

Given the fact that AQL is only tested in very limited platforms,
should we set the default to disabled by removing this change in the
next update?

-       local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
+
+       local->airtime_flags =3D AIRTIME_USE_TX |
+                              AIRTIME_USE_RX |
+                              AIRTIME_USE_AQL;
+       local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
+       atomic_set(&local->aql_total_pending_airtime, 0);


On Fri, Nov 15, 2019 at 5:20 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
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
> packet afterwards, to avoid having to do an expensive lookup of the stati=
on
> from the packet data on every packet.
>
> This patch does *not* include any mechanism to wake a throttled TXQ again=
,
> on the assumption that this will happen anyway as a side effect of whatev=
er
> freed the skb (most commonly a TX completion).
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/net/mac80211.h |   16 ++++++++++++++++
>  net/mac80211/status.c  |   26 ++++++++++++++++++++++++++
>  net/mac80211/tx.c      |   18 ++++++++++++++++++
>  3 files changed, 60 insertions(+)
>
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index ba3f33cc41ea..dcb4a1f19829 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1060,6 +1060,22 @@ struct ieee80211_tx_info {
>         };
>  };
>
> +static inline u16
> +ieee80211_info_set_tx_time_est(struct ieee80211_tx_info *info, u16 tx_ti=
me_est)
> +{
> +       /* We only have 10 bits in tx_time_est, so store airtime
> +        * in increments of 4us and clamp the maximum to 2**12-1
> +        */
> +       info->tx_time_est =3D min_t(u16, tx_time_est, 4095) >> 2;
> +       return info->tx_time_est;
> +}
> +
> +static inline u16
> +ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
> +{
> +       return info->tx_time_est << 2;
> +}
> +
>  /**
>   * struct ieee80211_tx_status - extended tx status info for rate control
>   *
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index 0e51def35b8a..39da82b35be9 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -670,12 +670,26 @@ static void ieee80211_report_used_skb(struct ieee80=
211_local *local,
>                                       struct sk_buff *skb, bool dropped)
>  {
>         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +       u16 tx_time_est =3D ieee80211_info_get_tx_time_est(info);
>         struct ieee80211_hdr *hdr =3D (void *)skb->data;
>         bool acked =3D info->flags & IEEE80211_TX_STAT_ACK;
>
>         if (dropped)
>                 acked =3D false;
>
> +       if (tx_time_est) {
> +               struct sta_info *sta;
> +
> +               rcu_read_lock();
> +
> +               sta =3D sta_info_get_by_addrs(local, hdr->addr1, hdr->add=
r2);
> +               ieee80211_sta_update_pending_airtime(local, sta,
> +                                                    skb_get_queue_mappin=
g(skb),
> +                                                    tx_time_est,
> +                                                    true);
> +               rcu_read_unlock();
> +       }
> +
>         if (info->flags & IEEE80211_TX_INTFL_MLME_CONN_TX) {
>                 struct ieee80211_sub_if_data *sdata;
>
> @@ -877,6 +891,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw=
 *hw,
>         struct ieee80211_bar *bar;
>         int shift =3D 0;
>         int tid =3D IEEE80211_NUM_TIDS;
> +       u16 tx_time_est;
>
>         rates_idx =3D ieee80211_tx_get_rates(hw, info, &retry_count);
>
> @@ -986,6 +1001,17 @@ static void __ieee80211_tx_status(struct ieee80211_=
hw *hw,
>                         ieee80211_sta_register_airtime(&sta->sta, tid,
>                                                        info->status.tx_ti=
me, 0);
>
> +               if ((tx_time_est =3D ieee80211_info_get_tx_time_est(info)=
) > 0) {
> +                       /* Do this here to avoid the expensive lookup of =
the sta
> +                        * in ieee80211_report_used_skb().
> +                        */
> +                       ieee80211_sta_update_pending_airtime(local, sta,
> +                                                            skb_get_queu=
e_mapping(skb),
> +                                                            tx_time_est,
> +                                                            true);
> +                       ieee80211_info_set_tx_time_est(info, 0);
> +               }
> +
>                 if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)=
) {
>                         if (info->flags & IEEE80211_TX_STAT_ACK) {
>                                 if (sta->status_stats.lost_packets)
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index aafc67b562eb..2fb6571453e7 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3551,6 +3551,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee802=
11_hw *hw,
>
>         WARN_ON_ONCE(softirq_count() =3D=3D 0);
>
> +       if (!ieee80211_txq_airtime_check(hw, txq))
> +               return NULL;
> +
>  begin:
>         spin_lock_bh(&fq->lock);
>
> @@ -3661,6 +3664,21 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80=
211_hw *hw,
>         }
>
>         IEEE80211_SKB_CB(skb)->control.vif =3D vif;
> +
> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
> +               u32 airtime;
> +
> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, t=
xq->sta,
> +                                                            skb->len);
> +               if (airtime) {
> +                       airtime =3D ieee80211_info_set_tx_time_est(info, =
airtime);
> +                       ieee80211_sta_update_pending_airtime(local, tx.st=
a,
> +                                                            txq->ac,
> +                                                            airtime,
> +                                                            false);
> +               }
> +       }
> +
>         return skb;
>
>  out:
>
