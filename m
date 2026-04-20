Return-Path: <linux-wireless+bounces-35077-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMdDIcpN5mkgugEAu9opvQ
	(envelope-from <linux-wireless+bounces-35077-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:01:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD9A42ED63
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE794369A4BF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097B43E9F9;
	Mon, 20 Apr 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWeA2W84"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52B43E9DC;
	Mon, 20 Apr 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691807; cv=none; b=ax2/6jIj5DmnbMNv/HIV4O4HGC6k/F3tRldzneWGQGtqPZEK6H2/fb8LrB5bCl+GsUg55Zq4BuZNjZdPUV7PWyLrJgOWHpvN9NMSl5E4wLMS5FbXPboq50LJDlhtlB9DZE6mqdX3vH0CFinjx3Ab4kNYF4AgXf0Tm2nKqBkttKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691807; c=relaxed/simple;
	bh=C9GfNAWj0YL3ATF78+dtGWFxV72UYQEMgacBgCxE/EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7Ul80mdvIpLaos3xVyA4DT06pAE1EynWjtv2/z0c38ngseaF4LcH7G8GMU+AOCwE3zecDbVcBQEi/QbMt2Jmgcw72xj+OdaDPBiAAJ0h9yWFrkX5H80Ov7oAFbT56Ox4Zgkxi49kLVxh8svoz7YvlOQpG/vXXvScnn+KoBiGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWeA2W84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3360BC2BCB8;
	Mon, 20 Apr 2026 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691807;
	bh=C9GfNAWj0YL3ATF78+dtGWFxV72UYQEMgacBgCxE/EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWeA2W84OKjkIDyz+ZNrb23wmJgOewTwWWU3nJqbN2QhviLSe9xRF4nirtGvSM29Y
	 xlyfwZihj8dw3zuTIPd0vQ439Et9G5zRyO7LeyvIeU79FHIxZPW0fBdw55VsHQu/oS
	 pJS5VvBUe7Zvi9Upzi2uO4kfwAoGiymqVfQjD8nOFFEtOYImxcAWERY8az3ypICHPg
	 ZB9gc9IpZcudrTwe8i5NwsR+WZMk6gD6hZCn2myGMdzhsOtU3VQoaK7DPdV8HhcX+2
	 Alf/Ui83SRXi7cAsbNnE01r3M1kJn0PGnIJCyeo9VJq+5jKdO3elnrXUTZ86ELIWA5
	 NuOTleQC0RWXQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.19] wifi: rtw89: Add support for Buffalo WI-U3-2400XE2
Date: Mon, 20 Apr 2026 09:19:59 -0400
Message-ID: <20260420132314.1023554-205-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-35077-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: CBD9A42ED63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit aefb20749074731c4f35444761e730991f1b8c77 ]

Add the ID 0411:03a6 to the table to support an additional RTL8832CU
adapter: Buffalo WI-U3-2400XE2.

Link: https://github.com/morrownr/rtw89/commit/506d193b8cb7d6394509aebcf8de1531629f6100
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260320154136.5750-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `wifi: rtw89:`
- Action: "Add support for" (new device ID)
- Summary: Adds USB device ID 0411:03a6 for Buffalo WI-U3-2400XE2 WiFi
  adapter to existing RTL8852CU driver.
- Record: [wifi: rtw89] [Add] [USB device ID for Buffalo WI-U3-2400XE2]

**Step 1.2: Tags**
- Link: GitHub commit in morrownr/rtw89 out-of-tree driver (user-
  contributed)
- Signed-off-by: Zenm Chen (author), Ping-Ke Shih (rtw89 subsystem
  maintainer)
- Link: patch.msgid.link for the submission
- No Fixes: tag (expected for device ID additions)
- No Reported-by / Tested-by / Reviewed-by (typical for trivial device
  ID patches)
- Record: Maintainer SOB from Ping-Ke Shih confirms review.

**Step 1.3: Body Text**
- "Add the ID 0411:03a6 to the table to support an additional RTL8832CU
  adapter: Buffalo WI-U3-2400XE2."
- Straightforward description, no bug symptoms, no crash, just enabling
  hardware.
- Record: No bug described. This enables hardware that uses an existing
  chipset/driver.

**Step 1.4: Hidden Bug Fix Detection**
- This is NOT a bug fix. It's a new device ID addition that falls into
  the explicit exception category for stable.
- Record: Not a hidden bug fix; it's a device ID addition (exception
  category).

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Files: `drivers/net/wireless/realtek/rtw89/rtw8852cu.c` (+2 lines)
- Change: Adds one entry to `rtw_8852cu_id_table[]`
- Record: Single file, +2 lines, one USB ID table entry added.

**Step 2.2: Code Flow Change**
- Before: The USB ID table has 8 entries for RTL8852CU devices.
- After: The table has 9 entries, with the new Buffalo device ID
  (0x0411:0x03a6) added.
- The entry uses `USB_DEVICE_AND_INTERFACE_INFO` with the same
  `rtw89_8852cu_info` driver data as all other entries.
- Record: Only change is one new ID table entry; no behavioral changes
  to existing code paths.

**Step 2.3: Bug Mechanism**
- Category: Hardware enablement (device ID addition)
- No bug being fixed; this enables a new device to be recognized by the
  existing driver.
- Record: [Device ID addition] [No bug; enables new hardware]

**Step 2.4: Fix Quality**
- Trivially correct: follows exact same pattern as all other entries in
  the table.
- Zero regression risk: only triggers for the new VID:PID, no impact on
  existing devices.
- Record: Obviously correct. No regression risk.

## PHASE 3: GIT HISTORY

**Step 3.1: Blame**
- The file was created by commit `406849000df41` in v6.19.
- Record: File introduced in v6.19.

**Step 3.2: Fixes tag**
- No Fixes: tag present. Expected for device ID additions.

**Step 3.3: File History**
- Only 2 commits to this file: initial creation (`406849000df41`) and
  one prior device ID addition (`5f65ebf9aaf00` - Valve Steam Deck ID
  28de:2432).
- Record: Standalone patch, no prerequisites.

**Step 3.4: Author's Commits**
- Zenm Chen has contributed multiple USB ID additions to rtw89: D-Link
  VR Air Bridge (DWA-F18), MSI AX1800 Nano (GUAX18N), also to rtw88 and
  btusb drivers.
- Record: Author is a regular contributor of device ID additions.

**Step 3.5: Dependencies**
- None. This is a self-contained 2-line addition to a USB ID table.
- Record: Fully standalone, no dependencies.

## PHASE 4: MAILING LIST / EXTERNAL RESEARCH

**Step 4.1: Patch Discussion**
- Lore protected by Anubis anti-bot; could not fetch directly.
- GitHub link confirmed: the same change was first applied to the
  morrownr/rtw89 out-of-tree driver, confirming user validation.
- Record: Patch originated from real user contribution, validated in
  out-of-tree driver.

**Step 4.2: Reviewers**
- Ping-Ke Shih (Realtek maintainer) signed off, confirming
  review/acceptance.
- Record: Subsystem maintainer reviewed and accepted.

**Step 4.3-4.5: Bug Report / Related Patches / Stable History**
- No bug report (not a bug fix).
- A prior similar device ID addition (`5f65ebf9aaf00` - 28de:2432) was
  already backported to 6.19.y stable as `6f055e0a78d6e`.
- Record: Precedent exists for backporting USB ID additions to this
  exact file in stable.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1-5.5:**
- The change is purely data-level (adding an entry to a `const` table).
- No function modified, no code logic changed.
- The USB subsystem will match the new VID:PID and bind to the existing
  `rtw89_usb_probe` function.
- Record: No code logic changes; purely declarative device ID addition.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Buggy Code in Stable?**
- The file `rtw8852cu.c` was introduced in v6.19, present in 7.0.y and
  6.19.y.
- Does NOT exist in older trees (6.12.y, 6.6.y, etc.).
- Record: File exists in v6.19.y and v7.0.y.

**Step 6.2: Backport Complications**
- The current tree (v7.0) has 8 entries in the table. The 6.19.y stable
  has 7 entries (missing 28de:2432 which was backported separately as
  `6f055e0a78d6e`).
- The patch adds the entry at the beginning of the table; it should
  apply cleanly or with trivial context adjustment.
- Record: Clean apply expected (may need minor fuzz for ordering).

**Step 6.3: Related Fixes Already in Stable**
- No previous fix for this specific device (it's a new ID).
- Record: No conflicts.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1:** WiFi drivers - IMPORTANT subsystem. Buffalo is a well-
known consumer electronics brand.
**Step 7.2:** rtw89 is actively developed with USB support being
relatively new (v6.19+).

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1:** Affects users of Buffalo WI-U3-2400XE2 USB WiFi adapter -
without this ID, the adapter is not recognized.
**Step 8.2:** Trigger: every time the device is plugged in (100%
reproducible - device doesn't work without it).
**Step 8.3:** Failure mode without fix: hardware doesn't work at all.
Severity: HIGH for affected users.
**Step 8.4:**
- Benefit: HIGH - enables hardware for real users (the patch came from a
  user contribution)
- Risk: VERY LOW - 2 lines, const data addition, cannot affect other
  devices
- Ratio: Strongly favorable

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: Evidence**
- FOR: Textbook device ID addition; trivially correct; 2 lines; zero
  regression risk; subsystem maintainer signed off; author has track
  record; precedent for same-file backports to stable; enables real
  hardware for real users
- AGAINST: None identified
- UNRESOLVED: Could not fetch lore discussion due to anti-bot protection

**Step 9.2: Stable Rules Checklist**
1. Obviously correct and tested? YES - follows exact pattern of all
   existing entries
2. Fixes a real bug? YES (exception category - enables hardware)
3. Important issue? YES for affected users - hardware non-functional
   without it
4. Small and contained? YES - 2 lines in one file
5. No new features or APIs? YES - just a device ID
6. Can apply to stable trees? YES - file exists in 6.19.y and 7.0.y

**Step 9.3: Exception Category**
YES - this is a **new device ID addition to an existing driver**, which
is explicitly listed as an exception category that is appropriate for
stable.

## Verification

- [Phase 1] Parsed tags: Signed-off-by from rtw89 maintainer Ping-Ke
  Shih
- [Phase 2] Diff analysis: +2 lines adding
  USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, ...) to ID table
- [Phase 3] git show 406849000df41: confirmed file created in v6.19
- [Phase 3] git describe --contains 406849000df41: first appeared in
  v6.19
- [Phase 3] git log for file: only 2 prior commits, no complex history
- [Phase 3] Author Zenm Chen: verified 5 other device ID additions in
  rtw89/rtw88/btusb
- [Phase 4] GitHub link: confirmed same change validated in
  morrownr/rtw89 out-of-tree driver
- [Phase 4] UNVERIFIED: Could not access lore.kernel.org discussion
  (anti-bot protection)
- [Phase 5] Grep for 0x0411: Buffalo vendor ID already in rtw8852au.c
  (known vendor)
- [Phase 6] git log v6.19..v6.19.12: confirmed similar ID addition
  (5f65ebf9aaf00) already backported to 6.19.y stable
- [Phase 6] File exists in 7.0 and 6.19.y; does NOT exist in older trees
- [Phase 8] Risk: VERY LOW (2-line const data); Benefit: HIGH (enables
  hardware)

This is a textbook USB device ID addition to an existing driver - the
most straightforward type of stable backport. It's 2 lines, trivially
correct, zero risk, enables real hardware for real users, was reviewed
by the subsystem maintainer, and there is direct precedent for identical
backports to this exact file.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 3b9825c92a0d9..a485dacbb0531 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -38,6 +38,8 @@ static const struct rtw89_driver_info rtw89_8852cu_info = {
 };
 
 static const struct usb_device_id rtw_8852cu_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc832, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc85a, 0xff, 0xff, 0xff),
-- 
2.53.0


