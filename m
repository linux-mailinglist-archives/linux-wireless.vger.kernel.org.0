Return-Path: <linux-wireless+bounces-34366-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL8kJPCT02lWjQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34366-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 13:07:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 153193A303E
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 13:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 639D330215BD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF633688A;
	Mon,  6 Apr 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOAU29Sb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF6330678;
	Mon,  6 Apr 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473562; cv=none; b=CjN4pU8H2wPUQqpl3TlBbqThHwizHeXgqGvfHKkNdePuCjpVyob/XWWA73SVl8SKmaTBo8gcyaMXImMMbnuvpELTd9IHGP//ft5N2ZwBqtUqdwkdKyM4hZTKYtns8fI88m8F3/MUCIZJBQFo7Ps3OpHNOlQpGYCEYLmtyfqCRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473562; c=relaxed/simple;
	bh=bb6VSCMyY+zjm/xop818NT+Aqpc51hEg1G2yyQkhyAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lx0jFKwoUQ6L3iJ31LLJ3gtsDE6QfoGjU4mGuBGIv/ULiGbKJWNvsd7iYBjkaljlgc06iVcESFAWNW2bfQIzyD+EEY6+maZW7xBowpsETcjRoDd6WDJ2MeO5j9AejAjiWI9qrL3ZSCwPaCcaYhIwUTr+h2OWqZBJlovSWT+esaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOAU29Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F99C2BCB1;
	Mon,  6 Apr 2026 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775473561;
	bh=bb6VSCMyY+zjm/xop818NT+Aqpc51hEg1G2yyQkhyAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOAU29Sbqd1ps9DCLA0HqRn+sTH+fGPAmgLp+I4YT6tcgJEA4jwMixix8/KJLaSXw
	 RBlyFfuXKkeLAk0HN1WcJMk7VM69y0lwbPDO8xCruBJgrFhF8qSP+h1zwtBTN8l2y6
	 BamrWN/Wqwze0Bfizl56O1tNdp7CZ3z9OMWBC8JpfJcAVFQbFHiyliA+e2H8KxXB1q
	 q/DOUGrzr3ylEbkZyO1QUdjHchgkS3NL3TO+9wQVtVE94D24T2y1V6zoM2UvDZB+72
	 HgiQOddi6Mt2JKLY7KzDnFV0zSvRtatPlkOfKZfLF5zIIfeDRVllXOR9xMpvlsHdId
	 rbEHthyJsERrg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] wifi: wl1251: validate packet IDs before indexing tx_frames
Date: Mon,  6 Apr 2026 07:05:40 -0400
Message-ID: <20260406110553.3783076-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406110553.3783076-1-sashal@kernel.org>
References: <20260406110553.3783076-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34366-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,iscas.ac.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 153193A303E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 0fd56fad9c56356e7fa7a7c52e7ecbf807a44eb0 ]

wl1251_tx_packet_cb() uses the firmware completion ID directly to index
the fixed 16-entry wl->tx_frames[] array. The ID is a raw u8 from the
completion block, and the callback does not currently verify that it
fits the array before dereferencing it.

Reject completion IDs that fall outside wl->tx_frames[] and keep the
existing NULL check in the same guard. This keeps the fix local to the
trust boundary and avoids touching the rest of the completion flow.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260323080845.40033-1-pengpeng@iscas.ac.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The function `wl1251_tx_packet_cb()` has been essentially unchanged
since 2009. The surrounding code is identical across all stable trees
(the only recent change was the `ieee80211_tx_status` rename in 2023,
which is only in the newer trees). The patch should apply cleanly or
with trivial adjustment.

Record: Clean apply expected on most stable trees. Minor conflict
possible on older trees due to function name rename
(`ieee80211_tx_status` vs `ieee80211_tx_status_skb`), but the fix itself
(the bounds check at the top of the function) is completely independent
of that.

### Step 6.3: CHECK IF RELATED FIXES ARE ALREADY IN STABLE
No related fixes for this specific issue found.

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: IDENTIFY THE SUBSYSTEM
- **Subsystem**: drivers/net/wireless/ti/wl1251 — WiFi driver for TI
  WL1251 chipset
- **Criticality**: PERIPHERAL — specific hardware driver, but used in
  some embedded/mobile devices (notably Nokia N900 and similar)
- **Maintainer**: Johannes Berg signed off, he is the WiFi subsystem
  maintainer — strong endorsement

Record: [Peripheral WiFi driver] [Maintainer-approved by Johannes Berg]

### Step 7.2: SUBSYSTEM ACTIVITY
Very low activity — 10 commits in the file's lifetime. This is a mature,
stable driver. The bug has been present for 17 years.

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: DETERMINE WHO IS AFFECTED
Users of TI WL1251 WiFi hardware (embedded systems, older Nokia phones,
some industrial devices).

### Step 8.2: DETERMINE THE TRIGGER CONDITIONS
- Triggered when firmware returns a corrupt or unexpected completion ID
  (>= 16)
- Could be triggered by firmware bugs, hardware glitches, or malicious
  firmware
- The user cannot directly control the trigger, but a compromised/buggy
  firmware can

### Step 8.3: DETERMINE THE FAILURE MODE SEVERITY
Without the bounds check, `result->id` (u8, range 0-255) is used to
index a 16-entry array. An OOB read from `wl->tx_frames[result->id]`
where id >= 16 reads kernel memory beyond the struct. This could result
in:
- **Kernel crash/oops** (if the read returns a value that's dereferenced
  and happens to be invalid)
- **Memory corruption** (line 441: `wl->tx_frames[result->id] = NULL`
  writes NULL to OOB location)
- **Information leak** (reading and processing an arbitrary skb pointer
  from kernel memory)

The OOB **write** at line 441 (`wl->tx_frames[result->id] = NULL`) is
particularly dangerous — it writes NULL to an arbitrary offset within
kernel memory.

Record: Severity HIGH to CRITICAL. OOB read leads to use of arbitrary
pointer; OOB write corrupts kernel memory.

### Step 8.4: RISK-BENEFIT RATIO
- **Benefit**: Prevents OOB read and write from untrusted firmware data.
  Prevents potential kernel crashes and memory corruption.
- **Risk**: Extremely low. The fix adds a single bounds check with
  `ARRAY_SIZE()` and returns early. It cannot introduce a regression.
- **Assessment**: Very favorable benefit-to-risk ratio.

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: COMPILE THE EVIDENCE

**FOR backporting:**
- Fixes a genuine OOB array access from untrusted firmware input (both
  read and write)
- Bug has existed since 2009 — present in ALL stable trees
- Fix is 6 lines, obviously correct, minimal, and self-contained
- Uses standard `ARRAY_SIZE()` bounds check idiom
- No dependencies on other patches
- Approved by WiFi subsystem maintainer (Johannes Berg)
- OOB write at line 441 could corrupt arbitrary kernel memory
- Clean backport expected

**AGAINST backporting:**
- Peripheral driver (TI WL1251, limited user base)
- No reported real-world triggers (theoretical, though firmware is
  untrusted)
- No syzbot report or CVE

### Step 9.2: APPLY THE STABLE RULES CHECKLIST
1. **Obviously correct and tested?** YES — simple ARRAY_SIZE bounds
   check, merged by maintainer
2. **Fixes a real bug?** YES — OOB array access from unvalidated
   firmware data
3. **Important issue?** YES — potential kernel memory corruption from
   OOB write
4. **Small and contained?** YES — 6 lines in one function in one file
5. **No new features or APIs?** YES — pure validation addition
6. **Can apply to stable trees?** YES — code unchanged since 2009

### Step 9.3: CHECK FOR EXCEPTION CATEGORIES
Not an exception category — this is a standard bug fix.

### Step 9.4: DECISION
The fix is small, surgical, obviously correct, and prevents out-of-
bounds array access (both read and write) from untrusted firmware data.
The OOB write to `wl->tx_frames[result->id] = NULL` is particularly
dangerous as it could corrupt kernel memory at an offset up to ~2KB
beyond the struct. While the driver serves a limited user base, the fix
has essentially zero regression risk and addresses a real memory safety
issue.

## Verification

- [Phase 1] Parsed tags: Signed-off-by author (Pengpeng Hou) and
  maintainer (Johannes Berg). No Fixes/Reported-by/Cc:stable (expected).
- [Phase 2] Diff analysis: ~6 lines changed in `wl1251_tx_packet_cb()`.
  Adds `ARRAY_SIZE()` bounds check before array index. Also protects OOB
  write at line 441.
- [Phase 2] Confirmed `tx_frames` is a 16-entry array (`struct sk_buff
  *tx_frames[16]` at wl1251.h:310), `result->id` is u8 (range 0-255).
- [Phase 3] git blame: Buggy code introduced in commit 2f01a1f58889fb
  (2009-04-29, Kalle Valo). Present since initial driver submission.
- [Phase 3] git log: File has only 10 commits total, very stable code.
  No recent refactoring.
- [Phase 3] Author check: Pengpeng Hou has 1 other similar bounds-
  checking fix (btusb).
- [Phase 4] UNVERIFIED: Could not access lore.kernel.org (Anubis block).
  Unable to check mailing list discussion.
- [Phase 5] Traced callers: `wl1251_tx_packet_cb()` called from
  `wl1251_tx_complete()` which reads `result` directly from firmware
  shared memory via `wl1251_mem_read()`. The `result->id` is firmware-
  controlled.
- [Phase 5] Both OOB accesses (line 405 read, line 441 write) are
  protected by the new check.
- [Phase 6] Bug exists in all active stable trees (code unchanged since
  2009).
- [Phase 6] Expected clean apply on all stable trees (fix is at top of
  function, independent of other changes).
- [Phase 7] WiFi subsystem maintainer (Johannes Berg) signed off —
  strong endorsement.
- [Phase 8] Failure mode: OOB read + OOB write to kernel memory from
  untrusted firmware input. Severity HIGH.
- [Phase 8] Risk: Extremely low (simple bounds check addition).

**YES**

 drivers/net/wireless/ti/wl1251/tx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index adb4840b04893..c264d83e71d9c 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -402,12 +402,14 @@ static void wl1251_tx_packet_cb(struct wl1251 *wl,
 	int hdrlen;
 	u8 *frame;
 
-	skb = wl->tx_frames[result->id];
-	if (skb == NULL) {
-		wl1251_error("SKB for packet %d is NULL", result->id);
+	if (unlikely(result->id >= ARRAY_SIZE(wl->tx_frames) ||
+		     wl->tx_frames[result->id] == NULL)) {
+		wl1251_error("invalid packet id %u", result->id);
 		return;
 	}
 
+	skb = wl->tx_frames[result->id];
+
 	info = IEEE80211_SKB_CB(skb);
 
 	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK) &&
-- 
2.53.0


