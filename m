Return-Path: <linux-wireless+bounces-9199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3390D922
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78901F24FC2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCC64D8A4;
	Tue, 18 Jun 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhQ8/bqh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E297347E
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727866; cv=none; b=cbpKPpzcofBf0cB4DNR1b55ubblkuJCllHIAHUk8Mldkb6oIiA43Yr3BbyHcfZhoi2rR5NA61LYSuQvPx3UcOMAHmDxbztVXyQVSwUb6PDfFXIXX5065XegqNc2gUV2nQ1Xap61DDNyWSMoxKdKVjPcpsIansIHHCJ6EGU271p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727866; c=relaxed/simple;
	bh=VOje7kmvdK9+0Du0dDRXC8KqclOApSk+jNBUxXyha2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svhG31j3HrOP79tqJ8Mm0WKbcDlUi2x0c0ul73e9n/XPjngTO6NPIq7T0uqYke1THVr1Uom67ED1LTrVjXXxSVYlj4nvIsYNR9KYnF5bbFbdKjSiOjH8966q2WwPj0nFwmrI4eNvzE3cxnU3F5bR10XGmL4RtQ1jqQenCGIsM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhQ8/bqh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718727864; x=1750263864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VOje7kmvdK9+0Du0dDRXC8KqclOApSk+jNBUxXyha2A=;
  b=QhQ8/bqhgO5MDqnGggdb1dlNqB7o1LEYFoM7UCUacWo2kx8ZDWm2T47x
   npixk3OLiVFSS5VxxCjE9MUAsTwldmbnQL+T7lF/Usivz0fQmFmAIjBPn
   EL1ibVWHbjX1HPvyPWmbGKsn2Ui3W/x0Q8hlIXiQlaplef5kV/HYMLUjt
   95jgwvStifDXGoCdhRj0KtAF3QpSs++XZzJUSxt/0CnVlpyIO+oJNuGQ6
   ubUvc3EW8NcGC+yIuK5REjICl6GNxrFqZD6H1OmdZFh0t/Q7B8PFxB5l7
   07c4/5GmGy92RViUl8OXOHM22wYlUdhVGA70T8sObywrxSo+R3smvTig9
   w==;
X-CSE-ConnectionGUID: gZRP2R4OS1algIoLiNprjA==
X-CSE-MsgGUID: 0KRqXmtyT6irAb2gVNMElg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="41030213"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41030213"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:24:23 -0700
X-CSE-ConnectionGUID: 3eMQY+dfQMSSLr9fyXxRsQ==
X-CSE-MsgGUID: wluUYYkcRWalN2daJSYSUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41558514"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:24:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] wifi: mac80211: inform the low level if drv_stop() is a suspend
Date: Tue, 18 Jun 2024 19:24:14 +0300
Message-Id: <20240618192351.e117673dc95f.Ie18a2fe8e02bf2717549d39420b350cfdaf3d317@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will allow the low level driver to take different actions for
different flows.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/admtek/adm8211.c             |  2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c          |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c             |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c             |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c             |  2 +-
 drivers/net/wireless/ath/ath5k/base.c             |  2 +-
 drivers/net/wireless/ath/ath5k/base.h             |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c     |  2 +-
 drivers/net/wireless/ath/ath9k/main.c             |  2 +-
 drivers/net/wireless/ath/carl9170/main.c          |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c           |  2 +-
 drivers/net/wireless/atmel/at76c50x-usb.c         |  2 +-
 drivers/net/wireless/broadcom/b43/main.c          |  2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c    |  2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c     |  2 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c    |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c    |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965.h        |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  2 +-
 drivers/net/wireless/intersil/p54/main.c          |  2 +-
 drivers/net/wireless/marvell/libertas_tf/main.c   |  2 +-
 drivers/net/wireless/marvell/mwl8k.c              |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt792x.h       |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt792x_core.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c      |  2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c        |  2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.h        |  2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c        |  4 ++--
 drivers/net/wireless/ralink/rt2x00/rt2x00.h       |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c    |  2 +-
 .../net/wireless/realtek/rtl818x/rtl8180/dev.c    |  2 +-
 .../net/wireless/realtek/rtl818x/rtl8187/dev.c    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c      |  2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c       |  4 ++--
 drivers/net/wireless/realtek/rtw88/mac80211.c     |  2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c     |  2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c       |  2 +-
 drivers/net/wireless/silabs/wfx/sta.c             |  2 +-
 drivers/net/wireless/silabs/wfx/sta.h             |  2 +-
 drivers/net/wireless/st/cw1200/sta.c              |  2 +-
 drivers/net/wireless/st/cw1200/sta.h              |  2 +-
 drivers/net/wireless/ti/wl1251/main.c             |  2 +-
 drivers/net/wireless/ti/wlcore/main.c             |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c     |  2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c      |  2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.h      |  2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c      |  2 +-
 drivers/staging/vt6655/device_main.c              |  2 +-
 drivers/staging/vt6656/main_usb.c                 |  2 +-
 include/net/mac80211.h                            |  2 +-
 net/mac80211/driver-ops.c                         |  6 +++---
 net/mac80211/driver-ops.h                         |  2 +-
 net/mac80211/ieee80211_i.h                        |  2 +-
 net/mac80211/iface.c                              |  4 ++--
 net/mac80211/pm.c                                 |  4 ++--
 net/mac80211/trace.h                              | 15 ++++++++++++---
 net/mac80211/util.c                               |  4 ++--
 70 files changed, 92 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index e3fd48dd3909..a2d87c3ad196 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -1550,7 +1550,7 @@ static int adm8211_start(struct ieee80211_hw *dev)
 	return retval;
 }
 
-static void adm8211_stop(struct ieee80211_hw *dev)
+static void adm8211_stop(struct ieee80211_hw *dev, bool suspend)
 {
 	struct adm8211_priv *priv = dev->priv;
 
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 5a55db349cb5..156f3650c006 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1061,7 +1061,7 @@ static int ar5523_start(struct ieee80211_hw *hw)
 	return error;
 }
 
-static void ar5523_stop(struct ieee80211_hw *hw)
+static void ar5523_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ar5523 *ar = hw->priv;
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3bf67b2ecd6d..a5da32e87106 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5363,7 +5363,7 @@ static int ath10k_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void ath10k_stop(struct ieee80211_hw *hw)
+static void ath10k_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath10k *ar = hw->priv;
 	u32 opt;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a1800c75d32b..c9a13b88c804 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6278,7 +6278,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
+static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath11k *ar = hw->priv;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 509c02bffdae..bd3e021e2a81 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6112,7 +6112,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
 }
 
-static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
+static void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 9f534ed2fbb3..abe41330fb69 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -2847,7 +2847,7 @@ static void ath5k_stop_tasklets(struct ath5k_hw *ah)
  * if another thread does a system call and the thread doing the
  * stop is preempted).
  */
-void ath5k_stop(struct ieee80211_hw *hw)
+void ath5k_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath5k_hw *ah = hw->priv;
 	int ret;
diff --git a/drivers/net/wireless/ath/ath5k/base.h b/drivers/net/wireless/ath/ath5k/base.h
index 97469d0fbad7..594e5b945cb7 100644
--- a/drivers/net/wireless/ath/ath5k/base.h
+++ b/drivers/net/wireless/ath/ath5k/base.h
@@ -92,7 +92,7 @@ void ath5k_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif);
 bool ath5k_any_vif_assoc(struct ath5k_hw *ah);
 
 int ath5k_start(struct ieee80211_hw *hw);
-void ath5k_stop(struct ieee80211_hw *hw);
+void ath5k_stop(struct ieee80211_hw *hw, bool suspend);
 
 void ath5k_beacon_update_timers(struct ath5k_hw *ah, u64 bc_tsf);
 int ath5k_beacon_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index b389e19381c4..8a03bcc2789e 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -973,7 +973,7 @@ static int ath9k_htc_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void ath9k_htc_stop(struct ieee80211_hw *hw)
+static void ath9k_htc_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath9k_htc_priv *priv = hw->priv;
 	struct ath_hw *ah = priv->ah;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 01173aac3045..b92c89dad8de 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -895,7 +895,7 @@ static void ath9k_pending_key_del(struct ath_softc *sc, u8 keyix)
 	ath_key_delete(common, keyix);
 }
 
-static void ath9k_stop(struct ieee80211_hw *hw)
+static void ath9k_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_hw *ah = sc->sc_ah;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 7e7797bf44b7..755c068e4197 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -439,7 +439,7 @@ static void carl9170_cancel_worker(struct ar9170 *ar)
 	cancel_work_sync(&ar->ampdu_work);
 }
 
-static void carl9170_op_stop(struct ieee80211_hw *hw)
+static void carl9170_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ar9170 *ar = hw->priv;
 
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index e760d8002e09..408776562a7e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -278,7 +278,7 @@ static int wcn36xx_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void wcn36xx_stop(struct ieee80211_hw *hw)
+static void wcn36xx_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct wcn36xx *wcn = hw->priv;
 
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index baa53cfefe48..504e05ea30f2 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -1850,7 +1850,7 @@ static int at76_mac80211_start(struct ieee80211_hw *hw)
 	return 0;
 }
 
-static void at76_mac80211_stop(struct ieee80211_hw *hw)
+static void at76_mac80211_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct at76_priv *priv = hw->priv;
 
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index badb2f494035..8e56dcf9309d 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5078,7 +5078,7 @@ static int b43_op_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-static void b43_op_stop(struct ieee80211_hw *hw)
+static void b43_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
 	struct b43_wldev *dev = wl->current_dev;
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 18eb610f600a..441d6440671b 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -3485,7 +3485,7 @@ static int b43legacy_op_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-static void b43legacy_op_stop(struct ieee80211_hw *hw)
+static void b43legacy_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct b43legacy_wl *wl = hw_to_b43legacy_wl(hw);
 	struct b43legacy_wldev *dev = wl->current_dev;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 860ef9c11c46..9ac6f3c4bdc7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -457,7 +457,7 @@ static int brcms_ops_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-static void brcms_ops_stop(struct ieee80211_hw *hw)
+static void brcms_ops_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct brcms_info *wl = hw->priv;
 	int status;
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 075b705a8d7b..74fc76c00ebc 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -2813,7 +2813,7 @@ il3945_mac_start(struct ieee80211_hw *hw)
 }
 
 static void
-il3945_mac_stop(struct ieee80211_hw *hw)
+il3945_mac_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct il_priv *il = hw->priv;
 
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index d018f56be966..1600c344edbb 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -5820,7 +5820,7 @@ il4965_mac_start(struct ieee80211_hw *hw)
 }
 
 void
-il4965_mac_stop(struct ieee80211_hw *hw)
+il4965_mac_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct il_priv *il = hw->priv;
 
diff --git a/drivers/net/wireless/intel/iwlegacy/4965.h b/drivers/net/wireless/intel/iwlegacy/4965.h
index 863e3792d153..951f2245fefb 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965.h
+++ b/drivers/net/wireless/intel/iwlegacy/4965.h
@@ -151,7 +151,7 @@ void il4965_mac_tx(struct ieee80211_hw *hw,
 		   struct ieee80211_tx_control *control,
 		   struct sk_buff *skb);
 int il4965_mac_start(struct ieee80211_hw *hw);
-void il4965_mac_stop(struct ieee80211_hw *hw);
+void il4965_mac_stop(struct ieee80211_hw *hw, bool suspend);
 void il4965_configure_filter(struct ieee80211_hw *hw,
 			     unsigned int changed_flags,
 			     unsigned int *total_flags, u64 multicast);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 826f129ecefa..74d163e56511 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -300,7 +300,7 @@ static int iwlagn_mac_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void iwlagn_mac_stop(struct ieee80211_hw *hw)
+static void iwlagn_mac_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct iwl_priv *priv = IWL_MAC80211_GET_DVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 81103a974b20..896e560f5a82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1376,7 +1376,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 	}
 }
 
-void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
+void iwl_mvm_mac_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bce517effe55..54c3553db219 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2818,7 +2818,7 @@ int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant);
 int iwl_mvm_mac_start(struct ieee80211_hw *hw);
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 				   enum ieee80211_reconfig_type reconfig_type);
-void iwl_mvm_mac_stop(struct ieee80211_hw *hw);
+void iwl_mvm_mac_stop(struct ieee80211_hw *hw, bool suspend);
 static inline int iwl_mvm_mac_config(struct ieee80211_hw *hw, u32 changed)
 {
 	return 0;
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index 687841b2fa2a..42111bb53f58 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -197,7 +197,7 @@ static int p54_start(struct ieee80211_hw *dev)
 	return err;
 }
 
-static void p54_stop(struct ieee80211_hw *dev)
+static void p54_stop(struct ieee80211_hw *dev, bool suspend)
 {
 	struct p54_common *priv = dev->priv;
 	int i;
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 9cca69fe04d7..b47a832b9ae2 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -267,7 +267,7 @@ static int lbtf_op_start(struct ieee80211_hw *hw)
 	return 0;
 }
 
-static void lbtf_op_stop(struct ieee80211_hw *hw)
+static void lbtf_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct lbtf_private *priv = hw->priv;
 	unsigned long flags;
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 241a02a0accd..b130e057370f 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -4768,7 +4768,7 @@ static int mwl8k_start(struct ieee80211_hw *hw)
 	return rc;
 }
 
-static void mwl8k_stop(struct ieee80211_hw *hw)
+static void mwl8k_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mwl8k_priv *priv = hw->priv;
 	int i;
@@ -6023,7 +6023,7 @@ static int mwl8k_reload_firmware(struct ieee80211_hw *hw, char *fw_image)
 	struct mwl8k_priv *priv = hw->priv;
 	struct mwl8k_vif *vif, *tmp_vif;
 
-	mwl8k_stop(hw);
+	mwl8k_stop(hw, false);
 	mwl8k_rxq_deinit(hw, 0);
 
 	/*
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 9b49267b1eab..f35fa643c0da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -23,7 +23,7 @@ mt7603_start(struct ieee80211_hw *hw)
 }
 
 static void
-mt7603_stop(struct ieee80211_hw *hw)
+mt7603_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt7603_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c27acaf0eb1c..50e262c1622f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -91,7 +91,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void mt7615_stop(struct ieee80211_hw *hw)
+static void mt7615_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index df737e1ff27b..9335ca0776fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -79,7 +79,7 @@ static void mt7663u_copy(struct mt76_dev *dev, u32 offset,
 	mutex_unlock(&usb->usb_ctrl_mtx);
 }
 
-static void mt7663u_stop(struct ieee80211_hw *hw)
+static void mt7663u_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mt7615_dev *dev = hw->priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 79b7996ad1a8..2ecee7c5c80d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -44,7 +44,7 @@ static void mt76x0e_stop_hw(struct mt76x02_dev *dev)
 	mt76_clear(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_RX_DMA_EN);
 }
 
-static void mt76x0e_stop(struct ieee80211_hw *hw)
+static void mt76x0e_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index bba44f289b4e..390f502e97f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -77,7 +77,7 @@ static void mt76x0u_cleanup(struct mt76x02_dev *dev)
 	mt76u_queues_deinit(&dev->mt76);
 }
 
-static void mt76x0u_stop(struct ieee80211_hw *hw)
+static void mt76x0u_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index bfc8c69f43fa..6accea551319 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -24,7 +24,7 @@ mt76x2_start(struct ieee80211_hw *hw)
 }
 
 static void
-mt76x2_stop(struct ieee80211_hw *hw)
+mt76x2_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 9fe390fdd730..ba0241c36672 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -22,7 +22,7 @@ static int mt76x2u_start(struct ieee80211_hw *hw)
 	return 0;
 }
 
-static void mt76x2u_stop(struct ieee80211_hw *hw)
+static void mt76x2u_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2624edbb59a1..049223df9beb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -108,7 +108,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void mt7915_stop(struct ieee80211_hw *hw)
+static void mt7915_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3e3ad3518d85..4f30426afbb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -268,7 +268,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-static void mt7921_stop(struct ieee80211_hw *hw)
+static void mt7921_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	int err = 0;
@@ -281,7 +281,7 @@ static void mt7921_stop(struct ieee80211_hw *hw)
 			return;
 	}
 
-	mt792x_stop(hw);
+	mt792x_stop(hw, false);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 20578497a405..cf14a38c5e72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -251,7 +251,7 @@ static inline bool mt792x_dma_need_reinit(struct mt792x_dev *dev)
 #define mt792x_mutex_release(dev)	\
 	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
 
-void mt792x_stop(struct ieee80211_hw *hw);
+void mt792x_stop(struct ieee80211_hw *hw, bool suspend);
 void mt792x_pm_wake_work(struct work_struct *work);
 void mt792x_pm_power_save_work(struct work_struct *work);
 void mt792x_reset(struct mt76_dev *mdev);
@@ -368,7 +368,7 @@ void mt792xu_wr(struct mt76_dev *dev, u32 addr, u32 val);
 u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val);
 void mt792xu_copy(struct mt76_dev *dev, u32 offset, const void *data, int len);
 void mt792xu_disconnect(struct usb_interface *usb_intf);
-void mt792xu_stop(struct ieee80211_hw *hw);
+void mt792xu_stop(struct ieee80211_hw *hw, bool suspend);
 
 static inline void
 mt792x_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index a405af8d9052..4adca99eb9b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -91,7 +91,7 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 }
 EXPORT_SYMBOL_GPL(mt792x_tx);
 
-void mt792x_stop(struct ieee80211_hw *hw)
+void mt792x_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index b49668a4b784..76272a03b22e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -285,12 +285,12 @@ int mt792xu_init_reset(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792xu_init_reset);
 
-void mt792xu_stop(struct ieee80211_hw *hw)
+void mt792xu_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt76u_stop_tx(&dev->mt76);
-	mt792x_stop(hw);
+	mt792x_stop(hw, false);
 }
 EXPORT_SYMBOL_GPL(mt792xu_stop);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 7c97140d8255..bce082038219 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -93,7 +93,7 @@ static int mt7996_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void mt7996_stop(struct ieee80211_hw *hw)
+static void mt7996_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index a7330576486b..7570c6ceecea 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -28,7 +28,7 @@ static int mt7601u_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void mt7601u_stop(struct ieee80211_hw *hw)
+static void mt7601u_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mt7601u_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 641f847d47ab..eae93efa6150 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -111,7 +111,7 @@ int plfxlc_op_start(struct ieee80211_hw *hw)
 	return 0;
 }
 
-void plfxlc_op_stop(struct ieee80211_hw *hw)
+void plfxlc_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct plfxlc_mac *mac = plfxlc_hw_mac(hw);
 
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.h b/drivers/net/wireless/purelifi/plfxlc/mac.h
index 49b92413729b..9384acddcf26 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.h
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.h
@@ -178,7 +178,7 @@ int plfxlc_mac_rx(struct ieee80211_hw *hw, const u8 *buffer,
 void plfxlc_mac_tx_failed(struct urb *urb);
 void plfxlc_mac_tx_to_dev(struct sk_buff *skb, int error);
 int plfxlc_op_start(struct ieee80211_hw *hw);
-void plfxlc_op_stop(struct ieee80211_hw *hw);
+void plfxlc_op_stop(struct ieee80211_hw *hw, bool suspend);
 int plfxlc_restore_settings(struct plfxlc_mac *mac);
 
 #endif /* PLFXLC_MAC_H */
diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 311676c1ece0..15334940287d 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -408,7 +408,7 @@ void plfxlc_usb_init(struct plfxlc_usb *usb, struct ieee80211_hw *hw,
 
 void plfxlc_usb_release(struct plfxlc_usb *usb)
 {
-	plfxlc_op_stop(plfxlc_usb_to_hw(usb));
+	plfxlc_op_stop(plfxlc_usb_to_hw(usb), false);
 	plfxlc_usb_disable_tx(usb);
 	plfxlc_usb_disable_rx(usb);
 	usb_set_intfdata(usb->intf, NULL);
@@ -761,7 +761,7 @@ static void plfxlc_usb_resume(struct plfxlc_usb *usb)
 
 static void plfxlc_usb_stop(struct plfxlc_usb *usb)
 {
-	plfxlc_op_stop(plfxlc_usb_to_hw(usb));
+	plfxlc_op_stop(plfxlc_usb_to_hw(usb), false);
 	plfxlc_usb_disable_tx(usb);
 	plfxlc_usb_disable_rx(usb);
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index bb648f95dfdd..dfb4bb370f01 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1450,7 +1450,7 @@ void rt2x00mac_tx(struct ieee80211_hw *hw,
 		  struct ieee80211_tx_control *control,
 		  struct sk_buff *skb);
 int rt2x00mac_start(struct ieee80211_hw *hw);
-void rt2x00mac_stop(struct ieee80211_hw *hw);
+void rt2x00mac_stop(struct ieee80211_hw *hw, bool suspend);
 void rt2x00mac_reconfig_complete(struct ieee80211_hw *hw,
 				 enum ieee80211_reconfig_type reconfig_type);
 int rt2x00mac_add_interface(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 75fda72c14ca..451632488805 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -178,7 +178,7 @@ int rt2x00mac_start(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(rt2x00mac_start);
 
-void rt2x00mac_stop(struct ieee80211_hw *hw)
+void rt2x00mac_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index 77b6cb7e1f6b..ded8d4d59289 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1249,7 +1249,7 @@ static int rtl8180_start(struct ieee80211_hw *dev)
 	return ret;
 }
 
-static void rtl8180_stop(struct ieee80211_hw *dev)
+static void rtl8180_stop(struct ieee80211_hw *dev, bool suspend)
 {
 	struct rtl8180_priv *priv = dev->priv;
 	u8 reg;
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 78d99afa373d..220ac5bdf279 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1019,7 +1019,7 @@ static int rtl8187_start(struct ieee80211_hw *dev)
 	return ret;
 }
 
-static void rtl8187_stop(struct ieee80211_hw *dev)
+static void rtl8187_stop(struct ieee80211_hw *dev, bool suspend)
 {
 	struct rtl8187_priv *priv = dev->priv;
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 89a841b4e8d5..3685dbefc9bd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7521,7 +7521,7 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void rtl8xxxu_stop(struct ieee80211_hw *hw)
+static void rtl8xxxu_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 	unsigned long flags;
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 42b7db12b1bd..7537f04b1930 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -144,7 +144,7 @@ static int rtl_op_start(struct ieee80211_hw *hw)
 	return err;
 }
 
-static void rtl_op_stop(struct ieee80211_hw *hw)
+static void rtl_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -547,7 +547,7 @@ static int rtl_op_suspend(struct ieee80211_hw *hw,
 	rtlhal->enter_pnp_sleep = true;
 
 	rtl_lps_leave(hw, true);
-	rtl_op_stop(hw);
+	rtl_op_stop(hw, false);
 	device_set_wakeup_enable(wiphy_dev(hw->wiphy), true);
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 0acebbfa13c4..63326b352738 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -62,7 +62,7 @@ static int rtw_ops_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void rtw_ops_stop(struct ieee80211_hw *hw)
+static void rtw_ops_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 41b286da3d59..722d09e9fbb5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -66,7 +66,7 @@ static int rtw89_ops_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void rtw89_ops_stop(struct ieee80211_hw *hw)
+static void rtw89_ops_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 211fa25b9a78..ee0f5d912dab 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -413,7 +413,7 @@ static int rsi_mac80211_start(struct ieee80211_hw *hw)
  *
  * Return: None.
  */
-static void rsi_mac80211_stop(struct ieee80211_hw *hw)
+static void rsi_mac80211_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index a904602f02ce..216d43c8bd6e 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -805,7 +805,7 @@ int wfx_start(struct ieee80211_hw *hw)
 	return 0;
 }
 
-void wfx_stop(struct ieee80211_hw *hw)
+void wfx_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct wfx_dev *wdev = hw->priv;
 
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index c478ddcb934b..7817c7c6f3dd 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -20,7 +20,7 @@ struct wfx_sta_priv {
 
 /* mac80211 interface */
 int wfx_start(struct ieee80211_hw *hw);
-void wfx_stop(struct ieee80211_hw *hw);
+void wfx_stop(struct ieee80211_hw *hw, bool suspend);
 int wfx_config(struct ieee80211_hw *hw, u32 changed);
 int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
 void wfx_set_default_unicast_key(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int idx);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 8ef1d06b9bbd..c259da8161e4 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -90,7 +90,7 @@ int cw1200_start(struct ieee80211_hw *dev)
 	return ret;
 }
 
-void cw1200_stop(struct ieee80211_hw *dev)
+void cw1200_stop(struct ieee80211_hw *dev, bool suspend)
 {
 	struct cw1200_common *priv = dev->priv;
 	LIST_HEAD(list);
diff --git a/drivers/net/wireless/st/cw1200/sta.h b/drivers/net/wireless/st/cw1200/sta.h
index a49f187c7049..b955b92cfd73 100644
--- a/drivers/net/wireless/st/cw1200/sta.h
+++ b/drivers/net/wireless/st/cw1200/sta.h
@@ -13,7 +13,7 @@
 /* mac80211 API								*/
 
 int cw1200_start(struct ieee80211_hw *dev);
-void cw1200_stop(struct ieee80211_hw *dev);
+void cw1200_stop(struct ieee80211_hw *dev, bool suspend);
 int cw1200_add_interface(struct ieee80211_hw *dev,
 			 struct ieee80211_vif *vif);
 void cw1200_remove_interface(struct ieee80211_hw *dev,
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index 0da2d29dd7bd..bb53d681c11b 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -415,7 +415,7 @@ static int wl1251_op_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void wl1251_op_stop(struct ieee80211_hw *hw)
+static void wl1251_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct wl1251 *wl = hw->priv;
 
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ef12169f8044..1fe1410ec9c7 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2006,7 +2006,7 @@ static void wlcore_op_stop_locked(struct wl1271 *wl)
 	memset(wl->reg_ch_conf_last, 0, sizeof(wl->reg_ch_conf_last));
 }
 
-static void wlcore_op_stop(struct ieee80211_hw *hw)
+static void wlcore_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct wl1271 *wl = hw->priv;
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index fbf24870209d..8491eb32f760 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2098,7 +2098,7 @@ static int mac80211_hwsim_start(struct ieee80211_hw *hw)
 }
 
 
-static void mac80211_hwsim_stop(struct ieee80211_hw *hw)
+static void mac80211_hwsim_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	int i;
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 900c063bd724..f90c33d19b39 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -326,7 +326,7 @@ int zd_op_start(struct ieee80211_hw *hw)
 	return r;
 }
 
-void zd_op_stop(struct ieee80211_hw *hw)
+void zd_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct zd_mac *mac = zd_hw_mac(hw);
 	struct zd_chip *chip = &mac->chip;
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.h b/drivers/net/wireless/zydas/zd1211rw/zd_mac.h
index 5ff84bdc5a4c..053748a474ec 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.h
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.h
@@ -303,7 +303,7 @@ void zd_mac_tx_failed(struct urb *urb);
 void zd_mac_tx_to_dev(struct sk_buff *skb, int error);
 
 int zd_op_start(struct ieee80211_hw *hw);
-void zd_op_stop(struct ieee80211_hw *hw);
+void zd_op_stop(struct ieee80211_hw *hw, bool suspend);
 int zd_restore_settings(struct zd_mac *mac);
 
 #ifdef DEBUG
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 2ee4218da1c5..a8a94edf2a70 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1476,7 +1476,7 @@ static void zd_usb_stop(struct zd_usb *usb)
 {
 	dev_dbg_f(zd_usb_dev(usb), "\n");
 
-	zd_op_stop(zd_usb_to_hw(usb));
+	zd_op_stop(zd_usb_to_hw(usb), false);
 
 	zd_usb_disable_tx(usb);
 	zd_usb_disable_rx(usb);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 283804b49e91..3ff8103366c1 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1339,7 +1339,7 @@ static int vnt_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void vnt_stop(struct ieee80211_hw *hw)
+static void vnt_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct vnt_private *priv = hw->priv;
 
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 7bbed462f062..4f09e733e7a8 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -613,7 +613,7 @@ static int vnt_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
-static void vnt_stop(struct ieee80211_hw *hw)
+static void vnt_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct vnt_private *priv = hw->priv;
 	int i;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ecfa65ade226..9c96e8ae9ef7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4444,7 +4444,7 @@ struct ieee80211_ops {
 		   struct ieee80211_tx_control *control,
 		   struct sk_buff *skb);
 	int (*start)(struct ieee80211_hw *hw);
-	void (*stop)(struct ieee80211_hw *hw);
+	void (*stop)(struct ieee80211_hw *hw, bool suspend);
 #ifdef CONFIG_PM
 	int (*suspend)(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan);
 	int (*resume)(struct ieee80211_hw *hw);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index dce37ba8ebe3..bef43990f07a 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -33,7 +33,7 @@ int drv_start(struct ieee80211_local *local)
 	return ret;
 }
 
-void drv_stop(struct ieee80211_local *local)
+void drv_stop(struct ieee80211_local *local, bool suspend)
 {
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -41,8 +41,8 @@ void drv_stop(struct ieee80211_local *local)
 	if (WARN_ON(!local->started))
 		return;
 
-	trace_drv_stop(local);
-	local->ops->stop(&local->hw);
+	trace_drv_stop(local, suspend);
+	local->ops->stop(&local->hw, suspend);
 	trace_drv_return_void(local);
 
 	/* sync away all work on the tasklet before clearing started */
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d4e73d3630e0..d382d9729e85 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -88,7 +88,7 @@ static inline int drv_get_et_sset_count(struct ieee80211_sub_if_data *sdata,
 }
 
 int drv_start(struct ieee80211_local *local);
-void drv_stop(struct ieee80211_local *local);
+void drv_stop(struct ieee80211_local *local, bool suspend);
 
 #ifdef CONFIG_PM
 static inline int drv_suspend(struct ieee80211_local *local,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3e735c9436d3..01f4d940c90c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2229,7 +2229,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 
 /* Suspend/resume and hw reconfiguration */
 int ieee80211_reconfig(struct ieee80211_local *local);
-void ieee80211_stop_device(struct ieee80211_local *local);
+void ieee80211_stop_device(struct ieee80211_local *local, bool suspend);
 
 int __ieee80211_suspend(struct ieee80211_hw *hw,
 			struct cfg80211_wowlan *wowlan);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6b7580c61e0c..4562aa57214e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -702,7 +702,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		wiphy_delayed_work_flush(local->hw.wiphy, &local->scan_work);
 
 	if (local->open_count == 0) {
-		ieee80211_stop_device(local);
+		ieee80211_stop_device(local, false);
 
 		/* no reconfiguring after stop! */
 		return;
@@ -1439,7 +1439,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	drv_remove_interface(local, sdata);
  err_stop:
 	if (!local->open_count)
-		drv_stop(local);
+		drv_stop(local, false);
  err_del_bss:
 	sdata->bss = NULL;
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index c1fa26e09479..d823d58303e8 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Portions
- * Copyright (C) 2020-2021, 2023 Intel Corporation
+ * Copyright (C) 2020-2021, 2023-2024 Intel Corporation
  */
 #include <net/mac80211.h>
 #include <net/rtnetlink.h>
@@ -171,7 +171,7 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	WARN_ON(!list_empty(&local->chanctx_list));
 
 	/* stop hardware - this must stop RX */
-	ieee80211_stop_device(local);
+	ieee80211_stop_device(local, true);
 
  suspend:
 	local->suspended = true;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index b26aacfbc622..dc498cd8cd91 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -328,9 +328,18 @@ TRACE_EVENT(drv_set_wakeup,
 	TP_printk(LOCAL_PR_FMT " enabled:%d", LOCAL_PR_ARG, __entry->enabled)
 );
 
-DEFINE_EVENT(local_only_evt, drv_stop,
-	TP_PROTO(struct ieee80211_local *local),
-	TP_ARGS(local)
+TRACE_EVENT(drv_stop,
+	TP_PROTO(struct ieee80211_local *local, bool suspend),
+	TP_ARGS(local, suspend),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(bool, suspend)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->suspend = suspend;
+	),
+	TP_printk(LOCAL_PR_FMT " suspend:%d", LOCAL_PR_ARG, __entry->suspend)
 );
 
 DEFINE_EVENT(local_sdata_addr_evt, drv_add_interface,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c73ff7dfbdba..2319f81f2051 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1565,7 +1565,7 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 	return supp_rates;
 }
 
-void ieee80211_stop_device(struct ieee80211_local *local)
+void ieee80211_stop_device(struct ieee80211_local *local, bool suspend)
 {
 	ieee80211_handle_queued_frames(local);
 
@@ -1576,7 +1576,7 @@ void ieee80211_stop_device(struct ieee80211_local *local)
 
 	flush_workqueue(local->workqueue);
 	wiphy_work_flush(local->hw.wiphy, NULL);
-	drv_stop(local);
+	drv_stop(local, suspend);
 }
 
 static void ieee80211_flush_completed_scan(struct ieee80211_local *local,
-- 
2.34.1


