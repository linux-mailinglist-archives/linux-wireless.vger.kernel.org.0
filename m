Return-Path: <linux-wireless+bounces-33509-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDpCH49FvGlTwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33509-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D622D1578
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92DBB3026067
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CC2F7478;
	Thu, 19 Mar 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAjU6ump"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE234CFA8
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946171; cv=none; b=Ch/2JlM382/4uP3uNaCtu9NoC5LnTGEcieACt3Lvt2ZWqdAO7xj9Y5quqG7KHmAA+SNKUHz8eVGuj3ElRWYZcGSZDFztYQhQa4eG44hwnL7H9Blm37KSEiatsBm3k95zBqFHPpV5l26n3DidlwKk5f2pfaClxMD0naBmGUELV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946171; c=relaxed/simple;
	bh=RzBnGsUc9jD4wf15DbqpPpbhpcK9Obcdmgbo9jDqmbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGlIPV7A1ghMExBH5eL5RRkoGt3K7wHMldvkdsl4dx5bcrcfiBzOxhaKTr2Cvcr1Xr2a4sd3lubi37tSA4g6LoP0osMk5yFuFE0luXR/MUuEyQczcIeTsN2n8a4wnErmYx419h+cQpJmggmLJSDfNsp8Iaplz10B+5GwbzZEiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAjU6ump; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946170; x=1805482170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RzBnGsUc9jD4wf15DbqpPpbhpcK9Obcdmgbo9jDqmbg=;
  b=YAjU6umpiDRG8W15MJ4/jM6b0tAf9P2eVRGHMTN7IXiZVAmin/kokFFv
   eqU4JN79mBMWZjwb4l9WTObEiuaUyy/r8h6RBMl+HZaomsDeUBfUe7sWb
   2tw3iUspftZWSnfl9fVSDXwdvuw5EQsVia2pEUgJRChBSAkVisXJql3Hh
   QZBAY8BZohddRTcZODOYBz/7M74rTZn3TAjhr1Di26RD+38nJngDKexz0
   YJw0m2blBSLcAMmhyWV4gm53zFNe2Y0kp2HK7Yv0Pzn3Q9pcR9Xj6kv27
   JLn77u+XHNi02lPzpVKV1PS+LH/cS277icyJtSUjPwpkrzM1PZUJK5qoh
   w==;
X-CSE-ConnectionGUID: t2KmdKUgRzi1xd/3xJPv3g==
X-CSE-MsgGUID: pQWFUr00Rzm8wLw08RmEeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656495"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656495"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:30 -0700
X-CSE-ConnectionGUID: NeAljGAsQCiqjd+7ZDB4Tg==
X-CSE-MsgGUID: Pm/xHjw3TEGwctypsscHkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998610"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: remove SCAN_TIMEOUT_MSEC
Date: Thu, 19 Mar 2026 20:48:55 +0200
Message-Id: <20260319204647.ea8d4a381474.I82c1d17faa6de6f16f08573ebb180de8db837bee@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33509-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: B8D622D1578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

It has no users

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 96cd970cceb4..17e0b13b5ce8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -47,8 +47,6 @@
 /* adaptive dwell number of APs override mask for social channels */
 #define IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS_BIT BIT(21)
 
-#define SCAN_TIMEOUT_MSEC (30000 * HZ)
-
 /* minimal number of 2GHz and 5GHz channels in the regular scan request */
 #define IWL_MLD_6GHZ_PASSIVE_SCAN_MIN_CHANS 4
 
-- 
2.34.1


