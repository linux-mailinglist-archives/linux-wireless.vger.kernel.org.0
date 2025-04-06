Return-Path: <linux-wireless+bounces-21170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5631A7CE2F
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 15:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B426188B376
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC58205E3F;
	Sun,  6 Apr 2025 13:44:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9DF9EC
	for <linux-wireless@vger.kernel.org>; Sun,  6 Apr 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743947065; cv=none; b=B7a5PN4VkRBSPWb9Ur/x8SIH96fW8od0Yp8nYV49tzH2wO6mnMJaJA7+VBZyqe+05P5joy4ETnvWOtCczfRakuSVgwsSj3yN2NxUwlgBxNA88P6MrvG4GctUPEtccY/FTWI39OneJEROkqdbb4dHPsVMACAqFvnbDxZE7FX4/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743947065; c=relaxed/simple;
	bh=oIuJNh+o5K4aDGmWce10xjyKs8Mdcm+p2kB9ZjoIK/w=;
	h=Message-Id:From:Date:Subject:To:Cc; b=b6kj0iflwHquK4M359o4hbEoW5sMyTrvx8J+EC44GzEj1RZ54aGnEEPxMk8z1NhpajHs3AVUgkS6tUzmW1JS3M/mobxmG8d7DS4JzhCpM1wLfOCPEREgIHbvwYqkyTPNOqg6vUHYJKGLRYVZ/nFY2Y2Ovk81Zu4tjLrnbZLoOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4AE682C0526E;
	Sun,  6 Apr 2025 15:44:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 074B130036; Sun,  6 Apr 2025 15:44:12 +0200 (CEST)
Message-Id: <f435bd9c8186176ffa12fd3650fac71cacdeebe1.1743946314.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 6 Apr 2025 15:43:30 +0200
Subject: [PATCH v2] wifi: iwlwifi: mld: fix building with CONFIG_PM_SLEEP
 disabled
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Benjamin Berg <benjamin.berg@intel.com>, Yedidya Benshimol <yedidya.ben.shimol@intel.com>, Arnd Bergmann <arnd@arndb.de>, Avraham Stern <avraham.stern@intel.com>, Daniel Gabay <daniel.gabay@intel.com>, Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, Shaul Triebitz <shaul.triebitz@intel.com>
Cc: linux-wireless@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver causes multiple build problems when CONFIG_PM_SLEEP
is disabled:

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

Hide the unused functions and make sure the 'ret' variable is initialized
before being used.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202504032255.N6ptuCNG-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[lukas: initialize ret to 0, use static inline]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
 Initialize ret to 0 instead of removing it from the if-clause (Miriam).
 Use static inline for iwl_mld_no_wowlan_suspend() instead of an #ifdef
 in accordance with section 21 of Documentation/process/coding-style.rst.

Link to v1:
 https://lore.kernel.org/r/20250325084340.378724-1-arnd@kernel.org/

 drivers/net/wireless/intel/iwlwifi/mld/d3.h       | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.h b/drivers/net/wireless/intel/iwlwifi/mld/d3.h
index 618d6fb..4157f82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.h
@@ -34,6 +34,7 @@ struct iwl_mld_wowlan_data {
 	struct iwl_mld_rekey_data rekey_data;
 };
 
+#ifdef CONFIG_PM_SLEEP
 int iwl_mld_no_wowlan_resume(struct iwl_mld *mld);
 int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld);
 int iwl_mld_wowlan_suspend(struct iwl_mld *mld,
@@ -47,5 +48,8 @@ void iwl_mld_ipv6_addr_change(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct inet6_dev *idev);
 #endif
+#else
+static inline int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld) { return 0; }
+#endif
 
 #endif /* __iwl_mld_d3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 6851064..18cd607 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -475,8 +475,8 @@ int iwl_mld_register_hw(struct iwl_mld *mld)
 int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
-	int ret;
 	bool in_d3 = false;
+	int ret = 0;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
@@ -1943,6 +1943,7 @@ static void iwl_mld_sta_rc_update(struct ieee80211_hw *hw,
 	}
 }
 
+#ifdef CONFIG_PM_SLEEP
 static void iwl_mld_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
@@ -1994,6 +1995,7 @@ static int iwl_mld_resume(struct ieee80211_hw *hw)
 
 	return 0;
 }
+#endif
 
 static int iwl_mld_alloc_ptk_pn(struct iwl_mld *mld,
 				struct iwl_mld_sta *mld_sta,
-- 
2.43.0


