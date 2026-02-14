Return-Path: <linux-wireless+bounces-31858-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sItrEsnokGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31858-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:27:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B066013D65A
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0864301FC8B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ADE29DB99;
	Sat, 14 Feb 2026 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fny6I+Ah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72538275B05;
	Sat, 14 Feb 2026 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104358; cv=none; b=bsWBYIpXZ8emaZm+CczMLoM0hwMWPrKRUPNioj77hXzBVDrPQEwAxbGoWGTNQZTKcwQQJd+pX85wdDd0dM5l4SJmdn3Xv8aI6mBaOIlvbFxq6JKpOeleebmqmy8OzHs0/iDlPTIOwVaUDY96GhjTJ85UmU4SBb6oVIDX5yi1eRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104358; c=relaxed/simple;
	bh=LfB/OXHK6nNuZXdd4ErG/FdhVBuHyGyB7eImBfTn8ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byrpFC/uXeAu2KO18zDnoG0Qqwce86666TpwoLn/HpgrgmnNOsBJPsqY4uKtbutp/kJZ93ahIim8KFj0e7XmAZ1fPjcFO+hDAmXmh7GnpGhDEtGn89CY5oO3MTnPl1mBlSkO5U67MQMER6FBLDJFUS9Tb+vxptU/N/32vCBltm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fny6I+Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2F1C19423;
	Sat, 14 Feb 2026 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104358;
	bh=LfB/OXHK6nNuZXdd4ErG/FdhVBuHyGyB7eImBfTn8ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fny6I+Ah2cJEkwHGKIlvJPmiWBrCAryO2eAJ8N6N3pVP6mu/ez60oz90y6WTlv6+W
	 s+bigyKqlwQ+pQlShTTQCPWFRXaqGcJlRGiA6sK276d0TWbDs9QaJp55pcD548BZhW
	 N5HXDUbbXZn9C7+B5c4LurClax/bxkdWq+oI3HEzEdITCs9pQGT/g+SlzbYbEANssX
	 ZjVORSKCuHS324kDjQt4Vzzd6mwVjiquajRXmV3wTeQJL5p/sonadNCf2iCm8+Gui6
	 haR/MJgUPTwuQOvxFt32yv3aMk9S0YUGcXIL6ZVw6AIutpD/YohV9BwdqmrvVlFamS
	 WIhHTeLDHnp5Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ross Vandegrift <ross@kallisti.us>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.19-6.6] wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1
Date: Sat, 14 Feb 2026 16:23:03 -0500
Message-ID: <20260214212452.782265-38-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31858-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kallisti.us:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,squebb.ca:email,qualcomm.com:email]
X-Rspamd-Queue-Id: B066013D65A
X-Rspamd-Action: no action

From: Ross Vandegrift <ross@kallisti.us>

[ Upstream commit 4015b1972763d7d513172276e51439f37e622a92 ]

Z16 Gen1 has the wakeup-from-suspend issues from [1] but was never added
to the appropriate quirk list.  I've tested this patch on top of 6.18.2,
it fixes the issue for me on 21D4

Mark Pearson provided the other product IDs covering the second Z16 Gen1
and both Z13 Gen1 identifiers.  They share the same firmware, and folks
in the bugzilla report do indeed see the problem on Z13.

[1] - https://bugzilla.kernel.org/show_bug.cgi?id=219196

Signed-off-by: Ross Vandegrift <ross@kallisti.us>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://patch.msgid.link/wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

This commit adds DMI-based power management quirk entries for Lenovo
ThinkPad Z13 Gen1 and Z16 Gen1 laptops to the `ath11k_pm_quirk_table[]`.
The commit message clearly states:

- The Z16 Gen1 has known wakeup-from-suspend issues documented in kernel
  bugzilla #219196
- The fix has been tested on actual hardware (21D4 model)
- Additional product IDs were provided by Mark Pearson (Lenovo engineer)
  covering both Z13 Gen1 and Z16 Gen1 variants
- The devices share the same firmware and users in the bugzilla confirm
  the problem exists on Z13 as well

### Code Change Analysis

The change adds exactly 4 new DMI table entries to the existing
`ath11k_pm_quirk_table[]` array:
- Z13 G1: product names "21D2" and "21D3"
- Z16 G1: product names "21D4" and "21D5"

Each entry follows the identical pattern as every other entry in the
table:
```c
{
    .driver_data = (void *)ATH11K_PM_WOW,
    .matches = {
        DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
        DMI_MATCH(DMI_PRODUCT_NAME, "XXXX"),
    },
},
```

This is a pure data addition — no logic changes, no new code paths, no
new APIs.

### Classification: Hardware Quirk/Workaround

This falls squarely into the **QUIRKS and WORKAROUNDS** exception
category explicitly called out in the stable kernel rules. It adds
hardware-specific quirk entries for devices with broken suspend/resume
behavior. The quirk table and the `ATH11K_PM_WOW` mechanism already
exist in the kernel — this merely extends coverage to additional laptop
models.

### Risk Assessment

- **Risk: Extremely low.** Adding DMI match entries to an existing quirk
  table cannot break anything for other users. The entries only activate
  on the specific Lenovo product IDs listed.
- **Scope: Minimal.** Only one file changed, only data additions, no
  logic changes.
- **Testing: Strong.** The commit has `Tested-by:` from Mark Pearson
  (Lenovo), `Reviewed-by:` from both the Qualcomm ath11k maintainer
  (Baochen Qiang) and Mark Pearson, and was tested by the author on
  actual hardware.

### User Impact

- **Problem:** WiFi fails to work properly after suspend/resume on
  ThinkPad Z13/Z16 Gen1 laptops — a critical issue for laptop users.
- **Affected users:** All owners of these specific Lenovo ThinkPad
  models using the ath11k WiFi driver.
- **Severity:** High — broken suspend/resume on a laptop is a
  significant usability issue that affects daily use.
- **Bugzilla link:** The issue is documented with multiple users
  confirming it.

### Dependency Check

No dependencies on other commits. The quirk table infrastructure already
exists in stable trees. The entries follow the exact same format as
existing entries.

### Conclusion

This is a textbook stable backport candidate: a small, zero-risk, data-
only addition of hardware quirk entries to an existing table, fixing a
real and well-documented suspend/resume bug on specific laptop models,
with proper testing and review from both the hardware vendor and the
subsystem maintainer.

**YES**

 drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 812686173ac8a..03dddc1cd003a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -994,6 +994,34 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z13 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D2"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z13 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D3"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z16 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z16 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
+		},
+	},
 	{}
 };
 
-- 
2.51.0


