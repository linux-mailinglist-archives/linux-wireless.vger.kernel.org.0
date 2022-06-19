Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63381550D03
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jun 2022 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiFSUnH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Jun 2022 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiFSUnG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Jun 2022 16:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA97271C
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 13:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B748361267
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 20:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B3C34114;
        Sun, 19 Jun 2022 20:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655671385;
        bh=q+e3hh6ai4q+2BuiozRk1STtRoybst3SWcNqCb0qUSY=;
        h=From:To:Cc:Subject:Date:From;
        b=B//NVPPrGO3XzDzA9gZ1Y4AN7E/vk9sKAWRaDPBw2LkOdmrS8pqH1hk5HWGhVSJ82
         PVcFNTBpxOWK8YyQzRyGPvacPJMbdGxTon8txQ4X64GaSawzb6uQmq4NLQbitwA8ZA
         4DOjCLX4Hjj3oKEmJqm+Wsku9SURLxZmtR2q6n0r6okP+crnYn6BgV2zKBeifb0tLU
         5+PaW0LKzx2JMqD8HrCpy4C4lnz3RBOIFh1q1uYL1rJ+9124vXX/ofkrkaOAavD5zM
         UjTE0TjDVI8L3dy8lFnIs6R2mEqypDG9+8qtxwRP59uGEjDYNsOdyfF1zBFEcEmFP+
         j/Wli95leUgLQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH 0/6] mt76: move connac txp code in shared module
Date:   Sun, 19 Jun 2022 22:42:35 +0200
Message-Id: <cover.1655649421.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   4 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 102 ++------------
 16 files changed, 257 insertions(+), 447 deletions(-)

-- 
2.36.1

