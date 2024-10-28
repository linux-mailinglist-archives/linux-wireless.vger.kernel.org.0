Return-Path: <linux-wireless+bounces-14591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF99B2F5E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61772821E3
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD14193091;
	Mon, 28 Oct 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdUUYRHX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11D189B8D
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116524; cv=none; b=sPPXw1BytvQcjIfN23URp7mSCHeu2n8PNFO9mSBFSoaIM4WrCKuHQ9gYZDx2muRXjYNcdaGTWHmpF31hyv4db1GL5r/Wigf3Q3uFVk1wE8din1Il7MurAePVZj69V7wbo34OaXQnnS5uDAyvjt7MhtNr0m/tO6uCOt3aEZ0RJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116524; c=relaxed/simple;
	bh=AbZMhG2ZqXsCiBs2eF4Br0PX2xO3apeI84U0NbN40zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGJBwl6xsKIVYOFvQLhlKj8GzCSXjazVmDUSfZq0dru8ThfdGGxKjCPWlFRRIQqFEgdgaW7lPp79ntd9y2POxVHuFMVjeENiKr1Bhrv+tZI4yfdd/ns3dzSD0M8JUyc1EhJjVZVu1s/UsMvqjXG2dNUssmDAwhYxPEspyA/2M2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdUUYRHX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116522; x=1761652522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AbZMhG2ZqXsCiBs2eF4Br0PX2xO3apeI84U0NbN40zc=;
  b=MdUUYRHXfIQb2AYdBMvyYSCizaAnuGqfkPTF4z74jCAhjqpzYtPgrtbr
   3zPZufDGuI08hBlobGSXIwSw8JAef/iAC1vdKrfrFPDDz2P8yRtbScKok
   LTniGPSbzZNO4kgniQHwm3VDorx9nUHUuANMdHR2ORltPApuQdmSFBLpD
   0suEV2IZN4p6OFYj7tzHOwUW11bjlmHIk7geI5FT+V62tDRAp+aBvdTQd
   UfRbNV/QW854zAg/61Ip6QgFA30THOXsihxKZdj5li21XxlBaMjeBwnu2
   /a6LE65tRg1/RCe+ZBjIaZTgWb3ov6v3/EuZdep012KVqmf2RaYUiX1nj
   Q==;
X-CSE-ConnectionGUID: 8YDVr3pARce9aJcxxcL4tg==
X-CSE-MsgGUID: HgvmRwLeSDmcpaSPPd5w/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813878"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:21 -0700
X-CSE-ConnectionGUID: KxM5zAsqRrW0VdA/hkh9TA==
X-CSE-MsgGUID: 5cAR2LS2T6mRfcQ2nQaJNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432575"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: allow always calling iwl_mvm_get_bss_vif()
Date: Mon, 28 Oct 2024 13:54:48 +0200
Message-Id: <20241028135215.a343824e2c61.Ib92534f17c63630aa2eb0604fd80dbae20077487@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Allow calling iwl_mvm_get_bss_vif() without getting an error
message if multiple vifs are active etc., this is much easier
than having to check beforehand (which would be effectively
the same code as the function itself.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 1d1364d03f02..dbbec81559fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -679,10 +679,8 @@ struct ieee80211_vif *iwl_mvm_get_bss_vif(struct iwl_mvm *mvm)
 		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
 		iwl_mvm_bss_iface_iterator, &bss_iter_data);
 
-	if (bss_iter_data.error) {
-		IWL_ERR(mvm, "More than one managed interface active!\n");
+	if (bss_iter_data.error)
 		return ERR_PTR(-EINVAL);
-	}
 
 	return bss_iter_data.vif;
 }
-- 
2.34.1


