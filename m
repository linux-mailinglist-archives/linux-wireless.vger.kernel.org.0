Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39ACDFDAE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 08:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfJVGUt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 02:20:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44502 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVGUt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 02:20:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id q12so12037135lfc.11
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P89YVq7mabnbReOmcuX3tbFnU1/HsoCVT0wVL7HYmgo=;
        b=H6fbYWTqwfAzUI0aZwG24lhF9WJY8zUGD2ZkDaEt8GdDT3wSosRcnrLTg5vgYNVQti
         xB5HLN+lsDlUxmw5ZwXpIOmfknFtbmHgejpU4A97IvOx1PPiW/lJEzROMOyUXQ4/4Mun
         KezH0Ku9mtAfva3+2KDK2dL2Lcnx0FFucpiemXhTcm4HjHVfEBQcMJeG4jl3NoY4x54A
         4jdUHr3gyn03Fa6aTId0V5CPkB1fflYZs1Sv4H1a3HRqv3TSkpvmESxTofmTnhItZiyz
         7lA76VICm3+uVUEPzJ0rG72KEUk2OuTkj71bOvxOMRuBgoVIBlVDHoNZ4C4sS76WncCB
         nYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P89YVq7mabnbReOmcuX3tbFnU1/HsoCVT0wVL7HYmgo=;
        b=UCtxSjK0d3Wkdl9kex/SjF66oQiBKD+3AMdQzzcf4llIVloT85cNbkslBEci8g92v3
         C2mo/KVBEaXIaxbWHu6Cqm9BAY1brBymzpSv0acw2P736rvIEl7UdZ+wpLE3zAmMRVH5
         U2vs6R0kjteYOt4QVnb5aq0ecRAVW8atqUgkF5uCyqz/7WAtv+1rrXNLaZOf8xMjCGRt
         6Fgpnwc3qmXmraF7Xltpv3tquLM6S9QvsCaq5DC51AsEz0v1XAWr9q5ntCj4zaM30yYO
         LBMJkCFbbqnjWhq6m3ObQbla+NfAO2dnv+ucWq/1ESAbcCOShz5ULvHu3R+YFtzyofXL
         IvVw==
X-Gm-Message-State: APjAAAV9fsPRzajKkJ12nrFEGYYGAeqNZBXmESmwSdbyh9FFpSLhxiCD
        mxKaCpDH/q8mVog5UoNq61xr0QCHIJt4FROI/Q1Gzw==
X-Google-Smtp-Source: APXvYqxl8ImxyIIaYe9Nt5SgAG5+hUWTullxdEbjF0/6jry2TDPqWN0jbmS+AN13XvzxT1JqVAOWFjuhHFtVQsZDa3s=
X-Received: by 2002:a19:9144:: with SMTP id y4mr12326104lfj.168.1571725245884;
 Mon, 21 Oct 2019 23:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk> <157148503865.2989444.7118792679603045723.stgit@toke.dk>
In-Reply-To: <157148503865.2989444.7118792679603045723.stgit@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Mon, 21 Oct 2019 23:20:34 -0700
Message-ID: <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
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

> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
> +                       qc =3D ieee80211_get_qos_ctl(hdr);
> +                       tid =3D qc[0] & 0xf;
> +                       ac =3D ieee80211_ac_from_tid(tid);
> +               } else {
> +                       ac =3D IEEE80211_AC_BE;
> +               }

The tid/ac is incorrect either here or in __ieee80211_tx_status() when
tested with ath10k. The ac is set to AC_BE with test done using BK
class traffic,  hence the pending airtime get updated for the wrong
txq.

The rest of the patch seems to work as expected, after I did a quick
hack to release the pending airtime from ath10k_txrx_tx_unref()
instead, where the ac/tid can be directly retrieved from struck struct
ieee80211_tx.


On Sat, Oct 19, 2019 at 4:37 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
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
>  net/mac80211/tx.c     |   21 +++++++++++++++++++++
>  2 files changed, 59 insertions(+)
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
> index 12653d873b8c..b8ff56d1d661 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3542,6 +3542,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee802=
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
> @@ -3652,6 +3655,24 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80=
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
> +                       /* We only have 10 bits in tx_time_est, so store =
airtime
> +                        * in increments of 4 us and clamp the maximum to=
 2**12-1
> +                        */
> +                       airtime =3D min_t(u32, airtime, 4095) & ~3U;
> +                       info->tx_time_est =3D airtime >> 2;
> +                       ieee80211_sta_update_pending_airtime(local, tx.st=
a,
> +                                                            txq->ac, air=
time,
> +                                                            false);
> +               }
> +       }
> +
>         return skb;
>
>  out:
>
