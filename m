Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA951CFED5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbgELUDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 16:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgELUDC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 16:03:02 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA522206D6;
        Tue, 12 May 2020 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589313782;
        bh=MTUCgk4rciCF//7GPnewL+9mWSnuMUcygZkcZVrYiaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQQF9BGVhVWeeh9XhG7JrHi/dK/Ipqhycgmc/XKAMuSjIHF+8+EgUPWYuZUYme8WP
         6yPZdQR+SVhn2gGaDzr61xCP3CIAzw+31FZTPr+7PggNiEGoNJFeiCunS1dUOtKFje
         f8EfUaQvpwLirNgCM8Rk/643Acw4onN2JdokbLTI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 2/4] mt76: mt7615: reduce hw scan timeout
Date:   Tue, 12 May 2020 22:02:48 +0200
Message-Id: <c661734466cb9e14f15a37e5f8cc6d54e18cad3b.1589313659.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589313659.git.lorenzo@kernel.org>
References: <cover.1589313659.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Differentiate hw scan channel time between passive and active scan

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9cb8a9bb912b..e9ae7e94d8fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2773,7 +2773,7 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 				       MCU_CMD_SET_CHAN_DOMAIN, false);
 }
 
-#define MT7615_SCAN_CHANNEL_TIME	120
+#define MT7615_SCAN_CHANNEL_TIME	60
 int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req)
 {
@@ -2819,6 +2819,9 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
 	req->ssids_num = n_ssids;
 
+	/* increase channel time for passive scan */
+	if (!sreq->n_ssids)
+		duration *= 2;
 	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
 	req->channel_min_dwell_time = cpu_to_le16(duration);
 	req->channel_dwell_time = cpu_to_le16(duration);
-- 
2.26.2

