Return-Path: <linux-wireless+bounces-32121-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNFIBIO7nGlSKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32121-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 21:41:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2BA17D096
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 21:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6674E31425E4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7E372B41;
	Mon, 23 Feb 2026 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1Jn2oJ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE603783C4
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879146; cv=none; b=mYLsEBh9lCBqiTKjvrZo7sZzUUHHUJYWNy4CcWVNAT1d8Nj9fn2n5nfZKpSjGynPyrdwYfOeewVf0H19ytgL9jwUJzMsLrcCiJalRprVIhzDp0YNzzNMoz2phXLNvrRPFQGFUapnSJCKxL4+lP3vs8rX7j9ZPXRDzT5mRcGUVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879146; c=relaxed/simple;
	bh=hL/6x1Kqita+RzwUr2VHF7ZNf04bupJ7cpMWCE5IWK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoesGcJUf9ram1UpNywPFgKFYyRuEqSAs6EP3Ta0ox59lArwHP9dGi4klxME7IlCbck0aU8apRfuG9FYxH1lKtqXw8xJ9gwNiC1ai6AJmL4g/0Q5dPW3S7e3Fs1n6kUtqMOp1fOhyYxa7H7FhqpE1TthLxcZ73TRqvHR2Ur+T2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1Jn2oJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9D4C19421
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771879146;
	bh=hL/6x1Kqita+RzwUr2VHF7ZNf04bupJ7cpMWCE5IWK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O1Jn2oJ1+Ta4ZL0OQbsYNg7XgXEqiHMHSFveAHYtLHIgeK86kBigLn+Ys7tbGMP+C
	 hr3ZEcz1o/mTbpA11N2xFB0WS1OEYQpCw0DZdDmDptMEmtA2ZSwxROrBdlwU5DGqgB
	 viVEMTNgH27VRzymOw2Rnsej6UawzKvCtEHjvmeodwDXZq1pEfhuYv/P7ul3TZlVOX
	 5B2CpEl5Iyx9nNE+kuxZVxLFymgevdxPf+07p9/rQFoz5rEf7ftuWtQc8g+8K0FQ65
	 7dH5XCdOgJspB9vo2v8NiHqB9igloId7S1y2wGShHZmAQpEkGAsjmPlwk2Gl5XmpHG
	 RqGgLoHGUQ5vQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38709888abeso40424681fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:39:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4KS/viulziVsh/y5SidZJskdRTWK9DoUQ0WbahtW7APYuAIbitwk/AEmqM0jTIMjoBFu0DNbj/imC/bnUbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEoQs/0oeD/+6GrecMN5hb8wa1ASV7bjAdgZRpwh6LR0b0r/u
	YoyTNPA9etULcgeUUnvc6mxibo6p9Hv3da5IccWDzZyY0l2/2tLsyTU7sw1EMMcFE776XsioAPp
	c9+O5QugML5uF3dB+6VJQz2M0pRRFGZg=
X-Received: by 2002:a2e:bc08:0:b0:382:56ff:5207 with SMTP id
 38308e7fff4ca-389a5e9020dmr30499801fa.36.1771879144493; Mon, 23 Feb 2026
 12:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223073854.2464232-1-jb.tsai@mediatek.com>
In-Reply-To: <20260223073854.2464232-1-jb.tsai@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 23 Feb 2026 14:38:53 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrSL36mwSU=UzSBCg5Xw0Y48r27hjnS3=taKkMsYmQ=qg@mail.gmail.com>
X-Gm-Features: AaiRm529A4Sc_pv820rvngGnqJsobPKqu7AdvHubkAsbW__Tvjp3nLMWI8wdOfM
Message-ID: <CAGp9LzrSL36mwSU=UzSBCg5Xw0Y48r27hjnS3=taKkMsYmQ=qg@mail.gmail.com>
Subject: Re: [PATCH 1/5] wifi: mt76: mt7921: refactor regulatory domain
 handling to regd.[ch]
To: JB Tsai <jb.tsai@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Deren.Wu@mediatek.com, 
	Sean.Wang@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
	Leon.Yen@mediatek.com, litien.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32121-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 6F2BA17D096
X-Rspamd-Action: no action

Hi JB,

Thanks for the patch  just a small nit:

On Mon, Feb 23, 2026 at 1:40=E2=80=AFAM JB Tsai <jb.tsai@mediatek.com> wrot=
e:
>
> Move regd logic to regd.c and regd.h files
>
> Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  98 +----------------
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |   1 +
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 -
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |   1 +
>  .../net/wireless/mediatek/mt76/mt7921/regd.c  | 104 ++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7921/regd.h  |  13 +++
>  7 files changed, 121 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.h
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers=
/net/wireless/mediatek/mt76/mt7921/Makefile
> index 2ad3c1cc3779..3ef7c9c45386 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> @@ -5,7 +5,7 @@ obj-$(CONFIG_MT7921E) +=3D mt7921e.o
>  obj-$(CONFIG_MT7921S) +=3D mt7921s.o
>  obj-$(CONFIG_MT7921U) +=3D mt7921u.o
>
> -mt7921-common-y :=3D mac.o mcu.o main.o init.o debugfs.o
> +mt7921-common-y :=3D mac.o mcu.o regd.o main.o init.o debugfs.o
>  mt7921-common-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
>  mt7921e-y :=3D pci.o pci_mac.o pci_mcu.o
>  mt7921s-y :=3D sdio.o sdio_mac.o sdio_mcu.o
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 29732315af1c..1fe2f2bc3881 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -9,6 +9,7 @@
>  #include "mt7921.h"
>  #include "../mt76_connac2_mac.h"
>  #include "mcu.h"
> +#include "regd.h"
>
>  static ssize_t mt7921_thermal_temp_show(struct device *dev,
>                                         struct device_attribute *attr,
> @@ -60,103 +61,6 @@ static int mt7921_thermal_init(struct mt792x_phy *phy=
)
>         return PTR_ERR_OR_ZERO(hwmon);
>  }
>
> -static void
> -mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
> -{
> -#define IS_UNII_INVALID(idx, sfreq, efreq) \
> -       (!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >=3D (sfreq) && =
(cfreq) <=3D (efreq))
> -       struct ieee80211_supported_band *sband;
> -       struct mt76_dev *mdev =3D &dev->mt76;
> -       struct device_node *np, *band_np;
> -       struct ieee80211_channel *ch;
> -       int i, cfreq;
> -
> -       np =3D mt76_find_power_limits_node(mdev);
> -
> -       sband =3D wiphy->bands[NL80211_BAND_5GHZ];
> -       band_np =3D np ? of_get_child_by_name(np, "txpower-5g") : NULL;
> -       for (i =3D 0; i < sband->n_channels; i++) {
> -               ch =3D &sband->channels[i];
> -               cfreq =3D ch->center_freq;
> -
> -               if (np && (!band_np || !mt76_find_channel_node(band_np, c=
h))) {
> -                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> -                       continue;
> -               }
> -
> -               /* UNII-4 */
> -               if (IS_UNII_INVALID(0, 5845, 5925))
> -                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> -       }
> -
> -       sband =3D wiphy->bands[NL80211_BAND_6GHZ];
> -       if (!sband)
> -               return;
> -
> -       band_np =3D np ? of_get_child_by_name(np, "txpower-6g") : NULL;
> -       for (i =3D 0; i < sband->n_channels; i++) {
> -               ch =3D &sband->channels[i];
> -               cfreq =3D ch->center_freq;
> -
> -               if (np && (!band_np || !mt76_find_channel_node(band_np, c=
h))) {
> -                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> -                       continue;
> -               }
> -
> -               /* UNII-5/6/7/8 */
> -               if (IS_UNII_INVALID(1, 5925, 6425) ||
> -                   IS_UNII_INVALID(2, 6425, 6525) ||
> -                   IS_UNII_INVALID(3, 6525, 6875) ||
> -                   IS_UNII_INVALID(4, 6875, 7125))
> -                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> -       }
> -}
> -
> -void mt7921_regd_update(struct mt792x_dev *dev)
> -{
> -       struct mt76_dev *mdev =3D &dev->mt76;
> -       struct ieee80211_hw *hw =3D mdev->hw;
> -       struct wiphy *wiphy =3D hw->wiphy;
> -
> -       mt7921_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
> -       mt7921_regd_channel_update(wiphy, dev);
> -       mt76_connac_mcu_set_channel_domain(hw->priv);
> -       mt7921_set_tx_sar_pwr(hw, NULL);
> -}
> -EXPORT_SYMBOL_GPL(mt7921_regd_update);
> -
> -static void
> -mt7921_regd_notifier(struct wiphy *wiphy,
> -                    struct regulatory_request *request)
> -{
> -       struct ieee80211_hw *hw =3D wiphy_to_ieee80211_hw(wiphy);
> -       struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> -       struct mt76_connac_pm *pm =3D &dev->pm;
> -
> -       memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2=
));
> -       dev->mt76.region =3D request->dfs_region;
> -       dev->country_ie_env =3D request->country_ie_env;
> -
> -       if (request->initiator =3D=3D NL80211_REGDOM_SET_BY_USER) {
> -               if (dev->mt76.alpha2[0] =3D=3D '0' && dev->mt76.alpha2[1]=
 =3D=3D '0')
> -                       wiphy->regulatory_flags &=3D ~REGULATORY_COUNTRY_=
IE_IGNORE;
> -               else
> -                       wiphy->regulatory_flags |=3D REGULATORY_COUNTRY_I=
E_IGNORE;
> -       }
> -
> -       if (pm->suspended)
> -               return;
> -
> -       dev->regd_in_progress =3D true;
> -
> -       mt792x_mutex_acquire(dev);
> -       mt7921_regd_update(dev);
> -       mt792x_mutex_release(dev);
> -
> -       dev->regd_in_progress =3D false;
> -       wake_up(&dev->wait);
> -}
> -
>  int mt7921_mac_init(struct mt792x_dev *dev)
>  {
>         int i;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 42b9514e04e7..00ca3d3f3ef0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <net/ipv6.h>
>  #include "mt7921.h"
> +#include "regd.h"
>  #include "mcu.h"
>
>  static int
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index ad92af98e314..5239ea970d24 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -246,7 +246,6 @@ mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 m=
ask, u32 val)
>  #define mt7921_l1_set(dev, addr, val)  mt7921_l1_rmw(dev, addr, 0, val)
>  #define mt7921_l1_clear(dev, addr, val)        mt7921_l1_rmw(dev, addr, =
val, 0)
>
> -void mt7921_regd_update(struct mt792x_dev *dev);
>  int mt7921_mac_init(struct mt792x_dev *dev);
>  bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
>  int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 65c7fe671137..a173a61f2b49 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -12,6 +12,7 @@
>  #include "../mt76_connac2_mac.h"
>  #include "../dma.h"
>  #include "mcu.h"
> +#include "regd.h"
>
>  static const struct pci_device_id mt7921_pci_device_table[] =3D {
>         { PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961),
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regd.c
> new file mode 100644
> index 000000000000..6e6c81189222
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: ISC */

Please align the SPDX identifier in the new files with mt76
(BSD-3-Clause-Clear).

> +/* Copyright (C) 2025 MediaTek Inc. */
> +
> +#include <linux/of_net.h>
> +#include <linux/of.h>

linux/of.h should be sufficient here; we can drop linux/of_net.h.

> +#include "mt7921.h"
> +#include "regd.h"
> +#include "mcu.h"
> +
> +static void
> +mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
> +{
> +#define IS_UNII_INVALID(idx, sfreq, efreq) \
> +       (!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >=3D (sfreq) && =
(cfreq) <=3D (efreq))
> +       struct ieee80211_supported_band *sband;
> +       struct mt76_dev *mdev =3D &dev->mt76;
> +       struct device_node *np, *band_np;
> +       struct ieee80211_channel *ch;
> +       int i, cfreq;
> +
> +       np =3D mt76_find_power_limits_node(mdev);
> +
> +       sband =3D wiphy->bands[NL80211_BAND_5GHZ];
> +       band_np =3D np ? of_get_child_by_name(np, "txpower-5g") : NULL;
> +       for (i =3D 0; i < sband->n_channels; i++) {
> +               ch =3D &sband->channels[i];
> +               cfreq =3D ch->center_freq;
> +
> +               if (np && (!band_np || !mt76_find_channel_node(band_np, c=
h))) {
> +                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> +                       continue;
> +               }
> +
> +               /* UNII-4 */
> +               if (IS_UNII_INVALID(0, 5845, 5925))
> +                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> +       }
> +
> +       sband =3D wiphy->bands[NL80211_BAND_6GHZ];
> +       if (!sband)
> +               return;
> +
> +       band_np =3D np ? of_get_child_by_name(np, "txpower-6g") : NULL;
> +       for (i =3D 0; i < sband->n_channels; i++) {
> +               ch =3D &sband->channels[i];
> +               cfreq =3D ch->center_freq;
> +
> +               if (np && (!band_np || !mt76_find_channel_node(band_np, c=
h))) {
> +                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> +                       continue;
> +               }
> +
> +               /* UNII-5/6/7/8 */
> +               if (IS_UNII_INVALID(1, 5925, 6425) ||
> +                   IS_UNII_INVALID(2, 6425, 6525) ||
> +                   IS_UNII_INVALID(3, 6525, 6875) ||
> +                   IS_UNII_INVALID(4, 6875, 7125))
> +                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> +       }
> +}
> +
> +void mt7921_regd_update(struct mt792x_dev *dev)
> +{
> +       struct mt76_dev *mdev =3D &dev->mt76;
> +       struct ieee80211_hw *hw =3D mdev->hw;
> +       struct wiphy *wiphy =3D hw->wiphy;
> +
> +       mt7921_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
> +       mt7921_regd_channel_update(wiphy, dev);
> +       mt76_connac_mcu_set_channel_domain(hw->priv);
> +       mt7921_set_tx_sar_pwr(hw, NULL);
> +}
> +EXPORT_SYMBOL_GPL(mt7921_regd_update);
> +
> +void mt7921_regd_notifier(struct wiphy *wiphy,
> +                         struct regulatory_request *request)
> +{
> +       struct ieee80211_hw *hw =3D wiphy_to_ieee80211_hw(wiphy);
> +       struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> +       struct mt76_connac_pm *pm =3D &dev->pm;
> +
> +       memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2=
));
> +       dev->mt76.region =3D request->dfs_region;
> +       dev->country_ie_env =3D request->country_ie_env;
> +
> +       if (request->initiator =3D=3D NL80211_REGDOM_SET_BY_USER) {
> +               if (dev->mt76.alpha2[0] =3D=3D '0' && dev->mt76.alpha2[1]=
 =3D=3D '0')
> +                       wiphy->regulatory_flags &=3D ~REGULATORY_COUNTRY_=
IE_IGNORE;
> +               else
> +                       wiphy->regulatory_flags |=3D REGULATORY_COUNTRY_I=
E_IGNORE;
> +       }
> +
> +       if (pm->suspended)
> +               return;
> +
> +       dev->regd_in_progress =3D true;
> +
> +       mt792x_mutex_acquire(dev);
> +       mt7921_regd_update(dev);
> +       mt792x_mutex_release(dev);
> +
> +       dev->regd_in_progress =3D false;
> +       wake_up(&dev->wait);
> +}

Looks good to me this is a straight move of the code with no extra
logic changes.

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regd.h
> new file mode 100644
> index 000000000000..0ba6161e1919
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: ISC */

Please align the SPDX identifier in the new files with mt76
(BSD-3-Clause-Clear).

> +/* Copyright (C) 2025 MediaTek Inc. */
> +
> +#ifndef __MT7921_REGD_H
> +#define __MT7921_REGD_H
> +
> +#include "mt7921.h"
> +

I guess regd.h shouldn=E2=80=99t rely on indirect includes for struct
regulatory_request; please forward-declare it or include the proper
header.

> +void mt7921_regd_update(struct mt792x_dev *dev);
> +void mt7921_regd_notifier(struct wiphy *wiphy,
> +                         struct regulatory_request *request);
> +
> +#endif
> --
> 2.45.2
>
>

