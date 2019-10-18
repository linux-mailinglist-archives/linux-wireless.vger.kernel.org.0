Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022F1DBB17
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 02:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfJRAvJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 20:51:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33036 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJRAvJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 20:51:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so4439854ljd.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iSISwMWQRzg7gYQZDYIh1MYDmFm6gFbMUIzdn63eJwU=;
        b=QP0xqjF6DY67L/9suJLLGwl/AvrVD8IKr9fTiVwt6tmpTZjFVQslVcfmBezgjvnYfh
         WaggH29yb505zVIdoU7dqFPnFUm3CMbigyH7Zf56IdO+IfXEqKSkn5zHUl/EsMpzdHWB
         jMoSXXsZGJjuF8v044ZYVbKrWxdUKQCuC2zJcoEgf0GZE2Ia4MQK/gCE3ctqoXUClaBk
         mV5mRI260p8dDPGlvscJ52qBok/XTtWWIXjHktI1BiLRdpglWBfQxNdl4AQbezAhhqJv
         s9YZ02IKK0ZBYYzi1aCu2Gn5pCZtlaNF+bIP7B4jwJxWI5Tu5MQUXgQdYBUXUBRExceV
         7A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iSISwMWQRzg7gYQZDYIh1MYDmFm6gFbMUIzdn63eJwU=;
        b=AAGd6C3UsIEJl6u7FDY3aNo5BE4y/eja5r5lgAjd06d6Qzf89HBbBJd1oJUV3SvaLt
         slXqlBckbfC5Wj6/eiJwnp3PIdrNglqWOrdTL8R/AoM5n/aAZDgEG+jDIXufz6gICWTS
         kX3w83wEhtU9XkZGR++YiHOQ0PAauRDr3HtKwX9+/TlHr3RkGJI0uTER2o1Qsp49XX3e
         58/fN0uoN+uEfMxk5dR3JSiMCFslZL9N5hvLHKeSzRmhjGUrQ6xXhfliMwGx8dUpw3KN
         UHMtSXFPzuP78zedNfRKXSefgzz+s7mzYV1oIOcEJoD1SCJBKVuH//QipatNYa/LHjRu
         9F3g==
X-Gm-Message-State: APjAAAXDud4NFa1sGP4tsh3dW1zgEu2bnL9jtwsUku9F+QcADRkjoVNJ
        lxyNookkRwkUbJP9XVz5sA8Dnn38KJfVPdSyvOT+5A==
X-Google-Smtp-Source: APXvYqzqP1PdXmQ5SSn0pQfY8BIQUHJ9okt6UCdSg83dwdeJBSSDcNxdBhuSrwj5YhVGdR5gHUVemkb8GxA9+l7t2uU=
X-Received: by 2002:a2e:2b94:: with SMTP id r20mr4254273ljr.119.1571359865720;
 Thu, 17 Oct 2019 17:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115993866.2500430.13989567853855880476.stgit@toke.dk>
In-Reply-To: <157115993866.2500430.13989567853855880476.stgit@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Thu, 17 Oct 2019 17:50:54 -0700
Message-ID: <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mac80211: Rearrange ieee80211_tx_info to make room
 for tx_time_est
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

The "tx_time_est" field, shared by control and status, is not able to
survive until the skb returns to the mac80211 layer in some
architectures. The same space is defined as driver_data and some
wireless drivers use it for other purposes, as the cb in the sk_buff
is free to be used by any layer.

In the case of ath10k, the tx_time_est get clobbered by
struct ath10k_skb_cb {
        dma_addr_t paddr;
        u8 flags;
        u8 eid;
        u16 msdu_id;
        u16 airtime_est;
        struct ieee80211_vif *vif;
        struct ieee80211_txq *txq;
} __packed;

Do you think shrink driver_data by 2 bytes and use that space for
tx_time_est to make it persistent across mac80211 and wireless driver
layer an acceptable solution?

Kan




On Tue, Oct 15, 2019 at 10:19 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> To implement airtime queue limiting, we need to keep a running account of
> the estimated airtime of all skbs queued into the device. Do to this
> correctly, we need to store the airtime estimate into the skb so we can
> decrease the outstanding balance when the skb is freed. This means that t=
he
> time estimate must be stored somewhere that will survive for the lifetime
> of the skb.
>
> Fortunately, we had a couple of bytes left in the 'status' field in the
> ieee80211_tx_info; and since we only plan to calculate the airtime estima=
te
> after the skb is dequeued from the FQ structure, on the control side we c=
an
> share the space with the codel enqueue time. And by rearranging the order
> of elements it is possible to have the position of the new tx_time_est li=
ne
> up between the control and status structs, so the value will survive from
> when mac80211 hands the packet to the driver, and until the driver either
> frees it, or hands it back through TX status.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/net/mac80211.h |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index d69081c38788..49f8ea0af5f8 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -975,20 +975,23 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_t=
x_rate *rate)
>   * @control.short_preamble: use short preamble (CCK only)
>   * @control.skip_table: skip externally configured rate table
>   * @control.jiffies: timestamp for expiry on powersave clients
> + * @control.enqueue_time: enqueue time (for iTXQs)
> + * @control.tx_time_est: estimated airtime usage (shared with @status)
> + * @control.reserved: unused field to ensure alignment of data structure
> + * @control.flags: control flags, see &enum mac80211_tx_control_flags
>   * @control.vif: virtual interface (may be NULL)
>   * @control.hw_key: key to encrypt with (may be NULL)
> - * @control.flags: control flags, see &enum mac80211_tx_control_flags
> - * @control.enqueue_time: enqueue time (for iTXQs)
>   * @driver_rates: alias to @control.rates to reserve space
>   * @pad: padding
>   * @rate_driver_data: driver use area if driver needs @control.rates
>   * @status: union part for status data
>   * @status.rates: attempted rates
>   * @status.ack_signal: ACK signal
> + * @status.tx_time_est: estimated airtime of skb (shared with @control)
> + * @status.tx_time: actual airtime consumed for transmission
>   * @status.ampdu_ack_len: AMPDU ack length
>   * @status.ampdu_len: AMPDU length
>   * @status.antenna: (legacy, kept only for iwlegacy)
> - * @status.tx_time: airtime consumed for transmission
>   * @status.is_valid_ack_signal: ACK signal is valid
>   * @status.status_driver_data: driver use area
>   * @ack: union part for pure ACK data
> @@ -1026,11 +1029,17 @@ struct ieee80211_tx_info {
>                                 /* only needed before rate control */
>                                 unsigned long jiffies;
>                         };
> +                       union {
> +                               codel_time_t enqueue_time;
> +                               struct {
> +                                       u16 tx_time_est; /* shared with s=
tatus */
> +                                       u16 reserved; /* padding for alig=
nment */
> +                               };
> +                       };
> +                       u32 flags;
>                         /* NB: vif can be NULL for injected frames */
>                         struct ieee80211_vif *vif;
>                         struct ieee80211_key_conf *hw_key;
> -                       u32 flags;
> -                       codel_time_t enqueue_time;
>                 } control;
>                 struct {
>                         u64 cookie;
> @@ -1038,12 +1047,13 @@ struct ieee80211_tx_info {
>                 struct {
>                         struct ieee80211_tx_rate rates[IEEE80211_TX_MAX_R=
ATES];
>                         s32 ack_signal;
> +                       u16 tx_time_est; /* shared with control */
> +                       u16 tx_time;
>                         u8 ampdu_ack_len;
>                         u8 ampdu_len;
>                         u8 antenna;
> -                       u16 tx_time;
>                         bool is_valid_ack_signal;
> -                       void *status_driver_data[19 / sizeof(void *)];
> +                       void *status_driver_data[16 / sizeof(void *)];
>                 } status;
>                 struct {
>                         struct ieee80211_tx_rate driver_rates[
> @@ -1126,6 +1136,8 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_=
info *info)
>                      offsetof(struct ieee80211_tx_info, control.rates));
>         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates) !=
=3D
>                      offsetof(struct ieee80211_tx_info, driver_rates));
> +       BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, control.tx_time_e=
st) !=3D
> +                    offsetof(struct ieee80211_tx_info, status.tx_time_es=
t));
>         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates) !=
=3D 8);
>         /* clear the rate counts */
>         for (i =3D 0; i < IEEE80211_TX_MAX_RATES; i++)
>
