Return-Path: <linux-wireless+bounces-35044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL/dEGUn5mm6sgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:17:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B877D42B7BF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7375D301DA70
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93D3A3E68;
	Mon, 20 Apr 2026 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1bt9X/Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1F3A3E66;
	Mon, 20 Apr 2026 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690952; cv=none; b=Oyu54klH+NoylzmQzeFL0gri7H9tgqjAiLHS+mT4s08ZMC50PCOeyYyRRlRptFftfM9fiYXEf1H9KT1EwU9ENtNmk0YxLm7KTWAYoFEWevG6zXdRlD6ZF3FrwiyhTI/y5sWEUBjZZY4UhsqIivbHI6D6lPkX2L/jwSqio9Jh7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690952; c=relaxed/simple;
	bh=VWOTnYN/a6Qya2C8TW2lWsYuvseWE56Cy8ZSZjxYK7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNxVPuLWTIBcdA9Mh5IFXVM6XpgjZmRBK7wcO/BbBv0YZAs3ag9aRoZigDorcNch9i2iRpzRy+cZT5rBgM60Qv41P2l24IgM8etc+KmwWBH/iUh/rjF03BzUAoxKbC8TuFQKt9QjZFrHfiG4OiPu0t2zoTn6uC4GQ3YOectjEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1bt9X/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9543C19425;
	Mon, 20 Apr 2026 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690952;
	bh=VWOTnYN/a6Qya2C8TW2lWsYuvseWE56Cy8ZSZjxYK7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1bt9X/Q5cLFwDWpmuJyUIAvwwhuq67TeWS5A+fjoAxCPeod0V12cXARBloMbe+71
	 GzLhmIEyaqcKRr34ceUzV7MMKfhazT3Urk/2pSdoLkQF7oairQov1uhn1OX37dmY/r
	 1jvyOaueM8yPUATn9TD7B4K0COdQWwz8CIMtdoVvAYyoLVpPrAwzDfGD9Fq7XODAx/
	 2IwlemSu6KMD4RCoZ+/AUrJ9s1hyoZRWuth73YAF5SVLiafhZr0FzhN/67l/YAPVH6
	 nVqDjEBIUP0vzuRHie2gM2SZbI5XC6t6AqJyze17iL2EOvbIBX8/ef4utSCEEiVGWG
	 GTzK9zj1Ah6tg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: David Bauer <mail@david-bauer.net>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: mt76: don't return TXQ when exceeding max non-AQL packets
Date: Mon, 20 Apr 2026 09:07:54 -0400
Message-ID: <20260420131539.986432-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35044-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[david-bauer.net,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nbd.name:email]
X-Rspamd-Queue-Id: B877D42B7BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Bauer <mail@david-bauer.net>

[ Upstream commit 964f870e090e9c88a41e2890333421204cc0bdf4 ]

mt76_txq_send_burst does check if the number of non-AQL frames exceeds
the maximum. In this case the queue is returned to ieee80211_return_txq
when iterating over the scheduled TXQs in mt76_txq_schedule_list.

This has the effect of inserting said TXQ at the head of the list. This
means the loop will get the same TXQ again, which will terminate the
scheduling round. TXQs following in the list thus never get scheduled
for transmission.

This can manifest in high latency low throughput or broken connections
for said STAs.

Check if the non-AQL packet count exceeds the limit and not return the
TXQ in this case.
Schedule all TXQs for the STA in case the non-AQL limit can be satisfied
again.

Signed-off-by: David Bauer <mail@david-bauer.net>
Link: https://patch.msgid.link/20260129232321.276575-1-mail@david-bauer.net
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I now have all the information needed for a complete analysis. Let me
compile my findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: `wifi: mt76:` (MediaTek mt76 WiFi driver)
- **Action verb**: "don't return" — indicates preventing incorrect
  behavior, i.e., a bug fix
- **Summary**: Don't return TXQ to mac80211 scheduler when the non-AQL
  packet limit is exceeded

### Step 1.2: Tags
- **Signed-off-by**: David Bauer (author), Felix Fietkau
  (committer/maintainer)
- **Link**:
  `https://patch.msgid.link/20260129232321.276575-1-mail@david-
  bauer.net`
- No Fixes: tag, no Cc: stable, no Reported-by — all expected for a
  commit under review
- Felix Fietkau (nbd@nbd.name) is the mt76 subsystem maintainer who
  merged this

### Step 1.3: Commit Body
- **Bug described**: When `mt76_txq_send_burst` detects non-AQL packets
  exceeding the limit, it returns 0. The TXQ is then returned to
  mac80211 via `ieee80211_return_txq()`, which re-inserts it at the head
  of the scheduling list (with airtime fairness). On the next iteration,
  `ieee80211_next_txq()` sees the same TXQ with its round number already
  set, returns NULL, and terminates the scheduling round.
- **Symptom**: "high latency low throughput or broken connections for
  said STAs" — TXQs following the problematic one in the list never get
  scheduled.
- **Root cause**: TXQ scheduling starvation due to improper return of
  rate-limited TXQs

### Step 1.4: Hidden Bug Fix Detection
This is an explicit, clearly-described bug fix for a scheduling
starvation issue.

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed**: 1 file — `drivers/net/wireless/mediatek/mt76/tx.c`
- **Changes**: ~20 lines added, 0 removed (two code additions)
- **Functions modified**: `mt76_tx_check_non_aql()`,
  `mt76_txq_schedule_list()`
- **Scope**: Single-file, surgical fix in two specific functions

### Step 2.2: Code Flow Changes

**Hunk 1** (`mt76_tx_check_non_aql`):
- **Before**: Decrements `non_aql_packets` on tx completion, clamps to 0
  if negative, returns
- **After**: Same, plus: when `pending == MT_MAX_NON_AQL_PKT - 1` (count
  just dropped below limit), reschedules all TXQs for the STA via
  `ieee80211_schedule_txq()`. This ensures TXQs that were dropped from
  the scheduling list get re-added.

**Hunk 2** (`mt76_txq_schedule_list`):
- **Before**: After getting a TXQ from `ieee80211_next_txq()`, checks PS
  flag and reset state, then proceeds to `mt76_txq_send_burst()` which
  may early-return if non-AQL limit is hit. Then always calls
  `ieee80211_return_txq()`.
- **After**: Adds a check `if (atomic_read(&wcid->non_aql_packets) >=
  MT_MAX_NON_AQL_PKT) continue;` — skips the TXQ without returning it to
  the scheduler, allowing the loop to proceed to the next TXQ.

### Step 2.3: Bug Mechanism
This is a **logic/scheduling correctness bug**. The mac80211 TXQ
scheduler has specific round-tracking semantics:
- `ieee80211_next_txq()` removes the TXQ and marks its round number
- `ieee80211_return_txq()` re-inserts it (at HEAD with airtime fairness)
- A subsequent `ieee80211_next_txq()` seeing the same TXQ's round number
  → returns NULL, ending the round

When a non-AQL-limited TXQ is returned to the list, it poisons the
scheduling round and starves all subsequent TXQs.

### Step 2.4: Fix Quality
- **Obviously correct**: Yes — the `continue` pattern is already used in
  this function for PS flag and reset state checks
- **Minimal/surgical**: Yes — two small additions, no unrelated changes
- **Regression risk**: Very low — not returning a rate-limited TXQ is
  correct; the rescheduling on tx completion ensures it gets re-added
  when appropriate

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
- `mt76_tx_check_non_aql()` — core logic introduced by `e1378e5228aaa1`
  (Felix Fietkau, 2020-08-23), refactored in `0fe88644c06063`
  (2021-05-07)
- `mt76_txq_schedule_list()` — scheduling loop from `17f1de56df0512`
  (2017-11-21), with non-AQL logic from `e1378e5228aaa1`
- The non-AQL mechanism itself was introduced in commit `e1378e5228aaa1`
  which first appeared in **v5.10-rc1**

### Step 3.2: Fixes Tag
No Fixes: tag present. However, the bug was effectively introduced by
`e1378e5228aaa1` ("mt76: rely on AQL for burst size limits on tx
queueing") in v5.10-rc1.

### Step 3.3: File History
- `tx.c` has had 19 commits since v6.1, including multi-radio support
  (`716cc146d5805`, Jan 2025) and wcid pointer wrapper (`dc66a129adf1f`,
  Jul 2025)
- This patch is standalone — not part of a series

### Step 3.4: Author
- David Bauer: occasional mt76 contributor (5 commits found), has worked
  on mt7915 MCU and other mt76 issues
- Felix Fietkau: mt76 subsystem maintainer who reviewed and merged this

### Step 3.5: Dependencies
- The `continue` in scheduling loop follows the existing pattern (PS
  flag, reset state already use `continue`)
- The rescheduling uses `ieee80211_schedule_txq()` — available since
  mac80211 TXQ API inception
- `wcid_to_sta()` — fundamental mt76 helper, present in all trees
- Minor adaptations needed for older trees (e.g., `__mt76_wcid_ptr` vs
  `rcu_dereference`)

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1–4.5
b4 dig couldn't find the message-id, and lore.kernel.org is blocking
automated access. The patch link is
`https://patch.msgid.link/20260129232321.276575-1-mail@david-bauer.net`.
It was merged by Felix Fietkau (mt76 maintainer), which provides strong
implicit review. No NAKs or objections were found.

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Functions Modified
1. `mt76_tx_check_non_aql()` — called from `__mt76_tx_complete_skb()` on
   every TX completion
2. `mt76_txq_schedule_list()` — core TX scheduling loop, called from
   `mt76_txq_schedule()`

### Step 5.2: Callers
- `mt76_tx_check_non_aql()` → called from `__mt76_tx_complete_skb()`
  which is the main TX completion path for ALL mt76 drivers
- `mt76_txq_schedule_list()` → called from `mt76_txq_schedule()` →
  `mt76_txq_schedule_all()` → `mt76_tx_worker_run()` — the main TX
  worker

### Step 5.3–5.4: Call Chain
TX completion path: hardware IRQ → driver tx_complete →
`__mt76_tx_complete_skb()` → `mt76_tx_check_non_aql()` → (new)
`ieee80211_schedule_txq()`. This is a very hot, commonly-exercised path.

### Step 5.5: Similar Patterns
The existing `continue` statements in `mt76_txq_schedule_list()` for PS
flag and reset state already follow the exact same pattern of skipping
TXQs without returning them.

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Buggy Code in Stable
The non-AQL mechanism (`e1378e5228aaa1`) was introduced in v5.10-rc1.
All active stable trees (5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y) contain
the buggy code.

### Step 6.2: Backport Complications
- The multi-radio refactoring (`716cc146d5805`, Jan 2025) and wcid_ptr
  wrapper (`dc66a129adf1f`, Jul 2025) are post-6.12
- Older trees will need minor adaptation (e.g., different wcid lookup
  syntax)
- The core logical change applies cleanly to all trees conceptually

### Step 6.3: No Related Fixes in Stable
No existing fix for this scheduling starvation issue was found in
stable.

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem Criticality
- **Subsystem**: `drivers/net/wireless/mediatek/mt76` — one of the most
  widely-used WiFi driver families in Linux
- **Criticality**: IMPORTANT — mt76 covers MT7603, MT7615, MT7915,
  MT7921, MT7996 chipsets used in routers, laptops, and access points
- This affects ALL mt76 devices, not just a specific chipset

### Step 7.2: Subsystem Activity
Active development — 30 commits in recent history for tx.c alone.

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All users of mt76 WiFi hardware (very broad: routers, embedded systems,
laptops). mt76 is one of the most popular WiFi driver families in the
Linux kernel.

### Step 8.2: Trigger Conditions
- Trigger: Multiple STAs connected, one STA hitting the non-AQL packet
  limit (common during bursts before rate control information is
  available, or under load)
- With airtime fairness enabled (default in many configurations):
  immediate starvation of all other STAs in the same AC
- Very likely to trigger in multi-client AP scenarios (routers, access
  points)

### Step 8.3: Failure Mode Severity
- **Failure mode**: High latency, low throughput, or broken connections
  for affected STAs
- **Severity**: HIGH — loss of connectivity/severe degradation for WiFi
  clients in multi-client scenarios

### Step 8.4: Risk-Benefit
- **Benefit**: HIGH — fixes scheduling starvation affecting all mt76
  users with multiple clients
- **Risk**: VERY LOW — ~20 lines, follows existing patterns, single
  file, obviously correct, merged by subsystem maintainer
- **Ratio**: Strongly favorable for backporting

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary
**FOR backporting:**
- Fixes a real, user-visible bug (high latency, broken connections)
- Affects all mt76 WiFi users with multiple clients — very broad impact
- Small, surgical fix (~20 lines, single file)
- Follows existing code patterns (`continue` for TXQ skipping)
- Merged by subsystem maintainer (Felix Fietkau)
- Bug exists in all stable trees since v5.10
- No regression risk — the fix is obviously correct

**AGAINST backporting:**
- No Fixes: tag or Cc: stable (expected)
- Minor adaptation needed for older trees due to intermediate
  refactoring
- No syzbot/KASAN report (this is a logic/scheduling bug, not memory
  safety)

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** — merged by maintainer, follows
   established patterns
2. Fixes a real bug? **YES** — scheduling starvation causing high
   latency/broken connections
3. Important issue? **YES** — connectivity loss for WiFi clients in
   common multi-client scenarios
4. Small and contained? **YES** — ~20 lines, single file, two functions
5. No new features or APIs? **YES** — no new features
6. Can apply to stable? **YES** — with minor adaptation for older trees

### Step 9.3: Exception Categories
Not an exception category — this is a standard bug fix.

### Step 9.4: Decision
This is a clear bug fix for a significant scheduling starvation issue in
the mt76 WiFi driver. The fix is small, obviously correct, and addresses
a real user-visible problem (high latency, low throughput, broken
connections) that affects all mt76 WiFi users in multi-client scenarios.

## Verification

- [Phase 1] Parsed tags: Signed-off-by David Bauer (author) and Felix
  Fietkau (maintainer/committer), Link to patch.msgid.link
- [Phase 2] Diff analysis: ~20 lines added in two functions in tx.c;
  adds non-AQL limit check in scheduling loop + TXQ rescheduling on tx
  completion
- [Phase 2] Verified `ieee80211_return_txq()` calls
  `__ieee80211_schedule_txq()` which re-inserts at head with airtime
  fairness (net/mac80211/tx.c lines 4116-4151)
- [Phase 2] Verified `ieee80211_next_txq()` terminates round when seeing
  same TXQ's schedule_round (net/mac80211/tx.c lines 4103-4104)
- [Phase 3] git blame: non-AQL logic introduced in e1378e5228aaa1
  (2020-08-23), first in v5.10-rc1
- [Phase 3] git describe: confirmed e1378e5228aaa1 is
  `v5.10-rc1~107^2~150^2~2^2~34`
- [Phase 3] Existing `continue` pattern verified in
  mt76_txq_schedule_list() for PS flag (line 542-543) and reset state
  (line 546-547)
- [Phase 3] No dependent patches found; this is standalone
- [Phase 4] b4 dig: could not find match; lore blocked by anti-scraping
- [Phase 5] mt76_tx_check_non_aql called from __mt76_tx_complete_skb
  (hot TX completion path, line 255)
- [Phase 5] mt76_txq_schedule_list called from mt76_txq_schedule →
  mt76_txq_schedule_all → mt76_tx_worker_run (main TX worker)
- [Phase 6] Bug present in all stable trees 5.10.y through 6.12.y
  (e1378e5228aaa1 in v5.10-rc1)
- [Phase 6] Backport needs minor adaptation for multi-radio refactoring
  (716cc146d5805) and wcid_ptr wrapper (dc66a129adf1f)
- [Phase 8] Failure mode: scheduling starvation → high latency/broken
  connections; severity HIGH
- UNVERIFIED: Exact mailing list review discussion (lore blocked);
  however, maintainer merge provides implicit review confirmation

**YES**

 drivers/net/wireless/mediatek/mt76/tx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 9ec6d0b53a84a..0753acf2eccb8 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -227,7 +227,9 @@ mt76_tx_check_non_aql(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		      struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_sta *sta;
 	int pending;
+	int i;
 
 	if (!wcid || info->tx_time_est)
 		return;
@@ -235,6 +237,17 @@ mt76_tx_check_non_aql(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	pending = atomic_dec_return(&wcid->non_aql_packets);
 	if (pending < 0)
 		atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
+
+	sta = wcid_to_sta(wcid);
+	if (!sta || pending != MT_MAX_NON_AQL_PKT - 1)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		if (!sta->txq[i])
+			continue;
+
+		ieee80211_schedule_txq(dev->hw, sta->txq[i]);
+	}
 }
 
 void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb,
@@ -542,6 +555,9 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 		if (!wcid || test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 			continue;
 
+		if (atomic_read(&wcid->non_aql_packets) >= MT_MAX_NON_AQL_PKT)
+			continue;
+
 		phy = mt76_dev_phy(dev, wcid->phy_idx);
 		if (test_bit(MT76_RESET, &phy->state) || phy->offchannel)
 			continue;
-- 
2.53.0


