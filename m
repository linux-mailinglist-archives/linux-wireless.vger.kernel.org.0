Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D827D394
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgI2QZx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgI2QZx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 12:25:53 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C0C061755
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KMbWS4HeKhmuNHz6g+voXVj4x3iKYvyw1dmoLPy8WwM=; b=ijqDVfeDc3DrU9CFdr2KawkNMn
        FJYM1OEGoO16OsVqo0gHk8OxMNjWHW0hpgozjSgRwSt1mbYFq5nMJImG7TpxuFAcsztwDbx0Ehu1q
        WBJ2mCa0N0uIuqjyFpbb3z00FxNDl9bPkOOQgdEkkKdZg5FRGThjaZLnGUQOCkgLxlLU=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNIRr-00028J-39
        for linux-wireless@vger.kernel.org; Tue, 29 Sep 2020 18:25:51 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7915: fix DRR sta bss group index
Date:   Tue, 29 Sep 2020 18:25:49 +0200
Message-Id: <20200929162550.83724-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware/hardware supports only 16 entries. Trying to use more can lead
to timeouts on some firmware versions

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ca198c4f5510..b50f5b058103 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2307,7 +2307,7 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		.action = cpu_to_le32(MT_STA_BSS_GROUP),
 		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
 		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
-		.val = cpu_to_le32(mvif->idx),
+		.val = cpu_to_le32(mvif->idx % 16),
 	};
 
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_DRR_CTRL,
-- 
2.28.0

