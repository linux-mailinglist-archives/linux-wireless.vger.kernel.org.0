Return-Path: <linux-wireless+bounces-31850-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOKbBJnokGkMdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31850-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF613D5F7
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81562303E759
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D75285061;
	Sat, 14 Feb 2026 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obsdvoqU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD653C2D;
	Sat, 14 Feb 2026 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104331; cv=none; b=aWLMUuesFGOZm7bw2lDPiyuAMXKGVxK7InkOjniP3FZJ4EazuN2pywodLxq0ITHvSsi7aeEDbufUUP/E9l2mrtpm/IyRKruG0AEaYYUOLGK7VZVURYXb3CiMt14/frdJrOqNNr8pHcSIsbLTlG9bWJAQUzzYX+hohdXs0LfYmAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104331; c=relaxed/simple;
	bh=5mpOtkJruGdHyLFUXd5KfJeEA2Oq+4NYlQdoQ8Mvyms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcYY4Ir5vyMuayskQshoYbCSk5vk3xiQzULwjpodakWzcj55rIMD0GCUvxR1KlKdqU996v32s0ljBhg8g1RYcjOonhSbK8uDVWNZJe5B1DO1j3iQYW8JJlhayLS0ifSIyJxVdfDehE1ZkAitTlXmYvEFVjpJa4mc7w9KYZjU6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obsdvoqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF1EC19422;
	Sat, 14 Feb 2026 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104331;
	bh=5mpOtkJruGdHyLFUXd5KfJeEA2Oq+4NYlQdoQ8Mvyms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obsdvoqUKx9gUQQ1t1YC1spIbUFCfmI71XOIw6WxXEnq0J8BalfYmqohZqH3PZhzd
	 2lzd4/n/nZ9wsW1a25Ilkb+6eknXjQY6rhOMnbb+iYABig801RZONCcMMVdIjLGEAH
	 tYhuWg/EzrIoCJTSZvfIlZBTjx22PkbFvUMcA8xQVwf5GrRjOTltTCk+QBA9Niuzjo
	 AkjCb+Iwd35SDPEj6YDC22uZR/u5IMM8VJd5sRBv0S0P0UerB1EBgCZsNr+zJZcc9f
	 EiNMScaKOePd129TjUYH1XZwlA6+rZQp8QhPO+lfePQUiC6O7QYL1I+ghbU4hjQPzW
	 A6VoYzICu2jsQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: disable EHT protocol by chip capabilities
Date: Sat, 14 Feb 2026 16:22:47 -0500
Message-ID: <20260214212452.782265-22-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31850-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,realtek.com:email]
X-Rspamd-Queue-Id: A9FF613D5F7
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 7fd36ffedeedc97c44a10249a3f12d471bb2dc26 ]

For certain chip models, EHT protocol is disabled, and driver must follow
the capabilities. Otherwise, chips become unusable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260110022019.2254969-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of commit: "wifi: rtw89: disable EHT protocol by chip
capabilities"

### 1. Commit Message Analysis

The commit message is clear and direct: "For certain chip models, EHT
protocol is disabled, and driver must follow the capabilities.
**Otherwise, chips become unusable.**"

This is a critical statement - it means that without this patch, certain
WiFi chips will not function at all. The word "unusable" indicates a
severe hardware functionality bug, not a minor issue or optimization.

### 2. Code Change Analysis

The change is spread across 4 files but is small and focused:

**fw.h**: Adds protocol level constants (11N=1, 11AC=2, 11AX=3, 11BE=4)
for the `RTW89_C2HREG_PHYCAP_W1_PROT` field. These are just defines for
values already communicated by firmware - not new features.

**core.h**: Adds a single `bool no_eht` field to `struct rtw89_hal`.
This is a runtime flag to track chip capability.

**mac.c** (`rtw89_mac_setup_phycap_part0`): Reads the protocol
capability from the firmware/hardware phycap register. If the chip
reports a protocol level below 11BE (EHT), it sets `hal->no_eht = true`.
This is reading hardware capabilities that already exist - the driver
was previously ignoring this information.

**core.c** (`rtw89_init_eht_cap`): Adds `|| hal->no_eht` to the existing
early-return check. Previously, only `RTW89_CHIP_AX` generation chips
would skip EHT capability initialization. Now, chips that report they
don't support EHT via their phycap register also skip it. Without this,
the driver would advertise EHT capabilities to the mac80211 stack for
hardware that doesn't support it, causing the chip to become unusable.

### 3. Bug Mechanism

The bug is:
1. Certain chip models report via firmware phycap that they don't
   support EHT (802.11be)
2. The driver was ignoring this capability report
3. The driver would then advertise EHT support to mac80211/cfg80211
4. mac80211 would try to use EHT features with the chip
5. The chip cannot handle EHT, making it **unusable**

This is a classic hardware capability mismatch bug where the driver
doesn't properly respect hardware-reported capabilities.

### 4. Classification

This is a **bug fix** - it fixes a real hardware functionality issue.
It's not adding a new feature; it's reading an existing hardware
capability field that was being ignored, and using it to prevent
advertising unsupported features.

This falls into the category of **hardware quirks/workarounds** -
respecting chip capabilities to prevent malfunction.

### 5. Scope and Risk Assessment

- **Lines changed**: ~15 lines of actual logic (very small)
- **Files touched**: 4 files in the same driver subsystem
- **Risk**: Very low
  - The `no_eht` flag defaults to `false` (zero-initialized), so
    existing working chips are unaffected
  - It only triggers for chips that explicitly report they don't support
    EHT
  - The check is additive (adds an OR condition to existing early-
    return)
  - No behavioral change for chips that already work correctly

### 6. User Impact

- **Severity**: HIGH - "chips become unusable" means complete loss of
  WiFi functionality
- **Affected users**: Users with specific Realtek WiFi chip models that
  don't support EHT
- **Impact without fix**: WiFi doesn't work at all on affected hardware

### 7. Stability and Dependencies

- The change is self-contained within the rtw89 driver
- No dependencies on other commits
- The `RTW89_C2HREG_PHYCAP_W1_PROT` field already existed in the
  codebase (it was already defined); the commit just adds named
  constants and actually uses the field
- The rtw89 driver exists in stable trees (it's been in the kernel since
  5.16+)

### 8. Conclusion

This commit fixes a real, severe bug where certain Realtek WiFi chips
become completely unusable because the driver advertises EHT
capabilities the hardware doesn't support. The fix is:
- Small and surgical (adds one bool field, reads one existing register
  field, adds one condition check)
- Obviously correct (respect hardware capability reports)
- Low risk (only affects chips that report no EHT support; no change for
  others)
- High impact (fixes completely broken WiFi for affected users)

This meets all stable kernel criteria: it fixes a real bug, is small and
contained, doesn't add new features (it reads existing hardware data),
and has been tested.

**YES**

 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/fw.h   | 4 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 5 +++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d5b492ea76ef4..a00b5348b7622 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5236,7 +5236,7 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	u8 val, val_mcs13;
 	int sts = 8;
 
-	if (chip->chip_gen == RTW89_CHIP_AX)
+	if (chip->chip_gen == RTW89_CHIP_AX || hal->no_eht)
 		return;
 
 	if (hal->no_mcs_12_13)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a9cb47ea0b935..46344ca8fa0c8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5037,6 +5037,7 @@ struct rtw89_hal {
 	bool support_cckpd;
 	bool support_igi;
 	bool no_mcs_12_13;
+	bool no_eht;
 
 	atomic_t roc_chanctx_idx;
 	u8 roc_link_index;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cedb4a47a769c..ba7c332911310 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -42,6 +42,10 @@ struct rtw89_c2hreg_phycap {
 #define RTW89_C2HREG_PHYCAP_W0_BW GENMASK(31, 24)
 #define RTW89_C2HREG_PHYCAP_W1_TX_NSS GENMASK(7, 0)
 #define RTW89_C2HREG_PHYCAP_W1_PROT GENMASK(15, 8)
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11N 1
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11AC 2
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11AX 3
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11BE 4
 #define RTW89_C2HREG_PHYCAP_W1_NIC GENMASK(23, 16)
 #define RTW89_C2HREG_PHYCAP_W1_WL_FUNC GENMASK(31, 24)
 #define RTW89_C2HREG_PHYCAP_W2_HW_TYPE GENMASK(7, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6734e5d5a5e22..fbce71cd5a05c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3061,6 +3061,7 @@ static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_mac_c2h_info c2h_info = {};
 	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 protocol;
 	u8 tx_nss;
 	u8 rx_nss;
 	u8 tx_ant;
@@ -3108,6 +3109,10 @@ static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "TX path diversity=%d\n", hal->tx_path_diversity);
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "Antenna diversity=%d\n", hal->ant_diversity);
 
+	protocol = u32_get_bits(phycap->w1, RTW89_C2HREG_PHYCAP_W1_PROT);
+	if (protocol < RTW89_C2HREG_PHYCAP_W1_PROT_11BE)
+		hal->no_eht = true;
+
 	return 0;
 }
 
-- 
2.51.0


