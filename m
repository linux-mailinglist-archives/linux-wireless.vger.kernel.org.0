Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83D4D87D0
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbiCNPMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242377AbiCNPME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 11:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4943EF5
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 08:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0600161277
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 15:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD82C340E9;
        Mon, 14 Mar 2022 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647270651;
        bh=7R/zaik3KG886DXjov4eTtkyArdUyZgzK5qTyMuQdpw=;
        h=From:To:Cc:Subject:Date:From;
        b=pxfBs0HyFTH5YJpaQoY/LZJPWeOh2XZuO8aluzNK/+JUeVvViRICehWVeusf/IY9B
         g7pZqupK2ZSeK4h4Bai7WHFF/iMhnRk9NUVYHumYKJ35qzMi3BN9DqmtJ+x2vDrunB
         ks41daNRpxko28AojdCCAyIyMFl8GLfgSk0sxGJNrhZ8khVQgRkZrLkCWzrdiKoawl
         SYd29BCFHZ0mTwNUPMaEVQcFzT9b68t6viZUkhVL5EHsDzmW4VTr9vTTUZH15l4mU5
         iOvFb3yXWbbZoT8rl4j2Sd20nLqCyiig16eFcYB/isZlnPjOqNn91AY5XR25nT4iSx
         SqZry4bhGK2pQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 0/9] introduce mt7921u driver
Date:   Mon, 14 Mar 2022 16:10:22 +0100
Message-Id: <cover.1647270525.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for MT7921U 802.11ax 2x2:2SS wireless devices.

Changes since v4:
- Rebase on top of mt76 master

Changes since v3:
- Fix compilation error

Changes since v2:
- implemented full reset support in mt7921u_mac_reset routine

Changes since v1:
- implement wfsys reset support
- fixed power on procedure
- fixed module unload

Lorenzo Bianconi (9):
  mt76: usb: add req_type to ___mt76u_rr signature
  mt76: usb: add req_type to ___mt76u_wr signature
  mt76: usb: introduce __mt76u_init utility routine
  mt76: mt7921: disable runtime pm for usb
  mt76: mt7921: update mt7921_skb_add_usb_sdio_hdr to support usb
  mt76: mt7921: move mt7921_usb_sdio_tx_prepare_skb in common mac code
  mt76: mt7921: move mt7921_usb_sdio_tx_complete_skb in common mac code.
  mt76: mt7921: move mt7921_usb_sdio_tx_status_data in mac common code.
  mt76: mt7921: add mt7921u driver

 drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  68 +++-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |  11 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |   6 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  12 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  91 ++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   1 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   3 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  36 ++-
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  50 ++-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   6 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  83 -----
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 305 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   | 252 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/usb.c      | 125 +++----
 19 files changed, 874 insertions(+), 195 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c

-- 
2.35.1

