Return-Path: <linux-wireless+bounces-34360-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHciAaz20WkkRwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34360-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:44:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059539D6DB
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 129203005327
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216735970F;
	Sun,  5 Apr 2026 05:44:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F8D35AC0B
	for <linux-wireless@vger.kernel.org>; Sun,  5 Apr 2026 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367844; cv=none; b=JreaW6p4rt+0Ksoo5oD2E3z0GQNQudnmeo/IEzzxdSIIoEMdU9c06YtJw9KmJiYXpoDJt/WtV621Eu603GVcikDb0Oiu0+Z9fRsp/o/N5AdjLogT+UKCfpRhJRedfLMg0MlRuRy0Ibb1ffDl1lnEysaOx7Nq9If88lcqofOh7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367844; c=relaxed/simple;
	bh=YPsr5Pq7k1vS7h5HMMgXlpD7edabh+CirG56Z/Kajxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9GWYMeWvedIxGaLoOaTiwAmpynyvud43IZeDZ49SovBsdEXEtsxIWACwsdaj/EqTLZSDX0Q/gum8aw0Jh01tPGiydynV4aQVlziFl6kTCjtvKXE6Fab0zI6G9hQMckd5Vtxgs0L7uvmCiFDhEXDsqE1QSYXKdAS0/lYldLFOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: linux-wireless@vger.kernel.org
Cc: greearb@candelatech.com,
	miriam.rachel.korenblit@intel.com,
	johannes@sipsolutions.net,
	cole@unwrap.rs
Subject: [PATCH 2/3] wifi: iwlwifi: mld: fix TSO segmentation explosion when AMSDU is disabled
Date: Sat,  4 Apr 2026 22:41:44 -0700
Message-ID: <20260405054145.1064152-3-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405054145.1064152-1-cole@unwrap.rs>
References: <20260405054145.1064152-1-cole@unwrap.rs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34360-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unwrap.rs:email,unwrap.rs:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0059539D6DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the TLC notification disables AMSDU for a TID, the MLD driver sets
max_tid_amsdu_len to the sentinel value 1. The TSO segmentation path in
iwl_mld_tx_tso_segment() checks for zero but not for this sentinel,
allowing it to reach the num_subframes calculation:

  num_subframes = (max_tid_amsdu_len + pad) / (subf_len + pad)
                = (1 + 2) / (1534 + 2) = 0

This zero propagates to iwl_tx_tso_segment() which sets:

  gso_size = num_subframes * mss = 0

Calling skb_gso_segment() with gso_size=0 creates over 32000 tiny
segments from a single GSO skb. This floods the TX ring with ~1024
micro-frames (the rest are purged), creating a massive burst of TX
completion events that can lead to memory corruption and a subsequent
use-after-free in TCP's retransmit queue (refcount underflow in
tcp_shifted_skb, NULL deref in tcp_rack_detect_loss).

The MVM driver is immune because it checks mvmsta->amsdu_enabled before
reaching the num_subframes calculation. The MLD driver has no equivalent
bitmap check and relies solely on max_tid_amsdu_len, which does not
catch the sentinel value.

Fix this by detecting the sentinel value (max_tid_amsdu_len == 1) at the
existing check and falling back to non-AMSDU TSO segmentation. Also add
a WARN_ON_ONCE guard after the num_subframes division as defense-in-depth
to catch any future code paths that produce zero through a different
mechanism.

Suggested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index e341d12e5233..8af58aabcd68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -823,7 +823,7 @@ static int iwl_mld_tx_tso_segment(struct iwl_mld *mld, struct sk_buff *skb,
 		return -EINVAL;
 
 	max_tid_amsdu_len = sta->cur->max_tid_amsdu_len[tid];
-	if (!max_tid_amsdu_len)
+	if (!max_tid_amsdu_len || max_tid_amsdu_len == 1)
 		return iwl_tx_tso_segment(skb, 1, netdev_flags, mpdus_skbs);
 
 	/* Sub frame header + SNAP + IP header + TCP header + MSS */
@@ -835,6 +835,9 @@ static int iwl_mld_tx_tso_segment(struct iwl_mld *mld, struct sk_buff *skb,
 	 */
 	num_subframes = (max_tid_amsdu_len + pad) / (subf_len + pad);
 
+	if (WARN_ON_ONCE(!num_subframes))
+		return iwl_tx_tso_segment(skb, 1, netdev_flags, mpdus_skbs);
+
 	if (sta->max_amsdu_subframes &&
 	    num_subframes > sta->max_amsdu_subframes)
 		num_subframes = sta->max_amsdu_subframes;
-- 
2.52.0


