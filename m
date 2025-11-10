Return-Path: <linux-wireless+bounces-28764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C0C46934
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255543A6A9E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55A17BA6;
	Mon, 10 Nov 2025 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M56zAIks"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60885CDF1
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777230; cv=none; b=lbrQpa23Iy7cP05DgkKLnu1yS9PCXczSsWEmYfkl6M9P9NCRVD7sXSuoz7qr7UxDLe2qjOeqOkhy3zW1rUDjsrgu5eVOE3yKPAryAnVzM/PBX8peM9HM5y01rYPj9jdcv1ba+KJcSTSznQ71p2+ULpIUOnfZoIkXoMuIlsgIdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777230; c=relaxed/simple;
	bh=sJ0XZhkkMv5zUtLS/Jyi77ZmnwCvVE/4LjxRjgFa8vA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffeDeVQAzsBcpFREIG0ccBn1X/cNrptcguh6BQKbJRNVwFLJQipJMCiYXJHvAn8AWhWStZuWJJ6Uo8JJAUtJZ08oqfPInt2pQkqqV7B34v6pLckIgZ5CfCsg9R7OH2iuD1nAAWgSA3xhi/yUO/o9bEUphgeE3JGG6CA/sr434g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M56zAIks; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762777229; x=1794313229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sJ0XZhkkMv5zUtLS/Jyi77ZmnwCvVE/4LjxRjgFa8vA=;
  b=M56zAIksJo2AOy0FOJ/gGbZ4pxYCnNPnTSVhrSJnYCfHQEZl03U7/Rww
   0OsySJrFeBqAaoZ3DbvoaRCpoJ4OA4YwY6VsDN/Zo88Tx5rWne8GO7L0v
   VdG0ABaEKjGc7Cg0Rg94wfzY734fycfod7we1/vxr/t6nADPyG/Itrynh
   XamDmXrz0VaM/WGxCUwTCsfEWMH/NSK/76zC26Cg9EcrOz8vF3J9EUScm
   whxxMX0pQv0/yojOiH9j1oKexO4k5R1q1hcFv/slxpRGgeuXvF5hkXQNd
   UqjKz7jc4SsbUuuvBRqrtJbsuJrSTdKyuGTStgZMRQEh1kbLF/kK+7SrU
   w==;
X-CSE-ConnectionGUID: RVJfs3+0Sv+qM+lIed1efg==
X-CSE-MsgGUID: gIjvrPlnQ028j+N5ALOwEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64706323"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64706323"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:20:29 -0800
X-CSE-ConnectionGUID: lSDEtOyFSmqOoMjp6s0Y+g==
X-CSE-MsgGUID: KjLzl2KYR8aUw4azkSgD7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="225919656"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:20:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: make monitor link info check more specific
Date: Mon, 10 Nov 2025 14:20:20 +0200
Message-Id: <20251110141948.6696dba8678d.Icafac3be4724825dd6140e4407bae3a2adb593a5@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Verify that only one of the permitted change flags is set when changing
the link of a monitor interface. Before the WARN_ON_ONCE would accept
anything if mu_mimo_owner was set.

Also, split out the mu_mimo_owner flag and enable it for all interface
types. The option is set during association when VHT is available and it
is not expected that any configuration of the MU groups is done without
it being set.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/driver-ops.c | 8 ++++++--
 net/mac80211/main.c       | 3 +--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index ba9fba165926..49753b73aba2 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -476,8 +476,12 @@ void drv_link_info_changed(struct ieee80211_local *local,
 	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
 			 sdata->vif.type == NL80211_IFTYPE_NAN ||
 			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
-			  !sdata->vif.bss_conf.mu_mimo_owner &&
-			  !(changed & BSS_CHANGED_TXPOWER))))
+			  changed & ~(BSS_CHANGED_TXPOWER |
+				      BSS_CHANGED_MU_GROUPS))))
+		return;
+
+	if (WARN_ON_ONCE(changed & BSS_CHANGED_MU_GROUPS &&
+			 !sdata->vif.bss_conf.mu_mimo_owner))
 		return;
 
 	if (!check_sdata_in_driver(sdata))
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index eefa6f7e899b..b05e313c7f17 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -356,8 +356,7 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
 			 sdata->vif.type == NL80211_IFTYPE_NAN ||
 			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
-			  !sdata->vif.bss_conf.mu_mimo_owner &&
-			  !(changed & BSS_CHANGED_TXPOWER))))
+			  changed & ~BSS_CHANGED_TXPOWER)))
 		return;
 
 	if (!check_sdata_in_driver(sdata))
-- 
2.34.1


