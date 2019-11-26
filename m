Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9EB10A628
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 22:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKZVrT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 16:47:19 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:46392 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKZVrT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 16:47:19 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 061E458007E;
        Tue, 26 Nov 2019 22:47:17 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v9 3/6] mt76: mt76x02: add check for invalid vif idx
Date:   Tue, 26 Nov 2019 22:47:01 +0100
Message-Id: <20191126214704.27297-4-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
References: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On adding vifs the idx can become 1 + (7 & 7) = 8 for APs.
Check against that, as only AP vif idx 0-7 is possible.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 889566b36a40..6073f8a4a8f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -325,7 +325,9 @@ mt76x02_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	if (vif->type == NL80211_IFTYPE_STATION)
 		idx += 8;
 
-	if (dev->vif_mask & BIT(idx))
+	/* vif is already set or idx is 8 for AP/Mesh/... */
+	if (dev->vif_mask & BIT(idx) ||
+	    (vif->type != NL80211_IFTYPE_STATION && idx > 7))
 		return -EBUSY;
 
 	dev->vif_mask |= BIT(idx);
-- 
2.24.0

