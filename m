Return-Path: <linux-wireless+bounces-28782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD3C46C05
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98F85347E92
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B8311C19;
	Mon, 10 Nov 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmywslJ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC930FC29
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779775; cv=none; b=FaScRScKFgVOxWS8GZXIwAucl66bSbeEVsmtnazvKBZsu2yIZgwSgZgQskmzfSmdYpJGAfxUnvV84U36SGfRh5k3T/JGmPcnfIYWoGPWWQ53NzffnJfWNbWDMmGZnMHDWiqHHvWNwmKfmhkyD8YuPIbs8jvRv+AFFDQC0y1h2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779775; c=relaxed/simple;
	bh=E6JMFOc5YGGVbDAzdMmctc4sjrdfrnD7D7V9spGSJcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEn1uB0m8DtEz6fg1zTRuP6Yur7FURniJgOzojRv9Y/clak0pyh5pGISgWS+MJp3Ag/4bxxXeaLUikELPtNKstAYT6jU7gvy/Tb1modAnMmOwZb6RXHaTmGuCsUjzKnWN17sshlBnFOzzXy4iNEv7FFGYO8tZZWy3l+LNjQrUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmywslJ4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779774; x=1794315774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E6JMFOc5YGGVbDAzdMmctc4sjrdfrnD7D7V9spGSJcA=;
  b=RmywslJ4bzaHlsXVaunJwZjvWYMJWjyv8PixADyPv0ENyonFDQIEvaeL
   7mnxwXWCDSgrTxt4Z5W5qCkJ9P3dN9KKucIvTKdhAO8uyAeMbMrqwjznr
   6mWdv0WVAjizWmzltyvjdTV5XgxSDRDKzwI62YiSR/PgmgW8Oo37Qs8lb
   HVGPDPnte8eqiWZSy+bc87GpYL9NEVgscCzkQRrKYJIV2LSNUtsvrDuoP
   17wDQBIE46jvLTe5Wj6oy1s4E9Itrfh9WH9xam2NBx/dceb/vZGGy4PO4
   xafHOa5FEGfDu5jAgbZia60hqJmWdLaUNH3obLDdkSCM8e2aQAuxrbR+C
   A==;
X-CSE-ConnectionGUID: fm+Bc803Qr2CziM56oTt+w==
X-CSE-MsgGUID: LXW2mcatQJWNMM5A628AdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454899"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454899"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:54 -0800
X-CSE-ConnectionGUID: p4jZHpt5QO6jmQ7hX9k1bQ==
X-CSE-MsgGUID: NgLLgYbrSUeBqh8xrSBdAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928578"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: fw: api: add HE type for UHR ELR
Date: Mon, 10 Nov 2025 15:02:26 +0200
Message-Id: <20251110150012.3dabe4690805.I93dfb6b41ace7844e462e8649253c20f2712b382@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For UHR ELR, the EXT_SU type is reused, so it depends on the
modulation. Add a define so the code will be clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index e073e1963742..ae6be3ed32f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -740,10 +740,11 @@ enum {
 #define RATE_MCS_HE_SU_4_LTF		3
 #define RATE_MCS_HE_SU_4_LTF_08_GI	4
 
-/* Bit 24-23: HE type. (0) SU, (1) SU_EXT, (2) MU, (3) trigger based */
+/* Bit 24-23: HE type. (0) SU, (1) HE SU_EXT/UHR ELR, (2) MU, (3) trigger based */
 #define RATE_MCS_HE_TYPE_POS		23
 #define RATE_MCS_HE_TYPE_SU		(0 << RATE_MCS_HE_TYPE_POS)
 #define RATE_MCS_HE_TYPE_EXT_SU		(1 << RATE_MCS_HE_TYPE_POS)
+#define RATE_MCS_HE_TYPE_UHR_ELR	(1 << RATE_MCS_HE_TYPE_POS)
 #define RATE_MCS_HE_TYPE_MU		(2 << RATE_MCS_HE_TYPE_POS)
 #define RATE_MCS_HE_TYPE_TRIG		(3 << RATE_MCS_HE_TYPE_POS)
 #define RATE_MCS_HE_TYPE_MSK		(3 << RATE_MCS_HE_TYPE_POS)
-- 
2.34.1


