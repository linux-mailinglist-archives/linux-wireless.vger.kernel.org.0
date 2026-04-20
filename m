Return-Path: <linux-wireless+bounces-35073-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L6eAhs95mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35073-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:50:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9E42D83A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39CF73066A3A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06E13CF683;
	Mon, 20 Apr 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWUrYW5q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E842B726;
	Mon, 20 Apr 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691775; cv=none; b=f9nqq2a40lzchOv5ls0yNB/VSmz/AZJYRn28a+fsX6JMKIFwD1m2W9P6WSraShwASAVQBhmM2GCrnlfE960mMAW3hbhGNv7xEtUhHB91mnvQVkG52aS1AF1uYJk/jkl1t5w8fz31r6DwZvQe3CjluliaZU9k/0F/UWJGZEhWbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691775; c=relaxed/simple;
	bh=xbJ0IB4Q5cSCaWoM2HB+vF/YtYqGE5DEOWqKit9ysRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQdU7LTTul7fj5uqwZ3sozSo1+VrPRCLPgecELtxVYTK4Q7TJ81Qp5284g0a4q5giA8dKacE0DHSQgrSm/BqAq3vQkycD6/a0yUDGPXUgToPo0a+F8b1suDPAWctwyIeHvZHOPI7dywiMV53MihIs0rQRNBy05etVXIV7iLmo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWUrYW5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DCBC2BCB4;
	Mon, 20 Apr 2026 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691775;
	bh=xbJ0IB4Q5cSCaWoM2HB+vF/YtYqGE5DEOWqKit9ysRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWUrYW5qyClb6QL1MZUB4N9e/VrTz5Uo07MEuTNaLpoZZnXQBxcbiS6stVRystzjx
	 pRBEeLSftbhL6ozAQmg+BwDiV9xC0ctUrMx5uVGQ5hbcm8DKD1skfmNquymI0+Y7XB
	 c+auk1/zhWFtJgvKqsRs1YEr+3fjbT/RfX/udG4r8US9bJLFA22BG/vRtB9m4n505U
	 IbccAenmS9fyUB0qm6t6Gw0pG5GXKzinFe/czKAG9d0yA20MySpROYh7IGlv+Jtlo5
	 SwiYS8A8Is2KwLlbqb798APyyOxghesROU47EVzCWjEkGGlXNHYjQoZCqPwKQAidV/
	 dl0FX8YxInLWA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.12] wifi: mt76: mt7925: resolve link after acquiring mt76 mutex
Date: Mon, 20 Apr 2026 09:19:40 -0400
Message-ID: <20260420132314.1023554-186-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35073-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mediatek.com,nbd.name,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,mediatek.com:email,nbd.name:email]
X-Rspamd-Queue-Id: 67E9E42D83A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit beec58f36983f826fe90287a90edff46b32e8a89 ]

mt792x_sta_to_link() uses rcu_dereference_protected() and therefore
expects mt76.mutex to be held. Move the lookup after
mt792x_mutex_acquire() to make the locking explicit and correct.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20260306232238.2039675-12-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a thorough analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: `wifi: mt76: mt7925` (MediaTek MT7925 WiFi driver in
  the mt76 subsystem)
- **Action verb**: "resolve" — implies correcting something that was
  wrong
- **Summary**: Move the `mt792x_sta_to_link()` lookup after acquiring
  `mt76.mutex`, because the function uses `rcu_dereference_protected()`
  which requires that lock.

Record: [wifi: mt76: mt7925] [resolve/correct] [Fix locking order:
acquire mutex before RCU-protected dereference]

### Step 1.2: Tags
- **Signed-off-by**: Sean Wang <sean.wang@mediatek.com> — the author, a
  prominent mt76/mt7925 contributor
- **Link**: https://patch.msgid.link/20260306232238.2039675-12-
  sean.wang@kernel.org — patch 12 (of 20 messages, patch 11/19)
- **Signed-off-by**: Felix Fietkau <nbd@nbd.name> — the mt76 subsystem
  maintainer who applied the patch
- No Fixes: tag, no Reported-by:, no Cc: stable — expected for candidate
  review

Record: Author is Sean Wang (regular mt76 contributor), applied by the
mt76 maintainer Felix Fietkau. No explicit Fixes: or stable tags.

### Step 1.3: Commit Body Analysis
The body says: "`mt792x_sta_to_link()` uses
`rcu_dereference_protected()` and therefore expects `mt76.mutex` to be
held." This directly describes a locking contract violation. The fix:
"Move the lookup after `mt792x_mutex_acquire()`."

Record: Bug: calling `rcu_dereference_protected()` without holding the
required lock. Symptom: lockdep warning if `CONFIG_PROVE_LOCKING` is
enabled; potential race condition for MLO vifs where the RCU pointer
could be concurrently modified.

### Step 1.4: Hidden Bug Fix Detection
This IS a bug fix despite not using the word "fix" — the commit corrects
a lock ordering violation. The `rcu_dereference_protected()` API
explicitly expects the lock to be held, and calling it without it is
incorrect.

Record: Yes, this is a real bug fix — locking correctness violation.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **File**: `drivers/net/wireless/mediatek/mt76/mt7925/main.c`
- **Function**: `mt7925_mac_link_sta_assoc()`
- **Change**: 2 lines moved (net 0 lines added/removed — pure reorder)
- **Scope**: Single function, single file, surgical

Record: 1 file changed, ~4 lines reordered within one function. Scope:
trivially small.

### Step 2.2: Code Flow Change
**Before**: `msta` and `mlink` were resolved via `mt792x_sta_to_link()`
before `mt792x_mutex_acquire(dev)` was called.

**After**: `mt792x_mutex_acquire(dev)` is called first, then `msta` and
`mlink` are resolved.

The `msta` assignment (`(struct mt792x_sta *)link_sta->sta->drv_priv`)
does not need the lock, but moving it below the mutex acquire is
harmless and keeps the code cleaner.

### Step 2.3: Bug Mechanism
This is a **synchronization / locking correctness fix**. The function
`mt792x_sta_to_link()` uses:

```293:294:drivers/net/wireless/mediatek/mt76/mt792x.h
return rcu_dereference_protected(msta->link[link_id],
        lockdep_is_held(&msta->vif->phy->dev->mt76.mutex));
```

The `rcu_dereference_protected()` call asserts that `mt76.mutex` must be
held. Calling it without the lock is:
1. A lockdep assertion violation (runtime warning with
   `CONFIG_PROVE_LOCKING`)
2. A potential race: without the mutex, the `msta->link[link_id]` RCU
   pointer could be concurrently modified (e.g., during link teardown),
   leading to use-after-free.

Note: For non-MLD (non-WiFi-7-MLO) vifs, the function returns
`&msta->deflink` early without touching RCU, so the actual RCU race only
applies to MLO connections.

Record: Synchronization/locking fix. `rcu_dereference_protected()`
called without required mutex. Race window for concurrent link
modification on MLO vifs.

### Step 2.4: Fix Quality
- **Obviously correct**: Yes — just reorders two existing operations.
- **Minimal**: Yes — net zero lines changed.
- **Regression risk**: Essentially zero. The mutex is acquired slightly
  earlier but still released at the same point. No new code is added.

Record: Fix is trivially correct with no regression risk.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
From the git blame, the buggy code was introduced by commit
`89397bccc882a4` ("wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to
associate per-link STA") by Sean Wang, dated 2024-06-12. This commit
first appeared in `v6.11-rc1`.

Record: Buggy code introduced in 89397bccc882a4, first in v6.11-rc1.
Present in stable trees v6.11+.

### Step 3.2: Fixes Tag
No explicit Fixes: tag, but the bug was clearly introduced by
`89397bccc882a4`.

Record: The original commit created the function
`mt7925_mac_link_sta_assoc` with the lock ordering issue from day one.

### Step 3.3: File History
The file has had ~46 commits since v6.11. Several are related locking
fixes (e.g., `9f15701370ec1` "fix locking in
mt7925_change_vif_links()").

Record: Active file with other locking fixes. This is standalone.

### Step 3.4: Author
Sean Wang is a prolific contributor to mt76/mt7925 and the author of the
MLO link support. He's also the author of the original buggy commit, so
this is the author fixing their own oversight.

Record: Author is the subsystem developer who introduced the bug.

### Step 3.5: Dependencies
This is patch 11/19 in a series, but the fix itself is **self-
contained**: it only reorders existing lines within one function. It has
no dependency on any other patch in the series.

Record: Self-contained, no dependencies.

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1: Original Discussion
The patch was submitted as `[PATCH 11/19]` in a series titled "wifi:
mt76: mt7925: fix up MLO link lifetime and error handling". The series
includes a mix of refactoring and fixes. This specific patch is a pure
correctness fix.

Record: Part of a 19-patch series for MLO link lifetime improvements.
This patch is standalone.

### Step 4.2: Reviewers
The series was sent to `nbd@nbd.name` (Felix Fietkau, mt76 maintainer)
and `lorenzo.bianconi@redhat.com`. Applied by Felix Fietkau.

Record: Applied by subsystem maintainer.

### Step 4.3-4.5: Bug Reports / Stable Discussion
No specific bug report or syzbot link. No specific stable discussion
found. The kernel test robot reported build issues on patch 2/19 only,
not on this patch.

Record: No external bug reports. The issue is self-evident from code
inspection.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Key Functions
- `mt7925_mac_link_sta_assoc()` — the function being fixed
- `mt792x_sta_to_link()` — the inline function that requires the mutex

### Step 5.2: Callers
`mt7925_mac_link_sta_assoc()` is called from `mt7925_mac_sta_event()`
(line 1078), which is exported via `EXPORT_SYMBOL_GPL` and called during
station association events via the mac80211 callback path. This is a
common WiFi operational path.

### Step 5.4: Reachability
The code path is: mac80211 sta_event callback ->
`mt7925_mac_sta_event()` -> `mt7925_mac_link_sta_assoc()`. This is
triggered during WiFi association, which is a very common operation.

Record: The buggy code is on a common WiFi association path, reachable
during normal operation.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Presence in Stable Trees
- Buggy commit `89397bccc882a4` is NOT in v6.10 (verified)
- It IS in v6.11+ (verified: v6.11-rc1)
- Relevant stable trees: 6.11.y, 6.12.y, and any later LTS

### Step 6.2: Backport Complications
The patch is a trivial reorder of existing lines. It should apply
cleanly to any tree that has the buggy commit.

Record: Clean apply expected for all trees with the buggy code (v6.11+).

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem Criticality
- Subsystem: `drivers/net/wireless/mediatek/mt76/mt7925/` — WiFi driver
- Criticality: IMPORTANT — MediaTek MT7925 is a WiFi 7 chip used in many
  modern laptops
- The fix is specifically for the MLO (Multi-Link Operation) code path

Record: IMPORTANT subsystem — popular WiFi 7 chip. Bug affects MLO
connections.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Who Is Affected
Users of MediaTek MT7925 WiFi 7 hardware using MLO (Multi-Link
Operation). For non-MLO connections, `mt792x_sta_to_link()` takes the
early `deflink` return path and doesn't touch RCU.

### Step 8.2: Trigger Conditions
- Triggered during WiFi association with MLO
- Common operation for WiFi 7 users
- With `CONFIG_PROVE_LOCKING`: always triggers a warning
- Without: race window exists but may be hard to hit

### Step 8.3: Failure Mode Severity
- **With lockdep**: WARNING (lock assertion failure) — MEDIUM
- **Without lockdep**: Potential use-after-free if link is concurrently
  modified — HIGH (crash/corruption risk, though race window is small)

### Step 8.4: Risk-Benefit Ratio
- **Benefit**: Fixes locking correctness and prevents lockdep warnings +
  potential UAF for MLO users. LOW-MEDIUM benefit.
- **Risk**: Essentially ZERO risk — the fix is a trivial reorder of two
  existing operations.
- **Ratio**: Very favorable — zero risk for a real correctness fix.

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary

**FOR backporting:**
- Fixes a real locking correctness violation
  (`rcu_dereference_protected()` without lock)
- The fix is trivially correct — just reorders 2 lines
- Zero regression risk
- Self-contained, no dependencies on other patches
- Applied by subsystem maintainer
- Bug exists in stable trees v6.11+
- On a common WiFi association code path

**AGAINST backporting:**
- Part of a 19-patch series (though this patch is standalone)
- Primarily affects WiFi 7 MLO users (subset of mt7925 users)
- Without lockdep, the actual race is theoretically possible but hard to
  trigger
- No user reports or syzbot reports of the issue

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** — trivial reorder, applied by
   maintainer
2. Fixes a real bug? **YES** — locking correctness violation
3. Important issue? **MEDIUM** — lockdep warning + potential UAF race on
   MLO
4. Small and contained? **YES** — ~4 lines reordered in one function
5. No new features or APIs? **YES** — pure fix
6. Can apply to stable trees? **YES** — should apply cleanly to v6.11+

### Step 9.3: Exception Categories
Not an exception category — this is a standard bug fix.

### Step 9.4: Decision
The fix is a trivially correct locking fix with zero regression risk. It
fixes a real `rcu_dereference_protected()` locking violation that
triggers lockdep warnings and has a theoretical UAF race. While the
impact is limited to WiFi 7 MLO users, the fix is so small and safe that
the risk-benefit ratio strongly favors backporting.

---

## Verification

- [Phase 1] Parsed tags: Author is Sean Wang (MediaTek), applied by
  Felix Fietkau (mt76 maintainer)
- [Phase 2] Diff analysis: ~4 lines reordered in
  `mt7925_mac_link_sta_assoc()` — moves mutex_acquire before
  `mt792x_sta_to_link()`
- [Phase 2] Verified `mt792x_sta_to_link()` uses
  `rcu_dereference_protected()` with `lockdep_is_held(&mt76.mutex)` at
  lines 293-294 of mt792x.h
- [Phase 2] Verified `mt792x_mutex_acquire()` expands to
  `mutex_lock(&dev->mutex)` via `mt76_connac_mutex_acquire()` at line
  401 of mt76_connac.h
- [Phase 3] git blame: buggy code introduced by 89397bccc882a4 (Sean
  Wang, 2024-06-12)
- [Phase 3] git describe: buggy commit first appears in v6.11-rc1
- [Phase 3] git merge-base: confirmed NOT in v6.10, YES in v6.11 and
  v6.12
- [Phase 4] b4 mbox: found series cover "fix up MLO link lifetime and
  error handling" (19 patches)
- [Phase 4] This is patch 11/19, but is self-contained
- [Phase 5] `mt7925_mac_link_sta_assoc()` called from
  `mt7925_mac_sta_event()` (line 1078), triggered during WiFi
  association
- [Phase 6] Code exists in stable trees v6.11+
- [Phase 8] Failure mode: lockdep WARNING (MEDIUM) or potential UAF race
  on MLO (HIGH but hard to trigger)
- UNVERIFIED: Could not access lore.kernel.org directly due to anti-bot
  protection to check for reviewer comments on patch 11/19 specifically

**YES**

 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 38474cd2c38d6..caafac14d97ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1030,11 +1030,11 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 
+	mt792x_mutex_acquire(dev);
+
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 
-	mt792x_mutex_acquire(dev);
-
 	if (ieee80211_vif_is_mld(vif)) {
 		link_conf = mt792x_vif_to_bss_conf(vif, msta->deflink_id);
 	} else {
-- 
2.53.0


