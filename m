Return-Path: <linux-wireless+bounces-34359-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAvLHaf20WkkRwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34359-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:44:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BFB39D6D4
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCB39300853C
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C41235AC3B;
	Sun,  5 Apr 2026 05:44:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8E35970F
	for <linux-wireless@vger.kernel.org>; Sun,  5 Apr 2026 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367843; cv=none; b=d55jUsije8eVB9Yr69Q/PBMceEk3DED5RYMW9EaNrc7HPT3Disnzs8v7hLDOmiptUVYRq2AO/u0MPOY1bkNtIoOrJLSUyyK3iiJHfhFe/bnmzjIFPLpbbQdvonI5AmzkMMpSw9gbCAeiYZgWo2D/1xjX5afCe95vkVMmyzAzvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367843; c=relaxed/simple;
	bh=96TETqZ2OYljl1SQIqKsG2uuGXPMAHHiJfew+M2IpU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbJkrvOkhOehyiA0wgNnugk1rPHuy3bxzzNKYZM609uF9kiRUDHePmT7RYMgg70lzZyuNM1nbb1o4OHvecihokorK/VXG3urTMEjd2oCs3RDiyuaEg2IYFdrL4zdRbU9eMz82kefz70wFf1KhLJtD68D18gh+tiEZFvmDGwB1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: linux-wireless@vger.kernel.org
Cc: greearb@candelatech.com,
	miriam.rachel.korenblit@intel.com,
	johannes@sipsolutions.net,
	cole@unwrap.rs
Subject: [PATCH v2 0/3] wifi: iwlwifi: mld: fix UAF and soft lockup on firmware error
Date: Sat,  4 Apr 2026 22:41:42 -0700
Message-ID: <20260405054145.1064152-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34359-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,unwrap.rs:mid]
X-Rspamd-Queue-Id: E4BFB39D6D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three fixes for the iwlmld sub-driver addressing use-after-free,
TSO segmentation explosion, and soft lockups during firmware error
recovery on Intel BE200 (WiFi7).

1/3 closes the NAPI race window where stale RX data from dying
firmware reaches the TX completion handlers, causing corrupt SSN
values to trigger skb use-after-free in iwl_trans_reclaim().
Ben Greear confirmed the WARN_ONCE fires on his test systems.

2/3 fixes the TSO segmentation explosion when AMSDU is disabled
for a TID. The TLC notification sets max_tid_amsdu_len to the
sentinel value 1, which slips past the existing zero check and
produces num_subframes=0, causing skb_gso_segment() to create
32000+ tiny segments. Revised per Miriam Korenblit's feedback to
check for the sentinel value directly and add a WARN_ON_ONCE
guard after the division as defense-in-depth.

3/3 adds STATUS_FW_ERROR checks in the TX pull path to stop
feeding frames to dead firmware. Revised per Johannes Berg's
feedback to use status bit checks instead of stop_queues/wake_queues,
which doesn't interact well with TXQ-based APIs.

Changes since v1:
  - 1/3: Added Tested-by from Ben Greear
  - 2/3: Check max_tid_amsdu_len == 1 (sentinel) instead of
    guarding !num_subframes after division; added WARN_ON_ONCE
    defense-in-depth (Suggested-by: Miriam Korenblit)
  - 3/3: Replaced ieee80211_stop_queues()/wake_queues() with
    STATUS_FW_ERROR checks in TX pull path (per Johannes Berg)

Cole Leavitt (3):
  wifi: iwlwifi: prevent NAPI processing after firmware error
  wifi: iwlwifi: mld: fix TSO segmentation explosion when AMSDU is
    disabled
  wifi: iwlwifi: mld: skip TX when firmware is dead

 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   4 +
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 210 +++++------
 .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 337 +++++++++---------
 3 files changed, 284 insertions(+), 267 deletions(-)


base-commit: 3aae9383f42f687221c011d7ee87529398e826b3
-- 
2.52.0


