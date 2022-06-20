Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869E5551987
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 15:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbiFTNFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbiFTNEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 09:04:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD818B0D
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 05:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65FC0B811B8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 12:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE033C3411B;
        Mon, 20 Jun 2022 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655729976;
        bh=f5wqFKnT+WgaZ/oLNe6htYquH8ZRcfN7kQCbETQPAKM=;
        h=From:To:Cc:Subject:Date:From;
        b=fkkKD+bRxbq9hCXRDFR9SGSGV0c5Kc9IccgYc+pJmqAthy/BG2EKXi/mVrqIkLYnR
         aFob+dvON4Q0LtdTG6jE4zO2cxzafe0S3ISa3zibPIwfCpdK6qgAo/5hK4kSrb63dg
         l+tIbMGYdDsGRs8/AvFpUKwNIIqjMqq/a3sb36SlVeBh309ExO4n45PoZdfABpa8Wo
         HmNHTxsTbsrPeWQQDh+99rqzW6/WCdoPNGQxKDVX0st1q8XmNxWpT8Hwf1WXDuCLxA
         /B6l4sqgguAQ9L7O6E//jc5hJsdQmUzrmrv2m1yzIjuzgf1Y4xbaYdOwE8PLEn1TRv
         La/s9wu1fbpqg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH 0/2] mt76: move tx mcu shared code in mt76_connac
Date:   Mon, 20 Jun 2022 14:59:16 +0200
Message-Id: <cover.1655729403.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac2_mcu_fill_message routine in shared code in order to reuse
it for mt7921 and mt7915e drivers.
This is a preliminary series to add mt7990 driver support.

This series is based on the series below:
https://patchwork.kernel.org/project/linux-wireless/cover/cover.1655649421.git.lorenzo@kernel.org/

Lorenzo Bianconi (2):
  mt76: move mcu_txd/mcu_rxd structures in shared code
  mt76: move mt76_connac2_mcu_fill_message in mt76_connac module

 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   3 -
 .../wireless/mediatek/mt76/mt76_connac2_mac.h |  13 +++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  77 +++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  90 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  12 ---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  86 ++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  45 +-------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  13 ---
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 102 +++---------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  88 ---------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   2 -
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  11 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  12 ++-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  12 ++-
 16 files changed, 250 insertions(+), 322 deletions(-)

-- 
2.36.1

