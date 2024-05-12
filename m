Return-Path: <linux-wireless+bounces-7522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3CB8C350D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A29A281C74
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD01C69D;
	Sun, 12 May 2024 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFsuFXnT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE891BF37
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488302; cv=none; b=A2qv1n61Bo3xIt9wriRsl9en5pR1vqPWb9iGfqGSQXAdGncRgQHSvvZQ/HANzuvAb0SWdimzeMSe+b0IQa3/xRB7Nw6nB6qKPZfEMjoyn/3qRuuhwXZtp2ASQGxN5oV71HT5dQzBu62aTpLE8Hb0wwfAx6nAkqLX95m9NM+ODvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488302; c=relaxed/simple;
	bh=Jam9qhvpJ3uN0qNGyqg9b5MfIYbwsvwj2oMgIwDqeJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAENhi5D4pKzC4er7mH2QOiW5TLoOjtC/rRajMVoriKCjZ3ECYuMIsEf2pYdDeukMCz1/tZw9u30pKCtijY0lVwG0uckVF5NINaq2l5DTyrVwCVSkSuWePPwJdGQYqL7c/spZUfNEFKmO5lrkRHykKpTp6D8RQIMn28J1D3A8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFsuFXnT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488300; x=1747024300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jam9qhvpJ3uN0qNGyqg9b5MfIYbwsvwj2oMgIwDqeJ8=;
  b=iFsuFXnTLh2JJCvgRxwe02o4Eu7+R3b+oiamatil5VvqbL/vGworEqLa
   9JBhHlPighf6n+t4YeyybQPx5/6a+mUJqfTJisK1xZdZomnt9/8jySfLs
   v74AAq3BwS2OzBmJBiP2XUKNkalLmdpZKKivhqSaFXChtTU9Ef8MUp1L9
   Jj7qCWxZbo7wxKe/GO1un/qiIHW6gt3o9shUR3hIR7YhUOWdQvbQpIu3c
   ectDOjQRKreOfHCjCznnz2Jz6/4Iw/LmKSQynHJlwMOsfL9AGCR3Vgctv
   AGZrrxkx4+3X59gtfm7yKnDNyQewcwCrT8qivT4xEjBy/OdZBMelGxsLx
   w==;
X-CSE-ConnectionGUID: u2+MECG4RVCRmyYA2B6Gqw==
X-CSE-MsgGUID: Zmg/l6LxR6O1dqzyo8OKXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323861"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323861"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:40 -0700
X-CSE-ConnectionGUID: eTv2hWD/RKCXlMH++CdeRw==
X-CSE-MsgGUID: MA1gnJDfRRGIk9Oh9U+MMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532175"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/16] wifi: iwlwifi: always print the firmware version in hex
Date: Sun, 12 May 2024 07:31:05 +0300
Message-Id: <20240512072733.cae4c562b2c3.I5043383bd0e81f872c55046afd2c6560f482c8e0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

All our firmware versions should now be printed in hex.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d156a9c64194..249dfd207fcf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -982,16 +982,10 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			minor = le32_to_cpup(ptr++);
 			local_comp = le32_to_cpup(ptr);
 
-			if (major >= 35)
-				snprintf(drv->fw.fw_version,
-					 sizeof(drv->fw.fw_version),
-					"%u.%08x.%u %s", major, minor,
-					local_comp, iwl_reduced_fw_name(drv));
-			else
-				snprintf(drv->fw.fw_version,
-					 sizeof(drv->fw.fw_version),
-					"%u.%u.%u %s", major, minor,
-					local_comp, iwl_reduced_fw_name(drv));
+			snprintf(drv->fw.fw_version,
+				 sizeof(drv->fw.fw_version),
+				 "%u.%08x.%u %s", major, minor,
+				 local_comp, iwl_reduced_fw_name(drv));
 			break;
 			}
 		case IWL_UCODE_TLV_FW_DBG_DEST: {
-- 
2.34.1


