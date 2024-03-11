Return-Path: <linux-wireless+bounces-4533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39B877AE8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E3B20C9E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0580FC17;
	Mon, 11 Mar 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q43JN1d+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436EF519
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138510; cv=none; b=DdVTwrrhfc62WFJlMHickfCL26DedPrpdZFVHabLVVtFnXZR8709XPFlEBVltT55AJu4cadCdlXB2RwRgdyvp8/ry66DIQ6WOrXSfIE9Q/pxBllNmJp0zyrbGj18V52fNbbQWkg7gHO6IBzbCLSC6wdeJHAS/avPLCQB1FpsvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138510; c=relaxed/simple;
	bh=AmM2ynJBN0Yu6e3yQlKrFMnjheFUMjfipXk34xdP7Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUTCpZsp9Gm4SYuYYnON8V5aelXz4CDi3bn/w56csfPlmSG+BrmYxk4dTEF0ruHgrYDrv/bU0clFsMBHmOShB+rWKdJvRAiT7HZmMGkK8c52eIWs2PNT8sEc19BjTe3r/imX8wXLM3COGS7G5QAZ2h7x4DqSQJ5k7A+dw+jKGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q43JN1d+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138509; x=1741674509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmM2ynJBN0Yu6e3yQlKrFMnjheFUMjfipXk34xdP7Tk=;
  b=Q43JN1d+4InlOGH1DuoAirxcWKB9UvTebnRueKdjSjPfCmErZRPg+n9e
   EW8UHlsFCUmNawm9MJx3h2N0TmjHxgW8T/MtP31qDQNf5Vd0DCUo9uGST
   aA8bsPox7/1rZARbpSEnIu6POfYM2fJHP2oOjTKBJ9RbXw5rWqu1iOjfK
   sbQLY3AUfMMocp4ZoYXWfTIjlqgYIwFIWvaj+OO48AfQl4KbXTSDddGp5
   tu4KQQ7Qn4/Ugq3CgCRBkJGBZSNoNXAso6DwtGJYPrsMLcWiqt/JrvpF7
   FnyM5GBmld7czGabG0a+wBcZOZiX7xuWDlru5zEk0iZDvonYfcPXe+Kfv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226735"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226735"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657591"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_NOTIF
Date: Mon, 11 Mar 2024 08:28:01 +0200
Message-Id: <20240311081938.39d5618f7b9d.I564d863e53c6cbcb49141467932ecb6a9840b320@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we want to know whether we should look for the mac_id or the
link_id in struct iwl_mvm_session_prot_notif, we should look at the
version of SESSION_PROTECTION_NOTIF.

This causes WARNINGs:

WARNING: CPU: 0 PID: 11403 at drivers/net/wireless/intel/iwlwifi/mvm/time-event.c:959 iwl_mvm_rx_session_protect_notif+0x333/0x340 [iwlmvm]
RIP: 0010:iwl_mvm_rx_session_protect_notif+0x333/0x340 [iwlmvm]
Code: 00 49 c7 84 24 48 07 00 00 00 00 00 00 41 c6 84 24 78 07 00 00 ff 4c 89 f7 e8 e9 71 54 d9 e9 7d fd ff ff 0f 0b e9 23 fe ff ff <0f> 0b e9 1c fe ff ff 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffb4bb00003d40 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff9ae63a361000 RCX: ffff9ae4a98b60d4
RDX: ffff9ae4588499c0 RSI: 0000000000000305 RDI: ffff9ae4a98b6358
RBP: ffffb4bb00003d68 R08: 0000000000000003 R09: 0000000000000010
R10: ffffb4bb00003d00 R11: 000000000000000f R12: ffff9ae441399050
R13: ffff9ae4761329e8 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9ae7af400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fb75680018 CR3: 00000003dae32006 CR4: 0000000000f70ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? show_regs+0x69/0x80
 ? __warn+0x8d/0x150
 ? iwl_mvm_rx_session_protect_notif+0x333/0x340 [iwlmvm]
 ? report_bug+0x196/0x1c0
 ? handle_bug+0x45/0x80
 ? exc_invalid_op+0x1c/0xb0
 ? asm_exc_invalid_op+0x1f/0x30
 ? iwl_mvm_rx_session_protect_notif+0x333/0x340 [iwlmvm]
 iwl_mvm_rx_common+0x115/0x340 [iwlmvm]
 iwl_mvm_rx_mq+0xa6/0x100 [iwlmvm]
 iwl_pcie_rx_handle+0x263/0xa10 [iwlwifi]
 iwl_pcie_napi_poll_msix+0x32/0xd0 [iwlwifi]

Fixes: 085d33c53012 ("wifi: iwlwifi: support link id in SESSION_PROTECTION_NOTIF")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index a59d264a11c5..ad960faceb0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -879,9 +879,8 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mvm_session_prot_notif *notif = (void *)pkt->data;
 	unsigned int ver =
-		iwl_fw_lookup_cmd_ver(mvm->fw,
-				      WIDE_ID(MAC_CONF_GROUP,
-					      SESSION_PROTECTION_CMD), 2);
+		iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
+					SESSION_PROTECTION_NOTIF, 2);
 	int id = le32_to_cpu(notif->mac_link_id);
 	struct ieee80211_vif *vif;
 	struct iwl_mvm_vif *mvmvif;
-- 
2.34.1


