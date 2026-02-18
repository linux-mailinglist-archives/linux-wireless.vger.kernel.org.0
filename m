Return-Path: <linux-wireless+bounces-31966-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IWpIQXRlWlEVAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31966-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 15:47:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33015723B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F61D300C909
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7504331A55;
	Wed, 18 Feb 2026 14:47:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983C319610
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426050; cv=none; b=Z73DBPZxeF3axmmRlQ4JESh3qXRffAnlsPSLT2UJRHCi6KG8QpKYXQBB4RJPEBjuO4aywjB+cOc6W8181kodPiyGlse99Ksv5aeqpLlFehTRANZBGg4pCyBTQVDkEmqYO+19ygdThh2yYu4QaA+5uvKburfjkMF/+VMmlBWt+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426050; c=relaxed/simple;
	bh=Udcf/AUCCa3sPMKY2d9FCCKLI2o7LMA/1bAl6k2zN78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRVokLO/oOQ2dU55K4/Ni1yMJMRCRhkEKqx4ogZFue18hJ0AO6G7C4ouQxp7wHGqluL535vK7tKZWksNM1XeH8V1VAn1xg4wWWV8q4N84Y05C5sn6I0z7zGCfS6A3X5X/oyrW4WxsWhQYLBxyjWk5ryskLriMhnfHbhSbKOS5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: greearb@candelatech.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	Cole Leavitt <cole@unwrap.rs>
Subject: [PATCH 0/1] wifi: iwlwifi: mld: fix TSO segmentation explosion causing UAF
Date: Wed, 18 Feb 2026 07:47:22 -0700
Message-ID: <20260218144723.31699-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <9edde56d-bfdc-40f6-862c-b69950cc2f25@candelatech.com>
References: <9edde56d-bfdc-40f6-862c-b69950cc2f25@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_FROM(0.00)[bounces-31966-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unwrap.rs:mid];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org]
X-Rspamd-Queue-Id: DB33015723B
X-Rspamd-Action: no action

Ben,

I've been digging into the use-after-free crash you reported on your
BE200 running the MLD driver (tcp_shifted_skb refcount underflow,
followed by NULL deref in tcp_rack_detect_loss). I think I found the
root cause -- it's a missing guard in the MLD TSO segmentation path
that lets num_subframes=0 reach skb_gso_segment(), producing the 32k+
segment explosion you're seeing.

Here's the full chain:

1) mld/tlc.c:790 -- when firmware's TLC notification disables AMSDU for
   a TID (bit not set in amsdu_enabled), the MLD driver sets:

     link_sta->agg.max_tid_amsdu_len[i] = 1;

   This sentinel value 1 means "AMSDU disabled on this TID".

2) mld/tx.c:836-837 -- the TSO path checks:

     max_tid_amsdu_len = sta->cur->max_tid_amsdu_len[tid];
     if (!max_tid_amsdu_len)   // <-- only catches zero, not 1
         return iwl_tx_tso_segment(skb, 1, ...);

   Value 1 passes this check.

3) mld/tx.c:847 -- the division produces zero:

     num_subframes = (1 + 2) / (1534 + 2) = 0

   Any max_tid_amsdu_len below ~1534 (one subframe) produces 0 here.

4) iwl-utils.c:27 -- gso_size is set to zero:

     skb_shinfo(skb)->gso_size = num_subframes * mss = 0 * 1460 = 0

5) iwl-utils.c:30 -- skb_gso_segment() with gso_size=0 creates 32001+
   tiny segments, which is the error you're seeing:

     "skbuff: ERROR: Found more than 32000 packets in skb_segment"
     "iwl-mvm-tx-tso-segment, list gso-segment list is huge: 32001"

6) mld/tx.c:912-936 -- the loop queues ~1024 of those segments to the
   TX ring before it fills up, then purges the rest. This creates a
   massive burst of tiny frames that stress the BA completion path.

The MVM driver is immune because it checks mvmsta->amsdu_enabled (a
separate bitmap) at tx.c:912 and tx.c:936 BEFORE ever reaching the
num_subframes calculation. MLD has no equivalent -- it relies solely on
max_tid_amsdu_len, and the sentinel value 1 slips through.

This explains all your observations:
- 6.18 regression: BE200 moved from MVM (has guard) to MLD (no guard)
- AP-specific: the problem AP causes firmware to disable AMSDU for the
  active TID (other APs enable it, so max_tid_amsdu_len gets a proper
  value from iwl_mld_get_amsdu_size_of_tid())
- 28min gap between TSO explosion and UAF: the ~1024 micro-frame burst
  creates massive alloc/free churn in the skb slab, which can corrupt
  TCP retransmit queue entries allocated from the same cache
- No firmware error: firmware is fine, the bug is purely in MLD's TSO
  parameter calculation

The fix (in patch 1/1) adds a guard after the num_subframes
calculation -- if it's zero, fall back to single-subframe TSO
(num_subframes=1), which correctly sets gso_size=mss. This matches what
MVM effectively does via its amsdu_enabled checks.

Could you test this against the problem AP? Two things that would help
confirm the theory:

1) Before applying the fix, add this debug print to see the actual
   max_tid_amsdu_len value with the problem AP:

     // In iwl_mld_tx_tso_segment(), after line 847
     if (!num_subframes)
         pr_warn_once("iwlmld: num_subframes=0, max_tid_amsdu_len=%u "
                      "subf_len=%u mss=%u\n",
                      max_tid_amsdu_len, subf_len, mss);

2) After applying the fix, run against the problem AP for 1+ day and
   check if both the TSO explosion AND the UAF are gone.

I also noticed a few secondary defense-in-depth regressions in MLD's TX
completion path vs MVM:

- MLD's iwl_mld_tx_reclaim_txq() has no per-TID reclaim tracking
  (MVM has tid_data->next_reclaimed and validates tid_data->txq_id)
- The transport-level reclaim_lock prevents direct double-free, but
  MLD is missing MVM's extra safety checks

These are probably not directly causing your crash, but worth noting.

Cole Leavitt (1):
  wifi: iwlwifi: mld: fix TSO segmentation explosion when AMSDU is
    disabled

 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.52.0


