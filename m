Return-Path: <linux-wireless+bounces-22330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A35AA7196
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9324F16BBF3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28580254AF8;
	Fri,  2 May 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHKyNhO+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B6248F46
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188452; cv=none; b=fYEv5XpKfkabRlxT6VnKuCQ+SowY+r1qiXY4Honb0biQuYBjiRY5BEYtf74WNBgytxvpDnrVYBb2ngkCW26NFPEqSBWwzpcHq28Kw90+vSSFElMOneJXKs4IehTAggtHGpSt5ldBZTKsYXW/Urp9Q0m5i4SwWxq1uR6rz1YeAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188452; c=relaxed/simple;
	bh=kVbWEmFUQdAf9SnCHmHJD4jfiuixmClaHEq3cqAZ71Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPacVF4YjUodNQFM+XmUmIySkDzin1oJ1mHaoCb60TjRU2ghTtInZ9yjnkRuLzQw/H3vka2nkv66zKH9DojWvXh0IDkytVGbNRXOIR1WINW0QfspeLIDgs72M0m7GKenkFEL8+otRU+POmsxh/vs9zJ7/1DEUoBKdvTB6SKkZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHKyNhO+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188450; x=1777724450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kVbWEmFUQdAf9SnCHmHJD4jfiuixmClaHEq3cqAZ71Y=;
  b=gHKyNhO+A5r8mlSsuJ4sCs7QXXnVnQHJcimPvzhvArYbEHApaHIvSvC/
   22ZSkKwnOk0ameGyvPCq0hYd8xiF//GAml4kjMoNLTxuHT2nEKZX9NOgr
   SQcdbrpduEnMtvAOkkGexmgBcR/WZjl+8qWWL/jySLyoJD5+R3ykOyfnj
   6awmSU5O3cJ4AM9knhBDlHkajReF9DbHmMYYZ871CpG61cNIPV3Dryrx0
   A9OmB4jWAiADU+HOSoABuH4HMUZbGmd1EjI30Ui8H+6LP0T4GnYctRLCg
   psxtNlOiAUTVpSgw+t2iHx4ywswEztD5c1gbCNq19wEoFL8xTgu/lAU9Z
   g==;
X-CSE-ConnectionGUID: rhtCb3lGR/+HZdZJiaNxvg==
X-CSE-MsgGUID: cUwaAog0TUyCM0MVySihoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010355"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010355"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:50 -0700
X-CSE-ConnectionGUID: p5W7lXY7R9aacEgxUM4SCg==
X-CSE-MsgGUID: JyCNr259SRyio22PuaLVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586110"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 04/15] wifi: iwlwifi: remove duplicated line
Date: Fri,  2 May 2025 15:20:19 +0300
Message-Id: <20250502151751.a2601e0a08e0.Ie72fadec40e41b8197bfdae16eaa430c64a3e62d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This line was duplicated by mistake, remove one occurrence.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a14488f03f92..daf04ae2f9a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -658,8 +658,6 @@ extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 #if IS_ENABLED(CONFIG_IWLMLD)
 extern const struct iwl_ht_params iwl_bz_ht_params;
 
-extern const struct iwl_ht_params iwl_bz_ht_params;
-
 extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_gl;
 
-- 
2.34.1


