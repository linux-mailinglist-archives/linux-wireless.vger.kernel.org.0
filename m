Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70503462FD0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 10:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbhK3Jjs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 04:39:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57764 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbhK3Jjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 04:39:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1087B817F7
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 09:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7EAC53FCB;
        Tue, 30 Nov 2021 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638264987;
        bh=gIiTF47+ybBL2RplebhTka24BvMjeJ28TMX1bCTkHZs=;
        h=From:To:Cc:Subject:Date:From;
        b=TzYWTv7Su8v62hf7TRMlHJTWCZTWIjJ/2IterNMY5BADKDtVVPRsLK3FicOsG9qd8
         QGi4NGc0mpj/ovSMRq6kecsYphzVk0icz2j/FbtRVPHoUh5PtzK4JPqgwbAEjhOrE0
         Sx1T6SI3K9SckzUPj3B4BZrbM81VcdurzlIfPYire6DAXAVYo6zvPHGZ8/tItKXJbC
         TnybwKUwOpbRjDoQfdrI4l2c+T/Bg/b+k24oza88w3s7BE793+HYyWWiyr5eACYEt2
         YcbAEUZtZZqOXhSCrTrHIMkdpzpAv5e4eSqRYeTQgtvgssdsLrdlgFmkZp3FgnREsQ
         kwtwYmVM6zCvA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: connac: fix last_chan configuration in mt76_connac_mcu_rate_txpower_band
Date:   Tue, 30 Nov 2021 10:36:15 +0100
Message-Id: <05dfc592c246c47c61495380680342148c9de29d.1638264847.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

last_ch configuration must not be dependent on the current configured band
but it is defined by hw capabilities since the fw always expects the
following order:
- 2GHz
- 5GHz
- 6GHz

Fixes: 9b2ea8eee42a1 ("mt76: connac: set 6G phymode in single-sku support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8198f177d59b..e5e4af1b404c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1980,12 +1980,12 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 	}
 	batch_size = DIV_ROUND_UP(n_chan, batch_len);
 
-	if (!phy->cap.has_5ghz)
-		last_ch = chan_list_2ghz[n_chan - 1];
-	else if (phy->cap.has_6ghz)
-		last_ch = chan_list_6ghz[n_chan - 1];
+	if (phy->cap.has_6ghz)
+		last_ch = chan_list_6ghz[ARRAY_SIZE(chan_list_6ghz) - 1];
+	else if (phy->cap.has_5ghz)
+		last_ch = chan_list_5ghz[ARRAY_SIZE(chan_list_5ghz) - 1];
 	else
-		last_ch = chan_list_5ghz[n_chan - 1];
+		last_ch = chan_list_2ghz[ARRAY_SIZE(chan_list_2ghz) - 1];
 
 	for (i = 0; i < batch_size; i++) {
 		struct mt76_connac_tx_power_limit_tlv tx_power_tlv = {};
-- 
2.31.1

