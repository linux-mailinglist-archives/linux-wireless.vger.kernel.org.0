Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C881B25FD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgDUM2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:28:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39842 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUM2l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:28:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03LCScaN118462;
        Tue, 21 Apr 2020 07:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587472118;
        bh=27rdEN5udCpOZEDEOuPyKBN4BY6ZZA8P9e94r163CVs=;
        h=From:To:CC:Subject:Date;
        b=sYHGJfshTSTzABGLabuk/U6Dbt13C3n96A+bzMxb6PSs/uVBv+29HcKVWa9gbCCSW
         sGh2uvIxspvaAWSq5lytQS5+jEELqAlY/BmaK8rVTqFzBwx5lXvEHFE+BqQ+uVZdiM
         RgRhjKUK9hYMXaerb/PIARvhMRs9F2XT28VqpUIU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03LCScOu051133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Apr 2020 07:28:38 -0500
Received: from ild153790.dhcp.ti.com (137.167.21.153) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Apr 2020 07:28:37 -0500
From:   Raz Bouganim <r-bouganim@ti.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <d-levy@ti.com>,
        Raz Bouganim <r-bouganim@ti.com>
Subject: [PATCH v3] wlcore: Adding suppoprt for IGTK key in wlcore driver
Date:   Tue, 21 Apr 2020 15:28:05 +0300
Message-ID: <1587472085-755-1-git-send-email-r-bouganim@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.167.21.153]
X-ClientProxiedBy: DLEE106.ent.ti.com (157.170.170.36) To DLEE105.ent.ti.com
 (157.170.170.35)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adding support for new cipher suite - AES-CMAC in wlcore driver.
This patch is required for support PMF/WPA3 connection to install IGTK key.

Signed-off-by: Raz Bouganim <r-bouganim@ti.com>
---
 drivers/net/wireless/ti/wlcore/cmd.h  | 1 +
 drivers/net/wireless/ti/wlcore/main.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index f2609d5..1d14bd1 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -458,6 +458,7 @@ enum wl1271_cmd_key_type {
 	KEY_TKIP = 2,
 	KEY_AES  = 3,
 	KEY_GEM  = 4,
+	KEY_IGTK  = 5,
 };
 
 struct wl1271_cmd_set_keys {
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index f140f7d..1a75959 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3547,6 +3547,9 @@ int wlcore_set_key(struct wl1271 *wl, enum set_key_cmd cmd,
 	case WL1271_CIPHER_SUITE_GEM:
 		key_type = KEY_GEM;
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key_type = KEY_IGTK;
+		break;
 	default:
 		wl1271_error("Unknown key algo 0x%x", key_conf->cipher);
 
@@ -6214,6 +6217,7 @@ static int wl1271_init_ieee80211(struct wl1271 *wl)
 		WLAN_CIPHER_SUITE_TKIP,
 		WLAN_CIPHER_SUITE_CCMP,
 		WL1271_CIPHER_SUITE_GEM,
+		WLAN_CIPHER_SUITE_AES_CMAC,
 	};
 
 	/* The tx descriptor buffer */
-- 
1.9.1
