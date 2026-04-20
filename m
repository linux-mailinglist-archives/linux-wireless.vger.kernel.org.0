Return-Path: <linux-wireless+bounces-35050-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CIlNJcq5mkDswEAu9opvQ
	(envelope-from <linux-wireless+bounces-35050-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:31:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6A442BE2A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3706C3088903
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407943C1419;
	Mon, 20 Apr 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW8Xzyua"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F43C1415;
	Mon, 20 Apr 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691048; cv=none; b=gYR5s/A6GBvSoYw+TSbB7pD1sReDfJEfxeQsmMQA9MEtvQ1qb/Q7rtvxnrfF4do3gDecne+pUNzH/7U0iy1+dj0g73icKjS9VQrqncm6z8FfoMchv9r8dZqoRAvbnCNpIb+k1Uoa9W7ih+9jDACvuoxec6wQph+ZpI2vNeATsVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691048; c=relaxed/simple;
	bh=2uxAMq/plTcDTGuk0sfBjxKUs2/3TSlDaTNK2qRM9K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GL7l/0F/8mV7gN5sp9tGSMmz/kmkEz5DWYfk3MZI58WRBGpat+3MbdoZD3XvcVNtSubuhSYjvn7m1Vk+UofE+ptIT/hvDcDnT36orC3HQTgndRaDFq00kGMO6ekBrB3HZvElA07/YtliRecAj3mt9htyk3AVAiH9LR/+zP7PBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW8Xzyua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25201C2BCB4;
	Mon, 20 Apr 2026 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691048;
	bh=2uxAMq/plTcDTGuk0sfBjxKUs2/3TSlDaTNK2qRM9K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SW8XzyuauKeFDPEggm3+rER0DXZ7a8s0YnJrZZ0ab2Nypx/M4uOyH40o5vUsdqLHS
	 j5JXEnPUqEmK7yYG51jezUun6A1YVBvK+6hLMRByCcthYbzgEO8TsjIrB8dffBgddo
	 BqBhTPAw3dkX0p/p95uJJTW9R+IlT9u9Oco8ZlgvQomXxHnSilQmFRxhWKAR0s83TM
	 O3asUjDJm/oLU701lEZ9kpvfppHyxNgNCU0dnGeS7GTwDOjUyxHXqChTetn16HG16f
	 x2OdzwkUnBsBgP/TdSXdVA38lDMwzStvypr7JReCg7iEwVfWVnq7bydO1qmbk0LziN
	 onX015bOnxriA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.1] wifi: rtw89: retry efuse physical map dump on transient failure
Date: Mon, 20 Apr 2026 09:08:49 -0400
Message-ID: <20260420131539.986432-63-sashal@kernel.org>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-35050-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA6A442BE2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit d92f6ad6483e6d430c8273eeb7be97ce85244bd5 ]

On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
physical map dump intermittently fails with -EBUSY during probe.
The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
bit after 1 second.

The root cause is a timing race during boot: the WiFi driver's
chip initialization (firmware download via PCIe) overlaps with
Bluetooth firmware download to the same combo chip via USB. This
can leave the efuse controller temporarily unavailable when the
WiFi driver attempts to read the efuse map.

The firmware download path retries up to 5 times, but the efuse
read that follows has no similar logic. Address this by adding
retry loop logic (also up to 5 attempts) around physical efuse
map dump.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260317112155.1939569-1-christianshewitt@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a thorough analysis. Here is
the complete walkthrough:

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: wifi: rtw89 (Realtek 802.11ax wireless driver)
- **Action verb**: "retry" — indicates adding resilience to a failure
  path
- **Summary**: Adds retry logic for efuse physical map dump to handle
  transient -EBUSY failures

### Step 1.2: Tags
- **Signed-off-by**: Christian Hewitt (author), Ping-Ke Shih (rtw89
  maintainer who applied it)
- **Link**: `https://patch.msgid.link/20260317112155.1939569-1-
  christianshewitt@gmail.com` — original submission
- No `Fixes:` tag (expected for autosel candidate)
- No `Cc: stable` (expected)
- No `Reported-by:` — the author is the reporter/user himself

### Step 1.3: Commit Body Analysis
- **Bug description**: On Radxa Rock 5B with RTL8852BE combo WiFi/BT,
  efuse physical map dump intermittently fails with -EBUSY during probe.
- **Symptom**: `read_poll_timeout_atomic()` times out (1 second) waiting
  for `B_AX_EF_RDY` bit in `rtw89_dump_physical_efuse_map_ddv()`.
- **Root cause**: Timing race during boot — WiFi chip initialization
  (firmware download via PCIe) overlaps with Bluetooth firmware download
  via USB to the same combo chip. The efuse controller becomes
  temporarily unavailable.
- **Fix approach**: Add retry loop (up to 5 attempts), matching the
  firmware download retry pattern already in the driver.

### Step 1.4: Hidden Bug Fix Detection
This is explicitly described as a real bug fix — probe fails
intermittently, WiFi doesn't work. The commit message is clear about the
failure mechanism.

Record: Real probe-time failure on real hardware. Not a hidden fix.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed**: 1 (`drivers/net/wireless/realtek/rtw89/efuse.c`)
- **Lines**: +19 added (new retry wrapper), minimal structural change
- **Functions modified**: `rtw89_dump_physical_efuse_map()` renamed to
  `__rtw89_dump_physical_efuse_map()`, new wrapper
  `rtw89_dump_physical_efuse_map()` with retry logic
- **Scope**: Single-file, surgical fix

### Step 2.2: Code Flow Change
**Before**: `rtw89_dump_physical_efuse_map()` calls DDV or DAV path
once. If the efuse controller is busy (-EBUSY), it fails immediately and
the caller propagates the error up, causing probe to fail.

**After**: The original function is renamed to
`__rtw89_dump_physical_efuse_map()`. A new wrapper calls it in a loop
(up to 5 times). On success, returns immediately. On failure, logs a
warning and retries.

### Step 2.3: Bug Mechanism
**Category**: Hardware timing/resource contention during probe.
- The efuse controller is shared between WiFi and BT on combo chips
- BT firmware download via USB can hold the controller busy
- The DDV read path polls for B_AX_EF_RDY for up to 1 second, then fails
- Without retry, a transient busy state becomes a permanent probe
  failure

### Step 2.4: Fix Quality
- **Obviously correct**: Yes — retry on transient error is a well-
  established pattern
- **Minimal**: Yes — 19 lines, pure wrapper function
- **Regression risk**: Very low — only adds retries on an already-
  failing path; success path is unchanged (returns immediately on first
  `!ret`)
- **Pattern consistency**: Exactly matches `rtw89_fw_download()` at
  fw.c:1980 which already does `for (retry = 0; retry < 5; retry++)`
  around `__rtw89_fw_download()`

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
- The DDV efuse read code (`rtw89_dump_physical_efuse_map_ddv`) was
  introduced in commit `e3ec7017f6a20d` (v5.16-rc4, Oct 2021 — initial
  rtw89 driver)
- The wrapper `rtw89_dump_physical_efuse_map()` with DAV split came from
  `bdfbf06c2c286d` (v5.18 era, Mar 2022)
- The buggy code has been present since the driver was introduced

### Step 3.2: Fixes Tag
No Fixes: tag present. The bug is effectively a design limitation from
the original driver — no retry logic was ever added for efuse reads,
while firmware download had retry from the beginning.

### Step 3.3: File History
Recent changes to `efuse.c` are all WiFi 7 feature additions (efuse
version reading, secure boot info). The core
`rtw89_dump_physical_efuse_map()` function has been unchanged since
v5.18. No prerequisites needed.

### Step 3.4: Author Check
- Christian Hewitt is the patch author (user who hit the bug on Radxa
  Rock 5B)
- Ping-Ke Shih is the rtw89 maintainer who signed off and applied the
  patch
- Maintainer sign-off provides strong confidence in the fix

### Step 3.5: Dependencies
- **No dependencies**: The patch modifies only the wrapper function and
  introduces no new structures, types, or dependencies
- The function signature matches all stable trees v6.1+
- In v5.16-5.17, the function signature differs (no `dav` parameter),
  requiring minor adaptation

---

## PHASE 4: MAILING LIST RESEARCH

b4 dig could not find the commit (it's a single-patch submission, not in
the local tree). Lore is blocking automated access. However:
- The patch was submitted from `christianshewitt@gmail.com` on
  2026-03-17
- Applied by Ping-Ke Shih (rtw89 maintainer)
- The Link: tag confirms it was submitted through normal mailing list
  flow

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Functions Modified
- `rtw89_dump_physical_efuse_map()` (renamed to `__` prefix, wrapped)

### Step 5.2: Callers
The wrapper `rtw89_dump_physical_efuse_map()` is called from 5
locations, all during probe:
1. `rtw89_parse_efuse_map_ax()` — twice (physical + DAV map)
2. `rtw89_parse_phycap_map_ax()` — once
3. `rtw89_read_efuse_ver()` — once
4. `rtw89_efuse_read_fw_secure_ax()` — once

All are invoked through `chip->ops->parse_efuse_map` and
`chip->ops->parse_phycap_map` during device initialization.

### Step 5.3/5.4: Impact
If any of these callers fail, the WiFi device fails to probe — it
becomes completely non-functional. The function is on the critical path
for device initialization.

### Step 5.5: Similar Patterns
The exact same retry pattern already exists at `fw.c:1980` for
`rtw89_fw_download()`. This establishes precedent within the driver.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Code Exists in Stable Trees
- **v5.16+**: The efuse DDV code exists (the core buggy path)
- **v5.18+**: The DDV/DAV split wrapper exists (matching the patch
  context)
- **v6.1, v6.6, v6.12**: The exact function
  `rtw89_dump_physical_efuse_map()` exists with identical signature and
  body
- RTL8852BE support has been present since v6.1

### Step 6.2: Backport Complications
The `rtw89_dump_physical_efuse_map()` function is **byte-for-byte
identical** across v6.1, v6.6, v6.12, and mainline. The patch will apply
cleanly to all active stable trees.

### Step 6.3: No Existing Fix
No related fix for this same issue exists in any stable tree.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem
- **Subsystem**: Network drivers (wireless) — Realtek rtw89
- **Criticality**: IMPORTANT — WiFi connectivity affects many users,
  especially on SBCs and laptops

### Step 7.2: Activity
- rtw89 is actively developed with regular updates
- Ping-Ke Shih (Realtek) is the active maintainer

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
Users with RTL8852BE and other Realtek combo WiFi/BT cards on any
platform where WiFi and BT firmware download can overlap during boot.
The Radxa Rock 5B is specifically mentioned but any combo card could be
affected.

### Step 8.2: Trigger Conditions
- **Trigger**: Boot with both WiFi and BT enabled on a combo Realtek
  chip
- **Frequency**: "Intermittently" — depends on boot timing
- **Unprivileged**: N/A — this is a probe-time issue, not user-triggered

### Step 8.3: Severity
- **Failure mode**: Complete WiFi probe failure — device doesn't work at
  all
- **Severity**: HIGH — total loss of WiFi functionality
- No crash or data corruption, but complete feature loss

### Step 8.4: Risk-Benefit Ratio
- **Benefit**: HIGH — prevents intermittent probe failures on real
  hardware
- **Risk**: VERY LOW — 19 lines, pure retry wrapper, success path
  unchanged, follows existing driver pattern
- **Ratio**: Strongly favorable for backport

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Summary

**FOR backporting**:
- Fixes a real probe failure on real hardware (Radxa Rock 5B, RTL8852BE)
- Small, self-contained, obviously correct (19 lines, single file)
- Follows an existing pattern in the same driver (`rtw89_fw_download`
  retry loop)
- Applied with maintainer sign-off (Ping-Ke Shih)
- No dependencies — standalone fix
- Applies cleanly to all active stable trees (v6.1+)
- When the bug triggers, WiFi is completely non-functional
- Combo WiFi/BT timing race is a generic issue affecting multiple boards

**AGAINST backporting**:
- No Fixes: tag or Cc: stable (expected, not a negative signal)
- Could be seen as adding "new logic" rather than fixing existing logic
- The failure is intermittent, not 100% reproducible

### Step 9.2: Stable Rules Checklist
1. **Obviously correct and tested?** YES — retry pattern is well-
   established, maintainer-approved
2. **Fixes a real bug?** YES — intermittent probe failure causes total
   WiFi loss
3. **Important issue?** YES — complete loss of WiFi connectivity during
   probe
4. **Small and contained?** YES — 19 lines, 1 file, pure wrapper
5. **No new features or APIs?** Correct — no new features, only
   resilience
6. **Can apply to stable?** YES — verified identical function across
   v6.1, v6.6, v6.12

### Step 9.3: Exception Category
Not an exception category — this is a standard bug fix.

### Step 9.4: Decision
The fix is small, surgical, obviously correct, follows an existing
pattern, fixes a real hardware issue causing complete WiFi loss, and was
approved by the subsystem maintainer. The risk-benefit ratio strongly
favors backporting.

---

## Verification

- [Phase 1] Parsed tags: Signed-off-by from Christian Hewitt (author)
  and Ping-Ke Shih (maintainer). Link to patch.msgid.link.
- [Phase 2] Diff analysis: 19 lines added — renames existing function
  with `__` prefix, wraps it in retry loop (up to 5 attempts). No
  behavioral change on success path.
- [Phase 3] git blame: Buggy code (no retry) introduced in
  e3ec7017f6a20d (v5.16-rc4, initial rtw89 driver, Oct 2021). Present in
  all stable trees since v5.16.
- [Phase 3] git blame: Wrapper function with DAV split introduced in
  bdfbf06c2c286d (v5.18 era). Present in v6.1+.
- [Phase 3] git log: No related fixes to this issue exist in history.
- [Phase 3] Author: Christian Hewitt is an external contributor; Ping-Ke
  Shih (Realtek, rtw89 maintainer) signed off.
- [Phase 4] b4 dig: Could not find commit in local tree. Lore blocked by
  anti-bot measures. Confirmed patch was submitted via normal mailing
  list flow (Link: tag present).
- [Phase 5] Grep callers: `rtw89_dump_physical_efuse_map()` called from
  5 locations, all in probe path (parse_efuse_map, parse_phycap_map,
  read_efuse_ver, read_fw_secure). Failure = total probe failure.
- [Phase 5] Pattern match: Identical retry pattern exists at fw.c:1980
  (`rtw89_fw_download()` wrapping `__rtw89_fw_download()` with `for
  (retry = 0; retry < 5; retry++)`).
- [Phase 6] Verified function exists identically in v6.1, v6.6, v6.12 by
  `git show` of each tag. Patch applies cleanly.
- [Phase 6] RTL8852BE PCI entry (9695dc2e4be90) present since v6.1.
- [Phase 6] efuse.c in v5.16 has different signature (no `dav` param);
  backport to 5.x would need rework.
- [Phase 8] Failure mode: Complete WiFi probe failure — device non-
  functional. Severity: HIGH.
- UNVERIFIED: Could not access lore.kernel.org discussion for reviewer
  feedback or stable nominations (anti-bot blocking). This does not
  change the decision — the fix is technically sound independent of
  reviewer commentary.

**YES**

 drivers/net/wireless/realtek/rtw89/efuse.c | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index a2757a88d55da..89d4b1b865f8f 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -185,8 +185,8 @@ static int rtw89_dump_physical_efuse_map_dav(struct rtw89_dev *rtwdev, u8 *map,
 	return 0;
 }
 
-static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
-					 u32 dump_addr, u32 dump_size, bool dav)
+static int __rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
+					   u32 dump_addr, u32 dump_size, bool dav)
 {
 	int ret;
 
@@ -208,6 +208,25 @@ static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
 	return 0;
 }
 
+static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
+					 u32 dump_addr, u32 dump_size, bool dav)
+{
+	int retry;
+	int ret;
+
+	for (retry = 0; retry < 5; retry++) {
+		ret = __rtw89_dump_physical_efuse_map(rtwdev, map, dump_addr,
+						      dump_size, dav);
+		if (!ret)
+			return 0;
+
+		rtw89_warn(rtwdev, "efuse dump (dav=%d) failed, retrying (%d)\n",
+			   dav, retry);
+	}
+
+	return ret;
+}
+
 #define invalid_efuse_header(hdr1, hdr2) \
 	((hdr1) == 0xff || (hdr2) == 0xff)
 #define invalid_efuse_content(word_en, i) \
-- 
2.53.0


