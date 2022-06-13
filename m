Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB387549BC7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbiFMSjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbiFMSiz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 14:38:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C12D36175
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 08:32:29 -0700 (PDT)
X-UUID: 22695338cf8042b99fc15bbdfc0db1f5-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:ba165584-d0b7-46a1-af76-d655c93f4229,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:f5c69037-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 22695338cf8042b99fc15bbdfc0db1f5-20220613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2068092625; Mon, 13 Jun 2022 23:32:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 13 Jun 2022 23:32:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jun 2022 23:32:24 +0800
Message-ID: <77d3ba88b76dcdb973fb078263513c595e911c14.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7921s: fix possible sdio deadlock in command
 fail
From:   Deren Wu <deren.wu@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        "Soul Huang" <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Mon, 13 Jun 2022 23:32:24 +0800
In-Reply-To: <YqcrzCbeJUg3s18b@lore-desk>
References: <7122534ce50527e099a23fa198683a0e20c6db38.1654998031.git.deren.wu@mediatek.com>
         <YqcrzCbeJUg3s18b@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-06-13 at 14:21 +0200, Lorenzo Bianconi wrote:
> > From: Deren Wu <deren.wu@mediatek.com>
> > 
> > Move sdio_release_host() to final resource handing
> > 
> > Fixes: b12deb5e86fa ("mt76: mt7921s: fix
> > mt7921s_mcu_[fw|drv]_pmctrl")
> > Reported-by: YN Chen <YN.Chen@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> > b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> > index 54a5c712a3c3..1856d677fff4 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> > @@ -156,9 +156,9 @@ int mt7921s_mcu_fw_pmctrl(struct mt7921_dev
> > *dev)
> >  
> >  	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
> >  				 !(status & WHLPCR_IS_DRIVER_OWN),
> > 2000, 1000000);
> > +err:
> >  	sdio_release_host(func);
> >  
> > -err:
> >  	if (err < 0) {
> >  		dev_err(dev->mt76.dev, "firmware own failed\n");
> >  		clear_bit(MT76_STATE_PM, &mphy->state);
> > -- 
> > 2.18.0
> > 
> 
> Hi Deren,
> 
> in order to align the code with mt7921e, can you please fold the
> following
> changes into this patch?
> 
> Regards,
> Lorenzo
> 

Hi Lore,

Sure, I will post v2 with your patch.


Thanks,
Deren

> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> @@ -135,8 +135,8 @@ int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev)
>  	struct sdio_func *func = dev->mt76.sdio.func;
>  	struct mt76_phy *mphy = &dev->mt76.phy;
>  	struct mt76_connac_pm *pm = &dev->pm;
> -	int err = 0;
>  	u32 status;
> +	int err;
>  
>  	sdio_claim_host(func);
>  
> @@ -147,7 +147,7 @@ int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev)
>  					 2000, 1000000);
>  		if (err < 0) {
>  			dev_err(dev->mt76.dev, "mailbox ACK not
> cleared\n");
> -			goto err;
> +			goto out;
>  		}
>  	}
>  
> @@ -155,18 +155,18 @@ int mt7921s_mcu_fw_pmctrl(struct mt7921_dev
> *dev)
>  
>  	err = readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
>  				 !(status & WHLPCR_IS_DRIVER_OWN),
> 2000, 1000000);
> -err:
> +out:
>  	sdio_release_host(func);
>  
>  	if (err < 0) {
>  		dev_err(dev->mt76.dev, "firmware own failed\n");
>  		clear_bit(MT76_STATE_PM, &mphy->state);
> -		err = -EIO;
> +		return -EIO;
>  	}
>  
>  	pm->stats.last_doze_event = jiffies;
>  	pm->stats.awake_time += pm->stats.last_doze_event -
>  				pm->stats.last_wake_event;
>  
> -	return err;
> +	return 0;
>  }
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

