Return-Path: <linux-wireless+bounces-37941-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id urbtNc6KN2oVOwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37941-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 08:55:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A56AA54D
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 08:55:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=c5jhijwH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37941-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37941-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EF763003D27
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918522D4D3;
	Sun, 21 Jun 2026 06:55:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893541C68F;
	Sun, 21 Jun 2026 06:55:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782024906; cv=none; b=h9lX8pMZ2UemwY3AoKBKlOlpNo8yZAiFrIUdrBa0ek5PWJGfgKZr/t5sGlFDxREhCtM1rxk0UdqXohohAB6CxFBZR/KqX/uMOh+GT50T5NXZt4YQPtBG5RbuCiP2eK7K3QADbLhPe7au1Yo5dvQyc3y/+TU6xpx21DInur4l7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782024906; c=relaxed/simple;
	bh=Wx01uP3faFngXSSrd1jm6na8igotzoZExmtNPTQ84ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ex3TdRvcEPSXt1bHAXY13tPcP5lWL3KScWx+wSBbgPFwjby8No3V+7TDdQH7+Blfxo/D+TZ0ldD9tUFLT2DBzagOcYTsReTgkn5+FmfXg5XgQr/ZYyUTDWltyqSSAq/afqKf3VG12uT4gNRFX7DlljPzEhc/tGAUuYWm9R6als0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5jhijwH; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782024904; x=1813560904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wx01uP3faFngXSSrd1jm6na8igotzoZExmtNPTQ84ss=;
  b=c5jhijwH4PG3lsj0wJ8wt7mT8i4Ye1OOkC2hoN1QZ8olMk7obPbm7hvM
   I3d+pMmUH/5Sjscus779lCa5bDwotIIOOyA/WVVlRCnAiTXSOi0QUT0LM
   U7NwerslBt8uSkESLK3FbCm2aRLfYG59oNutRH2CpwkXOYuyX7/pNTUyy
   8vmJ/jKmyOatz6gXHg5VHvUz7BQ9o5FJUgWt3YUrSrseuP6Wms56+UFcp
   36JMdbhlgdDWPv/gY2LpCVWfmTSwbjN1OfVZtwST1IW2aTpuXdU2s2eo6
   TX+DMjcJ/qv7RevHXbHUGfFfIw4Q8AH30AmFHt/z6YjjSVifVZLvXVsBN
   g==;
X-CSE-ConnectionGUID: TGuTOx/uQMWmNvj4UX6Hdg==
X-CSE-MsgGUID: wBsp2JiZT2aHN0q/fgFUQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11823"; a="93444611"
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="93444611"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 23:55:03 -0700
X-CSE-ConnectionGUID: KbyF/pl+Svet30DepINh+A==
X-CSE-MsgGUID: maxN6Em8RdK8YKWY1jUL3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="247809376"
Received: from egrumbac-mobl6.jer.intel.com ([10.13.65.199])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 23:55:02 -0700
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: linux-pci@vger.kernel.org,
	helgaas@kernel.org
Cc: linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel wireless BE200
Date: Sun, 21 Jun 2026 09:54:51 +0300
Message-ID: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37941-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[emmanuel.grumbach@intel.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emmanuel.grumbach@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D4A56AA54D

The Intel wireless BE200 device fails to copy the TLP Attributes from a
Request to the Completion.
Since there is no caching involved the device anyway, disable the
NoSnoop and Relaxed ordering on the root port.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/pci/quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c0242f3e9f06..e9f070d07b2c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4674,6 +4674,13 @@ static void quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 			 quirk_chelsio_T5_disable_root_port_attributes);
 
+/*
+ * The Intel wireless BE200 fails to copy TLP Attributes from a Request to the
+ * Completion it generates.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x272b,
+			 quirk_disable_root_port_attributes);
+
 /*
  * pci_acs_ctrl_enabled - compare desired ACS controls with those provided
  *			  by a device
-- 
2.54.0


