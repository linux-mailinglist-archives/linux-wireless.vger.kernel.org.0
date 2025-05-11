Return-Path: <linux-wireless+bounces-22849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A650DAB29CF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C452B168FA5
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920325D914;
	Sun, 11 May 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLJHBc+e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8425D910
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982429; cv=none; b=jEK6/P12luxuzT9HJlbptPfZ/JrRzYrkBAX93lz4aKc6HHTLFHrprMWapNqIcvfGg+aCWecno0K42AW+CJPLGoRyNCdvu+ZD/MiG4KAPAgTfkJu3L26fOcMPsepauwGTv3okGvLLlA4EJpZVrQlYV2KPwpXuPVjjsvUpMV+mkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982429; c=relaxed/simple;
	bh=ouUnGZ3qe8pdBFpplusobx8ii4D48bN1fXI421tCswQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTxXYUzH5x+Lk4gJd5x2J5RkPcx1D6bQni3vAg6Ur38jmklDL//SbGn1k4DE+eWKSr26ovmSWPk9Wb+FIBEfpMqcWMlJtX0ftnUdJBES4mIFe46cyDFi/m3w5C3ujiKEP2kvg1mCT6wOUujdEQ8+zSO1YAXeiR5G/mtbjli2mX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLJHBc+e; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982428; x=1778518428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ouUnGZ3qe8pdBFpplusobx8ii4D48bN1fXI421tCswQ=;
  b=YLJHBc+ehilxcSy1prM6Qzo521A/sEpm8H31Ba4a+8cWfxbCvhF2M5na
   t74h9/6LFlni/5FwygkE60VUHPSkSPqOa8OQ0tkAfmDy+BozLxDFvRsaP
   8pAtSd10qeSYo8XQZ0uSOoFihPdp5hFaPkux7ckntu0VcvsjwSZGiv1n+
   +jEkUsraGLirH5KWUi5dBKh2P/jqfBO7P50Uvg4MYGptUs/rTNoVFvG02
   UIszIc4l6oIY9lvyuEh8V/5DsbDSj/JO2M9vvG3LWgahngksyLtpX03ny
   B22I7shISCsJwOSdHfVIXrCCoqXIke4RQvQEsmCqaBxvEvHMBvetXMqvG
   g==;
X-CSE-ConnectionGUID: s1fwIBSoRYGckVPzVub9Wg==
X-CSE-MsgGUID: +4XWuBasTja4iUmCb36CWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582696"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:48 -0700
X-CSE-ConnectionGUID: 7b4nnuEeSkSa5j9zw5SgdA==
X-CSE-MsgGUID: ox2J2K+5S7KKr283F7RHJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655078"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: remove unused macro
Date: Sun, 11 May 2025 19:53:16 +0300
Message-Id: <20250511195137.a0154cca6afb.Ifb4915e0acd51be6a75d33a8b96b3f7b0928b312@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

TFD_QUEUE_SIZE_MAX_GEN3 is not used, remove it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index ee9e41c31797..0f6de08b7473 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -588,7 +588,6 @@ struct iwl_rb_status {
 
 
 #define TFD_QUEUE_SIZE_MAX      (256)
-#define TFD_QUEUE_SIZE_MAX_GEN3 (65536)
 /* cb size is the exponent - 3 */
 #define TFD_QUEUE_CB_SIZE(x)	(ilog2(x) - 3)
 #define TFD_QUEUE_SIZE_BC_DUP	(64)
-- 
2.34.1


