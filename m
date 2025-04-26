Return-Path: <linux-wireless+bounces-22102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60577A9DDEE
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 01:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B3817D003
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B41FF7B3;
	Sat, 26 Apr 2025 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgcNZKOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986901DFF0;
	Sat, 26 Apr 2025 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745711745; cv=none; b=L4tX695O28ZgNhnUIRjarVh4mAalAesGjixfygFSyXlF3zDYENpS/AgN2gqu5bWv+N+4iD4wXUgXHwEwgbiw5z75YeiWsYmgx4XzorUTUQ5zUvs4Fin4DF2q8oCUL4PzCWzYfTvPIztiCE9JZMQyh9AoutYU0VQjPeed5rBGC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745711745; c=relaxed/simple;
	bh=CN04mp5Hzz4TxfJzA9UkhfxZazobzkg4L4sWjiSrggo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvCh2XtAS9HodZQ1g3i4q5QxJQYTlLVXGkqF7RY5E+Cn0oUu8k0wnEFWACVMFSRrIxfaTk9gON7H1XlnGxxZsJSmViPiSUpoZQs00eRD7kL9YmMOJ3JWZ98L2gcP9S+LsCzKc+AqrKAkvbv3sVB1LuLZF08zzVAeQb3Wd54oEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgcNZKOo; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d57143ee39so31423495ab.1;
        Sat, 26 Apr 2025 16:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745711742; x=1746316542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaztB6z6BSPvlaDYmOQ1mMHeos6bY4JMrsEa59E6gxk=;
        b=BgcNZKOoTCvXvQjv40kSjy6DG0Heab42mIwlPdr1r6GsDZADRUURLAMBHuZ4PX5m8Z
         wwS8EGL8cadfiocl8s93g+hMkV/f3fndichKIS8xxolPXPUmLc1bCM70BzwiEOCeScpp
         LXX0OGegvVbihCQyo08pL4pdnVTN7Hx3+T7OipSDkroDYb0OrCu15f1sVfYu/JtgYeC5
         lpAKmn/QQ+JJWochsotpEUTdGEc0/dm0jI1G9KS7TzYWPnP65p6+9S0p828E1rGvKs/j
         wB/1O4cjew/kdxApFHhxEZloIhdPkYnj4wxP8Lmi2CHnfM92vK5SFmLMlcTHXHwqPPRB
         dVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745711742; x=1746316542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaztB6z6BSPvlaDYmOQ1mMHeos6bY4JMrsEa59E6gxk=;
        b=MquVTAAjQNTdKiGXVSrCK2wYGwmys7OuTDvUqhv65t8xQnppxkzvTkmmRUK3vhq/b6
         tQLAKQfFKVGWHThdV+PxfSOxB0UOPEIZyQGqFzooogf5YHrzHTf+dw8RDGyFgQqkNlsU
         fbS8G6IPJZ4tewj53yffwTl2ORJV0SFdDoi/73iTYvDfip0cypfCMNYBue5cykzJStG5
         U9SMCEgY9IC4fWKe8DcXgCE3qTmu5ieqjpErrTEUoujS0TZkOTxXPYW+O0sCvF3dER43
         eiMxFfwXb/Ir5hOk2Ht06TCcVvgb/MnXzALpscT8qxPHqdNVi+S3TpYt1QpMds0+6KSC
         b72g==
X-Forwarded-Encrypted: i=1; AJvYcCUzUcsDFSlkPjGXIF8Vwn3nap9E1MPdW0yzw6dA41k/CxfzWqEJUvS3qKM7Z2OWvnJvxTaxdRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lo9IvPMHV4YXIEoAx8d56+2SNio6QNHpQevcaGh6/R0ISk/P
	OFNvai2TCm1BiXbQOdDJOwOtD8rAKrJbu7CBxUpE4iw3GNvrty4ntfK4wuU0WjA/q6IDcT/6yen
	+aZEQ/ulaEiD7qiHlWNDFD6X25F8=
X-Gm-Gg: ASbGncsDIfLyu0QcHEu8xQhef29nIawMVRgI1rehDF2+gveQbPLKalhRdddoFu1tsMk
	5mI7fKbzeEejn4Dl1yAwLAFT1PxShTVPbC0PImx0Mvj/HUD+AafHCaGclt2TMe61JVELZVtL6/9
	DPZI47hZFWxJo5pXGC0Ygu9Kjxw7p2ni0=
X-Google-Smtp-Source: AGHT+IHB77RAetVr2KVVYI4l5ew77jStknccW/0eNisDbiA6s+azELSQpGS+qRcnMdXwZH59qeVJcTsH9bSJSAGeptg=
X-Received: by 2002:a05:6e02:178d:b0:3d8:20f0:4006 with SMTP id
 e9e14a558f8ab-3d942d1dde3mr45773585ab.4.1745711742604; Sat, 26 Apr 2025
 16:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
In-Reply-To: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 27 Apr 2025 07:55:06 +0800
X-Gm-Features: ATxdqUENz_2vM1tjB6p41stTqxzx6V15A7OUEGWXUtyvYhhmMBXSxGW3p43wmeE
Message-ID: <CAL+tcoBSj_ddXkee9q9Yr_GUTEAVHprBC-JNEAJZiJZP-+324g@mail.gmail.com>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Thu, Mar 13, 2025 at 9:01=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Someone mentioned today at netdevconf that we've run out of
> tx_flags in the skb_shinfo(). Gain one bit back by removing
> the wifi bit. We should be able to do that because the only
> userspace application for it (hostapd) doesn't change the
> setting on the socket, it just uses different sockets, and
> normally doesn't even use this any more, sending the frames
> over nl80211 instead.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Do you have plans to repost it recently in net-next? I'm going to
implement the rx path for BFP timestamping based on this patch :)

Thanks,
Jason

> ---
>  drivers/net/wireless/ath/wil6210/txrx.h     | 3 ++-
>  drivers/net/wireless/marvell/mwifiex/main.c | 3 ++-
>  include/linux/skbuff.h                      | 3 ---
>  include/net/sock.h                          | 2 --
>  net/mac80211/mesh.c                         | 3 ++-
>  net/mac80211/tx.c                           | 9 ++++-----
>  6 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wirele=
ss/ath/wil6210/txrx.h
> index 689f68d89a44..33ccd0b248d4 100644
> --- a/drivers/net/wireless/ath/wil6210/txrx.h
> +++ b/drivers/net/wireless/ath/wil6210/txrx.h
> @@ -7,6 +7,7 @@
>  #ifndef WIL6210_TXRX_H
>  #define WIL6210_TXRX_H
>
> +#include <net/sock.h>
>  #include "wil6210.h"
>  #include "txrx_edma.h"
>
> @@ -617,7 +618,7 @@ static inline bool wil_need_txstat(struct sk_buff *sk=
b)
>         const u8 *da =3D wil_skb_get_da(skb);
>
>         return is_unicast_ether_addr(da) && skb->sk &&
> -              (skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS);
> +              sock_flag(skb->sk, SOCK_WIFI_STATUS);
>  }
>
>  static inline void wil_consume_skb(struct sk_buff *skb, bool acked)
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wi=
reless/marvell/mwifiex/main.c
> index 45eecb5f643b..058687793a10 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/suspend.h>
> +#include <net/sock.h>
>
>  #include "main.h"
>  #include "wmm.h"
> @@ -943,7 +944,7 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct n=
et_device *dev)
>         multicast =3D is_multicast_ether_addr(skb->data);
>
>         if (unlikely(!multicast && skb->sk &&
> -                    skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS &&
> +                    sock_flag(skb->sk, SOCK_WIFI_STATUS) &&
>                      priv->adapter->fw_api_ver =3D=3D MWIFIEX_FW_V15))
>                 skb =3D mwifiex_clone_skb_for_tx_status(priv,
>                                                       skb,
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 14517e95a46c..a8638c8a53b4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -481,9 +481,6 @@ enum {
>         /* reserved */
>         SKBTX_RESERVED =3D 1 << 3,
>
> -       /* generate wifi status information (where possible) */
> -       SKBTX_WIFI_STATUS =3D 1 << 4,
> -
>         /* determine hardware time stamp based on time or cycles */
>         SKBTX_HW_TSTAMP_NETDEV =3D 1 << 5,
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8daf1b3b12c6..2668c3ed45ef 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2700,8 +2700,6 @@ static inline void _sock_tx_timestamp(struct sock *=
sk,
>                                 *tskey =3D atomic_inc_return(&sk->sk_tske=
y) - 1;
>                 }
>         }
> -       if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS)))
> -               *tx_flags |=3D SKBTX_WIFI_STATUS;
>  }
>
>  static inline void sock_tx_timestamp(struct sock *sk,
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index 974081324aa4..e77e623c8b77 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/slab.h>
>  #include <linux/unaligned.h>
> +#include <net/sock.h>
>  #include "ieee80211_i.h"
>  #include "mesh.h"
>  #include "wme.h"
> @@ -776,7 +777,7 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if=
_data *sdata,
>         if (ethertype < ETH_P_802_3_MIN)
>                 return false;
>
> -       if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
> +       if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
>                 return false;
>
>         if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 20179db88c4a..b75f72fbefd9 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -26,6 +26,7 @@
>  #include <net/codel_impl.h>
>  #include <linux/unaligned.h>
>  #include <net/fq_impl.h>
> +#include <net/sock.h>
>  #include <net/gso.h>
>
>  #include "ieee80211_i.h"
> @@ -2876,8 +2877,7 @@ static struct sk_buff *ieee80211_build_hdr(struct i=
eee80211_sub_if_data *sdata,
>         }
>
>         if (unlikely(!multicast &&
> -                    ((skb->sk &&
> -                      skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ||
> +                    ((skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS)) |=
|
>                       ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
>                 info_id =3D ieee80211_store_ack_skb(local, skb, &info_fla=
gs,
>                                                   cookie);
> @@ -3774,7 +3774,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_su=
b_if_data *sdata,
>                 return false;
>
>         /* don't handle TX status request here either */
> -       if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
> +       if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
>                 return false;
>
>         if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
> @@ -4664,8 +4664,7 @@ static void ieee80211_8023_xmit(struct ieee80211_su=
b_if_data *sdata,
>                         memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info)=
);
>         }
>
> -       if (unlikely(skb->sk &&
> -                    skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
> +       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
>                 info->status_data =3D ieee80211_store_ack_skb(local, skb,
>                                                             &info->flags,=
 NULL);
>                 if (info->status_data)
> --
> 2.48.1
>
>

