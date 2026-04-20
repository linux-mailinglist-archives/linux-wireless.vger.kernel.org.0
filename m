Return-Path: <linux-wireless+bounces-35083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA3KIrBQ5mkDuwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:13:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B042F290
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413543360DEB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98B3AE196;
	Mon, 20 Apr 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hipX0xjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F84C9545;
	Mon, 20 Apr 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691998; cv=none; b=bzPhVOjQwUmTr9FOcqhgQQCLrPMxOE8DueIPhvjJD3GXU+cqGafDV5Cp02LVW0PRr2RYaPoC2Yozi7vHnVnnn3hvKL/Hsm6rta1o0/9UCPZo+H98XSjoYsHlG+wg0NrE6B45WPgtg5b137qXKWZ8Ti9MKFNjSBldNFIDfRwYi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691998; c=relaxed/simple;
	bh=BePUomKvvkrM4BNzUrfaEwFz9bdlcwZGtKaMzr9TL2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhlqlNmo6+JZbNxSuXM3ZoXYTsTM3O6MRlNESOQSTbP02kl4QWaQR+B1L/zcIxHQ7K4ge003hAHI3+AnG+uJkDbMmOFp+hx8GdIvp/u4IiVg13sPu480c7bDbGkAjYPfxLzZbRZUyjH5yWb588A8Oirfk3l6jILLMQxx4e128lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hipX0xjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A96C2BCB4;
	Mon, 20 Apr 2026 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691997;
	bh=BePUomKvvkrM4BNzUrfaEwFz9bdlcwZGtKaMzr9TL2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hipX0xjKlSz5QyIV03cdH2iHNbOUrgeY4tVkPRNF59kZn7ttDpppJ3PQL9TP76yer
	 lSNNH679RcIxA9SdaV0qE5p/WUKAWsQI5KiVxcmbhxwuIQt7YbBRCBgVeW0C0CcqbG
	 /jTyBMVM39kf9Mm1bn7eyjMqF8P6xtoAXomUIZBQ4PBdQJF+VMnTGxINO1NK727n1L
	 M7vVrfTLkah8QRIxS3/HS0RhX01/e9Jn+lEV9ehgxgQH7pOmsVRdcj9NYJK2Emf9F5
	 4Gysktro777TCEUOa+iXcGxJZf85/Vqr45LEMJlYdp7Nn/8axhpCmMKO43HKwvNyJU
	 3skkTf/o2oUYg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 7.0-6.18] wifi: mt76: mt7996: fix frequency separation for station STR mode
Date: Mon, 20 Apr 2026 09:21:47 -0400
Message-ID: <20260420132314.1023554-313-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-35083-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,nbd.name,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nbd.name:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: E15B042F290
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit 59a295335021f6973a34566554b2b9371f1c6f7d ]

Fix frequency separation field for STR in MLD capabilities to get the
correct chip capability.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260316-mt7996-sta-str-v1-1-666814e6ab2d@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have enough information to complete the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: `wifi: mt76: mt7996:` — MediaTek mt7996 WiFi 7 wireless
  driver
- **Action verb**: "fix" — explicitly a bug fix
- **Summary**: Corrects frequency separation field for station STR mode
  in MLD capabilities

### Step 1.2: Tags
- `Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>` — author from
  MediaTek (the chip vendor)
- `Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>` — co-
  author/maintainer of mt76
- `Link:` to patch.msgid.link — mailing list submission link
- `Signed-off-by: Felix Fietkau <nbd@nbd.name>` — mt76 maintainer
  applied the patch
- No Fixes: tag, no Cc: stable, no Reported-by — expected for candidate
  review

### Step 1.3: Commit Body
The message says: "Fix frequency separation field for STR in MLD
capabilities to get the correct chip capability." The bug is that the
station's MLD capabilities struct was missing the `FREQ_SEP_TYPE_IND`
field, causing the driver to advertise incorrect STR capabilities during
(Re)Association Request frames.

### Step 1.4: Hidden Bug Fix?
This is an explicit fix — the word "fix" is in the subject. The missing
capability field causes incorrect WiFi frame content to be advertised to
the AP during MLD association.

Record: Genuine bug fix — incorrect WiFi capability advertisement.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **1 file** changed: `drivers/net/wireless/mediatek/mt76/mt7996/init.c`
- **1 line added**:
  `FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND, 1) |`
- Scope: Single-file, static initializer change

### Step 2.2: Code Flow
- **Before**: Station iftype entry in `iftypes_ext_capa[]` only sets
  `IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS`
- **After**: Station entry additionally sets
  `IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND` to value 1
- The `mld_capa_and_ops` field is consumed by mac80211 in `mlme.c`
  (lines 2069 and 10612-10613) and included directly in MLD capability
  elements of association frames

### Step 2.3: Bug Mechanism
This is a **logic/correctness fix** — a missing capability field in a
static const initializer. `IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND` (mask
`0x0f80`, bits 7-11) was not set, meaning the station reported frequency
separation type = 0 to the AP, which does not reflect the actual mt7996
hardware STR capability.

### Step 2.4: Fix Quality
- Trivially correct — adding a missing field to a bitfield OR expression
- Cannot introduce a regression — it's a static const initializer
- Minimal and surgical
- No red flags

Record: 1 line added, static initializer, zero regression risk.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame
The station entry was introduced by commit `f5160304d57c55` ("wifi:
mt76: mt7996: Enable MLO support for client interfaces") by Lorenzo
Bianconi on 2025-09-01. The base `iftypes_ext_capa[]` array was
introduced by `a9eae65d97f3cb` ("Export MLO AP capabilities to
mac80211") on 2025-08-27.

### Step 3.2: Fixes Target
No explicit Fixes: tag, but the implicit target is `f5160304d57c55`
which first introduced the station MLD capabilities. That commit was
first present in **v6.18** (confirmed via `git merge-base --is-
ancestor`). NOT in v6.17 or earlier.

### Step 3.3: File History
The file has 20 recent commits, many related to MLO/MLD enablement. This
fix appears standalone — no series dependencies.

### Step 3.4: Author
- Peter Chiu is from MediaTek (the silicon vendor) — strong authority on
  hardware capabilities
- Lorenzo Bianconi is the mt76 co-maintainer who also signed off
- Felix Fietkau (nbd) is the mt76 maintainer who applied the patch

Record: Author is from the chip vendor. Both mt76 maintainers signed
off. Bug introduced in v6.18.

### Step 3.5: Dependencies
The fix only adds a line to an existing OR expression in a static
initializer. No functional dependencies. The prerequisite code
(`iftypes_ext_capa` with the station entry) exists in v6.18 and v7.0.

---

## PHASE 4: MAILING LIST

### Step 4.1-4.5
Lore/WebFetch was blocked by Anubis protection. `b4 dig` for the
message-id didn't find a match by commit hash (the commit hasn't been
applied to the tree I'm on). The link
`https://patch.msgid.link/20260316-mt7996-sta-
str-v1-1-666814e6ab2d@kernel.org` indicates this was a v1 single-patch
submission from Lorenzo Bianconi.

Record: Could not fetch discussion. Patch submitted as v1, single patch.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.4
The `iftypes_ext_capa[]` array is assigned to `wiphy->iftype_ext_capab`
at line 497 of `init.c`. This is consumed by mac80211's `mlme.c` via
`cfg80211_get_iftype_ext_capa()` — the `mld_capa_and_ops` field is
directly encoded into (Re)Association Request frames and MLD
reconfiguration frames. This is a hot path for any MLD station
association.

### Step 5.5: Similar Patterns
The AP section of the same array does NOT include `FREQ_SEP_TYPE_IND`
either, but only the station section is fixed here (STR is a station-
side mode). The mt7925 driver also sets `mld_capa_and_ops` but
dynamically.

Record: Capability is directly embedded in WiFi management frames during
association.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Does the buggy code exist in stable trees?
- The buggy commit `f5160304d57c55` is in **v6.18 and v7.0 only**
- NOT in v6.17 or earlier — so this fix is irrelevant for all current
  LTS trees (6.12.y, 6.6.y, 6.1.y, 5.15.y)
- Only relevant for **7.0.y** stable and potentially 6.18.y if that is
  still maintained

### Step 6.2: Backport Complications
- 1 line addition to a static initializer — will apply cleanly to 7.0.y
- No conflicting changes expected

### Step 6.3: No related fixes already in stable

---

## PHASE 7: SUBSYSTEM CONTEXT

### Step 7.1
- **Subsystem**: WiFi drivers / MediaTek mt76 / mt7996
- **Criticality**: PERIPHERAL (specific WiFi hardware) but WiFi is
  important for many users

### Step 7.2
- Very active subsystem — 188 mt7996 commits since v6.12
- mt7996 is a WiFi 7 chip with active MLO development

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
- Mt7996 WiFi 7 hardware users attempting MLD (Multi-Link Device)
  operation in station mode

### Step 8.2: Trigger Conditions
- Triggered whenever a mt7996 station performs MLD association (common
  for WiFi 7 users)
- The wrong capability is always advertised

### Step 8.3: Failure Mode
- Incorrect WiFi capability in association frames → potentially
  incorrect STR mode negotiation, possible performance degradation or
  failed MLD operation
- Severity: **MEDIUM** — functional correctness issue, not a crash or
  security vulnerability

### Step 8.4: Risk-Benefit
- **Benefit**: Medium — corrects WiFi MLD capability for mt7996 users
- **Risk**: Very low — 1-line static initializer change, cannot regress
- **Ratio**: Favorable

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence
**FOR backporting:**
- Genuine correctness fix (missing capability field)
- Trivially small (1 line) and obviously correct
- Zero regression risk (static const initializer)
- Written by chip vendor (MediaTek), signed by both mt76 maintainers
- Fixes real functional issue for WiFi 7 MLD users
- Buggy code exists in 7.0

**AGAINST backporting:**
- Not a crash, security, or data corruption fix
- Only affects mt7996 MLD station mode users (relatively narrow)
- Relatively new code (v6.18+)

### Step 9.2: Stable Rules Checklist
1. Obviously correct and tested? **Yes** — trivially correct 1-line
   addition
2. Fixes a real bug? **Yes** — incorrect WiFi capability advertisement
3. Important issue? **Medium** — functional correctness for WiFi MLD
4. Small and contained? **Yes** — 1 line in 1 file
5. No new features? **Correct** — fixes existing code
6. Can apply to stable? **Yes** — clean apply expected

### Step 9.3: Exception Categories
Not an exception category; this is a standard driver bug fix.

### Step 9.4: Decision
The fix is a genuine 1-line correctness fix that corrects incorrect WiFi
MLD capability advertisement for mt7996 hardware. It's written by the
chip vendor, reviewed by both subsystem maintainers, and has zero
regression risk. While it's not a crash or security fix, it corrects
real WiFi functionality for mt7996 users in MLD/STR mode. The extremely
small scope and zero risk make this appropriate for stable.

---

## Verification

- [Phase 1] Parsed tags: Author from MediaTek, co-signed by mt76 co-
  maintainer and maintainer
- [Phase 2] Diff analysis: 1 line added to static const initializer,
  adds missing `IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND` field
- [Phase 3] git blame: Station MLD caps introduced by `f5160304d57c55`
  (v6.18), confirmed via `git merge-base`
- [Phase 3] git merge-base: Buggy commit NOT in v6.17 or earlier, IS in
  v6.18 and v7.0
- [Phase 5] grep callers: `mld_capa_and_ops` consumed in
  `net/mac80211/mlme.c` lines 2069 and 10612-10613 for association
  frames
- [Phase 5] grep definition: `IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND` =
  0x0f80 in `include/linux/ieee80211-eht.h`
- [Phase 6] Buggy code only in v6.18+ and v7.0; irrelevant for older LTS
  trees
- [Phase 7] Peter Chiu confirmed as MediaTek contributor; Lorenzo
  Bianconi and Felix Fietkau are mt76 maintainers
- UNVERIFIED: Could not access lore.kernel.org discussion due to Anubis
  protection

**YES**

 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 00a8286bd1368..d940ca84bd0f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -85,6 +85,7 @@ static const struct wiphy_iftype_ext_capab iftypes_ext_capa[] = {
 		.extended_capabilities_mask = if_types_ext_capa_ap,
 		.extended_capabilities_len = sizeof(if_types_ext_capa_ap),
 		.mld_capa_and_ops =
+			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND, 1) |
 			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS,
 					 MT7996_MAX_RADIOS - 1),
 	},
-- 
2.53.0


