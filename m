Return-Path: <linux-wireless+bounces-33135-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ7vBgTysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33135-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B7B2764DA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4395B30635EF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A911D3FCB14;
	Thu, 12 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="G73GN1lH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C353FBEB1
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334868; cv=none; b=nDXLFwWATjyAgLGilEhFUhkuN3Bq0PAn/FJzPmHtuSVugQIbdbHCRqENev3Pv1GPcv9miaxp7VGbh4Rf9NNo4Mg/V2gDvENYTUCnQrilFqv9WF7X3w7ttl0YrfsiehFNnMgf6cfpwh8FgAMpcVfCnpAjXWTH6bw3gjGtKg88urY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334868; c=relaxed/simple;
	bh=CTCMuoNTR1zKOuUeLRCwrEf946YXF/gSoMHht7voBy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VarVZlViEXrj7KIPH1pLzWyFTbGjJ6pmTVnW1a04MXqvhgGc6EvdQ2Ajw4JG3AGbesZhKHKuQiCjHD9XvqTXlXLGU8erkKBPK9H8r9Iy89jaXOMW4pKNs+71TkuvDECYjYcXQgTPJ1txnMv3YewCosGrk3qoqF0BKVru3w5hkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=G73GN1lH; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E2922800B0
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 6918013C2B4;
	Thu, 12 Mar 2026 10:01:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6918013C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334861;
	bh=CTCMuoNTR1zKOuUeLRCwrEf946YXF/gSoMHht7voBy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G73GN1lHMMMFn8IQhFI4r+vUlr/CPN265KnIgY+rlKniE4zJLnkZ9IbVKlSJqcEIN
	 e3FEE8g5S0kJMNQuM487CkYfHPjf9f9+wkX68zV2CVjxgI8ich1aNxHFAXx6i3BtAw
	 ZnNhzDQSL+yW9BaL5Wy8Hiq4riFuOtAspLhIB+po=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 15/28] wifi: iwlwifi: mld: Fix use-after-free of bss_conf
Date: Thu, 12 Mar 2026 10:00:13 -0700
Message-ID: <20260312170026.285494-16-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260312170026.285494-1-greearb@candelatech.com>
References: <20260312170026.285494-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773334864-ruLDrkXNXLvy
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334864;ruLDrkXNXLvy;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33135-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: D6B7B2764DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

In certain failure paths, the driver is not fully configured, and
it fails to find the link object.  We still need to remove pointers
to the bss_conf to keep from crashing shortly afterwards.

Search all indices for stale pointer if we cannot do the fast
lookup by ID.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index b5430e8a73d6..1e4959ceb3db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -504,23 +504,49 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
 	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
 	bool is_deflink = link == &mld_vif->deflink;
-	u8 fw_id = link->fw_id;
+	u16 fw_id;
 
-	if (WARN_ON(!link || link->active))
-		return;
+	if (WARN_ON_ONCE(!link)) {
+		IWL_ERR(mld, "Remove nonexistent link, bss_conf: 0x%px link-id: %d\n",
+			bss_conf, bss_conf->link_id);
+		fw_id = 0xffff;
+	} else {
+		fw_id  = link->fw_id;
+	}
+
+	/* Not cleaning it up seems worse than cleaning up an active link,
+	 * so continue on even in warning case.
+	 */
+	if (link && WARN_ON_ONCE(link->active))
+		IWL_ERR(mld, "Removing active link, id: %d\n",
+			bss_conf->link_id);
 
 	iwl_mld_rm_link_from_fw(mld, bss_conf);
 	/* Continue cleanup on failure */
 
-	if (!is_deflink)
+	if (link && !is_deflink)
 		kfree_rcu(link, rcu_head);
 
+	rcu_read_lock();
 	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
 
-	if (WARN_ON(fw_id >= mld->fw->ucode_capa.num_links))
-		return;
-
-	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
+	if (fw_id >= mld->fw->ucode_capa.num_links) {
+		struct ieee80211_bss_conf *tmp_bss_conf;
+		int i;
+
+		/* Search for any existing back-pointer */
+		for (i = 0; i < ARRAY_SIZE(mld->fw_id_to_bss_conf); i++) {
+			tmp_bss_conf = rcu_dereference(mld->fw_id_to_bss_conf[i]);
+			if (tmp_bss_conf == bss_conf) {
+				IWL_ERR(mld, "WARNING: Found bss_conf in fw_id_to_bss_conf[%i], Nulling pointer.\n",
+					i);
+				RCU_INIT_POINTER(mld->fw_id_to_bss_conf[i], NULL);
+			}
+		}
+	} else {
+		RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
+	}
+	rcu_read_unlock();
 }
 
 void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
-- 
2.42.0


