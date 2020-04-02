Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC50619C1B3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgDBNII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNII (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:08:08 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612DA20757;
        Thu,  2 Apr 2020 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832887;
        bh=qY1kduqfBx12lV0XczVCmm5xVfKRUZ4bGDEtw6uGdgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ0L0PG+LC/OxsFgOrhikRphaXRrQaBY2KGdQ9tyxGQ9pc0nkLdd4XQ/29/jh+D2l
         pdMhwtgVW+b0G8rJQa0NSTEUrNcxVQwHoSWCWDg+NULHyAT4DMCQlQdh7RMQby8NHo
         nrqsYs5abgqaYKL8O5OJLYQqyk22ArPmohgEAx5Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 10/12] mt76: mt7615: introduce BSS absence event
Date:   Thu,  2 Apr 2020 15:06:40 +0200
Message-Id: <87d37ce29bebfaa89aba0609cc0c07b0b514f785.1585832459.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce BSS absence event that is reported when the fw
is leaving or entering current operational channel.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 24 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  8 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 193808cca905..5385d16e435d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -339,6 +339,26 @@ mt7615_mcu_scan_event(struct mt7615_dev *dev, struct sk_buff *skb)
 				     MT7615_HW_SCAN_TIMEOUT);
 }
 
+static void
+mt7615_mcu_bss_event(struct mt7615_dev *dev, struct sk_buff *skb)
+{
+	struct mt7615_mcu_bss_event *event;
+	struct mt76_phy *mphy;
+
+	event = (struct mt7615_mcu_bss_event *)(skb->data +
+						sizeof(struct mt7615_mcu_rxd));
+
+	if (event->bss_idx && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+	else
+		mphy = &dev->mt76.phy;
+
+	if (event->is_absent)
+		ieee80211_stop_queues(mphy->hw);
+	else
+		ieee80211_wake_queues(mphy->hw);
+}
+
 static void
 mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
 {
@@ -352,6 +372,9 @@ mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_SCAN_DONE:
 		mt7615_mcu_scan_event(dev, skb);
 		return;
+	case MCU_EVENT_BSS_ABSENCE:
+		mt7615_mcu_bss_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -367,6 +390,7 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
 	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    !rxd->seq)
 		mt7615_mcu_rx_unsolicited_event(dev, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 7e55da2b6573..e6a927fd209f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -82,6 +82,7 @@ enum {
 	MCU_EVENT_ACCESS_REG = 0x02,
 	MCU_EVENT_MT_PATCH_SEM = 0x04,
 	MCU_EVENT_SCAN_DONE = 0x0d,
+	MCU_EVENT_BSS_ABSENCE  = 0x11,
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
 	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
 	MCU_EVENT_EXT = 0xed,
@@ -398,6 +399,13 @@ struct nt7615_sched_scan_done {
 	__le16 pad;
 } __packed;
 
+struct mt7615_mcu_bss_event {
+	u8 bss_idx;
+	u8 is_absent;
+	u8 free_quota;
+	u8 pad;
+} __packed;
+
 /* offload mcu commands */
 enum {
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
-- 
2.25.1

