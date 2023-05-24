Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71C70F8E6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjEXOjx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjEXOjr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 10:39:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885A995
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 07:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FFA863207
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 14:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F4DC433D2;
        Wed, 24 May 2023 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684939185;
        bh=5sohExesRk0Xvu2NQdw8JmPO62vr3vkY+lj47W6W9P8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZoqPeQ7PKpAtkwtgd1wm3ojqBMxcmMsxEM20x6/DpHHuo9QvgRKMoCM6G4r1fRZ2n
         bQhV6IbnrWpnrpGow+cyOqfimgkHWW91w/CUEAv93kaNK+lZEu6W0brCaIqXtNsOqJ
         zG7Uy9I0oz+cutLxMC234RH+W9K1+8XGo2PsP1d8/8UdA9ujAfxl/y6+uqyis6lXJv
         eB30AI4SSkJdGv32Qw0OpegIjmg3WJMypNElGAMr8wsM11UOrQCCZm4SHqCXtXgp6f
         YELExF0q8+FYKVfzNBhylaqRTw5s4LzPeVY9mm4//m+bb7kDKrCfoNSTokSr5OYEHJ
         +jLvpzrYvBcnA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        nbd@nbd.name
Subject: [PATCH wireless] wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll
Date:   Wed, 24 May 2023 16:39:32 +0200
Message-Id: <48b23404b759de4f1db2ef85975c72a4aeb1097c.1684938695.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Grab sta_poll_lock spinlock in mt7615_mac_sta_poll routine in order to
avoid possible races with mt7615_mac_add_txs() or mt7615_mac_fill_rx()
removing msta pointer from sta_poll_list.

Fixes: a621372a04ac ("mt76: mt7615: rework mt7615_mac_sta_poll for usb code")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index da1d17b73a25..64002484ccad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -914,7 +914,10 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
 					poll_list);
+
+		spin_lock_bh(&dev->sta_poll_lock);
 		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
-- 
2.40.1

