Return-Path: <linux-wireless+bounces-36328-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIFaFTGBA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36328-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD1528B32
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A4C30B1E69
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4576B3655F8;
	Tue, 12 May 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPvz7cY9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB535979
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614498; cv=none; b=s5JDxiF33e3+QRkxiUSCkvuDZgK7gTYyU23ApDk01jabMa4TJrZesdGZg+OLPeQeN79RPIYj5K7r1aJyfGRbR1L0NXYy5yAffiVuXbmxCEODyFXFWAfcOZlOVkbNKWBSc1PqRO2jNn9fHUxDHjdXf/5aFl3c/Ktu9Zp+e6+Ruq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614498; c=relaxed/simple;
	bh=ZM3FqMCkHb6v04wPiomfyAPeAmXl2ltHrV16og2JqHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGLoNwQBe0UF7DI8j4jsYwtMAbGBDDEcXp7FW4AZkllai8h6iqaW5GBoG/wxM9HlwHmyzX+eWGY/emdetmrDITLBQG520Xj+FBoKvnh7tUZqDgJbmYdqQcPs5n0b1SVvri/A9PFuUn714wUSOybRiHYoY8AkNaETw4q6RbilmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPvz7cY9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614496; x=1810150496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZM3FqMCkHb6v04wPiomfyAPeAmXl2ltHrV16og2JqHo=;
  b=IPvz7cY94IAW3+GuP5HpXRCVr5Eox98SXlVr4DchN0o2+FOhx0/hktvv
   c21PvwHpyBaLKI/W69bX47Cg4P/edAOizfi0bdl0O5+uwDpdk2fSE6Wss
   G6BpyqiXpLR4nYol4lZaLjsQ+YalN4VSfHIW44YEsoyFU6now505iOPzA
   LoNnL1SWVgXVDGhPNzPAqlrLxX6oxQj5r5FO1VKDaUX9luG6vLWUhENiE
   HF8g1EVLEMftinuwjjp/2mrvARslrSYuO0wtBVw4Fx1v+Zg4CyWS1U4WU
   Z7mNg0gmspFi8lyl7KgzdroyLWPxsKMCp2hCdznLrd6IOpcLcKxJteIrC
   w==;
X-CSE-ConnectionGUID: dNT8b42XQI+5g0CLQ3k/lA==
X-CSE-MsgGUID: oLvfMq6cTgqmATV3jMp5Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148767"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148767"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:56 -0700
X-CSE-ConnectionGUID: mLaU9wslSfqubOfBGljRYg==
X-CSE-MsgGUID: a0EGihhzTQOH0bUQ3ZDs7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471651"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Aaron Katzin <aaron.katzin@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: pcie: add debug print for resume flow if powered off
Date: Tue, 12 May 2026 22:34:27 +0300
Message-Id: <20260512222731.42623e43fde7.Ibcd656ca845828ce6f2358f9ef80e1ddf03f8f59@changeid>
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
X-Rspamd-Queue-Id: D1AD1528B32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36328-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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

From: Aaron Katzin <aaron.katzin@intel.com>

Log when the resume flow identifies based on the
scratch register that the device was powered off.

Signed-off-by: Aaron Katzin <aaron.katzin@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e0be899b8fca..58a7ae33c3ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1240,8 +1240,12 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 		u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
 
 		if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
-		    scratch == ~0U)
+		    scratch == ~0U) {
 			device_was_powered_off = true;
+			IWL_DEBUG_WOWLAN(trans,
+					 "Scratch 0x%08x indicates device was powered off\n",
+					 scratch);
+		}
 	} else {
 		/*
 		 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
-- 
2.34.1


