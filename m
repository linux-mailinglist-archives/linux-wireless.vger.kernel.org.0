Return-Path: <linux-wireless+bounces-20036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D50A57E5C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5D2188D823
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF51A5BBD;
	Sat,  8 Mar 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbQe99vk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8081EFF86
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468001; cv=none; b=o7XIoYxo09nXNTqPr9Emv4QQmOHNLl5/bcjyu11MHXTh0Zvu38/oTPjuroTB1fr80hMctSW9B4rCuWXoatDEBaTPbInAodqSGIsdcj/0XR+jcSfT/58nxuz7QQTsn7NPBwh1R0UrxAlfXtPW2fNlDmCCIGXvYj77Dbw7ONOJcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468001; c=relaxed/simple;
	bh=DYcltVUMLF4xMeT3uxSDwG6lZLJOWpkDsyW4wL2ahME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JetjeWXhay4qG5C4Ez8ZuyaghQF33EFxZnSeTDL3YPnO4/MSbzqRqGxejKIPRfpKXu4+xlYFd255gFtQWDlRhrv7sXHTJhEdFMHp45im527E8TzG3tP9zIdP9VwdkTcWl2+DJ8s9uhG3A5d6tddTNi2qq9jNiSOK0Q6bKrKLKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbQe99vk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468000; x=1773004000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYcltVUMLF4xMeT3uxSDwG6lZLJOWpkDsyW4wL2ahME=;
  b=RbQe99vk+7GqqSRou1+PF3hfcunqGVs7BDbpOuuN7nPw4t4o/3hDev0v
   00i5ewPk66fahJ6IUJCdufvXVouOJplIasCBOVK6pa4MvzpuhERmKLOCU
   kDnOg9V7tEqP8r7eqTWlZ/EgihVdehQ07Q/xYTxOqfqhDjxLUlxUL6PpN
   O1KKLdQMxN6z7g4/eRz3cVHbT7SFRxSfRrdfeCEDvt4zH+3HhTZparY9D
   o+KmKAnNAcD8A70q6xgtQGnjGQEn9lOf1gnYB1kQNtViajt21LlwLRQLA
   yqNd0ttNl/PWZQXPgsPLlhPxqUAS+RjRlm+DctmCZ56J40UvswQbVmwpC
   w==;
X-CSE-ConnectionGUID: uflHtL+aQPKgKoJHJghwRw==
X-CSE-MsgGUID: zZbTZG0eRqS2y0e/5cRgtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413067"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:05 -0800
X-CSE-ConnectionGUID: txid155XTOiNfAH0s6+ToQ==
X-CSE-MsgGUID: rGjxDKDXRqGA55ShoOEMGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644386"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH RESEND wireless-next 07/15] wifi: mac80211: allow 320 MHz FTM measurements
Date: Sat,  8 Mar 2025 23:03:33 +0200
Message-Id: <20250308225541.91f4cbe66817.I9205c585fca6a54a2c5a9e4db98c7781bd1fc4e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add 320 MHz to the list of allowed bandwidths for FTM measurements.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 15bbc9d06c9e..52728527c6f5 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -793,6 +793,7 @@ int wiphy_register(struct wiphy *wiphy)
 				  BIT(NL80211_CHAN_WIDTH_80) |
 				  BIT(NL80211_CHAN_WIDTH_80P80) |
 				  BIT(NL80211_CHAN_WIDTH_160) |
+				  BIT(NL80211_CHAN_WIDTH_320) |
 				  BIT(NL80211_CHAN_WIDTH_5) |
 				  BIT(NL80211_CHAN_WIDTH_10))))
 			return -EINVAL;
-- 
2.34.1


