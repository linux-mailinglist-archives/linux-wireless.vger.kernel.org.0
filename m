Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3307764484
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 05:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjG0Dlo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 23:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjG0Dlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 23:41:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871FC26A0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 20:41:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403c653d934so3018771cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 20:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690429299; x=1691034099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8Uw0vNKZE+GaqfQjiuOZc6ei5jBk5/DQtpVKaxsbKU=;
        b=RrrbR9txvZIVR9wVUunpxqqB7I4Mog+KLqZ3aJYwYz4JSZCgVFulSeYzjeYSOJgKCs
         78cqBkWHnnorU5tGbuYC+K4R3lI91JfAkB8eB4ppPqz9xZkfUVWUZxxeVerhMreaYLwR
         oMBW4LVrfb5KruWTVDWQf8Wkl4VJVorC4elC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690429299; x=1691034099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8Uw0vNKZE+GaqfQjiuOZc6ei5jBk5/DQtpVKaxsbKU=;
        b=QxI1v+F2Pj5HhoLEM5lLCu5FisagoPYbvfLZo5YqzcTsIsIxYggAHSJMQX0HXhbe7F
         PI86ME0Zk8hXnWQbRJ9BkuX9RAu5OsG0wWW2s+U5w45exAKEk/DOIfi5kugPMZsKD6bl
         d0TrTtORVeb8OJMOK1c9p7VrbT1dMEcx09YTBgfotf1n8rBNxW0jbUoJYtmoOKqX/S5h
         iGxJr+A8cB6EBxv6inUUWv3SsED76rLHnzL9ZXL8fDEg57lxWWSnW14s4sYzqMwNsIub
         hd+i/2e2Wzx11s7ajb7vEvgJVBbQw1ewFSD9FnSWRl6uvnTHfseocfTk5p4BTOWbWG/W
         vqqw==
X-Gm-Message-State: ABy/qLaR2f0UgFzJ6T3rIp2vWM9dZ8OhN9+W5ju/RWawJNoqOdgw7tLo
        5mVbS9dLAzMb7DRqDwjLfxLlq9EXrIF90vEyPUMVbw==
X-Google-Smtp-Source: APBJJlHhdsw+4kV6dQuqtaCDgKIlVDBJMknGTvNILioBeM9tyEzgr6pO2qYx/HEzM1K3BMWby3jIBA==
X-Received: by 2002:a05:6214:21ec:b0:63c:f5c0:cd14 with SMTP id p12-20020a05621421ec00b0063cf5c0cd14mr4208587qvj.49.1690429299452;
        Wed, 26 Jul 2023 20:41:39 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id c3-20020a0ce143000000b0063d32f515bbsm121302qvl.127.2023.07.26.20.41.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 20:41:39 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-403a7066bc8so3109071cf.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 20:41:39 -0700 (PDT)
X-Received: by 2002:a1f:5e43:0:b0:481:68cc:751 with SMTP id
 s64-20020a1f5e43000000b0048168cc0751mr648348vkb.13.1690429278247; Wed, 26 Jul
 2023 20:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <8fd42ac8e1c97246f6e65225a14fc8a029ac3aaa.1690232804.git.objelf@gmail.com>
In-Reply-To: <8fd42ac8e1c97246f6e65225a14fc8a029ac3aaa.1690232804.git.objelf@gmail.com>
From:   David Ruth <druth@chromium.org>
Date:   Wed, 26 Jul 2023 23:40:41 -0400
X-Gmail-Original-Message-ID: <CAKHmtrQOouchFx03NRTexru7+zh+MnvAvdRrx5Qz8Jn0EVkZ8A@mail.gmail.com>
Message-ID: <CAKHmtrQOouchFx03NRTexru7+zh+MnvAvdRrx5Qz8Jn0EVkZ8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: mt76: move struct ieee80211_chanctx_conf up to
 struct mt76_vif
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        ted.huang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, jsiuda@google.com, arowa@google.org,
        frankgor@google.com, kuabhs@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reviewed-by: David Ruth <druth@chromium.org>
Tested-by: David Ruth <druth@chromium.org>


On Mon, Jul 24, 2023 at 5:20=E2=80=AFPM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Move struct ieee80211_chanctx_conf up to struct mt76_vif to allow the
> connac2 library can access the struct ieee80211_chanctx_conf * member in
> struct mt76_vif.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c | 16 ++++++++--------
>  .../net/wireless/mediatek/mt76/mt7921/mt7921.h   |  1 -
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 878087257ea7..bf9c781ff48c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -708,6 +708,7 @@ struct mt76_vif {
>         u8 basic_rates_idx;
>         u8 mcast_rates_idx;
>         u8 beacon_rates_idx;
> +       struct ieee80211_chanctx_conf *ctx;
>  };
>
>  struct mt76_phy {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 87067ac367eb..8987173a83f2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -804,7 +804,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, stru=
ct ieee80211_vif *vif,
>
>         if (vif->type =3D=3D NL80211_IFTYPE_STATION && !sta->tdls)
>                 mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.w=
cid,
> -                                           true, mvif->ctx);
> +                                           true, mvif->mt76.ctx);
>
>         ewma_avg_signal_init(&msta->avg_ack_signal);
>
> @@ -839,7 +839,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, str=
uct ieee80211_vif *vif,
>                 if (!sta->tdls)
>                         mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
>                                                     &mvif->sta.wcid, fals=
e,
> -                                                   mvif->ctx);
> +                                                   mvif->mt76.ctx);
>         }
>
>         spin_lock_bh(&dev->mt76.sta_poll_lock);
> @@ -1638,7 +1638,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct iee=
e80211_vif *vif,
>         mt7921_mutex_acquire(dev);
>
>         err =3D mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wc=
id,
> -                                         true, mvif->ctx);
> +                                         true, mvif->mt76.ctx);
>         if (err)
>                 goto out;
>
> @@ -1670,7 +1670,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif,
>                 goto out;
>
>         mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, fals=
e,
> -                                   mvif->ctx);
> +                                   mvif->mt76.ctx);
>
>  out:
>         mt7921_mutex_release(dev);
> @@ -1695,7 +1695,7 @@ static void mt7921_ctx_iter(void *priv, u8 *mac,
>         struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
>         struct ieee80211_chanctx_conf *ctx =3D priv;
>
> -       if (ctx !=3D mvif->ctx)
> +       if (ctx !=3D mvif->mt76.ctx)
>                 return;
>
>         if (vif->type =3D=3D NL80211_IFTYPE_MONITOR)
> @@ -1728,7 +1728,7 @@ mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
>         struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
>
>         mutex_lock(&dev->mt76.mutex);
> -       mvif->ctx =3D ctx;
> +       mvif->mt76.ctx =3D ctx;
>         mutex_unlock(&dev->mt76.mutex);
>
>         return 0;
> @@ -1744,7 +1744,7 @@ mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw=
,
>         struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
>
>         mutex_lock(&dev->mt76.mutex);
> -       mvif->ctx =3D NULL;
> +       mvif->mt76.ctx =3D NULL;
>         mutex_unlock(&dev->mt76.mutex);
>  }
>
> @@ -1758,7 +1758,7 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_=
hw *hw,
>                        jiffies_to_msecs(HZ);
>
>         mt7921_mutex_acquire(dev);
> -       mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
> +       mt7921_set_roc(mvif->phy, mvif, mvif->mt76.ctx->def.chan, duratio=
n,
>                        MT7921_ROC_REQ_JOIN);
>         mt7921_mutex_release(dev);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index ec9879650174..04a9ce50cff2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -173,7 +173,6 @@ struct mt7921_vif {
>         struct ewma_rssi rssi;
>
>         struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
> -       struct ieee80211_chanctx_conf *ctx;
>  };
>
>  enum {
> --
> 2.25.1
>
