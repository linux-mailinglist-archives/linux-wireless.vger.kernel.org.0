Return-Path: <linux-wireless+bounces-35093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCkQGzdm5mmJvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:45:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA143204A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66CD73008C3D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67E3A7592;
	Mon, 20 Apr 2026 17:44:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A43845D4
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707057; cv=none; b=lC8223ZnV8aJUBQ5YItwJxdEnz5mYazyUTadM1AgY5zvtp5rTXdWBN/DAV7Vr9O2IQ9U9+XymKKihj+qlocFuSWGXImFApdZ1EjKNlpoOqu5Y9hQF3zkuO5vahsiuKyTuN6uDA3nXy58n8+UcfM6vAUEIu3bdMDKx8U+tir6pcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707057; c=relaxed/simple;
	bh=AxYDsSzx3lplX+wsiR8VxBaWMzbX6LE5D0HC/x9jaYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzlIJR0YuPZja6GKkX1+E1Sz1/qofrHYYfuHNj3n4V6HPpwvmu3mb/NVgdu8P6SoI80QvQjvDmfzuuC/sFVbBTKFdTQLjsigzIuuWze7wV/Ne24eKLZ9BXAPzREQhF6o98aeDEWO76gqqxgDkVoDFEURaVKaRUsyC6/OEyWaIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: linux-wireless@vger.kernel.org
Cc: greearb@candelatech.com,
	miriam.rachel.korenblit@intel.com,
	johannes@sipsolutions.net,
	cole@unwrap.rs
Subject: [PATCH v3 0/3] wifi: iwlwifi: mld: stability fixes around firmware error recovery
Date: Mon, 20 Apr 2026 10:44:03 -0700
Message-ID: <20260420174406.128254-1-cole@unwrap.rs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-35093-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unwrap.rs:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11EA143204A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three fixes for the iwlmld sub-driver observed on Intel BE200 (Wi-Fi 7).

1/3 adds STATUS_FW_ERROR guards to the NAPI poll functions and to the
    TX/BA notification handlers.  iwl_trans_reclaim() already has its
    own STATUS_FW_ERROR early-return, so these are defense-in-depth
    with WARN_ONCE instrumentation: if the suspected post-FW-error race
    fires, we now catch it early (before reclaim) and log it.  Tested by
    Ben Greear, who confirmed the WARN fires on his systems during
    firmware error recovery.

2/3 fixes a real TSO segmentation bug.  When the TLC notification
    disables AMSDU for a TID, max_tid_amsdu_len is set to the sentinel
    value 1 (see mld/tlc.c line 858).  The existing zero-only check in
    iwl_mld_tx_tso_segment() lets this sentinel through, producing
    num_subframes=0, which feeds gso_size=0 into iwl_tx_tso_segment()
    and downstream skb_gso_segment().

    MVM is immune because it gates on mvmsta->amsdu_enabled; MLD has no
    equivalent bitmap.  Fix by also treating the sentinel 1 as "AMSDU
    disabled" at the existing guard, and add a WARN_ON_ONCE(!num_subframes)
    after the division so any future path that produces zero through a
    different mechanism is caught and reported rather than silently
    creating a pathological GSO skb.

3/3 adds STATUS_FW_ERROR checks at the top of iwl_mld_tx_from_txq() and
    iwl_mld_mac80211_tx() to stop pulling frames for dead firmware,
    eliminating an observed soft lockup during firmware error recovery.
    Revised per Johannes Berg's feedback to use status-bit checks rather
    than ieee80211_stop_queues()/wake_queues() which do not interact
    well with TXQ-based APIs.

Changes since v2:
  - 1/3:
      * Stripped inadvertent clang-format style churn from v2; the diff
        is now only the functional STATUS_FW_ERROR guards (four hunks,
        ~30 lines added).
      * Rewrote commit message: the v2 message claimed a proven
        SSN-corruption -> iwl_trans_reclaim() UAF chain, but
        iwl_trans_reclaim() already checks STATUS_FW_ERROR itself
        (iwl-trans.c:~663), so that chain cannot actually reach the
        queue walk.  The patch is more accurately described as
        "earlier STATUS_FW_ERROR guards with WARN_ONCE instrumentation
        for diagnosis of suspected post-FW-error NAPI scheduling."
      * Kept Tested-by: Ben Greear.

  - 2/3:
      * Removed the speculative "TCP retransmit queue UAF / refcount
        underflow in tcp_shifted_skb / NULL deref in tcp_rack_detect_loss"
        chain from the commit message per Ben Greear's feedback.  Those
        symptoms are real but the causal link to this bug was not
        directly traced; describing them as consequences of this patch
        was overclaiming.
      * Commit message now states only what can be traced in-tree:
        sentinel 1 -> num_subframes=0 -> gso_size=0 -> unbounded
        skb_gso_segment() output.  Downstream symptom attribution is
        left for the separate investigation Ben and I have underway.
      * Code change is unchanged from v2.

  - 3/3: Unchanged from v2 beyond rebase context.

To Miriam's question in the v2 thread ("Was the soft lockup happening
as a consequence of the bug fixed in 2/3?"):  Yes, our typical trace is
2/3's GSO explosion -> firmware receives malformed AMSDU descriptors
-> firmware hangs in an MMIO poll (FSEQ_ERROR_CODE 0x67A00000,
SYSTEM_STATISTICS_CMD timeout) -> 3/3's dead-firmware TX path keeps
spinning -> soft lockup.  Full dmesg attached to a follow-up on the
v2 thread so the Intel firmware team can investigate the c102 MMIO
poll hang separately; the kernel-side chain is independently
reproducible with a small test case.

Cole Leavitt (3):
  wifi: iwlwifi: add STATUS_FW_ERROR guards to NAPI/TX-notif paths
  wifi: iwlwifi: mld: fix TSO segmentation when AMSDU is disabled
  wifi: iwlwifi: mld: skip TX when firmware is dead

 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        | 22 ++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c| 18 ++++++++++++++++++
 3 files changed, 44 insertions(+)

base-commit: 3aae9383f42f687221c011d7ee87529398e826b3
-- 
2.52.0

