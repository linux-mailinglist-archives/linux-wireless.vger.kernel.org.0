Return-Path: <linux-wireless+bounces-36932-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNklFdYWFmrOhQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36932-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:55:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5595DCFBE
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A34A302E5C3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD163C454E;
	Tue, 26 May 2026 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvySodVW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01B3C818B
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832368; cv=none; b=WP5mQul1JjOhQAFVbEmexwy1LHHgPzOgtXNdI2tsbCmaX8qXMXGtN6rZVX6Gr8uEYer44/AskedqGf70ggS8LIykDSyLYqluSx/jlGrV8jMYjr+bW0bpaNuItLZ7m9Pyhga6ysIbf4jlEygxM32TNwdnYhLd9ezW5IVEmKfqfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832368; c=relaxed/simple;
	bh=c+8/7l091quGh0H14krQlVhQZvm8FgIVDYoP3y7im1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPU8LiNNzOH16mMA5gV5ud9ly6rgD3vCYeWFY+Y2QGr5UR2EOE5OR1h3CmfNnnFQP0ZJCugdn5Hxr9osT7ZegHxc6eaOJtM28d4BXn4sTFqJpAcTb+VeSEYQzIFyyauJWEzfTPRUO1GLqKdTz3esrhVfvLUo1u0kwooUrQjr5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvySodVW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40EC1F00A3E
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832365;
	bh=vofwtLagvBRYkOYwKOjHnTeC6C87g7YP3KZhbzyhI3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JvySodVWkZ4MM3tRJ8YS99NO8G7r2QGWchQgjJs/N+v4T2fakaO4nQDdnRKzeIqTT
	 twW0FxpXffz7ntaZsc3O/ISWeFOfVsNb/x05burAQaCV9x0p4/oCBx+unOrZNDKiKH
	 l9eEs/xvzHk7ZO9LGKRzD+wyhYk/qRZhK5KF4wg+jKuzkyANdqT3/0CZ70KJQmgnhs
	 zZQSlPOBMLaWKn7O7IGnTpnQLYT/fNAPwTGi9bD8J0K1DlMF127mpbMjHwpWu/C29v
	 j8kQ4+Ada+sfRBKhvdrHvYOoaCl3yhfcJa5ke+GxzVVmXHgt06pmnxndTucORDzD0u
	 JP8bxaosMVwHg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38ea6a5a0b3so88879881fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 14:52:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mwp70fUQMNB74/DAky//DFfq30nq5/K4Qc7Yzj8wnEbtzyjjYkqL9URUATtXGUr5nErsbWZoE48+hO4UioQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxI7PMgTdU7wWD91cW+KlBe0rDnDzfOJ9p8SHm8akT5EHtVnk2
	OvR68fn7Nq0UlyDBB2Xgp1sjAquzOra2ru3WNjUiUzMrP7MoeOP8p9hkd+nFmaeBjJAOgLm7+9A
	NZAVb7EELiIBRi0rnQ40Dm67Nx1Gs58M=
X-Received: by 2002:a2e:8192:0:b0:394:2b8a:2374 with SMTP id
 38308e7fff4ca-395d8d3de65mr47969431fa.16.1779832364145; Tue, 26 May 2026
 14:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526060841.49161-1-liujiajia@kylinos.cn>
In-Reply-To: <20260526060841.49161-1-liujiajia@kylinos.cn>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 26 May 2026 16:52:32 -0500
X-Gmail-Original-Message-ID: <CAGp9LzqzddmyDHMNsaqigYpVEdo_Pmzwbeh5Ri5_Gr87cVL6Dg@mail.gmail.com>
X-Gm-Features: AVHnY4JN4XiSX6iZ8nQKBZrwSnhXgkTYMQMdyt2mZqBTxzISywSnHzHgBHOFEuo
Message-ID: <CAGp9LzqzddmyDHMNsaqigYpVEdo_Pmzwbeh5Ri5_Gr87cVL6Dg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7925: add wcid publish check in mt76_sta_add
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Michael Lo <michael.lo@mediatek.com>, 
	Leon Yen <leon.yen@mediatek.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36932-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 6F5595DCFBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, May 26, 2026 at 1:09=E2=80=AFAM Jiajia Liu <liujiajia@kylinos.cn> w=
rote:
>
> Since mt7925_mac_sta_add publishes wcid, add publish check in mt76_sta_ad=
d
> to avoid reinitializing the wcid->poll_list for mt7925.
>
> Found dev->sta_poll_list corruption when using mt7925 and 7.0-rc4.
> According to the corruption information, prev->next was changed to itself=
.
>
> wlan0: disconnect from AP 90:fb:5d:94:8b:e3 for new auth to 90:fb:5d:94:8=
b:e2
> wlan0: authenticate with 90:fb:5d:94:8b:e2 (local address=3D84:9e:56:9c:7=
e:6b)
> wlan0: send auth to 90:fb:5d:94:8b:e2 (try 1/3)
>  slab kmalloc-8k start ffff8c80958a6000 pointer offset 4160 size 8192
> list_add corruption. prev->next should be next (ffff8c808a7488f8), but wa=
s ffff8c80958a7040. (prev=3Dffff8c80958a7040).
>
>  mt76_wcid_add_poll+0x95/0xd0 [mt76]
>  mt7925_mac_add_txs.part.0+0xa5/0xe0 [mt7925_common]
>  mt7925_rx_check+0xa7/0xc0 [mt7925_common]
>  mt76_dma_rx_poll+0x50d/0x790 [mt76]
>  mt792x_poll_rx+0x52/0xe0 [mt792x_lib]
>
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>
> Reproduced and tested using the script below over ssh. Roam between two
> bssids with the same SSID on a router.
>
> #!/bin/bash
>
> set -ex
>
> while :; do
>         num=3D$(sudo iw wlan0 scan | grep Polaris | wc -l)
>         if [ $num -eq 2 ]; then
>                 break
>         fi
> done
>
> for i in $(seq 1 500); do
>
> echo "index $i"
> wpa_cli -i wlan0 roam 90:fb:5d:94:8b:e3
> sleep 5
> wpa_cli -i wlan0 roam 90:fb:5d:94:8b:e2
> sleep 5
>
> done
>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c    | 11 ++++++++---
>  drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c |  3 +++
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index 4ae5e4715a9c..83f4f941b890 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -1595,11 +1595,16 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee802=
11_vif *vif,
>                 mtxq->wcid =3D wcid->idx;
>         }
>
> -       ewma_signal_init(&wcid->rssi);
> -       rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
> +       if (!test_bit(MT_WCID_FLAG_DRV_PUBLISH, &wcid->flags)) {
> +               ewma_signal_init(&wcid->rssi);
> +               rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
> +               mt76_wcid_init(wcid, phy->band_idx);
> +       } else {
> +               wcid->phy_idx =3D phy->band_idx;
> +       }
> +
>         phy->num_sta++;
>

Thanks for spotting the roaming issue.

I think we can avoid adding MT_WCID_FLAG_DRV_PUBLISH and instead use the
WCID table itself for the publish check.

dev->wcid[] already encodes whether a WCID has been published, so checking
it directly avoids adding a second mirror state. MT_WCID_FLAG_* is also
better kept for WCID features that affect WTBL setup or data-path handling,
rather than common bookkeeping state.

Something like:

@@ -1620,6 +1620,7 @@ mt76_sta_add(struct mt76_phy *phy, struct
ieee80211_vif *vif,
{
  struct mt76_wcid *wcid =3D (struct mt76_wcid *)sta->drv_priv;
  struct mt76_dev *dev =3D phy->dev;
+       struct mt76_wcid *published;
  int ret;
  int i;

@@ -1639,7 +1640,10 @@ mt76_sta_add(struct mt76_phy *phy, struct
ieee80211_vif *vif,
          mtxq->wcid =3D wcid->idx;
  }

-       if (!test_bit(MT_WCID_FLAG_DRV_PUBLISH, &wcid->flags)) {
+       published =3D rcu_dereference_protected(dev->wcid[wcid->idx],
+                                             lockdep_is_held(&dev->mutex))=
;
+       if (published !=3D wcid) {
+               WARN_ON_ONCE(published);
                 ewma_signal_init(&wcid->rssi);
                 rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
                 mt76_wcid_init(wcid, phy->band_idx);

   ....


> -       mt76_wcid_init(wcid, phy->band_idx);
>  out:
>         mutex_unlock(&dev->mutex);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 527bef97e122..8bfce686bff7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -361,6 +361,7 @@ enum mt76_wcid_flags {
>         MT_WCID_FLAG_PS,
>         MT_WCID_FLAG_4ADDR,
>         MT_WCID_FLAG_HDR_TRANS,
> +       MT_WCID_FLAG_DRV_PUBLISH,
>  };
>
>  #define MT76_N_WCIDS 1088
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index 73d3722739d0..35b5c718475c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -1102,6 +1102,9 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struc=
t ieee80211_vif *vif,
>                                               &msta->deflink);
>         }
>
> +       if (!err)
> +               set_bit(MT_WCID_FLAG_DRV_PUBLISH, &msta->deflink.wcid.fla=
gs);
> +
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
> --
> 2.53.0
>
>

