Return-Path: <linux-wireless+bounces-19882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98CA54834
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB3B3ACF60
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DBA204C25;
	Thu,  6 Mar 2025 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGrN8BlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFD2040BF
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257831; cv=none; b=sDySgTfUGE92rd2fSFQKdC5MDoOWNRrqaIgguRxuT5e3MsGjKWtb2c/rP6yq4XDnVavwmzC9In9XhXG5OvPm/1lpYPcMEH0eNWS6lso4fH/kkZQZucG+VaNr9i93mpSldqt+mUUDJNGYd5LzRv9WnBDD+2qfvAuOKz1XcB25/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257831; c=relaxed/simple;
	bh=DYcltVUMLF4xMeT3uxSDwG6lZLJOWpkDsyW4wL2ahME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3vaCo/uy5NDocs3T5zLu8qRs8Pqkllj9Dta+jJuT4xz1Azy5Og0KbHUq7oCYGeyJRlkHr+rYtDxmxJvcXFh/CF+YlZQSG3HaOLMNpvHDyElVoeBVNwALFZjTpUY3taaqI3WEEhp/NACt/19nMSZlFfPjacO+7eWg4BmrEivhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGrN8BlJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257830; x=1772793830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYcltVUMLF4xMeT3uxSDwG6lZLJOWpkDsyW4wL2ahME=;
  b=MGrN8BlJsWjlg4pR1LHJWnnV0oJ2FJ3Yrec4SXwFDIo4k2K552p1KO9A
   Mg25qnUrKK3RZSHhbsvzwkPbhoMroKtvycvEDT5kFTDI6hckWZUWKFh/R
   oyai6ToMOdF9FZvdsHYcRm03uXlEzEqo5IS3g6AvWO8MJfXcFENOwcvJo
   UENIaLLg14D42dgXHg+20TZWPMlwZNjnOjewHXWppE9gquUMpnsDs3XMe
   OQ6KTkErHn4lPg5rMuCLo51NVDy6QXPh5a0K8YHvlhDRIFp/kIDfSjRje
   kIZ2nLXFv/URuurbFjaL7+QL1UAGEF89D4BN0ZSXQJJDsVNlMtNYgGsYL
   Q==;
X-CSE-ConnectionGUID: x4d+cfdvTgKaoOS9NtJzTQ==
X-CSE-MsgGUID: AuwdWn8+RnChSrm4h+no8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844488"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844488"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:50 -0800
X-CSE-ConnectionGUID: bU9ZosMsT4OUCwurTErUmg==
X-CSE-MsgGUID: 6Img398lQ7+Zyl1Wdh4r8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797744"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: mac80211: allow 320 MHz FTM measurements
Date: Thu,  6 Mar 2025 12:43:18 +0200
Message-Id: <20250306124057.eaa80d17cd7d.I9205c585fca6a54a2c5a9e4db98c7781bd1fc4e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
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


