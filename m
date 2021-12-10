Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8377D470804
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 19:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbhLJSF4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 13:05:56 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:55010 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhLJSFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 13:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=9jCU8BFQA1UlMvg4GNct9R1TYyo82hAzJbtaHyQ/HrY=;
        b=d+IoqAg1sdWeCP+jYh38TwdqYdNO2rxE/gqBSthzijjbezopH6lstON5TBp/oqZWJVud
        G5bQIgDo/1Q1cP9zrbPZx3BvjMOEQUUZ2rvHYlby3YPfHGrHKocGO0RLsafAr/r63XOBxl
        eVa7fJbf4Ud1XMoTdjz13TGaOTzjhiQIt6wKDO1Ak8xWogmxRwYaUsESgi4HRXJshzoGmW
        tzroQXBZeF1l56qr4AEc0uDOjdUW0yTxFGspeW8W+FGUidun1ILn42cRDE0/BT6J4Ypd8Z
        K/OPlQ1wm+2Pq1XE7FlhOF4P/flDw/cimhLwwPGR4DnlDuOtz7IY4uLShPau/g3A==
Received: by filterdrecv-55446c4d49-lmhnt with SMTP id filterdrecv-55446c4d49-lmhnt-1-61B3962B-50
        2021-12-10 18:02:19.404188147 +0000 UTC m=+8624537.106268030
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-canary-0 (SG)
        with ESMTP
        id f1cHiyA1TEaECC2CWIJEhQ
        Fri, 10 Dec 2021 18:02:19.185 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 750C57004D8; Fri, 10 Dec 2021 11:02:18 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wilc1000: Improve WILC TX performance when power_save is off
Date:   Fri, 10 Dec 2021 18:02:19 +0000 (UTC)
Message-Id: <20211210180213.3661994-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvGzZoaxb4vy+wQf6M?=
 =?us-ascii?Q?7A25menrBh5TCaCB0iYRtQAMZ55E+=2FQHzFrCZJY?=
 =?us-ascii?Q?SE+a8Lz6Yox+EoBT2F1kF2f62qbhwB4GHL4HWCC?=
 =?us-ascii?Q?tPhRJgw0iZHDF7AZmadI6DA2sjqbRaps4kLlmXS?=
 =?us-ascii?Q?V7mT3TZaSHPDUAvEpWlwpb7SUpNhc4ztbSbWHYw?=
 =?us-ascii?Q?TLN9YiU1gKWSRNVY4MTiQ=3D=3D?=
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The wakeup and sleep commands need to be sent to the WILC chip only
when the it is in power save mode (PSM, as controlled by "iw dev wlan0
set power_save on/off").  The commands are relatively costly, so it
pays to skip them when possible.

iperf3 without this patch (no significant different with PSM on/off):
  TX   0.00-120.01 sec   140 MBytes  9.82 Mbits/sec
  RX   0.00-120.69 sec   283 MBytes  19.6 Mbits/sec

with this patch applied:

PSM off (TX is 46% improved, RX slightly improved; may not be significant):
  TX   0.00-120.00 sec   206 MBytes  14.4 Mbits/sec
  RX   0.00-120.48 sec   322 MBytes  22.4 Mbits/sec

PSM on (no significant change):
  TX   0.00-120.00 sec   140 MBytes  9.78 Mbits/sec
  RX   0.00-120.08 sec   257 MBytes  18.0 Mbits/sec

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/hif.c    | 3 +++
 drivers/net/wireless/microchip/wilc1000/netdev.h | 1 +
 drivers/net/wireless/microchip/wilc1000/wlan.c   | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index e69b9c7f3d31..29a42bc47017 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1929,6 +1929,7 @@ int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
 
 int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout)
 {
+	struct wilc *wilc = vif->wilc;
 	struct wid wid;
 	int result;
 	s8 power_mode;
@@ -1944,6 +1945,8 @@ int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout)
 	result = wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
 	if (result)
 		netdev_err(vif->ndev, "Failed to send power management\n");
+	else
+		wilc->power_save_mode = enabled;
 
 	return result;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index b9a88b3e322f..f222e9c647f1 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -125,6 +125,7 @@ struct wilc_priv {
 	u64 tx_cookie;
 
 	bool cfg_scanning;
+	bool power_save_mode;
 
 	u8 associated_bss[ETH_ALEN];
 	struct sta_info assoc_stainfo;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 82566544419a..c63219fc634b 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -20,13 +20,13 @@ static inline bool is_wilc1000(u32 id)
 static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
 	mutex_lock(&wilc->hif_cs);
-	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP)
+	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode)
 		chip_wakeup(wilc);
 }
 
 static inline void release_bus(struct wilc *wilc, enum bus_release release)
 {
-	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP)
+	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
 		chip_allow_sleep(wilc);
 	mutex_unlock(&wilc->hif_cs);
 }
-- 
2.25.1

