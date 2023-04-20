Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E265A6E9C76
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjDTT2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjDTT2r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 15:28:47 -0400
X-Greylist: delayed 151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 12:28:44 PDT
Received: from resqmta-h1p-028596.sys.comcast.net (resqmta-h1p-028596.sys.comcast.net [IPv6:2001:558:fd02:2446::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CFF40E5
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:28:44 -0700 (PDT)
Received: from resomta-h1p-028516.sys.comcast.net ([96.102.179.207])
        by resqmta-h1p-028596.sys.comcast.net with ESMTP
        id pU8MpcmqXHswQpZv1pnw7c; Thu, 20 Apr 2023 19:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1682018771;
        bh=1DP3ECCIZRxMH/ilBqU9PIR5cGFHw51ic0tdsG11mCY=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=MD6jcyNjABpcc5YHdnE7dmfUIK3bLRPq14Rnevx1TskFh80kmh1nta2lJ8//KpmkV
         SJd0QAZ3h3EurZfRvnlkjmeJGmPSyGxwsbOD875AZRkzOzm+kX4Mi0zMSVc/cIQSbd
         HeN8r2fAYYCbwQAm4l/k05oyypnS0AI05G4XATBXPVuN70sHxQbShKqZAWGu68ceyl
         AMUyh8I163Mj+B1/l8YCy3CpRMBKDrrw4IXAPL5/8m5fXQ1Ki/wxxnVrI/GHqzQ3DL
         4PtqUiATyCTLaabZymNu66Gv/g7kAskJF+PEM6M2yiSD32CMDqx/yz+qW0WLjwJz5r
         2vCIIeZ1ckrCg==
Received: from Crushinator.home.mattwhitlock.com
 ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-h1p-028516.sys.comcast.net with ESMTPSA
        id pZudpRnagwRIepZufpF7f3; Thu, 20 Apr 2023 19:25:50 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     linux-wireless@vger.kernel.org
Cc:     Matt Whitlock <kernel@mattwhitlock.name>
Subject: [PATCH] mt76: mt7921: don't assume adequate headroom for SDIO headers
Date:   Thu, 20 Apr 2023 15:24:51 -0400
Message-Id: <20230420192451.28814-1-kernel@mattwhitlock.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921_usb_sdio_tx_prepare_skb() calls mt7921_usb_sdio_write_txwi() and
mt7921_skb_add_usb_sdio_hdr(), both of which blindly assume that
adequate headroom will be available in the passed skb. This assumption
typically is satisfied when the skb was allocated in the net core for
transmission via the mt7921 netdev (although even that is only an
optimization and is not strictly guaranteed), but the assumption is
sometimes not satisfied when the skb originated in the receive path of
another netdev and was passed through to the mt7921, such as by the
bridge layer. Blindly prepending bytes to an skb is always wrong.

This commit introduces a call to skb_cow_head() before the call to
mt7921_usb_sdio_write_txwi() in mt7921_usb_sdio_tx_prepare_skb() to
ensure that at least MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE bytes can be
pushed onto the skb.

Without this fix, I can trivially cause kernel panics by bridging an
MT7921AU-based USB 802.11ax interface with an Ethernet interface on an
Intel Atom-based x86 system using its onboard RTL8169 PCI Ethernet
adapter and also on an ARM-based Raspberry Pi 1 using its onboard
SMSC9512 USB Ethernet adapter. Note that the panics do not occur in
every system configuration, as they occur only if the receiving netdev
leaves less headroom in its received skbs than the mt7921 needs for its
SDIO headers.

Here is an example stack trace of this panic on Raspberry Pi OS Lite
2023-02-21 running kernel 6.1.24+ [1]:

 skb_panic from skb_push+0x44/0x48
 skb_push from mt7921_usb_sdio_tx_prepare_skb+0xd4/0x190 [mt7921_common]
 mt7921_usb_sdio_tx_prepare_skb [mt7921_common] from mt76u_tx_queue_skb+0x94/0x1d0 [mt76_usb]
 mt76u_tx_queue_skb [mt76_usb] from __mt76_tx_queue_skb+0x4c/0xc8 [mt76]
 __mt76_tx_queue_skb [mt76] from mt76_txq_schedule.part.0+0x13c/0x398 [mt76]
 mt76_txq_schedule.part.0 [mt76] from mt76_txq_schedule_all+0x24/0x30 [mt76]
 mt76_txq_schedule_all [mt76] from mt7921_tx_worker+0x58/0xf4 [mt7921_common]
 mt7921_tx_worker [mt7921_common] from __mt76_worker_fn+0x9c/0xec [mt76]
 __mt76_worker_fn [mt76] from kthread+0xbc/0xe0
 kthread from ret_from_fork+0x14/0x34

After this fix, bridging the mt7921 interface works fine on both of my
previously problematic systems.

[1] https://github.com/raspberrypi/firmware/tree/5c276f55a4b21345cd4d6200a504ee991851ff7a

Fixes: https://github.com/openwrt/openwrt/issues/11796
Signed-off-by: Matt Whitlock <kernel@mattwhitlock.name>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index dd1a241c45d6..72cd90829280 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1651,6 +1651,10 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
 		return -EINVAL;
 
+	err = skb_cow_head(skb, MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE);
+	if (err)
+		return err;
+
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
-- 
2.40.0

