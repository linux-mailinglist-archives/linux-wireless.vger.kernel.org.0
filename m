Return-Path: <linux-wireless+bounces-31771-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBbeMP7MjWn87AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31771-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:52:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015812D937
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4A7E300E59E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954435B135;
	Thu, 12 Feb 2026 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRk/Lspw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F522F39DE;
	Thu, 12 Feb 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900718; cv=none; b=oMN4P2Ej0MDAJBmKfLBXgvM8a7DGY3TU3AITiPfVfI5ZQdZZt4WvJWnntm1R0kCnAGpsPEnAMzyuUPqmSzPgezpPgnzD4q2MI2X0rHKPnFwFQGcoEpbZZ7ln2/zQPkh4mtq0uZBokaKgDxmRHecbJwVRX8qwVL4k0mCh9ZfZW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900718; c=relaxed/simple;
	bh=5PADlxX/i4hi1VtzVuL+/fMGXH/GtoU6RGW/xNTvkbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3BcmMCpxB+0U87MEZCbefClSoQFgoF/mS1XjJJgE4XR/gRSsKI3sl0N/CFLc3Joll1LoHkQCKqAF8bbmwQEyp3x4bKslEfn2LuutNNg4vQDOazTXxJF7833Qe+BPTNK22JKnYlbJ0pDfYiGmtjAcku+XMu+HzBgayHzY9votSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRk/Lspw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770900717; x=1802436717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5PADlxX/i4hi1VtzVuL+/fMGXH/GtoU6RGW/xNTvkbA=;
  b=WRk/Lspw69jjWmZeFYk3mPiJQnxRNtvbkXRVsIHml0Spp6waSpdGO6RY
   9818mhxeXGdUygfwUfAaLAF/0lQye0TxPZXRHzpizjl6RBXJAJx8X3Ro+
   vveeHR3jWE2M9+n4sD7jXjzmaJqE/6JzWDtx+8tX8UJo7xNQfik2F55Sm
   QxHgRsCrlhkWxhdMD37w0pvIbBKnNBSAaGypTj6pfGag+d8I0pDXl16lM
   bXTY4Jo1NYvGdhV9XlFgx1KYJ8XlT4yHEo87rF1oVaDbEsH0pKl0Phiyi
   IInDoVLYccZFu0oBCKXviLHEerFY/alCf8dvePZ9y/QF3vB/hVIdjDh4g
   Q==;
X-CSE-ConnectionGUID: jWV3RxjNSXq1wNGycJiFvQ==
X-CSE-MsgGUID: 0Hks4yIwQ/CIfpU5vAif8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72254028"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="72254028"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 04:51:51 -0800
X-CSE-ConnectionGUID: g7rFGx85TkSh4eFZ3STacg==
X-CSE-MsgGUID: TdTu/8/vS1CpLsgXK5HHPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="217553359"
Received: from b580.bj.intel.com ([10.238.152.74])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 04:51:48 -0800
From: Junjie Cao <junjie.cao@intel.com>
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	richardcochran@gmail.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yedidya.ben.shimol@intel.com,
	avraham.stern@intel.com,
	daniel.gabay@intel.com,
	krishnanand.prabhu@intel.com,
	luciano.coelho@intel.com,
	gregory.greenman@intel.com,
	stable@vger.kernel.org,
	Junjie Cao <junjie.cao@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH v2 2/2] wifi: iwlwifi: mld: fix race condition in PTP removal
Date: Thu, 12 Feb 2026 20:50:35 +0800
Message-ID: <20260212125035.1345718-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260212125035.1345718-1-junjie.cao@intel.com>
References: <DM3PPF63A6024A9E1EF4081E342AF4BED81A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <20260212125035.1345718-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31771-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 6015812D937
X-Rspamd-Action: no action

iwl_mld_ptp_remove() calls cancel_delayed_work_sync() only after
ptp_clock_unregister() and clearing ptp_data state (ptp_clock,
last_gp2, wrap_counter).

This creates a race where the delayed work iwl_mld_ptp_work() can
execute between ptp_clock_unregister() and cancel_delayed_work_sync(),
observing partially cleared PTP state.

Move cancel_delayed_work_sync() before ptp_clock_unregister() to
ensure the delayed work is fully stopped before any PTP cleanup
begins.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index 231920425c06..b40182320801 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -319,10 +319,10 @@ void iwl_mld_ptp_remove(struct iwl_mld *mld)
 			       mld->ptp_data.ptp_clock_info.name,
 			       ptp_clock_index(mld->ptp_data.ptp_clock));
 
+		cancel_delayed_work_sync(&mld->ptp_data.dwork);
 		ptp_clock_unregister(mld->ptp_data.ptp_clock);
 		mld->ptp_data.ptp_clock = NULL;
 		mld->ptp_data.last_gp2 = 0;
 		mld->ptp_data.wrap_counter = 0;
-		cancel_delayed_work_sync(&mld->ptp_data.dwork);
 	}
 }
-- 
2.48.1


