Return-Path: <linux-wireless+bounces-35057-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MF5LLgu5mliswEAu9opvQ
	(envelope-from <linux-wireless+bounces-35057-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:48:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D5F42C4C4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAFC43022A8E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F034E3D522C;
	Mon, 20 Apr 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0TGapmy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6A3D47DD;
	Mon, 20 Apr 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691420; cv=none; b=JUAHylv5Ub+6aPj1xnTegcuz/x8Z69pe6U7CFPOk8y9RiW82UKP2qNMKbr7P+Lm0rrUaiUuZ3ueAwwNMtmGxoZ1G3PIu3WPpUjKfpVf152chMltghXAvvSsEXDPtvOWjKJgYBnIsuvjEWf49xkWy+7lkAUrLBr++bmsKQ2ulIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691420; c=relaxed/simple;
	bh=cNGyNEfbHOaX+mqn2fFZRBv+MY/EX7TyQpYcmO5pWaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oA5kanHIAjGFiy3mpQMk+ZdaherTNzoSDbkogYZ93X5sYR+sRdMAgL6weWgLvgUapBYxUwueDB7xTXezHGt2V5L7V5kg0VsE3vXSjXeUAoo2ymS70BvquTg0dHOaBn6/xukhtht5LXYpXwjqHMRPD9mzJJhz0hKUnRb5/BcP+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0TGapmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE21C19425;
	Mon, 20 Apr 2026 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691420;
	bh=cNGyNEfbHOaX+mqn2fFZRBv+MY/EX7TyQpYcmO5pWaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0TGapmyJu5rKwtzUDu2xfzDwNEn7XlNrHLPcVW6D/JjEqtr83gWkWLqTzaJvBn/a
	 8yfV0z/rWinHEGmrrLlibp8mar0bjp8JynQ1gO2wmJmT/vbeshlGbcG7ha9B128VdA
	 makdrGxMBlfPIw4UbQnw1UvkULcPNx+DnN6dUgYYhtSyRBJkQTYCNkeDam+A1lWp2q
	 7dgVo6PC+kkPN8snQPo9pR+ZpPWZ/5ANTKQNymDA7JFLzmmnmGBIh4OCr43U+Jtkha
	 dGYPPJMbG2g0DkAvTXQz8GXggqCiXBDOzCexWixqGMFsfNR9PWBk+o+FND7c8yIbag
	 5Ax0VDI6C/UEg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Oleksandr Havrylov <goainwo@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: rtw88: add quirks to disable PCI ASPM and deep LPS for HP P3S95EA#ACB
Date: Mon, 20 Apr 2026 09:16:50 -0400
Message-ID: <20260420132314.1023554-16-sashal@kernel.org>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35057-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 89D5F42C4C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit b2bf9d61e14af4129362aeb9c10034229a6d8f08 ]

On an HP laptop (P3S95EA#ACB) equipped with a Realtek RTL8821CE 802.11ac
PCIe adapter (PCI ID: 10ec:c821), the system experiences a hard lockup
(complete freeze of the UI and kernel, sysrq doesn't work, requires
holding the power button) when the WiFi adapter enters the power
saving state. Disable PCI ASPM to avoid system freeze.

In addition, driver throws messages periodically. Though this doesn't
always cause unstable connection, missing H2C commands might cause
unpredictable results. Disable deep LPS to avoid this as well.

 rtw88_8821ce 0000:13:00.0: firmware failed to leave lps state
 rtw88_8821ce 0000:13:00.0: failed to send h2c command
 rtw88_8821ce 0000:13:00.0: failed to send h2c command

Tested on HP Notebook P3S95EA#ACB (kernel 6.19.7-1-cachyos):

  - No hard freeze observed during idle or active usage.
  - Zero h2c or lps errors in dmesg across idle (10 min),
    load stress (100MB download), and suspend/resume cycle.
  - Both quirk flags confirmed active via sysfs without any
    manual modprobe parameters.

Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Oleksandr Havrylov <goainwo@gmail.com>
Link: https://patch.msgid.link/20260316035635.16550-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information I need. Let me compile my analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
**Record:** [wifi: rtw88] [add quirks] [Adds DMI-based quirks to disable
PCI ASPM and deep LPS for a specific HP laptop model]

### Step 1.2: Tags
- **Reported-by:** Oleksandr Havrylov <goainwo@gmail.com> — a real user
  reporting the bug
- **Closes:** lore.kernel.org link to original bug report
- **Signed-off-by:** Ping-Ke Shih <pkshih@realtek.com> — Realtek's rtw88
  maintainer
- **Tested-by:** Oleksandr Havrylov <goainwo@gmail.com> — reporter
  confirmed the fix works
- **Link:** patch.msgid.link for the submission

No Fixes: tag (expected for this type of quirk addition). No Cc: stable
(expected). Author is the rtw88 subsystem maintainer.

### Step 1.3: Commit Body Analysis
- **Bug:** HP laptop (P3S95EA#ACB) with RTL8821CE WiFi experiences
  **hard lockup** (complete system freeze, SysRq unresponsive, requires
  power button) when WiFi adapter enters power saving state
- **Secondary issue:** Firmware error messages ("failed to leave lps
  state", "failed to send h2c command") suggesting broken power
  management communication
- **Testing evidence:** Detailed test plan with idle, load, and
  suspend/resume validation on 6.19.7 kernel
- **Failure mode:** CRITICAL — hard lockup requiring power cycle

### Step 1.4: Hidden Bug Fix Detection
**Record:** This is NOT a hidden bug fix — it's an explicit hardware
quirk/workaround for a specific device that causes system-wide hard
lockups. This falls squarely into the "hardware quirk" exception
category for stable.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- `main.h`: +5 lines — new enum `rtw_quirk_dis_caps` with 2 values
- `pci.c`: +31 lines — DMI include, callback function, quirk table,
  `dmi_check_system()` call
- Total: **+36 lines, 0 removed**
- Functions modified: `rtw_pci_probe()` (1 line added). New:
  `rtw_pci_disable_caps()` callback
- Scope: Single-driver, self-contained

### Step 2.2: Code Flow Change
1. New enum provides named constants for quirk capability bits
2. `rtw_pci_disable_caps()`: DMI callback that sets
   `rtw_pci_disable_aspm` and/or `rtw_disable_lps_deep_mode` global
   bools to true based on bitmask in driver_data
3. `rtw_pci_quirks[]`: DMI table matching HP vendor + "HP Notebook"
   product + "P3S95EA#ACB" SKU
4. `dmi_check_system()` call added in `rtw_pci_probe()` before
   `rtw_core_init()`, so quirks are set before driver initialization
   uses those globals

### Step 2.3: Bug Mechanism
**Category: Hardware workaround (DMI quirk)**
- The quirk sets the same module-level bools (`rtw_pci_disable_aspm`,
  `rtw_disable_lps_deep_mode`) that existing module parameters expose
- These bools are already checked in `rtw_pci_clkreq_set()`,
  `rtw_pci_aspm_set()`, and `rtw_update_lps_deep_mode()`
- The mechanism simply automates what a user would do with `modprobe
  rtw88_pci disable_aspm=Y` + `rtw88_core disable_lps_deep=Y`

### Step 2.4: Fix Quality
- **Obviously correct:** Uses standard DMI matching infrastructure. Sets
  existing, well-tested booleans. The same mechanism already works via
  module parameters.
- **Minimal and surgical:** Only affects the specific HP laptop model
  with the matching DMI strings. No behavioral change for any other
  system.
- **Regression risk:** Essentially zero — only changes behavior on one
  specific laptop, and only disables power saving features that cause
  lockups on that device.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
- `rtw_pci_disable_aspm` introduced by commit `68aa716b7dd36f`
  (2020-07-15) — present since ~v5.9
- `rtw_disable_lps_deep_mode` introduced by commit `fc3ac64a3a2868`
  (2020-10-30) — present since ~v5.10
- Both variables are available in ALL active stable trees

### Step 3.2: No Fixes tag — N/A

### Step 3.3: File History
The pci.c file is moderately active. The eb101d2abdccc commit (upstream
bridge check) touches a different part of the file and does NOT conflict
with this patch. The quirk insertion point (after `rtw_pci_err_handler`
export and before `rtw_pci_probe`) and the `dmi_check_system()`
insertion point (in `rtw_pci_probe` before `rtw_core_init`) are both
clean in the current v7.0 tree.

### Step 3.4: Author
Ping-Ke Shih (pkshih@realtek.com) is the **rtw88 subsystem maintainer**
at Realtek. He maintains the rtw tree and has many commits across the
rtw88 codebase.

### Step 3.5: Dependencies
- The patch is **fully standalone** — no prerequisites needed
- It only references existing global variables and standard kernel DMI
  infrastructure
- The enum addition in main.h is self-contained

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1: Original Discussion
- b4 dig found the submission at
  `20260316035635.16550-1-pkshih@realtek.com`
- Only v1 — no revisions needed. Clean acceptance.
- Thread from mbox: The reporter (Oleksandr Havrylov) provided detailed
  Tested-by with positive results.
- Maintainer (Ping-Ke Shih) acknowledged the test and added Tested-by to
  the commit message.

### Step 4.2: Reviewers
- linux-wireless@vger.kernel.org was CC'd
- Reporter provided Tested-by — direct confirmation the fix works

### Step 4.3: Bug Report
- Closes link points to the original bug report email from the user
- Single reporter but the issue is deterministic: hard lockup when WiFi
  enters power saving

### Step 4.4: Series Context
- Single standalone patch, not part of a series

### Step 4.5: Stable Discussion
- No specific stable discussion found. No Cc: stable on the original
  patch.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Functions
- `rtw_pci_disable_caps()` — new callback, only called by
  `dmi_check_system()`
- `rtw_pci_probe()` — modified to call `dmi_check_system()`

### Step 5.2: Callers
- `rtw_pci_probe()` is the PCI probe function called for every rtw88
  PCIe device during driver loading — common path
- `rtw_pci_disable_aspm` is checked in `rtw_pci_clkreq_set()` and
  `rtw_pci_aspm_set()` — called during power state transitions
- `rtw_disable_lps_deep_mode` is checked in `rtw_update_lps_deep_mode()`
  — called during firmware init

### Step 5.3-5.5: Call Chain
The quirk only sets global booleans that are already checked in existing
code paths. No new logic branches introduced.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Code Exists in Stable
- `rtw_pci_disable_aspm` exists since v5.9 (commit 68aa716b7dd36f)
- `rtw_disable_lps_deep_mode` exists since v5.10 (commit fc3ac64a3a2868)
- The RTL8821CE driver exists in all active stable trees
- **The buggy behavior exists in all stable trees supporting this
  hardware**

### Step 6.2: Backport Complications
- The patch should apply cleanly or with minimal offset to all active
  stable trees
- The insertion points (after EXPORT_SYMBOL, before probe function,
  inside probe) are stable
- No conflicting structural changes in this area

### Step 6.3: No related fixes already in stable for this specific
laptop

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: Subsystem
- **drivers/net/wireless/realtek/rtw88** — WiFi driver for Realtek
  chipsets
- **Criticality: IMPORTANT** — RTL8821CE is a widely-used WiFi adapter
  in consumer laptops
- RTW88 is an active, well-maintained in-tree driver

### Step 7.2: Activity
- Actively maintained by Realtek engineers (Ping-Ke Shih is the
  maintainer)

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
- Users of the specific HP laptop model (P3S95EA#ACB) with RTL8821CE
  WiFi adapter
- DMI matching is narrowly scoped (vendor + product + SKU)

### Step 8.2: Trigger Conditions
- **Trigger:** WiFi adapter enters power saving state — this happens
  automatically during normal idle usage
- **Frequency:** Very common — happens during any period of idle WiFi
  usage
- **Deterministic:** The lockup is reproducible

### Step 8.3: Failure Mode Severity
- **Hard lockup** — system completely freezes, SysRq unresponsive,
  requires holding power button
- **Severity: CRITICAL** — total system unavailability, potential data
  loss from unclean shutdown

### Step 8.4: Risk-Benefit
- **Benefit: HIGH** — prevents deterministic hard lockups on affected
  hardware
- **Risk: VERY LOW** — only affects one specific laptop model; uses
  existing, well-tested disable mechanisms; is functionally identical to
  module parameters that already exist
- **Ratio: Excellent** — high benefit, near-zero regression risk

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Compilation

**FOR backporting:**
- Fixes deterministic hard lockups (CRITICAL severity)
- Small, self-contained change (+36 lines, single driver)
- Written by the subsystem maintainer (Ping-Ke Shih at Realtek)
- Tested and confirmed working by the reporter
- Uses standard DMI quirk pattern already used in other drivers (ath9k,
  etc.)
- Only automates existing module parameter functionality
- Zero regression risk for non-affected systems (narrow DMI match)
- The underlying infrastructure (module params) exists in all stable
  trees since v5.10
- Hardware quirk = explicitly allowed exception for stable

**AGAINST backporting:**
- No explicit Cc: stable (expected — that's why we're reviewing it)
- Adds new code rather than modifying existing code (but this is
  inherent to quirk additions)

### Step 9.2: Stable Rules Checklist
1. **Obviously correct and tested?** YES — uses standard DMI matching,
   confirmed by Tested-by
2. **Fixes a real bug?** YES — hard lockup reported and reproduced by a
   user
3. **Important issue?** YES — CRITICAL: hard lockup requiring power
   cycle
4. **Small and contained?** YES — 36 lines, 2 files, single driver
5. **No new features?** YES — disables power features that cause
   lockups; no new user-visible behavior
6. **Can apply to stable?** YES — clean, standalone, no dependencies

### Step 9.3: Exception Category
**Hardware quirk/workaround** — DMI-based quirk to disable broken power
management on specific hardware. This is an explicitly allowed exception
for stable trees.

---

## Verification

- [Phase 1] Parsed tags: Reported-by from real user, Tested-by from same
  user, author is rtw88 maintainer
- [Phase 2] Diff: +36 lines across 2 files (main.h enum + pci.c DMI
  table + probe call), no code removed
- [Phase 3] git blame: `rtw_pci_disable_aspm` from 68aa716b7dd36f
  (2020-07-15), `rtw_disable_lps_deep_mode` from fc3ac64a3a2868
  (2020-10-30) — both present in all active stable trees
- [Phase 3] git log: no dependencies identified; eb101d2abdccc touches
  different code area
- [Phase 4] b4 dig -c b2bf9d61e14af: found at
  https://patch.msgid.link/20260316035635.16550-1-pkshih@realtek.com
- [Phase 4] b4 dig -a: only v1, clean acceptance with no revisions
- [Phase 4] b4 dig -w: linux-wireless list and reporter CC'd
- [Phase 4] mbox: reporter confirmed fix with detailed test (idle, load,
  suspend/resume)
- [Phase 5] `rtw_pci_disable_aspm` checked in `rtw_pci_clkreq_set()` and
  `rtw_pci_aspm_set()`; `rtw_disable_lps_deep_mode` checked in
  `rtw_update_lps_deep_mode()` — all existing code paths
- [Phase 6] Code infrastructure exists in all active stable trees
  (v5.10+), patch is standalone
- [Phase 6] Diff against v7.0 shows clean insertion points with no
  conflicts
- [Phase 7] ath9k uses identical `dmi_check_system` quirk pattern,
  establishing precedent
- [Phase 8] Failure mode: hard lockup (CRITICAL), triggers during normal
  idle WiFi usage

**YES** — This is a textbook hardware quirk that prevents deterministic
hard lockups on specific hardware. It uses standard DMI matching
infrastructure, is written by the subsystem maintainer, tested by the
reporter, adds only 36 lines, has zero regression risk for unaffected
systems, and the underlying mechanism already exists in all stable
trees.

**YES**

 drivers/net/wireless/realtek/rtw88/main.h |  5 ++++
 drivers/net/wireless/realtek/rtw88/pci.c  | 31 +++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 1ab70214ce36e..55b794d4584c4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -432,6 +432,11 @@ enum rtw_wow_flags {
 	RTW_WOW_FLAG_MAX,
 };
 
+enum rtw_quirk_dis_caps {
+	QUIRK_DIS_CAP_PCI_ASPM,
+	QUIRK_DIS_CAP_LPS_DEEP,
+};
+
 /* the power index is represented by differences, which cck-1s & ht40-1s are
  * the base values, so for 1s's differences, there are only ht20 & ofdm
  */
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 56b16186d3aa4..ca26e0a7f538f 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "main.h"
@@ -1744,6 +1745,34 @@ const struct pci_error_handlers rtw_pci_err_handler = {
 };
 EXPORT_SYMBOL(rtw_pci_err_handler);
 
+static int rtw_pci_disable_caps(const struct dmi_system_id *dmi)
+{
+	uintptr_t dis_caps = (uintptr_t)dmi->driver_data;
+
+	if (dis_caps & BIT(QUIRK_DIS_CAP_PCI_ASPM))
+		rtw_pci_disable_aspm = true;
+
+	if (dis_caps & BIT(QUIRK_DIS_CAP_LPS_DEEP))
+		rtw_disable_lps_deep_mode = true;
+
+	return 1;
+}
+
+static const struct dmi_system_id rtw_pci_quirks[] = {
+	{
+		.callback = rtw_pci_disable_caps,
+		.ident = "HP Notebook - P3S95EA#ACB",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Notebook"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "P3S95EA#ACB"),
+		},
+		.driver_data = (void *)(BIT(QUIRK_DIS_CAP_PCI_ASPM) |
+					BIT(QUIRK_DIS_CAP_LPS_DEEP)),
+	},
+	{}
+};
+
 int rtw_pci_probe(struct pci_dev *pdev,
 		  const struct pci_device_id *id)
 {
@@ -1771,6 +1800,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	rtwpci = (struct rtw_pci *)rtwdev->priv;
 	atomic_set(&rtwpci->link_usage, 1);
 
+	dmi_check_system(rtw_pci_quirks);
+
 	ret = rtw_core_init(rtwdev);
 	if (ret)
 		goto err_release_hw;
-- 
2.53.0


