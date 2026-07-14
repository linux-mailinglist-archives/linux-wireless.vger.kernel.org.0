Return-Path: <linux-wireless+bounces-39072-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rSwYK+1CVmqf2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39072-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D875589C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QAU4P7R7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39072-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39072-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5921731E9682
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E08B47CC7A;
	Tue, 14 Jul 2026 14:03:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0037106A
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:03:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037801; cv=none; b=kDtLVTrOJdwbepu0zjFaMlXcgDZY+PFS/0EOL459vdiU2rAA4DnrLZDICDPthvq9YANKqYoSVDW8wxs3VuXY5wAP0JBRy1xJs8TEeWtWzj9Q1paIUlstwrhO5i+twbiVPRKpc4uoce/7OI3nkM80fcPZOtPUBl32jgOeN/iCywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037801; c=relaxed/simple;
	bh=IQUc0nZimLwzbW/BXUVMiGO68xJDJqQ9W8XvhVnSV9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3sySPMdF36NO8kEa/d0KogIautxJdH9fq/5cWw1O1uwV56dV4CGUv6MvTqZpBJskPJPsulBhe9ftPKBgE1Ok6ugns3K8gDvBlSmsoUXRuO3FWRU5K4VibLwcyQ4x1Ez6QyTosupveNpXBnrPFkUjNuu7brHbQhd28Uf1p4dRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAU4P7R7; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037799; x=1815573799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQUc0nZimLwzbW/BXUVMiGO68xJDJqQ9W8XvhVnSV9s=;
  b=QAU4P7R7B5krN6/F+BB2SVwsRrE5AMS1mt/9xEKCd4H7i7InLRb6ZBgP
   6iNGvKwcpXVlGsKw+ZFc3c6ZhQZTbow9hoJKRZPJv+/GHle6F5ThkSq5v
   kVDk5GNIEFoDTCgQcIpYomLRwaMbjfZehIN/szbdH0S1q6PKUbnZzrEhY
   qxCoRilMWw9INL1lfdwx2PuVSCGxJxSFT9w0gTT52XTkdOCn63pdXnZ4G
   sDyDD/9GynP8BPW8sHI4XCuhyvfG/UGtugAUGIzsDl0JyD7p7fM6yBYUu
   7Pqx7IfrL+ARrZnWDVVgGn0t5CyivEsRUmBa8zHyuFFgOTen+LlmmhSGO
   Q==;
X-CSE-ConnectionGUID: lCT2myomSnmbyQiaGBriyA==
X-CSE-MsgGUID: 9OeGzbw7S3yQJlh1PToIoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855160"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:03:02 -0700
X-CSE-ConnectionGUID: Cp+iPng0SNiyUSd7mxDl+Q==
X-CSE-MsgGUID: XA7RcsyHSN+JkHXjPbpR/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737945"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:03:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 13/15] wifi: iwlwifi: mvm: reset the smart fifo state upon FW stop
Date: Tue, 14 Jul 2026 17:02:16 +0300
Message-Id: <20260714165826.7d3c5efe2d1a.I16b23c328a677257257f695fa6f439e41fbcd081@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
References: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39072-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,changeid:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 172D875589C

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The smart fifo is a feature in the firmware configured by the driver.
The driver keeps a state to remember what was the last configuration
sent to the firmware. Obviously, if the firmware stops, we need to
reconfigure the smart fifo. Since we didn't reset that state upon
firmware stop, we thought the firmware is already properly
configured and we didn't send the smart fifo configuration command
as part of the init sequence.

Reset the smart fifo state in iwl_mvm_stop_device() so that we
will properly send the command during the init that will come
later.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f43895c2f3c6..09150feb330d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1535,6 +1535,7 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 	iwl_fw_cancel_timestamp(&mvm->fwrt);
 
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
+	mvm->sf_state = SF_UNINIT;
 
 	iwl_mvm_pause_tcm(mvm, false);
 
-- 
2.34.1


