Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37133705950
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEPVMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEPVMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 17:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2651121;
        Tue, 16 May 2023 14:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363996152E;
        Tue, 16 May 2023 21:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9438FC4339B;
        Tue, 16 May 2023 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684271564;
        bh=4oFLEnl0a2bIlQpjNOZADDV91S2n86nKB82b9Gotd80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aSSeGSsG7+7SznPyod2HGPe6C9oZxltvyIklDc857d2M3V3E8pKsH3g98p3u2L8mj
         LKnGavzI2YWOJS9YSdqh9nSKmS+VT0xVcWK3MoLixDvaquwEm6fgGsLKu+18vzBROo
         5711d3q0ZyZAq9M30o+W8OrDW0stN+3adOmgR6+yD/TGNKKVdik3Ve2zlCVBLIGoBu
         8VNIGN5Lkd+HIker5YznfrBMtr62QjiiwWqJj1tRWss/1a0BNM4j0rBSXNBtIA9lYi
         0D2YIKf3rHUVQ3NWh7/bsnLT3uxp1Itmb86PKNZ+4ThWNIQPYwtGR9r0c/CNMlyopZ
         epu1pks/OSs5g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f18dfe3016so13312e87.0;
        Tue, 16 May 2023 14:12:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzn7tfykssdhf+/2Mgsh6daNj93k7t+Qn8KFTbNx1N7cQiw/fSu
        GnqNSO8hPLArlPVZ/1s8ug3gp1pTPRSjapMLhn4=
X-Google-Smtp-Source: ACHHUZ4xBMwSNcX4bBfMWz3Eoz4UQxAYE67D0kLIINM3mF3VBhuaSgz/8qOugH7daWzI6E9AqNBBHA0uWoMuDS/Jeg8=
X-Received: by 2002:ac2:5fc4:0:b0:4ef:ed0f:c604 with SMTP id
 q4-20020ac25fc4000000b004efed0fc604mr128295lfg.2.1684271562518; Tue, 16 May
 2023 14:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <b45ef06de62ce4f02d35ecef26ba78c7a7e75b51.1684153148.git.deren.wu@mediatek.com>
In-Reply-To: <b45ef06de62ce4f02d35ecef26ba78c7a7e75b51.1684153148.git.deren.wu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 16 May 2023 14:12:30 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpncPiFPgDEv51+JoDE6LMQ69Uvh584o+fcdJWVSpMdrw@mail.gmail.com>
Message-ID: <CAGp9LzpncPiFPgDEv51+JoDE6LMQ69Uvh584o+fcdJWVSpMdrw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Deren

On Mon, May 15, 2023 at 7:21=E2=80=AFAM Deren Wu <deren.wu@mediatek.com> wr=
ote:
>
> txs may be dropped if the frame is aggregated in AMSDU. When the problem
> shows up, some SKBs would be hold in driver to cause network stopped
> temporarily. Even if the problem can be recovered by txs timeout handling=
,
> mt7921 still need to disable txs in AMSDU to avoid this issue.
>
> Cc: stable@vger.kernel.org
> Fixes: 182071cdd594 ("mt76: connac: move connac2_mac_write_txwi in mt76_c=
onnac module")

The patch with the identifier "182071cdd594 ("mt76: connac: move
connac2_mac_write_txwi in mt76_connac module") was merely a
refactoring patch and not the root cause of the issue. Therefore, I
believe it would be more appropriate to address and rectify the patch
"163f4d22c118 ("mt76: mt7921: add MAC support") instead. This will
ensure downstream branches are better informed about the necessary fix
and can accurately backport the patch.

> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mac.c
> index ee0fbfcd07d6..56c42ee1178c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -495,6 +495,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev=
, __le32 *txwi,
>                                     BSS_CHANGED_BEACON_ENABLED));
>         bool inband_disc =3D !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_=
RESP |
>                                          BSS_CHANGED_FILS_DISCOVERY));
> +       bool amsdu_en =3D wcid->amsdu;
>
>         if (vif) {
>                 struct mt76_vif *mvif =3D (struct mt76_vif *)vif->drv_pri=
v;
> @@ -554,12 +555,14 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *d=
ev, __le32 *txwi,
>         txwi[4] =3D 0;
>
>         val =3D FIELD_PREP(MT_TXD5_PID, pid);
> -       if (pid >=3D MT_PACKET_ID_FIRST)
> +       if (pid >=3D MT_PACKET_ID_FIRST) {
>                 val |=3D MT_TXD5_TX_STATUS_HOST;
> +               amsdu_en &=3D !is_mt7921(dev);
> +       }
>
>         txwi[5] =3D cpu_to_le32(val);
>         txwi[6] =3D 0;
> -       txwi[7] =3D wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
> +       txwi[7] =3D amsdu_en ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
>
>         if (is_8023)
>                 mt76_connac2_mac_write_txwi_8023(txwi, skb, wcid);
> --
> 2.18.0
>
