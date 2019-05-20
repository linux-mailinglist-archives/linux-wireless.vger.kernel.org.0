Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DEC22F70
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfETIzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:55:24 -0400
Received: from nbd.name ([46.4.11.11]:41446 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731661AbfETIzV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:55:21 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSe4j-0002Y7-An; Mon, 20 May 2019 10:55:17 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V5 2/8] ath11k: fix some whitespace errors
Date:   Mon, 20 May 2019 10:55:02 +0200
Message-Id: <20190520085508.5888-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520085508.5888-1-john@phrozen.org>
References: <20190520085508.5888-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 38 +++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 366a136e53ac..0fa33f38abdf 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4139,28 +4139,28 @@ struct wmi_unit_test_cmd {
 
 #define MAX_SUPPORTED_RATES 128
 
-#define WMI_PEER_AUTH           0x00000001
-#define WMI_PEER_QOS            0x00000002
-#define WMI_PEER_NEED_PTK_4_WAY 0x00000004
-#define WMI_PEER_NEED_GTK_2_WAY 0x00000010
-#define WMI_PEER_HE             0x00000400
-#define WMI_PEER_APSD           0x00000800
-#define WMI_PEER_HT             0x00001000
-#define WMI_PEER_40MHZ          0x00002000
-#define WMI_PEER_STBC           0x00008000
-#define WMI_PEER_LDPC           0x00010000
-#define WMI_PEER_DYN_MIMOPS     0x00020000
-#define WMI_PEER_STATIC_MIMOPS  0x00040000
-#define WMI_PEER_SPATIAL_MUX    0x00200000
-#define WMI_PEER_VHT            0x02000000
-#define WMI_PEER_80MHZ          0x04000000
-#define WMI_PEER_PMF            0x08000000
+#define WMI_PEER_AUTH		0x00000001
+#define WMI_PEER_QOS		0x00000002
+#define WMI_PEER_NEED_PTK_4_WAY	0x00000004
+#define WMI_PEER_NEED_GTK_2_WAY	0x00000010
+#define WMI_PEER_HE		0x00000400
+#define WMI_PEER_APSD		0x00000800
+#define WMI_PEER_HT		0x00001000
+#define WMI_PEER_40MHZ		0x00002000
+#define WMI_PEER_STBC		0x00008000
+#define WMI_PEER_LDPC		0x00010000
+#define WMI_PEER_DYN_MIMOPS	0x00020000
+#define WMI_PEER_STATIC_MIMOPS	0x00040000
+#define WMI_PEER_SPATIAL_MUX	0x00200000
+#define WMI_PEER_VHT		0x02000000
+#define WMI_PEER_80MHZ		0x04000000
+#define WMI_PEER_PMF		0x08000000
 /* TODO: Place holder for WLAN_PEER_F_PS_PRESEND_REQUIRED = 0x10000000.
  * Need to be cleaned up
  */
-#define WMI_PEER_IS_P2P_CAPABLE 0x20000000
-#define WMI_PEER_160MHZ         0x40000000
-#define WMI_PEER_SAFEMODE_EN    0x80000000
+#define WMI_PEER_IS_P2P_CAPABLE	0x20000000
+#define WMI_PEER_160MHZ		0x40000000
+#define WMI_PEER_SAFEMODE_EN	0x80000000
 
 struct beacon_tmpl_params {
 	u8 vdev_id;
-- 
2.20.1

