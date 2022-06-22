Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8B555502
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 21:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354065AbiFVTrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376578AbiFVTr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 15:47:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1852C403C8
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 12:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B86BDB820E4
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 19:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C33C341C5;
        Wed, 22 Jun 2022 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655927243;
        bh=ixGQusXwM8Whu5v+N3sJXQnBQ9m1AEWK0f+o6gvJA/g=;
        h=From:To:Cc:Subject:Date:From;
        b=QlLR1p+2sjGojMpmROFy03ER0H2doMIP/qH12jppwR6go8k+dkqD87zG1Ao0fS8K1
         3hNmSFFIbqnTTcT3Zw0KG+zum0jFWkl8UAZT6hw5a4Nx03FLv51Xo3YfeuXaJd7tDt
         X6hp2/hODqsoW2QFSXFPKsUS/KiCBGFicmQAXv65UXVDuUpI7GxFAQrk2e77j1KnZV
         kpjdt15WFMfiLGj+dCPyTRSI+junlv0QLYtkaaIREPQfYoXrl5n3r+IAcQLJaiGsTK
         0qLphtckLECtPIWeTniFaTyY9jK4NXuIEca9FAsC9L1zA6PWTfmIAkLK9qZrLYb+z9
         OJn05l+nY/MaQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 0/6] mt76: move connac txp code in shared module
Date:   Wed, 22 Jun 2022 21:46:50 +0200
Message-Id: <cover.1655926989.git.lorenzo@kernel.org>
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

Move fw/hw txp code in mt76-connac module since it is shared between mt7915e,
mt7921e and mt7615 drivers. This is a preliminary series to add mt7990e chipset
support.

Changes since v1:
- fix mt7921 mt76_driver_ops txwi_size

Lorenzo Bianconi (6):
  mt76: connac: move mt76_connac_fw_txp in common module
  mt76: move mt7615_txp_ptr in mt76_connac module
  mt76: connac: move mt76_connac_tx_free in shared code
  mt76: connac: move mt76_connac_tx_complete_skb in shared code
  mt76: connac: move mt76_connac_write_hw_txp in shared code
  mt76: connac: move mt7615_txp_skb_unmap in common code

 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  63 +--------
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  69 ----------
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   4 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   3 -
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  78 +----------
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  91 ++++++++++++
 .../wireless/mediatek/mt76/mt76_connac2_mac.h |  13 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 130 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  41 +-----
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  32 -----
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   4 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  68 ---------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   5 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 102 ++------------
 16 files changed, 257 insertions(+), 448 deletions(-)

-- 
2.36.1

