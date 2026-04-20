Return-Path: <linux-wireless+bounces-35079-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBp4APhN5mkgugEAu9opvQ
	(envelope-from <linux-wireless+bounces-35079-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:02:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997442EDA7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9869310322D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C8480948;
	Mon, 20 Apr 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRB+RSWf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177147F2EA;
	Mon, 20 Apr 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691886; cv=none; b=VhWHsOMf1pgtFKRGGpQLtV8gXkEolC2R7ihSucH4oI9z2eLbpGO40AetbPrJx2tMS8Zpj3ES0xyfZK4IxIdc40vo6fldd93mTGMsjptvtVWuavyv9jujX6mwD5jMk0tZIZMlQ5p07kJoWxcqFyrUymKPmQ6ofcmzJu202X6BKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691886; c=relaxed/simple;
	bh=Pn9O84j5Gzkkn/+pDkJ16PqPIewq1Dj5WL2dYyGinJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI/d67W9SCZIkRRNEzrkofB63YXfKaNsVXHNHzotibAXk/6nsHAiKMWp2WuiAAFBfOWAF2m5gsYtTtBrl4RhGkJNxqn5huWjwQIGkr8XmtuTz3+N1o6PyHLOuD1TeMlseDRw1xZwmEmBH1WLTqqfHIDGFiD6yX6akxRWH+H0xjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRB+RSWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC6AC19425;
	Mon, 20 Apr 2026 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691885;
	bh=Pn9O84j5Gzkkn/+pDkJ16PqPIewq1Dj5WL2dYyGinJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRB+RSWfLJmUWoPP6r5iAA9mCImlc25pZdMrkBXQ7kR3fztmXbovGkBQx5gJCuBYd
	 oRPrV4UDUX+16F2pEzRfVXnTmwCPqj6qVeIcMPoQYfuzdWYNjb+TZhQnmBYb7kw3g/
	 qyXRroLRETD3T6Ad8HtcTa7Vdh2vhV9DvCn3KYwPGZquqYxUUsaITNPCi43QPhclDT
	 Mcbkg+MFycqY2lp8f7QIdzQg7AzMpeLgaRSBC6WalQpNUGrDINahAzkX7ETyeJl0n1
	 TqHhrYMcalUihz4RdnwmvnZXdsEPM/VaxUQH/QvigB3O9nEXXjQ/rBUloZbLCefm4Z
	 UtLMFBBc7SyqQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>,
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
Subject: [PATCH AUTOSEL 7.0-6.6] wifi: mt76: mt7996: reset device after MCU message timeout
Date: Mon, 20 Apr 2026 09:20:45 -0400
Message-ID: <20260420132314.1023554-251-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[monroe.io,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-35079-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[chad.monroe.io:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,nbd.name:email]
X-Rspamd-Queue-Id: 4997442EDA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chad Monroe <chad@monroe.io>

[ Upstream commit d2b860454ea2df8f336e9b859da7ffb27f43444d ]

Trigger a full reset after MCU message timeout.

Signed-off-by: Chad Monroe <chad@monroe.io>
Link: https://patch.msgid.link/6e05ed063f3763ad3457633c56b60a728a49a6f0.1765203753.git.chad@monroe.io
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for the complete analysis. Let me
compile the findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mt76: mt7996`
- Action verb: "reset" (implies recovery from a failure state)
- Summary: Trigger a device reset when MCU message timeouts occur on
  mt7996
- Record: [wifi/mt76/mt7996] [reset] [Trigger full device recovery after
  MCU message timeout]

**Step 1.2: Tags**
- `Signed-off-by: Chad Monroe <chad@monroe.io>` - patch author
- `Link: https://patch.msgid.link/...` - reference to lore
- `Signed-off-by: Felix Fietkau <nbd@nbd.name>` - maintainer/committer
  of mt76
- No Fixes: tag (expected for manual review candidates)
- No Cc: stable (expected)
- No Reported-by tag
- Record: Author is Chad Monroe; applied by Felix Fietkau (the mt76
  subsystem maintainer)

**Step 1.3: Commit Body**
- Body is very brief: "Trigger a full reset after MCU message timeout."
- No stack traces or reproduction steps given
- The mt7915 equivalent (commit 10f73bb3938f7c5) provides more context:
  "MCU hangs do not trigger watchdog interrupts, so they can only be
  detected through MCU message timeouts. Ensure that the hardware gets
  restarted when that happens in order to prevent a permanent stuck
  state."
- Record: Bug = MCU hang leaves device permanently stuck. Symptom = WiFi
  device becomes non-functional, requires reboot. Root cause = MCU hang
  without watchdog interrupt, only detectable via message timeout, no
  recovery triggered.

**Step 1.4: Hidden Bug Fix Detection**
- "reset device after MCU message timeout" - this is clearly a fix for a
  missing recovery path. Without it, a firmware hang results in a
  permanent stuck state.
- Record: This IS a bug fix. The device becomes permanently stuck
  without it.

---

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- `mcu.c`: +9 lines (in `mt7996_mcu_parse_response`)
- `mac.c`: +5 lines (in `mt7996_reset`)
- Total: ~14 lines added, 0 removed
- Scope: Single-driver, surgical fix in two closely-related functions
- Record: 2 files, +14 lines, functions: mt7996_mcu_parse_response,
  mt7996_reset

**Step 2.2: Code Flow Changes**

Hunk 1 (mcu.c): In `mt7996_mcu_parse_response()`, when `skb == NULL`
(MCU timeout):
- **Before**: Log error, return -ETIMEDOUT. No recovery action.
- **After**: Log error, atomically set `MT76_MCU_RESET` bit (via
  `test_and_set_bit` to prevent duplicates), set `recovery.restart =
  true`, wake up MCU wait queue, queue `reset_work`, wake up
  `reset_wait`, then return -ETIMEDOUT.

Hunk 2 (mac.c): In `mt7996_reset()`, before the existing `queue_work`:
- **Before**: Always queue reset_work and wake reset_wait
  unconditionally.
- **After**: If `MT_MCU_CMD_STOP_DMA` is set, additionally set
  `MT76_MCU_RESET` bit and wake up MCU wait queue, aborting pending MCU
  operations before reset.

**Step 2.3: Bug Mechanism**
- Category: Missing error recovery / permanent hardware stuck state
- The MCU can hang in a way that doesn't trigger a hardware watchdog
  interrupt. The only indication is MCU message timeouts. Without this
  patch, timeouts just return an error code but never trigger device
  recovery. The device becomes permanently non-functional.
- Record: Missing recovery mechanism. MCU hang → timeout → error return
  → no recovery → permanent stuck state.

**Step 2.4: Fix Quality**
- Obviously correct: Mirrors the exact same pattern used in mt7915
  (commit 10f73bb3938f7c5) and mt7915's STOP_DMA handling (commit
  b13cd593ef2402).
- Minimal/surgical: Only adds recovery trigger code at the exact points
  needed.
- `test_and_set_bit` prevents duplicate resets.
- Regression risk: Very low. The reset_work handler already handles
  `recovery.restart = true` properly. The STOP_DMA path already exists
  for other triggers.
- Record: High quality fix, obviously correct, mirrors established
  patterns.

---

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
- `mt7996_mcu_parse_response()`: Unchanged since original driver
  addition by Shayne Chen (commit 98686cd21624c7, November 2022, v6.2).
- `mt7996_reset()`: Added by Bo Jiao (commit 27015b6fbcca83, April 2023,
  v6.4) as "enable full system reset support".
- The buggy code (missing recovery trigger) has been present since the
  driver was first created.
- Record: Bug present since v6.2 (mcu.c) and v6.4 (mac.c had
  mt7996_reset without STOP_DMA handling).

**Step 3.2: No Fixes: Tag**
- N/A - no Fixes: tag present (expected).

**Step 3.3: File History**
- The mt7996 reset infrastructure was significantly improved in v6.18
  (ace5d3b6b49e8 "improve hardware restart reliability"). However, the
  basic recovery mechanism has been in place since v6.4.
- The commit `beb01caa570c52` in v6.18 decreased MCU timeouts to allow
  faster recovery - this patch's logic works with either timeout value.
- Record: This commit is standalone; no prerequisites needed beyond the
  v6.4 reset infrastructure.

**Step 3.4: Author**
- Chad Monroe is a contributor to mt76 (5 commits found in the driver).
- Felix Fietkau (nbd@nbd.name) is THE mt76 subsystem maintainer - he
  applied the patch.
- Felix also authored the identical fix for mt7915 (10f73bb3938f7c5).
- Record: Applied by subsystem maintainer. Author is a regular
  contributor.

**Step 3.5: Dependencies**
- All structures/flags used already exist: `MT76_MCU_RESET`,
  `recovery.restart`, `mcu.wait`, `reset_work`, `reset_wait`,
  `MT_MCU_CMD_STOP_DMA`.
- No new functions or data structures introduced.
- Record: Fully self-contained, no dependencies on other uncommitted
  patches.

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

**Step 4.1: Original Discussion**
- lore.kernel.org returned anti-bot protection; direct web access was
  blocked.
- b4 dig of the mt7915 equivalent found it was part of a 24-patch series
  (v2) by Felix Fietkau from August 2024.
- The mt7996 version is by Chad Monroe and was ported from the mt7915
  fix.
- Record: Could not access lore directly due to anti-bot protection. b4
  confirmed the mt7915 version was part of Felix Fietkau's cleanup
  series.

**Step 4.2: Reviewer**
- Applied by Felix Fietkau, the mt76 subsystem maintainer.
- Record: Subsystem maintainer applied the patch directly.

**Step 4.3-4.5**: Blocked by lore anti-bot protection. No additional
information could be gathered.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions Modified**
- `mt7996_mcu_parse_response()` - MCU response parser (callback)
- `mt7996_reset()` - device reset entry point

**Step 5.2: Callers of `mt7996_mcu_parse_response`**
- Registered as `.mcu_parse_response` in `mt7996_mcu_ops` (mcu.c line
  3363).
- Called from `mt76_mcu_skb_send_and_get_msg()` in `mcu.c` (core mt76
  code, line 122).
- This is the universal MCU message response handler - called for EVERY
  MCU command the driver issues.
- Record: Called for every MCU message. Critical, high-frequency path.

**Step 5.3: Callers of `mt7996_reset`**
- Called from interrupt context and error recovery paths.
- Used by `mt7996_irq_tasklet()` when MCU command interrupts occur.
- Record: Called from interrupt handler / tasklet context.

**Step 5.4: Call Chain**
- Any WiFi operation → MCU command → `mt76_mcu_skb_send_and_get_msg()` →
  wait for response → `mt7996_mcu_parse_response()` → if timeout →
  trigger reset
- This path is reachable from normal WiFi operations (scan, associate,
  channel switch, etc.)
- Record: Fully reachable from normal user operations.

**Step 5.5: Similar Patterns**
- mt7915 has identical recovery logic (10f73bb3938f7c5 +
  b13cd593ef2402).
- mt7921/mt7925 have similar reset mechanisms.
- Record: Well-established pattern across the mt76 driver family.

---

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable Trees**
- mt7996 driver added in v6.2.
- `mt7996_reset()` added in v6.4.
- `mt7996_mcu_parse_response()` unchanged since v6.2.
- The mcu.c part of the fix applies to 6.2+. The mac.c part applies to
  6.4+.
- Affected stable trees: 6.6.y, 6.12.y, and any other active LTS that
  includes mt7996.
- Record: Bug exists in 6.6.y and all later stable trees.

**Step 6.2: Backport Complications**
- The code being modified is unchanged since original introduction.
- Should apply cleanly to 6.6.y.
- Record: Expected clean apply.

**Step 6.3: No Related Fixes Already in Stable**
- No similar fix found in stable trees.
- Record: No existing fix for this issue in stable.

---

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1: Subsystem**
- WiFi driver (drivers/net/wireless/mediatek/mt76/mt7996)
- MT7996 is MediaTek's Wi-Fi 7 (802.11be) chipset - used in routers and
  access points.
- Criticality: IMPORTANT - WiFi is critical infrastructure for many
  users.
- Record: [WiFi driver] [IMPORTANT - affects mt7996 hardware users]

**Step 7.2: Activity**
- Very actively developed - dozens of commits in recent releases.
- Active MLO/Wi-Fi 7 development ongoing.
- Record: Highly active subsystem.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected Users**
- All users of mt7996/mt7992 WiFi hardware (routers, access points, PCIe
  WiFi cards).
- Record: Hardware-specific, but MT7996 is a current-generation popular
  WiFi chipset.

**Step 8.2: Trigger Conditions**
- Triggers when MCU firmware hangs without issuing a watchdog interrupt.
- Can happen during normal operation (firmware bugs, hardware glitches).
- Not user-triggered in the security sense, but can happen during
  routine WiFi operation.
- Record: Firmware hang during normal operation. Not predictable but
  happens in practice (same fix was needed for mt7915).

**Step 8.3: Failure Mode**
- Without the fix: WiFi device becomes permanently non-functional until
  reboot.
- This is a system hang from the WiFi perspective.
- Severity: HIGH (permanent loss of WiFi connectivity, requires reboot)
- Record: Permanent device stuck state. Severity: HIGH.

**Step 8.4: Risk-Benefit Ratio**
- Benefit: HIGH - prevents permanent WiFi device failure, enables
  automatic recovery.
- Risk: VERY LOW - 14 lines, uses `test_and_set_bit` for safety, mirrors
  proven mt7915 pattern, no changes to public APIs or data structures.
- Record: Benefit HIGH, Risk VERY LOW. Excellent ratio.

---

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence Summary**

FOR backporting:
- Fixes permanent device stuck state (WiFi becomes completely non-
  functional)
- Small and surgical fix (14 lines, 2 files in same driver)
- Mirrors identical fix already applied to sister chip mt7915 (proven
  pattern)
- Applied by mt76 subsystem maintainer (Felix Fietkau)
- No dependencies on other patches
- Buggy code present since driver introduction (v6.2/v6.4)
- `test_and_set_bit` prevents duplicate resets (safe concurrent
  behavior)
- Should apply cleanly to stable trees

AGAINST backporting:
- Brief commit message (but supplemented by identical mt7915 fix
  explanation)
- No explicit stable nomination or Reported-by (but this is expected for
  manual review candidates)

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? **YES** - mirrors proven mt7915
   pattern, applied by maintainer
2. Fixes a real bug? **YES** - permanent device stuck state
3. Important issue? **YES** - device becomes permanently non-functional
4. Small and contained? **YES** - 14 lines in single driver
5. No new features or APIs? **YES** - only adds error recovery
6. Can apply to stable? **YES** - code unchanged since introduction

**Step 9.3: Exception Categories**
- Not an exception category - this is a standard bug fix.

**Step 9.4: Decision**
This is a clear bug fix that prevents a permanent device stuck state.
It's small, obviously correct, follows established patterns, and was
applied by the subsystem maintainer. The benefit-to-risk ratio is
excellent.

---

## Verification

- [Phase 1] Parsed tags: Link to patch.msgid, signed by author (Chad
  Monroe) and maintainer (Felix Fietkau)
- [Phase 2] Diff analysis: +9 lines in mcu.c (reset trigger on timeout),
  +5 lines in mac.c (STOP_DMA handling)
- [Phase 3] git blame: mt7996_mcu_parse_response unchanged since
  98686cd21624c7 (v6.2); mt7996_reset from 27015b6fbcca83 (v6.4)
- [Phase 3] git show 10f73bb3938f7c5: confirmed identical mt7915 fix
  exists with clear explanation of the permanent stuck state bug
- [Phase 3] git show b13cd593ef2402: confirmed identical mt7915 STOP_DMA
  handling pattern
- [Phase 3] git log --author: Chad Monroe has 5 commits in mt76, is a
  regular contributor
- [Phase 4] b4 dig: found mt7915 version in Felix Fietkau's series at
  lore
- [Phase 4] lore direct access blocked by anti-bot protection
- [Phase 5] Grep MT76_MCU_RESET: confirmed flag is used across 15+ files
  in mt76 for reset coordination
- [Phase 5] Grep mt7996_mcu_parse_response: confirmed it's registered as
  mcu_ops callback (line 3363)
- [Phase 5] Grep reset_work: confirmed reset_work/reset_wait
  infrastructure exists since v6.4
- [Phase 6] git tag --contains: mt7996_reset present since v6.4; driver
  since v6.2
- [Phase 6] Current 7.0 code confirmed: mt7996_reset lacks STOP_DMA
  handling, parse_response lacks reset trigger
- [Phase 8] Failure mode: permanent WiFi device stuck state requiring
  reboot - severity HIGH
- UNVERIFIED: Exact lore discussion content could not be accessed due to
  anti-bot protection

**YES**

 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index d4f3ee943b472..b7aa51481ce82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2737,6 +2737,11 @@ void mt7996_reset(struct mt7996_dev *dev)
 		return;
 	}
 
+	if (READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA) {
+		set_bit(MT76_MCU_RESET, &dev->mphy.state);
+		wake_up(&dev->mt76.mcu.wait);
+	}
+
 	queue_work(dev->mt76.wq, &dev->reset_work);
 	wake_up(&dev->reset_wait);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index c0c042de477b8..54776f0703876 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -209,6 +209,7 @@ static int
 mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_mcu_rxd *rxd;
 	struct mt7996_mcu_uni_event *event;
 	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
@@ -217,6 +218,14 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (!skb) {
 		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
+
+		if (!test_and_set_bit(MT76_MCU_RESET, &dev->mphy.state)) {
+			dev->recovery.restart = true;
+			wake_up(&dev->mt76.mcu.wait);
+			queue_work(dev->mt76.wq, &dev->reset_work);
+			wake_up(&dev->reset_wait);
+		}
+
 		return -ETIMEDOUT;
 	}
 
-- 
2.53.0


