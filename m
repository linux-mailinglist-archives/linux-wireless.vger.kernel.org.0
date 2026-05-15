Return-Path: <linux-wireless+bounces-36471-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DFGLcERB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36471-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:29:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD254F902
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A1E130FC7BB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA6647CC9B;
	Fri, 15 May 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzljzquD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E247A0D1
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847013; cv=none; b=NsyZaiHX5epkYDwz8StaLJ5ZRZG2kQn2BIZvaa0dceZdPPP8JhK1bPdDMGQg5viHuuZeV2GP990TCfcH1Gz6QENzazFaRYCZ1mBJml0fgS2RmwYnmsAgRX4oslMhCfLIyQYt4LARQ2iSSUdPCrWiHqjPXVXa6KfFuHwuqICrUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847013; c=relaxed/simple;
	bh=NmOIqhN0/u9z5Vx7DUvhVvJoN0QJosWopoxoUDQbsqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nh9pTZrP38ggm+hime1ASPZbVUbsTCyG/yRMznqEWe3W0mW0OvB7JOfGz+Ib8CghC92GjjOf216yGI2PlI89Vq5OIB714XFRwM+sZxEV1fnOOsREG8+2o4gfnG8VZt3BnXA8FrjpqY+c7a8MaBiul373LYGaip8z/EPxCCWKdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzljzquD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847011; x=1810383011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NmOIqhN0/u9z5Vx7DUvhVvJoN0QJosWopoxoUDQbsqc=;
  b=CzljzquD9CSZJOEQPY3GvGkcdmLADVqMFEgHQ5aJ7HYTnovzAg1eKhHq
   Nt9Ciek2wTHIgFgKytqSWU+OKfSL572RhARW44FpO457JZnniCpIuxvbR
   1NP72aByyaJiRWxY65zzZA2EGiXpqyAIV2hDb2WPrdN8Km6eSoClhfzH2
   1ReeEiuzoN24bvmgvxMdEM2lFfA97IZjRmXzPzWnZAziwVzLl+5iiu+pJ
   IcOH2Sx/EZzbTwkcltYeFce++WObGynKr4kXxSRYdxvLYlODfY2jBvTnG
   p8ASjQB4CRxMjXPKQ9M2HaHzCkPYnn/7WcvfFzS6+n1lY0LHAmlcYijrs
   w==;
X-CSE-ConnectionGUID: QytM2+B4SC2e/ujwIa8Qdg==
X-CSE-MsgGUID: IIrRWm50TUyBDKHe7V7o/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185677"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185677"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:11 -0700
X-CSE-ConnectionGUID: +7CrG8GwQs6Xro/QM9tH/Q==
X-CSE-MsgGUID: qLQcu1WuRQyfKa4EzNqeUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243649996"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/15] wifi: iwlwifi: reduce the log level of firmware debug buffer size mismatch
Date: Fri, 15 May 2026 15:09:39 +0300
Message-Id: <20260515150751.36a772e925aa.I0f8db3099bd07e72ee007b322c0f85102f0550f9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CCD254F902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36471-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is not really an error and we can safely reduce the log level to
INFO.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index e3603571bdd9..50342604491d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -141,10 +141,10 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 		return;
 
 	if (power != max_power)
-		IWL_ERR(trans,
-			"Sorry - debug buffer is only %luK while you requested %luK\n",
-			(unsigned long)BIT(power - 10),
-			(unsigned long)BIT(max_power - 10));
+		IWL_INFO(trans,
+			 "Sorry - debug buffer is only %luK while you requested %luK\n",
+			 (unsigned long)BIT(power - 10),
+			 (unsigned long)BIT(max_power - 10));
 
 	fw_mon->block = block;
 	fw_mon->physical = physical;
-- 
2.34.1


