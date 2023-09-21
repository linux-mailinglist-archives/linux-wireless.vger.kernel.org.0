Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD867A9B73
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjIUTBg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjIUTBL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9AC80F85
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:36:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2DC32791;
        Thu, 21 Sep 2023 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695291839;
        bh=yEMCuP75RzU26/gJYkkF862Cbk6QqqQc4KgA55rLPV8=;
        h=From:To:Cc:Subject:Date:From;
        b=iR/1+ySnpN42QF9VbVkqFkj0hhrMu5F5iOFfdQRBkzLdj8ECUPNybKkdGlZ7H5Pd0
         LHBc0EOXBDMHNMUCne2QH0HkzX1f2UV/iwSb7f5ySkRRxGDVrDTT3gM4QXNPB+hJmx
         bqZ0+nhHh+Zlsh0AGkDFQwhfadPE4OSlsbmJq/M1gAZTONHXvLz2gvY3LPs1d4254L
         HuJ7W0uA6TdWRtuPgMgTPwXk8KJN7EVD7O+GYFZKhVThR5qXwu+59pqwEtJm5jZtPe
         W6SuTiluEhLf9apJECwMucPC/sRoTzOrJlCI/+l/xc1xDWm+dX27I+zT1pPCBSgsSd
         tE9MbxAGwmA2A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 0/2] wifi: mt76: mt792xu: some more code de-duplication
Date:   Thu, 21 Sep 2023 12:23:46 +0200
Message-ID: <cover.1695291565.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove some more usb duplicated code shared between mt7921 and mt7925

Lorenzo Bianconi (2):
  wifi: mt76: mt792x: move mt7921_skb_add_usb_sdio_hdr in mt792x module
  wifi: mt76: mt792x: move some common usb code in mt792x module

 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 21 +-----------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 17 --------------
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 12 ++--------
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 20 +----------------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 16 --------------
 .../net/wireless/mediatek/mt76/mt7925/usb.c   | 12 ++--------
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 18 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 22 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt792x_usb.c   |  9 ++++++++
 12 files changed, 58 insertions(+), 95 deletions(-)

-- 
2.41.0

