Return-Path: <linux-wireless+bounces-25190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A60B00953
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DD71CA2FB3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C76D2F0E28;
	Thu, 10 Jul 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BT97GnPT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6E2F0051
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166514; cv=none; b=FjZokwECMmFaIgS06m7d1nwnLUWFuj6UG2FNRil5gmfmdA9Z1bEDaqOtp0qlgLDnqLq5kZVhudJMu5iWVgrWryz0tAiZ4QZqkEZuwrxROVx0wK8yT2iFearnMM/iKSBr7rzx5jz+S5GEBxbx8sLSYfl9NNp2361w4hNx1Uii9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166514; c=relaxed/simple;
	bh=jfk9gvqh2Ms7ekcflGXuw/11k3Rr0QKqlQxlkLXVmys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4vKVY6gjrvg757E8yWAuf9aM8kG7cwyohErUo6X6V8u17xh/L2fl0e1rd5STDQd26/b87BQWND/Lrx/ycxSY+hO2k7hpilI/KFWx4wFfw4ZNPdqfksXLCCrJ2G7NwkWG/2YXktau8x3CunE6DX0OfYhvzMdrx+LLT6SF5cdZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BT97GnPT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166513; x=1783702513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfk9gvqh2Ms7ekcflGXuw/11k3Rr0QKqlQxlkLXVmys=;
  b=BT97GnPT4Z7nhOPZakF2hdTURlwm68tBDhM9uu9iR40cz6Ya1kbzcFWL
   bDX/UULSyBmWMmBZNJWmKJW92a+H+75tBFNb/XP5O9SlxCiA6Cvr1LPxP
   JqRv+IIqJkUZ7eKU4e4ZB850KEhk0vi0hRVTblmVcwZ3Mlsiik6Hz0/Oz
   qsmitw5U3Bsfk/lJpdtpENbjCjO/ITna9N66QgBikUSww3eDOqh172RZv
   jRQzm86/bWtlHaF8mPmI+ALhl8/dvfIcXyEFFWsYzQdQb59iFhPH7p2Wx
   HGIWZRtuNYS8WyRnfL33y6S2eWOJTMfuBUVFtI2seZk/eKpdF+TBwwKv4
   A==;
X-CSE-ConnectionGUID: Qgu2pfqkT0CyYwV4gH7qrg==
X-CSE-MsgGUID: f2vB6ZgfTjy8pqvMIv0Nag==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54609990"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54609990"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:13 -0700
X-CSE-ConnectionGUID: m259nzEAQUqwjBUlgnAazA==
X-CSE-MsgGUID: lUEAQMgCR6WbBtATqOjbZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156276999"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 03/15] wifi: iwlwifi: mld: update expected range response notification version
Date: Thu, 10 Jul 2025 19:54:36 +0300
Message-Id: <20250710195219.377d24e29ac6.I44119a4e793bba35b46e1d35e2c378ce6f901bfd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

The last version for the range response notification is 10.
Update the expected version accordingly.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/notif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index c0e62d46aba6..ff1a3b9079e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -350,7 +350,7 @@ CMD_VERSIONS(time_sync_confirm_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_cfm_notify))
 CMD_VERSIONS(omi_status_notif,
 	     CMD_VER_ENTRY(1, iwl_omi_send_status_notif))
-CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(9, iwl_tof_range_rsp_ntfy))
+CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
 
 DEFINE_SIMPLE_CANCELLATION(session_prot, iwl_session_prot_notif, mac_link_id)
 DEFINE_SIMPLE_CANCELLATION(tlc, iwl_tlc_update_notif, sta_id)
-- 
2.34.1


