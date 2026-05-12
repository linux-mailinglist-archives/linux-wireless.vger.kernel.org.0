Return-Path: <linux-wireless+bounces-36330-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOkjJz+BA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36330-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452F528B4E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7CF830DD5FF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C02935979;
	Tue, 12 May 2026 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSl60kre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450953655EB
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614499; cv=none; b=E8UCmwqoUZjxfoD+n2deHMnp7P0gkimVe3cpoZq7koxwLqL9KwYTfs3VEDglPRaan/9WmuqWG+r+GRQ22yVYeWc7mgoBfG0vrWItvIFxFrvWjvEnLDDrq79rHehpmJGspNp9hoI24W/MbM+af1eyKiaBXiOKlAZc1MTPNQVxIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614499; c=relaxed/simple;
	bh=OYYUKP6pc8qZtQtBFCNC0dHepaOLPxI9/iwpyrp9rTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dk718rFt3KS/D1sDL/WZG0aGR1tGheX9KaYOo4GvTgXfdgVkZFh2w3ezWT8rmt+s2qJzH+VBx8mja/Ed0fLEaGM8x/ybsUwrQgbhrU/yRpRmcS/eXHTV4RsrRFb4ZZ/+0DaA5ZoBxL6tgVps59QUAZKR6BSx+9i6JfJwFEpaaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSl60kre; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614498; x=1810150498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OYYUKP6pc8qZtQtBFCNC0dHepaOLPxI9/iwpyrp9rTU=;
  b=ZSl60krefF4zgPmQR6zBrI7oJi7A9nJN70JcHMNw70mR7CUGDhD7iU/y
   D2dnVMin1/i1k+o6S7sS00thXRVsTFRDr/LvEm9dxROsp1jDd8gVa/87y
   ZHMkCU5Iv/wXlMNG/pJvPbVGtgPH6xhE3RV7KyzHS98/P6RtNR69Rk5X2
   Gt2bImCYnxl2VU6/LxwxnUgKCoIYetaeBYbooisjdMzZpXQe24aVZn4rQ
   haUW4qtjKKZEUM8KVg9uuf6QeNLRwopUwIgL7uzyxJYNHUkNYM6mcqI94
   UAAj2qkuaywOx+/zFaAKt47k9gZgSvQ539GN7nteITT4HwY7qTxDVe1Cj
   w==;
X-CSE-ConnectionGUID: T2mYzOvySPWoeVxaC7xyZg==
X-CSE-MsgGUID: phoUp3HQTvCwVD6x2W+iSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148772"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148772"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:58 -0700
X-CSE-ConnectionGUID: yWzM0RaRTlKdP1swf+Qj1A==
X-CSE-MsgGUID: KJTBZW6GTaWjs00lo46yfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471690"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: define new FSEQ TLV with MAC ID
Date: Tue, 12 May 2026 22:34:29 +0300
Message-Id: <20260512222731.f31ffbff36b0.I227e5c94d4da79a32058d71539b190384caba03e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0452F528B4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36330-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Some firmware files can be used for different MACs, for example
for sc2/sc2f, yet might have different FSEQ versions. The files
will then contain multiple bigger FSEQ TLVs indicating the MAC
ID in addition to the version.

For now, since we don't parse this, define only the new format.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 68ddd99a9f7d..197c88c25f72 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -1064,10 +1064,15 @@ struct iwl_fw_dump_exclude {
 	__le32 addr, size;
 };
 
-struct iwl_fw_fseq_bin_version {
+struct iwl_fw_fseq_bin_version_v1 {
 	__le32 major, minor;
 }; /* FW_TLV_FSEQ_BIN_VERSION_S */
 
+struct iwl_fw_fseq_bin_version {
+	/* rf_id is currently unused and always zero */
+	__le32 mac_id, rf_id, major, minor;
+}; /* FW_TLV_FSEQ_BIN_VERSION_S */
+
 static inline size_t _iwl_tlv_array_len(const struct iwl_ucode_tlv *tlv,
 					size_t fixed_size, size_t var_size)
 {
-- 
2.34.1


