Return-Path: <linux-wireless+bounces-1033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0009819121
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511451F24D32
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D423B189;
	Tue, 19 Dec 2023 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ok6I0fYs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C253A1D1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015984; x=1734551984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3sheMNmS1CzKxKy1YRU17Q7Q26WOecH1f2mLKr6uIo=;
  b=Ok6I0fYseIn2aKW814KLoXBy+fUBQdnz1MQPZCtYR+4wj5FTqU8FbHeA
   s86tvEMfRKgh6Dqtlx1b0midWYhiRVcnSEby7wb2v34vk+/O6zW4qeAEN
   ZeK+OonG6fsEmPzUJF8WfDdZCYF757QbdA47ffuPVYjYrX6dtO1WUyGJv
   ghzrBMK5TrZPlA/xdGVJ7FDKMx7dCOX/A93YAsPSGDfxfLA68RYDWjDCQ
   pEMjW1ihhrwI2v6EcSqjcsnns8lbjwjfItsmA7n12FYI1EKiQgDihe8S+
   YC1fhjTUN64CaRrDADbWHevU7hMRSUPPuKOyrB2t+QOMByd+Pa20JZNGF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694954"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694954"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589112"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589112"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: fix out of bound copy_from_user
Date: Tue, 19 Dec 2023 21:58:55 +0200
Message-Id: <20231219215605.e4913deb2ad4.Idcf6a7e909ff4b7801cd49c2f691f84a2f68eff9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

The driver copies the userspace buffer into an internal NUL
byte terminated buffer. While doing so, it was reading beyond
the end of the userspace buffer, overwriting its own NUL
termination in the process.

Fix this by only copying the correct number of bytes.

Fixes: 3f244876ef73 ("wifi: iwlwifi: make debugfs entries link specific")
Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index e016fce7ab24..16a104de8371 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1829,7 +1829,7 @@ static ssize_t _iwl_dbgfs_link_sta_##name##_write(struct file *file,	\
 	char buf[buflen] = {};						\
 	size_t buf_size = min(count, sizeof(buf) -  1);			\
 									\
-	if (copy_from_user(buf, user_buf, sizeof(buf)))			\
+	if (copy_from_user(buf, user_buf, buf_size))			\
 		return -EFAULT;						\
 									\
 	return _iwl_dbgfs_link_sta_wrap_write(iwl_dbgfs_##name##_write,	\
-- 
2.34.1


