Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD83FADAB
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhH2STB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 14:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhH2STB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 14:19:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA46C061575
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 11:18:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m18so12300927lfl.10
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6qpYKHPZ3o/6p8b4HBCXmyZQFDSVexANicwSr1f3zk8=;
        b=RlAWJQuCVBr9KMnjgUj1FsKOb96EzNnNe2t9pCuakhoG0MdwkX3EAKB3YLTm9B7FqN
         tItSf69UF731foIENk9yrnavs5JQ6u1T+uEGeN2372v64vfO+CSeoqiFZBVJ3d6Caerk
         qSCxf4HwXwmVpOeTMf4MVxjBQn+NXyktB+FeIGrRD4m3LBjHv0xK4DsR/EzxoBGcppqa
         avZCdNep2R74Q9alizkMgPOUo2IjxaiFPck2qgMr4nMIiqNwBX3oFTzO/5wRCj4XwCZF
         bBEU4+CyhLtS3m+sGE/OXGZOf1IJXoqPuZZFnmmBwUT5fU2XDs6LrqPqvYgv3lmkMHru
         bHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6qpYKHPZ3o/6p8b4HBCXmyZQFDSVexANicwSr1f3zk8=;
        b=O4QdzWC7OBgXjW1Ll7NR8FVnziXQ+NaFmQvEfSArJgCbwmWRp4yuH/Wz4GMOifUHy8
         aNCRyhUSYpemjUaggJEX9I616b8tRhJmGffs2K1cD7f5f+omLAiG2/0u5dxzcsX6zrvv
         c1f3cbg8wkpGW5fvsObXz/AHbTaf5SdujhlBgWIUSYQ2cTY+1EL45/3dydaTbE2C/wwL
         qEB6FK3VtrJ7cYMmTkf3VGZ8AHu5WXrTUZKnZak2WiMjLQMffboJnNVkXy1DOT7+GlPI
         8o405d2fF7qCqrv0oZuTRZYeD4n+0fCM3nby3NNVfGrPeX1T7a/akhQXEAtbNRW20HNR
         CMEA==
X-Gm-Message-State: AOAM530bwZ7NyX3C3fwF4NAiJaZLahCtqVyFaEkvvEesFWOzFcVdkES3
        m+ziDoqs9RoaBrKMYO7ORvfV2X2Ql0V7eyUJv7Kl6piD+14=
X-Google-Smtp-Source: ABdhPJypPc6jKFpj69MIcXiza9jRjFIUmH/9BI56NY738+KegFGwan3WXZ4i2Tb1BVjKJ/RLkWEmazpvEoBNn7CkrW0=
X-Received: by 2002:a05:6512:3b9b:: with SMTP id g27mr462557lfv.556.1630261086691;
 Sun, 29 Aug 2021 11:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210820203531.20706-1-greearb@candelatech.com>
In-Reply-To: <20210820203531.20706-1-greearb@candelatech.com>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Sun, 29 Aug 2021 20:17:55 +0200
Message-ID: <CAFED-j=wek6cuX5wFeTKZFPJZ-hdQ+OoJsf-FKEwtpm49U30Qw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mt76: mt7915: fix STA mode connection on DFS channels
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Rubio Lu <Rubio-DW.Lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

pt., 20 sie 2021 o 22:37 <greearb@candelatech.com> napisa=C5=82(a):
>
> From: Ben Greear <greearb@candelatech.com>
>
> Only AP, adhoc and mesh mode needs to check CAC.
> Stations, in particular, do not need this check.
>
> Signed-off-by: Rubio Lu <Rubio-DW.Lu@mediatek.com>
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> v3:  Fix typo in SOB in 1/2, fix rebase typo in 2/2,
>   split long line in 2/2
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 8747e452e114..a6e142d27b60 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -2455,6 +2455,32 @@ static int mt7915_dfs_start_radar_detector(struct =
mt7915_phy *phy)
>         return 0;
>  }
>
> +struct mt7915_vif_counts {
> +       u32 mesh;
> +       u32 adhoc;
> +       u32 ap;
> +};
> +
> +static void
> +mt7915_vif_counts(void *priv, u8 *mac, struct ieee80211_vif *vif)
> +{
> +       struct mt7915_vif_counts *counts =3D priv;
> +
> +       switch (vif->type) {
> +       case NL80211_IFTYPE_ADHOC:
> +               counts->adhoc++;
> +               break;
> +       case NL80211_IFTYPE_MESH_POINT:
> +               counts->mesh++;
> +               break;
> +       case NL80211_IFTYPE_AP:
> +               counts->ap++;
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
>  static int
>  mt7915_dfs_init_radar_specs(struct mt7915_phy *phy)
>  {
> @@ -2495,6 +2521,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_ph=
y *phy)
>         struct mt7915_dev *dev =3D phy->dev;
>         bool ext_phy =3D phy !=3D &dev->phy;
>         int err;
> +       struct mt7915_vif_counts counts =3D {0};
>
>         if (dev->mt76.region =3D=3D NL80211_DFS_UNSET) {
>                 phy->dfs_state =3D -1;
> @@ -2519,9 +2546,14 @@ int mt7915_dfs_init_radar_detector(struct mt7915_p=
hy *phy)
>         phy->dfs_state =3D chandef->chan->dfs_state;
>
>         if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
> -               if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE)
> -                       return mt7915_dfs_start_radar_detector(phy);
> -
> +               if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE) =
{
> +                       ieee80211_iterate_active_interfaces(phy->mt76->hw=
,
> +                               IEEE80211_IFACE_ITER_RESUME_ALL,
> +                               mt7915_vif_counts, &counts);
> +                       if (counts.ap + counts.adhoc + counts.mesh)
> +                               mt7915_dfs_start_radar_detector(phy);
> +                       return 0;
> +               }
>                 return mt7915_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
>                                           MT_RX_SEL0, 0);
>         }
> --
> 2.20.1
>

This depends on spec interpretation - when we have multiple ifaces on
the same radio/channel (STA + APs).
Maybe this is good time to start discussion about it - how we handle
DFS and if we should improve.

Some vendors "derive" CAC from STA.
So, while STA don't need to run CAC and first VIF sta will be
connected on DFS channel, assume don't need to run CAC for second,
third ... AP VIF. Still required ISM (In service monitoring, radar
detection if AP ifaces) but simple skip CAC. This simplify
implementation a lot for multi-vif (STA+APs) case.

So, maybe we should/could add kconfig for that - CONFIG_DFS_DERIVE_STA_CAC.
When set, we could simple set NL80211_DFS_AVAILABLE when STA will
connect on DFS channel - then any other APs we will add on the same
channel will not require CAC, radar detection still required.


Regarding STA connection on DFS channel, I agree - today MT76x have a
bug for that (eg. single VIF station).
I have much older code and fix it simplest way I could.

--- a/mt7615/mac.c
+++ b/mt7615/mac.c
@@ -2034,6 +2034,11 @@ static int mt7615_dfs_start_radar_detect
  phy->rdd_state |=3D BIT(1);
  }

+   /* end CAC - upper layer will care about it, lock tx, beacon setup */
+   err =3D mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy, MT_RX_SEL0, 0);
+   if (err < 0)
+       return err;
+
  return 0;
 }

@@ -2104,11 +2109,7 @@ int mt7615_dfs_init_radar_detector(struc
  phy->dfs_state =3D chandef->chan->dfs_state;

  if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
-   if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE)
-     return mt7615_dfs_start_radar_detector(phy);
-
-   return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
-   MT_RX_SEL0, 0);
+   return mt7615_dfs_start_radar_detector(phy);
  }

 stop:

BR
Janusz
