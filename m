Return-Path: <linux-wireless+bounces-25894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE9B0EAE1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA62A6C5861
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3B271472;
	Wed, 23 Jul 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGMK4Te8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707720B81D
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253141; cv=none; b=E82JOawe3bsV9TknvekEJZXJZFdc5bX/9dAId5xPFTP+jIriOmZv+wcddvFcMwv0BPc+sVyDXGPfTzs6qXLtAlbXKFNck5QhmW0PtGVhpUd0e6e9KhRxwuVn1yUHh8uXe2N+zlWQiejFFchqgMmQ4cNzlIghzGWN8D6gw3Cnsoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253141; c=relaxed/simple;
	bh=RMdDiuuvHQH36u7xg86ICkL0gF5hR/CGa7ifbowG2f0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcFaXScc1dYHQbSDrJHCu0IlBTvMPYUk0SauwDg2ONs2BuWofy8BItoAlJnKGs9DVkJf1Dolqw+SzD5KTGh0QIsiFABPwxJyF/CD2URmijZmaVhiJ6wxz+DhhqcznxCqZ1SAh2IL/DPL1+jdJeOh7GLR1BxSaZ2lM2ME+jh71SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGMK4Te8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253139; x=1784789139;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RMdDiuuvHQH36u7xg86ICkL0gF5hR/CGa7ifbowG2f0=;
  b=DGMK4Te89Ni26w3LYoOEGGvXaBhHIVa0jwMIaXn1llYsJHTuayi/qYIv
   h8vQnRJCAWtd4ssWRhOvEcVXTIgK+8kFozDgqOZ1J5tfrTsm7E0JORqWF
   MvtaLGpBcOMOaCROHgYxrLgCMmoJAW9t+WN1NcBXlXA3h568fUov0wT/j
   ukiBYsaRHHWtFjK0YCZTMs3Nt1oSl/L8KGX7jMFG0an6t6xZ3x8Ktzlxh
   KQK7RCkRVAnTAS2DMkqQ6N+CYrX1MEh4f+jtF67x99vRpZA5O/fYtDI1K
   afpN+/u/MrV80rIlBuBuDbnxY0Hrfv+6kes6nQtyhE4a/XH4ffle+8Dw0
   w==;
X-CSE-ConnectionGUID: twrcktPsR92QrYyyjIFVsQ==
X-CSE-MsgGUID: Sc5pnXSCS02CTkvbFCQgPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340718"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340718"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:38 -0700
X-CSE-ConnectionGUID: C7EzYiWTQuSBu3h7BYatPg==
X-CSE-MsgGUID: FzW6rSaLS++XYYc3BDWh0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918069"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 01/14] wifi: iwlwifi: mld: disable RX aggregation if requested
Date: Wed, 23 Jul 2025 09:45:02 +0300
Message-Id: <20250723094230.40746586ade7.Ibf5877df76ea2f1eee614166b3194843fd9898cd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The user can request to disable RX aggregations via the module parameter
enable_11n.
Honor this request and reject addba.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 59be9923c3b2..d929cf2e73fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1918,6 +1918,10 @@ iwl_mld_mac80211_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
+		if (!iwl_enable_rx_ampdu()) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = iwl_mld_ampdu_rx_start(mld, sta, tid, ssn, buf_size,
 					     timeout);
 		break;
-- 
2.34.1


