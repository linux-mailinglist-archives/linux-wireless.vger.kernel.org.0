Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D9F53FA5B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiFGJwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiFGJv6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 05:51:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA8ED704
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 02:50:04 -0700 (PDT)
X-UUID: b60edb2a1d7742878ced10a201261caa-20220607
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:9616e106-317b-445f-b3bb-b1736113d0b3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:57,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:57
X-CID-META: VersionHash:2a19b09,CLOUDID:5777eee4-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:801,TC:nil,Content:3,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: b60edb2a1d7742878ced10a201261caa-20220607
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2105198642; Tue, 07 Jun 2022 17:49:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Jun 2022 17:49:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 7 Jun 2022 17:49:45 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     <lorenzo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <lorenzo.bianconi@redhat.com>,
        <nbd@nbd.name>, <ryder.lee@mediatek.com>, <sean.wang@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: Re: [PATCH 2/5] mt76: mt7921: move fw toggle in mt7921_load_firmware
Date:   Tue, 7 Jun 2022 17:49:24 +0800
Message-ID: <20220607094924.2110-1-deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <8d3f5d937138d5bb1694235cf71aeef7a28f7cd1.1654248715.git.lorenzo@kernel.org>
References: <8d3f5d937138d5bb1694235cf71aeef7a28f7cd1.1654248715.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thie series work fine in mt7921[e/u/s]

Tested-by: Deren Wu <deren.wu@mediatek.com>
