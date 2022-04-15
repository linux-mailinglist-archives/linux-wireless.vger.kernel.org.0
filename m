Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865C5028C3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Apr 2022 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiDOLS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Apr 2022 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241828AbiDOLS0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Apr 2022 07:18:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD2101E6
        for <linux-wireless@vger.kernel.org>; Fri, 15 Apr 2022 04:15:54 -0700 (PDT)
X-UUID: 8dfdb75e29ba459a91564ab4f8383ad0-20220415
X-UUID: 8dfdb75e29ba459a91564ab4f8383ad0-20220415
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 114709593; Fri, 15 Apr 2022 19:15:49 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Apr 2022 19:15:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Apr
 2022 19:15:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 19:15:47 +0800
Message-ID: <9188cd3d7463cb8fc65c741bd07de817d0e60f6f.camel@mediatek.com>
Subject: Re: [PATCH v2] mt76: mt7915: add debugfs knob for RF registers
 read/write
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Date:   Fri, 15 Apr 2022 19:15:47 +0800
In-Reply-To: <c8662170-bf59-06df-a78c-8fb24303f274@nbd.name>
References: <20220415061444.30720-1-shayne.chen@mediatek.com>
         <c8662170-bf59-06df-a78c-8fb24303f274@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-04-15 at 10:26 +0200, Felix Fietkau wrote:
> On 15.04.22 08:14, Shayne Chen wrote:
> > Add RF registers read/write support for debugging RF issues, which
> > should be processed by mcu commands.
> > 
> > Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> > Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> 
> What's the required width of rf_sel and rf_ofs? Would both fit
> together 
> in a single u32? If so, you could just use the generic regidx
> debugfs 
> file for both and simply add a rf_regval debugfs file.
> 
> - Felix

Hi Felix,

FW use the WF sel (antenna 0-3) and offset to locate rf registers.
I'll send an update patch to merge them in the generic regidx with
wf sel [31:28] and offset [27:0].

Thanks,
Shayne

