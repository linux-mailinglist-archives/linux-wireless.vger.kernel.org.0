Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16EB7D0D2E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376894AbjJTKb7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376881AbjJTKb5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:31:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270BC114
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:31:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63496C433C9;
        Fri, 20 Oct 2023 10:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797914;
        bh=XCjwwQVr6jl38xcwubSN4H5Ycb70YzrZh+Ybb+/Y1fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8VdptcAIDN9x/prleh6Rk2Ttdbj4QJRD9eBGNi6A/Pi35CQcDpjmd+X6hFAbyFTU
         zj+Al4BIWY4XrzSvtoT4Z5znf3RZpMgtt2jRNfjarVvj4l2tYxh3NtznliUz1R/9CD
         66MRXari/71VjAulC8t7Mc4J3Ro5uPYBO8oDNqXgV2L2q/l9IzzYAeqjE4z+bx+eeH
         j84ETkqttgSRDAlo9j4MEeweEvkCzQdD1T1Zij9qy+cE9Ty5A9jiJR5ZpDZDln0yV1
         4GaO785XjOhnfhkSPGpCHT02uRwfgBCkP7PWyxh3022QG68ErcGo9FvjIenC+eZ6NB
         I3Bqxgg8x1/mg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 09/13] wifi: mt76: mt7996: use u16 for val field in mt7996_mcu_set_rro signature
Date:   Fri, 20 Oct 2023 12:30:56 +0200
Message-ID: <78b1ae679ad5555ce94cc28a0b7ef950ae7b24c8.1697797423.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697797422.git.lorenzo@kernel.org>
References: <cover.1697797422.git.lorenzo@kernel.org>
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

This is a preliminary patch to introduce WED rx support for mt7996
driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index bf917beb9439..3ecdc09323c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4019,7 +4019,7 @@ int mt7996_mcu_trigger_assert(struct mt7996_dev *dev)
 				 &req, sizeof(req), false);
 }
 
-int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val)
+int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u16 val)
 {
 	struct {
 		u8 __rsv1[4];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ccb6c5763956..d4425c133ced 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -397,7 +397,7 @@ int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
 				     struct cfg80211_chan_def *chandef);
 int mt7996_mcu_rf_regval(struct mt7996_dev *dev, u32 regidx, u32 *val, bool set);
 int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans);
-int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val);
+int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u16 val);
 int mt7996_mcu_wa_cmd(struct mt7996_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7996_mcu_fw_log_2_host(struct mt7996_dev *dev, u8 type, u8 ctrl);
 int mt7996_mcu_fw_dbg_ctrl(struct mt7996_dev *dev, u32 module, u8 level);
-- 
2.41.0

