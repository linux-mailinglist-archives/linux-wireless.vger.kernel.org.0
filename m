Return-Path: <linux-wireless+bounces-3174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890184A6DC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4393291648
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB759B46;
	Mon,  5 Feb 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnwgWzXp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28459B5C
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160925; cv=none; b=t11WOfwysOjX638L+DawaX1QmdQL3WlCgTnSp4DZW/kHdyd9Ce1vZzIW7raMu2XYPhAfiEFQ+l7O4UYmm0qvbkehwbKdpw0ceYzXrwHEZ94aTSLYH2xqd4eHl8qtpmt3qXE9U2ug1V8D7F/5ux9fedbNQHiheuMvBEYOHjRUnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160925; c=relaxed/simple;
	bh=ISv1a8OSjIBB4pWfwGywYicE1VRC2Oby2DlJ2858/JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3WBktcxRmF67ghZBC5MlXNU6D7QO2b1IGBo9148nh1jmqYU2PzbtJwuS4MjeJkknQa+ke6Yd/iDfU9UjI8oTLDmjQ3Ca/nAofB0A4FwuiumVzQ7OUayzPwN+YNyPgPNRcQcMQbJfH+56ajPdD+LBF4iJYQFD8JEDUAJaqvCpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnwgWzXp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160924; x=1738696924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ISv1a8OSjIBB4pWfwGywYicE1VRC2Oby2DlJ2858/JU=;
  b=AnwgWzXpfzs7yVqy3gZSnjpuysL51clML9YDIWpQPhhcv3sj0cTGLGsJ
   ZDjTnHgYT2orKY/A7kJAiUcSDiHvZO9Y+SlbYXuH0yW/wA4TGI4vl020Q
   zCfvop8kY3WEyt+0Jpoalp8hUFlmbJwKLmvaJ1a8WOBZV6eBbHdEszrAu
   S2soHaFiayYbURNRUJmNEOku5QEH4ygCUXjHHswezIXiJk0aPQNl1h49J
   DEOMUK2ycja4NAioKUUp2DSKGpw9r0aY32/8U+4i/geUUrqR7Tuq9xjmt
   +k0eYlYBeyvCdoZGJ46wA/e/5yKI07oZSASYM6L6dguVIFnxjSqqg01+T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381648"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381648"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403179"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: limit pseudo-D3 to 60 seconds
Date: Mon,  5 Feb 2024 21:21:11 +0200
Message-Id: <20240205211151.ca55b3a7fa8d.Id746846f187442ebc689416d2688f2bd9278c0e9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With unlimited pseudo-D3, we can get stuck here in the read if
the firmware never wakes up. All of our testing infrastructure
however will anyway give up after at most a minute, so there's
no value in that.

Limit this to about a minute to avoid getting stuck with the
RTNL held forever, which basically makes the machine unusable
and then we can't even understand what caused the failure.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 994387eac6f7..af449cb9f967 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3389,6 +3389,7 @@ static ssize_t iwl_mvm_d3_test_read(struct file *file, char __user *user_buf,
 				    size_t count, loff_t *ppos)
 {
 	struct iwl_mvm *mvm = file->private_data;
+	unsigned long end = jiffies + 60 * HZ;
 	u32 pme_asserted;
 
 	while (true) {
@@ -3402,6 +3403,12 @@ static ssize_t iwl_mvm_d3_test_read(struct file *file, char __user *user_buf,
 
 		if (msleep_interruptible(100))
 			break;
+
+		if (time_is_before_jiffies(end)) {
+			IWL_ERR(mvm,
+				"ending pseudo-D3 with timeout after ~60 seconds\n");
+			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
-- 
2.34.1


