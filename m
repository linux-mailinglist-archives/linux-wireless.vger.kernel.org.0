Return-Path: <linux-wireless+bounces-35047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGmPKwkr5mkDswEAu9opvQ
	(envelope-from <linux-wireless+bounces-35047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:32:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B5E42BF48
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5301830C331A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3553B19DE;
	Mon, 20 Apr 2026 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edvuBKxm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E013B38AE;
	Mon, 20 Apr 2026 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691007; cv=none; b=b9gXWr6nzVlmQ4JdiOpPRRFIh3ay4RxktiFoZ0xxQCQFwQx6Igvr7m31EdoXR8F7LoWI47AOkf/KBtYl1xaL3we0H6ONIiPZeMo5zpyP470x0LqT411sN3tUu+D9qqcVZ+oa9K5v4LzHig3sNkVXc9JNbMwMFoKqc/vmEok1CJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691007; c=relaxed/simple;
	bh=ZoszNydaLQofCj2GKZoDLQEsFcd927i5D8t5v/p8GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjKBTkAXV9r9s3deYmmbTc4P8baPV7PmMWZicu7S6507jiGUTHmJWcoZ3r0/3wp+j5IQ9OstM9u7UzppbNgMriRCRC5ZJiPg/wUpqfUagBIlRGUIIE7JGpUIAfau7IpR9g7DMEDvi6pFngqS5qhbEESYYojDda3JzP3bA0raVmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edvuBKxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF2C19425;
	Mon, 20 Apr 2026 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691006;
	bh=ZoszNydaLQofCj2GKZoDLQEsFcd927i5D8t5v/p8GTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edvuBKxmddpO/DM+pTwYAPEBwdVt8jRGn4W2G0BQC2gTsQpKAdhex3QNiRfQolApZ
	 CkiVMGrtE6/wj6SUP/7axOXeXvTvTjgfVq/CeRXiH6VekR5EETd0bAkbIh6VyhQ3ou
	 0Hyt3cbLDsilHhph9o4gYp9QovtqtsYLHGswFvh6Ww4nNb3FVsNnbefcd0kWfHdLW8
	 MZGAbvsy5mYqY5efetOWwun4ZJfqGzVZucienKL1El3gDv4lprXjwWKbJauKeyIFhF
	 BlYLpVsMytZo1wmWXObFxL/Y4D3nokjJbhJf/FVMPOnEOwqzNvcDBMD09WF9aqrdIU
	 cx3gZDP8g6AxQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.6] wifi: mac80211: Remove deleted sta links in ieee80211_ml_reconf_work()
Date: Mon, 20 Apr 2026 09:08:25 -0400
Message-ID: <20260420131539.986432-39-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35047-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 08B5E42BF48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 84674b03d8bf3a850f023a98136c27909f0a2b61 ]

Delete stale station links announced in the reconfiguration IE
transmitted by the AP in the beacon frames.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260309-mac80211-reconf-remove-sta-link-v2-1-1582aac720c6@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the data needed for my analysis. Let me compile the final
assessment.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mac80211:`
- Action verb: "Remove" (implies cleaning up something that should have
  been cleaned up but wasn't)
- Summary: Remove deleted sta links in ieee80211_ml_reconf_work()
- Record: [wifi: mac80211] [Remove] [Clean up stale station link data
  during AP-initiated MLO reconfiguration]

**Step 1.2: Tags**
- Signed-off-by: Lorenzo Bianconi (author)
- Link: https://patch.msgid.link/20260309-mac80211-reconf-remove-sta-
  link-v2-1-1582aac720c6@kernel.org
- Signed-off-by: Johannes Berg (mac80211 maintainer who applied it)
- No Fixes: tag
- No Cc: stable tag
- No Reported-by: tag
- Record: Applied by mac80211 maintainer Johannes Berg. No explicit
  stable nomination. This is v2 of the patch.

**Step 1.3: Commit Body**
- "Delete stale station links announced in the reconfiguration IE
  transmitted by the AP in the beacon frames."
- The commit describes missing cleanup of station link data when an AP
  announces link removal via the ML Reconfiguration element in beacons.
- Record: Bug is missing STA link cleanup during AP-initiated ML
  reconfiguration. No crash described, but clear data
  inconsistency/leak.

**Step 1.4: Hidden Bug Fix Detection**
- "Remove deleted sta links" and "Delete stale station links" = this IS
  a bug fix: cleanup that was missing, leading to stale/leaked
  resources.
- Record: YES - this is a hidden bug fix. Station links were not being
  freed during AP-initiated link removal, creating resource leaks and
  data inconsistency.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Single file: `net/mac80211/mlme.c`
- +11 lines added, 0 removed
- Function modified: `ieee80211_ml_reconf_work()`
- Record: [net/mac80211/mlme.c: +11/-0] [ieee80211_ml_reconf_work]
  [Single-file surgical fix]

**Step 2.2: Code Flow**
- BEFORE: After adjusting active links, the function calls
  `ieee80211_vif_set_links()` to update VIF-level links but NEVER cleans
  up STA-level link data.
- AFTER: Before calling `ieee80211_vif_set_links()`, the function looks
  up the AP station, iterates removed links, and calls
  `ieee80211_sta_free_link()` for each to clean up STA link data.
- Affected path: Normal AP-initiated ML reconfiguration path (beacon-
  driven link removal).

**Step 2.3: Bug Mechanism**
- Category: Resource leak + data inconsistency
- `sta_remove_link()` (called by `ieee80211_sta_free_link()`) performs:
  1. Clears `sta->sta.valid_links & ~BIT(link_id)`
  2. Accumulates removed link statistics
  3. NULLs `sta->link[link_id]` and `sta->sta.link[link_id]` pointers
  4. Frees the link_sta allocation via `kfree_rcu()`
  5. Recalculates aggregates
- Without this fix, all of the above are skipped, causing memory leaks
  and stale data.

**Step 2.4: Fix Quality**
- Obviously correct: mirrors the STA-initiated path in
  `ieee80211_mgd_assoc_ml_reconf()` (line 10997-11003)
- Minimal/surgical: only 11 lines, single function, single file
- Regression risk: very low - `ieee80211_sta_free_link()` is a well-
  tested function
- Johannes Berg (maintainer) reviewed and applied it
- Record: Fix is obviously correct, minimal, and well-contained.

## PHASE 3: GIT HISTORY

**Step 3.1: Blame**
- All lines in `ieee80211_ml_reconf_work()` trace back to 8eb8dd2ffbbb
  (Ilan Peer, 2023-06-18) = the original ML reconf support commit.
- This commit is in v6.5-rc1, meaning the bug has existed since v6.5.

**Step 3.2: Fixes tag**
- No Fixes: tag present. The implicit target would be 8eb8dd2ffbbb
  ("wifi: mac80211: Support link removal using Reconfiguration ML
  element").
- 8eb8dd2ffbbb is in v6.5+ (verified: in v6.5, v6.6, NOT in v6.1).

**Step 3.3: Related Changes**
- `3f654d53dff56` converted ml_reconf_work to wiphy_hrtimer_work
  (v6.18-rc5+, NOT in v6.12 or v6.6)
- `162d331d833dc` bounds-check link_id in ieee80211_ml_reconfiguration
  (Cc: stable)
- These are independent changes. The fix under review is standalone.

**Step 3.4: Author**
- Lorenzo Bianconi is a known wireless contributor with 10+ mac80211
  commits.
- The patch was applied by Johannes Berg, the mac80211 maintainer.

**Step 3.5: Dependencies**
- `ieee80211_sta_free_link()` exists since v6.0-rc1 (commit
  21476ad16d3ca)
- `sta_info_get()` is a long-standing function
- No dependencies beyond what exists in stable trees with the ML reconf
  feature.
- For stable trees < 6.18, the function signature uses
  `wiphy_delayed_work` instead of `wiphy_hrtimer_work`, requiring minor
  backport adjustment.

## PHASE 4: MAILING LIST

**Step 4.1: Discussion**
- v1 submitted 2026-03-07 to wireless-next
- Lachlan Hodges suggested using `scoped_guard(rcu)` instead
- Johannes Berg reviewed and provided critical feedback:
  1. Remove unnecessary `rcu_read_lock/unlock` (wiphy mutex is held)
  2. Asked whether `ieee80211_sta_remove_link()` should be used instead
     to notify the driver
  3. Noted TDLS station cleanup is also needed (separate commit)
- Lorenzo addressed feedback in v2 (removed rcu locks)
- v2 applied by Johannes Berg

**Step 4.2: Reviewers**
- Johannes Berg (mac80211 maintainer) directly reviewed and applied the
  patch.

**Step 4.3: Bug Report**
- No external bug report. Discovered by code review / development.

**Step 4.4: Series**
- Standalone single patch, not part of a series.

**Step 4.5: Stable Discussion**
- No stable-specific discussion found. Patch was sent to wireless-next.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Key Functions**
- `ieee80211_ml_reconf_work()` - the work function for AP-initiated ML
  reconfiguration
- `ieee80211_sta_free_link()` - cleans up STA link data (calls
  `sta_remove_link` without unhashing)

**Step 5.2: Callers**
- `ieee80211_ml_reconf_work` is scheduled by
  `ieee80211_ml_reconfiguration()` when the AP advertises link removal
  via ML Reconfiguration element in beacons.
- This is triggered by real AP behavior in MLO (WiFi 7) environments.

**Step 5.3-5.4: Call Chain**
- AP beacon -> `ieee80211_ml_reconfiguration()` -> schedules
  `ieee80211_ml_reconf_work` -> (the fix adds)
  `ieee80211_sta_free_link()` -> `sta_remove_link()` -> `kfree_rcu()`
  for link_sta allocation

**Step 5.5: Similar Patterns**
- The STA-initiated path (`ieee80211_mgd_assoc_ml_reconf`, line
  10997-11003) correctly calls `ieee80211_sta_remove_link()`. This fix
  makes the AP-initiated path consistent.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable**
- Original ML reconf feature (8eb8dd2ffbbb) is in v6.5+
- Active stable trees affected: 6.6.y (the primary LTS)
- NOT in 6.1.y (too old for MLO support)

**Step 6.2: Backport Complications**
- For 6.6.y: the function uses `wiphy_delayed_work` not
  `wiphy_hrtimer_work`, so the `container_of` will need a minor
  adjustment. The core logic is the same.
- The fix itself is simple enough that adaptation should be trivial.

**Step 6.3: Related Fixes in Stable**
- No related fix for this specific bug in stable.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1: Subsystem**
- net/mac80211 - WiFi MAC layer, core wireless infrastructure
- Criticality: IMPORTANT - affects all WiFi 7 (MLO) users

**Step 7.2: Activity**
- mac80211 is very actively developed (MLO/WiFi 7 features ongoing).

## PHASE 8: IMPACT AND RISK

**Step 8.1: Who Is Affected**
- Users of WiFi 7 (MLO/Multi-Link Operation) where the AP performs link
  reconfiguration
- Growing user base as WiFi 7 hardware becomes common

**Step 8.2: Trigger Conditions**
- Triggered when an AP removes a link via ML Reconfiguration element in
  beacon frames
- This is a normal WiFi 7 operational scenario (AP-initiated link
  removal)
- Not timing-dependent

**Step 8.3: Failure Mode**
- Memory leak: `link_sta_info` and allocation leaked for each removed
  link (via missing `kfree_rcu`)
- Data inconsistency: `sta->sta.valid_links` still has bits set for
  removed links
- Stale STA link pointers not NULLed (potential stale data access)
- RX/TX paths checking `sta.valid_links` may behave incorrectly (40+
  references across mac80211)
- Severity: HIGH (memory leak in operational path + data inconsistency
  affecting correctness)

**Step 8.4: Risk-Benefit**
- BENEFIT: Prevents memory leaks and data inconsistency in WiFi 7 MLO
  link removal. Fixes a correctness bug that affects all WiFi 7 users
  with AP-initiated link removal.
- RISK: Very low. 11 lines added, calls well-tested
  `ieee80211_sta_free_link()`. Reviewed by mac80211 maintainer. Minor
  backport adjustment needed for older stable trees.
- Ratio: High benefit, very low risk.

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence**

FOR backporting:
- Fixes a real bug: missing STA link cleanup = memory leak + data
  inconsistency
- Small, surgical fix: 11 lines added in one function, one file
- Obviously correct: mirrors the existing STA-initiated reconfig path
- Reviewed and applied by mac80211 maintainer Johannes Berg
- Bug exists since v6.5, affects active stable tree 6.6.y
- `ieee80211_sta_free_link()` exists in all affected stable trees
- No dependencies on other patches

AGAINST backporting:
- Sent to wireless-next (not wireless/fixes), suggesting
  author/maintainer didn't consider it urgent
- No Fixes: tag, no Cc: stable tag
- No crash reports or user-visible symptoms documented
- WiFi 7 MLO is relatively new (fewer affected users currently)
- Minor backport adaptation needed for pre-6.18 trees
  (wiphy_delayed_work vs wiphy_hrtimer_work)

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? YES - mirrors existing pattern,
   reviewed by maintainer
2. Fixes a real bug? YES - memory leak and data inconsistency
3. Important issue? MEDIUM-HIGH - memory leak in operational path, data
   corruption risk
4. Small and contained? YES - 11 lines, single file
5. No new features? CORRECT - no new features
6. Can apply to stable? YES with minor adjustment for function signature

**Step 9.3: Exception Categories**
- Not an exception category (not device ID, quirk, DT, build fix, or doc
  fix)

**Step 9.4: Decision**
This is a clear correctness bug fix that prevents memory leaks and data
inconsistency in WiFi 7 MLO link removal. The fix is small, surgical,
obviously correct, and reviewed by the maintainer. While it was sent to
wireless-next and lacks explicit stable tags, the technical merit of the
fix warrants backporting. The memory leak occurs every time an AP
removes a link, which is a normal operational scenario for WiFi 7 users.

## Verification

- [Phase 1] Parsed tags: Signed-off-by Lorenzo Bianconi (author) +
  Johannes Berg (maintainer). No Fixes:, no Cc: stable, no Reported-by.
- [Phase 2] Diff analysis: 11 lines added in ieee80211_ml_reconf_work(),
  adds sta link cleanup via ieee80211_sta_free_link() before
  ieee80211_vif_set_links()
- [Phase 2] Compared with ieee80211_mgd_assoc_ml_reconf (lines
  10997-11003) which correctly calls ieee80211_sta_remove_link() for
  removed links - confirms the AP-initiated path was missing equivalent
  cleanup
- [Phase 2] Read sta_remove_link() (line 414-448): confirmed it frees
  link_sta allocation via kfree_rcu, NULLs pointers, clears valid_links
  bits, accumulates stats
- [Phase 3] git blame: all lines in ieee80211_ml_reconf_work trace to
  8eb8dd2ffbbb (v6.5-rc1, June 2023)
- [Phase 3] Verified 8eb8dd2ffbbb is in v6.5, v6.6 (YES), not in v6.1
  (NO)
- [Phase 3] ieee80211_sta_free_link introduced in 21476ad16d3ca
  (v6.0-rc1) - exists in all affected stable trees
- [Phase 3] 3f654d53dff56 (hrtimer conversion) NOT in v6.12 or v6.6 -
  minor backport adaptation needed
- [Phase 4] b4 mbox: retrieved full v1 and v2 threads from lore
- [Phase 4] v1->v2 evolution: v2 removed unnecessary
  rcu_read_lock/unlock per Johannes Berg's review
- [Phase 4] Johannes Berg (maintainer) reviewed directly, asked about
  ieee80211_sta_remove_link vs ieee80211_sta_free_link - accepted
  ieee80211_sta_free_link since driver is notified via set_active_links
- [Phase 4] Patch sent to wireless-next (not wireless/fixes)
- [Phase 5] Verified sta_info_get() and ieee80211_sta_free_link() are
  available in all affected stable trees
- [Phase 5] sta.valid_links is referenced 40+ times across mac80211 -
  stale bits affect many code paths
- [Phase 6] Bug affects v6.5+ stable trees; 6.6.y is primary affected
  LTS
- [Phase 8] Failure mode: memory leak (kfree_rcu not called) + data
  inconsistency (valid_links stale) - severity HIGH

**YES**

 net/mac80211/mlme.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 810bea1aacc5e..68da06434bb5d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7001,6 +7001,7 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 		container_of(work, struct ieee80211_sub_if_data,
 			     u.mgd.ml_reconf_work.work);
 	u16 new_valid_links, new_active_links, new_dormant_links;
+	struct sta_info *sta;
 	int ret;
 
 	if (!sdata->u.mgd.removed_links)
@@ -7036,6 +7037,16 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 		}
 	}
 
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (sta) {
+		unsigned long removed_links = sdata->u.mgd.removed_links;
+		unsigned int link_id;
+
+		for_each_set_bit(link_id, &removed_links,
+				 IEEE80211_MLD_MAX_NUM_LINKS)
+			ieee80211_sta_free_link(sta, link_id);
+	}
+
 	new_dormant_links = sdata->vif.dormant_links & ~sdata->u.mgd.removed_links;
 
 	ret = ieee80211_vif_set_links(sdata, new_valid_links,
-- 
2.53.0


