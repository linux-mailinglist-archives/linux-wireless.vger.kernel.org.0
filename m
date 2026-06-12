Return-Path: <linux-wireless+bounces-37693-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ymfZBt99K2ol+gMAu9opvQ
	(envelope-from <linux-wireless+bounces-37693-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 05:32:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428736766F4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 05:32:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="U/wBGcrX";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37693-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37693-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA7213073433
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 03:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889093955E3;
	Fri, 12 Jun 2026 03:32:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890143955C9;
	Fri, 12 Jun 2026 03:32:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781235162; cv=none; b=EbFsWIiUBn3vnp4tfE1+cXbrmr2A8/4ad39z6s8Fw6rSrPKVcqBQZKgo/VNpV6LdssWXnl+DhOeYOsnRtRXQNgpLgoxnySqVd67moJqUZF7GAZBNtb8WHRG1dPrwLrqcYzRN8u0GfGiYM7C5pdsleTTK1dI5KTECCmeKZD+TKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781235162; c=relaxed/simple;
	bh=GLBRA3aCNOiJ+cX4pPaaXG4vkxzw21PHIsDYWqB6ZcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfyWGSCfQfKA9I7fNDIN/SBXXveukMk66XOlVgZzpp4f74QhHUoLl5CRaMHW5p8jnEHc5FrmsgCg1as/z6EiIDpWk8VwytruoEd8gvaiJcBzbXNmQ3GV9zKxCArivRL742Xsd6kXtDpJqecq2f0HYGbkVQUCZuQ8HW+2VC+wCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=U/wBGcrX; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4217b11a3;
	Fri, 12 Jun 2026 11:27:22 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jjohnson@kernel.org
Cc: kvalo@kernel.org,
	quic_kangyang@quicinc.com,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: ath12k: avoid flushing scan work under the wiphy lock
Date: Fri, 12 Jun 2026 11:27:01 +0800
Message-Id: <20260612032701.1619188-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb9debbea03a1kunma64aae04181256
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTU8dVhlLHR4fGE0fGUhOTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=U/wBGcrXfmxiUJTXDGpQPoyDXab+N9lE5yaEVcYf68EUjSrTUvQalq4fxwwd+ITCRkw/lBFTQA8//+dkkyaHdKVDevzBWD9gI4+S0Dcf5lXPyLJSBqB6pAdQByAyO24LhYQVcg5c6DPBPbzV3YWy4pvcp8cvFZlmfayFr360Loc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=OYG8FF1qte1dFzNbSJ7ZjAMN0gyC4DSDMnQ2biEA2Z4=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37693-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:kvalo@kernel.org,m:quic_kangyang@quicinc.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 428736766F4

ath12k_mac_op_stop() is entered with the wiphy mutex already held.  It
then takes ah->hw_mutex and ath12k_mac_stop() synchronously cancels the
scan.timeout delayed work.  The timeout worker grabs the same wiphy lock
before it aborts the scan, so stop can deadlock against the pending
worker.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the ath12k_mac_op_stop() -> ath12k_mac_stop() ->
cancel_delayed_work_sync(&ar->scan.timeout) path and the
ath12k_scan_timeout_work() -> wiphy_lock() edge.  Lockdep reported:

  WARNING: possible circular locking dependency detected
  ath12k_scan_timeout_work+0x25/0x42 [vuln_msv]
  __cancel_work_timer
  *** DEADLOCK ***

Drain scan.timeout before re-entering the stop path under the wiphy lock
and leave the rest of ath12k_mac_stop() unchanged.

Fixes: 2830bc9e784f ("wifi: ath12k: implement remain on channel for P2P mode")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Notes:
  - Validated with a grounded Lockdep PoC that preserves the
    ath12k_mac_op_stop() -> ath12k_mac_stop() ->
    cancel_delayed_work_sync(&ar->scan.timeout) path and the
    ath12k_scan_timeout_work() -> wiphy_lock() edge.
  - checkpatch.pl --strict: clean.
  - Not tested on ath12k hardware.

 drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b97469dca046..cc9e8331513d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5263,8 +5263,6 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 		ar = arvif->ar;
 
 		ath12k_scan_abort(ar);
-
-		cancel_delayed_work_sync(&ar->scan.timeout);
 	}
 }
 
@@ -9164,6 +9162,15 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	/*
+	 * scan.timeout grabs the wiphy lock before aborting the scan, so
+	 * drain it before re-entering the stop path under the wiphy lock.
+	 */
+	wiphy_unlock(hw->wiphy);
+	for_each_ar(ah, ar, i)
+		cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_lock(hw->wiphy);
+
 	ath12k_drain_tx(ah);
 
 	guard(mutex)(&ah->hw_mutex);
-- 
2.34.1

