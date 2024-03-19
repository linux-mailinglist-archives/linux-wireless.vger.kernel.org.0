Return-Path: <linux-wireless+bounces-4890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34387F919
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3441C21978
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9717CF37;
	Tue, 19 Mar 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2HIntHK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC487D079
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835864; cv=none; b=ch5u91uI66oHLAwCWmTUrqqnFkC3dKq+/fmlcdGo+TAwRiRV9PkL2G9Li3Db4ddAXg2aXnxLzOv8FPzRSWskg23XzT8RcKpSzs7zlGj+ha7J29hCkfMnGnkJlTeTGX6Jvv7GIUDJLw+1vx6TJqp16DWRLTM3bwQnt7I5lVP4CvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835864; c=relaxed/simple;
	bh=weoFCDvUGHmm4jv/R9K3QcHACe60JqeNsp1k0hnL4V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/9LEgjW8Pm7xdqUPSarK79X52B2a7KnDgOtKnpRcJHLPqr41syJ021HuDGyU9yY049zt7+kn4Ro4aRI6OMw8IjcT3GAYDGD7BbmkjLYUOa4cUEcRa9XB5mRu3gUL36Uz9fvHdMw0jI6acQxtT9xddw1Sgc/mLXHHebtW9cOiJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2HIntHK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835863; x=1742371863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=weoFCDvUGHmm4jv/R9K3QcHACe60JqeNsp1k0hnL4V0=;
  b=M2HIntHKzyGZFFkoZqA6ZPMgm9b56yVtO2e2h8FarOiVTZP8BDtqN5CG
   /XRq2PDolMTfDolcTD/sQEdlOknD6ouqe95D1i2pWVdvRqD9kF/AuwPi8
   1uW9WE1iq335a82aLFRePf6AJm9WVItp/M9wAe3hmaK/NWMBc6nVBVIpK
   eTm97e051UsOat6SGhB59tbC8i22X5y94AW04E3XyQNxSOjmEoWOW62bT
   C7tLid3FNwdzh4VPNFzXW5IalkiItvihzZbG8VKtODXjG6VMNoV94p5Hl
   vl1KAzK9yM+2aG9egAafpT2gCg82eMOZmWJDr0WCj4GYdLaAYO4wBQUcn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810574"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810574"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447641"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: read txq->read_ptr under lock
Date: Tue, 19 Mar 2024 10:10:22 +0200
Message-Id: <20240319100755.bf4c62196504.I978a7ca56c6bd6f1bf42c15aa923ba03366a840b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we read txq->read_ptr without lock, we can read the same
value twice, then obtain the lock, and reclaim from there
to two different places, but crucially reclaim the same
entry twice, resulting in the WARN_ONCE() a little later.
Fix that by reading txq->read_ptr under lock.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 33973a60d0bf..6229c785c845 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1589,9 +1589,9 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		return;
 
 	tfd_num = iwl_txq_get_cmd_index(txq, ssn);
-	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 
 	spin_lock_bh(&txq->lock);
+	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 
 	if (!test_bit(txq_id, trans->txqs.queue_used)) {
 		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
-- 
2.34.1


