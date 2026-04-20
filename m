Return-Path: <linux-wireless+bounces-35078-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ0sGIs95mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35078-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:51:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2EE42D8CC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D98A436BF1A6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D344BC9F;
	Mon, 20 Apr 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTxCdp3F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355D44103F;
	Mon, 20 Apr 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691814; cv=none; b=BuJoyPsmfKZZKKY70FQpJmH42/icXyYy6xm6SCKp65Zib8a/1h4WKul8MzCN1nms7wPU0eo+HDQHsmRnCBXDVjQZSeMLARUl1a3CkglR6Ljxe1mmx7voWoUIhiBzmM8qrgNEVCtY764psuxcxC/Yl+oaWZ3P+VjKUARs9aMuMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691814; c=relaxed/simple;
	bh=0w01zXikFo9Re00qyVxbzAZST/JtC6BUtf0eukMyG74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2lJcdk15rLIV9dBaU2fJ3M6VuL0dF82ZYj+pZWyoEn3NoyWKq/3BSvapTGArh/V1WKDYKzRxeMKOPq7Q5kN5bwflEm3xMR5E/4UFJ8cGe6p4DRCp1tYNveHLeBZbMzuXUrlEqwqZm4IPMENwQ+qjIQTab7NPmDeJ3eMLpjcN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTxCdp3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82C5C19425;
	Mon, 20 Apr 2026 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691813;
	bh=0w01zXikFo9Re00qyVxbzAZST/JtC6BUtf0eukMyG74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTxCdp3F6Ww0wM43U7g7u5mw7796ka59jLKh55D6Lz9VzgcR5pEizULx+GlJflXzZ
	 G+2Zmjs26UwbfWdikcFZ5MX9O/kkpnjR+VyCRyxv7qS2z+tOs6h1BT/Yk33w0GqXc8
	 Kggo/1R7Z0+i07aw72/d3CrS182RnYkc5AYi9VuItCfbOBxvrhDAFSkkegIFAGExwW
	 rwTTDb2gWN9kr5mUNjSWUCVJliwStD/6D74lRBKwLZka4+UujZJTdR6gG0vs1g7YdZ
	 efK1JAKIl8hxCh5zOC4l9b2klDTU30+oFAE+Bk5VYY2p8igFLOTAMR5txwM8PelaWh
	 4hsNS61qH2cwg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.19] wifi: rtw89: Add support for Elecom WDC-XE2402TU3-B
Date: Mon, 20 Apr 2026 09:20:04 -0400
Message-ID: <20260420132314.1023554-210-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35078-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: AE2EE42D8CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 4e4fc2149b0a983670fd99bbd549012839bda79e ]

Add the ID 056e:4024 to the table to support an additional RTL8832CU
adapter: Elecom WDC-XE2402TU3-B.

Link: https://github.com/morrownr/rtw89/commit/55c059e2bd49acd5cf93edbc8eda7b9e042f4efd
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260330093440.3615-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have enough information to complete the full analysis. Let me
document all phases.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: rtw89`
- Action verb: "Add support for"
- Summary: Adds USB device ID for Elecom WDC-XE2402TU3-B WiFi adapter
  (RTL8832CU-based)
- Record: [wifi: rtw89] [Add] [USB device ID for new RTL8832CU adapter]

**Step 1.2: Tags**
- No Fixes: tag (expected for candidate commits)
- No Reported-by: tag
- No Cc: stable tag
- Link: to GitHub morrownr/rtw89 commit (out-of-tree driver reference)
- Signed-off-by: Zenm Chen (author/contributor)
- Signed-off-by: Ping-Ke Shih (rtw89 subsystem maintainer, accepted the
  patch)
- Link: patch.msgid.link (mainline submission)
- Record: Author is a community contributor (Zenm Chen), maintainer
  (Ping-Ke Shih) accepted the patch.

**Step 1.3: Body Text**
- Clear and concise: "Add the ID 056e:4024 to the table to support an
  additional RTL8832CU adapter: Elecom WDC-XE2402TU3-B."
- Vendor 0x056e = Elecom Co., Ltd.
- Product 0x4024 = WDC-XE2402TU3-B
- The adapter uses the RTL8832CU chip, which the rtw89_8852cu driver
  already fully supports.
- Record: [Device ID addition] [No bug described - hardware enablement]
  [RTL8832CU chip already supported]

**Step 1.4: Hidden Bug Fix Detection**
- This is NOT a hidden bug fix. It's a straightforward USB device ID
  addition.
- However, it falls into the **explicit exception category** for stable:
  NEW DEVICE IDs to existing drivers.
- Record: Not a bug fix. Exception category: device ID addition.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Files changed: 1 (`drivers/net/wireless/realtek/rtw89/rtw8852cu.c`)
- Lines added: 2 (one `USB_DEVICE_AND_INTERFACE_INFO` entry +
  `.driver_info` line)
- Lines removed: 0
- Functions modified: None. Only the static `rtw_8852cu_id_table[]`
  array gains an entry.
- Scope: single-file, surgical, 2-line addition to a const data table.
- Record: [1 file, +2 lines, 0 functions modified, trivial scope]

**Step 2.2: Code Flow Change**
- Before: The USB ID table does not include 0x056e:0x4024. The Elecom
  WDC-XE2402TU3-B adapter is not recognized by the driver.
- After: The USB ID table includes 0x056e:0x4024 pointing to the
  existing `rtw89_8852cu_info` driver data. The adapter will be
  automatically bound to the rtw89_8852cu driver on plug-in.
- No code logic changes; only static data table modification.
- Record: [Before: device not recognized] [After: device bound to
  existing driver]

**Step 2.3: Bug Mechanism**
- Category: Hardware enablement / device ID addition (category h from
  the analysis framework)
- The new entry uses `USB_DEVICE_AND_INTERFACE_INFO` with the same
  interface class/subclass/protocol (0xff, 0xff, 0xff) and the same
  `rtw89_8852cu_info` as all other entries in the table.
- Record: [Device ID addition, identical pattern to existing entries]

**Step 2.4: Fix Quality**
- Obviously correct: follows the exact same pattern as every other entry
  in the table.
- Minimal/surgical: 2 lines, purely additive to a const data array.
- Regression risk: effectively zero. The new entry only matches USB
  device 056e:4024; it cannot affect any other device.
- Record: [Obviously correct, zero regression risk]

## PHASE 3: GIT HISTORY

**Step 3.1: Blame**
- The file was created by Bitterblue Smith in commit `406849000df41`
  (Nov 2025), first appearing in v6.19.
- One subsequent ID addition (0x28de:0x2432) by Shin-Yi Lin in
  `5f65ebf9aaf00` (Jan 2026).
- Record: [File created in v6.19, present in v7.0]

**Step 3.2: Fixes Tag**
- No Fixes: tag present (expected, as this is a device ID addition, not
  a bug fix).

**Step 3.3: File History**
- Only 2 commits to this file in the v7.0 tree: creation and one prior
  ID addition.
- The author (Zenm Chen) has contributed multiple similar USB ID
  additions to the rtw89 driver family (D-Link DWA-F18 for rtw8852au,
  MSI AX1800 Nano, etc.).
- Record: [Standalone commit, no dependencies on other patches]

**Step 3.4: Author**
- Zenm Chen is a community contributor who specializes in adding device
  IDs to rtw89/rtw88 drivers.
- Patches accepted by Ping-Ke Shih, the Realtek rtw89 subsystem
  maintainer.
- Record: [Community contributor, maintainer-accepted]

**Step 3.5: Dependencies**
- The diff context shows IDs 0x0411:0x03a6 and 0x37ad:0x0103 which are
  NOT present in the v7.0 tree. These were added by other commits
  post-v7.0.
- However, the actual change (adding 0x056e:0x4024) is completely
  independent of those entries. It just needs to be placed anywhere in
  the table.
- Minor context adjustment needed for clean application, but trivially
  resolvable.
- Record: [No functional dependencies. Trivial context conflict
  expected.]

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.5:**
- b4 dig could not find the commit (the commit is post-v7.0 mainline,
  not yet in this tree).
- Lore.kernel.org was blocked by anti-scraping protection.
- The patch link is
  `https://patch.msgid.link/20260330093440.3615-1-zenmchen@gmail.com`,
  indicating it was a single-patch submission (not part of a series).
- The GitHub link references the out-of-tree morrownr/rtw89 driver repo,
  where this ID was already tested.
- Ping-Ke Shih (maintainer) signed off, indicating acceptance.
- Record: [Single-patch submission, maintainer-accepted, no series
  dependencies]

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1-5.5:**
- No functions modified. The change is purely to a static const data
  table (`rtw_8852cu_id_table[]`).
- The USB core uses this table for device/driver matching via
  `MODULE_DEVICE_TABLE(usb, ...)`.
- No new code paths, no logic changes, no callee/caller analysis needed.
- Record: [No code flow impact, static data table only]

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1:**
- The file `rtw8852cu.c` was created in v6.19 (commit `406849000df41`).
- It exists in v7.0.
- For stable trees older than v6.19, this file does not exist, so the
  commit is irrelevant there.
- Record: [File exists in v6.19+, applicable to 6.19.y and 7.0.y stable
  trees]

**Step 6.2:**
- Minor context conflict: the diff assumes IDs 0x0411:0x03a6 and
  0x37ad:0x0103 are present, but they aren't in v7.0.
- Trivial to resolve: just insert the new 2-line entry into the existing
  table.
- Record: [Minor context adjustment needed, trivially resolvable]

**Step 6.3:**
- No related fixes for this specific device ID in stable.
- Record: [No prior related fixes]

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

**Step 7.1:**
- Subsystem: `drivers/net/wireless/realtek/rtw89` - WiFi driver
- Criticality: IMPORTANT - WiFi connectivity is essential for many
  users, especially USB WiFi adapters on Linux.
- Record: [WiFi driver, IMPORTANT criticality]

**Step 7.2:**
- The rtw89 USB support is actively developed (new file in v6.19,
  multiple ID additions since).
- Record: [Active development]

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Who is affected**
- Users who own an Elecom WDC-XE2402TU3-B USB WiFi adapter.
- Without this ID, the adapter is completely non-functional under Linux.
- Record: [Device-specific: owners of Elecom WDC-XE2402TU3-B]

**Step 8.2: Trigger**
- Plugging in the USB adapter. The USB subsystem matches the device ID
  to bind the driver.
- Record: [Triggered on device plug-in, extremely common operation]

**Step 8.3: Failure Mode**
- Without the fix: the WiFi adapter is simply not recognized. No driver
  binds.
- With the fix: adapter works using the existing, fully-functional
  RTL8832CU driver.
- Severity: MEDIUM (hardware non-functional without it, but no
  crash/corruption).
- Record: [Device not functional without fix, MEDIUM severity]

**Step 8.4: Risk-Benefit**
- BENEFIT: HIGH - enables hardware for real users who purchased this
  adapter.
- RISK: VERY LOW - 2-line addition to a const data table, follows
  identical pattern to all other entries, only affects the specific
  device.
- Ratio: Overwhelmingly favorable.
- Record: [High benefit, very low risk]

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence**

FOR backporting:
- Classic USB device ID addition to existing driver (explicit exception
  category)
- 2-line change, zero logic change, only static data
- Follows identical pattern to all existing entries
- Zero regression risk (only matches specific USB device)
- Maintainer (Ping-Ke Shih) accepted the patch
- Enables real hardware for real users
- The driver infrastructure fully exists in stable

AGAINST backporting:
- Minor context conflict (trivially resolvable)
- Affects only users with this specific adapter (niche audience)

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? **YES** - identical pattern to all
   other entries in the table.
2. Fixes a real bug? **YES (exception)** - device ID addition enables
   hardware support.
3. Important issue? **YES** - hardware doesn't work at all without it.
4. Small and contained? **YES** - 2 lines in 1 file.
5. No new features or APIs? **YES** - no new functionality, just an ID
   entry for existing driver.
6. Can apply to stable trees? **YES** - with trivial context adjustment
   for v7.0.y; file exists since v6.19.

**Step 9.3: Exception Category**
- **Device ID addition to existing driver** - this is explicitly listed
  as an automatic YES for stable.

**Step 9.4: Decision**
This is a textbook device ID addition. 2 lines, zero risk, enables real
hardware. Automatic YES per stable exception rules.

## Verification

- [Phase 1] Parsed commit message: USB device ID addition 056e:4024 for
  Elecom WDC-XE2402TU3-B (RTL8832CU)
- [Phase 1] Parsed tags: Signed-off-by from author (Zenm Chen) and
  maintainer (Ping-Ke Shih), Link to patch.msgid.link
- [Phase 2] Diff analysis: +2 lines to `rtw_8852cu_id_table[]`, no logic
  changes, identical pattern to existing entries
- [Phase 2] Verified new entry uses same `rtw89_8852cu_info` struct as
  all other entries
- [Phase 3] git blame: file created by 406849000df41 (v6.19), only 1
  prior ID addition (5f65ebf9aaf00)
- [Phase 3] git tag --contains 406849000df41: confirmed file exists
  since v6.19
- [Phase 3] git log author: Zenm Chen contributes USB ID additions
  regularly to rtw89/rtw88
- [Phase 3] Verified IDs 0x0411:0x03a6 and 0x37ad:0x0103 from diff
  context do NOT exist in current tree (grep returned no matches) -
  minor context conflict for backport
- [Phase 4] b4 dig failed (commit not in this tree); lore blocked by
  anti-scraping
- [Phase 5] No code logic changes; only static const data table modified
- [Phase 6] File exists in v7.0 (and v6.19+); applicable to those stable
  trees
- [Phase 8] Risk: VERY LOW (2 lines, const data); Benefit: HIGH (enables
  hardware)
- UNVERIFIED: Could not read original mailing list discussion due to
  lore anti-bot protection. This does not affect the decision since the
  change is a trivially verifiable device ID addition.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 314ea7f0ba72d..d0795da154594 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -40,6 +40,8 @@ static const struct rtw89_driver_info rtw89_8852cu_info = {
 static const struct usb_device_id rtw_8852cu_id_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4024, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc832, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc85a, 0xff, 0xff, 0xff),
-- 
2.53.0


