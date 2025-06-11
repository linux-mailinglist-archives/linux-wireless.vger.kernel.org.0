Return-Path: <linux-wireless+bounces-24002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A9AD5F06
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25048176B7C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F7224AE1;
	Wed, 11 Jun 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnuWQPvC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C327CCDB
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670015; cv=none; b=Z0YQIgz3BKRVJkrW6OmWVan7mRVsbkoVsDDocw60wWXjHi5Pbmil1TkBmqyf+XHwUp2oY1HsF1EYF+8qUs7OxmAtrkZhZBG6tSpZ6wErA9gYcWc/CVpZSiJo2a3Zy8q/2AAQmS2z0GJPtzBTqPnAkNOslVlUfHvOE4+fungWLGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670015; c=relaxed/simple;
	bh=TAJrZEsJSgeAa4gixJOn+roF5tylPMHvxQFzabKcfEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS+52IqP0KDUvuLGjv75s6N7EiL9RawkaXW2xSzsE+w3YblWlhu1/YXIDSaHAuygnuQebksBwQdSXoyWTJfnUHbksg0GZW8D40pkzo5GWAR+KpmLarDg1x4IKrEQ/7esdZkF/pLYAbDzBfHBv3JFty1xfguENyz8hJBW9hVXJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnuWQPvC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670014; x=1781206014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAJrZEsJSgeAa4gixJOn+roF5tylPMHvxQFzabKcfEA=;
  b=GnuWQPvCbx4x24rR/drwd+UVKXWsckuETdDVXIXk4lh08EhTTVJcZw/b
   U6+RnlGXuXsnFKrkerNdBzA/oHdupuKVfDIxpog9/4qkLg3+ucK5Nv020
   CQFPThFBiXp5OKwkIgDjefTlLM0omqyjQa69iGrNt7QHM3Y8Ph+Mf2O/q
   U3I1fo22GCUSPlSO2i5BOToRERk3yNcVAFPrlQyrsbJ2f7Mwzd4Hb0C3C
   L/OJ/Iwbulo+k02/JQ7V844fagXehYDxpgtW8dBjA957DCXzXGtpjSwCm
   k/D6aofZ+46vVqIvWasBSjVl5cYzED4Kh2KMNVcxlggh274UFiXzIGyZF
   Q==;
X-CSE-ConnectionGUID: j+oZW4HUR0OK30f7XjGNiA==
X-CSE-MsgGUID: 45BNu7cfTZuL/IY+eH9Vwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360858"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360858"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:54 -0700
X-CSE-ConnectionGUID: KbzaW6y8Tcym/H5MiQUNqg==
X-CSE-MsgGUID: EXyyBzJKSCe/UWwAbw1s8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165830"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next v2 02/15] wifi: iwlwifi: add support for the devcoredump
Date: Wed, 11 Jun 2025 22:26:21 +0300
Message-Id: <20250611222325.bb38efe6700d.I9c666440dd1eac13ac52a2c2d533224c36fea2a6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

This handler will be used by upcoming changes to trigger
firmware dumps from devcoredump through trans layer.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c    |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 5dc299296d6d..a146d0e399f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -147,6 +147,8 @@ struct iwl_fw_error_dump_mode {
  *	Op_mode needs to reset its internal state because the device did not
  *	survive the system state transition. The firmware is no longer running,
  *	etc...
+ * @dump: Op_mode needs to collect the firmware dump upon this handler
+ *	being called.
  */
 struct iwl_op_mode_ops {
 	struct iwl_op_mode *(*start)(struct iwl_trans *trans,
@@ -174,6 +176,7 @@ struct iwl_op_mode_ops {
 			   enum iwl_fw_ini_time_point tp_id,
 			   union iwl_dbg_tlv_tp_data *tp_data);
 	void (*device_powered_off)(struct iwl_op_mode *op_mode);
+	void (*dump)(struct iwl_op_mode *op_mode);
 };
 
 int iwl_opmode_register(const char *name, const struct iwl_op_mode_ops *ops);
@@ -286,4 +289,11 @@ static inline void iwl_op_mode_device_powered_off(struct iwl_op_mode *op_mode)
 	op_mode->ops->device_powered_off(op_mode);
 }
 
+static inline void iwl_op_mode_dump(struct iwl_op_mode *op_mode)
+{
+	if (!op_mode || !op_mode->ops || !op_mode->ops->dump)
+		return;
+	op_mode->ops->dump(op_mode);
+}
+
 #endif /* __iwl_op_mode_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 44e19b27f36a..a42a6da5d2ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1564,12 +1564,21 @@ static const struct dev_pm_ops iwl_dev_pm_ops = {
 
 #endif /* CONFIG_PM_SLEEP */
 
+static void iwl_pci_dump(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct iwl_trans *trans = pci_get_drvdata(pdev);
+
+	iwl_op_mode_dump(trans->op_mode);
+}
+
 static struct pci_driver iwl_pci_driver = {
 	.name = DRV_NAME,
 	.id_table = iwl_hw_card_ids,
 	.probe = iwl_pci_probe,
 	.remove = iwl_pci_remove,
 	.driver.pm = IWL_PM_OPS,
+	.driver.coredump = iwl_pci_dump,
 };
 
 int __must_check iwl_pci_register_driver(void)
-- 
2.34.1


