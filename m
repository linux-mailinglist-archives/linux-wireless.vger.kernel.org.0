Return-Path: <linux-wireless+bounces-35049-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEguN78p5mnesgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35049-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:27:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB1542BC45
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0693C305626A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F53BED0E;
	Mon, 20 Apr 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwwpwu8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD833A5E8B;
	Mon, 20 Apr 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691037; cv=none; b=renxf5oKHyDB4TkisfGV1lIS8YbL62wpmeI4zXs8xZnLcoY5jLOzwPuCOMk2yCyZcC25cFOyyhG+4R0S3/vB1y1qUNqcsNXcTsmDMAYjWXmexKEKQBlwbMTQ/bLXn4Z4/mujoaN6M8h267+kaUi2sf43KSIEx+oESGZ9zevCf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691037; c=relaxed/simple;
	bh=s4G8zpqOYFeSri/61okSTFd2Tvlt/DHWyYwTn/Zdl/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhWInSc+Fy/mVovMxw0Kk+oiz3uvFf7GevctRPddNK9owprll480OuwKUJiErEszYAlE89CZesVbeIuNAsG12NspBc3xZUZSZfaJS8rVXmQ5kdfPknpyTp6gZrptQuwfGb5UVE8vHDo2Mc9NsP3tjY9LjK12m97OH0SecsUJPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwwpwu8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6505C2BCF4;
	Mon, 20 Apr 2026 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691037;
	bh=s4G8zpqOYFeSri/61okSTFd2Tvlt/DHWyYwTn/Zdl/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwwpwu8oqQ8F7WshMy/3jG1zRnnZvCdNIhkwX2XSvye3AxvgGNVt5/IrV/3+ppYeG
	 LDzD55mQh0aUtzTcw34FVIhUBglFkau/suF65PeuWwD4wikl0Prm/mKhCCYc28EV5H
	 yQjiYd9yBbDx8MRP9m7CvVlArVRcuifN8u9HZyq1QbVG8dsa9QwvvyiQJhhr+pU7ys
	 Y1qWIk4wyrIODRytBGss9WFVHgIX1yzSEzMjUb3jeVA6NaZ2a7GEqRT6Jibe97BGDU
	 vDsu81T/wBZ8dvoZT77wl0BSvZ+C5adX9ADbY33C0E0qUBVFlAfigMkOZ9cbn4Swpz
	 +GAjA7WUEidBg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: rtw88: coex: Ignore BT info byte 5 from RTL8821A
Date: Mon, 20 Apr 2026 09:08:43 -0400
Message-ID: <20260420131539.986432-57-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-35049-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5DB1542BC45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 658e3c836969e1624a7572c75684f54ec503c2ed ]

Sometimes while watching a Youtube video with Bluetooth headphones the
audio has a lot of interruptions, because the 5th byte of the BT info
sent by RTL8821AU has strange values, which result in
coex_stat->bt_hid_pair_num being 2 or 3. When this happens
rtw_coex_freerun_check() returns true, which causes
rtw_coex_action_wl_connected() to call rtw_coex_action_freerun() instead
of rtw_coex_action_bt_a2dp().

The RTL8821AU vendor driver doesn't do anything with the 5th byte of the
BT info, so ignore it here as well.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/bbf06c83-d2ee-4205-8fbb-829e2347586f@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Good. Now I have a complete picture. Here is the full analysis:

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: `wifi: rtw88: coex:` (Realtek RTW88 WiFi driver,
  Bluetooth coexistence)
- **Action verb**: "Ignore" — indicates a hardware-specific workaround
  to suppress bad data
- **Summary**: Ignore erroneous BT info byte 5 from RTL8821A chip to fix
  Bluetooth audio interruptions

### Step 1.2: Tags
- **Signed-off-by**: Bitterblue Smith (author) + Ping-Ke Shih (subsystem
  maintainer)
- **Acked-by**: Ping-Ke Shih — the Realtek WiFi subsystem maintainer
  endorsed this
- **Link**: patch.msgid.link reference
- No Fixes: tag (expected for manual review candidates)
- No Reported-by: tag, but the commit message describes a user-visible
  symptom experienced by the author
- No Cc: stable (expected)

### Step 1.3: Body Analysis
The commit describes a real, user-visible bug:
- **Bug**: While watching YouTube with Bluetooth headphones, audio has
  frequent interruptions
- **Root cause**: RTL8821AU sends BT info with "strange values" in byte
  5 (bt_info_hb2), which causes `bt_hid_pair_num` to be 2 or 3
- **Impact chain**: `bt_hid_pair_num >= 2` → `rtw_coex_freerun_check()`
  returns true → `rtw_coex_action_freerun()` is called instead of
  `rtw_coex_action_bt_a2dp()` → wrong coexistence algorithm → audio
  stuttering
- **Vendor driver evidence**: RTL8821AU vendor driver doesn't use byte 5
  at all

### Step 1.4: Hidden Bug Fix Detection
This IS a bug fix. The "Ignore" verb is a hardware workaround — the chip
sends garbage data in byte 5 that causes incorrect coexistence
decisions.

Record: This is a hardware quirk/workaround disguised with neutral
language.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed**: 1 (`drivers/net/wireless/realtek/rtw88/coex.c`)
- **Lines added**: 3 (including blank line)
- **Lines removed**: 0
- **Function modified**: `rtw_coex_bt_info_notify()`
- **Scope**: Single-file surgical fix, chip-specific

### Step 2.2: Code Flow Change
**Before**: Byte 5 of BT info (`bt_info_c2h[rsp_source][5]`) is stored
verbatim from the buffer, then copied into `bt_info_hb2`, and later used
to compute `bt_hid_pair_num`, `bt_hid_slot`, `bt_opp_exist`, etc.

**After**: For RTL8821A only, byte 5 is zeroed immediately after being
copied from the buffer. This means all downstream fields derived from
`bt_info_hb2` (like `bt_hid_pair_num`, `bt_hid_slot`, `bt_opp_exist`,
`bt_a2dp_active`, `bt_slave`) will be based on a zero value instead of
garbage.

### Step 2.3: Bug Mechanism
This is a **hardware workaround** (category h). The RTL8821A firmware
sends unreliable data in byte 5 of BT info. The fix zeros it to prevent
incorrect coexistence algorithm selection.

The critical impact path: `bt_hid_pair_num` (derived from bits 6-7 of
byte 5) being >= 2 causes `rtw_coex_freerun_check()` at line 127 to
return true, which in `rtw_coex_action_wl_connected()` (lines 2496-2516)
causes "freerun" mode instead of the proper A2DP algorithm.

### Step 2.4: Fix Quality
- **Obviously correct**: Yes — the vendor driver ignores this byte
  entirely, zeroing it is the conservative approach
- **Minimal/surgical**: Yes — 2 lines of real code, chip-specific guard
- **Regression risk**: Very low — only affects RTL8821A, and only
  suppresses data that's already garbage
- **Red flags**: None

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
- `bt_hid_pair_num` extraction from `bt_info_hb2` was introduced by
  commit `4136214f7c4683` (Yan-Hsuan Chuang, 2019-07-31) — present since
  very early rtw88 history
- The freerun check using `bt_hid_pair_num >= 2` was added by commit
  `8e6947dcb95d77` (Ching-Te Ku, 2020-11-26)
- However, `RTW_CHIP_TYPE_8821A` was only added in v6.13 (commit
  `d12722830ea4f`, 2024-10-23)

### Step 3.2: Fixes Tag
No Fixes: tag present. The bug exists since RTL8821A support was first
added in v6.13.

### Step 3.3: Related Changes
The author (Bitterblue Smith) has been the primary contributor of
RTL8821A/RTL8812A support in rtw88, with numerous commits adding the
chip support infrastructure. Related commit `bfcee5ee924fc` ("wifi:
rtw88: 8821a: Regularly ask for BT info updates") also addresses
RTL8821AU BT coexistence quirks — another sign the chip's BT behavior is
non-standard.

### Step 3.4: Author Context
Bitterblue Smith is the primary developer who reverse-engineered and
ported RTL8821A/RTL8812A support to the rtw88 framework. They are the de
facto maintainer of this chip's support. The fix is acked by the rtw88
subsystem maintainer Ping-Ke Shih.

### Step 3.5: Dependencies
The fix depends on `RTW_CHIP_TYPE_8821A` existing in the enum (added in
v6.13). No other dependencies — the code is self-contained.

---

## PHASE 4: MAILING LIST RESEARCH

### Step 4.1-4.5
Lore is protected by Anubis bot detection and could not be fetched. b4
dig could not find the commit (it's not yet in the local tree). However,
the patch link
(`patch.msgid.link/bbf06c83-d2ee-4205-8fbb-829e2347586f@gmail.com`) is
in the commit metadata.

The commit has **Acked-by: Ping-Ke Shih** (Realtek maintainer) AND
**Signed-off-by: Ping-Ke Shih** (meaning he applied it through his
tree), which is strong evidence of proper review.

Record: Could not access lore. However, maintainer ack and sign-off
confirmed from commit tags.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.2: Function & Callers
The modified function is `rtw_coex_bt_info_notify()`. The zeroed byte 5
(`bt_info_hb2`) affects:
1. `rtw_coex_freerun_check()` via `bt_hid_pair_num` (line 127) —
   controls whether freerun or proper A2DP coex is used
2. `bt_opp_exist`, `bt_a2dp_active`, `bt_slave`, `bt_hid_slot`,
   `bt_hid_pair_num`, `bt_418_hid_exist` (lines 3251-3262) — all derived
   from byte 5

For RTL8821A, since the vendor driver ignores all of byte 5, zeroing it
is the correct behavior for all these fields.

### Step 5.3-5.5
The freerun vs A2DP algorithm choice directly impacts the Bluetooth TDMA
scheduling — freerun mode doesn't properly coordinate WiFi/BT time slots
for A2DP streaming, causing audio dropouts.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Code Existence in Stable
- `RTW_CHIP_TYPE_8821A` was added in v6.13 (commit `d12722830ea4f`)
- The coex code being modified (`rtw_coex_bt_info_notify`) exists in all
  trees, but the chip type enum only exists in v6.13+
- **Applicable stable trees**: 6.13.y, 6.14.y, 6.15.y, and this 7.0.y
  tree
- **NOT applicable**: 6.12.y and older (no RTL8821A support)

### Step 6.2: Backport Complications
The patch should apply cleanly to any tree with RTL8821A support
(v6.13+). The surrounding code in `rtw_coex_bt_info_notify()` has been
stable.

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1: Subsystem Criticality
- **Subsystem**: WiFi driver (drivers/net/wireless/realtek/rtw88) —
  IMPORTANT level
- RTL8821AU is a common USB WiFi dongle used by many Linux users

### Step 7.2: Activity
Active subsystem with regular commits from both Bitterblue Smith and
Ping-Ke Shih.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
Users of RTL8821AU USB WiFi dongles who use Bluetooth headphones
simultaneously (a very common use case for laptop users with USB WiFi
adapters).

### Step 8.2: Trigger Conditions
- Trigger: Using Bluetooth A2DP headphones while WiFi is connected
- Very common scenario — watching video with BT headphones is an
  everyday task
- No special privileges needed

### Step 8.3: Failure Mode Severity
- **Failure mode**: Bluetooth audio has frequent
  interruptions/stuttering
- **Severity**: MEDIUM-HIGH — not a crash, but makes BT audio unusable,
  which is a significant functionality regression for a very common use
  case

### Step 8.4: Risk-Benefit
- **Benefit**: HIGH — fixes Bluetooth audio for RTL8821AU users, very
  common use case
- **Risk**: VERY LOW — 2 lines, chip-specific guard, vendor driver
  doesn't use this byte at all, maintainer-acked
- **Ratio**: Strongly favorable

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence
**FOR backporting:**
- Fixes real user-visible bug (BT audio stuttering)
- Extremely small (2 lines of code)
- Hardware-specific quirk (only RTL8821A affected)
- Consistent with vendor driver behavior
- Acked by subsystem maintainer (Ping-Ke Shih)
- Zero regression risk for other chips
- Common use case (BT audio + WiFi)

**AGAINST backporting:**
- Only affects trees with RTL8821A support (v6.13+)
- No Fixes: tag (expected for review candidates)
- No explicit stable nomination

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **YES** — matches vendor driver, acked
   by maintainer
2. Fixes a real bug? **YES** — BT audio interruptions
3. Important issue? **YES** — makes BT audio unusable with this common
   USB dongle
4. Small and contained? **YES** — 2 lines, single file, chip-specific
5. No new features or APIs? **CORRECT** — this is a workaround, not a
   feature
6. Can apply to stable trees? **YES** — clean apply to v6.13+

### Step 9.3: Exception Category
This is a **hardware quirk/workaround** — a classic exception category
that is automatically YES for stable.

---

## Verification

- [Phase 1] Parsed tags: Acked-by and Signed-off-by from Ping-Ke Shih
  (subsystem maintainer)
- [Phase 2] Diff analysis: 2 lines added after buffer copy in
  `rtw_coex_bt_info_notify()`, zeroes byte 5 for RTL8821A only
- [Phase 2] Verified impact path: byte 5 → `bt_info_hb2` →
  `bt_hid_pair_num` at line 3258 → `rtw_coex_freerun_check()` at line
  127 → wrong algorithm at lines 2496-2516
- [Phase 3] git blame: `bt_hid_pair_num` extraction from 2019, freerun
  check from 2020, RTL8821A chip type added v6.13
- [Phase 3] `RTW_CHIP_TYPE_8821A` added in commit d12722830ea4f (v6.13)
- [Phase 3] RTL8821A driver (rtw8821a.c) added in commit 32e284a238806
  (v6.13)
- [Phase 3] Author is the primary RTL8821A/RTL8812A contributor with
  many commits in rtw88
- [Phase 4] Lore access blocked by Anubis. UNVERIFIED: could not read
  mailing list discussion
- [Phase 5] Traced `bt_hid_pair_num` usage: line 127
  (`rtw_coex_freerun_check`), line 1530 (algorithm selection), lines
  3258-3262 (418 HID detection)
- [Phase 6] Applicable to stable trees v6.13.y and newer only (RTL8821A
  support not present in older trees)
- [Phase 6] Patch applies cleanly — no conflicting changes in
  surrounding code
- [Phase 8] Failure mode: BT A2DP audio stuttering when WiFi connected,
  severity MEDIUM-HIGH

---

This is a textbook hardware quirk fix: a 2-line, chip-specific
workaround that fixes a real user-visible Bluetooth audio problem, is
consistent with the vendor driver, and is endorsed by the subsystem
maintainer. The regression risk is negligible since it only affects
RTL8821A and only zeroes a byte containing garbage data. It meets all
stable kernel criteria.

**YES**

 drivers/net/wireless/realtek/rtw88/coex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index b4dc6ff2c1750..97fc7392b48a8 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -3095,6 +3095,9 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	for (i = 0; i < COEX_BTINFO_LENGTH; i++)
 		coex_stat->bt_info_c2h[rsp_source][i] = buf[i];
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A)
+		coex_stat->bt_info_c2h[rsp_source][5] = 0;
+
 	/* get the same info from bt, skip it */
 	if (coex_stat->bt_info_c2h[rsp_source][1] == coex_stat->bt_info_lb2 &&
 	    coex_stat->bt_info_c2h[rsp_source][2] == coex_stat->bt_info_lb3 &&
-- 
2.53.0


