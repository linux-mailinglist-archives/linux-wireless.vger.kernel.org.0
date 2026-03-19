Return-Path: <linux-wireless+bounces-33505-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEcKJ3tFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33505-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6CE2D1537
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C2F1302299F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951534CFB0;
	Thu, 19 Mar 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iACn4eph"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35034CFA8
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946165; cv=none; b=qeI2VBEfHVyGpIB5rMjBzZg4mdfis43NWvpwOyLNXxkfAutKAyyLUHEAh32jBtHhytWxJLLWa0PXdsVSID08Ui/0Tgm0qKQOwMh7sTpc01vMPyYOU2u59ikYZ0Ni8hlT5kLJWPuqNK6fdgKiPbc/lzPjfGvue0TQq9BaUDWfIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946165; c=relaxed/simple;
	bh=9m3CqOvKXi/r5YTaVfq7i1sL9KfhWp5Fv8+UDomvkYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQSJ/fAZYM9mSmje5OKhKMhg42wY+yJ4Vxl7QFAbtErCWq1hNjUuBOOm38xymJxIu77HOmAnk7WCnzLP1SxlGHi2jlKNpV4g/Wr0HDIeVCCeer+th7PFElby9D05Tj5fd0G6oObLS9Q/2ioyYOBrfFSRLNf4GK5lLzHjpfx85f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iACn4eph; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946165; x=1805482165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9m3CqOvKXi/r5YTaVfq7i1sL9KfhWp5Fv8+UDomvkYg=;
  b=iACn4ephRT0sioYF7TuXGwhNHWFtgOuek+WdJg5LdlDyKtVkDlwDoGiV
   5D2/ggKF72CYhgqPBvqDYAxYCFGRZ71ga7WLpDEiAM3urX99hv2qOM4e7
   +/cl2KNl3gv4ZJk3DkP/Vc+r2yQ3IOZXofulmgtjcC8sue9V5FIVIUf6e
   fXSZ3f43nsREduLJm+vb+rDRkMiZ9XxN40fPWD8Zh+LqDGCaHP/ESXrvP
   c0mmvh6zuf6Jcc3g96vS2ikn7jM6zjtqCXK9aiXAMYKWJQbDpY2panf7u
   j3OTTzvCnkWUICxla4Pw7WPElQ/ZhAbzGJCguKlA5W4I4XpJ/w/G9ZWeW
   w==;
X-CSE-ConnectionGUID: PmB/V5yHTrSHznODNKxqwA==
X-CSE-MsgGUID: KivCEamYR0WbRE0fLulfXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656489"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:24 -0700
X-CSE-ConnectionGUID: BTbuErlMSDOFBcQElSrWKg==
X-CSE-MsgGUID: abwb7jrcQTCMOrKYyMh8pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998564"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: acpi: add support for WGDS revision 4
Date: Thu, 19 Mar 2026 20:48:51 +0200
Message-Id: <20260319204647.721e9fbabfc9.Ie8bd641cf84aa659d93893438c172c172b67214b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
References: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33505-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD6CE2D1537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This adds support for UNII-9.
WGDS tables will now have 4 subbands.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 1c416d3f75ea..16d91c6915f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -812,6 +812,12 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 		u8 profiles;
 		u8 min_profiles;
 	} rev_data[] = {
+		{
+			.revisions = BIT(4),
+			.bands = ACPI_GEO_NUM_BANDS_REV4,
+			.profiles = ACPI_NUM_GEO_PROFILES_REV3,
+			.min_profiles = BIOS_GEO_MIN_PROFILE_NUM,
+		},
 		{
 			.revisions = BIT(3),
 			.bands = ACPI_GEO_NUM_BANDS_REV2,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 8e5ed72d4d8d..51a57e57de7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -66,6 +66,7 @@
 /* revision 0 and 1 are identical, except for the semantics in the FW */
 #define ACPI_GEO_NUM_BANDS_REV0		2
 #define ACPI_GEO_NUM_BANDS_REV2		3
+#define ACPI_GEO_NUM_BANDS_REV4		4
 
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
-- 
2.34.1


