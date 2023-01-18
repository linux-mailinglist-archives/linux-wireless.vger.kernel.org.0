Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA5672366
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjARQdn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjARQdA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:33:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCDA58663
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26D68618D5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 16:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0D6C433F2;
        Wed, 18 Jan 2023 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674059456;
        bh=ckxYV7+Gte3DYK4Ha9BXngdMFMgAGD7a8m/4cx2PNgM=;
        h=From:To:Cc:Subject:Date:From;
        b=m/G41H+bcwqyrSw18Sz9VfaUZnKLgb33SvyDSef/hGdYJ2ZkjtrTD/utfju0IybUQ
         i/IkRx2vHuljeOiwWo6uf4RWjcMABi2JQUq8C7O1Fe71j3YECEd0b/3S+y4xyKk6KG
         zSJbKFeWoSoiueXEBt485C4mwnv+uhJquYlPEIYZdlC3qRV4fJFSz7iY/rdlMdQ6t5
         k3XUiYcn/7KHrmiTtZAPVOTy0CdVj5ZIED9W7QEKO9GrMQLDb0deXTaxNPQSBoZ3XD
         yPffv8LmkOinwBvcYplefNSg7egJku/DXqEMSkqCkmsqPfBFa/gTWaAvPkA2WBWFuu
         EqwuZqe59ULBQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 0/4] mt76: mt7996: remove some duplicated code
Date:   Wed, 18 Jan 2023 17:30:37 +0100
Message-Id: <cover.1674059222.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove some duplicated code from mt7996 driver that is already available in
mt76_connac shared library.
Please note this series is just compiled tested.

Lorenzo Bianconi (4):
  wifi: mt76: mt7996: rely on mt76_connac_txp_common structure
  wifi: mt76: mt7996: rely on mt76_connac_txp_skb_unmap
  wifi: mt76: mt7996: rely on mt76_connac_tx_complete_skb
  wifi: mt76: mt7996: rely on mt76_connac2_mac_decode_he_radiotap

 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 240 ++----------------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  24 --
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |   4 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   1 -
 5 files changed, 20 insertions(+), 252 deletions(-)

-- 
2.39.0

