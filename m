Return-Path: <linux-wireless+bounces-19912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1410A54A0A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F7918888DF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6620CCF8;
	Thu,  6 Mar 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKgHBoXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC40C20AF98
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261780; cv=none; b=b7ejjCdFTe/3XU0lNL7JIVcsjx8nMiy4p1rfalUnpJX/jwzLwjgo/DgcIY8QSKnNK8BzbsXLfnmRUR1mQWPxZt1RbfP9ZZ1R8zHs45qBnhUXgqzY9UslW2PMOVXmegFIQVemL34l1h5TTZeZx9D6rE0GzdONXhd9/nVypF/x5VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261780; c=relaxed/simple;
	bh=g6BiFm89esW+8V8YJ24jsMF1JDmgXbzryMkXVjpvqIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2Jin2X77rpODV+o30TT727ZbHkLvj1u7oTp5UzvbCEFbhaVF2HnYchpRqN/7tTxJ/DDdkMgy46iNyn6aK+UceDveY/0inKJViM4boqj5MlrVYRA1uraWVebe0Vsm86aoe7FZmEpTXKZgcxQLg5iKu7yl4lmSRyBtZ8MkrCHEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKgHBoXj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261779; x=1772797779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6BiFm89esW+8V8YJ24jsMF1JDmgXbzryMkXVjpvqIM=;
  b=bKgHBoXjSlFnFfYyPy2sype4tXocUYiw6CXlrUjlUp60b8q7cjWteCV6
   fqqqvvJcY+tIBbqnJWWNUG3c7PiJVzk1/+ob3pNr8ZNutV1wV4JG88z+r
   Ix2OmcdVmUsGcd6F1wj+V62A7YBK+P8EoX+Rt/ufGVsGUcdlNTvasq+CP
   Gf7ePvqBuPj0a2gSVO3JopKSPu4OjekBjlfJc8owisouqJbbir6uhBaNk
   n9tuMIqyOzObixgXKGmU6Q3BpVf2bmBTIgd+BMGYQF+4rJKz+kY1sTFVJ
   lrbpE+j6uu1EaOsQkc9X540w4jdyArxSKVsbaB4Oh3huxf1t648ROb//X
   Q==;
X-CSE-ConnectionGUID: 14y9wfqMTCCkIX2vsLuWTg==
X-CSE-MsgGUID: GMR29ZgoReyOdt2BziGnoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474578"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474578"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:39 -0800
X-CSE-ConnectionGUID: PFMGPfU8SkuXdx1SGLZMBQ==
X-CSE-MsgGUID: S2a/eHwzQEaCmelOpnq57w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915597"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 19/19] wifi: iwlwifi: re-add IWL_AMSDU_8K case
Date: Thu,  6 Mar 2025 13:48:55 +0200
Message-Id: <20250306134559.fd4ec088400a.Ifbf89e7b7391cd7070267b7360c53230b3b2c57c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This case in iwl_trans_get_rb_size_order was accidently combined with
the IWL_AMSDU_12K case. Fix this.

Fixes: 7391b2a4f7db ("wifi: iwlwifi: rework firmware error handling")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 25fb4c50e38b..b9dc1b8794ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -328,6 +328,7 @@ iwl_trans_get_rb_size_order(enum iwl_amsdu_size rb_size)
 	case IWL_AMSDU_4K:
 		return get_order(4 * 1024);
 	case IWL_AMSDU_8K:
+		return get_order(8 * 1024);
 	case IWL_AMSDU_12K:
 		return get_order(16 * 1024);
 	default:
-- 
2.34.1


