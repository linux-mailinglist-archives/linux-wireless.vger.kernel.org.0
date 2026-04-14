Return-Path: <linux-wireless+bounces-34739-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOSMLGgk3mmMoAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34739-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 13:26:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797F3F94F6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5C943057133
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE63DC4A0;
	Tue, 14 Apr 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtLwS3nE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CC3DA7FA;
	Tue, 14 Apr 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165916; cv=none; b=m75XkqjS071wRLEgcQyw6DbJ5gdQbYVRHnaNVCBu2NntPvh0zRxQfuBdfc/+P6jZn7ENhpQrNAD/R6gLMicKPcuxjPRODJnIZHSZtuZ1SYPjYylsBJX+JAQmhAvsPtA6dieU/X3j3Rj4YAISEJMLN/OSwCZ+N4VcDd6XvHbuyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165916; c=relaxed/simple;
	bh=Bzr2bh91YAKJAoTSgULgagBtRIPAUCKSWOYnWZMIWOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCct3/tN5YL5fSRNeoMz1HyNCA2JRTt8/EmdndSVppZNWR3PxWiQ1XlewUqysHRtaYYVXmXL/HxxEfx9HYjw8V8N0F+/AA7IusN8rDdad9D7JcfbdUQs360w/OWrPNNd7RXo+WzUZFO6dpKBmRQAbIn0IupCUVatcLYb7qBDxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtLwS3nE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD91C4AF0B;
	Tue, 14 Apr 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776165916;
	bh=Bzr2bh91YAKJAoTSgULgagBtRIPAUCKSWOYnWZMIWOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtLwS3nEsRoIG6sLyMR5oY4H+BOyWTQDhoZAMk5Y79B4YmdI+tfrT5Xpt9V1sbnnZ
	 xFCofmzlHyNjHzI0Qg1qlCaLFwBiT4pLVaRmEDty1/dZUoeJfhovTzqJUy3GWY5hAV
	 MBTKHwzTCC5LOTIPxasO+o27jbSoNbd59d3vXYA4XWd+Rq35TRv6wvVQqlZN4VJ/Rk
	 7+JutFU5uyqlleC0R/m3HwKXrOr4li5grqPFh2G9kTrwMefm4DdBfkwwjPK5aH9obz
	 x2V2j12K52xTITS+i0MlZSmbugK8WK5IZLu0ggJJWoPX7EcQwnCp0OofKMgIbXOzoh
	 0tCyRmPiTiNWA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] wifi: brcmfmac: validate bsscfg indices in IF events
Date: Tue, 14 Apr 2026 07:25:00 -0400
Message-ID: <20260414112509.410217-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414112509.410217-1-sashal@kernel.org>
References: <20260414112509.410217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34739-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,intel.com:email]
X-Rspamd-Queue-Id: 2797F3F94F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 304950a467d83678bd0b0f46331882e2ac23b12d ]

brcmf_fweh_handle_if_event() validates the firmware-provided interface
index before it touches drvr->iflist[], but it still uses the raw
bsscfgidx field as an array index without a matching range check.

Reject IF events whose bsscfg index does not fit in drvr->iflist[]
before indexing the interface array.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260323074551.93530-1-pengpeng@iscas.ac.cn
[add missing wifi prefix]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a complete analysis. Let me
compile the findings.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: brcmfmac`
- Action verb: "validate" — this is adding a missing safety check
- Summary: Adds bounds validation for firmware-provided `bsscfgidx`
  before using it as an array index
- Record: [wifi: brcmfmac] [validate] [add missing bounds check for
  bsscfgidx in IF event handler]

**Step 1.2: Tags**
- `Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>` — author
- `Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>` — Broadcom
  subsystem maintainer acked it
- `Link:
  https://patch.msgid.link/20260323074551.93530-1-pengpeng@iscas.ac.cn`
  — original submission
- `Signed-off-by: Johannes Berg <johannes.berg@intel.com>` — applied by
  wireless maintainer
- No Fixes: tag, no Cc: stable, no Reported-by — expected for manual
  review candidates

**Step 1.3: Commit Body**
- The commit message explains that `brcmf_fweh_handle_if_event()`
  already validates `ifidx` before using it to index `drvr->iflist[]`,
  but does NOT validate `bsscfgidx` before using it the same way.
- Bug: out-of-bounds array access when firmware provides `bsscfgidx >=
  BRCMF_MAX_IFS` (16)
- Failure mode: kernel crash / memory corruption / potential code
  execution

**Step 1.4: Hidden Bug Fix?**
- This IS a bug fix. The word "validate" means adding a missing safety
  check. The commit directly prevents an out-of-bounds array access from
  firmware-controlled data.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Single file: `drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c`
- +5 lines added, 0 removed
- Function modified: `brcmf_fweh_handle_if_event()`
- Scope: single-file surgical fix

**Step 2.2: Code Flow Change**
- BEFORE: `ifevent->bsscfgidx` is used directly as an array index at
  line 157 (`ifp = drvr->iflist[ifevent->bsscfgidx]`) and at line 162
  (`brcmf_add_if(drvr, ifevent->bsscfgidx, ...)`), with no bounds check.
- AFTER: A bounds check `ifevent->bsscfgidx >= BRCMF_MAX_IFS` is added
  before any array access, returning early with an error log if out of
  bounds.
- Only affects the error path for malformed IF events from firmware.

**Step 2.3: Bug Mechanism**
- Category: **Buffer overflow / out-of-bounds array access**
- `drvr->iflist` is declared as `struct brcmf_if *iflist[BRCMF_MAX_IFS]`
  where `BRCMF_MAX_IFS = 16`
- `ifevent->bsscfgidx` is a `u8` from firmware (range 0-255), used as
  index without validation
- This is the SAME class of bug as **CVE-2022-3628**, which was fixed in
  the sibling code path by commit `6788ba8aed4e2`

**Critical insight**: There are TWO separate `bsscfgidx` fields from
firmware:
1. `event->emsg.bsscfgidx` (event message header) — validated by
   CVE-2022-3628 fix in `brcmf_fweh_event_worker()`
2. `ifevent->bsscfgidx` (IF event payload, `struct brcmf_if_event`) —
   **NOT validated** until this commit

For IF events (BRCMF_E_IF), `brcmf_fweh_event_worker()` calls
`brcmf_fweh_handle_if_event()` which uses `ifevent->bsscfgidx` from the
payload, bypassing the header check entirely.

Additionally, `brcmf_add_if()` at `core.c:860` also indexes
`drvr->iflist[bsscfgidx]` without its own bounds check, so the fix
protects that path too.

**Step 2.4: Fix Quality**
- Obviously correct: identical pattern to `ifidx` check 4 lines above
  and `bsscfgidx` check in `brcmf_fweh_event_worker()` at line 275
- Minimal and surgical: 5 lines, one conditional, one log message, one
  return
- Zero regression risk: only rejects malformed firmware events, does not
  change any normal path

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
- The unchecked `drvr->iflist[ifevent->bsscfgidx]` at line 157 was
  introduced by commit `37a869ec859308` (Hante Meuleman, 2015-10-29),
  "brcmfmac: Use consistent naming for bsscfgidx." This was a rename of
  an even older pattern.
- The buggy code has existed since at least 2015, present in ALL active
  stable trees.

**Step 3.2: CVE-2022-3628 (Related Fix)**
- Commit `6788ba8aed4e2` fixed the same bug class (CVE-2022-3628) in
  `brcmf_fweh_event_worker()` but missed the
  `brcmf_fweh_handle_if_event()` path.
- That fix was explicitly Cc'd to stable and applied to all active
  stable trees.
- This current commit completes the original CVE fix.

**Step 3.3: File History**
- The file has minimal recent changes. The last relevant bug fix was
  `6788ba8aed4e2` (the CVE fix). No other patches touch this function.
- This commit is standalone — no dependencies.

**Step 3.4: Author**
- Pengpeng Hou also submitted other security-related bounds-check fixes
  (NFC pn533, bnxt_en, ipv6 ioam6, Bluetooth btusb).

**Step 3.5: Dependencies**
- No dependencies. The check pattern already exists for `ifidx` in the
  same function. Applies cleanly to any tree that has the original code.

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

**Step 4.1-4.2: Patch Discussion**
- Acked by Arend van Spriel (Broadcom brcmfmac maintainer) — no caveats
- Applied by Johannes Berg (wireless maintainer) with only a minor
  subject prefix fixup
- Appears to be accepted on v1 (no version indicator in subject)

**Step 4.3: Bug Report**
- No external bug report — this was found by code inspection (comparing
  against the CVE-2022-3628 fix)

**Step 4.4-4.5: Related Patches**
- Standalone fix, not part of a series.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1-5.2: Functions and Callers**
- `brcmf_fweh_handle_if_event()` is called only from
  `brcmf_fweh_event_worker()` (line 303)
- `brcmf_fweh_event_worker()` is a work queue handler processing
  firmware events
- The firmware events come from the Broadcom WiFi hardware/firmware via
  the event queue

**Step 5.3-5.4: Call Chain**
- Firmware sends events → `brcmf_fweh_process_event()` queues them →
  `brcmf_fweh_event_worker()` processes → `brcmf_fweh_handle_if_event()`
  handles IF events → unchecked array access
- The path is reachable from firmware-provided data. For USB-attached
  Broadcom WiFi devices, a malicious device could craft events with
  arbitrary bsscfgidx values.

**Step 5.5: Similar Patterns**
- The exact same check already exists in `brcmf_fweh_event_worker()` at
  line 275 (for the header's bsscfgidx). This commit adds the equivalent
  check for the payload's bsscfgidx.

## PHASE 6: CROSS-REFERENCING AND STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable Trees**
- The unvalidated `drvr->iflist[ifevent->bsscfgidx]` access has existed
  since at least kernel 3.x (original brcmfmac code from 2012-2015).
- All active stable trees (5.15, 6.1, 6.6, 6.12) contain this bug.
- The CVE-2022-3628 fix (6788ba8aed4e2) is present in stable 5.15+, but
  only covered the worker path.

**Step 6.2: Backport Complications**
- Expected: clean apply. The function has been stable, with no
  structural changes since the CVE fix.
- The 5-line patch touches a single, well-isolated location.

**Step 6.3: Related Fixes Already in Stable**
- CVE-2022-3628 fix is in stable but incomplete — it doesn't cover this
  code path.

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

**Step 7.1: Subsystem Criticality**
- Subsystem: WiFi driver (brcmfmac — Broadcom FullMAC WiFi)
- Criticality: IMPORTANT — widely used in Raspberry Pi, many laptops,
  USB WiFi dongles
- Broadcom WiFi is one of the most common WiFi chipsets in consumer
  hardware

**Step 7.2: Subsystem Activity**
- Moderate activity — recent vendor-specific event handling rework, but
  the core event handler is mature code.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected Users**
- All users with Broadcom brcmfmac WiFi hardware (Raspberry Pi, many
  laptops, USB WiFi adapters)

**Step 8.2: Trigger Conditions**
- Triggered by malicious/buggy firmware sending an IF event with
  `bsscfgidx >= 16`
- For USB WiFi: a malicious USB device can inject arbitrary firmware
  events (physical access attack vector)
- For embedded firmware: a firmware bug could produce out-of-range
  values

**Step 8.3: Failure Mode Severity**
- Out-of-bounds array access on `drvr->iflist[]` (16-element pointer
  array)
- Consequence: kernel crash (GPF/oops), potential memory corruption,
  potential code execution
- Severity: **CRITICAL** (same class as CVE-2022-3628)

**Step 8.4: Risk-Benefit**
- BENEFIT: Very high — prevents kernel crash and potential security
  exploit from firmware-controlled data
- RISK: Very low — 5 lines, identical pattern to existing validated
  checks, zero normal-path impact
- Ratio: Strongly favorable for backporting

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence Compilation**

FOR backporting:
- Fixes an out-of-bounds array access from firmware-controlled data
  (same class as CVE-2022-3628)
- Completes an incomplete CVE fix
- Extremely small (5 lines), obviously correct, identical pattern to
  existing checks
- Acked by Broadcom maintainer, applied by wireless maintainer
- Bug present in ALL stable trees
- Zero regression risk — only rejects malformed firmware events
- Hardware is widely used (Raspberry Pi, laptops, USB WiFi)

AGAINST backporting:
- No reported real-world trigger (found by code audit)
- No CVE assigned (yet) — but same class as CVE-2022-3628

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? **YES** — identical pattern to existing
   checks, Acked by maintainer
2. Fixes a real bug? **YES** — out-of-bounds array access from firmware
   data
3. Important issue? **YES** — kernel crash / security vulnerability
4. Small and contained? **YES** — 5 lines, single file, single function
5. No new features or APIs? **YES** — pure bug fix
6. Can apply to stable? **YES** — clean apply expected, no dependencies

**Step 9.3: Exception Categories**
- Not an exception category — this is a standard, clear-cut
  security/stability bug fix.

**Step 9.4: Decision**
- Overwhelming evidence supports backporting. This is a surgical 5-line
  fix completing a CVE fix that was already backported to stable.

## Verification

- [Phase 1] Parsed tags: Acked-by from Broadcom maintainer, Link to
  patch submission, applied by Johannes Berg
- [Phase 2] Diff analysis: +5 lines in `brcmf_fweh_handle_if_event()`,
  adds bounds check for `ifevent->bsscfgidx` before `drvr->iflist[]`
  indexing
- [Phase 2] Verified TWO separate bsscfgidx fields: `struct
  brcmf_event_msg_be.bsscfgidx` (fweh.h:234) vs `struct
  brcmf_if_event.bsscfgidx` (fweh.h:283) — confirmed different
  structures, different data sources
- [Phase 2] Verified `brcmf_add_if()` at core.c:860 also uses bsscfgidx
  as array index without its own bounds check — this fix protects that
  path too
- [Phase 3] git blame: line 157 (`drvr->iflist[ifevent->bsscfgidx]`)
  introduced by commit 37a869ec859308 (2015-10-29)
- [Phase 3] git show 6788ba8aed4e2: confirmed CVE-2022-3628 fix only
  added bounds check in `brcmf_fweh_event_worker()`, NOT in
  `brcmf_fweh_handle_if_event()`
- [Phase 3] Verified BRCMF_MAX_IFS = 16, iflist array is 16 elements
  (core.h:118)
- [Phase 4] Patch acked by Arend van Spriel (Broadcom maintainer) with
  no caveats
- [Phase 5] Traced call chain: firmware → brcmf_fweh_process_event() →
  queue → brcmf_fweh_event_worker() → brcmf_fweh_handle_if_event() →
  unchecked array access
- [Phase 5] Confirmed event->emsg.bsscfgidx check at line 275 does NOT
  protect ifevent->bsscfgidx used at line 157 (different data fields)
- [Phase 6] Code exists in all active stable trees (5.15, 6.1, 6.6,
  6.12) — verified via git log
- [Phase 6] CVE-2022-3628 fix (6788ba8aed4e2) is in stable since 5.15,
  but incomplete
- [Phase 8] Failure mode: out-of-bounds read/write on pointer array →
  kernel GPF/oops, severity CRITICAL

**YES**

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index c2d98ee6652f3..1d25dc9ebca8b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -153,6 +153,11 @@ static void brcmf_fweh_handle_if_event(struct brcmf_pub *drvr,
 		bphy_err(drvr, "invalid interface index: %u\n", ifevent->ifidx);
 		return;
 	}
+	if (ifevent->bsscfgidx >= BRCMF_MAX_IFS) {
+		bphy_err(drvr, "invalid bsscfg index: %u\n",
+			 ifevent->bsscfgidx);
+		return;
+	}
 
 	ifp = drvr->iflist[ifevent->bsscfgidx];
 
-- 
2.53.0


