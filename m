Return-Path: <linux-wireless+bounces-36299-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG+5ImC8AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36299-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:36:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EACBE51A2BE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C41DC3059E0C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB83803C3;
	Tue, 12 May 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZwPQc0F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153D37267B
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563412; cv=none; b=a1Yc1XFkYqpPwFVEpQUTuXDsc2aeyWVoke0ij9fu+ph2qYy/7lFDwPSrp6PmZoIOrv4/eO03rpRCe6N3baCFGEou3IkWv2ZDjxB8uRSR0cCx7YthmNk0252aOOPVfl+COGJI6EpitL84e0HXABEQiRYQdNSz9G9t4QNYS7bf0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563412; c=relaxed/simple;
	bh=p/9AskBHo+fkyErQKHlpGmMaB6BguSOHEua6u9wyQnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYi2g8O9f8MWn7g8H337IjnyL+lYQUnQee/m+DynJGNft6FTKLS4q3auqP06dspvKIfNxQWgvA81tuU424SzCJ8qQoFXdc1Xjw9Bw2pMaqb+z0AgupS78g+wq7A7rLBcD43U3teRj1X881hQ2zdin/5zfoSsbc0nx87V20OwH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZwPQc0F; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563411; x=1810099411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/9AskBHo+fkyErQKHlpGmMaB6BguSOHEua6u9wyQnE=;
  b=LZwPQc0Fy5xkAhwn6+aAD+QEpzrIsO6aRTP9xchVOXFXEGAaxENXn6UG
   2GNbKxyXOGToP7wP0wUBt7Y+dAgdowdZkgwViQu7vu9656qMy1vqFSOhr
   EGrylgzNlXyDvTSbNkeRRuBFW5epPVk8LClrnuXn9AYxRkqcey1mMCAoe
   rbFrfMuVng1Az9wlCu7XxU/pKean2dNm4MIB51O2wREl1gkfgLTkxBl4g
   NHkkl+fRWyfnVv5HDwnRKLJ9w4FmKqolG+sncffLf0ywPjnbKq2PFrPsj
   buUDsu0Etqt9IdZDfkpLQCfXliyrlNeE++SFqbG2rwAAAe66UwE+uDeJ5
   A==;
X-CSE-ConnectionGUID: P+/VIGN6RDmMZOlea2TcPw==
X-CSE-MsgGUID: 21Qln++cTTWmBGeby181yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495096"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495096"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:30 -0700
X-CSE-ConnectionGUID: NFtajDi6QRuTtAwGbcBUSQ==
X-CSE-MsgGUID: 3TrCwj7yQf2PwumwNnuK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187563"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: print FSEQ sha1 in addition to version
Date: Tue, 12 May 2026 08:23:00 +0300
Message-Id: <20260512082114.7239e0b90611.I2a833b0354c5512189e74d3a296c55546444a360@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EACBE51A2BE
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36299-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The version isn't all that useful, however the sha1 will
identify the exact source. Print that as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d5ded4d3a30b..83a63be90e46 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1294,8 +1294,9 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_DEBUG_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
-				       fseq_ver->version);
+			IWL_DEBUG_INFO(drv,
+				       "TLV_FW_FSEQ_VERSION: %.32s (sha1: %.20s)\n",
+				       fseq_ver->version, fseq_ver->sha1);
 			}
 			break;
 		case IWL_UCODE_TLV_FW_NUM_STATIONS:
-- 
2.34.1


