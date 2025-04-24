Return-Path: <linux-wireless+bounces-21992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69887A9ADB4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A28C462F50
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4827A936;
	Thu, 24 Apr 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neRzM5px"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2227A91D
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498350; cv=none; b=dt7G32P7WDd9lKUTlPjpR6CqJ5p6AXUpB0wB3xBHcQdp6sAS/Qq3ZPrnBbizUuDPtZElD9gESOicGXo26+7WS7bEMFU+4HlC0vexezyhA/cJF1bHXjkD9IMfH9kVPxx6C+3GOk2EPrSH/1sHB+BhZcPHNXzA81o8QQizKkK6IV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498350; c=relaxed/simple;
	bh=g4KwGLGmucKVwP9uiyarAH0WP7NFZHFX8OvuaqU0Chs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7TR7+JmiPAkGZlNpOV3OP5k9V1NBK8oFe1lNhNXHT/+/dWbLVDeBNobqJoVESwZ9cFK0f5HvfxON+fcC6Vmt+s5GeIAIdCfapZe+F3gi99EtYQTxWSWciTG9NdkFj10tLFJND8XiklTxNoLEKvIAlekIq0QYUHL/n423WQN7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neRzM5px; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498349; x=1777034349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4KwGLGmucKVwP9uiyarAH0WP7NFZHFX8OvuaqU0Chs=;
  b=neRzM5pxu2K29vMwF6LtKxTwr2Cce+LIwKPA53fuHKUCJvl8WqjJJ+uU
   /FzuKTVpWPyO1A68gbmHSHyd3+Xs1qSkRK9zTdcFAygj0rM8RHHcn31kW
   ThSmiQbaBMZrsCZqmMDIbWXyWH6DYgaAmfYdLmQm+SZSdc5Plt/pDvkAy
   9SaKV5mLTsL4eP+ZoMaSeKuOSpCYn+Glyr4TGie36DZS1oZ7Prz5Dink2
   Sfqog+1c3qtu+fsvmSaKYHgCZtGDGbp+sXAkXfad6SnPawbmRkL0bS+UL
   v4fq/NYMYDhHuFBgp3hR9vRE6K04T0viLGQqdPxAF0cVvHLjZRGlJrkf9
   Q==;
X-CSE-ConnectionGUID: DlHOk6HFT/qBojLh5yMsyg==
X-CSE-MsgGUID: 85dBIJ0qRWuxS+wxm1kSNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302451"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302451"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:08 -0700
X-CSE-ConnectionGUID: keC/Dp2RRyG9bovMpUSQ7A==
X-CSE-MsgGUID: um29TW93TUiFnsOTrdwc7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137469"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 13/14] wifi: iwlwifi: pcie: make sure to lock rxq->read
Date: Thu, 24 Apr 2025 15:38:30 +0300
Message-Id: <20250424153620.73725f207aaa.I1a3e4b6c5fd370e029fdacfcdc9ee335788afa98@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

rxq->read is accessed without the rxq->lock in a few places,
Make sure to have the lock there.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Tested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c917ed4c19bc..b2258c13f7f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2934,6 +2934,8 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 	for (i = 0; i < trans->num_rx_queues && pos < bufsz; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
+		spin_lock_bh(&rxq->lock);
+
 		pos += scnprintf(buf + pos, bufsz - pos, "queue#: %2d\n",
 				 i);
 		pos += scnprintf(buf + pos, bufsz - pos, "\tread: %u\n",
@@ -2954,6 +2956,7 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 			pos += scnprintf(buf + pos, bufsz - pos,
 					 "\tclosed_rb_num: Not Allocated\n");
 		}
+		spin_unlock_bh(&rxq->lock);
 	}
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 	kfree(buf);
@@ -3654,8 +3657,11 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 		/* Dump RBs is supported only for pre-9000 devices (1 queue) */
 		struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 		/* RBs */
+		spin_lock_bh(&rxq->lock);
 		num_rbs = iwl_get_closed_rb_stts(trans, rxq);
 		num_rbs = (num_rbs - rxq->read) & RX_QUEUE_MASK;
+		spin_unlock_bh(&rxq->lock);
+
 		len += num_rbs * (sizeof(*data) +
 				  sizeof(struct iwl_fw_error_dump_rb) +
 				  (PAGE_SIZE << trans_pcie->rx_page_order));
-- 
2.34.1


