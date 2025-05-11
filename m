Return-Path: <linux-wireless+bounces-22844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98677AB29C7
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2771C3A42A2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFA256C7C;
	Sun, 11 May 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdgJseXs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4625D1F7
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982424; cv=none; b=tDb4JJJaToY2PomRyHRgfUoBJk7jOHjAlJcR9ZF+OgcVwrtPeoVnnFLoHYy+zRacQ2yhLVQ8VUlIjt+JjuoZFk7tRqkXUwqjskMLvYlkUM/MBtbZUQnuZlYETwUJ+JcaGKJVKrMGz55NydV55t0cuIVcpdXzNKU8gEaRDu+5sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982424; c=relaxed/simple;
	bh=z8PgtYNYiE+WubjN+UJbGqq9m8QqiyYsr5yM+TANT2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jpo/eXnhyUbTOx7Ew5wQb9S8Qk6MeOpVLlzeBaYIg3de2wYijeGT/szaNY0Fy28cx6X4XYdnuc0Qub1TqqxDs53Uh51QC9V4fdAoL8LH5IVNQ8RbT/H1UndTixU3PvXeRWgLSdEeiKU6aXq06RRZbdFECHBRsmM/cuD+tOyYP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdgJseXs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982423; x=1778518423;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=z8PgtYNYiE+WubjN+UJbGqq9m8QqiyYsr5yM+TANT2U=;
  b=PdgJseXsg+FO+xTy3th/kTM3R0We5SeKavcyKf23BGngG7s8UDofOFse
   KTfuMS8ZbOF25zGXEdDwTPvL74pVzjU1gA3YVSbmEYrjr4JoIktGoXnoD
   9j7SDP6uylAmEEEkKaWJoSXHHBy44TCjRj2bjBHHUj6Yqn/oDSkKqnXun
   aLUEp4Csd5/q6GF77pytpY/2nVpM1nsDYA9dvxQ2lHeDRwXRxykTzj1ZX
   RG7Es4gXhiUpzSRjpUjQaJHIu++2FyMoUoy2PSvsQgPiaTBWJYlkLs0Ow
   3/XPFzDopLmCsB+AuGPmVCip3HcHDkqgCyt+nxipTWs1oqN0H57d26M34
   w==;
X-CSE-ConnectionGUID: +juDxAoqTBimR2XJGllX6g==
X-CSE-MsgGUID: Isftk67cTSCWfNpVlgbpbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582685"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582685"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:42 -0700
X-CSE-ConnectionGUID: WJhtlBHcR/K37jDAkwFRIQ==
X-CSE-MsgGUID: /lwMDN8HSCmXmPgGtBJQ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655036"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: stop supporting TX_CMD_API_S_VER_8
Date: Sun, 11 May 2025 19:53:11 +0300
Message-Id: <20250511195137.9f17dfef16e4.I0ffe242f3a0021d17b24b8a21d242ed74d6c2ad5x-iwlwifi-stack-dev: aa4b6a34411a1d0df217c33faa26c992c31ebaf2@changeid>
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

This version is not used on any device. Don't support it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 0b59fabde7f0..67355ac243c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -298,8 +298,7 @@ struct iwl_tx_cmd_gen3 {
 	__le32 rate_n_flags;
 	u8 reserved[8];
 	struct ieee80211_hdr hdr[];
-} __packed; /* TX_CMD_API_S_VER_8,
-	     * TX_CMD_API_S_VER_10,
+} __packed; /* TX_CMD_API_S_VER_10,
 	     * TX_CMD_API_S_VER_11
 	     */
 
-- 
2.34.1


