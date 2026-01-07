Return-Path: <linux-wireless+bounces-30416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B0CFBBCE
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 03:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3A7F3040D30
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F331DEFE0;
	Wed,  7 Jan 2026 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="K8tSs6zN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BA21CC44
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753180; cv=none; b=QzfpAEufLHwV93aBgptzF4I3U48IkraqqUmofosvVhwEhLpHxgwDjJ+1P5Pu0Fs+PcJZtRwmxS/la1w47GcL9WQwDMYDZ5u34cl8mMgNA3AnvYI1cVQhJxJfuM6FmaRNe9fe7YLsJSGTvBprE7nMkFxVHKxuBjCl/I85h69ZL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753180; c=relaxed/simple;
	bh=LrQ9BRaFUBPu7sQ3EpMzkLOvWdGwYvDmUVjqPFwAUqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtAXLYACFUjpA/aEKCEL+WNzxVBOo/jBwpu6mUX/Sz2MUNwBBtP+iylTfj/S9CuyJ0qHLANZ8pt35fuJbUJQ6bnA6TFd38sdEGeR9RsV71DoXl+jrUzVNDyQupiaFtL3ZR9S9kacf3IC8rgprmeuW51em1ZvK/2zJ6mwCcxwo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=K8tSs6zN; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F13A4180075;
	Wed,  7 Jan 2026 02:32:49 +0000 (UTC)
Received: from carkeek.candelatech.com (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6231413C2B0;
	Tue,  6 Jan 2026 18:32:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6231413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1767753167;
	bh=LrQ9BRaFUBPu7sQ3EpMzkLOvWdGwYvDmUVjqPFwAUqc=;
	h=From:To:Cc:Subject:Date:From;
	b=K8tSs6zNhOBRzLl1VKT95gxx3fZ6YEBtt0bZHWD5Hcg0laZpwwcMvWiM9Zm9Qu0/W
	 P+2b5WMGrHB6FfbjGqISUJftoD7wspz7LGklbEVmfcZMEhQdG4TiBCKxIWXP04DVgz
	 CZ5QOUo1PfmFnQdBdt9j5KVdV7TWYIvDIuSyfCKM=
From: Rory Little <rory@candelatech.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: mld: Fix dereference of link before NULL check.
Date: Tue,  6 Jan 2026 18:32:23 -0800
Message-ID: <20260107023223.28930-1-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1767753170-ks9wxyRcskrb
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1767753170;ks9wxyRcskrb;<rory@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;

Move dereference to retrieve fw_id member of the link to after the link
is NULL checked.

Fixes: 77e67d5daaf1 ("wifi: iwlwifi: fix potential use after free in iwl_mld_remove_link()")
Signed-off-by: Rory Little <rory@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index d89840a1152b..13102753b36c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -504,11 +504,13 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
 	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
 	bool is_deflink = link == &mld_vif->deflink;
-	u8 fw_id = link->fw_id;
+	u8 fw_id;
 
 	if (WARN_ON(!link || link->active))
 		return;
 
+	fw_id  = link->fw_id;
+
 	iwl_mld_rm_link_from_fw(mld, bss_conf);
 	/* Continue cleanup on failure */
 
-- 
2.49.0


