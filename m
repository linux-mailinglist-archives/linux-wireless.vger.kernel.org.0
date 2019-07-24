Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C61A72AE3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 10:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGXI6f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 04:58:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41218 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbfGXI6e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 04:58:34 -0400
X-UUID: 70373fde55e24d0ca8f80ed2ec1609a4-20190724
X-UUID: 70373fde55e24d0ca8f80ed2ec1609a4-20190724
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1270313578; Wed, 24 Jul 2019 16:58:24 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 16:58:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 16:58:23 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 1/6] mt76: Add paragraphs to describe the config symbols fully
Date:   Wed, 24 Jul 2019 16:58:15 +0800
Message-ID: <d259e08a5f4c0f0f50f67d6cfc2a6258181e53d4.1563944758.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1563944758.git.ryder.lee@mediatek.com>
References: <cover.1563944758.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update the help text to fix a checkpatch warning:

WARNING: please write a paragraph that describes the config symbol fully

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig |  6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig |  7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig | 12 ++++++++++--
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig | 14 +++++++++++---
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
index e108bf881ca8..6a0080f1d91c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
@@ -5,6 +5,8 @@ config MT7603E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7603E wireless PCIe devices and the WLAN core on
-	  MT7628/MT7688 SoC devices
+	  This adds support for MT7603E wireless PCIe devices and the WLAN core
+	  on MT7628/MT7688 SoC devices. This family supports IEEE 802.11n 2x2
+	  to 300Mbps PHY rate
 
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 2ed47b309b6e..4cabba9aa2ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -5,4 +5,9 @@ config MT7615E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7615-based wireless PCIe devices.
+	  This adds support for MT7615-based wireless PCIe devices,
+	  which support concurrent dual-band operation at both 5GHz
+	  and 2.4GHz, IEEE 802.11ac 4x4:4SS 1733Mbps PHY rate, wave2
+	  MU-MIMO up to 4 users/group and 160MHz channels.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig b/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
index 209d8abc49d5..7c88ed8b8f1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
@@ -10,7 +10,11 @@ config MT76x0U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7610U-based wireless USB dongles.
+	  This adds support for MT7610U-based wireless USB 2.0 dongles,
+	  which comply with IEEE 802.11ac standards and support 1x1
+	  433Mbps PHY rate.
+
+	  To compile this driver as a module, choose M here.
 
 config MT76x0E
 	tristate "MediaTek MT76x0E (PCIe) support"
@@ -18,4 +22,8 @@ config MT76x0E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7610/MT7630-based wireless PCIe devices.
+	  This adds support for MT7610/MT7630-based wireless PCIe devices,
+	  which comply with IEEE 802.11ac standards and support 1x1
+	  433Mbps PHY rate.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig b/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
index 1f69908f8373..5fd4973e32df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
@@ -8,8 +8,12 @@ config MT76x2E
 	select MT76x2_COMMON
 	depends on MAC80211
 	depends on PCI
-	---help---
-	  This adds support for MT7612/MT7602/MT7662-based wireless PCIe devices.
+	help
+	  This adds support for MT7612/MT7602/MT7662-based wireless PCIe
+	  devices, which comply with IEEE 802.11ac standards and support
+	  2SS to 866Mbit/s PHY rate.
+
+	  To compile this driver as a module, choose M here.
 
 config MT76x2U
 	tristate "MediaTek MT76x2U (USB) support"
@@ -18,4 +22,8 @@ config MT76x2U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7612U-based wireless USB dongles.
+	  This adds support for MT7612U-based wireless USB 3.0 dongles,
+	  which comply with IEEE 802.11ac standards and support 2SS to
+	  866Mbit/s PHY rate.
+
+	  To compile this driver as a module, choose M here.
-- 
2.18.0

