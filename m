Return-Path: <linux-wireless+bounces-35061-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDyZDCIz5mmOtQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35061-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:07:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDF42CA7C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4287432112E5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2CB3B8BB1;
	Mon, 20 Apr 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d68ufO2S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B233EAC7C;
	Mon, 20 Apr 2026 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691505; cv=none; b=idH5n5S2uaTxrKV4tVwMnup28ERONfo0IFMs08FdlsEqZJZdHxwUGLbzlvGlTdGxNIv3sp5Voi4iebizDhL/naB96iKT564WhGR4LokHUKGpVTzzD+1RbwqGRkzQeLkxysZ5xwYYa6hSzc99LvcpLh3DurpVgIFAM8fg+LqZ3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691505; c=relaxed/simple;
	bh=iy4ullM0riE/zDEDaP0clf8E2jfWZ8QiGCYYRQJZXwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/pY7Jq0EZdhzef9vvlywUlxlAwhOKst2KJ02mVofqncE5a/KUUz91r0TgyHhw6cP+SMxBoT8gyzgx7CZaP8xnliaefSzNl2ZIRzLcNAkce4GFE54hMtdFeFF9TOnpbbWIGLjeLouiQxab9t4jp5EtOrhvcwBCcmDNyI2tJSDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d68ufO2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA91CC2BCB4;
	Mon, 20 Apr 2026 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691504;
	bh=iy4ullM0riE/zDEDaP0clf8E2jfWZ8QiGCYYRQJZXwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d68ufO2SwHbB8RAiL6uO0dql2h7bAzRW2kQLS2sbYKq29fEWHUNl7c6VTQM+43Tew
	 xfJWAnS2kJu6gVkSvVf17dVswBQpzuy493FxwsxYxVrpzFQSLlhZOuJoWroBk/k5tA
	 DNWxUDhXKowxP63BWGDnjJuJLh84oYzV8jxmLDgw/d0TyNn3D0rdpFJB4h8W7yg3nF
	 8GgNKPJEgSal6h8mU0zq1nH/l9WPaC7UxKcdmKc0Fd9SARzT7ly0Xi5YKlmOGIMKJk
	 O8C//RLZ70k6ySZ/m/XJDcnjZGJwz8waDRA8FfdXCRhxzOwEVTCJ0YYijRf4SgosVn
	 awCKh2aqJBzHw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.19] wifi: rtw89: Add support for TP-Link Archer TX50U
Date: Mon, 20 Apr 2026 09:17:43 -0400
Message-ID: <20260420132314.1023554-69-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35061-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9BDF42CA7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 6678828eb78f3ae0bc6db90436068d5fd0387703 ]

Add the ID 37ad:0103 to the table to support an additional RTL8832CU
adapter: TP-Link Archer TX50U.

Link: https://github.com/morrownr/rtl8852cu-20251113/issues/2
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260320093122.6754-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a clear picture. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: PARSE THE SUBJECT LINE
- **Subsystem**: `wifi: rtw89:`
- **Action verb**: "Add support for" (device ID addition)
- **Summary**: Adding USB device ID 37ad:0103 for TP-Link Archer TX50U
  (RTL8832CU adapter)

### Step 1.2: PARSE ALL COMMIT MESSAGE TAGS
- **Link**: https://github.com/morrownr/rtl8852cu-20251113/issues/2
  (GitHub issue confirming user tested the ID)
- **Signed-off-by**: Zenm Chen <zenmchen@gmail.com> (author)
- **Signed-off-by**: Ping-Ke Shih <pkshih@realtek.com> (subsystem
  maintainer - Realtek rtw89 driver)
- **Link**:
  https://patch.msgid.link/20260320093122.6754-1-zenmchen@gmail.com
  (lore submission)
- No Fixes: tag (expected for device ID additions), no Reported-by, no
  Cc: stable.

### Step 1.3: ANALYZE THE COMMIT BODY TEXT
The commit body is straightforward: add USB ID 37ad:0103 to the existing
rtw_8852cu_id_table to enable the TP-Link Archer TX50U, which uses the
RTL8832CU chipset. The GitHub issue link confirms a real user verified
the device works with this ID.

### Step 1.4: DETECT HIDDEN BUG FIXES
This is not a hidden bug fix. It is a pure USB device ID addition. This
falls squarely into the **DEVICE ID EXCEPTION** category for stable
backports.

## PHASE 2: DIFF ANALYSIS - LINE BY LINE

### Step 2.1: INVENTORY THE CHANGES
- **Files changed**: 1
  (`drivers/net/wireless/realtek/rtw89/rtw8852cu.c`)
- **Lines added**: 2 (one USB_DEVICE_AND_INTERFACE_INFO entry +
  driver_info)
- **Lines removed**: 0
- **Functions modified**: None - only the `rtw_8852cu_id_table[]` static
  const array
- **Scope**: Single-file, trivial addition to a static USB ID table

### Step 2.2: UNDERSTAND THE CODE FLOW CHANGE
- **Before**: The `rtw_8852cu_id_table` contains 8 USB vendor/product ID
  entries
- **After**: The table contains 9 entries, with `{0x37ad, 0x0103}` added
  before the sentinel
- The entry uses the exact same `rtw89_8852cu_info` driver_info as all
  other entries
- This only affects USB device enumeration: when a device with
  vendor=0x37ad product=0x0103 is plugged in, the kernel will now bind
  the rtw89_8852cu driver to it

### Step 2.3: IDENTIFY THE BUG MECHANISM
Category: **Hardware enablement (Device ID addition)**. The TP-Link
Archer TX50U uses the RTL8832CU chipset which is fully supported by the
existing driver. Without this ID, the device simply isn't recognized and
doesn't bind to the driver.

### Step 2.4: ASSESS THE FIX QUALITY
- **Obviously correct**: Yes - identical pattern to all other entries in
  the table
- **Minimal/surgical**: Yes - 2 lines, only touches the ID table
- **Regression risk**: Effectively zero. Adding a USB ID cannot affect
  existing IDs or any other code path. The entry only matches one
  specific vendor/product pair.

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: BLAME THE CHANGED LINES
- The file was created in commit `406849000df41` by Bitterblue Smith on
  2025-11-01
- One additional USB ID was added by commit `5f65ebf9aaf00` (Shin-Yi
  Lin, 2026-01-14)
- The driver is relatively new but fully functional in v7.0

### Step 3.2: FOLLOW THE FIXES: TAG
No Fixes: tag - expected for a device ID addition.

### Step 3.3: CHECK FILE HISTORY FOR RELATED CHANGES
Only 2 commits in the file's history - the initial creation and one
prior ID addition. No complex refactoring.

### Step 3.4: CHECK THE AUTHOR'S OTHER COMMITS
Zenm Chen is a repeat contributor who adds USB device IDs to Realtek
wireless drivers (rtw89, rtw88, rtl8xxxu) and Bluetooth (btusb). All
their commits follow the same pattern of device ID additions. The patch
is signed off by Ping-Ke Shih, the Realtek rtw89 subsystem maintainer.

### Step 3.5: CHECK FOR DEPENDENT/PREREQUISITE COMMITS
No dependencies. The driver already exists with its full infrastructure.
This is a standalone ID table addition.

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Step 4.1: FIND THE ORIGINAL PATCH DISCUSSION
Lore is behind anti-bot protection so direct fetch failed. The GitHub
issue (successfully fetched) at
https://github.com/morrownr/rtl8852cu-20251113/issues/2 confirms a real
user (@wd5gnr) tested the TP-Link Archer TX50U adapter and confirmed it
works with ID 37ad:0103. The user also wrote a Hackaday article about
the experience.

### Step 4.2: CHECK WHO REVIEWED THE PATCH
Signed-off-by from Ping-Ke Shih (pkshih@realtek.com) - the Realtek rtw89
maintainer. Appropriate review for this type of change.

### Step 4.3-4.5: BUG REPORT / RELATED PATCHES / STABLE DISCUSSION
The GitHub issue serves as the effective "report" - a user found their
adapter wasn't recognized. No prior stable discussion found.

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1-5.4: FUNCTION ANALYSIS
No functions are modified. The change is a static data table addition.
The ID table is consumed by the USB core during device enumeration to
match devices to drivers. The probe path (`rtw89_usb_probe`) is already
exercised by all 8 existing IDs and is well-tested.

### Step 5.5: SIMILAR PATTERNS
The author (Zenm Chen) has contributed many identical ID additions to
rtw89 and other Realtek drivers. The previous commit `5f65ebf9aaf00`
follows the exact same pattern for the same file.

## PHASE 6: CROSS-REFERENCING AND STABLE TREE ANALYSIS

### Step 6.1: DOES THE BUGGY CODE EXIST IN STABLE TREES?
Verified: The file exists in v7.0 (which is HEAD = the current stable
tree). The v7.0 tree has `rtw8852cu.c` with 8 USB IDs. The new ID would
be the 9th.

### Step 6.2: CHECK FOR BACKPORT COMPLICATIONS
The patch will apply cleanly. The v7.0 file already has the 28de:2432 ID
that was added after initial creation, and the new 37ad:0103 entry goes
right before the sentinel `{}`. No conflicts expected.

### Step 6.3: CHECK IF RELATED FIXES ARE ALREADY IN STABLE
No related fix for this specific USB ID exists.

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: IDENTIFY THE SUBSYSTEM AND ITS CRITICALITY
- **Subsystem**: WiFi drivers (drivers/net/wireless/realtek/rtw89)
- **Criticality**: IMPORTANT - USB WiFi adapters are widely used,
  especially by Linux users who buy them specifically for Linux support

### Step 7.2: ASSESS SUBSYSTEM ACTIVITY
The rtw89 subsystem is actively developed with recent commits visible.

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: DETERMINE WHO IS AFFECTED
Users of the TP-Link Archer TX50U USB WiFi adapter. This is a
commercially available, retail WiFi adapter from a major brand.

### Step 8.2: DETERMINE THE TRIGGER CONDITIONS
Without this ID, plugging in the adapter simply does nothing - the
device is not recognized by any driver.

### Step 8.3: DETERMINE THE FAILURE MODE SEVERITY
Without the fix: **Device non-functional** - the adapter cannot be used
at all. With the fix: device works immediately on plug-in. Severity:
HIGH for affected users (complete loss of WiFi functionality for their
hardware).

### Step 8.4: CALCULATE RISK-BENEFIT RATIO
- **BENEFIT**: HIGH - enables a commercially available WiFi adapter for
  users who own it
- **RISK**: NEGLIGIBLE - 2-line static data addition, cannot affect any
  other device or code path
- **Ratio**: Overwhelmingly favorable

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: COMPILE THE EVIDENCE

**FOR backporting:**
- Classic USB device ID addition - explicitly called out as a stable
  exception category
- 2-line change, zero regression risk
- Enables a real, commercially available TP-Link WiFi adapter
- Confirmed working by a real user (GitHub issue)
- Reviewed/signed-off by subsystem maintainer (Ping-Ke Shih)
- Driver already exists in v7.0 stable tree
- Will apply cleanly
- Author has a track record of identical, successful ID additions

**AGAINST backporting:**
- (none identified)

### Step 9.2: APPLY THE STABLE RULES CHECKLIST
1. Obviously correct and tested? **YES** - identical to all other
   entries, user-tested
2. Fixes a real bug? **YES** - enables hardware that should work but
   doesn't
3. Important issue? **YES** - without it, the adapter is completely non-
   functional
4. Small and contained? **YES** - 2 lines in 1 file
5. No new features or APIs? **YES** - just a data addition to existing
   infrastructure
6. Can apply to stable? **YES** - clean apply expected

### Step 9.3: CHECK FOR EXCEPTION CATEGORIES
**YES - Device ID addition to existing driver.** This is the textbook
example of the USB ID exception category.

### Verification:
- [Phase 1] Parsed tags: Signed-off-by from Ping-Ke Shih (maintainer),
  Link to GitHub issue and lore
- [Phase 2] Diff analysis: 2 lines added to static USB ID table in
  `rtw8852cu.c`, adds {0x37ad, 0x0103}
- [Phase 3] git blame: file created in 406849000df41 (2025-11-01),
  exists in v7.0
- [Phase 3] git show v7.0:rtw8852cu.c: confirmed file exists with 8 IDs
  in v7.0 stable tree
- [Phase 3] git log --author: Zenm Chen contributes multiple identical
  ID additions across Realtek drivers
- [Phase 4] GitHub issue #2: user @wd5gnr confirmed TX50U works with
  this ID, linked Hackaday article
- [Phase 4] b4 dig on sibling commit 5f65ebf9aaf00: confirmed similar ID
  additions go through the same maintainer
- [Phase 4] Lore direct access blocked by anti-bot protection (Anubis)
- [Phase 5] No functions modified - pure data table change; probe path
  exercised by existing 8 IDs
- [Phase 6] v7.0 tag contains the file; patch applies cleanly (no
  intervening changes to this section)
- [Phase 7] rtw89 is an actively maintained WiFi subsystem, TP-Link is a
  major brand
- [Phase 8] Risk: negligible (2-line data addition); Benefit: enables
  hardware for real users

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index a485dacbb0531..314ea7f0ba72d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -56,6 +56,8 @@ static const struct usb_device_id rtw_8852cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0102, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x37ad, 0x0103, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8852cu_id_table);
-- 
2.53.0


