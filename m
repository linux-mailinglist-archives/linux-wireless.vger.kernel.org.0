Return-Path: <linux-wireless+bounces-18664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517B8A2DDCC
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444EE3A4528
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0474040;
	Sun,  9 Feb 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4YCk4mL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE381D47B5
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104516; cv=none; b=kCv/kkpZ1oOji/UrD6xO3qJ2h0jA4ea2/3rzkhkTX9YHHi+V0SWcds/NjG8GH7H3gQpZqU9aq0KPNPamAKb0O7VU+LqlVfJf1+86UDuoS+zKqs+1i1fHEYAd7uLwgR7UNwlSxCw5TzS9oOvFSkmSqS4KOc0v72inWGepMQUuk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104516; c=relaxed/simple;
	bh=bGeJ1aIpY8w5LCmWGXcaIKofr/okufkfaJ5rDj1HicQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPkHLkncYg294oRkpB20BXxEvFGFYclNCsBdm2Qu22H/3xxNBQPv78LHMb8z94cFkDyDtnfmzUvUBYqD9O3O+gOQF4e+WJHHQkp2XSxsVnTHskufanp9r3Iy8WTNqWVeoLT0nIDYRNPb1oGUEoGIjm7G7kC8duBZwIhnQ1fBEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4YCk4mL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104513; x=1770640513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bGeJ1aIpY8w5LCmWGXcaIKofr/okufkfaJ5rDj1HicQ=;
  b=J4YCk4mL/xip9eZ0y1dPO/aorrBd6NyuLFXaKjGc5KanupWfSt2a58Qa
   J5S/kHOdg2Le3Kjm0peF8VbwFXwWFXaMM3cGjt1yChMy8mC4fGBbYhnsm
   3lSDu/TOIVLI4REaznM9l7VapnwuF8ONexUjCjiuiz2Q3ZP9AMKEJV1xU
   vcFRAeUrPTnejuvJ7l1EuxBAxK77QC8WneaWOedvRcnfIhVQDH8zsleuU
   e2ywSy0rfHADodZ33l4PAkT5Aox1WAtzrw6PSN61FAkTSET7EAF15DPfm
   KIrkQrAqSm5nlz4vN0hXt1E1kicpiNX1nCJrj8y6nY6cTj78hHtdOln1/
   Q==;
X-CSE-ConnectionGUID: Umf6hVvLQ0y7F7Ae5qzUsQ==
X-CSE-MsgGUID: hXbA/vcIT+K6fKwAiNFYzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125973"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125973"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:12 -0800
X-CSE-ConnectionGUID: dQuJcf0ySXisQE6w7TIgWg==
X-CSE-MsgGUID: tI/61LrvR3Sf2S+a9Rc3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782403"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 2/9] wifi: iwlwifi: fw: avoid using an uninitialized variable
Date: Sun,  9 Feb 2025 14:34:46 +0200
Message-Id: <20250209143303.37cdbba4eb56.I95fe9bd95303b8179f946766558a9f15f4fe254c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_fwrt_read_err_table can return true also when it failed to read
the memory. In this case, err_id argument is not initialized,
but the callers are still using it.

Simply initialize it to 0. If the error table was read successfully it'll
be overridden.

Fixes: 43e0b2ada519 ("wifi: iwlwifi: fw: add an error table status getter")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 8e0c85a1240d..c7b261c8ec96 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -540,6 +540,9 @@ bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id)
 	} err_info = {};
 	int ret;
 
+	if (err_id)
+		*err_id = 0;
+
 	if (!base)
 		return false;
 
-- 
2.34.1


