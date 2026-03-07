Return-Path: <linux-wireless+bounces-32685-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFojMzBrq2nycwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32685-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:02:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F2228E0B
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3465301BF72
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4B13DDAA;
	Sat,  7 Mar 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NvXTtJXB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD28128816
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841707; cv=none; b=uMT8wuoACXdhbNMGTNK1FkUZumKyyK0wd2xWDBPHc8JH6nQm7VyCjeRxmWUiCJFokug1lFxOiGxl9wlznkSceXSGPkn9wIid6/HbhuuNYXbstt9yYy+GbVzkQmZT+2NUjSMKf3iPlsEBzAowWpc/JKZrKaejrt6YX+mqrtzmyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841707; c=relaxed/simple;
	bh=T+uoPFutR9DL9cXq0Ap5C40RzX61KSO52NNyx1GyiIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1IE6XcskLKJRt3APmHjFbzIj/M3jMzfZhoL4A+a7dTCIH47MuRY5zAhoIbwAWC/I8mM25IKfTeuWNTDeRyhO5pYpmksRAXT6MSC6BpLwitlUzV8uroCIzEV19sn+FDIrZTUhamYT8ujGdoBo0KkIhY+4pCveoPkR6qkCCOc4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=NvXTtJXB; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0C281280076
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 00:01:37 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 4C4F513C2B0;
	Fri,  6 Mar 2026 16:01:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4C4F513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772841695;
	bh=T+uoPFutR9DL9cXq0Ap5C40RzX61KSO52NNyx1GyiIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NvXTtJXBIVKAL/TX5no1b4/93wh5zmSGJjmet7qFBfSsBPZB2gpww8n1TdCz9wutv
	 c/5Ddrt6FnoDvx1Fd333O7axTwdCFVdgcqmRjlYcEN/Z1TjnfeFRtXwgsri1y7gSS1
	 stiW8lRxMUg2JClR0Z0DYqP2jhkzDAICgZN6lvm8=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [RFC 1/2] wifi: mac80211:  Add force-cleanup call to driver.
Date: Fri,  6 Mar 2026 16:01:30 -0800
Message-ID: <20260307000131.2527892-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1772841698-AvNVscRvjizn
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772841698;AvNVscRvjizn;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 327F2228E0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32685-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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

RFC:  I'm curious if something like this is wanted upstream?

 include/net/mac80211.h    | 7 +++++++
 net/mac80211/driver-ops.h | 8 ++++++++
 net/mac80211/util.c       | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ae82fb5f2254..faa8c4f52794 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3942,6 +3942,12 @@ struct ieee80211_prep_tx_info {
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
@@ -4584,6 +4590,7 @@ struct ieee80211_ops {
 		   struct sk_buff *skb);
 	int (*start)(struct ieee80211_hw *hw);
 	void (*stop)(struct ieee80211_hw *hw, bool suspend);
+	void (*force_cleanup)(struct ieee80211_hw *hw);
 #ifdef CONFIG_PM
 	int (*suspend)(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan);
 	int (*resume)(struct ieee80211_hw *hw);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index fb98f6ea30a8..12970bdcf7b9 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -308,6 +308,14 @@ static inline void drv_cancel_hw_scan(struct ieee80211_local *local,
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
index 1347e4933888..e2979c411c64 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1740,6 +1740,11 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
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


