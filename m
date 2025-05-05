Return-Path: <linux-wireless+bounces-22465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23926AA9C11
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E19C3BEEFE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5926F44E;
	Mon,  5 May 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEpm+M3N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF21FBC91
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471433; cv=none; b=Pv5BlIaYBzw6uPsd7pYjgeos2U4YOw63W+zPWycBG2ewcw8XkCn4Y15IqCSBPy0ALfATlupe46g7N6m568gV0yo/ezD+ncnaZpQNw0m52ZjPXcdvGfXEHYcx81Co9HmoqdVl6MvbS8FIjgjTq4QIuuVP0evIRzscLdzFXLJylIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471433; c=relaxed/simple;
	bh=eMNGbe1utxfnVxzf4JoGk6+U31qZJwtcOCmi8UyDmP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqZDEFnTWVoT+oTDjbxe7lOxMuVaKQTl4AMjZuNFVIFlEppsn8agtMI0jmOD8iYpwQrB3pnJSpAtDDEnFAZvIKeZOPrLIZaiRgiNwVc39fvRozcJczpptog/30PCPt0AIAZNHElnJ+RR2f/aZ6Rh+aPsJvjcipUyntPRwJlqV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEpm+M3N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471432; x=1778007432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eMNGbe1utxfnVxzf4JoGk6+U31qZJwtcOCmi8UyDmP4=;
  b=fEpm+M3NunlRo7qmOoVruj4c/15lynq+UyX7sTMWhUG8Tlr8UAR+JKay
   qPGVcnjn4WQy/JU8evHz69cgIcWbYsyQANaFAYG9t2NctlErf2pgYHLXB
   6xsgHSR+yeOUl4BCtshgLpoAMeTfGYUg+xGJwrpfmZphIWTbyI5kpqKnB
   0UwGHBCgXKC+5PYbNtn/4TVlZSTiwQKqGbl3tm0TbWYJ480YmjmgX+Yci
   45fs5N7T7mZQRfigrmMYY/9c/V78wlR4FhbRm5YlpisVIIrJxpf9sD+yA
   i4xJhvwY8O2Li3Q5WVDJSXoo7krEbtmpJPYzjmDKekRpUxtKdnO3Zn3bG
   g==;
X-CSE-ConnectionGUID: 7yoDro34ShaXyHO9hPyVpA==
X-CSE-MsgGUID: ZirCrdbETOi92CSh5UEzZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359436"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359436"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:11 -0700
X-CSE-ConnectionGUID: j+UYUW8WTjK92JVCyMCrYA==
X-CSE-MsgGUID: 2fQIYuxgSzuRtvwiEOeifQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697910"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: print the DSM value when read from UEFI
Date: Mon,  5 May 2025 21:56:41 +0300
Message-Id: <20250505215512.f419c18c064e.I870a4537a4bfa3c54b03ec7ec29bb246e6aa75cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We have such a print for ACPI, add one for UEFI.
This is needed for testing

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index d49bf3c34f95..ce17424f3a60 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -753,6 +753,10 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 	}
 
 	*value = data->functions[func];
+
+	IWL_DEBUG_RADIO(fwrt,
+			"UEFI: DSM func=%d: value=%d\n", func, *value);
+
 	ret = 0;
 out:
 	kfree(data);
-- 
2.34.1


