Return-Path: <linux-wireless+bounces-32686-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 06TQH/Bqq2nycwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32686-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:01:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A0228DFB
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46920303048D
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB91C8626;
	Sat,  7 Mar 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="sSu7R/2k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABE7260F
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841707; cv=none; b=VMv1/mDvMGkfVqQdgI9GtLDTtdt5T8f0ATMNXcCW3P5BDARE+oATCia1uJq1zhXiWyUSQhyIGJ6/Y0LQSuTLgnzHqTNKsae0gzcu31cm4tX6NfNEd7gbnSRDfnZdgSIqR3/7BgR/w1CWwhuizBx+hh5AuBdRlN+x+6Js0yvMbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841707; c=relaxed/simple;
	bh=gR9JT4IxhXW7jNpGmsvoz/a1/Svj0SfLhlguz+sE50w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgvuKa5EhLyZjZBeJgHbR+liyg6jHBzP5UdmIoxawKZYqlsgsjvr+l2ctv5R5ZIN2PY5zfNXeloZv7hjxJ2/XFlAqeFKXBd7PJgwU9Q1GktDEE8lfASJfjcRZe6D3fuq/R7gtqOoFQM1/scvYj+QBkdKZvtq0bSbeIiJdEJWO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=sSu7R/2k; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2CE80B8009A
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 00:01:39 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id C1AD413C2B1;
	Fri,  6 Mar 2026 16:01:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C1AD413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772841696;
	bh=gR9JT4IxhXW7jNpGmsvoz/a1/Svj0SfLhlguz+sE50w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSu7R/2k8qkcaIlfSdMk+3GZz1eDSCz4HNgpvaOb/Eu41nNnD6cw0TOWq1oZ6q3Vs
	 mRHlt0GtqXL3RABmNgs0VHoU2X4R4oOIu3t1qW1GQ2u2O96cFGXZZayPMkENvn3C9g
	 WS+dXdErd+IWx0nvdvkvj5qSSyKUP8AH2hvMcFIY=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [RFC 2/2] wifi: iwlwifi: mld:  Support force-cleanup op
Date: Fri,  6 Mar 2026 16:01:31 -0800
Message-ID: <20260307000131.2527892-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260307000131.2527892-1-greearb@candelatech.com>
References: <20260307000131.2527892-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1772841699-9krOyDPr3B18
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772841699;9krOyDPr3B18;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: DE0A0228DFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32686-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ben Greear <greearb@candelatech.com>

This lets mac80211 force the driver to clean up any lingering
configuration, fixing use-after-free in case of unrecoverable
hardware failure.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 4102ee924757..d9ba77eb20eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -500,6 +500,18 @@ iwl_mld_restart_cleanup(struct iwl_mld *mld)
 	ieee80211_wake_queues(mld->hw);
 }
 
+/* mac80211 thinks our driver/firmware/hardware has crashed
+ * and cannot be recovered.  Force clean any existing configuration
+ * (stas, etc), as mac80211 will not attempt further cleanup.
+ */
+static void iwl_mld_mac80211_force_cleanup(struct ieee80211_hw *hw)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	IWL_ERR(mld, "mac80211-force-cleanup called, calling mld_restart_cleanup.\n");
+	iwl_mld_restart_cleanup(mld);
+}
+
 static
 int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
 {
@@ -2963,6 +2975,7 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.start = iwl_mld_mac80211_start,
 	.stop = iwl_mld_mac80211_stop,
 	.config = iwl_mld_mac80211_config,
+	.force_cleanup = iwl_mld_mac80211_force_cleanup,
 	.add_interface = iwl_mld_mac80211_add_interface,
 	.remove_interface = iwl_mld_mac80211_remove_interface,
 	.conf_tx = iwl_mld_mac80211_conf_tx,
-- 
2.42.0


