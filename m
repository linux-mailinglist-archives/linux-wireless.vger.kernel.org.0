Return-Path: <linux-wireless+bounces-7519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6298C350A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062CE281C69
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4391804E;
	Sun, 12 May 2024 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cItujQ5y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7D1798F
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488297; cv=none; b=E+g5ibIyMFx3b2aQk4jaCIc+pjXUrHhUpElzBhm58Q4xVMJGFmIkccEIojaW/u46+h53oyq9FOhXo9gE9lfAy8t7C368Ck0W6z3XWVsf/ko6x3UVFhLQZcHmxQOxMTtiuxj5d0qLpScfUixPY5lxHm3V3DliYAC764IIWuxutqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488297; c=relaxed/simple;
	bh=fU8V3tIHog8OUa/mo2nNYJFWCnImJqTN7MoY0u1BTig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZl5v14oykpxohnYlg57GtZM55hk1auFoKwyPjI+As8KH8wVXhof9oui8/AiDyj87/MP4HopD4jmRC+PqC/etSIt+L/OQh6q4m2t+IdXmmYdUMWtQF7lLnB5fiNCIiUzO8J7fZjt40ag4/RCLefO0uHwNzT+IVNmNIka06tISCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cItujQ5y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488296; x=1747024296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fU8V3tIHog8OUa/mo2nNYJFWCnImJqTN7MoY0u1BTig=;
  b=cItujQ5yA7zmKKIUsqrEzWiGTyyYnitZiI+/LHgHqpGEk5GF899TWbl4
   XUFdY4tZOEp9jSIMYJeTUT81M4yItYrNucRmqI1YLSqYORHLQE50Jk7HX
   70vfrcD/tjl+k0taeDiDQIEe9mfpSCZrxQRukrGLXIDnJu5kcTUArllKo
   o/PI8ItflrVNm/WWP9yW4hZsCErK6SbBpbLiIfwcgv4u8AscWY3E4eL1G
   paVPm/IeAh/bk5qVPzTSl+heiQKVFlB5g2BShIdC7j7Az++ZGpdX4hCwk
   9lTEXLmkxL9gjfSlgLNzD2p0pIcAspS6sYmhDckmCSqiHQ+eSTfaxbtqz
   g==;
X-CSE-ConnectionGUID: 7AJVyB3KTNWNrc/KIEq73Q==
X-CSE-MsgGUID: Vkow8ze7RhGYQGyBjsa/qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323852"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323852"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:36 -0700
X-CSE-ConnectionGUID: Pls/x8B4QWW8Xd4XDzRgSg==
X-CSE-MsgGUID: Ll0GCMB3Qmmqjla64pMDFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532163"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 08/16] wifi: iwlwifi: mvm: leave a print in the logs when we call fw_nmi()
Date: Sun, 12 May 2024 07:31:02 +0300
Message-Id: <20240512072733.ef1502a9ef0e.Idd81777c47264e6f557b086625895c1dc2f667f3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we crash the firmware, we need to know why we decided to do so.
Almost all the callsites of iwl_force_nmi() print something in the logs
that explain why the driver decided to crash the firmware.
Debugfs doesn't print anything and it is then hard to understand why the
firmware has crashed.
Add a simple print in the debugfs hook to ease the debug.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 79f4ac8cbc72..96c9382b98fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1396,6 +1396,8 @@ static ssize_t iwl_dbgfs_fw_nmi_write(struct iwl_mvm *mvm, char *buf,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
+	IWL_ERR(mvm, "Triggering an NMI from debugfs\n");
+
 	if (count == 6 && !strcmp(buf, "nolog\n"))
 		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
 
-- 
2.34.1


