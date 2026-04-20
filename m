Return-Path: <linux-wireless+bounces-35069-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BV1NjpM5mkgugEAu9opvQ
	(envelope-from <linux-wireless+bounces-35069-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:54:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00442EB42
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E37435D71BE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1064425CEE;
	Mon, 20 Apr 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4p/m19+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB65425CEA;
	Mon, 20 Apr 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691674; cv=none; b=ks7Zk4ubLjVm3CzFMBtPggY65W0v+MgsPOOgbRvNocchQQXzEyCM0SBnmhwry0W3v0sYto7xffH2/ycBrQzEYRiqXSTQE+hAv5tk1mI+xAjIvqBFlJowBpvXesIaAARV6sRCMP3QJlav0Jy9IjZVLwkCcgIFnCnb5/5IVALsUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691674; c=relaxed/simple;
	bh=ToJ7ExQdL7HGWIM0YNB8YbaFQr4RMeEJEHcofk681Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtIbUsrNWNjiHUE26+PoLc6DVZkWqfKZF/WNAIlee42XkLVJRvpz+fa+6854vy9KX2LJqgQn78kj/DZHlb8bHTzBflPrFp6qX7WdPSo3jKDSFBbzZmqWMlgwT2FwNVB9wunyNsKY6wlAbTjuLkTefEEPN7IazA43JVJZ724N61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4p/m19+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E1AC2BCB6;
	Mon, 20 Apr 2026 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691674;
	bh=ToJ7ExQdL7HGWIM0YNB8YbaFQr4RMeEJEHcofk681Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4p/m19+KdhrsW6n9CU0qLU2k/kq3NHpIZov1Oun133SaRRB577xARhp6i/pwUFG8
	 5TvK9P5V1iMxhxHumH6+LVnCRHKSrVdhvDpyvFAmngY+SDNddbPn8ygwrbphKWsKVW
	 EebPCLZD69BqDcgMrJHhnP+0nk/jBCOnRqMbzwy6p4g4UOiu2uDraYhjz7/q8g/ofD
	 /OR89YZkB08oNZmw24vNrJZuF/UCyBasRO4i5PHqbEMG1XBMXGsjtiR3r19aKYIkrA
	 swzTpQKdBZ0XXUDFs5NOwdyNcvASMPGqK61y7OulR06c+jdBc0g6VaejeDDx+aW1+X
	 ecs4XuBI2Ax+g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: mt76: mt7996: Disable Rx hdr_trans in monitor mode
Date: Mon, 20 Apr 2026 09:19:20 -0400
Message-ID: <20260420132314.1023554-166-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-35069-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 3B00442EB42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 947d63d8cd3b03c7be16875ca90273edbdbe7ce5 ]

Ensure raw frames are captured without header modification.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Link: https://patch.msgid.link/04008426d6cd5de3995beefb98f9d13f35526c25.1770969275.git.ryder.lee@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Good. Now I have all the information needed. Let me compile my analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: mt76: mt7996:` (MediaTek MT7996 WiFi driver)
- Action verb: "Disable" — implies correcting a misconfiguration
- Summary: Disable Rx header translation when monitor mode is active

Record: [wifi: mt76: mt7996] [Disable] [Disable Rx header translation in
monitor mode to ensure raw frames]

**Step 1.2: Tags**
- `Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>` — MediaTek
  employee, regular mt76 contributor
- `Link:` to patch.msgid.link (submission URL)
- `Signed-off-by: Felix Fietkau <nbd@nbd.name>` — mt76 subsystem
  maintainer who merged it
- No Fixes: tag, no Reported-by:, no Cc: stable

Record: Author is a MediaTek contributor. Maintainer Felix Fietkau
merged it.

**Step 1.3: Commit Body**
"Ensure raw frames are captured without header modification." This is
terse but clearly states: without this fix, monitor mode frames are
modified (translated from 802.11 to Ethernet format), which makes
captured frames incorrect/useless.

Record: [Bug: monitor mode captures frames with modified (translated)
headers instead of raw 802.11 frames] [Symptom: packet capture tools see
Ethernet headers instead of 802.11 headers] [Root cause: RX header
translation not disabled when entering monitor mode]

**Step 1.4: Hidden Bug Fix Detection**
This IS a bug fix. "Ensure raw frames are captured" means they currently
are NOT captured correctly. Monitor mode is broken without this fix — it
produces unusable output.

Record: [Yes, this is a clear bug fix. Monitor mode produces incorrectly
formatted frames.]

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- `mt7996/regs.h`: +3 lines (register and bit definitions)
- `mt7996/main.c`: +2 lines (register write to disable/enable hdr_trans)
- Total: +5 lines, 0 removed
- Functions modified: `mt7996_set_monitor()` only
- Scope: Single-file surgical fix (+ supporting register defines)

Record: [2 files, +5 lines, 0 removed] [mt7996_set_monitor()] [Single-
function surgical fix]

**Step 2.2: Code Flow**
Before: `mt7996_set_monitor()` sets `MT_DMA_DCR0_RXD_G5_EN`, updates rx
filter, and sets sniffer mode — but does NOT disable hardware header
translation.
After: Additionally toggles `MT_MDP_DCR0_RX_HDR_TRANS_EN` — disabling it
when monitor=enabled, enabling it when monitor=disabled.

Record: [Before: hdr_trans stays enabled in monitor mode → corrupted
captures. After: hdr_trans properly toggled with monitor mode]

**Step 2.3: Bug Mechanism**
Category: (g) Logic/correctness fix — missing hardware configuration
step.
The hardware's RX header translation converts 802.11 frame headers to
Ethernet headers. In monitor mode, raw 802.11 frames must be captured
unmodified. Not disabling this translation makes monitor mode output
incorrect.

Record: [Missing hardware configuration] [hdr_trans not toggled →
monitor mode frames have wrong headers]

**Step 2.4: Fix Quality**
- Obviously correct: The mt7915 sibling driver does the exact same thing
  (verified at `mt7915/main.c:496`)
- Minimal/surgical: 2 lines of functional code + 3 register defs
- Regression risk: Very low — only affects monitor mode path, standard
  register toggle
- No red flags

Record: [Obviously correct, mirrors mt7915. Minimal. Very low regression
risk.]

## PHASE 3: GIT HISTORY

**Step 3.1: Blame**
The `mt7996_set_monitor()` function was introduced by commit
`69d54ce7491d04` ("wifi: mt76: mt7996: switch to single multi-radio
wiphy") by Felix Fietkau, first appearing in v6.14-rc1. Before v6.14,
monitor mode was handled inline in `mt7996_config()` — also missing
hdr_trans disable.

Record: [Buggy code introduced in 69d54ce7491d04, v6.14. Older code
(v6.12 and before) also lacked this but had different code structure.]

**Step 3.2: Fixes tag**
No Fixes: tag present (expected).

**Step 3.3: File History**
Recent changes to main.c show numerous MLO/MLD fixes. The
`cb423ddad0f6e` commit fixed a NULL deref in the same
`mt7996_set_monitor()` function (moved `dev = phy->dev` after the NULL
check). This prerequisite is already in the current tree.

Record: [cb423ddad0f6e is a prerequisite that's already applied. No
other dependencies found.]

**Step 3.4: Author**
Ryder Lee is a regular MediaTek contributor to mt76 with multiple
accepted patches.

Record: [Regular MediaTek contributor to the subsystem]

**Step 3.5: Dependencies**
The patch adds `MT_MDP_DCR0` and `MT_MDP_DCR0_RX_HDR_TRANS_EN` register
definitions and uses them. Self-contained — no external dependencies
beyond the function already existing.

The function `mt7996_set_monitor()` only exists from v6.14+. For v6.14.y
backport, the NULL deref fix `cb423ddad0f6e` would need to be present
first (or the patch adapted to the pre-fix code).

Record: [Self-contained. Applies to v6.14+ where mt7996_set_monitor()
exists.]

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.5:**
Lore was not accessible due to anti-bot protection. The Link: in the
commit points to `patch.msgid.link/04008426d6cd5de3995beefb98f9d13f35526
c25.1770969275.git.ryder.lee@mediatek.com`. B4 dig did not find the
commit (likely not in the local repo under that hash).

Record: [UNVERIFIED: Could not access lore or b4 dig results. However,
Felix Fietkau (mt76 maintainer) signed off on the merge, confirming
maintainer review.]

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions modified**
`mt7996_set_monitor()` — a static function in main.c.

**Step 5.2: Callers**
`mt7996_set_monitor()` is called from:
- `mt7996_add_interface()` when `vif->type == NL80211_IFTYPE_MONITOR`
  (line 501)
- `mt7996_remove_interface()` when monitor mask changes (line 547)

These are standard mac80211 callbacks triggered when a user adds/removes
a monitor interface (e.g., `iw dev wlan0 set type monitor`).

Record: [Called from mac80211 interface add/remove — standard user-
triggered path]

**Step 5.3: What it calls**
`mt76_rmw_field()` — standard register read-modify-write. This is a
well-tested primitive.

**Step 5.4: Reachability**
User creates a monitor interface → mac80211 → `mt7996_add_interface()` →
`mt7996_set_monitor()`. Fully reachable from userspace.

Record: [Reachable via standard WiFi monitor mode interface creation]

**Step 5.5: Similar patterns**
The mt7915 driver has the exact same pattern at `mt7915/main.c:496`:

```494:495:drivers/net/wireless/mediatek/mt76/mt7915/main.c
                mt76_rmw_field(dev, MT_DMA_DCR0(band),
MT_MDP_DCR0_RX_HDR_TRANS_EN,
                               !dev->monitor_mask);
```

This confirms the fix is correct and needed — the mt7996 was simply
missing this step.

Record: [mt7915 already has this exact pattern. mt7996 was missing it.]

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Does buggy code exist in stable trees?**
- `mt7996_set_monitor()` was introduced in v6.14 (commit
  `69d54ce7491d04`)
- Does NOT exist in v6.12 or v6.13 (confirmed via `git show v6.12:...`
  and `git show v6.13:...`)
- The older monitor code path (in `mt7996_config()`) also lacked
  hdr_trans disable, but has different structure
- Applicable stable trees: v6.14.y and later (v6.14 has active stable
  releases through v6.14.11)

Record: [Buggy code exists in 6.14.y. Older trees have different code
structure with same bug.]

**Step 6.2: Backport complications**
- For 6.14.y: The `dev` initialization is before the NULL check
  (pre-`cb423ddad0f6e`), but the patch insertion point is identical.
  Minor context difference but patch should apply or need trivial
  adjustment.
- `MT_MDP_DCR0` register definitions don't exist in 6.14.y's regs.h
  (confirmed), so the register defs must come with the patch (they do).

Record: [6.14.y: Near-clean apply, minor context difference from NULL
deref fix]

**Step 6.3: Related fixes already in stable**
No evidence of a different fix for this same issue in any stable tree.

Record: [No prior fix found]

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

**Step 7.1:** WiFi driver (mt76/mt7996) — IMPORTANT subsystem. MT7996 is
MediaTek's WiFi 7 chipset used in access points and routers.

**Step 7.2:** Very active subsystem — 73 changes between v6.14 and v7.0
in this single file.

Record: [IMPORTANT subsystem, very active development]

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected users**
All users of MT7996/MT7992 WiFi hardware who use monitor mode for packet
capture or WiFi analysis.

**Step 8.2: Trigger conditions**
Trigger: Enable monitor mode on an mt7996 device. Every user of monitor
mode is affected. Common operation for network administrators, WiFi
developers, and security researchers.

**Step 8.3: Failure mode severity**
Not a crash — but monitor mode produces incorrect/corrupted frame
captures. The feature is essentially non-functional. Severity: MEDIUM-
HIGH (complete functional failure of a core WiFi feature).

**Step 8.4: Risk-benefit**
- BENEFIT: HIGH — fixes completely broken monitor mode on mt7996
  hardware
- RISK: VERY LOW — 2 lines toggling a hardware register bit, same
  pattern as mt7915, only affects monitor mode code path
- Ratio: Very favorable

Record: [Benefit HIGH, Risk VERY LOW. 5-line patch fixing broken monitor
mode.]

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence compilation**

FOR backporting:
- Fixes a real functional bug: monitor mode captures are corrupted
- Small, surgical fix: +5 lines total (2 functional + 3 register defs)
- Obviously correct: mirrors mt7915 sibling driver behavior
- Maintainer-reviewed: Felix Fietkau signed off
- Author is a MediaTek contributor who knows the hardware
- Low regression risk: only affects monitor mode path
- Reachable from userspace via standard WiFi operations

AGAINST backporting:
- No crash/security/data corruption — "just" broken monitor mode output
- No Fixes: tag, no Reported-by: (no evidence of user complaints)
- Only applies to v6.14+ (limited stable tree scope)
- Terse commit message doesn't call this a "fix"

**Step 9.2: Stable rules checklist**
1. Obviously correct and tested? YES — mirrors mt7915, accepted by
   maintainer
2. Fixes a real bug? YES — monitor mode doesn't work correctly
3. Important issue? MEDIUM-HIGH — complete functional failure of monitor
   mode
4. Small and contained? YES — 5 lines, 1 function
5. No new features/APIs? CORRECT — no new features
6. Can apply to stable? YES for v6.14.y (with possible minor context
   adaptation)

**Step 9.3: Exception categories**
This is a hardware configuration bug fix, not an exception category.

**Step 9.4: Decision**
This is a small, obviously correct bug fix that restores monitor mode
functionality on MT7996 hardware. The fix mirrors what the mt7915 driver
already does, is reviewed by the subsystem maintainer, and has very low
regression risk. While it doesn't fix a crash, it fixes complete
functional breakage of a core WiFi feature (monitor mode).

**Verification:**
- [Phase 1] Parsed tags: Signed-off-by from MediaTek employee and mt76
  maintainer. No Fixes/Reported-by.
- [Phase 2] Diff analysis: +2 lines in mt7996_set_monitor() toggling
  MT_MDP_DCR0_RX_HDR_TRANS_EN, +3 lines register definitions in regs.h
- [Phase 3] git blame: mt7996_set_monitor() introduced in 69d54ce7491d04
  (v6.14-rc1)
- [Phase 3] Verified mt7996_set_monitor() does NOT exist in v6.12 or
  v6.13 (git show confirmed)
- [Phase 3] cb423ddad0f6e is a prerequisite NULL deref fix already in
  tree
- [Phase 4] UNVERIFIED: Lore/b4 not accessible due to anti-bot
  protection
- [Phase 5] grep confirmed mt7915/main.c:496 has identical hdr_trans
  disable pattern
- [Phase 5] Callers: mt7996_add_interface() and
  mt7996_remove_interface() — standard mac80211 callbacks
- [Phase 6] v6.14 regs.h confirmed: MT_MDP_DCR0 not defined, MT_MDP_DCR2
  exists at line 136
- [Phase 6] v6.14.y is the earliest applicable stable tree
- [Phase 7] Active subsystem: 73 commits between v6.14 and v7.0 in
  main.c
- [Phase 8] Failure mode: monitor mode captures have translated (wrong)
  headers — feature non-functional

**YES**

 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f16135f0b7f94..110b9a32e5ec8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -472,6 +472,8 @@ static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
 
 	mt76_rmw_field(dev, MT_DMA_DCR0(phy->mt76->band_idx),
 		       MT_DMA_DCR0_RXD_G5_EN, enabled);
+	mt76_rmw_field(dev, MT_MDP_DCR0,
+		       MT_MDP_DCR0_RX_HDR_TRANS_EN, !enabled);
 	mt7996_phy_set_rxfilter(phy);
 	mt7996_mcu_set_sniffer_mode(phy, enabled);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index e48e0e575b646..393faae2d52b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -159,6 +159,9 @@ enum offs_rev {
 #define MT_MDP_BASE				0x820cc000
 #define MT_MDP(ofs)				(MT_MDP_BASE + (ofs))
 
+#define MT_MDP_DCR0				MT_MDP(0x800)
+#define MT_MDP_DCR0_RX_HDR_TRANS_EN		BIT(19)
+
 #define MT_MDP_DCR2				MT_MDP(0x8e8)
 #define MT_MDP_DCR2_RX_TRANS_SHORT		BIT(2)
 
-- 
2.53.0


