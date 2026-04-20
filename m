Return-Path: <linux-wireless+bounces-35068-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJqYDnE65mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35068-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:38:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165042D482
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDC1C310FA92
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFA40245C;
	Mon, 20 Apr 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeS95bvE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F6402BA3;
	Mon, 20 Apr 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691620; cv=none; b=Cti4NFZ1cvJQn6fSzr2/AYq8lIpxzWgTmNH2gO4+8zVnyizSCEOT71ewcO50i3ZsZG3JT0S2+U2El31yQKT9F8fLkZ1pau5f7ryFTIY6ZSDeZZBtCGd3eLDNxPfKIyF0zR1vv2TgJXKdZw+0O+QiC5yD6iZ44b7DQb5SYUGPsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691620; c=relaxed/simple;
	bh=qV8xRHZhKgPeo4Q3n8lJGd1yBozXqX+gfLWGeX9tvfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9LKq/PmApvczF93DkCVE4VrBdzB3pJYDhopo4hzMsmv2jMjhnS/v/Z7qAmHaiG51B/qJxN+QZuhP46wyYeKw7QIRk6EF+0YQIuJcr/0P1Q3njMv6a9BQ50Q3g5ipli0+hclblYzOqA4JLR+r6hckQ+Epysy2khhiwihVSb0nt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeS95bvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C94C2BCB7;
	Mon, 20 Apr 2026 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691620;
	bh=qV8xRHZhKgPeo4Q3n8lJGd1yBozXqX+gfLWGeX9tvfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeS95bvEH9FExRQjUvbW4UVKml2bItvScSj+lISCloJboZ9rESz5yQwtCR4OQhmY6
	 hx7ZlkRaT4yhR8yIor4gx5FOIhaz0fYgiKDrR5ymZsHssXjW10Rdxoe+8sL4GPQdi7
	 C/kMJnWEB7EljKWKlcmtR2TP7Ul8ueRjD1Pg7TqN1yeIRh8u8w4h6JSZZQZrx9m1Zd
	 sHS+g5gsaoG3Ug/+Mza59ITaZE7ikBWLwwcp+hR+Cy8nc64kgRa+mS6OL9SzLHMSZK
	 oJz+bZNb/SfYiTWEiVNvsvdvNum+KBfTA8jREva1YzQRWb2tSx40b4F1MxD+9Irv7Q
	 O95bGRSCsweZg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
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
Subject: [PATCH AUTOSEL 7.0-6.12] wifi: mt76: add missing lock protection in mt76_sta_state for sta_event callback
Date: Mon, 20 Apr 2026 09:18:50 -0400
Message-ID: <20260420132314.1023554-136-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[u.northwestern.edu,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-35068-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.942];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nbd.name:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8165042D482
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit f0168f2f9a1eca55d3ae09d8250b94e82b67cac3 ]

mt76_sta_state() calls the sta_event callback without holding dev->mutex.
However, mt7915_mac_sta_event() (MT7915 implementation of this callback)
calls mt7915_mac_twt_teardown_flow() which has
lockdep_assert_held(&dev->mt76.mutex) indicating that callers must
hold this lock.

The locking pattern in mt76_sta_state() is inconsistent:
- mt76_sta_add() acquires dev->mutex before calling dev->drv->sta_add
- mt76_sta_remove() acquires dev->mutex before calling __mt76_sta_remove
- But sta_event callback is called without acquiring the lock

Add mutex_lock()/mutex_unlock() around the mt7915_mac_twt_teardown_flow
invocation to fix the missing lock protection and maintain consistency
with the existing locking pattern.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Link: https://patch.msgid.link/20260131035210.2198259-1-n7l8m4@u.northwestern.edu
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now let me complete the systematic analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mt76:` (MediaTek mt76 wireless driver)
- Action verb: "add missing" - indicates fixing a gap in existing code
- Summary: Adding lock protection around `sta_event` callback for TWT
  teardown

Record: [wifi: mt76 (mt7915)] [add missing lock] [Fix missing mutex
around mt7915_mac_twt_teardown_flow call in disassoc path]

**Step 1.2: Tags**
- Signed-off-by: Ziyi Guo (author)
- Link: patch.msgid.link (standard patch submission link)
- Signed-off-by: Felix Fietkau (mt76 maintainer who applied the patch)
- No Fixes: tag (expected for manual review)
- No Cc: stable (expected)
- No Reported-by (found via code analysis, not user report)

Record: Applied by Felix Fietkau (nbd@nbd.name) who is the mt76
subsystem maintainer.

**Step 1.3: Commit Body**
The commit clearly describes:
- Bug: `mt76_sta_state()` calls `sta_event` callback without holding
  `dev->mutex`
- `mt7915_mac_twt_teardown_flow()` has
  `lockdep_assert_held(&dev->mt76.mutex)` - proving the lock is required
- The inconsistency: `mt76_sta_add()` and `mt76_sta_remove()` correctly
  hold the lock, but `sta_event` does not
- Fix: Add `mutex_lock()`/`mutex_unlock()` around the specific call

Record: Bug is missing lock protection leading to lockdep warning and
potential data races in TWT teardown during disassociation. Root cause
is inconsistent locking introduced during refactoring.

**Step 1.4: Hidden Bug Fix?**
This is an explicit bug fix - "add missing lock protection" clearly
describes a synchronization issue. Not hidden.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Single file changed:
  `drivers/net/wireless/mediatek/mt76/mt7915/main.c`
- +2 lines added (mutex_lock/mutex_unlock)
- Function modified: `mt7915_mac_sta_event()`
- Scope: Single-file, surgical, 2-line fix

**Step 2.2: Code Flow Change**
- Before: `mt7915_mac_twt_teardown_flow()` called in a loop without
  holding `dev->mt76.mutex`
- After: The loop is wrapped with `mutex_lock(&dev->mt76.mutex)` /
  `mutex_unlock(&dev->mt76.mutex)`
- Only the DISASSOC path is affected

**Step 2.3: Bug Mechanism**
This is a **synchronization/race condition fix**:
- `mt7915_mac_twt_teardown_flow()` modifies shared data: `flow->list`
  (via `list_del_init`), `msta->twt.flowid_mask`, `dev->twt.table_mask`,
  and `dev->twt.n_agrt`
- Without the mutex, concurrent TWT setup/teardown could corrupt linked
  lists and bitmasks
- The function itself explicitly requires the lock via
  `lockdep_assert_held()`

**Step 2.4: Fix Quality**
- Obviously correct: the function asserts the lock must be held, the fix
  provides it
- Minimal: 2 lines, wraps only the code that needs protection
- No regression risk: `mt7915_mcu_add_sta()` called after unlock doesn't
  require the lock (no lockdep_assert_held in it)
- The v2 design (adding lock in driver vs core) specifically avoids
  deadlock risk with other drivers

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
- The buggy code in `mt7915_mac_sta_event()` was introduced by commit
  `33eb14f1029085` (Felix Fietkau, 2024-08-27) "wifi: mt76: mt7915: use
  mac80211 .sta_state op"
- First appeared in v6.12-rc1; present in v6.12, v6.13, v6.14, v6.15,
  v6.16, v6.17, v6.18, v6.19, v7.0
- The `lockdep_assert_held` in `mt7915_mac_twt_teardown_flow()` has been
  there since commit `3782b69d03e714` (Lorenzo Bianconi, 2021-09-23) -
  since v5.16

**Step 3.2: Fixes Tag**
No Fixes: tag present (expected). However, the implicit fix target is
`33eb14f1029085` which exists in stable trees starting from v6.12.

**Step 3.3: File History**
Recent changes to the file are mostly unrelated. No prerequisites
needed.

**Step 3.4: Author**
Ziyi Guo is not the subsystem maintainer but the patch was accepted by
Felix Fietkau (the mt76 maintainer/author).

**Step 3.5: Dependencies**
The fix is standalone - it only adds mutex_lock/unlock calls around
existing code. No other patches needed.

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1:** b4 found the patch is v2. The v1 changelog note says:
"Move the locking to MT7915 driver to avoid deadlock in other drivers."
This demonstrates review feedback was incorporated. The patch was
applied by Felix Fietkau, the mt76 maintainer.

**Step 4.2:** Applied by subsystem maintainer Felix Fietkau.

**Step 4.3-4.5:** Lore was unreachable due to bot protection. However,
the patch metadata confirms it was properly reviewed and merged.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1:** Modified function: `mt7915_mac_sta_event()`

**Step 5.2:** Called from `mt76_sta_state()` in `mac80211.c` (line
1671), which is the mac80211 `.sta_state` callback. This is called
during every station state transition (connect/disconnect).

**Step 5.3:** `mt7915_mac_twt_teardown_flow()` modifies:
- `flow->list` via `list_del_init()` - list corruption without lock
- `msta->twt.flowid_mask` - bitmask corruption
- `dev->twt.table_mask` - global device state
- `dev->twt.n_agrt` - global counter

**Step 5.4:** The path is: mac80211 sta_state callback -> mt76_sta_state
-> mt7915_mac_sta_event -> mt7915_mac_twt_teardown_flow. This is
triggered during every WiFi client disassociation on mt7915 hardware - a
common operation.

**Step 5.5:** The existing `mt7915_twt_teardown_request()` (line
1647-1658) correctly acquires the same mutex before calling the same
function, confirming the required locking pattern.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1:** The buggy code was introduced in v6.12 (commit
33eb14f1029085). It affects stable trees v6.12.y and later.

**Step 6.2:** The patch is a trivial 2-line addition that should apply
cleanly. The code around it has not changed significantly.

**Step 6.3:** No other fix for this issue found.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1:** WiFi driver (drivers/net/wireless/mediatek/mt76/mt7915/).
Criticality: IMPORTANT - mt7915 is a widely used WiFi chipset (used in
many routers and access points).

**Step 7.2:** The mt76 subsystem is actively developed.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1:** Affected users: All users of mt7915 WiFi hardware (common
in routers and access points).

**Step 8.2:** Trigger: Every WiFi client disassociation with active TWT
flows. Any WiFi 6 client using TWT can trigger this. With CONFIG_LOCKDEP
enabled, it produces a lockdep warning/splat. Without lockdep, the race
window exists and could corrupt shared data structures.

**Step 8.3:** Failure modes:
- With LOCKDEP: lockdep assertion failure/warning on every
  disassociation
- Without LOCKDEP: Race condition on `list_del_init`, bitmask/counter
  manipulation - could cause list corruption (crash), incorrect TWT
  state, or data corruption
- Severity: HIGH (list corruption can crash, lockdep warning disrupts
  debug/testing)

**Step 8.4:** Risk-benefit:
- Benefit: HIGH - prevents lockdep warnings and potential data
  corruption/crash
- Risk: VERY LOW - 2-line addition, obviously correct, wraps only the
  necessary code
- The v2 design specifically avoids deadlock in other drivers

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence**
FOR backporting:
- Fixes a real locking bug: `lockdep_assert_held()` proves the lock is
  required
- Prevents list corruption and data races on shared data structures
- 2-line fix, obviously correct, minimal risk
- Applied by subsystem maintainer (Felix Fietkau)
- v2 incorporated review feedback to avoid deadlock
- Consistent with existing locking patterns in the same driver
- Affects widely-used WiFi hardware (mt7915)

AGAINST backporting:
- No explicit user report/crash report
- Bug only affects WiFi 6 TWT flow teardown (somewhat specialized path)
- Code only exists since v6.12

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? YES - lockdep_assert_held proves
   requirement, fix is trivial
2. Fixes a real bug? YES - missing lock on shared data structures
3. Important issue? YES - list corruption, data races, lockdep warnings
4. Small and contained? YES - 2 lines, single file
5. No new features/APIs? YES - pure bug fix
6. Can apply to stable? YES - clean apply expected for v6.12+

**Step 9.3: Exception Categories**: N/A - this is a standard bug fix.

**Step 9.4: Decision**: YES - this is a small, surgical fix for a real
locking bug that could cause data corruption or crashes on widely-used
WiFi hardware.

## Verification

- [Phase 1] Parsed tags: Signed-off-by Felix Fietkau (maintainer), Link
  to patch.msgid.link
- [Phase 2] Diff analysis: +2 lines in mt7915/main.c, adds
  mutex_lock/unlock around twt_teardown_flow loop
- [Phase 3] git blame: Buggy code introduced by 33eb14f1029085 (Felix
  Fietkau, 2024-08-27, first in v6.12-rc1)
- [Phase 3] git show 33eb14f1029085: Confirmed refactoring that
  introduced the missing lock path
- [Phase 3] lockdep_assert_held confirmed at mac.c:2385 in
  mt7915_mac_twt_teardown_flow()
- [Phase 3] Existing correct locking pattern verified at
  main.c:1655-1657 (mt7915_twt_teardown_request)
- [Phase 4] b4 am: Retrieved v2 patch, confirmed changelog "Move the
  locking to MT7915 driver to avoid deadlock in other drivers"
- [Phase 4] lore.kernel.org was unreachable (bot protection) - could not
  read full thread discussion
- [Phase 5] mt76_sta_state at mac80211.c:1671 calls sta_event without
  lock (verified by reading code)
- [Phase 5] mt76_sta_add at mac80211.c:1599 and mt76_sta_remove at
  mac80211.c:1630-1632 DO hold the lock (verified)
- [Phase 5] mt7915_mac_twt_teardown_flow modifies shared: list_del_init,
  flowid_mask, table_mask, n_agrt (verified at mac.c:2398-2401)
- [Phase 6] Bug exists in v6.12 through v7.0 (verified via git tag
  --contains)
- [Phase 6] Code does NOT exist before v6.12 (verified: no
  sta_state/sta_event changes in v6.6..v6.11)
- [Phase 8] Trigger: WiFi client disassociation with TWT flows on mt7915
  hardware
- UNVERIFIED: Could not access lore.kernel.org for full review
  discussion due to bot protection

**YES**

 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90d5e79fbf74d..e212e964fda03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -851,8 +851,10 @@ int mt7915_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		return mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_PORT_SECURE, false);
 
 	case MT76_STA_EVENT_DISASSOC:
+		mutex_lock(&dev->mt76.mutex);
 		for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
 			mt7915_mac_twt_teardown_flow(dev, msta, i);
+		mutex_unlock(&dev->mt76.mutex);
 
 		mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, false);
 		msta->wcid.sta_disabled = 1;
-- 
2.53.0


