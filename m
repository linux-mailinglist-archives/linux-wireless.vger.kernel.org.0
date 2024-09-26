Return-Path: <linux-wireless+bounces-13240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9529879D5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 21:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F7D286DFF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF3817F394;
	Thu, 26 Sep 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="D37LvAuj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549F17AE05;
	Thu, 26 Sep 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380658; cv=none; b=V2bTE+uKyGCIL0yfD2AdJZbgBQkuu7ynNHh/haadDedvtPcG68fV97j14YsGGx/PrvoIcXWvdCmFMhFi7oRYW1n+995MLgxI6EClBBRoETvGOefE3VTLSstLGccn/xasfJE6q1zntXrnO0CyNg7+VV2+gtjBN2fBROIPMFZRW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380658; c=relaxed/simple;
	bh=BXyO1gXJhwJLcwfXHg21iHqxlUglHiDbuhCl+Qqdtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRAjWQBX/aAtG96LLHnt+VIQkTr//Znd0GgEybsImKAZFsg2lt+SnECOnPjN6WHG2HS8Yr5BiybF2t6gaMwcLzlKMOiujZnRA9A5Nb1b6KVjn5HZrlIqU9JZIYt+AA51WWW0tRliBAW1+a9gmnLyxqCUwsQR0hi77APuH6f1E0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=D37LvAuj; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AC2C788D63;
	Thu, 26 Sep 2024 21:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727380655;
	bh=hV38atJN8IFcrziakhzOcFeHVWya0xOFyCcXJ8LYMUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D37LvAujDtssdOT0HQHCpdBAZhn9J0lb9hw5859WH10KiLaFypyjvLbraW9AkuVk0
	 QWtWrNFdmoY13kZUjU20zCQeap5JxwdV9uakvMm9z3beARsM0CXxWfHRI8NLyU9QKF
	 0d9ecZn87zflyDJ/SjDhs1YEMW6JZ/5h71IbhWVVoWuad3Ejz8srSPXX60P70O3lPJ
	 ixVPV0sMILjF7X7PCCxDeC/Mba7/8uhBPnix+fHSvfBWDryaf5Z4hZRmwULu5WEXw+
	 BhAJtLR30kAtSnK80FflU5IpqLW80KLfRpgVgpJ8M0E/WmpgBcIC65dTIZ5UbKOnhd
	 wOzq8Q4vkLClQ==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
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
Subject: [PATCH v6 3/7] wifi: wilc1000: Fold chip_allow_sleep()/chip_wakeup() into wlan.c
Date: Thu, 26 Sep 2024 21:55:43 +0200
Message-ID: <20240926195700.2823751-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240926195700.2823751-1-marex@denx.de>
References: <20240926195700.2823751-1-marex@denx.de>
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

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
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
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: New patch
V3: No change
V4: Add RB from Alexis
V5: No change
V6: - Rebase on next-20240926
---
 .../net/wireless/microchip/wilc1000/wlan.c    | 47 +++++++++----------
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 -
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 1f113a55ea6aa..6f4be21296029 100644
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
index 44dce53d24916..90ba76cf14dd1 100644
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
2.45.2


