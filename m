Return-Path: <linux-wireless+bounces-21884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E76A97F02
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A452172EAD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374F267393;
	Wed, 23 Apr 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZYW3ZVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61299266EE2
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389019; cv=none; b=L6//zEjxOVTpbp2nEf5q1VCgd9nm22+Ntv0bq4excunpnLcawfwT4WkRPgTuBOTBc2YFkoTETmEAfzBoBDWQ0C2CKWljTZu4RoyMqEOJvnyw3KNw/wdC8cHwUW3MZPu8OsFraGqFifO5YlJRuR3ih/8CUImaIp82HfB8pqUjGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389019; c=relaxed/simple;
	bh=g6BiFm89esW+8V8YJ24jsMF1JDmgXbzryMkXVjpvqIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohCYct4u/N+PDrZAh2+O4kvpUr8feivjsvdCG/zzK5eXlE9j2Gm1By27HwDGhNHkoia7EUFVWfbN9MlzXr8ehGmz0Cocxu1/ypV2nfw49pMeuHHEAHGuwkAEPpchcWIKQvUWa9XOYqU54scQRQFIPrmDiZa0JNYp+rlpEtyckyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZYW3ZVo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389018; x=1776925018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6BiFm89esW+8V8YJ24jsMF1JDmgXbzryMkXVjpvqIM=;
  b=TZYW3ZVoG05LiIITq34wexiSHWkpR/vL1ULAJNziB/mpWTrVLyHB8c26
   Gst1tGzIVTSgGgcfi+90DA3X1bNRe1hMwLV5nCY02BvUbVY4MJtPW+gau
   6hrnHM4gyw4GDu2kSX9WweaGkoMVi/CpZAnmzwjhiQ8WVmVhsZ+2VT0PZ
   hw83z8m4mu9Fw5t+/KxIQgi8yNxIgZbPCF5dOmmzROczaVKLfeSzGmMaw
   hAepYHqJu4/esWy1XVjMF0sBcYMtx1ilb7qtmg9wtcDzU/krBdEa1bDnH
   a0h46fIvDN8KShHHwOyp8VjUXmG3AvaICyfThJOaS6F5odsvybKuizQCX
   A==;
X-CSE-ConnectionGUID: V4RI4g5zSPSB4fC01x7Yxg==
X-CSE-MsgGUID: QnojmDguQzeO+jaogoL7NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843620"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:58 -0700
X-CSE-ConnectionGUID: WU14Z2CLQbCSNTxOJFskEQ==
X-CSE-MsgGUID: 2E1uSfEDTFOZG3tmJtw+bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269015"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 03/15] wifi: iwlwifi: re-add IWL_AMSDU_8K case
Date: Wed, 23 Apr 2025 09:16:29 +0300
Message-Id: <20250423091408.ef19205aa358.Ifbf89e7b7391cd7070267b7360c53230b3b2c57c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
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


