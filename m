Return-Path: <linux-wireless+bounces-21907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E1A98565
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 11:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CC43AA4C8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B6221544;
	Wed, 23 Apr 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAKFXPP9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E738242D6C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400310; cv=none; b=XoVw1Jvyxir42vbBnY064UeYuVs2a8ADDi5zDn/8xS7hO0WYryvuKex/kck73gSkwHigfApS0s6po16Y/502dQqMac1SsjkTp4Uj5t/aBPpYBaNu789hEFHjrwXGjP9wolk1SwbvThUr00sO8z9KC/kjGnGdCowxD60cfqU5e1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400310; c=relaxed/simple;
	bh=MQCgOcT/eU+lzEMD1vky4X0TdFL+Q2HXCqfRexcTEbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nP1ZLho1ERHwdytfLNj11X6c601D1eGQcbLD5KjQXrBOqqu/d3fHDUfJJP96DUC1PUBLkgDkkoEzbi5BUyLOgf/ONIc5YQfm8dZt0sqA4y0r5GpSjBEAvUzDn/qmhhBHhXpO7q4XC9+mUmnC61+3DJ7ZofKojGsHiS/Rc+6nTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAKFXPP9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745400308; x=1776936308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQCgOcT/eU+lzEMD1vky4X0TdFL+Q2HXCqfRexcTEbs=;
  b=CAKFXPP9v61KInft8dtHUaXKY+B6QWX4zuz2ulf9qx//w5eXcOH5gFL6
   XoFExWxrMD8dn2fPwAsBLusSrWUT14dTAj/aa6LbCY8Zng0di3HhUVi5L
   3ecnuGZcqfnTK/KLvVgMZxbv73MmaNGIsFbrM0WrbxlFOaontfHkRuLNg
   V2o2aKra6IiHcpk/br1NgX+IOqZufDVVSolW5vRIZrTUex/hMCttxuPvK
   2Mh4cMpU34v57wCWW8OXLkFV/lawmCkuZ4z08DYQrxxQOnqZ0IdE9G7ne
   juwevWD85ImkZG8aUEs4nC4hL8wGRhXeb9c2JJKhc6a/DD/hKdfARIpr4
   Q==;
X-CSE-ConnectionGUID: CljUaPVDTTOeftyyzmr63Q==
X-CSE-MsgGUID: 43i88Tn1T0qjtFdYdIr/dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50815110"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50815110"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 02:25:07 -0700
X-CSE-ConnectionGUID: qzu6nBccRGeFBq99MdJpDg==
X-CSE-MsgGUID: w5u44BPtSCW+kvS1J78Msg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="169475545"
Received: from iapp347.iil.intel.com (HELO 8ca39f2fbbbb.iil.intel.com) ([10.167.28.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 02:25:06 -0700
From: Itamar Shalev <itamar.shalev@intel.com>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH wireless v2] wifi: iwlwifi: restore missing initialization of async_handlers_list
Date: Wed, 23 Apr 2025 12:25:02 +0300
Message-Id: <20250423092503.35206-1-itamar.shalev@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The initialization of async_handlers_list
was accidentally removed in a previous change.
This patch restores the missing initialization
to ensure proper handler registration.

Fixes: 6895d74c11d8 ("wifi: iwlwifi: mld: initialize regulatory early")
Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
---
Changes in v2:
- Fix the fixes format.
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index d4a99ae64074..4bff036aa3a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -75,6 +75,7 @@ void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,

 	/* Setup async RX handling */
 	spin_lock_init(&mld->async_handlers_lock);
+	INIT_LIST_HEAD(&mld->async_handlers_list);
 	wiphy_work_init(&mld->async_handlers_wk,
 			iwl_mld_async_handlers_wk);

--
2.34.1

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


