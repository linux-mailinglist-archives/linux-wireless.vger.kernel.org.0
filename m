Return-Path: <linux-wireless+bounces-15171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7B79C38E8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 08:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3BFB207C4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573F15852E;
	Mon, 11 Nov 2024 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CD7e2opg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E912CD96
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309137; cv=none; b=cbzuMPwZjPjtRwpOIkp1Ev2McGymntqpDNjGdpZ7Qqu5rugOMCwQ9gYpPEPiDi4bRzAgNCXze4CRIam56JVZMOtddfYhWm0pPpctqWoS1IPQC8cdU/HEzx3wQahCtlTMbJql7vUZC/gJ0ZsrR8kzTC1M2emXnLIJTzSFlXT9fTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309137; c=relaxed/simple;
	bh=F9dgFHL8AXZ5k78uAomKr5Iyw6/LuVRE2IBFnOWi96Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRnehzNow9FbrYWJLM8v/1qvVrZGxSyR2pTxn4NYy0O9x7wv8HpAqBzCbPNQE4jRFtqWxNHYQqtJZUx8TjvRHNqWNsBnJnZJ6JNKMI/K0KGaLqIP5Y2iMd5XFxad/NMkD/Z53a56UfE0VnhvODx111Iko/zf4KRDSsS5r6/OTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=CD7e2opg; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:8f4f:0:640:c72e:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id A8FD96093D;
	Mon, 11 Nov 2024 10:12:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3CgTkQugx8c0-kd8asRWd;
	Mon, 11 Nov 2024 10:12:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731309125; bh=JrU3UAbLQpSw3TSQh7d2cSgoaf7x+BI0l3F7eDLxJw4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=CD7e2opgF4E3aYpSH81Xsfg/yFa3VdFXb274xu09Ae7KdUP6m1E6uS6eIyKy0lTlG
	 4d1wckpeoXb8NU6v8lHx2DfpRb18S8IhmS5wkodqCJKrpky43BlmTcezHT8rcBFqlj
	 +R32UYZDv/M7Qz5VcjJ4uYJbqUWveMbKtvyqF6H0=
Authentication-Results: mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: miscellaneous spelling fixes
Date: Mon, 11 Nov 2024 10:11:57 +0300
Message-ID: <20241111071157.88296-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling here and there as suggested by codespell.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/antenna.c         | 2 +-
 drivers/net/wireless/ath/ath9k/ar9002_hw.c       | 2 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c       | 2 +-
 drivers/net/wireless/ath/ath9k/ar9003_mci.c      | 4 ++--
 drivers/net/wireless/ath/ath9k/ar9003_phy.h      | 2 +-
 drivers/net/wireless/ath/ath9k/channel.c         | 2 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c | 2 +-
 drivers/net/wireless/ath/ath9k/dfs.c             | 2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c         | 2 +-
 drivers/net/wireless/ath/ath9k/hw.c              | 4 ++--
 drivers/net/wireless/ath/ath9k/hw.h              | 2 +-
 drivers/net/wireless/ath/ath9k/mac.h             | 2 +-
 drivers/net/wireless/ath/ath9k/main.c            | 2 +-
 drivers/net/wireless/ath/ath9k/wow.c             | 6 +++---
 drivers/net/wireless/ath/ath9k/xmit.c            | 2 +-
 15 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/antenna.c b/drivers/net/wireless/ath/ath9k/antenna.c
index acc84e6711b0..e5e274bc9e68 100644
--- a/drivers/net/wireless/ath/ath9k/antenna.c
+++ b/drivers/net/wireless/ath/ath9k/antenna.c
@@ -193,7 +193,7 @@ static void ath_lnaconf_alt_good_scan(struct ath_ant_comb *antcomb,
 static void ath_ant_set_alt_ratio(struct ath_ant_comb *antcomb,
 				  struct ath_hw_antcomb_conf *conf)
 {
-	/* set alt to the conf with maximun ratio */
+	/* set alt to the conf with maximum ratio */
 	if (antcomb->first_ratio && antcomb->second_ratio) {
 		if (antcomb->rssi_second > antcomb->rssi_third) {
 			/* first alt*/
diff --git a/drivers/net/wireless/ath/ath9k/ar9002_hw.c b/drivers/net/wireless/ath/ath9k/ar9002_hw.c
index d08ea0b28530..b26224480041 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_hw.c
@@ -395,7 +395,7 @@ static void ar9002_hw_init_hang_checks(struct ath_hw *ah)
 		ah->config.hw_hang_checks |= HW_MAC_HANG;
 }
 
-/* Sets up the AR5008/AR9001/AR9002 hardware familiy callbacks */
+/* Sets up the AR5008/AR9001/AR9002 hardware family callbacks */
 int ar9002_hw_attach_ops(struct ath_hw *ah)
 {
 	struct ath_hw_private_ops *priv_ops = ath9k_hw_private_ops(ah);
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
index e9bd13eeee92..6595eca74997 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
@@ -1170,7 +1170,7 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 	return false;
 }
 
-/* Sets up the AR9003 hardware familiy callbacks */
+/* Sets up the AR9003 hardware family callbacks */
 void ar9003_hw_attach_ops(struct ath_hw *ah)
 {
 	struct ath_hw_private_ops *priv_ops = ath9k_hw_private_ops(ah);
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mci.c b/drivers/net/wireless/ath/ath9k/ar9003_mci.c
index 2b9c07961cd7..7dd4377b7a23 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mci.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mci.c
@@ -637,7 +637,7 @@ static u32 ar9003_mci_wait_for_gpm(struct ath_hw *ah, u8 gpm_type,
 		 * same time. Since BT's calibration doesn't happen
 		 * that often, we'll let BT completes calibration then
 		 * we continue to wait for cal_grant from BT.
-		 * Orginal: Wait BT_CAL_GRANT.
+		 * Original: Wait BT_CAL_GRANT.
 		 * New: Receive BT_CAL_REQ -> send WLAN_CAL_GRANT->wait
 		 * BT_CAL_DONE -> Wait BT_CAL_GRANT.
 		 */
@@ -747,7 +747,7 @@ int ar9003_mci_end_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	 * BT is sleeping. Check if BT wakes up during
 	 * WLAN calibration. If BT wakes up during
 	 * WLAN calibration, need to go through all
-	 * message exchanges again and recal.
+	 * message exchanges again and recall.
 	 */
 	REG_WRITE(ah, AR_MCI_INTERRUPT_RX_MSG_RAW,
 		  (AR_MCI_INTERRUPT_RX_MSG_REMOTE_RESET |
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index ad72a30b67c3..e13873fb8e2f 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -246,7 +246,7 @@
 
 
 /*
- * MRC Feild Definitions
+ * MRC Field Definitions
  */
 #define AR_PHY_SGI_DSC_MAN   0x0007FFF0
 #define AR_PHY_SGI_DSC_MAN_S 4
diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 571062f2e82a..02237d106f8c 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -17,7 +17,7 @@
 #include "ath9k.h"
 
 /* Set/change channels.  If the channel is really being changed, it's done
- * by reseting the chip.  To accomplish this we must first cleanup any pending
+ * by resetting the chip.  To accomplish this we must first cleanup any pending
  * DMA, then restart stuff.
  */
 static int ath_set_channel(struct ath_softc *sc)
diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index 4b27445a5fb8..628eeec4b82f 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -734,7 +734,7 @@ void ath9k_cmn_spectral_scan_trigger(struct ath_common *common,
 				 ATH9K_RX_FILTER_PHYRADAR |
 				 ATH9K_RX_FILTER_PHYERR);
 
-	/* TODO: usually this should not be neccesary, but for some reason
+	/* TODO: usually this should not be necessary, but for some reason
 	 * (or in some mode?) the trigger must be called after the
 	 * configuration, otherwise the register will have its values reset
 	 * (on my ar9220 to value 0x01002310)
diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 3689e12db9f7..2fb73a5e1d51 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -79,7 +79,7 @@ static int ath9k_get_max_index_ht40(struct ath9k_dfs_fft_40 *fft,
 	const int DFS_UPPER_BIN_OFFSET = 64;
 	/* if detected radar on both channels, select the significant one */
 	if (is_ctl && is_ext) {
-		/* first check wether channels have 'strong' bins */
+		/* first check whether channels have 'strong' bins */
 		is_ctl = fft_bitmap_weight(fft->lower_bins) != 0;
 		is_ext = fft_bitmap_weight(fft->upper_bins) != 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 7265766cddbd..fe9abe8cd268 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1198,7 +1198,7 @@ static int ath9k_hif_request_firmware(struct hif_device_usb *hif_dev,
 			filename = FIRMWARE_AR9271;
 
 		/* expected fw locations:
-		 * - htc_9271.fw   (stable version 1.3, depricated)
+		 * - htc_9271.fw   (stable version 1.3, deprecated)
 		 */
 		snprintf(hif_dev->fw_name, sizeof(hif_dev->fw_name),
 			 "%s", filename);
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index e2bef099adb3..e6301ab768b1 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2149,7 +2149,7 @@ static void ath9k_set_power_network_sleep(struct ath_hw *ah)
 
 		/* When chip goes into network sleep, it could be waken
 		 * up by MCI_INT interrupt caused by BT's HW messages
-		 * (LNA_xxx, CONT_xxx) which chould be in a very fast
+		 * (LNA_xxx, CONT_xxx) which could be in a very fast
 		 * rate (~100us). This will cause chip to leave and
 		 * re-enter network sleep mode frequently, which in
 		 * consequence will have WLAN MCI HW to generate lots of
@@ -2544,7 +2544,7 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 
 	pCap->tx_chainmask = ah->eep_ops->get_eeprom(ah, EEP_TX_MASK);
 	/*
-	 * For AR9271 we will temporarilly uses the rx chainmax as read from
+	 * For AR9271 we will temporarily uses the rx chainmax as read from
 	 * the EEPROM.
 	 */
 	if ((ah->hw_version.devid == AR5416_DEVID_PCI) &&
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 450ab19b1d4e..e2cbf3f00da0 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -282,7 +282,7 @@ enum ath9k_hw_caps {
  * an exact user defined pattern or de-authentication/disassoc pattern.
  * @ATH9K_HW_WOW_PATTERN_MATCH_DWORD: device requires the first four
  * bytes of the pattern for user defined pattern, de-authentication and
- * disassociation patterns for all types of possible frames recieved
+ * disassociation patterns for all types of possible frames received
  * of those types.
  */
 
diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index f03d792732da..16203e7ecf29 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -251,7 +251,7 @@ struct ath_desc {
  * when the descriptor is specifically marked to generate
  * an interrupt with this flag. Descriptors should be
  * marked periodically to insure timely replenishing of the
- * supply needed for sending frames. Defering interrupts
+ * supply needed for sending frames. Deferring interrupts
  * reduces system load and potentially allows more concurrent
  * work to be done but if done to aggressively can cause
  * senders to backup. When the hardware queue is left too
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index b92c89dad8de..dd7910782858 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1001,7 +1001,7 @@ static bool ath9k_uses_beacons(int type)
 static void ath9k_vif_iter_set_beacon(struct ath9k_vif_iter_data *iter_data,
 				      struct ieee80211_vif *vif)
 {
-	/* Use the first (configured) interface, but prefering AP interfaces. */
+	/* Use the first (configured) interface, but preferring AP interfaces. */
 	if (!iter_data->primary_beacon_vif) {
 		iter_data->primary_beacon_vif = vif;
 	} else {
diff --git a/drivers/net/wireless/ath/ath9k/wow.c b/drivers/net/wireless/ath/ath9k/wow.c
index 8d0b1730a9d5..ed4152cd44f0 100644
--- a/drivers/net/wireless/ath/ath9k/wow.c
+++ b/drivers/net/wireless/ath/ath9k/wow.c
@@ -60,7 +60,7 @@ static int ath9k_wow_add_disassoc_deauth_pattern(struct ath_softc *sc)
 	memset(dis_deauth_mask, 0, MAX_PATTERN_SIZE);
 
 	/*
-	 * Create Dissassociate / Deauthenticate packet filter
+	 * Create Disassociate / Deauthenticate packet filter
 	 *
 	 *     2 bytes        2 byte    6 bytes   6 bytes  6 bytes
 	 *  +--------------+----------+---------+--------+--------+----
@@ -70,7 +70,7 @@ static int ath9k_wow_add_disassoc_deauth_pattern(struct ath_softc *sc)
 	 * The above is the management frame format for disassociate/
 	 * deauthenticate pattern, from this we need to match the first byte
 	 * of 'Frame Control' and DA, SA, and BSSID fields
-	 * (skipping 2nd byte of FC and Duration feild.
+	 * (skipping 2nd byte of FC and Duration field.
 	 *
 	 * Disassociate pattern
 	 * --------------------
@@ -225,7 +225,7 @@ int ath9k_suspend(struct ieee80211_hw *hw,
 	ath9k_stop_btcoex(sc);
 
 	/*
-	 * Enable wake up on recieving disassoc/deauth
+	 * Enable wake up on receiving disassoc/deauth
 	 * frame by default.
 	 */
 	ret = ath9k_wow_add_disassoc_deauth_pattern(sc);
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 35aa47a9db90..0a24439dd30d 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -557,7 +557,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 			/*
 			 * AR5416 can become deaf/mute when BA
 			 * issue happens. Chip needs to be reset.
-			 * But AP code may have sychronization issues
+			 * But AP code may have synchronization issues
 			 * when perform internal reset in this routine.
 			 * Only enable reset in STA mode for now.
 			 */
-- 
2.47.0


