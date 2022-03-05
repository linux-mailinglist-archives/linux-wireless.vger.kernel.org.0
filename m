Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1794CE58C
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Mar 2022 16:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiCEPjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Mar 2022 10:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiCEPjh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Mar 2022 10:39:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358723BEF
        for <linux-wireless@vger.kernel.org>; Sat,  5 Mar 2022 07:38:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 865B6CE02C1
        for <linux-wireless@vger.kernel.org>; Sat,  5 Mar 2022 15:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A070C004E1;
        Sat,  5 Mar 2022 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646494723;
        bh=zxvHvr27s0mGN1RkZiqCVZJvjw0t85N6ds69F5b781A=;
        h=From:To:Cc:Subject:Date:From;
        b=iN4nFl3fetdvAK6cdPAC/4tBC31SsH5HdXHwfVr7xsbAvQ0ncP4FrZnG0QjP+dKXs
         xL5Rj+q2v86I4S73oE77VS+N1MyH/kvR58t+FMi6I29vyoK0xFVOnGlzlb5IJ6DY+E
         w9rfkqI9KE20rfLsSBBHsFatnZIqSmRlrUESFU2UWTUhAd49jxwcnsxWk0xbNktylE
         62jAu31KCEgneMJxRjJUNLeyuhj07XHTxeqvx1xdNaTvT/on0Q/olN9hfXVtKpSxA4
         i+VSp4Ca01LP8fgmv8tkb2x1jHsvfEltTML9tQkuRtyaT+CdAbcf2uptyML/LLNWDm
         fQUc2i4JAN11w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/9] introduce mt7921u driver
Date:   Sat,  5 Mar 2022 16:38:10 +0100
Message-Id: <cover.1646494452.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for MT7921U 802.11ax 2x2:2SS wireless devices.

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
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  34 +-
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  50 ++-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   6 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  83 -----
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 304 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   | 195 +++++++++++
 drivers/net/wireless/mediatek/mt76/usb.c      | 125 +++----
 19 files changed, 814 insertions(+), 195 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c

-- 
2.35.1

