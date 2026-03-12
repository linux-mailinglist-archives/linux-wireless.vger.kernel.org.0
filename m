Return-Path: <linux-wireless+bounces-33145-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKIyCDDysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33145-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E25276542
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D10AF3001012
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC713FE341;
	Thu, 12 Mar 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ntLBgCum"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373603FCB09
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334871; cv=none; b=EoZisD+BbWslzW3H7wjC/IPaDcAqp6CF4w4VVrzn6QxYOK21Sa/0kXKVPfxMMbVUqxrjJ+JV2jE4YxixRilm/OhZP/JSF4Zf67gI/Nc2NOzmln5QZOwPsVk6Mhz1ujLf6+bfUkMBoxcjMaE5Xn9tal+u3xmkCDk3PwlqDEGDpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334871; c=relaxed/simple;
	bh=9bEwIouyN/FaLS3kVOEMHmKUqLgkpTcccITqVBxMObQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4Ubpreay3qEe3QxQ0xHClINxStgzvnzmxrgP+buuS7Nhq+HWOAf0AYv/XMzpIKUvtCYfyIpKs/aS4Td1iGfhTskQn0fLDG3h7+qh3Vn9bc9mAA9DNClK1fAKHwJC6LQitdRxv55Pea13OqAvhWvHUP8y10vOJ1uHeZHEtWDpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ntLBgCum; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D1A0AC0105
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 3C77913C2B8;
	Thu, 12 Mar 2026 10:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3C77913C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334863;
	bh=9bEwIouyN/FaLS3kVOEMHmKUqLgkpTcccITqVBxMObQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntLBgCum4EdGs9v7hzzpDEN0X8X+DCzg7pjTclW238TpOKL7WiAK3e9DY+ttmk9gr
	 8ooalr4+A6Ky885wc2i+J8O8Xci4QiZBOa7y5NXdMngdsL+62u9Ln4iscu2QMkj1q7
	 KcpjQtlW7BPKH7h2oxLZjxdfLsj0ynKCOzefyxL4=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 22/28] wifi: mac80211: Add force-cleanup call to driver.
Date: Thu, 12 Mar 2026 10:00:20 -0700
Message-ID: <20260312170026.285494-23-greearb@candelatech.com>
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
X-MDID: 1773334865-QgLLp9QaWmAA
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334865;QgLLp9QaWmAA;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33145-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1E25276542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

When hardware is determined by mac80211 to be in non-recoverable
state, then SDATA_IN_DRIVER flag is removed, and mac80211 will no
longer do any 'graceful' teardown of the objects in the driver.

This was causing use-after-free crashes in the iwlwifi driver
since it's logic to do internal cleanup is not quite right for
some reason.

Add an explicit callback to the driver to tell it to clean up
whatever it needs to clean up in case mac80211 considers it
dead.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/net/mac80211.h    | 7 +++++++
 net/mac80211/driver-ops.h | 8 ++++++++
 net/mac80211/util.c       | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9cc482191ab9..d963f213863b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3934,6 +3934,12 @@ struct ieee80211_prep_tx_info {
  *	you should ensure to cancel it on this callback.
  *	Must be implemented and can sleep.
  *
+ * @force_cleanup: Called after mac80211 determines the
+ *      driver/firmware/hardware has failed and cannot
+ *      be restarted.  SDATA_IN_DRIVER is false at this point,
+ *      so normal cleanup will not happen.  This force_cleanup
+ *      operation lets the driver do any needed houskeeping.
+ *
  * @suspend: Suspend the device; mac80211 itself will quiesce before and
  *	stop transmitting and doing any other configuration, and then
  *	ask the device to suspend. This is only invoked when WoWLAN is
@@ -4569,6 +4575,7 @@ struct ieee80211_ops {
 		   struct sk_buff *skb);
 	int (*start)(struct ieee80211_hw *hw);
 	void (*stop)(struct ieee80211_hw *hw, bool suspend);
+	void (*force_cleanup)(struct ieee80211_hw *hw);
 #ifdef CONFIG_PM
 	int (*suspend)(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan);
 	int (*resume)(struct ieee80211_hw *hw);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index e2283d7dcd1e..3bd3d078ce9b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -300,6 +300,14 @@ static inline void drv_cancel_hw_scan(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void
+drv_force_cleanup(struct ieee80211_local *local)
+{
+	lockdep_assert_wiphy(local->hw.wiphy);
+	if (local->ops->force_cleanup)
+		local->ops->force_cleanup(&local->hw);
+}
+
 static inline int
 drv_sched_scan_start(struct ieee80211_local *local,
 		     struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 55054de62508..ec11ee6b8752 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1692,6 +1692,11 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 	 */
 	list_for_each_entry(ctx, &local->chanctx_list, list)
 		ctx->driver_present = false;
+
+	/* Tell driver to purge any remaining configuration it may have
+	 * lingering around.
+	 */
+	drv_force_cleanup(local);
 }
 
 static void ieee80211_assign_chanctx(struct ieee80211_local *local,
-- 
2.42.0


