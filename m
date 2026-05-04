Return-Path: <linux-wireless+bounces-35882-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBtYG2H0+Gk73gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35882-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:32:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F184C3466
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6675303D72A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165153E8668;
	Mon,  4 May 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVqZ/GuR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A8378D72
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922783; cv=none; b=qhSwAEWx86+QMpvDSiOI4CBRotvG8zNMF+7sxuH4Q8W+ZG5wXqxV/vX7WVBozrvm0RYa0iZQ2Cwv9MnzWLHfsJ2vndQnLwIeG8LojmhZL3rwnRsNz7X0mjAqDWfbWufEfE4qhD/K4nC6x6vNknMbp35IeLt8irajYF2sLZm81zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922783; c=relaxed/simple;
	bh=GL6Vn8WKeM1BTTdQhCnWmCWbkkEh7LzY4zKCUdD6fhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNrnsgUCMqhqZJsA7h9oLUzvJa0uWUPymopZHgvhFs23plFbPC4pD7za529wtIzNYa51oASgwGlmtWelPu+rA9SxtnoTgcm3386vH6yky2wc9NXrCAvGE03YGOXpb5Vbbu5A6A2C3z60SLMZ38EbBOZbN+TrxETpevESw+raeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVqZ/GuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62176C2BCF5
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777922782;
	bh=GL6Vn8WKeM1BTTdQhCnWmCWbkkEh7LzY4zKCUdD6fhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jVqZ/GuRcXECP5oKriX8p92qj8/Q4HVHldhI+q9pkqARsu9vUeUPdzhUuEe0G4ab+
	 9BEjE7MumWxuTMqYaZKONcaZfNdwB90AlRsiohszhtN6qkn1brnvrTs1d6YnCTG9AF
	 WbfWRP9vcWA4FC9x4Q14KUhRgyWOMaVOgg3/GmUMkfWWB/RfdXVN7B3E3bV1eC2X8y
	 8UdbN7O+Sz8cLnxvhwOdJfw/AykntBHGmcfCAv3SEQeCZKzqp1GF1ngx9ZP34STBoD
	 6Ee5BJtmL5j7qwogfC7M8ujZCh+GwlzChOKTSZ0a7HHrzW129B8ojDlOTIApNALp1a
	 xunM7sz8TzArA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a877510541so1089571e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:26:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9IrE8f2f5zPx63NSrc7UfGqLsfDS4E/XkdThfCUc7xsc0OGZ1OFBQtsWQXEflw+hBp517OIFZ8JbyT3ixwoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkSaKA8UqEsOfHuC6W6G0A2WckQoDmO+9rYi5gShkZdLcoX0E
	xtITvhqV5ZRAuTz/Ppss99LLtY/Zw0cHy8dwbZrYwyQHUYXXKIZ0grGJleezS/2CUOFFpfBSFc6
	Bu9kXTUoQQTzWdpqMqog6D+lTEW4HgZQ=
X-Received: by 2002:a05:6512:3e0f:b0:5a4:1904:711c with SMTP id
 2adb3069b0e04-5a87f1e9dd9mr75929e87.29.1777922780493; Mon, 04 May 2026
 12:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430084525.3471313-1-jb.tsai@mediatek.com>
In-Reply-To: <20260430084525.3471313-1-jb.tsai@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 4 May 2026 14:26:09 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzop0opQ_jDHsExDQpx355NBL=48oeHRXDZMQKQs6er_8g@mail.gmail.com>
X-Gm-Features: AVHnY4JN9SNXtAl6rlntT0dLYS0j7nF6PnmmRTEuH8WtfSBirHP98-o8wZtE5es
Message-ID: <CAGp9Lzop0opQ_jDHsExDQpx355NBL=48oeHRXDZMQKQs6er_8g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete
To: JB Tsai <jb.tsai@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Deren.Wu@mediatek.com, 
	Sean.Wang@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
	Leon.Yen@mediatek.com, litien.chang@mediatek.com, eason.lai@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5F184C3466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35882-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mediatek.com:email]

Hi,

On Thu, Apr 30, 2026 at 3:50=E2=80=AFAM JB Tsai <jb.tsai@mediatek.com> wrot=
e:
>
> From: Eason Lai <Eason.Lai@mediatek.com>
>
> A use-after-free issue occurs in mt76_rx_poll_complete due to a race
> condition. The STA has already been removed, but the rx_status still
> had a pointer to the wcid in the STA.
>
> Use wcid_idx instead of storing the wcid pointer, and look up the wcid
> via rcu_dereference() by wcid_idx.
>
> BUG: KASAN: invalid-access in mt76_rx_poll_complete+0x280/0x470 [mt76]
> Call trace:
> dump_backtrace+0xec/0x128
> show_stack+0x18/0x28
> dump_stack_lvl+0x40/0xc8
> print_report+0x1b8/0x710
> kasan_report+0xe0/0x144
> do_bad_area+0x120/0x260
> do_tag_check_fault+0x20/0x34
> do_mem_abort+0x54/0xa8
> el1_abort+0x3c/0x5c
> el1h_64_sync_handler+0x40/0xcc
> el1h_64_sync+0x7c/0x80
> mt76_rx_poll_complete+0x280/0x470
> mt76_dma_rx_poll+0x114/0x51c
> mt792x_poll_rx+0x60/0xf8
> napi_threaded_poll_loop+0xe0/0x450
> napi_threaded_poll+0x80/0x9c
> kthread+0x11c/0x158
> ret_from_fork+0x10/0x20
>

This patch causes a build error:

  mt76x02_mac.c: In function =E2=80=98mt76x02_mac_process_rx=E2=80=99:
  mt76x02_mac.c:804:15: error: =E2=80=98struct mt76_rx_status=E2=80=99 has =
no member
named =E2=80=98wcid=E2=80=99
    804 |         status->wcid =3D mt76x02_rx_get_sta_wcid(sta, unicast);
        |               ^~

Please update the mt76x02 RX path as well, since mt76_rx_status no
longer carries a cached wcid pointer.

Also, after dropping the union:

  struct mt76_rx_status {
-       union {
-               struct mt76_wcid *wcid;
                u16 wcid_idx;
-       };
  };

wcid_idx should be shifted left by one tab to match the surrounding
structure indentation.

The underlying issue looks critical for mt76. The KASAN report shows a
use-after-free in mt76_rx_poll_complete() caused by keeping a stale WCID
pointer after the STA has already been removed. Using wcid_idx and doing
the WCID lookup under RCU is the right direction.

Please also add a proper Fixes tag and Cc stable, so this can be
backported to stable kernels.

> Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/agg-rx.c   | 18 ++++---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 47 ++++++++-----------
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  7 ++-
>  .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 ++-
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 19 +++++---
>  .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 +-
>  .../wireless/mediatek/mt76/mt76_connac_mac.c  | 12 ++++-
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 16 +++++--
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 13 +++--
>  .../net/wireless/mediatek/mt76/mt7925/mac.c   | 19 +++++---
>  .../net/wireless/mediatek/mt76/mt7996/mac.c   | 29 ++++++++----
>  11 files changed, 114 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wi=
reless/mediatek/mt76/agg-rx.c
> index bf1babac3895..b72d13975466 100644
> --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
> +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> @@ -116,14 +116,15 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
>  }
>
>  static void
> -mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
> +mt76_rx_aggr_check_ctl(struct mt76_dev *dev, struct sk_buff *skb,
> +                      struct sk_buff_head *frames)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
>         struct ieee80211_bar *bar =3D mt76_skb_get_hdr(skb);
> -       struct mt76_wcid *wcid =3D status->wcid;
>         struct mt76_rx_tid *tid;
> -       u8 tidno;
> +       struct mt76_wcid *wcid;
>         u16 seqno;
> +       u8 tidno;
>
>         if (!ieee80211_is_ctl(bar->frame_control))
>                 return;
> @@ -131,6 +132,10 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct s=
k_buff_head *frames)
>         if (!ieee80211_is_back_req(bar->frame_control))
>                 return;
>
> +       wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);
> +       if (!wcid)
> +               return;
> +
>         status->qos_ctl =3D tidno =3D le16_to_cpu(bar->control) >> 12;
>         seqno =3D IEEE80211_SEQ_TO_SN(le16_to_cpu(bar->start_seq_num));
>         tid =3D rcu_dereference(wcid->aggr[tidno]);
> @@ -145,10 +150,11 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct =
sk_buff_head *frames)
>         spin_unlock_bh(&tid->lock);
>  }
>
> -void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *fram=
es)
> +void mt76_rx_aggr_reorder(struct mt76_dev *dev, struct sk_buff *skb,
> +                         struct sk_buff_head *frames)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
> -       struct mt76_wcid *wcid =3D status->wcid;
> +       struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx)=
;
>         struct ieee80211_sta *sta;
>         struct mt76_rx_tid *tid;
>         bool sn_less;
> @@ -164,7 +170,7 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct=
 sk_buff_head *frames)
>
>         if (!status->aggr) {
>                 if (!(status->flag & RX_FLAG_8023))
> -                       mt76_rx_aggr_check_ctl(skb, frames);
> +                       mt76_rx_aggr_check_ctl(dev, skb, frames);
>                 return;
>         }
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index 4ae5e4715a9c..2933b29782d3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -1283,21 +1283,24 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_b=
uff *skb,
>         memcpy(status->chain_signal, mstat.chain_signal,
>                sizeof(mstat.chain_signal));
>
> -       if (mstat.wcid) {
> -               status->link_valid =3D mstat.wcid->link_valid;
> -               status->link_id =3D mstat.wcid->link_id;
> -       }
> +       if (mstat.wcid_idx !=3D MT76_WCID_IDX_INVALID) {
> +               struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, mstat.wci=
d_idx);
>
> -       *sta =3D wcid_to_sta(mstat.wcid);
> +               if (wcid) {
> +                       status->link_valid =3D wcid->link_valid;
> +                       status->link_id =3D wcid->link_id;
> +                       *sta =3D wcid_to_sta(wcid);
> +               }
> +       }
>         *hw =3D mt76_phy_hw(dev, mstat.phy_idx);
>  }
>
>  static void
> -mt76_check_ccmp_pn(struct sk_buff *skb)
> +mt76_check_ccmp_pn(struct mt76_dev *dev, struct sk_buff *skb)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
> -       struct mt76_wcid *wcid =3D status->wcid;
>         struct ieee80211_hdr *hdr;
> +       struct mt76_wcid *wcid;
>         int security_idx;
>         int ret;
>
> @@ -1307,6 +1310,7 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
>         if (status->flag & RX_FLAG_ONLY_MONITOR)
>                 return;
>
> +       wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);
>         if (!wcid || !wcid->rx_check_pn)
>                 return;
>
> @@ -1354,7 +1358,7 @@ static void
>  mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,
>                     int len)
>  {
> -       struct mt76_wcid *wcid =3D status->wcid;
> +       struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx)=
;
>         struct ieee80211_rx_status info =3D {
>                 .enc_flags =3D status->enc_flags,
>                 .rate_idx =3D status->rate_idx,
> @@ -1382,19 +1386,9 @@ mt76_airtime_report(struct mt76_dev *dev, struct m=
t76_rx_status *status,
>  static void
>  mt76_airtime_flush_ampdu(struct mt76_dev *dev)
>  {
> -       struct mt76_wcid *wcid;
> -       int wcid_idx;
> -
>         if (!dev->rx_ampdu_len)
>                 return;
>
> -       wcid_idx =3D dev->rx_ampdu_status.wcid_idx;
> -       if (wcid_idx < ARRAY_SIZE(dev->wcid))
> -               wcid =3D rcu_dereference(dev->wcid[wcid_idx]);
> -       else
> -               wcid =3D NULL;
> -       dev->rx_ampdu_status.wcid =3D wcid;
> -
>         mt76_airtime_report(dev, &dev->rx_ampdu_status, dev->rx_ampdu_len=
);
>
>         dev->rx_ampdu_len =3D 0;
> @@ -1405,7 +1399,7 @@ static void
>  mt76_airtime_check(struct mt76_dev *dev, struct sk_buff *skb)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
> -       struct mt76_wcid *wcid =3D status->wcid;
> +       struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx)=
;
>
>         if (!(dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME))
>                 return;
> @@ -1418,8 +1412,6 @@ mt76_airtime_check(struct mt76_dev *dev, struct sk_=
buff *skb)
>
>                 if (!ether_addr_equal(hdr->addr1, dev->phy.macaddr))
>                         return;
> -
> -               wcid =3D NULL;
>         }
>
>         if (!(status->flag & RX_FLAG_AMPDU_DETAILS) ||
> @@ -1430,7 +1422,6 @@ mt76_airtime_check(struct mt76_dev *dev, struct sk_=
buff *skb)
>                 if (!dev->rx_ampdu_len ||
>                     status->ampdu_ref !=3D dev->rx_ampdu_ref) {
>                         dev->rx_ampdu_status =3D *status;
> -                       dev->rx_ampdu_status.wcid_idx =3D wcid ? wcid->id=
x : 0xff;
>                         dev->rx_ampdu_ref =3D status->ampdu_ref;
>                 }
>
> @@ -1448,7 +1439,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff=
 *skb)
>         struct ieee80211_hdr *hdr =3D mt76_skb_get_hdr(skb);
>         struct ieee80211_sta *sta;
>         struct ieee80211_hw *hw;
> -       struct mt76_wcid *wcid =3D status->wcid;
> +       struct mt76_wcid *wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx)=
;
>         u8 tidno =3D status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
>         bool ps;
>
> @@ -1456,8 +1447,10 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buf=
f *skb)
>         if (ieee80211_is_pspoll(hdr->frame_control) && !wcid &&
>             !(status->flag & RX_FLAG_8023)) {
>                 sta =3D ieee80211_find_sta_by_ifaddr(hw, hdr->addr2, NULL=
);
> -               if (sta)
> -                       wcid =3D status->wcid =3D (struct mt76_wcid *)sta=
->drv_priv;
> +               if (sta) {
> +                       wcid =3D (struct mt76_wcid *)sta->drv_priv;
> +                       status->wcid_idx =3D wcid->idx;
> +               }
>         }
>
>         mt76_airtime_check(dev, skb);
> @@ -1521,7 +1514,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct =
sk_buff_head *frames,
>         while ((skb =3D __skb_dequeue(frames)) !=3D NULL) {
>                 struct sk_buff *nskb =3D skb_shinfo(skb)->frag_list;
>
> -               mt76_check_ccmp_pn(skb);
> +               mt76_check_ccmp_pn(dev, skb);
>                 skb_shinfo(skb)->frag_list =3D NULL;
>                 mt76_rx_convert(dev, skb, &hw, &sta);
>                 ieee80211_rx_list(hw, sta, skb, &list);
> @@ -1563,7 +1556,7 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, en=
um mt76_rxq_id q,
>                     mt76_npu_device_active(dev))
>                         __skb_queue_tail(&frames, skb);
>                 else
> -                       mt76_rx_aggr_reorder(skb, &frames);
> +                       mt76_rx_aggr_reorder(dev, skb, &frames);
>         }
>
>         mt76_rx_complete(dev, &frames, napi);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 527bef97e122..fd449298fb11 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -364,6 +364,7 @@ enum mt76_wcid_flags {
>  };
>
>  #define MT76_N_WCIDS 1088
> +#define MT76_WCID_IDX_INVALID          0xffff
>  #define MT76_BEACON_MON_MAX_MISS       7
>
>  /* stored in ieee80211_tx_info::hw_queue */
> @@ -728,10 +729,7 @@ struct mt76_mmio {
>  };
>
>  struct mt76_rx_status {
> -       union {
> -               struct mt76_wcid *wcid;
>                 u16 wcid_idx;
> -       };
>
>         u32 reorder_time;
>
> @@ -1793,7 +1791,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct =
sk_buff_head *frames,
>                       struct napi_struct *napi);
>  void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
>                            struct napi_struct *napi);
> -void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *fram=
es);
> +void mt76_rx_aggr_reorder(struct mt76_dev *dev, struct sk_buff *skb,
> +                         struct sk_buff_head *frames);
>  void mt76_testmode_tx_pending(struct mt76_phy *phy);
>  void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
>                             struct mt76_queue_entry *e);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7603/mac.c
> index d3110eeb45d7..aeb890df808e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> @@ -513,6 +513,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_=
buff *skb)
>         u32 rxd2 =3D le32_to_cpu(rxd[2]);
>         bool unicast =3D rxd1 & MT_RXD1_NORMAL_U2M;
>         bool insert_ccmp_hdr =3D false;
> +       struct mt76_wcid *wcid;
>         bool remove_pad;
>         int idx;
>         int i;
> @@ -524,7 +525,8 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_=
buff *skb)
>         i >>=3D 1;
>
>         idx =3D FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
> -       status->wcid =3D mt7603_rx_get_wcid(dev, idx, unicast);
> +       wcid =3D mt7603_rx_get_wcid(dev, idx, unicast);
> +       status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;
>
>         status->band =3D sband->band;
>         if (i < sband->n_channels)
> @@ -672,7 +674,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_=
buff *skb)
>         }
>
>         hdr =3D (struct ieee80211_hdr *)skb->data;
> -       if (!status->wcid || !ieee80211_is_data_qos(hdr->frame_control))
> +       if (!wcid || !ieee80211_is_data_qos(hdr->frame_control))
>                 return 0;
>
>         status->aggr =3D unicast &&
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index ce0051468501..84be00a13930 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -246,17 +246,20 @@ static void mt7615_mac_fill_tm_rx(struct mt7615_phy=
 *phy, __le32 *rxv)
>  }
>
>  /* The HW does not translate the mac header to 802.3 for mesh point */
> -static int mt7615_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_g=
ap)
> +static int mt7615_reverse_frag0_hdr_trans(struct mt7615_dev *dev,
> +                                         struct sk_buff *skb, u16 hdr_ga=
p)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
>         struct ethhdr *eth_hdr =3D (struct ethhdr *)(skb->data + hdr_gap)=
;
> -       struct mt7615_sta *msta =3D (struct mt7615_sta *)status->wcid;
>         __le32 *rxd =3D (__le32 *)skb->data;
>         struct ieee80211_sta *sta;
>         struct ieee80211_vif *vif;
>         struct ieee80211_hdr hdr;
> +       struct mt7615_sta *msta;
>         u16 frame_control;
>
> +       msta =3D (struct mt7615_sta *)mt76_wcid_ptr(dev, status->wcid_idx=
);
> +
>         if (le32_get_bits(rxd[1], MT_RXD1_NORMAL_ADDR_TYPE) !=3D
>             MT_RXD1_NORMAL_U2M)
>                 return -EINVAL;
> @@ -335,6 +338,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev,=
 struct sk_buff *skb)
>         struct ieee80211_supported_band *sband;
>         struct ieee80211_hdr *hdr;
>         struct mt7615_phy *phy2;
> +       struct mt76_wcid *wcid;
>         __le32 *rxd =3D (__le32 *)skb->data;
>         u32 rxd0 =3D le32_to_cpu(rxd[0]);
>         u32 rxd1 =3D le32_to_cpu(rxd[1]);
> @@ -378,12 +382,13 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *de=
v, struct sk_buff *skb)
>
>         unicast =3D (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) =3D=3D MT_RXD1_NORM=
AL_U2M;
>         idx =3D FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
> -       status->wcid =3D mt7615_rx_get_wcid(dev, idx, unicast);
> +       wcid =3D mt7615_rx_get_wcid(dev, idx, unicast);
> +       status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;
>
> -       if (status->wcid) {
> +       if (wcid) {
>                 struct mt7615_sta *msta;
>
> -               msta =3D container_of(status->wcid, struct mt7615_sta, wc=
id);
> +               msta =3D container_of(wcid, struct mt7615_sta, wcid);
>                 mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
>         }
>
> @@ -590,7 +595,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev,=
 struct sk_buff *skb)
>
>         hdr_gap =3D (u8 *)rxd - skb->data + 2 * remove_pad;
>         if (hdr_trans && ieee80211_has_morefrags(fc)) {
> -               if (mt7615_reverse_frag0_hdr_trans(skb, hdr_gap))
> +               if (mt7615_reverse_frag0_hdr_trans(dev, skb, hdr_gap))
>                         return -EINVAL;
>                 hdr_trans =3D false;
>         } else {
> @@ -638,7 +643,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev,=
 struct sk_buff *skb)
>                 status->flag |=3D RX_FLAG_8023;
>         }
>
> -       if (!status->wcid || !ieee80211_is_data_qos(fc))
> +       if (!wcid || !ieee80211_is_data_qos(fc))
>                 return 0;
>
>         status->aggr =3D unicast &&
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index 51423c7740bd..d9ae8d204442 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -448,7 +448,8 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *de=
v, struct mt76_wcid *wcid,
>  void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
>                                          struct sk_buff *skb,
>                                          __le32 *rxv, u32 mode);
> -int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
> +int mt76_connac2_reverse_frag0_hdr_trans(struct mt76_dev *dev,
> +                                        struct ieee80211_vif *vif,
>                                          struct sk_buff *skb, u16 hdr_off=
set);
>  int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
>                                   struct mt76_rx_status *status,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mac.c
> index 0339e2e7ab60..376d59d517cc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -952,7 +952,8 @@ void mt76_connac2_mac_decode_he_radiotap(struct mt76_=
dev *dev,
>  EXPORT_SYMBOL_GPL(mt76_connac2_mac_decode_he_radiotap);
>
>  /* The HW does not translate the mac header to 802.3 for mesh point */
> -int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
> +int mt76_connac2_reverse_frag0_hdr_trans(struct mt76_dev *dev,
> +                                        struct ieee80211_vif *vif,
>                                          struct sk_buff *skb, u16 hdr_off=
set)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
> @@ -960,6 +961,7 @@ int mt76_connac2_reverse_frag0_hdr_trans(struct ieee8=
0211_vif *vif,
>         __le32 *rxd =3D (__le32 *)skb->data;
>         struct ieee80211_sta *sta;
>         struct ieee80211_hdr hdr;
> +       struct mt76_wcid *wcid;
>         u16 frame_control;
>
>         if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=3D
> @@ -969,7 +971,13 @@ int mt76_connac2_reverse_frag0_hdr_trans(struct ieee=
80211_vif *vif,
>         if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
>                 return -EINVAL;
>
> -       sta =3D container_of((void *)status->wcid, struct ieee80211_sta, =
drv_priv);
> +       wcid =3D __mt76_wcid_ptr(dev, status->wcid_idx);
> +       if (!wcid)
> +               return -EINVAL;
> +
> +       sta =3D container_of((void *)wcid, struct ieee80211_sta, drv_priv=
);
> +       if (!sta)
> +               return -EINVAL;
>
>         /* store the info from RXD and ethhdr to avoid being overridden *=
/
>         frame_control =3D le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index cec2c4208255..30672713323f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -280,6 +280,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb,
>         u8 mode =3D 0, qos_ctl =3D 0;
>         struct mt7915_sta *msta =3D NULL;
>         u32 csum_status =3D *(u32 *)skb->cb;
> +       struct mt76_wcid *wcid;
>         bool hdr_trans;
>         u16 hdr_gap;
>         u16 seq_ctrl =3D 0;
> @@ -313,10 +314,13 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct s=
k_buff *skb,
>
>         unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_R=
XD3_NORMAL_U2M;
>         idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
> -       status->wcid =3D mt7915_rx_get_wcid(dev, idx, unicast);
>
> -       if (status->wcid) {
> -               msta =3D container_of(status->wcid, struct mt7915_sta, wc=
id);
> +       wcid =3D mt7915_rx_get_wcid(dev, idx, unicast);
> +
> +       status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;
> +
> +       if (wcid) {
> +               msta =3D container_of(wcid, struct mt7915_sta, wcid);
>                 mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
>         }
>
> @@ -475,7 +479,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb,
>
>                 vif =3D container_of((void *)msta->vif, struct ieee80211_=
vif,
>                                    drv_priv);
> -               err =3D mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hd=
r_gap);
> +               err =3D mt76_connac2_reverse_frag0_hdr_trans(&dev->mt76, =
vif,
> +                                                          skb, hdr_gap);
>                 if (err)
>                         return err;
>
> @@ -532,7 +537,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb,
>         if (rxv && mode >=3D MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLA=
G_8023))
>                 mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv,=
 mode);
>
> -       if (!status->wcid || !ieee80211_is_data_qos(fc))
> +       if (status->wcid_idx =3D=3D MT76_WCID_IDX_INVALID ||
> +           !ieee80211_is_data_qos(fc))
>                 return 0;
>
>         status->aggr =3D unicast &&
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 03b4960db73f..59c64b951678 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -184,6 +184,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)
>         u32 rxd4 =3D le32_to_cpu(rxd[4]);
>         struct mt792x_sta *msta =3D NULL;
>         struct mt792x_link_sta *mlink;
> +       struct mt76_wcid *wcid;
>         u16 seq_ctrl =3D 0;
>         __le16 fc =3D 0;
>         u8 mode =3D 0;
> @@ -211,10 +212,11 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct s=
k_buff *skb)
>         chfreq =3D FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
>         unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_R=
XD3_NORMAL_U2M;
>         idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
> -       status->wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);
> +       wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);
> +       status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;
>
> -       if (status->wcid) {
> -               mlink =3D container_of(status->wcid, struct mt792x_link_s=
ta, wcid);
> +       if (wcid) {
> +               mlink =3D container_of(wcid, struct mt792x_link_sta, wcid=
);
>                 msta =3D container_of(mlink, struct mt792x_sta, deflink);
>                 mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
>         }
> @@ -395,7 +397,8 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)
>
>                 vif =3D container_of((void *)msta->vif, struct ieee80211_=
vif,
>                                    drv_priv);
> -               err =3D mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hd=
r_gap);
> +               err =3D mt76_connac2_reverse_frag0_hdr_trans(&dev->mt76, =
vif,
> +                                                          skb, hdr_gap);
>                 if (err)
>                         return err;
>
> @@ -433,7 +436,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)
>         if (rxv && mode >=3D MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLA=
G_8023))
>                 mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv,=
 mode);
>
> -       if (!status->wcid || !ieee80211_is_data_qos(fc))
> +       if (!wcid || !ieee80211_is_data_qos(fc))
>                 return 0;
>
>         status->aggr =3D unicast && !ieee80211_is_qos_nullfunc(fc);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mac.c
> index c47bd812b66b..e429f78596e2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> @@ -166,17 +166,20 @@ void mt7925_mac_set_fixed_rate_table(struct mt792x_=
dev *dev,
>  }
>
>  /* The HW does not translate the mac header to 802.3 for mesh point */
> -static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_g=
ap)
> +static int mt7925_reverse_frag0_hdr_trans(struct mt792x_dev *dev,
> +                                         struct sk_buff *skb, u16 hdr_ga=
p)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
>         struct ethhdr *eth_hdr =3D (struct ethhdr *)(skb->data + hdr_gap)=
;
> -       struct mt792x_sta *msta =3D (struct mt792x_sta *)status->wcid;
>         __le32 *rxd =3D (__le32 *)skb->data;
>         struct ieee80211_sta *sta;
>         struct ieee80211_vif *vif;
>         struct ieee80211_hdr hdr;
> +       struct mt792x_sta *msta;
>         u16 frame_control;
>
> +       msta =3D (struct mt792x_sta *)mt76_wcid_ptr(dev, status->wcid_idx=
);
> +
>         if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=3D
>             MT_RXD3_NORMAL_U2M)
>                 return -EINVAL;
> @@ -368,6 +371,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)
>         u32 rxd3 =3D le32_to_cpu(rxd[3]);
>         u32 rxd4 =3D le32_to_cpu(rxd[4]);
>         struct mt792x_link_sta *mlink;
> +       struct mt76_wcid *wcid;
>         u8 mode =3D 0; /* , band_idx; */
>         u16 seq_ctrl =3D 0;
>         __le16 fc =3D 0;
> @@ -392,10 +396,11 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct s=
k_buff *skb)
>         chfreq =3D FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
>         unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_R=
XD3_NORMAL_U2M;
>         idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
> -       status->wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);
> +       wcid =3D mt792x_rx_get_wcid(dev, idx, unicast);
> +       status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;
>
> -       if (status->wcid) {
> -               mlink =3D container_of(status->wcid, struct mt792x_link_s=
ta, wcid);
> +       if (wcid) {
> +               mlink =3D container_of(wcid, struct mt792x_link_sta, wcid=
);
>                 mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
>         }
>
> @@ -545,7 +550,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)
>
>         hdr_gap =3D (u8 *)rxd - skb->data + 2 * remove_pad;
>         if (hdr_trans && ieee80211_has_morefrags(fc)) {
> -               if (mt7925_reverse_frag0_hdr_trans(skb, hdr_gap))
> +               if (mt7925_reverse_frag0_hdr_trans(dev, skb, hdr_gap))
>                         return -EINVAL;
>                 hdr_trans =3D false;
>         } else {
> @@ -608,7 +613,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_=
buff *skb)
>                 }
>         }
>
> -       if (!status->wcid || !ieee80211_is_data_qos(fc))
> +       if (!wcid || !ieee80211_is_data_qos(fc))
>                 return 0;
>
>         status->aggr =3D unicast && !ieee80211_is_qos_nullfunc(fc);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index e2a83da3a09c..98c30957dd76 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -186,17 +186,19 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *=
dev)
>  }
>
>  /* The HW does not translate the mac header to 802.3 for mesh point */
> -static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_g=
ap)
> +static int mt7996_reverse_frag0_hdr_trans(struct mt7996_dev *dev,
> +                                         struct sk_buff *skb, u16 hdr_ga=
p)
>  {
>         struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb->c=
b;
>         struct ethhdr *eth_hdr =3D (struct ethhdr *)(skb->data + hdr_gap)=
;
> -       struct mt7996_sta_link *msta_link =3D (void *)status->wcid;
> -       struct mt7996_sta *msta =3D msta_link->sta;
> +       struct mt76_wcid *wcid =3D mt76_wcid_ptr(dev, status->wcid_idx);
> +       struct mt7996_sta_link *msta_link;
>         struct ieee80211_bss_conf *link_conf;
>         __le32 *rxd =3D (__le32 *)skb->data;
>         struct ieee80211_sta *sta;
>         struct ieee80211_vif *vif;
>         struct ieee80211_hdr hdr;
> +       struct mt7996_sta *msta;
>         u16 frame_control;
>
>         if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=3D
> @@ -206,10 +208,16 @@ static int mt7996_reverse_frag0_hdr_trans(struct sk=
_buff *skb, u16 hdr_gap)
>         if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
>                 return -EINVAL;
>
> +       if (!wcid)
> +               return -EINVAL;
> +
> +       msta_link =3D container_of(wcid, struct mt7996_sta_link, wcid);
> +       msta =3D msta_link->sta;
> +
>         if (!msta || !msta->vif)
>                 return -EINVAL;
>
> -       sta =3D wcid_to_sta(status->wcid);
> +       sta =3D wcid_to_sta(wcid);
>         vif =3D container_of((void *)msta->vif, struct ieee80211_vif, drv=
_priv);
>         link_conf =3D rcu_dereference(vif->link_conf[msta_link->wcid.link=
_id]);
>         if (!link_conf)
> @@ -429,6 +437,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_=
rxq_id q,
>         bool unicast, insert_ccmp_hdr =3D false;
>         u8 remove_pad, amsdu_info, band_idx;
>         u8 mode =3D 0, qos_ctl =3D 0;
> +       struct mt76_wcid *wcid;
>         bool hdr_trans;
>         u16 hdr_gap;
>         u16 seq_ctrl =3D 0;
> @@ -461,12 +470,14 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt7=
6_rxq_id q,
>
>         unicast =3D FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) =3D=3D MT_R=
XD3_NORMAL_U2M;
>         idx =3D FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
> -       status->wcid =3D mt7996_rx_get_wcid(dev, idx, band_idx);
>
> -       if (status->wcid) {
> +       wcid =3D mt7996_rx_get_wcid(dev, idx, band_idx);
> +       status->wcid_idx =3D wcid ? wcid->idx : MT76_WCID_IDX_INVALID;
> +
> +       if (wcid) {
>                 struct mt7996_sta_link *msta_link;
>
> -               msta_link =3D container_of(status->wcid, struct mt7996_st=
a_link,
> +               msta_link =3D container_of(wcid, struct mt7996_sta_link,
>                                          wcid);
>                 msta =3D msta_link->sta;
>                 mt76_wcid_add_poll(&dev->mt76, &msta_link->wcid);
> @@ -620,7 +631,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_=
rxq_id q,
>
>         hdr_gap =3D (u8 *)rxd - skb->data + 2 * remove_pad;
>         if (hdr_trans && ieee80211_has_morefrags(fc)) {
> -               if (mt7996_reverse_frag0_hdr_trans(skb, hdr_gap))
> +               if (mt7996_reverse_frag0_hdr_trans(dev, skb, hdr_gap))
>                         return -EINVAL;
>                 hdr_trans =3D false;
>         } else {
> @@ -697,7 +708,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_=
rxq_id q,
>                 }
>         }
>
> -       if (!status->wcid || !ieee80211_is_data_qos(fc) || hw_aggr)
> +       if (!wcid || !ieee80211_is_data_qos(fc) || hw_aggr)
>                 return 0;
>
>         status->aggr =3D unicast &&
> --
> 2.45.2
>
>

