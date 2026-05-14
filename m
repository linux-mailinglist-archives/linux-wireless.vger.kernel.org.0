Return-Path: <linux-wireless+bounces-36426-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGoKHlgmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36426-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07D54678B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9689A3041AA5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3332239E9A0;
	Thu, 14 May 2026 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCmGqP7W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB1389E1A
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787900; cv=none; b=ke0g34dlH6RC7k9lvDdzZwjnbPcDeelxhPchBE7LQuJMbiD8KhCtwf1ujvi6rDmRNP1mzSfQhEAvPv3qvis5uhXeWW8biOExzJYANmtFrLdzjg9FJ5OCSUoC1iEPR3pHf4/2stFI+N8Bz0oap822hMkkyQsZLcTUiVc0wZa/FzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787900; c=relaxed/simple;
	bh=NmOIqhN0/u9z5Vx7DUvhVvJoN0QJosWopoxoUDQbsqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szorLK0C8nEMfQ/6ZtiSvj8gt2gsZC7V0SNX5YY4oylb4BLyXnZXdtgDHvIMVu4tvLUfQz0gz/CZO1osyLvjmLgq2HT4CVAkSsfdt7liqC5TMbbWFZRy28hmcXHOHPd0qsjPs1zbbwSkE0DzzlWWIQncmJsaZUijG723cR7RjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCmGqP7W; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787898; x=1810323898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NmOIqhN0/u9z5Vx7DUvhVvJoN0QJosWopoxoUDQbsqc=;
  b=eCmGqP7WpxGdwAvUXyNOMrzx5wjyPdNBbTqdYt81/8zoRG0ZhAHuxs5Q
   JKlFSkJZ9thOLkiHifOqqWXP8RvHjP+sa8twULrS7ap2F49fXpBQfdxFs
   bpkVVXv/CtTFtbh3t79TlVmYlmu6rjETPrbKCU/VBMAkx6CeuMhSkiiKS
   P+VlZ1wAVVyhFHbQnCfp1a341eDtaSNS0gDCt4GUdpUwVdB6m3KKiUIyP
   OzFdri8AB0yLfdRXP5xjHiyQ/ZsTf9zd3hz+W5RPfnDG1Cs6DD2x5TP8/
   BAwhDbKqdo2Pc5ca1TKubPBACFF49HzkobtbVFKU9gTBPzZG8MOaQtV5a
   w==;
X-CSE-ConnectionGUID: wYiZzFZYS12iswWfSdYS/A==
X-CSE-MsgGUID: M3jgHgvwQnyH2SfnqzxNZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352583"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352583"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:58 -0700
X-CSE-ConnectionGUID: c6bHpHSMRhW7FXHvDXazaw==
X-CSE-MsgGUID: fJeFyGYkTLu6dcXmE1IQDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616273"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: reduce the log level of firmware debug buffer size mismatch
Date: Thu, 14 May 2026 22:44:25 +0300
Message-Id: <20260514224230.36a772e925aa.I0f8db3099bd07e72ee007b322c0f85102f0550f9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC07D54678B
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
	TAGGED_FROM(0.00)[bounces-36426-lists,linux-wireless=lfdr.de];
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


