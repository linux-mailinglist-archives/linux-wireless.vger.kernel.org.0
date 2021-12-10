Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96DC470BD7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 21:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbhLJUd7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 15:33:59 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:35858 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344184AbhLJUd6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 15:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=aOFq/ymrkhh+1xjIr5PEl78GKED6RbjTLdF1XyyvOAQ=;
        b=HddRQb9yBMD7BdKblBFuweDKyWtmPR7adHhjd/tYZ2EtC7GPYNBDeMbpUaQX9zAixG2Y
        ryQ7LPrOWZpa0626ybazgO0BYDjDNmq5raajd2MkbcGGPvXDYBlpJ86JsTAd7F+60EoZiJ
        88+UxuSGI1Ls2Lxk6kAYe2HZd/k2quA0i0YD1mnKclzqatawMjNwoZ3u1hMNdI3V5x5c4z
        KvTh8JsnYgjyZUJIJzYzTzRxGLOVfssVLQsHZtsOXy6xXMtifhcm3oZxu6os9QQH2vakCG
        sCejPgJrHpnK5bpTDZ0OwimuMLNO03jgb8KNOHFQ2wC3n9A+zsJVfjwTzpzR04+w==
Received: by filterdrecv-75ff7b5ffb-q2hvm with SMTP id filterdrecv-75ff7b5ffb-q2hvm-1-61B3B8DE-50
        2021-12-10 20:30:22.354960945 +0000 UTC m=+8633406.199069630
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-4-1 (SG)
        with ESMTP
        id 5YVvpbITTEGQzGwPPsYsHA
        Fri, 10 Dec 2021 20:30:22.226 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id B1E4E700922; Fri, 10 Dec 2021 13:30:21 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 1/1] wilc1000: Improve WILC TX performance when power_save
 is off
Date:   Fri, 10 Dec 2021 20:30:22 +0000 (UTC)
Message-Id: <20211210203016.3680425-2-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210203016.3680425-1-davidm@egauge.net>
References: <20211210203016.3680425-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvJ+c=2FU+9SC0L3N0eo?=
 =?us-ascii?Q?qpSQAh2SdcM3M=2FPj42+clWjkbmvlTK1A7FuifVZ?=
 =?us-ascii?Q?dVo72smJeqVTpSq9SenDW=2FPemXVKcWI=2F4v=2FcVWU?=
 =?us-ascii?Q?AKtnhFQTjlXsBU+H=2FSz5CTVcsreGbuLk=2FTHkaoj?=
 =?us-ascii?Q?MCZ7a7=2FDChAcfXIEFQP3rCHO4IVB3HBl4nawOc4?=
 =?us-ascii?Q?V3qhuJwKAjBJuquTDSjcA=3D=3D?=
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
when it is in power save mode (PSM, as controlled by "iw dev wlan0 set
power_save on/off").  The commands are relatively costly, so it pays
to skip them when possible.

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
index b9a88b3e322f..6c0e634d0249 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -212,6 +212,7 @@ struct wilc {
 	s8 mac_status;
 	struct clk *rtc_clk;
 	bool initialized;
+	bool power_save_mode;
 	int dev_irq_num;
 	int close;
 	u8 vif_num;
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

