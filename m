Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFC53F9C7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiFGJ3n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 05:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbiFGJ3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 05:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF48A05F
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 02:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD72360C93
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 09:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ECFC34119;
        Tue,  7 Jun 2022 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654594134;
        bh=EkbpqkyORa0DmyjNAP00MPTuJ8sJ/auTt/F5bHY5KSo=;
        h=From:To:Cc:Subject:Date:From;
        b=hT+iXLJfmZT48gulURYC8Q877tdf5XYt/hVMdF/Dm89dCIPP0s/gB3DPxKL4EktIh
         tjSbXFAgwF1Npp0jWvTvtzMW2aD4++bXV9cZ5AoLNZ2d73/itk1GOIIk5e/NIOitvH
         wzaozNuhkHGIS6CFJEhjc/OkzGKp+BkndcgN4gmfK1eYxSmXOncqs4Ju+s/7fm8uJ/
         c3IkxLqOfc3P7c/Qg8V4mlPSMB/xHAmsIz02oYvvM4sBJd276WRRro6gtD8ggAmEal
         Beyu9PcKNnsYMmpkLBvER5E1yrnKdmJQTo8ClmCD9V256A3/n9sYPR20H0+Joy7MBM
         iHPJAKM3ImxsA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 0/5] move connac2 shared txwi code in connac module
Date:   Tue,  7 Jun 2022 11:28:36 +0200
Message-Id: <cover.1654593918.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series allow reusing connac2 txwi code in mt7921 and mt7915 driver.

Lorenzo Bianconi (5):
  mt76: mt7921: rely on mt76_dev in mt7921_mac_write_txwi signature
  mt76: mt7915: rely on mt76_dev in mt7915_mac_write_txwi signature
  mt76: connac: move mac connac2 defs in mt76_connac2_mac.h
  mt76: connac: move connac2_mac_write_txwi in mt76_connac module
  mt76: connac: move mt76_connac2_mac_add_txs_skb in connac module

 .../net/wireless/mediatek/mt76/mt76_connac.h  |   9 +
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 167 +++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 406 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 386 +----------------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 142 +-----
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   6 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  17 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 335 +--------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 123 +-----
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   4 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  15 -
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |   4 +-
 13 files changed, 607 insertions(+), 1009 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h

-- 
2.35.3

