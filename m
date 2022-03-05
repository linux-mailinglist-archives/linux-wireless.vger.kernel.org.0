Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA024CE340
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Mar 2022 07:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiCEGSJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Mar 2022 01:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEGSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Mar 2022 01:18:08 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C64182DAD
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 22:17:15 -0800 (PST)
X-UUID: ca4879053cb9453bb3fde6236149be35-20220305
X-UUID: ca4879053cb9453bb3fde6236149be35-20220305
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1602392950; Sat, 05 Mar 2022 14:17:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Mar 2022 14:17:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Mar 2022 14:17:08 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <Deren.Wu@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 0/9] introduce mt7921u driver
Date:   Sat, 5 Mar 2022 14:17:07 +0800
Message-ID: <1646461027-5374-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1646235785.git.lorenzo@kernel.org>
References: <cover.1646235785.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>Introduce support for MT7921U 802.11ax 2x2:2SS wireless devices.
>

Tested the whole series with sta and monitor mode and it is working well.

Tested-by: Sean Wang <sean.wang@mediatek.com>

>Lorenzo Bianconi (9):
>  mt76: usb: add req_type to ___mt76u_rr signature
>  mt76: usb: add req_type to ___mt76u_wr signature
>  mt76: usb: introduce __mt76u_init utility routine
>  mt76: mt7921: disable runtime pm for usb
>  mt76: mt7921: update mt7921_skb_add_usb_sdio_hdr to support usb
>  mt76: mt7921: move mt7921_usb_sdio_tx_prepare_skb in common mac code
>  mt76: mt7921: move mt7921_usb_sdio_tx_complete_skb in common mac code.
>  mt76: mt7921: move mt7921_usb_sdio_tx_status_data in mac common code.
>  mt76: mt7921: add mt7921u driver
>
> drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
> .../net/wireless/mediatek/mt76/mt7615/usb.c   |  68 ++-
> .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   2 +-
> .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   2 +-
> .../net/wireless/mediatek/mt76/mt7921/Kconfig |  11 +
> .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +
> .../wireless/mediatek/mt76/mt7921/debugfs.c   |   6 +
> .../net/wireless/mediatek/mt76/mt7921/init.c  |  12 +-
> .../net/wireless/mediatek/mt76/mt7921/mac.c   |  91 ++++
> .../net/wireless/mediatek/mt76/mt7921/mac.h   |   1 +
> .../net/wireless/mediatek/mt76/mt7921/main.c  |   3 +-
> .../wireless/mediatek/mt76/mt7921/mt7921.h    |  25 +-
> .../net/wireless/mediatek/mt76/mt7921/regs.h  |  36 +-
> .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   6 +-
> .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  83 ----
> .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   2 +-
> .../net/wireless/mediatek/mt76/mt7921/usb.c   | 397 ++++++++++++++++++
> drivers/net/wireless/mediatek/mt76/usb.c      | 125 ++----
> 18 files changed, 689 insertions(+), 195 deletions(-)  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb.c
>
>--
>2.35.1
>
>


