Return-Path: <linux-wireless+bounces-37198-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNDwIDcTHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37198-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2044615A8F
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E68D3038F71
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2952376BD5;
	Sun, 31 May 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D18M2Sc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DC376A10
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224807; cv=none; b=skClvpuq4yR3FAogygg1sr7TIrYJ7XTVdWYlU2vjP3KxTUamxYKya1go37Zzjj+yTeZzlxQPUuJGpmY7kHCVYyBFdYs2FdxP4XmpY1YHofe9SOc5RmoCd1E4FU7PE9HDDoTO/cUeKBa/2zYt94yC2qV8Ultd2YnCGYcxJhqqqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224807; c=relaxed/simple;
	bh=JgBDtaq6kBKvgNwbZw0sunSG10mhCCRURpUWVfwc6CE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAfxLBI9yXWwavfdYgVfdPaQGt494X/Dc8FXfFUBDG0vf+IkfFohEwvDZW31xFLQVdpQbglADA8zSIFHL3DAlbZnr4o8Q5m7mEkBCpjonDijFHlyhGPoKAG7Tx+d28w3I8Fg5F5rK5OrOolvrM10GvghFJ4VDIHyQeGE1TW9bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D18M2Sc1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224806; x=1811760806;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JgBDtaq6kBKvgNwbZw0sunSG10mhCCRURpUWVfwc6CE=;
  b=D18M2Sc10OncKpfqYawhMdwkT7uTxV0IN1IRqt+qdUl372ikeCYHamN7
   sW2OD7oV+ZNkJmjFfKgliDj+sS+ISQbqsGq8U+UZxLJJKr+AsxpaHEcNu
   DGsQQROPfdfaZhAZNgjoUJc5cglgXcIjuzEd7M9fA4nQpPb2gQrvjkXWG
   sSSjsxGlk5x3qEytE9vrAvKJLmngukCcBM+5GdJLgbdWJTdRYeCnM4dA3
   2UT0zsXg/pqrUwP/KepLauXZnxP1lyWhg7Dc/D1ewu6HT5oT3tYs5v9gf
   wUZ2ob2giqtfEMOHNSLyC5aniIwez4owEN03OWgPbFLqvuLPCFCuKq5pC
   Q==;
X-CSE-ConnectionGUID: unBXtP+7S0m01v7rd7iSXg==
X-CSE-MsgGUID: uNPWIBmNQ/CXwP2FCB+fFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039663"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039663"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:26 -0700
X-CSE-ConnectionGUID: mEJmSjJrQYW2PeIHp562XQ==
X-CSE-MsgGUID: XvXJbcguSG+BUve8+AtMSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240295991"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 02/10] wifi: iwlwifi: fix a typo
Date: Sun, 31 May 2026 13:53:01 +0300
Message-Id: <20260531135036.62a394741a04.I2fd9e1d5dc4d467426c9061df2796ff8ba0129d4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
References: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37198-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F2044615A8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We use 512 A-MSDUs in an A-MPDU, not 612. Fix the typo.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 933a96131d1a..6a3539ad7331 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -372,7 +372,7 @@ struct iwl_mac_cfg {
 };
 
 /*
- * These sizes were picked according to 8 MSDUs inside 64/256/612 A-MSDUs
+ * These sizes were picked according to 8 MSDUs inside 64/256/512 A-MSDUs
  * in an A-MPDU, with additional overhead to account for processing time.
  * They will be doubled for MACs starting from So/Ty that don't support
  * putting multiple frames into a single buffer.
-- 
2.34.1


