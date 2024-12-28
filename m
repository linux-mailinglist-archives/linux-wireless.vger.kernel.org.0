Return-Path: <linux-wireless+bounces-16853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D19FDC35
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E3E3A1536
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419B19924F;
	Sat, 28 Dec 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZh8UJY1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602961990C8
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418093; cv=none; b=DE2JeSDoNI1C5XuJZDajSufb9ksPZJ37WuGCUwhSWDUYmLJesZSdOjI0DOSa05qz/8E9LD2KDfLmmNnSwTmkcSHeUsp3pN3986XGIwZdXb13eFY6gUtdqRhkJM4IeG4QC7grwLDRgjkqK8BaxD5/Ioz1WI+e/XnrKcrgNQ8TjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418093; c=relaxed/simple;
	bh=m1OUxnykpE9ZgaUf+ZodfpqCPgaGa0hAlpJ6xdBKLlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6V3zyXGcLvsB48WPfdXxDVmo70GxM6K7GsLIfNE7l8F7tKqzsMDMr0N7yXD/ITP+reGz/BOLaCW7b8Qfm7hRhJtBYQMC0kGuITr2zUCtJIH1bgJQyrGkZQzojhmqQqkDEw3rigbgNdgYhvqtVkWXoWGQu/DxG7DdCJ94/JCA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZh8UJY1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418092; x=1766954092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m1OUxnykpE9ZgaUf+ZodfpqCPgaGa0hAlpJ6xdBKLlA=;
  b=KZh8UJY1JblLnr5jl/iMuB02WNrq/AC609FgnhlTFUyyvS5zYU/i3oce
   k7SK8qbWwjfTLiivuTrZgIT8SX9zrw0Y6ysUZ3tKXws0lLWOhsSHLe7BE
   9733GDDxrL/TdFozWIbKrkS3FSa60lEDr21RfWgb0YS/i/v2+ug624I8a
   a7pcDLOWnNJMOEe7eGZJBuzPNaqvS8shiX1wJHEsqI/5DwAoaWISisRAg
   7fnsBvn3vF1jHSd+iboy76IPicqxmpBh8xQF2yDXCTeqwaCHUusAty7tl
   2yw5qfgk7CMpBeQSWWDVjrCG+9XFRZoYn/lgz0U+YEWpgsyPht8AMET+H
   A==;
X-CSE-ConnectionGUID: 9nILGjo1RcaXPXppLcblJw==
X-CSE-MsgGUID: feYoqpR3QPqnyAvqd+zUug==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479774"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479774"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:50 -0800
X-CSE-ConnectionGUID: kE9PXMJtSM+6dxY1TDymDQ==
X-CSE-MsgGUID: uO21h2quSkWvU1VJp/Vqcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488415"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 11/15] wifi: iwlwifi: avoid memory leak
Date: Sat, 28 Dec 2024 22:34:15 +0200
Message-Id: <20241228223206.bf61eaab99f8.Ibdc5df02f885208c222456d42c889c43b7e3b2f7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

A caller of iwl_acpi_get_dsm_object must free the returned object.
iwl_acpi_get_dsm_integer returns immediately without freeing
it if the expected size is more than 8 bytes. Fix that.

Note that with the current code this will never happen, since the caller
of iwl_acpi_get_dsm_integer already checks that the expected size if
either 1 or 4 bytes, so it can't exceed 8 bytes.

While at it, print the DSM value instead of the return value, as this
was the intention in the first place.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index d3ab40fc8ab0..b32d5141dbbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -108,7 +108,7 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 				    size_t expected_size)
 {
 	union acpi_object *obj;
-	int ret = 0;
+	int ret;
 
 	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL, guid);
 	if (IS_ERR(obj)) {
@@ -123,8 +123,10 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 	} else if (obj->type == ACPI_TYPE_BUFFER) {
 		__le64 le_value = 0;
 
-		if (WARN_ON_ONCE(expected_size > sizeof(le_value)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(expected_size > sizeof(le_value))) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		/* if the buffer size doesn't match the expected size */
 		if (obj->buffer.length != expected_size)
@@ -145,8 +147,9 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 	}
 
 	IWL_DEBUG_DEV_RADIO(dev,
-			    "ACPI: DSM method evaluated: func=%d, ret=%d\n",
-			    func, ret);
+			    "ACPI: DSM method evaluated: func=%d, value=%lld\n",
+			    func, *value);
+	ret = 0;
 out:
 	ACPI_FREE(obj);
 	return ret;
-- 
2.34.1


