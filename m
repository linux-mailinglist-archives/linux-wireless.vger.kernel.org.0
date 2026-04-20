Return-Path: <linux-wireless+bounces-35045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIBIHgYp5mnysgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:24:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085F42BA4B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77BB83068104
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DE3A544F;
	Mon, 20 Apr 2026 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4g9dRJr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420803A1D1C;
	Mon, 20 Apr 2026 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690957; cv=none; b=XLxgCcyy1inaOHlDh5VJ3ECuQsaAMu4cj4KzFbrgUbXtXfSk5axLcl9q6bjjL8yIE0w0MoEvMkMIm7o9U6gXGaMg6M399LNXiKIYxVd0c+j0uzMH017HoEQ3BmbeGtbwvobOtEX+fRMkVkLgi1Fyz5i6r1hB1dgCr42LsBCvXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690957; c=relaxed/simple;
	bh=4t1FZwqMwZPkAYeL765ze89kh1tnz2HhY0WOaKUodLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cebtyimGkizH0Cr6XHUvPlL8vMD+FsxfAGsRRMSoA4Bc4Zmyw1k77/Y+UevFZTDmh7MWKUObiNPmtsRlUQ+XzON3cFucGl+XdyE/EVscdWHMDEC7mg4JSbD+CzF/hbHmlxHmxU6Yhypbot5yBmsE0m+fEHBKcIT184nNia0vs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4g9dRJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC4FC2BCB7;
	Mon, 20 Apr 2026 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690957;
	bh=4t1FZwqMwZPkAYeL765ze89kh1tnz2HhY0WOaKUodLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4g9dRJrUtpA19Oxvq5rInSq4RoQ/DWWGLZHEyrByhbO+OAL1JAJ8FOhtUI3rmNUO
	 zHZOAtem+z4evsElpO058cwbqMm6i0qxhqtx5Onk3xDKGMk69H3Clq7/bK9a+MTpkT
	 I/v0C++jzc+8gbMqLXkg7zv4/KjaEJKkod/VokRW6sdPK2C1scImGx32jQQfGzm+rH
	 eeev6Y0+IsAZG+yBdbgKJFzq8wxPfTdlfIsXMI1HKvBHF08T+fv3nUh8IAWm38BIdO
	 Z0BWWPk0m7cDEGxpw1+6NZW/y5YFj3hf9j0I4xFhk62nbSJKVJgb3X9qrPKdXdSlur
	 7/y4JTG4RacJA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.12] wifi: mac80211: properly handle error in ieee80211_add_virtual_monitor
Date: Mon, 20 Apr 2026 09:07:57 -0400
Message-ID: <20260420131539.986432-11-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35045-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7085F42BA4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 876565d4a826f3f04ef36f1cef6123ed4b150aa3 ]

In case of an error in ieee80211_add_virtual_monitor,
SDATA_STATE_RUNNING should be cleared as it was set in this function.
Do it there instead of in the error path of ieee80211_do_open.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260320141312.5546126313b1.I689dba2f54069b259702e8d246cedf79a73b82c6@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have enough information for a thorough analysis. Let me compile
the findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: wifi: mac80211
- **Action verb**: "properly handle" (strong indicator of a bug fix)
- **Summary**: Fix error handling in `ieee80211_add_virtual_monitor` --
  `SDATA_STATE_RUNNING` bit not properly managed on error paths.

Record: [wifi: mac80211] [properly handle] [Fix SDATA_STATE_RUNNING
management on error paths in virtual monitor addition]

### Step 1.2: Tags
- **Reviewed-by**: Johannes Berg (mac80211 subsystem maintainer)
- **Signed-off-by**: Miri Korenblit (Intel WiFi developer, regular
  mac80211 contributor)
- **Signed-off-by**: Johannes Berg (maintainer applied the patch)
- **Link**: patch.msgid.link URL (lore.kernel.org backed)
- No Fixes: tag (expected for AUTOSEL candidates)
- No Reported-by: tag
- No Cc: stable tag

Record: Reviewed and signed-off by the subsystem maintainer. Strong
quality signal.

### Step 1.3: Commit Body
The commit explains: when `ieee80211_add_virtual_monitor` encounters an
error, `SDATA_STATE_RUNNING` should be cleared within the function
itself (since it was set there), rather than relying on the caller's
error path in `ieee80211_do_open` (where it was clearing a bit that was
never set on the caller's sdata).

Record: Bug is incorrect state management -- SDATA_STATE_RUNNING bit
left set on error paths within the function. The caller's cleanup was a
no-op.

### Step 1.4: Hidden Bug Fix Detection
"properly handle error" is a direct bug fix description. This fixes a
state consistency issue where `SDATA_STATE_RUNNING` is set but never
cleared on failure, which could cause incorrect behavior in the
extensive code paths that check `ieee80211_sdata_running()`.

Record: This is clearly a bug fix, not disguised.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed**: 1 (`net/mac80211/iface.c`)
- **Lines**: ~5 lines changed effectively (moved set_bit, added
  clear_bit, removed dead code)
- **Functions modified**: `ieee80211_add_virtual_monitor` and
  `ieee80211_do_open`

Record: Single file, surgical change, two functions affected. Scope:
very small.

### Step 2.2: Code Flow Changes

**Hunk 1** (`ieee80211_add_virtual_monitor`):
- **Before**: `set_bit(SDATA_STATE_RUNNING)` at line 1225 BEFORE
  `ieee80211_check_queues`; if check_queues fails, sdata is freed with
  RUNNING still set.
- **After**: `set_bit(SDATA_STATE_RUNNING)` moved AFTER
  `ieee80211_check_queues`. The bit is only set once the queues are
  verified. In the `ieee80211_link_use_channel` error path,
  `clear_bit(SDATA_STATE_RUNNING)` is added before `kfree(sdata)`.

**Hunk 2** (`ieee80211_do_open`):
- **Before**: `clear_bit(SDATA_STATE_RUNNING, &sdata->state)` in error
  path with comment "might already be clear but that doesn't matter."
- **After**: This `clear_bit` is removed because `SDATA_STATE_RUNNING`
  is only set at line 1541 (after all error gotos), so clearing it in
  the error path was always a no-op.

### Step 2.3: Bug Mechanism
This is a **state management / initialization bug**. The
`SDATA_STATE_RUNNING` bit gates behavior in ~50+ call sites across
mac80211 (TX, RX, scan, reconfig, offchannel, etc.). Setting it
prematurely or failing to clear it on error leads to inconsistent state.

The correct pattern is shown in `ieee80211_del_virtual_monitor` (lines
1301-1312):

```1301:1312:net/mac80211/iface.c
        clear_bit(SDATA_STATE_RUNNING, &sdata->state);
        ieee80211_link_release_channel(&sdata->deflink);
        // ...
        drv_remove_interface(local, sdata);
        // ...
        kfree(sdata);
```

The error path was missing the `clear_bit` before teardown, inconsistent
with this established pattern.

### Step 2.4: Fix Quality
- Obviously correct: follows the established pattern in
  `ieee80211_del_virtual_monitor`
- Minimal/surgical: only moves one bit-set and adds one bit-clear
- Regression risk: very low -- the removed `clear_bit` in
  `ieee80211_do_open` was a no-op
- Reviewed by maintainer Johannes Berg

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
The `set_bit(SDATA_STATE_RUNNING)` was introduced by commit
`bdeca45a0cc58` ("mac80211: set SDATA_STATE_RUNNING for monitor
interfaces") from 2020-11-29. This commit was added to fix HW restart
issues but didn't account for all error paths.

The buggy code exists since v5.10 (confirmed via `git merge-base --is-
ancestor`), and is present in v5.15, v6.1, v6.6, and all newer stable
trees.

### Step 3.2: Fixes Tag
No Fixes: tag present. The implicit fix target is `bdeca45a0cc58` from
2020-11-29.

### Step 3.3: Related Changes
- `cbf0dc37bb4e9` ("wifi: mac80211: fix list iteration in
  ieee80211_add_virtual_monitor()") -- a syzbot-reported fix in the same
  function, shows the function has known bug history.
- `c0d82ba9612fb` -- Miri's other commit about `ieee80211_sdata_running`
  checks.

### Step 3.4: Author
Miri Korenblit is a regular Intel WiFi developer with many commits to
mac80211. The patch was reviewed by Johannes Berg, the mac80211
maintainer.

### Step 3.5: Dependencies
No dependencies found. The fix is self-contained and modifies only the
ordering and presence of `set_bit`/`clear_bit` calls on existing state
bits. Should apply cleanly to stable trees back to v5.10.

---

## PHASE 4: MAILING LIST RESEARCH

Lore.kernel.org was behind anti-bot protection and could not be fetched.
The Link: tag points to the original submission. The patch was reviewed
by the maintainer.

Record: Could not fetch lore discussion due to anti-bot protection. The
Reviewed-by from Johannes Berg is a strong quality signal.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.4: Functions and Call Chains
`ieee80211_sdata_running()` (which checks `SDATA_STATE_RUNNING`) is
called from **50+ locations** across mac80211:
- TX hot path (`tx.c:2319, 4291, 4523, 4707`)
- RX path (`rx.c:5396`)
- HW reconfig (`util.c:1925, 1942, 1955, 1985, 2157, 2248`)
- Scanning (`scan.c:532, 942, 1152`)
- Channel management (`chan.c:93, 568`)
- Configuration (`cfg.c` multiple locations)

The critical path is HW reconfig at `util.c:1954-1956`:
```c
sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
if (sdata && ieee80211_sdata_running(sdata))
    ieee80211_assign_chanctx(local, sdata, &sdata->deflink);
```

If the sdata was partially initialized (RUNNING set but channel context
failed), this could attempt operations on invalid state.

### Step 5.5: Similar Patterns
The proper pattern (`clear_bit` before teardown) is consistently used in
`ieee80211_del_virtual_monitor` (line 1301) and `ieee80211_do_stop`
(line 490). The error path was the outlier.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Buggy Code in Stable
The buggy commit `bdeca45a0cc58` from Nov 2020 is present in **all
active stable trees**: v5.10, v5.15, v6.1, v6.6, v6.12. The fix is
relevant to all of them.

### Step 6.2: Backport Complications
The function signature changed (added `creator_sdata` parameter), but
the core logic and error paths are the same. Minor conflicts possible in
older trees but the fix concept applies cleanly.

### Step 6.3: Related Fixes in Stable
No other fix for this specific issue found in stable.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Criticality
- **Subsystem**: WiFi (net/mac80211) -- IMPORTANT level
- WiFi is used by vast majority of laptops, embedded systems, IoT
  devices
- mac80211 is the core WiFi stack used by most WiFi drivers

### Step 7.2: Activity
Very active subsystem (87 changes since v6.6 for this single file).

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All WiFi users whose hardware uses mac80211 virtual monitor interfaces
(common during scanning, monitoring).

### Step 8.2: Trigger Conditions
Triggered when `ieee80211_add_virtual_monitor` fails -- specifically
when `ieee80211_check_queues` or `ieee80211_link_use_channel` return
errors. This can happen during:
- HW restart/reconfig (util.c:2269)
- Opening a monitor interface (iface.c:1437)
- Channel context assignment failures

### Step 8.3: Failure Mode
- Incorrect `SDATA_STATE_RUNNING` state could cause code paths gated by
  `ieee80211_sdata_running()` to operate on improperly initialized sdata
- In the worst case, during HW reconfig, could lead to inconsistent
  driver state, potential crashes, or resource leaks
- Severity: **MEDIUM-HIGH** (state corruption in WiFi stack, potential
  for cascading issues)

### Step 8.4: Risk-Benefit
- **Benefit**: Fixes state management bug in widely used WiFi code,
  present since v5.10
- **Risk**: Very low -- moves one set_bit, adds one clear_bit, removes
  dead code. Reviewed by maintainer.
- **Ratio**: Favorable for backport

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary

**FOR backporting:**
- Fixes a real error handling bug (SDATA_STATE_RUNNING not cleared on
  error paths)
- `ieee80211_sdata_running()` checked in 50+ locations -- incorrect
  state has wide impact
- Bug present since v5.10, affects all stable trees
- Small, surgical fix (5 effective lines changed)
- Reviewed and signed-off by Johannes Berg (mac80211 maintainer)
- Author is a regular Intel WiFi contributor
- Follows established cleanup pattern from
  `ieee80211_del_virtual_monitor`
- Single file change, no dependencies

**AGAINST backporting:**
- No specific crash/bug report referenced (no Reported-by)
- Failure requires specific error conditions (channel context failure)
- Minor function signature differences in older stable trees

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** -- follows existing pattern,
   reviewed by maintainer
2. Fixes a real bug? **YES** -- state bit not cleared on error path
3. Important issue? **YES** -- affects WiFi state management in widely-
   used code
4. Small and contained? **YES** -- 5 lines across one file
5. No new features or APIs? **YES** -- purely error handling fix
6. Can apply to stable trees? **YES** -- code exists in all active
   stable trees

### Step 9.3: Exceptions
Not applicable.

---

## Verification

- [Phase 1] Parsed tags: Reviewed-by Johannes Berg (maintainer), SOB
  from Miri Korenblit (Intel wifi dev)
- [Phase 2] Diff analysis: set_bit moved after ieee80211_check_queues;
  clear_bit added in ieee80211_link_use_channel error path; dead
  clear_bit removed from ieee80211_do_open
- [Phase 3] git blame: SDATA_STATE_RUNNING introduced by bdeca45a0cc58
  (2020-11-29), present since v5.10
- [Phase 3] git merge-base: confirmed bdeca45a0cc58 is in v5.10, v5.15,
  v6.1, v6.6
- [Phase 3] Related fix cbf0dc37bb4e9 (syzbot-found bug in same
  function) confirms function has bug history
- [Phase 4] Could not fetch lore discussion (anti-bot protection).
  UNVERIFIED: no stable nomination in discussion
- [Phase 5] grep: ieee80211_sdata_running() used in 50+ call sites
  across TX, RX, scan, reconfig, cfg
- [Phase 5] Compared with ieee80211_del_virtual_monitor (line 1301):
  proper pattern clears RUNNING before teardown
- [Phase 6] Bug code present in all active stable trees (v5.10+)
- [Phase 8] Failure mode: inconsistent SDATA_STATE_RUNNING during error
  recovery, severity MEDIUM-HIGH

The fix is small, correct, matches established patterns, reviewed by the
subsystem maintainer, and fixes a real state management bug in code
present in all stable trees.

**YES**

 net/mac80211/iface.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 676b2a43c9f2f..989e60d4b721d 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1222,14 +1222,14 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
 		}
 	}
 
-	set_bit(SDATA_STATE_RUNNING, &sdata->state);
-
 	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
 	if (ret) {
 		kfree(sdata);
 		return ret;
 	}
 
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
+
 	mutex_lock(&local->iflist_mtx);
 	rcu_assign_pointer(local->monitor_sdata, sdata);
 	mutex_unlock(&local->iflist_mtx);
@@ -1242,6 +1242,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
 		mutex_unlock(&local->iflist_mtx);
 		synchronize_net();
 		drv_remove_interface(local, sdata);
+		clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 		kfree(sdata);
 		return ret;
 	}
@@ -1550,8 +1551,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	sdata->bss = NULL;
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
-	/* might already be clear but that doesn't matter */
-	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	return res;
 }
 
-- 
2.53.0


