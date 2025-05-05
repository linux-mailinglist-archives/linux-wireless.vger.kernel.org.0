Return-Path: <linux-wireless+bounces-22473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3602AA9C1E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2441A80FB1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35326E146;
	Mon,  5 May 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7FdNOhF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D02701CE
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471446; cv=none; b=YT+CCpOcT7DIQLfHEP99CLRsJ1mr1bHI2Kr77ikVBEsiedBvzj4oYqtrUVN7kls9DXS6QDywvvhkUJ+6kqZEspJgI/OZeQ7DtEEL+XEq3uUKBJoi+lBuLvuNSMTW0yMOUnpyHESUCTB3rM58k4w7ko0pP8ApmnU8UJPLfOplH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471446; c=relaxed/simple;
	bh=x6CuV3gdAwh+nySxZZq7umwfKsU/r26TrSWAPc90Ogg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQ0AfRIIahIbV5Kr+f3Bc7EMUAH1e/UzDJbeGu5AWwZz66Uudj4NI2uNiSfvl+SK7hKaQ+vJnBuQq+HneyAI1R0yloXFhr5RB5y707FQGLXI4JWraE0XYZWDxCpWsXsIlnJaPHyy159lMLGKry5b7dQdIKsZbMbCBxwZsG/D3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7FdNOhF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471445; x=1778007445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6CuV3gdAwh+nySxZZq7umwfKsU/r26TrSWAPc90Ogg=;
  b=f7FdNOhFSx4sgl+BucRDUb5dowlqKXRqjwdLyT3N1sQdP/yWrQi2PQWW
   MsJ8OqoJNjSE4MGZwAotiAeF+2GRfj7nsEV9eIMfmjy3ZuOkMkgJBs9ag
   gIBr8LznGgIseAUNZZHk0xgddVb6SUpV028LjKaYbyH2QR1nnBYG1mWOa
   Q/0ptyYJs1wupjW+nha6V1DoxDfeNPoLpDkwEoX9wSm5tq0VQwnvuZeh1
   u3va3q0QTwPEEjlB0lnA4uZ3QN4Hasf1ys+Q8vgk0w3roUZNTy3mRTnLA
   SXqgYk2SpDy4GrJPjPudtxeJRp6DqwrFiqAAjSGQHl6ELXDAM10DFM0Xs
   w==;
X-CSE-ConnectionGUID: RF93FfWtQ1GUTSzyCn1rfw==
X-CSE-MsgGUID: OCkHTr+GQK6OUOdwesUsVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359455"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:24 -0700
X-CSE-ConnectionGUID: 4kDzSfqQQJGejJ1NcfCVog==
X-CSE-MsgGUID: 0CCJIycrSxCMGplUPPkUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135698014"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: add support PE RF
Date: Mon,  5 May 2025 21:56:49 +0300
Message-Id: <20250505215513.c3481b1a4124.Id94c680636be2f59c9172919c79d80a48c7d1322@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is a new RF module and of course the firmware name for this new RF
module is different.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 652fa0708de8..e7629420be6a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -260,6 +260,9 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 			rf = "wh";
 		}
 		break;
+	case IWL_CFG_RF_TYPE_PE:
+		rf = "pe";
+		break;
 	default:
 		return "unknown-rf";
 	}
-- 
2.34.1


