Return-Path: <linux-wireless+bounces-23133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C74ABB29D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337553B47E0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B497BAEC;
	Mon, 19 May 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU8vnqIU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C20A55;
	Mon, 19 May 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747613997; cv=none; b=o5xTr/Kxu+ZgunAugV2XT39n5wWn150Up8hGmRNPnf3u3yuYD7Vd+RfWnt4rSpQjbiGJHaRDA+YGFxOkdLgAcinQQo038Q76+LQiQE3h+WEBflZ5Le7QfGf8+zpPbcRr7WQvzNSQ/tC/Lg4XElSchtJec8uvhU8ghcNxRInfBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747613997; c=relaxed/simple;
	bh=e+8xX1cNRYnccXiDprAPn7Ln+YBvl0s4xBwFMImTf8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+r7j5CZyn0F+LRvsNbjjRnFzsBcSBG2Mebu2Uyz2knKLlD3arnhvDIWWGgHUGknTxMZAaSPJFNw73uaIny530ibvaOqo0GCR5DUdf1IVj4qNce8OtIg34jXJZiAf7lwtemkIdPy2F+yUbbxq9eVerKZ/kOtUg/uaexxG1OTEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU8vnqIU; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85d9a87660fso459035639f.1;
        Sun, 18 May 2025 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747613995; x=1748218795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mIEs5JgSEaPbr5jSK7sQiQaNvyQeS4sY5VhRKgpWgQ=;
        b=YU8vnqIUROhgPVcb2MIR27+xpSve2TvDxS2z4dXCJjIVylV0eDU0sObBRf0paIOhdl
         thLRx6GnDkugmoHrS6zJuuyo9qLPnuiMh3oA0Li4jcBs4zJ17g5m0wJ8mKnn2fmhSRk9
         tOqwiFrMJ1dcBGsmr8T/MZE+gZ4rKTX4QlUG0xB+HpN62LZ8oJXCf6T0Nn//9JQoTdQI
         8HiHJH4fLIVg9+c0yntdMOEyDj3afF000b366OCcILn/0l7hff+iqKzSV8px2iDrdywb
         t0WjWETorJ0FZkeSstY4W7tQFTSCE4rgdsDT8N9LVA4slEyQ/Zhp2CymI8YxX9XKXMwG
         Aisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747613995; x=1748218795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mIEs5JgSEaPbr5jSK7sQiQaNvyQeS4sY5VhRKgpWgQ=;
        b=h2OAwUR96WMAITHvCELf4KNLzp48D8PvA3JU07xsOSiZGvQHxu6bEogeW5xH5StgFX
         CGVne2sisjAvUSEjECpoA3EUceSJr9TQvIBEJ1a62mQrXMJ3ztDyNf4Id3/ui5VQMswh
         8O2NK0pw4UsqwBMb8Lc1Q7LLgg4AwDGVx/WacMJ92jSdWYAjKPT3wtQvAGNiTNE/87Yq
         e8C+s6o74Du6TJRBqqbcjU9s0O9H/mWNfooxrNuGu0E5Wlb+jDk+kh5EUtOuAGiOlY32
         hLmqI3WngOQe9RhpeXNJjOFauwLCkl6u52bvbfHSJRZKDdLNKsQIbaywH9tcC177V+Pc
         QSUA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvQXobH9KnuywW/VRi4C3iUQjwcQlhwK2Q9uHVJJj3tyXKIuWGyEAujOCvPoutlyl6NjJbnzXMtj4HyI=@vger.kernel.org, AJvYcCWX623Xc0a9Jc1sMils7ARo2JFPLBpZZ1J/C4r4GnwL3jBQnZm2ho9Br93PLHhs7CaTtBu1B1gtzYlGjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEu9rW3t1mtguwqAwV2415sPmPkzZ0VW98dLYawip5uYVxkCo
	qF3RAGVgSdd7lKJRi4AaGT4B76h3fiyEIOTEOfJZfE+JirB8Q8wgzaK1xo8bI6+GUJwz5TQ4Nx0
	imnNibVeME1TORLXacfbBfZcUZtVPApA=
X-Gm-Gg: ASbGncvn6xbymYwaTCR+24+lK6dUcLmxRW9XuLj/B5J4tBvNlHAnQp+mnMgTKgOd5xm
	JJrGf2o4JwRJXjw73TZY+bR2sp3FDNDNzhOIOZuNtDXFaOHSbhQas1Zl/m0FD3cV1W4iojMbYS/
	nQoj0wNO8lKvn/OnGIoE+jC4bmNfA7ous=
X-Google-Smtp-Source: AGHT+IG3O0hhjIORebx7V/xhzGNNRuXYkKqud94y0o19uMMgfpdEla4ZCmPTNNnrWvglmcw7RIoLzbae0POswDlNp1I=
X-Received: by 2002:a05:6e02:1a02:b0:3d4:2306:a875 with SMTP id
 e9e14a558f8ab-3db8573b7f2mr117674435ab.8.1747613995011; Sun, 18 May 2025
 17:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518164546.4612-1-spasswolf@web.de>
In-Reply-To: <20250518164546.4612-1-spasswolf@web.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 May 2025 08:19:19 +0800
X-Gm-Features: AX0GCFvOvbUTzmHJdz0uqX0nRrz7gaE2_-JhccWYMysTJrerFVRfpgOSNjwvooA
Message-ID: <CAL+tcoB8kP-q-RsWBrow0yauGd5aiqq=zmokD-s5GWrqOZx=EA@mail.gmail.com>
Subject: Re: [PATCH] wifi: Check if socket flags are valid
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 12:46=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> The check, if a particular SO_* flag_bit is set, may give a wrong result
> since sk_flags are part of a union and the union is used otherwise.
> This happens, if a socket is not a full socket, like a request socket
> for example.
>
> Add a check to verify, if the union is used for sk_flags.
>
> This solution is taken from commit
> e8a64bbaaad1 ("net/sched: taprio: Check if socket flags are valid").
>
> Fixes: 76a853f86c97 ("wifi: free SKBTX_WIFI_STATUS skb tx_flags flag")
>

nit: empty line

> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Great! Thanks!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  drivers/net/wireless/ath/wil6210/txrx.h     | 2 +-
>  drivers/net/wireless/marvell/mwifiex/main.c | 2 +-
>  net/mac80211/mesh.c                         | 2 +-
>  net/mac80211/tx.c                           | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wirele=
ss/ath/wil6210/txrx.h
> index 33ccd0b248d4..91432b318ec2 100644
> --- a/drivers/net/wireless/ath/wil6210/txrx.h
> +++ b/drivers/net/wireless/ath/wil6210/txrx.h
> @@ -618,7 +618,7 @@ static inline bool wil_need_txstat(struct sk_buff *sk=
b)
>         const u8 *da =3D wil_skb_get_da(skb);
>
>         return is_unicast_ether_addr(da) && skb->sk &&
> -              sock_flag(skb->sk, SOCK_WIFI_STATUS);
> +              sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WIFI_STATU=
S);
>  }
>
>  static inline void wil_consume_skb(struct sk_buff *skb, bool acked)
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wi=
reless/marvell/mwifiex/main.c
> index 1485f949ad4e..973df2656238 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -913,7 +913,7 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct n=
et_device *dev)
>
>         multicast =3D is_multicast_ether_addr(skb->data);
>
> -       if (unlikely(!multicast && skb->sk &&
> +       if (unlikely(!multicast && skb->sk && sk_fullsock(skb->sk) &&
>                      sock_flag(skb->sk, SOCK_WIFI_STATUS) &&
>                      priv->adapter->fw_api_ver =3D=3D MWIFIEX_FW_V15))
>                 skb =3D mwifiex_clone_skb_for_tx_status(priv,
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index a381b4b756ea..11b6cb639ae7 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -777,7 +777,7 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if=
_data *sdata,
>         if (ethertype < ETH_P_802_3_MIN)
>                 return false;
>
> -       if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
> +       if (skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WI=
FI_STATUS))
>                 return false;
>
>         if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 3b9392a6ddb2..8b5bcddd5cc9 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -2859,7 +2859,7 @@ static struct sk_buff *ieee80211_build_hdr(struct i=
eee80211_sub_if_data *sdata,
>         }
>
>         if (unlikely(!multicast &&
> -                    ((skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS)) |=
|
> +                    ((skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->=
sk, SOCK_WIFI_STATUS)) ||
>                       ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
>                 info_id =3D ieee80211_store_ack_skb(local, skb, &info_fla=
gs,
>                                                   cookie);
> @@ -3756,7 +3756,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_su=
b_if_data *sdata,
>                 return false;
>
>         /* don't handle TX status request here either */
> -       if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
> +       if (skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WI=
FI_STATUS))
>                 return false;
>
>         if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
> @@ -4648,7 +4648,7 @@ static void ieee80211_8023_xmit(struct ieee80211_su=
b_if_data *sdata,
>                         memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info)=
);
>         }
>
> -       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
> +       if (unlikely(skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk=
, SOCK_WIFI_STATUS))) {
>                 info->status_data =3D ieee80211_store_ack_skb(local, skb,
>                                                             &info->flags,=
 NULL);
>                 if (info->status_data)
> --
> 2.49.0
>
> I've dug a little into the history of sk_flags (which have been introduce=
d in
> v4.4) and found commit e8a64bbaaad1 ("net/sched: taprio: Check if socket =
flags
> are valid"), which seems to address the same problem we're currently faci=
ng:

Indeed, sk_flags can only be used by a full socket.

Thanks,
Jason

>
> commit e8a64bbaaad1f6548cec5508297bc6d45e8ab69e
> Author: Benedikt Spranger <b.spranger@linutronix.de>
> Date:   Fri Apr 8 11:47:45 2022 +0200
>
>     net/sched: taprio: Check if socket flags are valid
>
>     A user may set the SO_TXTIME socket option to ensure a packet is send
>     at a given time. The taprio scheduler has to confirm, that it is allo=
wed
>     to send a packet at that given time, by a check against the packet ti=
me
>     schedule. The scheduler drop the packet, if the gates are closed at t=
he
>     given send time.
>
>     The check, if SO_TXTIME is set, may fail since sk_flags are part of a=
n
>     union and the union is used otherwise. This happen, if a socket is no=
t
>     a full socket, like a request socket for example.
>
>     Add a check to verify, if the union is used for sk_flags.
>
>     Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
>     Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
>     Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>     Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 377f896bdedc..b9c71a304d39 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -417,7 +417,8 @@ static int taprio_enqueue_one(struct sk_buff *skb, st=
ruct Qdisc *sch,
>  {
>         struct taprio_sched *q =3D qdisc_priv(sch);
>
> -       if (skb->sk && sock_flag(skb->sk, SOCK_TXTIME)) {
> +       /* sk_flags are only safe to use on full sockets. */
> +       if (skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_TX=
TIME)) {
>                 if (!is_valid_interval(skb, sch))
>                         return qdisc_drop(skb, sch, to_free);
>         } else if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
>
> I'm not sure if all sk_fullsock() checks are necessary, or if it can
> be guessed from context if the socket is valid, though.
>
> This has been tested for ~1h so far.
>
> Bert Karwatzki

