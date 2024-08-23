Return-Path: <linux-wireless+bounces-11859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED74695D2B5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8911C23148
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42F18DF81;
	Fri, 23 Aug 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Wk2aoivr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560CB18BC1B;
	Fri, 23 Aug 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429538; cv=none; b=ouL24HjC5HkYlmw0HzdQ1wCsX4Q3u1+97IpeeeFtDxAuvIYDR6yExU8Kj0s/HhESsowDYIq/GaNIqcPwI5j+AOUl3MBL2IaW3oYJH8tRq/FrkcqytJ81KhN4pU7+BHzWZdt/nm30MssXo8j2Kr6w2osyb5heUMm0ZRCHZ3hBpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429538; c=relaxed/simple;
	bh=bgsGE/iSwDfYUrr9iJbDG60zDK9cjB6HrRs91tSYP3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPyq6Ij/mkm4Fx5JRGGMY2EikGcDq7SRul2qs6WJClzCoOmd/lyp/pTPOYt7dx1j5NI6OejJIPPSUxHqfy2+88iGsL4ADNkiHmYdSRH/2MQ7kL5h+E1RKKMCs46wu//biEaudukXo5mNZC5Q3kDRgi+O7mR/MAZ6R4YJMoz+Z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Wk2aoivr; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0DD15888BF;
	Fri, 23 Aug 2024 18:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724429529;
	bh=6qniPfEjPyYJhycRQMQbJ7zF7p2a2Q/izZQn8hkzwXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wk2aoivrqdEvwfPK3WsKFJnfZKpxMqmCfDDg4ABdGI4s00BOa+IMVGssEDJK88zi3
	 rFvUyyT3zXWKiwk6KDf+0i1fKmzdoukJFtCE+xgCejD41KHcsEZLK8pzNrYlXidydq
	 Vte3RcNrq0DF61KL5s4ALsYGeT6sQ7yCLPL9CxpcHaHst5iRRX9i1TYR/wocBiMLzW
	 GQT9IQzckaxxCMuNZjbGtSQzRbmPhizwtRJcRS8ZMFPcdXMfJ8cyHFjIzqOCAhS0H/
	 cvbVS5uC4TcxSkXP7xwMJ1KZTe0XruI5EPBAfSVKzFOzB5RNy/c7wSswLBfd5NXQsl
	 2XAtbAGflVNKg==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 3/4] wifi: wilc1000: Fold chip_allow_sleep()/chip_wakeup() into wlan.c
Date: Fri, 23 Aug 2024 18:08:58 +0200
Message-ID: <20240823161131.94305-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823161131.94305-1-marex@denx.de>
References: <20240823161131.94305-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Neither chip_allow_sleep()/chip_wakeup() is used outside of wlan.c .
Make both functions static and remove both the exported symbol and
entries from wlan.h .

Make chip_allow_sleep() return error code in preparation for the
follow up patches.

Move acquire_bus() and release_bus() to avoid forward declaration
of chip_allow_sleep()/chip_wakeup().

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: New patch
---
 .../net/wireless/microchip/wilc1000/wlan.c    | 47 +++++++++----------
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 -
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 1aab2f2dc159f..5fbba6876bd07 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -12,20 +12,6 @@
 
 #define WAKE_UP_TRIAL_RETRY		10000
 
-static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
-{
-	mutex_lock(&wilc->hif_cs);
-	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode)
-		chip_wakeup(wilc);
-}
-
-static inline void release_bus(struct wilc *wilc, enum bus_release release)
-{
-	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
-		chip_allow_sleep(wilc);
-	mutex_unlock(&wilc->hif_cs);
-}
-
 static void wilc_wlan_txq_remove(struct wilc *wilc, u8 q_num,
 				 struct txq_entry_t *tqe)
 {
@@ -555,7 +541,7 @@ static struct rxq_entry_t *wilc_wlan_rxq_remove(struct wilc *wilc)
 	return rqe;
 }
 
-void chip_allow_sleep(struct wilc *wilc)
+static int chip_allow_sleep(struct wilc *wilc)
 {
 	u32 reg = 0;
 	const struct wilc_hif_func *hif_func = wilc->hif_func;
@@ -584,7 +570,7 @@ void chip_allow_sleep(struct wilc *wilc)
 	while (--trials) {
 		ret = hif_func->hif_read_reg(wilc, to_host_from_fw_reg, &reg);
 		if (ret)
-			return;
+			return ret;
 		if ((reg & to_host_from_fw_bit) == 0)
 			break;
 	}
@@ -594,28 +580,28 @@ void chip_allow_sleep(struct wilc *wilc)
 	/* Clear bit 1 */
 	ret = hif_func->hif_read_reg(wilc, wakeup_reg, &reg);
 	if (ret)
-		return;
+		return ret;
 	if (reg & wakeup_bit) {
 		reg &= ~wakeup_bit;
 		ret = hif_func->hif_write_reg(wilc, wakeup_reg, reg);
 		if (ret)
-			return;
+			return ret;
 	}
 
 	ret = hif_func->hif_read_reg(wilc, from_host_to_fw_reg, &reg);
 	if (ret)
-		return;
+		return ret;
 	if (reg & from_host_to_fw_bit) {
 		reg &= ~from_host_to_fw_bit;
 		ret = hif_func->hif_write_reg(wilc, from_host_to_fw_reg, reg);
 		if (ret)
-			return;
-
+			return ret;
 	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(chip_allow_sleep);
 
-void chip_wakeup(struct wilc *wilc)
+static void chip_wakeup(struct wilc *wilc)
 {
 	u32 ret = 0;
 	u32 clk_status_val = 0, trials = 0;
@@ -674,7 +660,20 @@ void chip_wakeup(struct wilc *wilc)
 	if (wilc->io_type == WILC_HIF_SPI)
 		wilc->hif_func->hif_reset(wilc);
 }
-EXPORT_SYMBOL_GPL(chip_wakeup);
+
+static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
+{
+	mutex_lock(&wilc->hif_cs);
+	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode)
+		chip_wakeup(wilc);
+}
+
+static inline void release_bus(struct wilc *wilc, enum bus_release release)
+{
+	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
+		chip_allow_sleep(wilc);
+	mutex_unlock(&wilc->hif_cs);
+}
 
 void host_wakeup_notify(struct wilc *wilc)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index ae187192a79c6..e75a5c8aaecec 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -438,8 +438,6 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size);
 bool wilc_wfi_mgmt_frame_rx(struct wilc_vif *vif, u8 *buff, u32 size);
 void host_wakeup_notify(struct wilc *wilc);
 void host_sleep_notify(struct wilc *wilc);
-void chip_allow_sleep(struct wilc *wilc);
-void chip_wakeup(struct wilc *wilc);
 int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count);
 int wilc_wlan_init(struct net_device *dev);
-- 
2.43.0


