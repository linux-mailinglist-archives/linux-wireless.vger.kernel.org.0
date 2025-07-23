Return-Path: <linux-wireless+bounces-25896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D792B0EADC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FD017F3F4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08FC270EBB;
	Wed, 23 Jul 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOhVjqyW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21ED271469
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253145; cv=none; b=C25S6Wda6yEtaVsAQXV+uAytHeoPPKau6KQRWhJwaxEQD8fb+Be6caq5TqrYX0ARYOkQsdRuA7MCVY3tMY0yc1A/fF5DMQKKmkixEfxh1CYqesc/ecIdWf6AmCgLouPFtFBzKEpdIeg/R6qt4KTkLb6DCW37TURZu/eGH/1NJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253145; c=relaxed/simple;
	bh=4LgHXbtObKheDq2SdSF+ueGU8ZkouyyX/UvjL/Shu78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtXvRXTq0iFRwahLJI7KhfNthB0PYJGXrKjns5zcvRT2fMYu3DnShimn5IYpO3PCtud+QTXwkpRXzmvidrCf6A64ktWCM9Z2YhFgjvTrkA5wGzJeOmlpZ29hhybW2OAmMP0ekRVrR7F4KRdMVY0Kq30ccP0v9Y6uLa0mDCTwnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOhVjqyW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253144; x=1784789144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4LgHXbtObKheDq2SdSF+ueGU8ZkouyyX/UvjL/Shu78=;
  b=TOhVjqyW1PDh02qmbwC8/9wA5y/XL7iKfCi5mjE67aWP783KVjD73mJ0
   fUjm89Z2wRET1U+P0L7rNiG5rFwqyoTmZz2ZZL8HilDEc8CzpUpI/37Gz
   /Q/xvJ0GXuBjDN+TkuVN6zJkTFbDPIctC8/VE/FrmaMs0KIpkEuD2yQGW
   F/FCa8sXs4EtAbN23u7/EI4DEaxNMDFejtunZblZ4Cxo9ReboF528aug1
   5B3U6/noQ8sq7KqcmwuQhZI0pityfGTdyz/hvXVgQxOq7oVI9EKYohSdI
   M13RSfrJE4y9IIimFNuclr7XWqMQmzYaPr35fo68XFzQJPdPC4hQPNPdN
   Q==;
X-CSE-ConnectionGUID: JOxXs2rHRAGPVwBZ7Sp6Lg==
X-CSE-MsgGUID: zSfqllzTRjuv7CmbpQKhYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340738"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340738"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:43 -0700
X-CSE-ConnectionGUID: txovpVXmSS6L2WQqwFN4MQ==
X-CSE-MsgGUID: s8An+DURTzKp2k5VzhCjBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918079"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/14] wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
Date: Wed, 23 Jul 2025 09:45:05 +0300
Message-Id: <20250723094230.795ec0cb8817.I9ec9a3508e7935e8d1833ea3e086066fdefee644@changeid>
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

From: Avraham Stern <avraham.stern@intel.com>

If no frames are received on a queue for a while, the reorder buffer
head_sn may be an old one. When the next frame that is received on
that queue and buffered is a subframe of an AMSDU but not the last
subframe, it will not update the buffer's head_sn. When the frame
release notification arrives, it will not release the buffered frame
because it will look like the notification's NSSN is lower than the
buffer's head_sn (because of a wraparound).
Fix it by updating the head_sn when the first frame is buffered.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 4b57ca56e1f6..62e76a79f621 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -905,10 +905,15 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	 * already ahead and it will be dropped.
 	 * If the last sub-frame is not on this queue - we will get frame
 	 * release notification with up to date NSSN.
+	 * If this is the first frame that is stored in the buffer, the head_sn
+	 * may be outdated. Update it based on the last NSSN to make sure it
+	 * will be released when the frame release notification arrives.
 	 */
 	if (!amsdu || last_subframe)
 		iwl_mvm_release_frames(mvm, sta, napi, baid_data,
 				       buffer, nssn);
+	else if (buffer->num_stored == 1)
+		buffer->head_sn = nssn;
 
 	spin_unlock_bh(&buffer->lock);
 	return true;
-- 
2.34.1


