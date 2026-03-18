Return-Path: <linux-wireless+bounces-33428-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELXtGlgRu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33428-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:55:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FB2C2BDB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A32C3175C23
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A541371D0D;
	Wed, 18 Mar 2026 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTMsKjG7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC7371CE5
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867290; cv=none; b=kai+zbrZENS13fGDlER7GjgXYIpXc8SYeckbPdlJy9+X/m1sYHZbjeqiMHc3M3YwfXjPxBRrWuBT4YPEg5dAPrN6Z3VSn3UtTI/YricUHJqph70Sib96HMVsTkXZ/K6kaJzqextx9vgVOn+KewevuMWBcZsVQ+nCMB1u4svyvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867290; c=relaxed/simple;
	bh=FpaK6iPluKBOZiOVnxYhnL/D/ZzfJGw8FkdKLSlKb38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYFE/EwxHaNHp0COdtQNJ8MoJNKtrZXy0nQfFE3+mVdDUJAZIr23Od3/ARup0AAudfKFX1jNcFk68eiaCBb4XgKcE1c3cBTok6MeDTpVtkcCHPDm5sRLiSrMOFYrv8cqkzLa7wNLwhkvvwkbadz9Gaen3cnZsyongZz9SZtSlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTMsKjG7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867288; x=1805403288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpaK6iPluKBOZiOVnxYhnL/D/ZzfJGw8FkdKLSlKb38=;
  b=CTMsKjG7deYc06wTTuMir1TLVIqjCtiZrniYXtuW3u2SSCcY3GwvAlTs
   s6QneBE8eQvVEJqWiVBaiIJ1qAEFJ/dac82l62ZZ4dmYmFXXcW8BozURt
   p4udfTZovCNWQ7v2rr1afmh77LKlCohrx6NxSkbbN2TCpDhDL98I/4RZs
   5kID+qR2QW0VtytwfxlUOAxfIUVsBnPr2Fhy9V1wMBP32e5rRpoV71ozx
   /hdDSbCA9tdMWnxv7dRkvA5JTy1I+cCP6kBI4QbVqKUOBjo0tP1hLb7To
   WOQUz6eSwaHzxbHTuKaW/Ks5/ENfDgRnQGuB/o2xPTl1DOB7O+XfUc0bZ
   Q==;
X-CSE-ConnectionGUID: dQNp9C15RUKZ7FczMh6j4g==
X-CSE-MsgGUID: uw1JGEc1RgKnuq29ION9gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010012"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:47 -0700
X-CSE-ConnectionGUID: 6/LA+L3TS56j6jVNMLW0NQ==
X-CSE-MsgGUID: ZtoAhftgQS68IoQB6HnoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793868"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: acpi: better use ARRAY_SIZE than a define
Date: Wed, 18 Mar 2026 22:54:19 +0200
Message-Id: <20260318225236.1acfc3b6f2b8.I2185e7850146e15628f8ec2c579d93f536c83d83@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
References: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
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
	TAGGED_FROM(0.00)[bounces-33428-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE5FB2C2BDB
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


