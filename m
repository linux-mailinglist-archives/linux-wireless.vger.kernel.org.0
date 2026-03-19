Return-Path: <linux-wireless+bounces-33467-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKFRJi3Au2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33467-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:21:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F14B32C8855
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43AEE32BCC9A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC93BA242;
	Thu, 19 Mar 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcI5jYMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE43B8D7B
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911388; cv=none; b=VUoS+Em9Xp37FZ6k438wUezHJ+Jf43XwuVEYHglJRVxxSLModvqDW3nf9/cXvA5sS+yxRDakcA41XiqFbaPVZ1Nu3ASMEtapwU+Txu7a3sOPbiF74kQJixJ4hjdH6XwPKlVHGmL/hrTKXSDMPAGIcQs3nGcbeaAtVLC5ON7ZSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911388; c=relaxed/simple;
	bh=FpaK6iPluKBOZiOVnxYhnL/D/ZzfJGw8FkdKLSlKb38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqXN4lLC4QxP7P53wj1lb/XkZLXMAXO3M1DusA5N6BAii7uka08tuJaelWVCRqZb8IZyT+FD5eLKqYd5vUaPSM7VfgI/f8pseqBBU8l2hXjTsfd4+P/TvgwY2E0bDP+nHRy+je5AyDNwQxnMAXW7wA1aqfjNk0YllEZNUR45eTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcI5jYMI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911386; x=1805447386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpaK6iPluKBOZiOVnxYhnL/D/ZzfJGw8FkdKLSlKb38=;
  b=IcI5jYMIEzz3FSjuSBw6BBNiH5wwZwrEjBNiM6nBbtlVpSl07PH8gL/T
   stWBikJc8qR3Mwjmwz1PQLuZs02FIefO56FO0jBE7gYLhQHHlnkkpFWyS
   T5fm2Wf4gFj/Qetbj2UocnFhD0gdlxDhiw+J5yDm2lC0XMC4AO3Ko4NVg
   RMpH7uGk6Lv6INPt9439eUvgke56ikZjdsCvtL5UcckIoS8iNmKNs7Bdc
   Nu6F3D8F3e7wXHuNAIFp6I9DSmfnozUXy2sqI50Sbi0wM7MLcBHa53WKU
   YV5WfTK/lOgq0cvPtSA3p0D8LJXjH18Ipn6MYjf9Loj7cCkXw+QYVAq74
   g==;
X-CSE-ConnectionGUID: +imxoFy8S6O7DzBS8e6tew==
X-CSE-MsgGUID: T0SOIXyWRS6JaZfwlI4mZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992704"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:44 -0700
X-CSE-ConnectionGUID: Qlcoj4+mQR2++uJ+rPFOlA==
X-CSE-MsgGUID: Orf2sRU8RSe2cGW78B5iiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387127"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 04/15] wifi: iwlwifi: acpi: better use ARRAY_SIZE than a define
Date: Thu, 19 Mar 2026 11:09:16 +0200
Message-Id: <20260319110722.1acfc3b6f2b8.I2185e7850146e15628f8ec2c579d93f536c83d83@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33467-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: F14B32C8855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Since we'll have to change things in this area, use the safer option to
define the size of an array.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index de9aef0d924c..b64abb8439b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -504,7 +504,8 @@ iwl_acpi_parse_chains_table(union acpi_object *table,
 			    u8 num_chains, u8 num_sub_bands)
 {
 	for (u8 chain = 0; chain < num_chains; chain++) {
-		for (u8 subband = 0; subband < BIOS_SAR_MAX_SUB_BANDS_NUM;
+		for (u8 subband = 0;
+		     subband < ARRAY_SIZE(chains[chain].subbands);
 		     subband++) {
 			/* if we don't have the values, use the default */
 			if (subband >= num_sub_bands) {
-- 
2.34.1


