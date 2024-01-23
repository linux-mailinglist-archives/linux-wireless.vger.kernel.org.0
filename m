Return-Path: <linux-wireless+bounces-2399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDB83974A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875EC289C87
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B981211;
	Tue, 23 Jan 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpBkn7ZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB1E81AB8
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033333; cv=none; b=IOcD2Xu4HHOtouABEUSq9PZUXP2XI4eElr+aQau7XH/bXU4hnfHyMqVgBRb8izbvxtYgSmeL37hioxQG9Rd4LiHbxsgyz3Yc/yomOEhkxYY3MDxUOxqpx+UwXVCKRNZXADnXcgq6OzzqR6bcY5frZurxZ60Wm7a3548jQMDrrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033333; c=relaxed/simple;
	bh=RgzVesXq/zZ1bAJozBx51741iH+CxrsLQs9esaSLgIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJiJGATFC85kJonUCt8jdpwevuUbXbemkakmaRaAbwxA5B+0gyA7Gqz5/ITh4ODO2BE4PCwgE0iXMFA781JjU1oVmtvlBMUZ69tvTpELwgqwI0fE7x5xVhIib2GIMhsK+3cXajQpaNJV0xIKy8fIeTExJtC7rbSspSUiAuRx+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpBkn7ZA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033333; x=1737569333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RgzVesXq/zZ1bAJozBx51741iH+CxrsLQs9esaSLgIY=;
  b=JpBkn7ZAqTdaWIyp98Xn+rnImikgLrGtNct+WszqVvQuocOgu8UUxrAV
   yGyPTGZ9BgjvdiaTfuFr/EIssylrnjT1trgL0Ppv3FV+1JOww5a6yTyeU
   OhYCCMSLnBa8gAn/m0gnod21M44GR4OMJweEsteDqRUC2fGBXt3XIousD
   UJltxWq/BtWy2T0xLFkvem4hxpM+ccY6RyD4umywM+8oXz7jJFRm3wEna
   KtNaLYxBHv4YFBIpQiUru1MeP/tNDYQqWhHQhfoypxBiyBAv5PVhv6FMX
   zeGzMV2lQRulqfKYfz6VEd4TbUgwiYFlOtTJ9HjH9P5HwR/b4+PLLwpql
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501738"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501738"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666486"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: make TB reallocation a debug message
Date: Tue, 23 Jan 2024 20:08:12 +0200
Message-Id: <20240123200528.329d5f2ee7f7.I0bfc6dde17fe2c738129f3aba746c6cba57589f9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to print this, it's a known issue and
the workaround works just fine. Make the reallocation
message just a debug message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index ca74b1b63cac..ba0419bc1765 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -271,9 +271,10 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
 		meta = NULL;
 		goto unmap;
 	}
-	IWL_WARN(trans,
-		 "TB bug workaround: copied %d bytes from 0x%llx to 0x%llx\n",
-		 len, (unsigned long long)oldphys, (unsigned long long)phys);
+	IWL_DEBUG_TX(trans,
+		     "TB bug workaround: copied %d bytes from 0x%llx to 0x%llx\n",
+		     len, (unsigned long long)oldphys,
+		     (unsigned long long)phys);
 
 	ret = 0;
 unmap:
-- 
2.34.1


