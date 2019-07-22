Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD916F8E4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 07:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfGVFbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 01:31:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16282 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbfGVFbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 01:31:46 -0400
X-UUID: 8790669de8a5464a85a2e4cf534bab16-20190722
X-UUID: 8790669de8a5464a85a2e4cf534bab16-20190722
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 91142533; Mon, 22 Jul 2019 13:31:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 13:31:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 13:31:17 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH 1/5] mt76: Add paragraphs to describe the config symbols fully
Date:   Mon, 22 Jul 2019 13:31:11 +0800
Message-ID: <ae5dedf629c67985226dc63fb5ac08488957cc59.1563772403.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1563772403.git.ryder.lee@mediatek.com>
References: <cover.1563772403.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update the help text to fix checkpatch.pl warning:

WARNING: please write a paragraph that describes the config symbol fully

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig |  6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig |  7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig | 12 ++++++++++--
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig | 14 +++++++++++---
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
index e108bf881ca8..69cc74bce060 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
@@ -5,6 +5,8 @@ config MT7603E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7603E wireless PCIe devices and the WLAN core on
-	  MT7628/MT7688 SoC devices
+	  This adds support for MT7603E wireless PCIe devices and the WLAN core
+	  on MT7628/MT7688 SoC devices. This family supports 2x2 IEEE 802.11n
+	  300Mbps PHY rate
 
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 2ed47b309b6e..dfc110b4bcb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -5,4 +5,9 @@ config MT7615E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7615-based wireless PCIe devices.
+	  This adds support for MT7615-based wireless PCIe devices, which
+	  support concurrent dual-band operation at 5GHz and 2.4GHz band,
+	  4x4:4SS IEEE 802.11ac 1733Mbps PHY rate, wave2 MU-MIMO up to 4
+	  users/group and 160MHz channels.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig b/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
index 209d8abc49d5..fb8fe98512ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
@@ -10,7 +10,11 @@ config MT76x0U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7610U-based wireless USB dongles.
+	  This adds support for MT7610U-based wireless USB 2.0 dongles,
+	  which complie with IEEE 802.11ac standards and support 1x1
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
+	  which complie with IEEE 802.11ac standards and support 1x1
+	  433Mbps PHY rate.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig b/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
index 1f69908f8373..c4fe52d8c88b 100644
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
+	  devices, which complie with IEEE 802.11ac standards and support
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
+	  which complie with IEEE 802.11ac standards and support 2SS
+	  to 866Mbit/s PHY rate.
+
+	  To compile this driver as a module, choose M here.
-- 
2.18.0

