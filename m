Return-Path: <linux-wireless+bounces-15508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FEA9D2A40
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 16:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3996B2B882
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC9678C76;
	Tue, 19 Nov 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="No0Gkcdu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F11CF7C7
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030560; cv=none; b=fLojzKl3Biz5dHPgnH1Duwh6FO0OIqcq9iiUZCPmWEbPWYymFnftDzPgkMM4GLML5HAE7tJUtgwZU27AJzbBSD715hOKTtOyNCtAGXV3k6pYH2eENyGBmAfPtD2jc1a6TD7UJSwBrju6TrhLI+5ye3NDWEF+YE1kmp7Yawp2dhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030560; c=relaxed/simple;
	bh=CsbJIlwxzQJ41hOmUR0Ri5TzFdBWDbEx+AjV9AAj+Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmfRFziW+8SMpOGoMx4F0AroaH/9AwZE96ncN8AaXMTopV6BLA25G/wBoLf2VqvYFpwyayMMCouOCR19IX+JseC1ap7WQWdIORcrwrl1ETPPO2QUljrsbLai8Ad3dvlK3XDEO86FN55EJr5aVz/bq50XBY0cAJjbPTwbnfyGBZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=No0Gkcdu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732030558; x=1763566558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsbJIlwxzQJ41hOmUR0Ri5TzFdBWDbEx+AjV9AAj+Pc=;
  b=No0GkcduR5wMGI/SLV3sOJOwzW1r9UbLWc4PpShR0F9uHX0gnWp2agyj
   ne+quMs9xOYASRwK21tzAitn4FUcbsWyGCS+zgaaooHtk8oE0v9YnmrX2
   B8zpUs0pSyZatfcvv0/a6+ssrqf7tlly9xNxmcPdz7QCYpCNdTfk22lMQ
   7x4WINy34MpcK6ln6/7BWBx9n7Q6NQOciJbkU5YouXl17FiznL/BdmwhX
   J8vUrM7P5QwTL7qj/iE4cwPdFk6l9vhJ3JDywPOv61dNEoz1vtJjaMntX
   7DkY9YynEqlyDZNprrmP760Z1AxP59bVMmq5sQotMcwcktZFa59oMtoqQ
   A==;
X-CSE-ConnectionGUID: A0sJz2fdQVqBQeIi4oQK+w==
X-CSE-MsgGUID: iLzisrV0RGajpJZ09mIDHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32284149"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32284149"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:35:57 -0800
X-CSE-ConnectionGUID: /olEWlu+Ttio83nxmllh1Q==
X-CSE-MsgGUID: MLxe1bRySxSDofU5PPf4Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89180902"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:35:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: wake the queues in case of failure in resume
Date: Tue, 19 Nov 2024 17:35:39 +0200
Message-Id: <20241119173108.cd628f560f97.I76a15fdb92de450e5329940125f3c58916be3942@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119153540.594699-1-miriam.rachel.korenblit@intel.com>
References: <20241119153540.594699-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In case we fail to resume, we'll WARN with
"Hardware became unavailable during restart." and we'll wait until user
space does something. It'll typically bring the interface down and up to
recover. This won't work though because the queues are still stopped on
IEEE80211_QUEUE_STOP_REASON_SUSPEND reason.
Make sure we clear that reason so that we give a chance to the recovery
to succeed.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219447
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f94faa86ba8a..9f96c4dc037a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1842,6 +1842,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN(1, "Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.\n");
 		else
 			WARN(1, "Hardware became unavailable during restart.\n");
+		ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
+						IEEE80211_QUEUE_STOP_REASON_SUSPEND,
+						false);
 		ieee80211_handle_reconfig_failure(local);
 		return res;
 	}
-- 
2.34.1


