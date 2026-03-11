Return-Path: <linux-wireless+bounces-33030-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMcTJGf2sWl7HQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33030-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:10:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E351D26B328
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29D9E32118D2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E7390C8B;
	Wed, 11 Mar 2026 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="SxNsKkU3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73939FCB4
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270483; cv=none; b=eiL4W1Vhy+UWyRy0zRh6XBbSViFz4vEDI0BJmer5sfekbUzu8zn2VSftuAUtaTKKlcMYV47KQgEzaNZLGX6MVaOBWoUFx8FMbmvehs69eLpJI+EM4SCUqJQFhgZHM/6bulPiUv02jcuLAz/N90uOUrqOOAU88mPR0BhZfnSaZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270483; c=relaxed/simple;
	bh=CTCMuoNTR1zKOuUeLRCwrEf946YXF/gSoMHht7voBy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8OqoB89PauN3VM0FVSxB97DQa63Sux/1QFLH3VENmIfO4Yt0uzl8WOUvYcUDRldGlFZAz/HvhMMcLet4Pmax77cNiyR5AAh2pg0XmpmMHTN8EaaytFLPsgSAXAUZLd7RG4GzpFVE+EZ54vwo92YpIoD4oDUBxwfss5/eExa7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=SxNsKkU3; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 557632C00A7
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:49 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 817D4A80075
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:42 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id AEDB913C2B3;
	Wed, 11 Mar 2026 16:07:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AEDB913C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270459;
	bh=CTCMuoNTR1zKOuUeLRCwrEf946YXF/gSoMHht7voBy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxNsKkU3g3XNwILV2A8qGc3gFk1ZCcGq0B7MAFFotBZO7djG/xnPIOXYdQofiRjlS
	 u6qcjro6ih0hC2mQpqEuYx0wNFWrFF5EUxbs0tuf4iMyfoHmo3G53hTx/oCJw8JzrL
	 SDJqHMhpYLimmJdatxYqIo0JxzzubPcjbvgSBO74=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 15/28] wifi: iwlwifi: mld: Fix use-after-free of bss_conf
Date: Wed, 11 Mar 2026 16:07:17 -0700
Message-ID: <20260311230730.163348-16-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260311230730.163348-1-greearb@candelatech.com>
References: <20260311230730.163348-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773270463-0c15Q_QVrwEM
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773270463;0c15Q_QVrwEM;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33030-lists,linux-wireless=lfdr.de];
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
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: E351D26B328
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


