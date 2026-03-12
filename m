Return-Path: <linux-wireless+bounces-33143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGdgEx7ysmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227C27652C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F75C306E206
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9143FD139;
	Thu, 12 Mar 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="cnXkeuod"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169D3FBEC8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334870; cv=none; b=FjuOzZKhcJXycxXeMf2e7TQLX92d3AcLzOHEw/udGCWoGRWHTvX4e47y5xuOnfgtOh0f3W3YGYho64Zzve3s4m4OnNDu58vEzuJEMVVWSz3uQioCex9Z28hmCeluvZm55jx7nYRmhF9QOYkXQu1fwhjJr4rN77xtCii0dVSNgio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334870; c=relaxed/simple;
	bh=qvz/48tv8wHKybJuK3/ebAGlNDAhmg7NrNqkFW0QVeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVzTGJX0BQBNvbyEvkVyD+CFv0HwAWBBOce3qewelUKFkqizhy+Dvvqy0SfI+/l22rUFt73BIIjnFJyyt+yRIBIM9K/1B3jVGOFsQ/xh4Q7oDXtHOIGUs9s+QSIaigChul3y0UyH2bssnSsyIoFyVLVLe31Mxp3+jZzf3nYzBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=cnXkeuod; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DB4B64000AA
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 7038E13C2B9;
	Thu, 12 Mar 2026 10:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7038E13C2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334863;
	bh=qvz/48tv8wHKybJuK3/ebAGlNDAhmg7NrNqkFW0QVeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnXkeuodXyVsfH55a1M0/a4SQkwbk1ZN9+K1NaFZKf8hggTcqNuFsx9880hfgannv
	 wfyUpl/syzVgLZWFG5jKZTC6dq0cSJ0E9aEO4dccZ/HyrbXkg7iFzExzaTJ8u8ggQS
	 suoWh/Pc+dBY4G5N9Vd3FrcA3m6qlc1Y6tAWD25M=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 23/28] wifi: iwlwifi: mld: Support force-cleanup op
Date: Thu, 12 Mar 2026 10:00:21 -0700
Message-ID: <20260312170026.285494-24-greearb@candelatech.com>
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
X-MDID: 1773334865-5Xw0an8fzxMj
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334865;5Xw0an8fzxMj;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33143-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 0227C27652C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

This lets mac80211 force the driver to clean up any lingering
configuration, fixing use-after-free in case of unrecoverable
hardware failure.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 43bc73764dcd..31a3818f32bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -560,6 +560,18 @@ iwl_mld_restart_cleanup(struct iwl_mld *mld)
 	iwl_mld_ftm_restart_cleanup(mld);
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
@@ -2717,6 +2729,7 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.config = iwl_mld_mac80211_config,
 	.get_antenna = iwl_mld_get_antenna,
 	.set_antenna = iwl_mld_set_antenna,
+	.force_cleanup = iwl_mld_mac80211_force_cleanup,
 	.add_interface = iwl_mld_mac80211_add_interface,
 	.remove_interface = iwl_mld_mac80211_remove_interface,
 	.conf_tx = iwl_mld_mac80211_conf_tx,
-- 
2.42.0


