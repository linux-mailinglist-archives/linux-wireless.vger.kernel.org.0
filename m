Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54B66170AA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 23:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKBW3b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBW33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 18:29:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6782BD0
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 15:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A794B82528
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 22:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592ABC433D6;
        Wed,  2 Nov 2022 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667428165;
        bh=afZJpjssqhN+myESqpJIzgINiOVj1pLDmg+9flUgKHs=;
        h=From:To:Cc:Subject:Date:From;
        b=TSh4dUoU22A7buFnEltcN9zZ7Fg3kwnFtOQ5QiMwx4VADgThA/xov5WZCfSTPQrAA
         r6nkv/r70fZmdM1sIg8tkrKD4gp027+7qOVVenMh5LxhoOGBQ8zveX+QvZF+2RuHZO
         fIyTZOvoFsAoYIGVH7kyfXYV97SU1VUt+fOVGRvzz2SXiFHGvQ3o2tPQFzgOKbFIFu
         blv96cuncfN4oDp677NKtpnvGNauyeNu4MeOX4SwEiLyyNsENnOUXBaimo0mSlnIbj
         UST3Bo19b98+Fn+g7pPcIyGApMxSd39LarKjsIkyNT4rosUm9Lq6Rjt5hytEA5UhYe
         HTDB7nu9RFcyA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] mt76: move aggr_stats array in mt76_phy
Date:   Wed,  2 Nov 2022 23:29:13 +0100
Message-Id: <cover.1667427944.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is based on the following patches:
- wifi: mt76: mt7915: fix reporting of TX AGGR histogram
  https://patchwork.kernel.org/project/linux-wireless/patch/33a05d9d25e43fbb880bea5e1ad52c92f1ad2e27.1667392073.git.lorenzo@kernel.org/
- wifi: mt76: mt7921: fix reporting of TX AGGR histogram
  https://patchwork.kernel.org/project/linux-wireless/patch/74cf11c228e9174c5d7fd794af8967d5ce9e5de7.1667393153.git.lorenzo@kernel.org/

Lorenzo Bianconi (2):
  wifi: mt76: mt7615: rely on mt7615_phy in mt7615_mac_reset_counters
  wifi: mt76: move aggr_stats array in mt76_phy

 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++--
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +++---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  6 ++----
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 17 +++++++--------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 ++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  6 +++---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  5 ++---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 21 +++++++------------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 ++---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 10 ++++-----
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 15 files changed, 41 insertions(+), 53 deletions(-)

-- 
2.38.1

