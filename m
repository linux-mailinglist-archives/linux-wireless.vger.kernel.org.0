Return-Path: <linux-wireless+bounces-20773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F9A6E040
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE723ABEFA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89112263C91;
	Mon, 24 Mar 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvn8SGsA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DF263F25;
	Mon, 24 Mar 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835240; cv=none; b=Aye4XjjX2LQxCuh3S1P7zHQBZDTonrYeJwfpcjjELlljRVT+YLtiO111QopE09AbVXo0KhVjJjZg28tmqsgTIfRtyqabRb6i3A9XYtHrlBXCsFZWc89vsF2YOc27S3L17fIhRzDfwBxJ46XLbIqWVY9v3zRg8V++DJ92YNjPdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835240; c=relaxed/simple;
	bh=5HdPWf9m3WFmIVGoPmOl/Dc14erwkK4cs/CWjXuYWBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwNvGY6qypBLacM+cFH6faTvLWnRm7sWrxcRd7DSj4X8NgzZVI8kcc517GmYiwXNIMvX1y7lchGOoqu1SljzwQNfxThs6upe/8vijmmap0bW0bwK7mLuhjtdl9hRLKUDBP2oBtUcs5Tz+SCgqIt5ahcHjgGpzU00cz6T6ZNN05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvn8SGsA; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d4496a34cdso14572655ab.1;
        Mon, 24 Mar 2025 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742835238; x=1743440038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noOG1gs6jyKnnWgfSb4CTlen5GZCaEYwgu6oh3DZt+E=;
        b=Bvn8SGsA7Pi2Oqp24P32MY1Z4si7lLrh2QD1VPdonMAALSK+p7PvxpUCJXzJ+ZAU8o
         zWLS2Vpfh6pVzhBngybCoxv0zNPJldOC+LsxYrLDOhsnimZkI7a7HyXWW2nTBpjGg0GS
         zVo/vh9wCzy+KE5qyrsN4iTuHPi77WNYfBK/7rshdr7ha1b8TUZrDQtDHW0du65+ScU7
         USEJFyb6FW4UJYb8FKqe9zx3blK9Icx0gBRWbG2tEMb8vzJyJAczxSxPkeH5TUxfGE2q
         tQgs4YWJUGfDhqjG5jBjf89+0b/qpFgQLwmvh/8llSiXYoSrKKLxRUI9otrjENuhyKqk
         v+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835238; x=1743440038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noOG1gs6jyKnnWgfSb4CTlen5GZCaEYwgu6oh3DZt+E=;
        b=LgVPCyZoTmt4GcjYtdlidPclzgvLkTTNe3PBhprZAp2UIVgJ4Oi30OkblzpX5qH1dM
         jhRcLUedAhFW3t3T1Db/iAdOs03xmNSpU54XOpk1KAvZR20fM3yr1Ni8pKSZioMmhZ7Z
         uuhIKLgs26CPbveEHz2/68fyiN5RGii00TFrC/EqzyfQKQ5TW2XdvBfJtlNoyoFq8bHf
         HaUJQUa+PdPEvBzy2a7ok6JpyfPrzfrxBD/FBiNzUSs7ag2yMp3XJIW0+1Dz3VYGIEvF
         bfVpl5n6lTpC2iVJRgX55xPBEbrhu9+VZzYnqGgNqV3mKaZRujFYCzbVQ7lcdSnX/9zn
         acAg==
X-Forwarded-Encrypted: i=1; AJvYcCUi5i1EASPGkUeFK+GTPfw/x0ISdCE9VTqM6JHAeDd/m2Yya5UY4yt8JPp/AT4iO3xag010r/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmh83g0tpQg5uNkEarxv1Z+JojHzF8zYNy8MvL9vmnt0lYElc
	tZMvbnyqgo/8BA9FtO1yBG5t65FtppXewyE36DogLyFxwuMne5C7Wx7E2sVhQjFfDFlD1cUx33Z
	+Vi5jplET9zEli/Acacg8lIj4t2I=
X-Gm-Gg: ASbGncvrB1jkSkFOwX//cc8RYlJu4rgT93Of9VEgDXrdmRDUiRYOfrQHmNRJOyB51r6
	7hRf7yKibDOVg5+rQeqexOfm1eBkvMeDU1uMq5CYlEeYOIHFmy9prRtn3php/0/Eom9ECFRlXTe
	KM5vl4JCJBLgr+eT8VzfSRTv1KEg==
X-Google-Smtp-Source: AGHT+IHbIOU2uQX2zGmrMb5t9w3JPDla8k+F6srVXhUTw2pmoGfqRvYiv5hVhU/wJ+vzJI+jhoM35z++U96PT5cH9jQ=
X-Received: by 2002:a92:c263:0:b0:3d5:8937:f419 with SMTP id
 e9e14a558f8ab-3d59611923dmr125344285ab.13.1742835237641; Mon, 24 Mar 2025
 09:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
In-Reply-To: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Mar 2025 00:53:21 +0800
X-Gm-Features: AQ5f1JqyJ3ZcT0OL9SE5gM3sMsEwxsTA1pF1BMnlxTyQXwQCd9okh92vPjvUE-Q
Message-ID: <CAL+tcoB3zku2EtLT2yJ9qPCSuN2=x-T-avqcZ-LJ2Q-mU5xLVg@mail.gmail.com>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Thanks for working on this. After net-next is open, I will use this
bit to finish the bpf timestamping in the rx path :)

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

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

It might conflict with the bluetooth commit [1], I presume.

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoot=
h-next.git/commit/?id=3Dc6c3dc495a6ce5b9dfed4df08c3220207e7103bd

>
> -       /* generate wifi status information (where possible) */
> -       SKBTX_WIFI_STATUS =3D 1 << 4,
> -

Better use SKBTX_RESERVED. No strong preference here since I'm going to use=
 it.

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

