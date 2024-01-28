Return-Path: <linux-wireless+bounces-2609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A365E83F46C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFC6B21889
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C4C15D;
	Sun, 28 Jan 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbYpHczs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114F8BF8
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424880; cv=none; b=olVrjryrJLzo5OqQl0/c0eMwpXdD68QKMhEJXHdFmJMeexsTnDal3N7Odtng43b45vRX+dKulYnrpql5ZbNLZutj2gJ1OGzWhUWPN4I0hwxa3bUIbxmaA4+kFa0sE+EQbjiTcr4n/uBL4kXP7e+9FgIbXfrhKV2l6+L/0LmtjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424880; c=relaxed/simple;
	bh=QC2M86855mUgmH+0wJgXFym17dWDEq15baeJfQEmjjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KayLAh16wj6l2Nlv0CttxM8oW28JwUZ1CEH9WWYtulcOI14jc9ySwji1jpPmJCCiwoTa9/nxkrqAzgCxHXym8ja/Yg5qlT5h9vsOMlXP2YxdePDN6pBFPoK5n7vwypzyvwlPR2+JFdnb6j4ld6kqZ42guw2oog07nzj0K3tk6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbYpHczs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424879; x=1737960879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QC2M86855mUgmH+0wJgXFym17dWDEq15baeJfQEmjjE=;
  b=fbYpHczsc3kxRK2qDe/iOoEjjXra1xyFfeAOj2MyHq0ss0FUCiUhHlVX
   8JUy4OU3nkk6yQOJst6T/5qGjLpIA3AH2QTDWssGv0zcHTwgghgf2ctns
   UGGvcrnTcW2gnaPtcZIkbyxf26376Z6GdWGeQb8VUUhBpHlTwn5Lbu6an
   kxFiX7buMgTio4+QAz/IFjmwwCx+crF/4AyAy0CX6onfQI1gM3LfWCd23
   xMR5MOeI0TjVNOEmcHK7p5nJn12N1aeypGN8jNEpWmeD6+sx8yjTZhDW2
   cIzKPFgjubQATcOGbedL7QgN+Tsji8QvJsE11URuB36jSfbjGaz2XPhJw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217640"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217640"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833338"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:36 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: mvm: d3: disconnect on GTK rekey failure
Date: Sun, 28 Jan 2024 08:53:49 +0200
Message-Id: <20240128084842.944af193d479.I5ef9f1f0e048d44d7158615d071b793d69eceb75@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If there was a rekey failure during D3 when firmware is
handling the GTK rekeying, and it decided that we should
wake up, then there was an issue in the connection and
we don't necessarily have the right keys, so we should
disconnect.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 4582afb149d7..61aeb7f6604b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1462,7 +1462,8 @@ static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
 			status->pattern_number;
 
 	if (reasons & (IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_MISSED_BEACON |
-		       IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_DEAUTH))
+		       IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_DEAUTH |
+		       IWL_WOWLAN_WAKEUP_BY_GTK_REKEY_FAILURE))
 		wakeup.disconnect = true;
 
 	if (reasons & IWL_WOWLAN_WAKEUP_BY_GTK_REKEY_FAILURE)
-- 
2.34.1


