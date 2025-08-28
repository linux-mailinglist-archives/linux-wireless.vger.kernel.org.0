Return-Path: <linux-wireless+bounces-26723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC8B39465
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486087B12B9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D92C2347;
	Thu, 28 Aug 2025 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbIzCZtg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364E27B354
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364162; cv=none; b=Gz+ERY+Th7YCd70VtY1JVGrktqJamfSwwjLpuXu+pgwE8e9h2U+f4f9uuu8hMGxU78USxr3b05ISGJBGPWiqMK2X6C5JRTLEz7WU5x+eJAO0Ync1uhbOiY0HnCqzk6TP+qKtTjzvmVBx1jmFyeaWgqDWjB6KhYghmB9AZD10nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364162; c=relaxed/simple;
	bh=TLfUZJWi41kVFyFTjIL1mPK8ICAg7Nb0GScTEEI4rp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQnOjdAgTrt6Gg4bkQDOUva2P56BCOM9XsXhBfCctpvOqHeI4ytc5PDy3kimwLXt3ZsusO4jR+CzUfhCWPbFgDcBJa6mIuZJJtQgXln3DbM2AwSVJnA0bmOec35mQnYcTxmYvq91xjI89iMgyh+VD4Y9DbQZmNAN4zVXTSJ4/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbIzCZtg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756364161; x=1787900161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TLfUZJWi41kVFyFTjIL1mPK8ICAg7Nb0GScTEEI4rp4=;
  b=kbIzCZtgkTWDxb1xcMyMX/Ni839rFV7WIJgyED3kpwOTvsVxTHWoBwdG
   zqg27jyi+whE+idhBGTWW3uWZxC1cvfmPnkm3syulEDhRL3lJ+nJbL9Q2
   9DZDcRB/hxAjVDSXSAJ/K0aJNPY/2hQrz/8cfaimFcILRz/BM8WSJD2u3
   9XZEfj3opItimDWkmh+K0OniU8JeQ4+KmOwo4dc0hHz5DQWITcWlG8AyT
   ZYLL765ymBBJ90tA8CqBhySPI0I1VOdAzL7iGjwsqP+XMa6i/qsgPNmC/
   zIalwObEQfoYL33ihSkLqhU9XtIq8tKX9ctejzzD5MdlwFEpxs5jPOWpu
   Q==;
X-CSE-ConnectionGUID: JdsfjWOuRKqYr0RTL9OUMg==
X-CSE-MsgGUID: 3vFQhioSTK6zbl16whe2SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58723685"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58723685"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:56:01 -0700
X-CSE-ConnectionGUID: cv2fqsvnQu2+H+CCFgllMA==
X-CSE-MsgGUID: 1PbUCyv/SB2hYfIo60GfjQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:55:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 3/6] wifi: iwlwifi: uefi: check DSM item validity
Date: Thu, 28 Aug 2025 09:55:28 +0300
Message-Id: <20250828095500.59ec52ff865e.I9e11f497a029eb38f481b2c90c43c0935285216d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The first array index is a bitmap indicating which of the
other values are valid. Check that bitmap before returning
a value.

Fixes: fc7214c3c986 ("wifi: iwlwifi: read DSM functions from UEFI")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220085
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 48126ec6b94b..99a17b9323e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -747,6 +747,12 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		goto out;
 	}
 
+	if (!(data->functions[DSM_FUNC_QUERY] & BIT(func))) {
+		IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
+				func, data->functions[DSM_FUNC_QUERY]);
+		goto out;
+	}
+
 	*value = data->functions[func];
 
 	IWL_DEBUG_RADIO(fwrt,
-- 
2.34.1


