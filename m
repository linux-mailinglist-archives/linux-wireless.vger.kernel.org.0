Return-Path: <linux-wireless+bounces-9911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB392579A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB3828C29C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D6916191E;
	Wed,  3 Jul 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hI3kCs2A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647813DDA3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000771; cv=none; b=iCR0ZulV0X4qCNK1Etkx3L9fMMXYsZMBlF00JoQ6hYxqMz3pVd1mBFvkdRI5HT6paTz6CLABzA7AYGKUBr9jtCI15mYQ+DfZ5io0zYXd1oXeQA4Xwwh6fSjsa8W9VXaLKr3rIyiu0wJZI9o6E2DQfrJBob/6iw1xqjoOJ1DIfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000771; c=relaxed/simple;
	bh=f99aTibn+l0Bq2tQ+avdyxVXWPh3cqDuT3S7PegTy7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6QHh/jOu28azBvaPCU96ZFdNYLH7TZBW7Vp8ldlf8ICor1g3QulKWg6U81RL10IhAbAX3fEh025Rk7IunMIVsGIMN/0Z6SIu1I1kSE06ttOmx7SMITAY+hZPZDaoim81EI3CQtj7RgUC0bWctYGa7tmAMmRTyNSmKTxa+RzCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hI3kCs2A; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000770; x=1751536770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f99aTibn+l0Bq2tQ+avdyxVXWPh3cqDuT3S7PegTy7s=;
  b=hI3kCs2A+wSuc0BzXju6LhcOHZ9xC9x0sco4YpzQMQMaw7l/NLRfHvoL
   Bvo4I3aK++6zf8Lsem8cD0TMwdf4zri5EegNWv1P4S3Qs16hIypLG9fy6
   O50YGzpydbVj9S5nugCvq6s+FWmRn/JlVRuB4YdU43sdji0lisU0zErm0
   axJXa4x0LtZLoRTdx9RbHtivTPslvkqyL1MsBXlhvhd7R8X6yQUDL4Z7d
   dUmOyGMr5XAZACTkgnFxOU71nAXMctUqDCKq9H5vH4bdjLXvRXe5tLiiy
   olcQ3JAUG+FbzDNLX3z9OHibwOqJnkSgFLKiHPt3KSjILeCQE1oYtVz5p
   Q==;
X-CSE-ConnectionGUID: o1YA7iceTIWmkAbPTl+X6Q==
X-CSE-MsgGUID: CPNGaClSSe6z7BMIcSY2vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837548"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:30 -0700
X-CSE-ConnectionGUID: 8+cSTG0NQQCKaAqSqbvduQ==
X-CSE-MsgGUID: 1AQLq356SfeRLF21OD2UcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987798"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/18] wifi: iwlwifi: mvm: add missing string for ROC EMLSR block
Date: Wed,  3 Jul 2024 12:58:58 +0300
Message-Id: <20240703125541.03d428f4ff4d.I858f17a5173fe8337cea4e7665fec00dbb15e514@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This should be labeled for the debug output, add the missing
string.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 4e702e7a4b82..a9929aa49913 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -11,6 +11,7 @@
 	HOW(BLOCKED_TPT)		\
 	HOW(BLOCKED_FW)			\
 	HOW(BLOCKED_NON_BSS)		\
+	HOW(BLOCKED_ROC)		\
 	HOW(EXIT_MISSED_BEACON)		\
 	HOW(EXIT_LOW_RSSI)		\
 	HOW(EXIT_COEX)			\
-- 
2.34.1


