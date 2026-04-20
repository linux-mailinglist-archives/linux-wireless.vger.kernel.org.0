Return-Path: <linux-wireless+bounces-35066-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC3eMDQ65mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35066-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:37:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889F42D42B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6B2352FD24
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DB401A17;
	Mon, 20 Apr 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLaVJudb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA83C2798;
	Mon, 20 Apr 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691613; cv=none; b=Bp33B5aiOtZ4OjHFhcq8I++HkRcUdbgcxYLhFdACQEW7+8nNxIL6q1hB+iXH+OK6jfsp7+HVtIpZHsjkWlT4XoJknmQLwJZPxvIAxwV4V9q6gbziFOlkK82g6RbrjWBg5WcU6GCM08bwhJ//VlmC4IcqF+9qBs1SgvumMbOlUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691613; c=relaxed/simple;
	bh=PPUIx66EefomAExyC7+f52diEldPURBFAue1OxHTY50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0O2vPJqeP0gqqItLXj6QAof2n/zC8I5IALAW8et5M2HbhXmAVJSvIO65mJAQUbu998uEZ/U6fJ+gqrcXU4ct9p5FpErm0HbaL6gK1CxoOs20IPmA475/kgaagwTFhbcPF+1upyqIeeS6eEx+wAahT5NxcSUgLtFmYnpIf4rvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLaVJudb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735F8C19425;
	Mon, 20 Apr 2026 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691613;
	bh=PPUIx66EefomAExyC7+f52diEldPURBFAue1OxHTY50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLaVJudbL3QP1gyJn1YUmrvDpFRg8xzQRT5e22+sixQCyZSkXSayP1BQTlbT/4QWY
	 20PDfisxNxypFdvEFh7lqFpvDAMuu1QDYAelAj6BNEES71mBFcx2I9CFpPFo4K3BaW
	 IyMYm2pfkDqNBSiHPRoN+M8TWlt3KJwasAbiiBTuXNaNe/muLUZPLUCQO9ybnSMkXI
	 BppOSwDyB2rayqaJ7E4hQzo0eOr9HCjR+J7gaNgrKKxcyvVss6/B4tp9ocV4k3PBsi
	 rYh4S+n0TYcvssOdxYWIULbZqHsVaOzMiFVHHE9c8d96y94kpFACxtQ9FIEyHq5f94
	 xpic9HESs9Mpg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: mt76: flush pending TX before channel switch
Date: Mon, 20 Apr 2026 09:18:46 -0400
Message-ID: <20260420132314.1023554-132-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35066-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 2889F42D42B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 0dcef1cbae27d806cd29c296cc03ad6e8ece771d ]

mt76_tx() queues frames on wcid->tx_pending for async processing by
tx_worker. In __mt76_set_channel(), the worker gets disabled before it
may have run, and the subsequent wait only checks DMA ring queues, not
the software pending list. This means frames like nullfunc PS frames
from mt76_offchannel_notify() may never be transmitted on the correct
channel.

Fix this by running mt76_txq_schedule_pending() synchronously after
disabling the tx_worker but before setting MT76_RESET, which would
otherwise cause mt76_txq_schedule_pending_wcid() to bail out.

Link: https://patch.msgid.link/20260309060730.87840-8-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Good. I now have a complete picture. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: wifi: mt76 (MediaTek WiFi driver)
- **Action verb**: "flush" — implies fixing missing work that should
  have been done
- **Summary**: Flush pending TX frames before channel switch to ensure
  they're sent on the correct channel

Record: [wifi: mt76] [flush] [Ensure pending TX frames are transmitted
before channel switch]

### Step 1.2: Tags
- **Link**:
  `https://patch.msgid.link/20260309060730.87840-8-nbd@nbd.name` — part
  of a series (patch 8)
- **Signed-off-by**: Felix Fietkau `<nbd@nbd.name>` — the mt76
  maintainer and original author

Record: No Fixes: tag (expected for autosel candidates). No Reported-by.
No Cc: stable. Author is subsystem maintainer. Part number "8" in msgid
suggests this is part of a series.

### Step 1.3: Commit Body Analysis
The commit clearly explains the bug:
- `mt76_tx()` queues frames on `wcid->tx_pending` for async processing
  by `tx_worker`
- In `__mt76_set_channel()`, the worker gets disabled *after*
  `MT76_RESET` is set
- `mt76_txq_schedule_pending_wcid()` bails out when `MT76_RESET` is set
  (line 626 of tx.c)
- The `wait_event_timeout` only checks DMA ring queues via
  `mt76_has_tx_pending()`, NOT the software pending list
- Result: Frames like nullfunc PS frames may never be transmitted on the
  correct channel

Record: Bug = TX frames lost during channel switch due to ordering issue
between MT76_RESET flag and tx_worker disable. Symptom = nullfunc power-
save frames not transmitted. Root cause = MT76_RESET set before
schedule_pending runs, causing bail-out.

### Step 1.4: Hidden Bug Fix Detection
This is an explicit bug fix, not disguised. The commit clearly describes
lost TX frames.

Record: Explicit bug fix — not a hidden fix.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **mac80211.c**: 3 lines reordered (moved `mt76_worker_disable` before
  `set_bit(MT76_RESET)`, added `mt76_txq_schedule_pending()` call)
- **mt76.h**: 1 line added (function declaration)
- **tx.c**: 1 line changed (`static void` → `void`)
- **Total**: ~5 lines of meaningful change
- **Functions modified**: `__mt76_set_channel()`,
  `mt76_txq_schedule_pending()` (visibility only)

Record: [3 files, ~5 lines changed] [__mt76_set_channel reordering,
mt76_txq_schedule_pending visibility] [Single-subsystem surgical fix]

### Step 2.2: Code Flow Change

**Before** (`__mt76_set_channel()`):
1. `set_bit(MT76_RESET, &phy->state)` — blocks
   `mt76_txq_schedule_pending_wcid`
2. `mt76_worker_disable(&dev->tx_worker)` — stops worker
3. `wait_event_timeout(... !mt76_has_tx_pending ...)` — only checks DMA
   queues

**After**:
1. `mt76_worker_disable(&dev->tx_worker)` — stops worker first
2. `mt76_txq_schedule_pending(phy)` — synchronously flush software
   pending list to DMA
3. `set_bit(MT76_RESET, &phy->state)` — now safe to set
4. `wait_event_timeout(... !mt76_has_tx_pending ...)` — DMA queues now
   include flushed frames

Record: Fix reorders operations so pending frames get flushed to DMA
rings before MT76_RESET blocks further processing.

### Step 2.3: Bug Mechanism
This is a **logic/ordering bug** leading to **TX frame loss**. The
`MT76_RESET` flag acts as a gate in `mt76_txq_schedule_pending_wcid()`
(line 626), and it was being set too early, preventing software-queued
frames from ever reaching the hardware.

Record: [Logic/ordering bug] [MT76_RESET set too early prevents software
TX queue flushing → frame loss]

### Step 2.4: Fix Quality
- Obviously correct: The reordering is logically sound — disable worker,
  flush pending, then set reset flag
- Minimal and surgical: ~5 lines changed
- Regression risk: Very low — the only new code path is calling
  `mt76_txq_schedule_pending()` synchronously, which already runs as
  part of `mt76_txq_schedule_all()` via the tx_worker. The worker is
  already disabled at this point, so no concurrency concern.

Record: [High quality fix, obviously correct, minimal scope, very low
regression risk]

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
The buggy code pattern (`set_bit` before `mt76_worker_disable`) was
introduced by:
- `f4fdd7716290a2` ("wifi: mt76: partially move channel change code to
  core") — v6.12
- `0b3be9d1d34e21` ("wifi: mt76: add separate tx scheduling queue for
  off-channel tx") — v6.12

These two commits together created the bug: one added the off-channel TX
pending mechanism, the other moved channel change code to core with the
wrong ordering.

Record: Bug introduced in v6.12 by commits f4fdd7716290a2 and
0b3be9d1d34e21.

### Step 3.2: Fixes Tag
No Fixes: tag present (expected for autosel). However, the bug clearly
traces back to `0b3be9d1d34e` — two related fixes (228bc0e79c852 and
49fba87205bec) already reference it with `Fixes:` tags.

Record: Related fixes 228bc0e79c852 and 49fba87205bec both fix
0b3be9d1d34e — this is a third fix for the same problematic commit.

### Step 3.3: File History
Related recent commits:
- `228bc0e79c852` (v6.14): "only enable tx worker after setting the
  channel" — Fixes: 0b3be9d1d34e
- `49fba87205bec`: "fix linked list corruption" — Fixes: 0b3be9d1d34e
- `bdeac7815629c`: "free pending offchannel tx frames on wcid cleanup"

Record: Multiple follow-up fixes to the same offchannel TX code. This
commit is standalone — only needs the pre-existing
mt76_txq_schedule_pending function.

### Step 3.4: Author
Felix Fietkau (`nbd@nbd.name`) is the mt76 subsystem maintainer and
original author of the driver. Very high confidence in fix correctness.

Record: Author is the mt76 maintainer — highest trust level.

### Step 3.5: Dependencies
- `mt76_txq_schedule_pending()` exists since v6.12 (commit 0b3be9d1d34e)
- `__mt76_set_channel()` exists since v6.14 (commit 82334623af0cd2)
- For v6.12 backport: function is called `mt76_set_channel()` with
  different context — needs adaptation
- For v6.14+/7.0: should apply cleanly or with minimal context
  adjustment
- Commit `228bc0e79c852` (v6.14) should ideally be present first, as it
  repositions `mt76_worker_enable()`. The v6.12 code has enable before
  `set_channel`, which was moved by that fix.

Record: Dependencies on 0b3be9d1d34e (present since v6.12) and
82334623af0cd2 (v6.14). For v6.12 backport, adaptation is needed.

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Step 4.1: Patch Discussion
b4 dig could not find the exact commit by the Link msgid. The msgid
suggests this is patch 8 of a series from Felix Fietkau dated
2026-03-09.

Record: Part of a larger series. Could not retrieve full lore discussion
due to lore anti-bot protections.

### Step 4.2: Reviewers
Felix Fietkau is both author and maintainer — self-reviewed. This is
normal for mt76 where he is the primary maintainer.

Record: Author is subsystem maintainer.

### Step 4.3-4.5: Bug Report
No Reported-by tag, no syzbot report. This appears to be found through
code review by the maintainer. No stable-specific discussion found.

Record: Found by maintainer code review.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.2: Key Functions
- `__mt76_set_channel()` — called from `mt76_set_channel()`
  (mac80211.c:1071) and `mt76_chanctx_assign_vif()` (channel.c:29)
- `mt76_set_channel()` is the mac80211 callback for channel changes
- This is called during every channel switch, scan, remain-on-channel —
  a **common operation**

### Step 5.3-5.4: Call Chain
`mac80211 → mt76_set_channel() → __mt76_set_channel()` — this is the
standard channel switch path, reachable during normal WiFi operation
(scanning, roaming, channel changes).

Record: Commonly triggered during WiFi scanning and channel switching.

### Step 5.5: Similar Patterns
The MT76_RESET bail-out pattern in `mt76_txq_schedule_pending_wcid()`
(line 626) is the direct cause. The same flag check exists in other TX
scheduling paths (lines 492, 546) which are also affected by the
ordering.

Record: MT76_RESET acts as gating mechanism in multiple TX paths.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Bug Existence in Stable
- **v6.6 and earlier**: Bug does NOT exist —
  `mt76_txq_schedule_pending()` and the offchannel TX mechanism weren't
  added until v6.12
- **v6.12**: Bug EXISTS — has both the offchannel TX pending mechanism
  and the wrong ordering in `mt76_set_channel()`
- **v6.14+**: Bug EXISTS — has `__mt76_set_channel()` with the wrong
  ordering

Record: Bug exists in v6.12+ stable trees.

### Step 6.2: Backport Complications
- **v7.0**: Should apply cleanly
- **v6.14**: Should apply cleanly or near-cleanly (function name same)
- **v6.12**: Needs adaptation — different function name
  (`mt76_set_channel` vs `__mt76_set_channel`), different surrounding
  code (mutex_lock, cancel_delayed_work), may also need 228bc0e79c852 as
  prerequisite

Record: Clean for v6.14+; needs rework for v6.12.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem Criticality
WiFi driver (mt76) — **IMPORTANT**. MediaTek MT76xx chipsets are
extremely common in consumer routers, laptops (mt7921/mt7922), and
access points (mt7915, mt7996). This is one of the most widely used WiFi
driver families in Linux.

Record: [drivers/net/wireless/mediatek/mt76] [IMPORTANT — very common
WiFi hardware]

### Step 7.2: Activity
Very active subsystem with frequent fixes from the maintainer.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All users of MT76-based WiFi devices (mt7603, mt76x0, mt76x2, mt7615,
mt7915, mt7921/mt7922, mt7996) — a very large user base including laptop
users, router users, and embedded systems.

Record: [Driver-specific but very widely used]

### Step 8.2: Trigger Conditions
- Triggered during any channel switch (scanning, roaming, offchannel
  operations)
- WiFi scanning happens automatically and frequently
- The bug window is when frames are queued on `tx_pending` just before a
  channel switch

Record: [Common trigger — scanning happens regularly on all WiFi
devices]

### Step 8.3: Failure Mode
- TX frame loss — nullfunc PS frames not transmitted → AP may not know
  client is going off-channel → potential packet loss, connectivity
  issues
- Not a crash, but a functional correctness issue affecting WiFi
  reliability

Record: [Failure mode: TX frame loss during channel switch] [Severity:
MEDIUM-HIGH — affects WiFi reliability]

### Step 8.4: Risk-Benefit
- **Benefit**: Fixes TX frame loss during channel switch on widely-used
  WiFi hardware. Medium-high benefit.
- **Risk**: Very low — 5 lines of reordering, obviously correct,
  authored by maintainer
- **Ratio**: Strong benefit, minimal risk

Record: [Benefit: medium-high] [Risk: very low] [Favorable ratio]

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence

**FOR backporting**:
- Fixes a real bug: TX frames lost during channel switch
- Small, surgical fix: ~5 lines of meaningful change
- Authored by the mt76 maintainer (Felix Fietkau)
- Affects widely-used WiFi hardware
- Common trigger (WiFi scanning)
- Obviously correct: just reordering operations and adding a synchronous
  flush
- Very low regression risk
- Related to same code that already has two other Fixes: tagged commits

**AGAINST backporting**:
- No Fixes: tag (expected for autosel)
- No Reported-by (found by maintainer review)
- Part of a larger series (patch 8) — but the fix is self-contained
- v6.12 backport would need adaptation
- Not a crash — "just" frame loss (but impacts WiFi reliability)

### Step 9.2: Stable Rules Checklist
1. Obviously correct? **YES** — ordering fix is straightforward
2. Fixes a real bug? **YES** — TX frame loss during channel switch
3. Important issue? **YES** — WiFi reliability on common hardware
4. Small and contained? **YES** — ~5 lines across 3 files in same
   subsystem
5. No new features? **YES** — just fixes ordering
6. Can apply to stable? **YES** for v6.14+; **needs rework** for v6.12

### Step 9.3: Exception Categories
Not an exception category — this is a straightforward bug fix.

### Step 9.4: Decision
The fix addresses a real TX frame loss bug during WiFi channel switching
on widely-used MT76 hardware. It is small, obviously correct, authored
by the subsystem maintainer, and carries minimal regression risk. The
bug affects WiFi reliability for a large user base.

---

## Verification

- [Phase 1] Parsed tags: Link to patch.msgid.link, Signed-off-by Felix
  Fietkau (mt76 maintainer)
- [Phase 2] Diff analysis: Reorders
  set_bit(MT76_RESET)/mt76_worker_disable, adds
  mt76_txq_schedule_pending() call, makes function non-static
- [Phase 2] Confirmed MT76_RESET bail-out at tx.c line 626:
  `test_bit(MT76_RESET, &phy->state)` causes schedule_pending_wcid to
  return -1
- [Phase 2] Confirmed mt76_has_tx_pending() only checks DMA queues
  (q->queued), not software pending list
- [Phase 3] git blame: `set_bit(MT76_RESET)` ordering from
  f4fdd7716290a2 (v6.12), offchannel pending from 0b3be9d1d34e21 (v6.12)
- [Phase 3] git show 228bc0e79c852: Related fix "only enable tx worker
  after setting the channel", Fixes: 0b3be9d1d34e (v6.14)
- [Phase 3] git show 49fba87205bec: Related fix "fix linked list
  corruption", Fixes: 0b3be9d1d34e
- [Phase 3] Confirmed __mt76_set_channel() introduced in 82334623af0cd2
  (v6.14)
- [Phase 3] Felix Fietkau confirmed as mt76 maintainer via git log
  --author
- [Phase 5] mt76_txq_schedule_pending called from mt76_txq_schedule_all
  → mt76_tx_worker_run → tx_worker — normal TX path
- [Phase 6] Confirmed mt76_txq_schedule_pending does NOT exist in v6.6
  (bug not present pre-v6.12)
- [Phase 6] Confirmed v6.12 has the same bug pattern (set_bit before
  worker_disable, no schedule_pending call)
- [Phase 6] v6.12 uses `mt76_set_channel()` not `__mt76_set_channel()` —
  backport needs adaptation
- UNVERIFIED: Could not access lore.kernel.org discussion thread due to
  anti-bot protections

**YES**

 drivers/net/wireless/mediatek/mt76/mac80211.c | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d0c522909e980..73d252e0a7bf3 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1030,9 +1030,10 @@ int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 	int timeout = HZ / 5;
 	int ret;
 
-	set_bit(MT76_RESET, &phy->state);
-
 	mt76_worker_disable(&dev->tx_worker);
+	mt76_txq_schedule_pending(phy);
+
+	set_bit(MT76_RESET, &phy->state);
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
 	mt76_update_survey(phy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d05e83ea1cacc..7bba0831bc0eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1518,6 +1518,7 @@ void mt76_stop_tx_queues(struct mt76_phy *phy, struct ieee80211_sta *sta,
 void mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb);
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
 void mt76_txq_schedule_all(struct mt76_phy *phy);
+void mt76_txq_schedule_pending(struct mt76_phy *phy);
 void mt76_tx_worker_run(struct mt76_dev *dev);
 void mt76_tx_worker(struct mt76_worker *w);
 void mt76_release_buffered_frames(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 0753acf2eccb8..ab62591b7a260 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -660,7 +660,7 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
 	return ret;
 }
 
-static void mt76_txq_schedule_pending(struct mt76_phy *phy)
+void mt76_txq_schedule_pending(struct mt76_phy *phy)
 {
 	LIST_HEAD(tx_list);
 	int ret = 0;
-- 
2.53.0


