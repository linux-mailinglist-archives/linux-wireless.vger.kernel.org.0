Return-Path: <linux-wireless+bounces-605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C093180BAD4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14FF1C2094F
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF3C8DE;
	Sun, 10 Dec 2023 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hu6wZOUQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F3AA6
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213585; x=1733749585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sUvLvHSGpTg2W+vBKYZ+WCNKupVSygatMl/3Rwexo9I=;
  b=hu6wZOUQfe/aJF9rVTjKLbYODQlsptGKls9yNhV4Ij5ZzTkCRxW9rF4N
   2oHL9ivbM54WAwVCesGEMh7ly5zss740U0EP9z/W6vgrAwkIfVl5QZLpU
   bxT2nCCE//7ajpxQEwxagJEtot4EzkTF/kq2Y04vss+od5776c9dHh1kD
   3MlI/yR1VKOkn8U5xDzFURUyoxVcplwN/pqseNuu5uV3UXhj8kaeRx+CX
   MySt03fZvaf+uRB3uYR2vBTr7tWFkF0nI4JCjzCp3jrujh7hFYcy2zibV
   lWgbXIlBGc4/5eqwwmHKhyhK8wl0QILvNWkTAj9mkm0vTOphtb++NvlCr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480746104"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480746104"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748926307"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748926307"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 10/14] wifi: cfg80211: consume both probe response and beacon IEs
Date: Mon, 11 Dec 2023 09:05:28 +0200
Message-Id: <20231211085121.07a88656d7df.I0fe9fc599382de0eccf96455617e377d9c231966@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When doing a channel switch, cfg80211_update_known_bss may be called
with a BSS where both proberesp_ies and beacon_ies is set. If that
happens, both need to be consumed.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3e3ba0ddb83e..3d260c99c348 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1749,7 +1749,9 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 				   new->pub.proberesp_ies);
 		if (old)
 			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
-	} else if (rcu_access_pointer(new->pub.beacon_ies)) {
+	}
+
+	if (rcu_access_pointer(new->pub.beacon_ies)) {
 		const struct cfg80211_bss_ies *old;
 
 		if (known->pub.hidden_beacon_bss &&
-- 
2.34.1


