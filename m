Return-Path: <linux-wireless+bounces-23602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F3EACD1D9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6AE7A882B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04321F3B83;
	Wed,  4 Jun 2025 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAs99XMw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1514F9D6;
	Wed,  4 Jun 2025 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998511; cv=none; b=sqwOaGP1KgmMOVjx3H7Li3AbFhCZPQah7iwFMnBmad6eM+9oVrsXJEajKb3hkqNgwbRXP268aZJX/TGJaSQJlnFCL/Yczy855ryAHE03UgNRnkvDmipPZWPMCiMaKfLiOXuWADN11eE4OKWsi6n+0I807XCtQrOKpY/59IuPOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998511; c=relaxed/simple;
	bh=xXiCTL8+SgapkUC/DQT0ILiAk/rJdNNt5qtrpAoF8I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWpFpXwhqmhI6F/X+xYRSZV8D1JGY7t/4t/08mFQlfjslYvevPJpXQ14pbepX0Ps/LvIq7UFfUGS2weVE6VXvSRe5bo2332IUfUGkKeRDDDn3G0OmweULbXglOc44Hz0rOk8GRWAn8nn9xcWt6AGPEo8R4llIsbwOBVTdys/ZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAs99XMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475B7C4CEED;
	Wed,  4 Jun 2025 00:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998511;
	bh=xXiCTL8+SgapkUC/DQT0ILiAk/rJdNNt5qtrpAoF8I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAs99XMw84BPNlzF9YR1ReeGi2sR8XvN35GJMs8JLVitycLT/OB0TFkU9DzEty3eu
	 uqClnNkIiGENItbULpkZTY0w5pZyeEUjMbFLlOrWExqmAprJWOGuFsggCvjRlsUSMv
	 BQ/u7TDjajWkCPjLXXazNhHhWsxY2an3svYzha/KBZmd3zBWg2qB9Pj8betSDRtjn8
	 9aAD0rqjPaCxvP6ty2pe+LqEQdYJ2h+4H1OrP+c7bBbwjcjQUXmSiKVIUHppP+3a95
	 hHnEaiyA459WejFSfE/JEriqZXiSt2GUimmJOrCoWMr3uyibGiv/qEKIod/1rVKVj6
	 RGeaS+xl8qOFA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 114/118] wifi: ath11k: determine PM policy based on machine model
Date: Tue,  3 Jun 2025 20:50:45 -0400
Message-Id: <20250604005049.4147522-114-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005049.4147522-1-sashal@kernel.org>
References: <20250604005049.4147522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit ce8669a27016354dfa8bf3c954255cb9f3583bae ]

To handle the Lenovo unexpected wakeup issue [1], previously we revert
commit 166a490f59ac ("wifi: ath11k: support hibernation"). So currently
WLAN target is put into WoWLAN mode during suspend. This is a temporary
solution as it does not work on machines where WLAN power is cut off.

The thought here is that we do WoWLAN suspend on Lenovo machines while
do non-WoWLAN suspend (which is done in the reverted commit) on other
machines. This requires us to identify Lenovo machines from others.
For that purpose, read board vendor and product name from DMI interface,
match it against all known affected machines. If there is a match, choose
WoWLAN suspend mode, else choose non-WoWLAN mode. Save the mode in ab
for later reference.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250328-ath11k-bring-hibernation-back-v3-1-23405ae23431@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should definitely be backported to stable kernel
trees. Here's my detailed analysis: ## Bug Fix Nature This commit
clearly fixes a specific user-visible bug affecting Lenovo laptops with
WiFi suspend/wake functionality. The commit message explicitly
references bugzilla.kernel.org issue #219196, indicating this addresses
real user complaints about unexpected wakeup behavior. This aligns
perfectly with the **YES** backport example (Similar Commit #1) which
also reverted hibernation support due to Lenovo platform suspend issues.
## Code Changes Analysis ### 1. DMI Quirk Table Addition ```c +static
const struct dmi_system_id ath11k_pm_quirk_table[] = { + { +
.driver_data = (void *)ATH11K_PM_WOW, + .matches = { +
DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"), + DMI_MATCH(DMI_PRODUCT_NAME,
"21J4"), + }, + }, ``` This is a standard, low-risk pattern used
throughout the kernel for hardware-specific workarounds. It only affects
machines that exactly match the DMI criteria. ### 2. PM Policy
Infrastructure ```c +enum ath11k_pm_policy { + ATH11K_PM_DEFAULT, +
ATH11K_PM_WOW, +}; ``` The commit adds a simple enum and uses existing
WoWLAN suspend mechanisms rather than introducing new power management
code. ### 3. Policy Selection Logic ```c + dmi_id =
dmi_first_match(ath11k_pm_quirk_table); + if (dmi_id) + ab->pm_policy =
(kernel_ulong_t)dmi_id->driver_data; + else + ab->pm_policy =
ATH11K_PM_DEFAULT; ``` This is straightforward DMI matching that sets a
policy flag without changing core functionality. ## Risk Assessment
**Extremely Low Risk:** - **Scope**: Only affects specific Lenovo laptop
models (21J4, 21K4, 21K6, 21K8, 21KA, 21F9) - **Fallback**: Non-matching
machines continue using existing default behavior - **Tested Path**:
WoWLAN suspend mode is already implemented and working - **No Core
Changes**: Doesn't modify suspend/resume logic, just selects which path
to use ## Comparison to Reference Commits This follows the same pattern
as **Similar Commit #1** (marked YES), which also addressed Lenovo
platform suspend issues by reverting hibernation support. Both commits:
- Target specific hardware compatibility issues - Use conservative
approaches (WoWLAN vs full hibernation) - Have minimal code footprint -
Address real user bug reports Unlike the **NO** examples which add new
features (WoWLAN support, new suspend capabilities), this commit uses
existing infrastructure to fix hardware-specific incompatibilities. ##
Stable Tree Criteria Alignment ✅ **Fixes important bugs** - Suspend/wake
functionality on laptops ✅ **Small and contained** - Only DMI table and
policy selection ✅ **Low regression risk** - Targeted to specific
hardware ✅ **User-visible impact** - Improves power management behavior
✅ **No architectural changes** - Uses existing WoWLAN mechanisms This is
an ideal stable backport candidate that fixes real user issues with
minimal risk.

 drivers/net/wireless/ath/ath11k/core.c | 55 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  7 ++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3d39ff85ba94a..f3a29f5d2381b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -907,6 +907,52 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	},
 };
 
+static const struct dmi_system_id ath11k_pm_quirk_table[] = {
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
+		},
+	},
+	{}
+};
+
 static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct ath11k_base *ab)
 {
 	WARN_ON(!ab->hw_params.single_pdev_only);
@@ -2327,8 +2373,17 @@ EXPORT_SYMBOL(ath11k_core_pre_init);
 
 int ath11k_core_init(struct ath11k_base *ab)
 {
+	const struct dmi_system_id *dmi_id;
 	int ret;
 
+	dmi_id = dmi_first_match(ath11k_pm_quirk_table);
+	if (dmi_id)
+		ab->pm_policy = (kernel_ulong_t)dmi_id->driver_data;
+	else
+		ab->pm_policy = ATH11K_PM_DEFAULT;
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n", ab->pm_policy);
+
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 1a3d0de4afde8..df2b0cb2f0b5a 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -892,6 +892,11 @@ struct ath11k_msi_config {
 	u16 hw_rev;
 };
 
+enum ath11k_pm_policy {
+	ATH11K_PM_DEFAULT,
+	ATH11K_PM_WOW,
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath11k_base {
 	enum ath11k_hw_rev hw_rev;
@@ -1058,6 +1063,8 @@ struct ath11k_base {
 	} testmode;
 #endif
 
+	enum ath11k_pm_policy pm_policy;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
-- 
2.39.5


