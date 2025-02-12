Return-Path: <linux-wireless+bounces-18816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41302A31E22
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC68161125
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358021FBCB2;
	Wed, 12 Feb 2025 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFEoZNsy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE201F8AC5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339045; cv=none; b=mU4IKJlkKUi9Dc84OjALUbNa/eht77qyO0vMObO4OJG+vmUMRQyUWvz711NlcmTx+SL9Aju7lSTXFFuZ0Cn8nKeGx7nmL4p7TXFY4rhYJee3+kAYPl0exKpW4Fqm9xo9gLAyDRPE++V+SXjHk0bfgxMQB2AWXXqcDFwJbuJb6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339045; c=relaxed/simple;
	bh=hRTWq+S02+FLN2jO2jceKX8ghSU5ywr6qGTxNZYgaPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R66udKs3w7fUBgolPu/3MgB3GHHTrAQ7oQnYsxRfF37GfOdgPNSbjgHWF0Rqy0fAdMjNN5gTczG2Wr9et0s6wVFcxcAJYbqB5ETxA6yYoFvvPTZsmeZOfAPg35G57GyU4YpAXAilkJgDLMd/E0GnIh+d4He9zSdoIQ/Fc5JAe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFEoZNsy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339043; x=1770875043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hRTWq+S02+FLN2jO2jceKX8ghSU5ywr6qGTxNZYgaPk=;
  b=BFEoZNsyrQWoYimmPJOXLLqCATsQZjygscwNZAsqdkuolY34xuzRBhgx
   QFHjAyYu9qyeU0LzVW85g25MdBB31SL2AnukXA04hVtWMvekXkR6XqEFH
   vHqNlAo8w9MfI2cWCyiGyFwKz8sLCKYn7Il9tNconxFXfB79N7K7CkKhg
   sfYMo7/4bMYYl8tfDZZxUAERfGxQ8uOckLmZUk5ZzU54Pd09723iTZ0nj
   HXbiZcmNoVqNvlGW2G83uvXFwCjM1HVpVxfHmy30QsPlbocbOPW3TOVrM
   HBtkGqGeq3wP3m0+d1lF9NQOOqnTExMhhIcvN4up+JzaSa4Syg/YY77l7
   Q==;
X-CSE-ConnectionGUID: oSW+70OxSV6ZuclCcu4IDA==
X-CSE-MsgGUID: m0BYCMvcTSaBJuhr0hvbgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172228"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172228"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:44:03 -0800
X-CSE-ConnectionGUID: QNPaoU3eSgC2hGiYUdT1cg==
X-CSE-MsgGUID: 1lSG79B9TPeyZ4926zivrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893910"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:44:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 11/12] wifi: iwlwifi: add IWL_MAX_NUM_IGTKS macro
Date: Wed, 12 Feb 2025 07:43:32 +0200
Message-Id: <20250212073923.a8e3c7461f13.If63cbc73eaf328b2c1d7c8e57627eb93c35b0c70@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This macro represents the number of IGTKS the FW can support.
Will be used in a later patch.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index d7f8a276b683..ecbcd5084cd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -191,6 +191,7 @@ enum iwl_sta_sleep_flag {
 #define STA_KEY_IDX_INVALID (0xff)
 #define STA_KEY_MAX_DATA_KEY_NUM (4)
 #define IWL_MAX_GLOBAL_KEYS (4)
+#define IWL_MAX_NUM_IGTKS 2
 #define STA_KEY_LEN_WEP40 (5)
 #define STA_KEY_LEN_WEP104 (13)
 
-- 
2.34.1


