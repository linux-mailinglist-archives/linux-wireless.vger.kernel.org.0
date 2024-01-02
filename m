Return-Path: <linux-wireless+bounces-1402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196F1822223
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB275284283
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1C516431;
	Tue,  2 Jan 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/NQZQ3a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCA1641A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224186; x=1735760186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4yeDQ+UyqAPgmaU+hWB4pDtKz789luv4vQOeHD8rzY8=;
  b=M/NQZQ3a2q3hwK9V/uRAPLpI8030JFHRIlKbsBUxdeBBXasxTgrnsN9f
   i+w5yyEvKISb8XTUrqxBwuvsay2/gbVgrrwTvzowfYCZ6XIXNce38gvXO
   260RFUPTpJRhbn0nbPzQ1V5uFc2EF099tf+ymHIaDX27+RDNNcp1BnfK6
   oEEywx0Xtrwa6o8nYArXdMpw2CiIEIJHDvKXMy7ttZAn89tUDWAsN93ym
   sNvsf+AX9i0OzVGgGuqJ7EYN39oNTb6CIIwJfaB6HMonouP4dZQPivdZf
   XHerRpB6z/sLSQlYyusbZqkF87OpwcGkAwGbBlUYgurTO818UuPWv5XOR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314316"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314316"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624533"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624533"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] wifi: mac80211_hwsim: handle BSS_CHANGED_MLD_TTLM
Date: Tue,  2 Jan 2024 21:35:36 +0200
Message-Id: <20240102213313.3c28da3534e9.I76846c5dd693f930d4828e411c734639708b5a1a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

Same as in BSS_CHANGED_VALID_LINKS, set the active
links to all the usable links.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e144cd30ae3f..e080d1131f76 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2462,7 +2462,7 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    changed & BSS_CHANGED_MLD_VALID_LINKS) {
+	    changed & (BSS_CHANGED_MLD_VALID_LINKS | BSS_CHANGED_MLD_TTLM)) {
 		u16 usable_links = ieee80211_vif_usable_links(vif);
 
 		if (vif->active_links != usable_links)
-- 
2.34.1


