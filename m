Return-Path: <linux-wireless+bounces-20794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7EDA6EBE3
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 09:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046AE188C4CD
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055A2528E5;
	Tue, 25 Mar 2025 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBuWqGS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78447D530;
	Tue, 25 Mar 2025 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892226; cv=none; b=RARNX8Wk2ZTkPFVAh29vLoLtdcIT0Fpw/LYN6s8dkFYsOJO2jxGLuuqIAXxigWDmNgA5YNdcTNxf0sCwKp3vg1BOl1HtNBF18ntNX47RFRb6NBAvb1X8OPVa6BxkDvtENUc95uvsFDZqU4X8qr3UawGoEXkE+gYgYSx8GFCAgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892226; c=relaxed/simple;
	bh=87zwA4C9SFzpaeniES/1S8GNdBde+cswnUuu9rcZGnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vEuxqk3QH9okO2TB6HJ/Q0QosjD6tPajE1hDW6GNm/nj442b6jlONOiajkOb7Fr+trj5niyxuY+McEtjuR4+rqwWWeK/wkMFCZ4yZtwygSzUcWSoiI2eN8OV0GPqr90dofZZhROOh61B0naFXzV5PrmHX46f26NmxuFelaDY+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBuWqGS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F431C4CEE4;
	Tue, 25 Mar 2025 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742892225;
	bh=87zwA4C9SFzpaeniES/1S8GNdBde+cswnUuu9rcZGnE=;
	h=From:To:Cc:Subject:Date:From;
	b=bBuWqGS6LZVddJfmv8eT3vWQhKqLZmRtvhrN22/SHTgNXNMBRLVzjGuMNAoY4+4Fn
	 x646HJnNMcJ4zTYRj62fW2nRwZuMjQLIMD3FhTom0VaA6Xr/t7L0Ii78bMqWyU/86f
	 TxO5BNb3FYbRkVoTiHSIhtcBxlcG0UZshGfsGsDVH1nc4t4xpzZDF3B3wBuN1wdoqn
	 4ZvndLUEopBJkEEqAbetyPG4kd2O81Kk7tyW+v5nmckvYVYRA1yclxfD24GuTDuAoV
	 UgJ0KxHYb0tu9XuYNzH8At8sIeT43OikUm+4A7IpgEjlUJ+VEn9fH+15yXMi/7Oeco
	 bpHTdiiL1AjsQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: mld: fix building with CONFIG_PM_SLEEP disabled
Date: Tue, 25 Mar 2025 09:43:30 +0100
Message-Id: <20250325084340.378724-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver causes multiple build problems when CONFIG_PM_SLEEP is
disabled:

drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1982:12: error: 'iwl_mld_resume' defined but not used [-Werror=unused-function]
 1982 | static int iwl_mld_resume(struct ieee80211_hw *hw)
      |            ^~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1960:1: error: 'iwl_mld_suspend' defined but not used [-Werror=unused-function]
 1960 | iwl_mld_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
      | ^~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1946:13: error: 'iwl_mld_set_wakeup' defined but not used [-Werror=unused-function]
 1946 | static void iwl_mld_set_wakeup(struct ieee80211_hw *hw, bool enabled)
      |             ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mld/mac80211.c: In function 'iwl_mld_mac80211_start':
drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:504:20: error: 'ret' is used uninitialized [-Werror=uninitialized]
  504 |         if (!in_d3 || ret) {
      |                    ^~
drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:478:13: note: 'ret' was declared here
  478 |         int ret;
      |             ^~~

Hide the unused functions and make sure the 'ret' variable is not used
before the initialization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 6851064b82da..0b5bc5abb82d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -501,7 +501,7 @@ int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
 		iwl_mld_restart_cleanup(mld);
 	}
 
-	if (!in_d3 || ret) {
+	if (!in_d3) {
 		ret = iwl_mld_start_fw(mld);
 		if (ret)
 			goto error;
@@ -537,7 +537,8 @@ void iwl_mld_mac80211_stop(struct ieee80211_hw *hw, bool suspend)
 	/* if the suspend flow fails the fw is in error. Stop it here, and it
 	 * will be started upon wakeup
 	 */
-	if (!suspend || iwl_mld_no_wowlan_suspend(mld))
+	if (!suspend ||
+	    (IS_ENABLED(CONFIG_PM_SLEEP) && iwl_mld_no_wowlan_suspend(mld)))
 		iwl_mld_stop_fw(mld);
 
 	/* HW is stopped, no more coming RX. OTOH, the worker can't run as the
@@ -1943,6 +1944,7 @@ static void iwl_mld_sta_rc_update(struct ieee80211_hw *hw,
 	}
 }
 
+#ifdef CONFIG_PM_SLEEP
 static void iwl_mld_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
@@ -1994,6 +1996,7 @@ static int iwl_mld_resume(struct ieee80211_hw *hw)
 
 	return 0;
 }
+#endif
 
 static int iwl_mld_alloc_ptk_pn(struct iwl_mld *mld,
 				struct iwl_mld_sta *mld_sta,
-- 
2.39.5


