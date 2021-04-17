Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01C4363143
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhDQQwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 12:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236537AbhDQQwL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 12:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77E7160FE6;
        Sat, 17 Apr 2021 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618678304;
        bh=EtdOWBik4y0FsPt+7ZiltKUS8Hkfa1gChdsULRHg9wk=;
        h=From:To:Cc:Subject:Date:From;
        b=Fha1XojN1BBkp0Ewr7zXPiyS11WJ1P8sIeVNk6sx5F02IAHVaUgeTTC9efZCkQHY0
         v/5RdqT2bg/2z+Dxlx9Xt10vywnblRscBfSG5ikcSlzt+d670Bxl5W8wP2jnOyhGuG
         50Tvx0kB10Z5hZGHhrCfOgfcwzjVZmsH7Gu6aH+5It85YilKi3UbVcpx810FXA0pVx
         Hcl0Ya2UAQDfLO7DW+LQI4k6gVnYoFON7IPSCHKuqOo+NaXc+R4+I8OA1swHIw7JMp
         O/ogMUs7WSILP7eh3rsxqgRRdeOhpduLviK03b/dlSXcGWU6wVrtD3Idd9B/VZDbB3
         3qk1wDe2eK5nw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: remove leftover function declaration
Date:   Sat, 17 Apr 2021 18:51:37 +0200
Message-Id: <7caae4078c8cb2759d06bd96b6798f697816d866.1618678223.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of leftover mt7921_mcu_add_bss_info routine declaration

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 3982e074ff50..3780a7f4cb16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -257,8 +257,6 @@ void mt7921_dma_prefetch(struct mt7921_dev *dev);
 void mt7921_dma_cleanup(struct mt7921_dev *dev);
 int mt7921_run_firmware(struct mt7921_dev *dev);
 int mt7921_mcu_init(struct mt7921_dev *dev);
-int mt7921_mcu_add_bss_info(struct mt7921_phy *phy,
-			    struct ieee80211_vif *vif, int enable);
 int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd);
-- 
2.30.2

