Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE65A2037
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 07:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiHZFNg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 01:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiHZFNf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 01:13:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4085C946
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 22:13:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso3801559wmc.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 22:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Wh6FLDEnJQ0ruFSeCB7dZ0n+l2/E1h9WWj0E7OrvHN8=;
        b=gzvm+bQtE8AmMsvbkn6i37XPPtXDA1iCHae/C2j4+xAsmHS2vcozSBzu4Y0tzPlkLB
         frJAVOMQruttFHaVSU4UIT1aWUo7AfH2Ff9H0fE8ZxJIjYfx2ZQukGpsi0/EwQCS143C
         kD6saRNrvRRAy7i+99+TpMQ011lbZ9hrepoaC4v+FYOXDntQHyC0UPd1kY8r/jplXWU1
         QygyRHER5lqg45w8vGM6BUuJ+X9XRh3j1I/WrwWRystcpA+idTltyybUOuOCRsJ4QNsp
         MV5vxp9/x2Lz+8nyK5a9do0S5iruX2dTEhILARFfIaeWgEwVEt7pjePTAQ9dqY5k5rqA
         Ikrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Wh6FLDEnJQ0ruFSeCB7dZ0n+l2/E1h9WWj0E7OrvHN8=;
        b=faNH2z4O/0ibgDDrezzUv7M00KGM/zQqTMn06XxsswM29DphA1LLwdr+zsMw4XvoVQ
         EPQjCqv67PlpVYTrx+HPgGBIa2vzzyN6loLCDFHs+fOieX4Svk01TZJY+9n4VhYbsojL
         pd7YtVa6t2xdOvlkfYmZDE7CuIDKjtnkiQvpSqS/J4U7ropn1d9hJq5x3qEQ3iuTMss5
         fF10MkDB2uWrps0jB95IEW4Pw1ia37xJUM5XzcLpakPx2iCdrnQSbCCB0TS6YEjyFClY
         UerdUM/l+LJHLB0zK11eezMEm5xPPiR8G3dwajJpgzi+SR9wFXAd63CBCtraABD6INZB
         eYSA==
X-Gm-Message-State: ACgBeo1MoQvpkkRB7VRIRh69xLHU+WIvvvELatpnCgUbk+j9A/Z5dlPV
        YER3ifWX6DNxbfpajQI9wZKHSoX7WFYCjPZ8sVI=
X-Google-Smtp-Source: AA6agR7QFJk2fyWRvEx03DjqaHYun1rzfQlrmhMAnyRnD79orGEX+fPxtFvy6QAk3o0D/25is63NMgz/ewnaoA7X3Cc=
X-Received: by 2002:a05:600c:5008:b0:3a6:1cd8:570d with SMTP id
 n8-20020a05600c500800b003a61cd8570dmr4030338wmr.57.1661490812559; Thu, 25 Aug
 2022 22:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <fd716a393e20d5db89f4f9d705d6dbbfde7260a6.1661400412.git.objelf@gmail.com>
 <Ywc1srMmMu51Nuzv@lore-desk>
In-Reply-To: <Ywc1srMmMu51Nuzv@lore-desk>
From:   sean wang <objelf@gmail.com>
Date:   Thu, 25 Aug 2022 22:13:20 -0700
Message-ID: <CAGp9LzqmSyj0n__1vOhQcqt-7QXWNzia-zngqyufB4-epgBsQg@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921: reset msta->airtime_ac while clearing up hw value
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, lorenzo.bianconi@redhat.com,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        jenhao.yang@mediatek.com, Robin Chiu <robin.chiu@mediatek.com>,
        Eddie.Chen@mediatek.com, CH Yeh <ch.yeh@mediatek.com>,
        Posh Sun <posh.sun@mediatek.com>, ted.huang@mediatek.com,
        Stella Chang <Stella.Chang@mediatek.com>,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, kuabhs@google.com, druth@google.com,
        abhishekpandit@google.com, shawnku@google.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

On Thu, Aug 25, 2022 at 1:41 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > We should reset mstat->airtime_ac along with clear up the entries in the
> > hardware WLAN table for the Rx and Rx accumulative airtime. Otherwsie, the
> > value msta->airtime_ac - [tx, rx]_last may be a negative and that is not
> > the actual airtime the device took in the last run.
>
> the only point where we need it is mt7921_mac_sta_assoc() since in
> mt7921_mac_sta_add() airtime_ac array is supposed to be already 0 and in
> mt7921_mac_sta_remove() we are removing the sta. Is my understanding correct?
> If so, is it better to just add a memset(, 0, ..) in mt7921_mac_sta_assoc()?
>

The way looks good to me. I'll add in the v2. thanks!

    Sean

> Regards,
> Lorenzo
>
> >
> > Reported-by: YN Chen <YN.Chen@mediatek.com>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7921/mac.c   | 15 ++++++++++-----
> >  drivers/net/wireless/mediatek/mt76/mt7921/main.c  |  9 +++------
> >  .../net/wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
> >  3 files changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> > index 47f0aa81ab02..87dd0babff7a 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> > @@ -46,6 +46,14 @@ bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
> >                        0, 5000);
> >  }
> >
> > +void mt7921_mac_sta_airtime_clear(struct mt7921_dev *dev,
> > +                               struct mt7921_sta *msta)
> > +{
> > +     mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> > +                            MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> > +     memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
> > +}
> > +
> >  void mt7921_mac_sta_poll(struct mt7921_dev *dev)
> >  {
> >       static const u8 ac_to_tid[] = {
> > @@ -100,11 +108,8 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
> >                       addr += 8;
> >               }
> >
> > -             if (clear) {
> > -                     mt7921_mac_wtbl_update(dev, idx,
> > -                                            MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> > -                     memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
> > -             }
> > +             if (clear)
> > +                     mt7921_mac_sta_airtime_clear(dev, msta);
> >
> >               if (!msta->wcid.sta)
> >                       continue;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > index 1438a9f8d1fd..9d70884e24af 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > @@ -723,8 +723,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
> >       if (vif->type == NL80211_IFTYPE_STATION)
> >               mvif->wep_sta = msta;
> >
> > -     mt7921_mac_wtbl_update(dev, idx,
> > -                            MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> > +     mt7921_mac_sta_airtime_clear(dev, msta);
> >
> >       ret = mt7921_mcu_sta_update(dev, sta, vif, true,
> >                                   MT76_STA_INFO_STATE_NONE);
> > @@ -750,8 +749,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
> >               mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
> >                                           true);
> >
> > -     mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> > -                            MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> > +     mt7921_mac_sta_airtime_clear(dev, msta);
> >
> >       mt7921_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
> >
> > @@ -769,8 +767,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
> >       mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> >
> >       mt7921_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
> > -     mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> > -                            MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> > +     mt7921_mac_sta_airtime_clear(dev, msta);
> >
> >       if (vif->type == NL80211_IFTYPE_STATION) {
> >               struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > index c161031ac62a..8b704d08509d 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > @@ -362,6 +362,8 @@ void mt7921_stop(struct ieee80211_hw *hw);
> >  int mt7921_mac_init(struct mt7921_dev *dev);
> >  bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
> >  void mt7921_mac_reset_counters(struct mt7921_phy *phy);
> > +void mt7921_mac_sta_airtime_clear(struct mt7921_dev *dev,
> > +                               struct mt7921_sta *msta);
> >  void mt7921_mac_set_timing(struct mt7921_phy *phy);
> >  int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
> >                      struct ieee80211_sta *sta);
> > --
> > 2.25.1
> >
