Return-Path: <linux-wireless+bounces-12079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219796145D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE12B215E2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68A1CF290;
	Tue, 27 Aug 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="L5sW/SsT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607561CC150;
	Tue, 27 Aug 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776897; cv=none; b=lYBO5AMTIBeLGPyyE3vaOb3tdRqgJNn1kDftuVIhJ4i1WX89siHMyUuk74wJjN2u/pRmljxE1qXPHlfW0selUTchq3UOWx+nGsgCyI4SY+BPlDhJfT9XEPiq+c7L2uJ7L0C39mTgfDJyU/TBmVJ85JuMqV+izRViAIt6B2OxBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776897; c=relaxed/simple;
	bh=Pz/7n4MgXH++LaaoI8WybLWplDzOie33ABhmrcolquM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6OujwiJ6Biyt7oKimfvpq/nQI37yyI7vR8GclNOyq9KWK4+JgTdry+0dJ2TSgvC/DK23IpTCzSWyc/d5InfbJq/G2PyE0bdWYuvqkhjRs8wP/JtKbRKlJaf+qcMG3hYTlwfeWG233SgwMsv7ZbarpABUAKfzUDO+NNdtsr9IiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=L5sW/SsT; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2688288970;
	Tue, 27 Aug 2024 18:41:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724776893;
	bh=x834WX67V4H6W4CYrFiUR8rxBBYDfY3Zfv0n3ii6y5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5sW/SsTiDWvbiNiXsgWB2XqJ6og/1D4vexCXUzCpBwh5B2dcGiSM4UhAbfkHue6M
	 0m306mO8MZK9pBWDC8nCZGmADl98chXS5I7ugc02eKKCc04QVKxqwexVE5dyKKM860
	 INb5evF0wHzLDGJtaiCZansrlkrdskD0jKx1s3noVdLfo9QolrY8fp4Ymj+ykQ+PC1
	 t55c/g5i8tZjs60WMw3xu8r+6oNSbKV9duy4H5pZIeThAws7tjhCL5r8nk/uhUj4NN
	 pm2fP6VU5cBC6Zx+iulV205Y1hB6mN3QK7s56W2GBWCOmeOIHQ1sKgG5zLH2j4TGnn
	 kqZh5A/J3jb/g==
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
Subject: [PATCH v3 3/5] wifi: wilc1000: Fold chip_allow_sleep()/chip_wakeup() into wlan.c
Date: Tue, 27 Aug 2024 18:37:40 +0200
Message-ID: <20240827164042.53698-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827164042.53698-1-marex@denx.de>
References: <20240827164042.53698-1-marex@denx.de>
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
V3: No change
---
 .../net/wireless/microchip/wilc1000/wlan.c    | 47 +++++++++----------
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 -
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 5b7dd37267de0..d228c5df82628 100644
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
2.45.2


