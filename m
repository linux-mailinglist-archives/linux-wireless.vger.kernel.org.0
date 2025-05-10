Return-Path: <linux-wireless+bounces-22822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716EAB250C
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A72F7AA543
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5911C285409;
	Sat, 10 May 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaZ40lfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D1284677
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902935; cv=none; b=utQm2UbX0b0U0x4r/mWqBWxYJVhgvfr1IhrzswveDN0L9Wu8+CcDhWDZdpZilIiKfUpTEFKYWL1neqgKO+3WvdLoUX87NA9WqIHfZHWwWg0PVLGyU9z7ij/58m03tfcHZFodRVrVMPlybKCyQ/e/G9xpksxnPmmsxQmET7O1YGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902935; c=relaxed/simple;
	bh=BYcgh1xepvAucoJjxe+hapCAFmmCIDIIdgYFXWC3jnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mkvrJgRNmeD5jnNKGQx/mT8y0tvn9S2w8+WWrmS3xNH2r2biJ8alUBqkyBq3eqcWOBEkMQkEgdJxQkNpO/7ZZaiiHJnoNjCX7IQO+hozobgzSlE6Mg2BO+8NNo3zWqZuiWJdo04+4cV6ngx2k+8/DUajR8PHob3pY/SmrMdgmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaZ40lfB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902934; x=1778438934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BYcgh1xepvAucoJjxe+hapCAFmmCIDIIdgYFXWC3jnk=;
  b=HaZ40lfBm7iTV9rCkxXS51TD9BwTWbs+fNM9nNWsjyOAcXxxkgNNvEID
   i3zCqNlVNsDqXr2Fn8s6YTZ482IdYqYHjyE/i4R/Z+vWKvnaJ/IB8cPmw
   vkM5qehcbXVYa53OQu13wVbVTNj7840s7gOzB3bPVpG5Zmw6rOut7N5i+
   qk+WJP+ndCyjbg6sUJIUjKULat6MbfuoRoJK2phFhJ/ULbaB8ZGW75po3
   lf+O/z0JWU7lm0G8yaCV3PCQ4Gr49zDtH4EFhz/ICdf/ygBgaSE8nazVj
   VCjbc/tHAjy53h/as7vtAnIMIJnz02pKj/gYEt4/camtuBcI9eD+WoHow
   Q==;
X-CSE-ConnectionGUID: cKqxULdjTDi26Hy9+4acvw==
X-CSE-MsgGUID: cMrHlYUDSfexUMRJg+1CXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880889"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880889"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:54 -0700
X-CSE-ConnectionGUID: R8ES1CQDTciZP/hrQCHfxg==
X-CSE-MsgGUID: ylQAlhO8RU6jCKksd1iTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033437"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: tests: make subdev match test more precise
Date: Sat, 10 May 2025 21:48:21 +0300
Message-Id: <20250510214621.87cc0ad360a8.I9be361caedd7258e8e817d4100c549681396f307@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It's OK to match with subdevice_mask as long as that doesn't
overlap the RF ID/BW limit/cores fields in that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 115642c75d10..bd0102ef7384 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -104,9 +104,17 @@ static void devinfo_check_subdev_match(struct kunit *test)
 		if (di->bw_limit == 1)
 			KUNIT_EXPECT_NE(test, di->cfg->bw_limit, 0);
 
+		/* if subdevice is ANY we can have RF ID/BW limit/cores */
 		if (di->subdevice == (u16)IWL_CFG_ANY)
 			continue;
 
+		/* same if the subdevice mask doesn't overlap them */
+		if (IWL_SUBDEVICE_RF_ID(di->subdevice_mask) == 0 &&
+		    IWL_SUBDEVICE_BW_LIM(di->subdevice_mask) == 0 &&
+		    IWL_SUBDEVICE_CORES(di->subdevice_mask) == 0)
+			continue;
+
+		/* but otherwise they shouldn't be used */
 		KUNIT_EXPECT_EQ(test, di->rf_id, (u8)IWL_CFG_ANY);
 		KUNIT_EXPECT_EQ(test, di->bw_limit, (u8)IWL_CFG_ANY);
 		KUNIT_EXPECT_EQ(test, di->cores, (u8)IWL_CFG_ANY);
-- 
2.34.1


