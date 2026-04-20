Return-Path: <linux-wireless+bounces-35081-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA6bL0hC5mlxtwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35081-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:12:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530E42DE53
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07B43336015D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6C94A2E17;
	Mon, 20 Apr 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH72oSSl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CA3AC0EF;
	Mon, 20 Apr 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691962; cv=none; b=o9R6l1qQZ6MAp9Sep9OkZJSwg3KALZrOoa7iLtyjURPpsRiMp5JOEqzDpHb6oyNIUUxpV9Yg31QUK9Z4QFb2/wVyZfe6Nv8jR4WJExRpzNIAVfoKBcW7GMjIC0roT1hHgUabqIoGixt8RRFNTkeWVZ4sJoiMmG8FjjdabBJKauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691962; c=relaxed/simple;
	bh=eGzhoL+9ItleeULCSIk5g1DY5q8ohXKhvnZBWAIftTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cefwzZd6GTuBzTKoH0fhuFSK4D3vcto8KSMfNT/MhKx4scfmed9/bP33LeRr5YOoutz9XhQ5QLzIQX76+GnDkwuPMTgefBFMh1741fduHqNbPwRBoLGAUrv+Rp70314AB4HsoQrMAg2ktozz4SBZUhDc4J1vFOEEnHaPNz6QcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH72oSSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84238C19425;
	Mon, 20 Apr 2026 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691962;
	bh=eGzhoL+9ItleeULCSIk5g1DY5q8ohXKhvnZBWAIftTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RH72oSSlOMreQWk6k3PhRuidp+65pU6ukXtMTaGFPNCeD8UQhSsJKuW0z1rAjtuVE
	 8A2aAO3PYgUzpi8bv89jijMXUTuuVN4vAn1hmjiuFqR7Brx/9kRV4bgm6BZioFmEk3
	 MFhPX0w0TuPNDUT1jOQPPP6ZUm0hYRhgRAywdAv5vlnWV3uY0OfaeH18TwVUzPVxaA
	 JJH8Lm/mkUOUZwXfFQvCz9ytxBhkB2aSixPdB8+91c2kE3WSLyuVkiOOnTj9ZRAH7N
	 UrGw6buNKYBMgfyavD+fxR/jaJqeg61aMFu76gPfQjrk2XVSVRhMarBiwKe0PXy6u1
	 kVNl2lYXwgs2A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Oleksandr Havrylov <goainwo@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: rtw88: validate RX rate to prevent out-of-bound
Date: Mon, 20 Apr 2026 09:21:27 -0400
Message-ID: <20260420132314.1023554-293-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35081-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5530E42DE53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit bf14367719fa86f7c6922c64d37a2df347954c66 ]

The reported RX rate might be unexpected, causing kernel warns:

  Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
  WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [mac80211]

As the RX rate can be index of an array under certain conditions, validate
it to prevent accessing array out-of-bound potentially.

Tested on HP Notebook P3S95EA#ACB (kernel 6.19.9-1-cachyos):

  - No WARNING: net/mac80211/rx.c:5491 observed after the v2 patch.
The unexpected `NSS: 0, MCS: 0` VHT rate warnings are successfully
mitigated.
  - The system remains fully stable through prolonged idle periods,
high network load, active Bluetooth A2DP usage, and multiple deep
suspend/resume cycles.
  - Zero h2c timeouts or firmware lps state errors observed in dmesg.

Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com/
Tested-by: Oleksandr Havrylov <goainwo@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260324011001.5742-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Here is my complete analysis:

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: rtw88`
- Action verb: "validate" (to "prevent out-of-bound")
- Summary: Adds bounds check on RX rate from hardware to prevent out-of-
  bounds array access
- Record: [wifi: rtw88] [validate/prevent] [bounds check on HW-reported
  RX rate]

**Step 1.2: Tags**
- `Reported-by: Oleksandr Havrylov <goainwo@gmail.com>` — real user
  report
- `Closes:` lore link to original bug report
- `Tested-by: Oleksandr Havrylov <goainwo@gmail.com>` — reporter
  confirmed fix
- `Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>` — Realtek WiFi
  maintainer authored the fix
- `Link:` to patch.msgid.link for the v1 submission
- No Fixes: tag, no Cc: stable — expected for manual review candidate
- Record: Real user-reported and user-tested fix by subsystem
  maintainer.

**Step 1.3: Commit Body**
- Bug: Hardware reports unexpected RX rate values, causing a kernel
  WARNING from mac80211: `"Rate marked as a VHT rate but data is
  invalid: MCS: 0, NSS: 0"` at `ieee80211_rx_list+0x183/0x1020`
- Since rate is used as array index, values >= DESC_RATE_MAX lead to
  out-of-bounds access
- Extensive testing on HP Notebook P3S95EA#ACB: no warnings, stable
  through idle, high load, Bluetooth A2DP, and suspend/resume cycles
- Record: Bug = invalid HW rate → WARNING in mac80211 + OOB array
  access. Symptom = repeated kernel WARNING. Tested on real hardware.

**Step 1.4: Hidden Bug Fix Detection**
- Not hidden — explicitly described as preventing out-of-bounds access
  and kernel warnings. This is a clear bug fix.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Files changed: 1 (`drivers/net/wireless/realtek/rtw88/rx.c`)
- Lines added: +8 (7 lines of code + 1 blank line)
- Lines removed: 0
- Function modified: `rtw_rx_query_rx_desc()`
- Scope: single-file, single-function, surgical fix
- Record: 1 file, +8/-0 lines, one function, very small scope

**Step 2.2: Code Flow Change**
- **Before**: `pkt_stat->rate` read from hardware descriptor (7-bit
  field, values 0-127) and used directly in downstream code with no
  validation
- **After**: If `pkt_stat->rate >= DESC_RATE_MAX` (84), a debug message
  is logged, and rate is clamped to `DESC_RATE1M` (0) with BW set to
  20MHz
- This is an early validation check placed right after the rate is read
  from hardware, before any downstream usage

**Step 2.3: Bug Mechanism**
The RX rate field is `GENMASK(6, 0)` = 7 bits, supporting values 0-127
from hardware. But `DESC_RATE_MAX = 0x54 = 84`. Two concrete bugs:

1. **Out-of-bounds array write** (line 99):
   `cur_pkt_cnt->num_qry_pkt[pkt_stat->rate]++` where array size is
   `DESC_RATE_MAX` (84 elements). Rate >= 84 corrupts memory.

2. **Invalid VHT encoding to mac80211** (lines 215-231): Rate >=
   `DESC_RATEVHT1SS_MCS0` (0x2c) sets `encoding = RX_ENC_VHT`, but if
   rate > `DESC_RATEVHT4SS_MCS9` (0x53), `rtw_desc_to_mcsrate()` doesn't
   match any range, leaving `nss=0, mcs=0`. mac80211 fires `WARN_ONCE`
   and drops the packet.

- Category: Buffer overflow / out-of-bounds + input validation
- Record: OOB array write via untrusted HW rate + mac80211 WARNING from
  invalid VHT rate

**Step 2.4: Fix Quality**
- Obviously correct: simple bounds check with safe fallback to CCK 1Mbps
- Minimal and surgical: 7 lines of validation code
- No regression risk: clamping an invalid rate to a safe default is
  strictly better than using the invalid value
- Uses existing `RTW_DBG_UNEXP` debug category already used elsewhere in
  the driver
- Record: Fix is obviously correct, minimal, zero regression risk

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
The rate assignment line (`pkt_stat->rate = le32_get_bits(...)`) was
introduced in `bbb6f9be7f994` (Sep 2024) — a refactoring that
consolidated 5 per-chip `query_rx_desc` functions into one. Before that,
each chip function had the same unvalidated rate read (e.g.,
`GET_RX_DESC_RX_RATE(rx_desc)`). The bug is as old as the driver itself
— `e3037485c68ec` from April 2019 (v5.2).

**Step 3.2: No Fixes: tag**
Expected for manual review candidate. The underlying issue predates the
refactoring.

**Step 3.3: File History**
Recent history shows only the refactoring series (bbb6f9be7f994,
053a7aace0207, 47f754b3f8382). No overlapping fixes.

**Step 3.4: Author**
Ping-Ke Shih (`pkshih@realtek.com`) is the Realtek WiFi subsystem
maintainer. His authorship carries high weight.

**Step 3.5: Dependencies**
This patch depends on `bbb6f9be7f994` (the refactoring into single
`rtw_rx_query_rx_desc()`), which is present in this 7.0 tree. The patch
is standalone and self-contained.

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

**Step 4.1-4.2**: Lore is behind anti-bot protection. b4 dig for the
specific commit hash couldn't find it (commit not yet in this tree). The
Link tag points to
`https://patch.msgid.link/20260324011001.5742-1-pkshih@realtek.com`. The
author is the recognized subsystem maintainer.

**Step 4.3**: The bug report is linked in `Closes:` — a real user report
on linux-wireless mailing list.

**Step 4.4-4.5**: This is a standalone fix, not part of a series.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Functions Modified**
- `rtw_rx_query_rx_desc()` — the central RX descriptor parser for all
  rtw88 chips

**Step 5.2: Callers**
`rtw_rx_query_rx_desc()` is called from every RX path in the driver —
PCI, USB, and SDIO transport backends. It is called for **every received
WiFi packet**. This is an extremely hot path.

**Step 5.3-5.4: Downstream impact**
After rate is read, it flows to:
1. `rtw_rx_fill_rx_status()` → determines encoding type (VHT/HT/legacy)
   → passed to mac80211
2. `rtw_rx_phy_stat()` → `num_qry_pkt[rate]++` — the out-of-bounds array
   write
3. `rtw_desc_to_mcsrate()` → converts to MCS/NSS for mac80211

**Step 5.5: Similar patterns**
Found `rtw_get_tx_power_params()` had a similar array overrun fix
(`2ff25985ea9cc`), confirming this is a known pattern in the driver.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable**
The unvalidated rate path exists since driver inception (v5.2, 2019). In
trees with the `bbb6f9be7f994` refactoring (post 6.12), this patch
applies directly. In older trees, the per-chip functions need similar
fixes (different patch needed).

**Step 6.2: Backport for 7.0**
For 7.0 stable: The refactoring is present, so this patch applies
cleanly to `rtw_rx_query_rx_desc()`.

**Step 6.3**: No related fix already in stable for this specific issue.

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

**Step 7.1**: WiFi driver (drivers/net/wireless/) — IMPORTANT subsystem.
rtw88 supports popular consumer WiFi chipsets (RTL8822CE, RTL8723DE,
etc.) used in many laptops.

**Step 7.2**: Actively developed subsystem with recent refactoring and
new chip support.

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1**: Affects all rtw88 WiFi users — a widely used WiFi driver
for Realtek chipsets common in laptops.

**Step 8.2**: Triggered by receiving any WiFi frame with an unexpected
rate value from hardware. This can happen during normal operation as
demonstrated by the user report. No special conditions needed — just
using WiFi.

**Step 8.3**:
- Kernel WARNING spam in dmesg (every occurrence) — MEDIUM
- Out-of-bounds array write (memory corruption) — HIGH
- Packet drops when WARNING triggers — MEDIUM
- Combined severity: **HIGH**

**Step 8.4**:
- Benefit: HIGH (fixes user-visible WARNING spam + potential memory
  corruption on a hot RX path for a popular driver)
- Risk: VERY LOW (7 lines, bounds check with safe fallback, no behavior
  change for valid rates)
- Ratio: Very favorable

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence**
FOR backporting:
- Fixes real user-reported bug (kernel WARNING spam)
- Fixes potential out-of-bounds memory write (OOB array access)
- Extremely small and surgical (7 lines)
- Obviously correct (bounds check with safe default)
- Authored and signed by the subsystem maintainer (Ping-Ke Shih)
- Tested by the reporter with extensive scenarios
- Affects a popular WiFi driver used in many laptops
- Hot path (every RX packet)

AGAINST backporting:
- None identified

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? **YES** — trivial bounds check, tested
   by reporter
2. Fixes a real bug? **YES** — user-reported WARNING + OOB memory write
3. Important issue? **YES** — memory corruption (OOB write) and kernel
   warnings
4. Small and contained? **YES** — 7 lines in one file, one function
5. No new features or APIs? **YES** — pure validation addition
6. Can apply to stable? **YES** — 7.0 tree has the required refactoring

**Step 9.3: Exception categories** — N/A (this is a standard bug fix)

**Step 9.4: Decision** — Clear YES

## Verification

- [Phase 1] Parsed all tags: Reported-by from real user, Tested-by from
  same user, author is subsystem maintainer
- [Phase 2] Diff analysis: +7 lines adding bounds check in
  `rtw_rx_query_rx_desc()`, validates rate before downstream use
- [Phase 2] Verified `RTW_RX_DESC_W3_RX_RATE = GENMASK(6, 0)` — 7-bit
  field, values 0-127
- [Phase 2] Verified `DESC_RATE_MAX = 0x54 = 84` — array bound
- [Phase 2] Verified OOB at line 99: `num_qry_pkt[pkt_stat->rate]++`
  with array size DESC_RATE_MAX
- [Phase 2] Verified VHT path: rate >= 0x2c triggers VHT encoding, rate
  > 0x53 not handled by rtw_desc_to_mcsrate → nss=0
- [Phase 2] Verified mac80211 WARNING at net/mac80211/rx.c:5505-5510
  matches commit message exactly
- [Phase 3] git blame: rate line from bbb6f9be7f994 (Sep 2024
  refactoring), bug pattern since driver inception (v5.2)
- [Phase 3] git log: no related prior fix for this specific issue
- [Phase 3] Author Ping-Ke Shih is confirmed Realtek WiFi maintainer
- [Phase 5] `rtw_rx_query_rx_desc()` is called from PCI/USB/SDIO
  backends for every RX packet
- [Phase 5] `RTW_DBG_UNEXP` debug flag already exists and is used in 3
  other places in the driver
- [Phase 6] Refactoring (bbb6f9be7f994) present in 7.0 tree — patch
  applies cleanly
- [Phase 8] Impact: all rtw88 users, triggered during normal WiFi
  operation
- UNVERIFIED: Could not access lore discussion due to anti-bot
  protection (does not affect decision)

**YES**

 drivers/net/wireless/realtek/rtw88/rx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 8b0afaaffaa0e..d9e11343d4988 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -295,6 +295,14 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
 
 	pkt_stat->tsf_low = le32_get_bits(rx_desc->w5, RTW_RX_DESC_W5_TSFL);
 
+	if (unlikely(pkt_stat->rate >= DESC_RATE_MAX)) {
+		rtw_dbg(rtwdev, RTW_DBG_UNEXP,
+			"unexpected RX rate=0x%x\n", pkt_stat->rate);
+
+		pkt_stat->rate = DESC_RATE1M;
+		pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
+	}
+
 	/* drv_info_sz is in unit of 8-bytes */
 	pkt_stat->drv_info_sz *= 8;
 
-- 
2.53.0


