Return-Path: <linux-wireless+bounces-31970-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IpSHmEJlmldYwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31970-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 19:48:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00742158CFD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB5803004C24
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB4258ED4;
	Wed, 18 Feb 2026 18:47:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD73009DE
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440478; cv=none; b=UEK1rVlz3WraLdEn4IqiodTCOWAxaOwNoSApoGVpvzlbc/1vn4FVif5mNVgYO9FZXLEloRai4e9DK6ApJ8Pgkl0XhjUrkXyHzT/SvXjkLNxUzc3F/0bO5NHbWfyxtt272WhpSF2uc7hediJ/JRSXIZndZGExbykpLbjUgtJM4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440478; c=relaxed/simple;
	bh=0LrHsHHQ7iSGgU3vLyN+JsxLWcPoykD9UQTWrIgo+sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1allnlabQnENHnqteZRvTnm6WxMFaqlf5xb0C1RKaZP+KfWTmTY+XCftNKto3PO7UNb+rsLxgHWQgGeJjwBPFnyWbN/BDpbwsi5+mX0N2HlpnPoY0OGh+ZisXl4SXbN2zk8zauUz777B422Nmqul915yizY8n17fQdm1anZBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: prevent NAPI processing after firmware error
Date: Wed, 18 Feb 2026 11:47:49 -0700
Message-ID: <20260218184749.22675-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <7f72ac08-6b4a-486b-a8f9-7b78ea0f5ae1@candelatech.com>
References: <7f72ac08-6b4a-486b-a8f9-7b78ea0f5ae1@candelatech.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31970-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00742158CFD
X-Rspamd-Action: no action

Ben,

Thanks for the historical context. I dug through the git history and
your linux-ct repos to verify exactly what happened when. I want to
make sure I have this right - can you confirm whether this matches
what you saw?

2018 Bug (Bug 199209)
---------------------
Fixed by Emmanuel in commit 0eac9abace16 ("iwlwifi: mvm: fix TX of
AMSDU with fragmented SKBs"). That was a different trigger - NFS
created highly fragmented SKBs where nr_frags was so high that the
buffer descriptor limit check produced num_subframes=0. Emmanuel's
fix clamps that path to 1.

Current MLD Bug
---------------
Different path to the same symptom. When TLC disables AMSDU for a
TID, both MVM and MLD set max_tid_amsdu_len[tid] = 1 as a sentinel
value. The key difference in protection:

MVM has a private mvmsta->amsdu_enabled bitmap that gates the entire
AMSDU path:

    if (!mvmsta->amsdu_enabled)
        return iwl_tx_tso_segment(skb, 1, ...);  // bail out early

    if (!(mvmsta->amsdu_enabled & BIT(tid)))
        return iwl_tx_tso_segment(skb, 1, ...);  // bail out early

MVM never reads max_tid_amsdu_len in its TX path - it uses its own
mvmsta->max_amsdu_len. This bitmap was added in commit 84226ca1c5d3
("iwlwifi: mvm: enable AMSDU for all TIDs", Nov 2017).

MLD was designed to use mac80211's sta->cur->max_tid_amsdu_len
directly, with no equivalent bitmap:

    max_tid_amsdu_len = sta->cur->max_tid_amsdu_len[tid];
    if (!max_tid_amsdu_len)  // only catches 0, not sentinel 1!
        return iwl_tx_tso_segment(skb, 1, ...);

    num_subframes = (max_tid_amsdu_len + pad) / (subf_len + pad);
    // When max_tid_amsdu_len=1: num_subframes = (1 + 3) / (1534 + 3) = 0

What I found in your repos:

  - linux-ct-6.5-be200, linux-ct-6.10, linux-ct-6.14: No MLD driver,
    only MVM with amsdu_enabled bitmap protection
  - linux-ct-6.15, linux-ct-6.18: Have MLD driver
    (drivers/net/wireless/intel/iwlwifi/mld/)
  - backport-iwlwifi: MLD tx.c first appeared in commit 56f903a89
    (2024-07-17)

So MVM should have been immune to this specific sentinel-value bug
due to the bitmap check.

Question for you: When you saw TSO segment explosions in 2024, what
kernel and driver were you using? If it was one of your 6.5-6.14
kernels with MVM, then there may be a different path to
num_subframes=0 that I haven't identified yet. If you were using
backport-iwlwifi with MLD enabled, that would explain it hitting the
same bug I'm fixing now.

The commit ae6d30a71521 (Feb 2024) added better error reporting for
skb_gso_segment failures, which suggests people were hitting GSO
segment errors around that time - but I don't have visibility into
what specific trigger you hit.

My fix catches the sentinel-induced zero after the calculation, which
is equivalent to what MVM's bitmap check accomplishes. This should
prevent the current MLD bug from reaching skb_gso_segment with
gso_size=0.

Looking forward to your test results with the problem AP, and any
clarification on what setup you were using in 2024.

Cole

