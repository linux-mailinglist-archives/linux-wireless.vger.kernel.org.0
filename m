Return-Path: <linux-wireless+bounces-22275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD98AA4C63
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3BA9E0E79
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534ED2627F5;
	Wed, 30 Apr 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JW8Mhszx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38842620CF
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017885; cv=none; b=T0SAGTndn29ZEbEV/3ccF4ZB/EMYoEJ6R47REuQHiX+a7ZsW/tgvRSBVaYiTN4fo82pKBYGC6/kKEU0hUSaW+v/FnKdeLUHxZ3px2aeIb1asjGbRfGKIxcO/SX9gKiy17SR4xs+/fDAI+DRzfJ0RXAjL0mQ1+wOStlroIo/hOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017885; c=relaxed/simple;
	bh=Sxclxb4tVw67TWIaQqXKThbbu1kaUoIzQj82yA85c98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drB18WsrbXvVKWJqd7nfwEEgj4wb2dPFhrrYV1HfyXKi5F041mzT4U060pw6k4J8b9c54gmjSkzLnsqIlSz6yyrQG3emC1WDASqnyxhq8WtbT1x+0Gzad5b1KHPSdR45clwud+W07xDEZSRqmqA7J05jlKZgocwLh3M1xI8jkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JW8Mhszx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017884; x=1777553884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sxclxb4tVw67TWIaQqXKThbbu1kaUoIzQj82yA85c98=;
  b=JW8Mhszxsd89EMtFzVRGxxff0dm2QMwQ/wtZ7I1Qhb/hsdLXmmKALMlS
   IaxdkD010V67NOuWeQok1GNxS3Kgeln7YYqQj/rToFJjKQ1n8pOKqasbZ
   /vM9bayTQnvoLU9lk2Ii3d/Tyysu/T7bYGDIHcpmueP+sV+VX1qhbzmQ0
   N/UL9OVI7twvE6zeOKvCNBx75Rrqhclkr+ULOaI7Vsa07nyIaBhYvUMJ5
   /UeEWOyLb89AwAVgwqI3FRsYmExXhHFjkWrBmUCMNOYfpK+k8q3auAuby
   /p4PEEDQO4eDnAo3sbRqwYG4VNB5TVr4eyLzQ1j/5d4lf+CxJahaazkhG
   Q==;
X-CSE-ConnectionGUID: fQRzZphjT9Og3RBp0wzdaw==
X-CSE-MsgGUID: BIXG+p1hT/ibInXuDd3ccg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332354"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332354"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:58:03 -0700
X-CSE-ConnectionGUID: rp8+N7ISTLWFUbPGfCoG4g==
X-CSE-MsgGUID: xjQ1Fm54TU2ZmntpY5xI8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632137"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:58:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: set rx_mpdu_cmd_hdr_size
Date: Wed, 30 Apr 2025 15:57:28 +0300
Message-Id: <20250430155443.caf1d8e2bae3.I82d89bc8d128f78159a8a11b1573574dacdeb99e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Set rx_mpdu_cmd_hdr_size so that tracing will correctly include
the frame header.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 5d91de598256..e26fcce773aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -347,6 +347,7 @@ iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
 	struct iwl_trans *trans = mld->trans;
 
 	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
+	trans->rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_res_start);
 	trans->iml = mld->fw->iml;
 	trans->iml_len = mld->fw->iml_len;
 	trans->wide_cmd_header = true;
-- 
2.34.1


