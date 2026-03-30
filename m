Return-Path: <linux-wireless+bounces-34177-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MdGOadLymmb7QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34177-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:08:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4E358E33
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F20F730148BF
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD43B8938;
	Mon, 30 Mar 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BRK91mSo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369623B7B92;
	Mon, 30 Mar 2026 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865167; cv=none; b=Sod7dKcnq9IHqJ7o7B5oWOYPNt9O5rxZoMrUaQJdBuOCjALCa3lotd+2WX7iCX5W3mBUdtNYnrSb6qeF8PklDTj3yHco9VSKjGpXjoUfmdE104plST3qHLF5OkWPgigkPAGs6CmL906FDgDax8kDs7IQyOw95YVKhlNtB3anGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865167; c=relaxed/simple;
	bh=2Px1vFmVelvllOxT/hL/0VnYYWZyh+UKt4NS9+SHuFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDabxtElkHRHxtZRXz0xA36TNIKOfJKBMFxxuugLgoFS1rvYp/hRJ/30/mL8EoBIroBrbFV4Wq9fSe54c0uxMkR/vBjJv6lCxvM31+WwMH0v5wJxxgq3B6vnw39+xVF325xWB0gKDMmrPxRwTxbI7TkxGRQDTFrd6au99KPRNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BRK91mSo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774865158;
	bh=2Px1vFmVelvllOxT/hL/0VnYYWZyh+UKt4NS9+SHuFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BRK91mSobPtGrDz7gGNcgOYhrnozUQ50KD313+nAgjXQmBO/yfZCrJ6D8PZpXFtQY
	 pghvkhibzpWyDPY6mq0R6uGw0H2SH5jYDf8/qp+NoeGeolV/4pLUM3U5yhbPXPATJg
	 /Rx5fJ5U4ohR2R2/MeXA1TQsKnfPXinzMWP3PAq1y3Lo7QG0PVE+d9pQDi/WrjnZ0w
	 NOH266CQGIVAtj8moOCAyI4l3enicspCDQr0eKUNhO8KczP1j58pbZYlD2Txxt66NY
	 uOKJoXbHPHSJr8WALKDeXa+XKRoaiDmRPgzhG75FhvlbcgLGYEwNR6q6LNn5wBXnkB
	 JTQFSoCRF2bTw==
Received: from [192.168.1.53] (unknown [IPv6:2a01:6243:628:0:43ea:f64d:fc7e:3a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6525D17E41AE;
	Mon, 30 Mar 2026 12:05:58 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Mon, 30 Mar 2026 11:05:31 +0100
Subject: [PATCH RESEND RFC 1/3] net: ath11k: fix redundant reset from stale
 pending workqueue bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-ath11k-lockup-fixes-v1-1-7ed21095c2c4@collabora.com>
References: <20260330-ath11k-lockup-fixes-v1-0-7ed21095c2c4@collabora.com>
In-Reply-To: <20260330-ath11k-lockup-fixes-v1-0-7ed21095c2c4@collabora.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34177-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAF4E358E33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During a firmware lockup, WMI commands time out in rapid succession,
each calling queue_work() to schedule ath11k_core_reset().  This can
cause a spurious extra reset after recovery completes:

1. First WMI timeout calls queue_work(), sets the pending bit and
   schedules ath11k_core_reset(). The workqueue clears the pending bit
   before invoking the work function. reset_count becomes 1 and the reset
   is kicked off asynchronously. ath11k_core_reset() returns.

2. Second WMI timeout calls queue_work() and re-queues the work. When it
   runs after step 1 returns, it sees reset_count > 1 and blocks in
   wait_for_completion(). The pending bit is again cleared.

3. Third WMI timeout calls queue_work(), the pending bit was cleared in
   step 2, so this succeeds and arms another execution.

4. The asynchronous reset finishes. ath11k_mac_op_reconfig_complete()
   decrements reset_count and calls complete(). The blocked worker from
   step 2 wakes, takes the early-exit path, and decrements reset_count to
   0.

5. The workqueue sees the pending bit from step 3 and runs
   ath11k_core_reset() again. reset_count is 0, triggering a
   full redundant hardware reset.

Fix this by calling cancel_work() on reset_work in
ath11k_mac_op_reconfig_complete() before signalling completion. This
clears any stale pending bit, preventing the spurious re-execution.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e4ee2ba1f669..748f779b3d1b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9274,6 +9274,10 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			 * the recovery has to be done for each radio
 			 */
 			if (recovery_count == ab->num_radios) {
+				/* Cancel any pending work, preventing a second redudant
+				 * reset.
+				 */
+				cancel_work(&ab->reset_work);
 				atomic_dec(&ab->reset_count);
 				complete(&ab->reset_complete);
 				ab->is_reset = false;

-- 
2.53.0


