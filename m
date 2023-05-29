Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02426714811
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjE2Kli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjE2Klh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:41:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9182FC7
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D0260A5C
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395C5C433EF;
        Mon, 29 May 2023 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356895;
        bh=iRLpDNjyaG1lKppfH74GyjAmYg/O3kau8KtjTBRwgHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqUFjzbvYbqAIPxmWJK3yWeu4AjuhrehUrPo/OHSuXxATF3LOtWdGGLBEjJrX4x0L
         oLcAFIPBL5vJDDDLBqQpmDwBiBfxfUUv0xcaGItjCK1BCfvacYTIIJuPbcnOAOeXjV
         KL1xLLazbOhizDxrEzloIq8nmMSpBOOSACyIDy2HMPnx/F5kXPGylBN44eX3zifXsB
         TaTJaY42tmsvoA1zjceaRdpzHam5fo4G2szJL+s5RsHrek+DVAu0EKb5mNAjkhhCqi
         BDywFov/5pWj7EDoiMowzppXP56ql7Z5BZ+Wonw2PKSdEU8lTsCCZH13Y3i36JJ5lQ
         sd4WuUcZS5CgQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 01/13] wifi: mt76: mt7921: make mt7921_mac_sta_poll static
Date:   Mon, 29 May 2023 12:40:52 +0200
Message-Id: <a9d38dbfb85cc394bcd394379fe6fe4283e099a4.1685356673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685356673.git.lorenzo@kernel.org>
References: <cover.1685356673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make mt7921_mac_sta_poll static since it is run just in mac.c

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1675bf520481..bde73859b5da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -52,7 +52,7 @@ bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
 			 0, 5000);
 }
 
-void mt7921_mac_sta_poll(struct mt7921_dev *dev)
+static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 {
 	static const u8 ac_to_tid[] = {
 		[IEEE80211_AC_BE] = 0,
@@ -183,7 +183,6 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 		ewma_avg_signal_add(&msta->avg_ack_signal, -msta->ack_signal);
 	}
 }
-EXPORT_SYMBOL_GPL(mt7921_mac_sta_poll);
 
 static void
 mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 149acb1662d5..39d7ebba0457 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -513,7 +513,6 @@ int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 void mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
 		      struct ieee80211_sta *sta, bool clear_status,
 		      struct list_head *free_list);
-void mt7921_mac_sta_poll(struct mt7921_dev *dev);
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 
-- 
2.40.1

