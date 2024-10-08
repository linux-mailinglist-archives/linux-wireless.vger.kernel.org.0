Return-Path: <linux-wireless+bounces-13674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAB993DFA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B131C23F33
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792178685;
	Tue,  8 Oct 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0UHFpJo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B712C484
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361559; cv=none; b=CJUMeqLbKh9JE0FvWj6eR5fxDj8xLM0l6UgeDOlaEp5kmo9HflVCBvIqCcPH6c6wabDSHLU+WR968vkg814VhxQRBw+6MMduuhWgalwqc+CZA5d39klKh/1P23VuJUgJPAAtu+TESzr5GjAvvh7ecOgz0mwN/nZYKoj1Tr0DIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361559; c=relaxed/simple;
	bh=1X68w1t8FfSAedz2vntuxswzV6KQYPNBQ0b1knPSXs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cr0D8DFTFGjJMJLgE6bKZDCWLF8COz5hgd5JcxKbfOD4d9Cw4BF8N6JNSOdMU4vv4DMJeX4WNZNVjzVO5MJx6mKLWViMNsqWbgTQFM0v1VYKC+UhCyn3IPgsMzfDim9nyXhJiUszUanUru6w6vWxnsXhHQO6YDaxltMiUyLqUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0UHFpJo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361558; x=1759897558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1X68w1t8FfSAedz2vntuxswzV6KQYPNBQ0b1knPSXs0=;
  b=O0UHFpJoDLzCks+E4+J3IlC0urPidYW+fzYTy1anbxBbXYbSrrJKYbK3
   8hKJQ6sze9iIbuOhw5nLqsH2n2ia1TfQ8/+xrQqk7c+trNVu4RRJpVYGn
   Xzvw2gcOcSszXwCeDKfzjwd9CNdSTQ+pgFQRw8Qjxbn1x3yovwt5xzHY6
   lxjVBnclz7oynlcttLRhqz1ZmzWpx3/YSRIYSWhN9r6ubQDw8G2Rfxa85
   N1rS8ROwwvCpRsFnKLt70Frr83irLi70KJZJy+MYvS77mAZolur44Wdqy
   Cn5oPe01n7gUB1fwvZ/jZuwJyun+kjxBSY2RarZo+Q2wdTSkRky58y29x
   A==;
X-CSE-ConnectionGUID: cVKNj7SUS7K4X3tzlrm4Iw==
X-CSE-MsgGUID: yCMg0GntTOaSaLcEGmXpZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024299"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024299"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:57 -0700
X-CSE-ConnectionGUID: YomwILFgRaiIvOlOuRPL7w==
X-CSE-MsgGUID: NKXtHRsLT8O07vvL/Iu94w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486386"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: do not warn about a flush with an empty TX queue
Date: Tue,  8 Oct 2024 07:25:25 +0300
Message-Id: <20241008072037.7c152d0820be.I3ae39a9a470f47bfe4405f2e5c30327e157eb55f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When resuming it can happen that the TX queue is flushed even though it
is entirely empty. This is completely fine and should not be causing an
error level log message.

Return early from reclaim in that case.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 9fe050f0ddc1..1ef14340953c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2351,6 +2351,10 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	txq_write_ptr = txq->write_ptr;
 	spin_unlock(&txq->lock);
 
+	/* There is nothing to do if we are flushing an empty queue */
+	if (is_flush && txq_write_ptr == txq_read_ptr)
+		goto out;
+
 	read_ptr = iwl_txq_get_cmd_index(txq, txq_read_ptr);
 
 	if (!test_bit(txq_id, trans_pcie->txqs.queue_used)) {
-- 
2.34.1


