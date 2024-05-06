Return-Path: <linux-wireless+bounces-7199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E38BC7FF
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FB41F21B07
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673377E58D;
	Mon,  6 May 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgOasywn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D68524AE
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979073; cv=none; b=QT6mg9qNPD+dpsK4K3baFTIo8gP16+bzame+Dmh7fyHmr+ZJKguFJtf+STCa3J5E9Y2tWWoPTHNl0Mm5J84Tungt6aEWIZUc+3N3hOmt3/OTkFan6EnUBLN98+N6WuhrNURfYxBIp1zygg+cMDhEGiG2kdzS/wLxxwpOq8gO0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979073; c=relaxed/simple;
	bh=Hi4BDeSPRAiODk56O95/3/fxkoo18zgixTcnLoXqqUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+TdlVB66F2f4xNRygMUbSQXZ6Z55qbsY6d8uvesb7LJp/iqG9IwCJfS/HY8C9XxQwkWgVgM9xJp2cnAHdRB371QF6CLtIF7lPapaedRt8+I+clxhUPgoemgGonJbpvxrz2Yb6lMgKXJfIoNezgcnur/Y5I363anYMljBHhojWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgOasywn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979072; x=1746515072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hi4BDeSPRAiODk56O95/3/fxkoo18zgixTcnLoXqqUI=;
  b=bgOasywnOV8s3n9nUoS5vStcxQ6NjXT2Kt6yApxJkd4bIQxhUMV0/6d+
   TV9ScHwsXsB2ZrZAPX8ZAYrb2ry0oKT+GSOxkyq8BPhshA7S9OsFRnvvs
   3ezq8Oj2yup9YO02SVUfIjgquFQkoI1RFGdfGo03ViiCxVWmqmOBO5Qon
   zYYZ+f3Xc3QlkhCO6Pp3mPLnfBkWAjVlyQsNUa/JXcIOOWS8bJ38FOrat
   ++eiNqhQUgvQ4u00WWIMVzdaO/u7j136sBeWIzHdnGbv71VnKjcDxclOs
   iyPMuoqhghtykBFPEqpa//ipaGTm6n73hDCi4jobC7JVX+3RlhRXalT91
   Q==;
X-CSE-ConnectionGUID: hv+6SW5WSG2rLazD7Tkt6A==
X-CSE-MsgGUID: Ajg2Lp5tQMOXjbzXQNK2fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638153"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638153"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:32 -0700
X-CSE-ConnectionGUID: yVqy1g7JRmi9gUCVFIqNlA==
X-CSE-MsgGUID: ERNn4i8wRA+yLmTOYAHvmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264867"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: fix primary link setting
Date: Mon,  6 May 2024 10:04:06 +0300
Message-Id: <20240506095953.779bf6949053.Ia9297991ff2fdc82ae7c730e0069e2dd6e5f2902@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

mvmvif::primary link holds the ID and not a bitmap. Fix this

Fixes: 07bf5297d392 ("wifi: iwlwifi: mvm: Implement new link selection algorithm")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index bceafd551e8f..0a3b7284eedd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1212,7 +1212,7 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 		 * Ensure we always have a valid primary_link, the real
 		 * decision happens later when PHY is activated.
 		 */
-		mvmvif->primary_link = BIT(__ffs(new_links));
+		mvmvif->primary_link = __ffs(new_links);
 	}
 
 out_err:
-- 
2.34.1


