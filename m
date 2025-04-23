Return-Path: <linux-wireless+bounces-21863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13DA97E4C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDB33B93B2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C88266B65;
	Wed, 23 Apr 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jp98w9Jj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5787266B51
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387455; cv=none; b=MnEsLYBVRGVDiq+XaJMDeEjLc38tc1JELwJ9DV9L9JvZ0cULAAEWnb+RvOk1hyXnpjHMHHxjGxA+twbmn3bqCxufdJV1MHMyLkOm/QwD8JOSsGBbDSFMrMt/jGOy3MBx/Pxo/vWy3Cxe96fEa+FyLKP6emAsY200mSqnsL6GvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387455; c=relaxed/simple;
	bh=g6BiFm89esW+8V8YJ24jsMF1JDmgXbzryMkXVjpvqIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXLYsjGXQ/qtuLDsX1iEvOeNlICpQUS9/avGL3DEFX7pd8+45Yx70RfieSBr+MTNcrWztaNMnkxwQ2XN7V+NQmpsMmvtM2+GEtvIcEiE2jGaAiVuYiNcx5Sq71OCLhJy/eII1DyL5/3eFY7k4EM/MoCMVparkTL9AVEAM68QWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jp98w9Jj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387453; x=1776923453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6BiFm89esW+8V8YJ24jsMF1JDmgXbzryMkXVjpvqIM=;
  b=Jp98w9Jj5sMawQrEZxg1sCyhm5x9Nw1P7b1UZ6xqi/CwT/VVoM7m8kn7
   mjehAW21ATkzwSLrGJa0Wcp7ZJOXDs0tk2OVBsPdzENgLx0npzYXPW5x5
   1Vl6PkteyPviba8atzpgNjD4aBie1Jr8dgwhqfgZ6QT/dgaoYTp013t3H
   KDUy83ttFojlx1YsbqEjxZhibRHVjkHvyXO+M6GUiKuG6tsAeKtta6hx4
   5fK50S9k+YXFZR8NjQkZh7eBSUPEGpYE+F/hoySs9SkwxlilD9pdDefh3
   EQjZS12didWAlM5U987zJN/7LHMYCO61Yf1Hl1iEqj//rpJkXAshgio/E
   g==;
X-CSE-ConnectionGUID: NNOLrlyzRSeDU3eSLkpCmg==
X-CSE-MsgGUID: DEB8cTl3TZ26C3P3Wz/a+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844619"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844619"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:53 -0700
X-CSE-ConnectionGUID: TyHzT6VEQz2Ldts0dchRFw==
X-CSE-MsgGUID: l3EcZlNYRH65eFlXIVMRbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164309"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 03/17] wifi: iwlwifi: re-add IWL_AMSDU_8K case
Date: Wed, 23 Apr 2025 08:50:22 +0300
Message-Id: <20250423084826.ef19205aa358.Ifbf89e7b7391cd7070267b7360c53230b3b2c57c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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


