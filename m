Return-Path: <linux-wireless+bounces-23959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDDAD4967
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB653A6373
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1242045B5;
	Wed, 11 Jun 2025 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Psdd42bd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECC1A5BAC
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612876; cv=none; b=m5EfXqK9YhHCdd5MQNOjtkgRFWm3wDHQCinsUFIEvDweY1GlO554LAlCwgu6uDxamzIjtBC2VjCZuzntoo/YeppTuT+KSigREE4TCTwZrQYmWsuyld9epTn+Z5Nd3cdFctTT5T90dZgnWkiOZ4KSFrJR05YQPpQyHo+YNtpgZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612876; c=relaxed/simple;
	bh=TAJrZEsJSgeAa4gixJOn+roF5tylPMHvxQFzabKcfEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4JqEaZp3eGJ6R54z5IhxtnJ8wMYdflmBx2nPNaBbhy2d6DOH/7IznbAoNqeTmz/n02rfFYGhulwyoSlZIdmceQ5sOd1oZPxHsH+N1EDRwPawRSk5zjsj+AFGfa8Edlsj+yAVUiNR/G2BG0eadkbwkByMthV7NFQWzj58FkWD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Psdd42bd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612875; x=1781148875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAJrZEsJSgeAa4gixJOn+roF5tylPMHvxQFzabKcfEA=;
  b=Psdd42bdOgVxoaeMFuzwdb81uF+ZHcdQFY2ljYvBqmjymiHJETKzuAfu
   uq6Dc6WAsXLCFaPVhFinyBEl2pEYjqbF1kCDU/0uI2gEZsKBN4MLpk3C4
   sKsElvRl62gpn97n3RFF85XH/gPtKSFvVahJAHoxMRKfJRvZWbWdiXQAF
   HH0JgsouJ5SxlVqr3k3bSXJZVFrUkeTK9OAjSfCntJDiAsDktdy24EiOp
   +ier/heu1di5L3psoogdgYz9472ObOKNF3iF01aWiQ3ppCqGk2Ql4UMsl
   VeeONZi5EAGdJISQGn8Ov6koJ1FCynpol2mOeB2OP4zAu3AfoaHNG5Xc1
   Q==;
X-CSE-ConnectionGUID: EugxcwYdRDK/DCKGm8aB5g==
X-CSE-MsgGUID: IeUSr/s0S1eWNORkjneZJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094879"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094879"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:35 -0700
X-CSE-ConnectionGUID: s8oJ3ECqS/aJBxo6gaTQEQ==
X-CSE-MsgGUID: ExCDt4lqQoqZZ/Dcr7W97g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880915"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: add support for the devcoredump
Date: Wed, 11 Jun 2025 06:34:02 +0300
Message-Id: <20250611063124.bb38efe6700d.I9c666440dd1eac13ac52a2c2d533224c36fea2a6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
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


