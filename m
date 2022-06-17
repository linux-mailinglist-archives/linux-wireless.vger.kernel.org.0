Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6F54F446
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiFQJaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiFQJaE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 05:30:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A9C6350A
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 02:29:58 -0700 (PDT)
X-UUID: ade3e43aac924cb4a7900541e07460a7-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:10f5b955-60b8-4014-afbd-7c198ef4c72f,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.6,REQID:10f5b955-60b8-4014-afbd-7c198ef4c72f,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:b14ad71,CLOUDID:09a1a2f6-e099-41ba-a32c-13b8bfe63214,C
        OID:c79e28fbb90c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ade3e43aac924cb4a7900541e07460a7-20220617
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 468184255; Fri, 17 Jun 2022 17:29:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 17 Jun 2022 17:29:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jun 2022 17:29:52 +0800
Message-ID: <d441fbdebcf2576bd08b2ad032b4bc4d184fdccc.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7921: fix aggregation subframes setting to HE
 max
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Fri, 17 Jun 2022 17:29:52 +0800
In-Reply-To: <b7e3006a-03a9-fad6-3f57-10aed678f211@nbd.name>
References: <7f5145276d732cb4aebcbffd6fc4a5eb852dd3be.1655393246.git.deren.wu@mediatek.com>
         <b7e3006a-03a9-fad6-3f57-10aed678f211@nbd.name>
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

Hi Felix,

On Fri, 2022-06-17 at 10:39 +0200, Felix Fietkau wrote:
> On 16.06.22 17:57, Deren Wu wrote:
> > From: Deren Wu <deren.wu@mediatek.com>
> > 
> > mt7921/mt7922 support HE max aggregation subframes 256 for both
> > tx/rx.
> > Get better throughput then before.
> > 
> > Fixes: 94bb18b03d43 ("mt76: mt7921: fix max aggregation subframes
> > setting")
> > Tested-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > Reviewed-by: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> 
> When I made the change that you're reverting here, I used the values 
> from the reference SDK that I got, and the change actually seemed to 
> improve performance in my tests.
> Did something change in the firmware, or is there a related chipset 
> difference between 7921 and 7922?
> 
> - Felix
> 


Yes, there was some fw changes ready in 2021 and the SDK was updated as
well. After some performance re-check, the test result is much better
with the new patch. We think the max-size-256 can be applied in
mt7921/mt7922 driver now. 

PS: mt7921/mt7922 are the same. Both of them can support this size.

Thanks,
Deren

