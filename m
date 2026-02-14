Return-Path: <linux-wireless+bounces-31843-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MWMOVjokGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31843-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC413D518
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D723A3045AB7
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7102C11E2;
	Sat, 14 Feb 2026 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGyHK04q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AB241665;
	Sat, 14 Feb 2026 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104301; cv=none; b=mDssRWlSJRqRQ1BN6exfkw3fAJ+efRY0sEjgUJB1cTW+kF7wE88SUGmjgMkR6NJaLUL4gdt1p1vU3nC9JthO59MEEv0GaaN+hA4bVlLmzaYKtwBem5V3FNEB4ToAu0OQu0FkGRQNRrHpY4Oopl91iCnNIu0zFzUf+VzCsppxb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104301; c=relaxed/simple;
	bh=0zaMdaW5V9eh6ift6xDfGX0Sbu9Si0t4ROIF/YNGBI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YR2Q2JEqD4nSVoE3EYN08jdbsftg3mVnNOeoJujKQJkC+1H+yW2Bh/GGXSw/NMF7Dc2ElQzqTgnVyHxFVibAyqwGUQA2gQMjbsNX9sAV6XEWVBxkGGM7ao0BYh2bKC7p+Tc571pxgiv9iDZVhuvVVahmabzwI1A5vs6p6Z1Za28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGyHK04q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B03DC16AAE;
	Sat, 14 Feb 2026 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104301;
	bh=0zaMdaW5V9eh6ift6xDfGX0Sbu9Si0t4ROIF/YNGBI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGyHK04qu4pnRxLf0zUFbr/vVGipGhvJJypvYfuOszQ5mOduJDOeDM5tnlMlkiLRL
	 Fjn4uGG/S6MyjPsvl+V8PacTu+BJ07Cyb2CaoTxTt5ZPKZhjxTFv2meckRyHAfXNsl
	 gtpUPAM0naYZqAzmRrT0DCJ+FlJulFz5Ohj6v3o61L/5u/wZwkkecVlvxd6COQMoln
	 5yzMzm4KT+q/ingsq7KMG0noZ82/KRSgUEflqDnWVMrHrJlmp3qqVVLWP2Q7isFFxf
	 cqdGCy5NW/d4DVwuMVNbacAYNNdJrDKdO25n7gsiK5ZKr8AEdMk8PhOtpAhmymZ3BE
	 qlpZtccXwYbWg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Po-Hao Huang <phhuang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: rtw89: 8922a: add digital compensation for 2GHz
Date: Sat, 14 Feb 2026 16:22:30 -0500
Message-ID: <20260214212452.782265-5-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31843-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5FFC413D518
X-Rspamd-Action: no action

From: Po-Hao Huang <phhuang@realtek.com>

[ Upstream commit 8da7e88682d58a7c2e2c2101e49d3c9c9ac481b0 ]

This fixes transmit power too low under 2GHz connection. Previously
we missed the settings of 2GHz, add the according calibrated tables.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260117044157.2392958-10-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

The commit says it "fixes transmit power too low under 2GHz connection"
by adding previously "missed" calibration tables for the 2GHz band. The
subject says "add digital compensation for 2GHz" — this is framed as
adding missing functionality rather than fixing a clear crash/corruption
bug.

### Code Change Analysis

Let me examine the changes in detail:

1. **New data tables added**: Three new static const arrays
   (`rtw8922a_digital_pwr_comp_2g_s0_val`,
   `rtw8922a_digital_pwr_comp_2g_s1_val`) containing calibration values
   for 2GHz band, for path 0 (s0) and path 1 (s1). These are ~37 lines
   of pure data.

2. **Function signature change**: `rtw8922a_set_digital_pwr_comp()`
   changes the `bool enable` parameter to `u8 band`. This is a semantic
   change — previously, for 2GHz, the function would write zeros to all
   registers (effectively disabling compensation). Now it writes band-
   specific calibration values.

3. **Logic change in `rtw8922a_set_digital_pwr_comp()`**: Previously, if
   `enable` was false (2GHz band), all registers were set to 0 (`val =
   enable ? digital_pwr_comp[i] : 0`). Now, the function always writes
   calibration data, selecting the appropriate table based on band and
   path.

4. **Logic change in `rtw8922a_digital_pwr_comp()`**: The `bool enable =
   chan->band_type != RTW89_BAND_2G` is replaced with `u8 band =
   chan->band_type`, and the band is passed through to the set function.

### Bug Assessment

The original code had a real functional deficiency: on 2GHz, digital
power compensation was completely disabled (all zeros written),
resulting in "transmit power too low." This means:

- **Real user impact**: WiFi connections on 2.4GHz band would have poor
  signal/throughput on the RTW8922A chip
- **This is a bug fix**: The 2GHz compensation data was supposed to be
  there but was missing. The existing code structure (with
  enable/disable logic) was a workaround for having no 2GHz tables

### Scope and Risk Assessment

- **Files changed**: 1 file (rtw8922a.c)
- **Lines added**: ~47 lines of data tables + ~15 lines of logic changes
- **Lines removed**: ~10 lines
- **Scope**: Entirely contained within the RTW8922A WiFi driver
- **Risk**: Low — the change only affects the RTW8922A chip on 2GHz
  band. The 5GHz/6GHz paths continue to use the same tables as before.
  The logic is straightforward table selection based on band and path.

### Stable Kernel Criteria Check

1. **Obviously correct and tested**: The change is from the Realtek
   driver maintainers themselves, adding calibration data they would
   have tested. The logic is simple table selection.
2. **Fixes a real bug**: Yes — transmit power too low on 2GHz is a real
   functional bug affecting WiFi connectivity.
3. **Important issue**: This affects basic WiFi functionality on 2.4GHz
   for users of this chip. Low TX power means poor range, throughput,
   and possibly connection drops.
4. **Small and contained**: Yes — single driver file, straightforward
   table data addition and selection logic.
5. **No new features**: This restores intended functionality rather than
   adding new capability. The driver already supported 2GHz band; it
   just had wrong/missing calibration data.

### Concerns

- **RTW8922A is a newer chip**: This is a WiFi 7 (802.11be) chip. Need
  to verify it exists in stable trees. The file `rtw8922a.c` was added
  relatively recently, so it may not be present in older stable branches
  (e.g., 6.1.y, 5.15.y). However, if it is present in a given stable
  tree, this fix is clearly needed.
- **No explicit Fixes: tag**: Expected for candidates under review.
- **Data tables are large**: But they're static const data with zero
  risk of runtime regression.
- **The `enable` parameter removal**: The old `val = enable ?
  digital_pwr_comp[i] : 0` path (writing zeros for 2GHz) is completely
  removed. This is the intended behavior change — from "disable on 2GHz"
  to "use proper 2GHz tables."

### Verdict

This fixes a real functional bug (low transmit power on 2.4GHz WiFi) for
users of the RTW8922A chip. The fix is contained within a single driver,
adds only calibration data tables and simple selection logic, and comes
from the chip vendor's driver team. While it's a relatively new driver,
for any stable tree that contains this driver, the fix would be
important — 2.4GHz WiFi with too-low TX power is essentially broken for
many use cases.

The change is low-risk, driver-specific, and fixes a real user-facing
problem. It meets stable kernel criteria.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 57 +++++++++++++++----
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 4bcf20612a455..52da0fa02da01 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1770,6 +1770,32 @@ static int rtw8922a_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
 }
 
 #define DIGITAL_PWR_COMP_REG_NUM 22
+static const u32 rtw8922a_digital_pwr_comp_2g_s0_val[][DIGITAL_PWR_COMP_REG_NUM] = {
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010000, 0x00000101,
+	 0x01010101, 0x02020201, 0x02010000, 0x03030202, 0x00000303,
+	 0x03020101, 0x06060504, 0x01010000, 0x06050403, 0x01000606,
+	 0x05040202, 0x07070706},
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010100, 0x00000101,
+	 0x01000000, 0x01010101, 0x01010000, 0x02020202, 0x00000404,
+	 0x03020101, 0x04040303, 0x02010000, 0x03030303, 0x00000505,
+	 0x03030201, 0x05050303},
+};
+
+static const u32 rtw8922a_digital_pwr_comp_2g_s1_val[][DIGITAL_PWR_COMP_REG_NUM] = {
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x01010000, 0x01010101, 0x00000101,
+	 0x01010100, 0x01010101, 0x01010000, 0x02020202, 0x01000202,
+	 0x02020101, 0x03030202, 0x02010000, 0x05040403, 0x01000606,
+	 0x05040302, 0x07070605},
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010100, 0x00000101,
+	 0x01010000, 0x02020201, 0x02010100, 0x03030202, 0x01000404,
+	 0x04030201, 0x05050404, 0x01010100, 0x04030303, 0x01000505,
+	 0x03030101, 0x05050404},
+};
+
 static const u32 rtw8922a_digital_pwr_comp_val[][DIGITAL_PWR_COMP_REG_NUM] = {
 	{0x012C0096, 0x044C02BC, 0x00322710, 0x015E0096, 0x03C8028A,
 	 0x0BB80708, 0x17701194, 0x02020100, 0x03030303, 0x01000303,
@@ -1784,7 +1810,7 @@ static const u32 rtw8922a_digital_pwr_comp_val[][DIGITAL_PWR_COMP_REG_NUM] = {
 };
 
 static void rtw8922a_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
-					  bool enable, u8 nss,
+					  u8 band, u8 nss,
 					  enum rtw89_rf_path path)
 {
 	static const u32 ltpc_t0[2] = {R_BE_LTPC_T0_PATH0, R_BE_LTPC_T0_PATH1};
@@ -1792,14 +1818,25 @@ static void rtw8922a_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
 	u32 addr, val;
 	u32 i;
 
-	if (nss == 1)
-		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[0];
-	else
-		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[1];
+	if (nss == 1) {
+		if (band == RTW89_BAND_2G)
+			digital_pwr_comp = path == RF_PATH_A ?
+				rtw8922a_digital_pwr_comp_2g_s0_val[0] :
+				rtw8922a_digital_pwr_comp_2g_s1_val[0];
+		else
+			digital_pwr_comp = rtw8922a_digital_pwr_comp_val[0];
+	} else {
+		if (band == RTW89_BAND_2G)
+			digital_pwr_comp = path == RF_PATH_A ?
+				rtw8922a_digital_pwr_comp_2g_s0_val[1] :
+				rtw8922a_digital_pwr_comp_2g_s1_val[1];
+		else
+			digital_pwr_comp = rtw8922a_digital_pwr_comp_val[1];
+	}
 
 	addr = ltpc_t0[path];
 	for (i = 0; i < DIGITAL_PWR_COMP_REG_NUM; i++, addr += 4) {
-		val = enable ? digital_pwr_comp[i] : 0;
+		val = digital_pwr_comp[i];
 		rtw89_phy_write32(rtwdev, addr, val);
 	}
 }
@@ -1808,7 +1845,7 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
-	bool enable = chan->band_type != RTW89_BAND_2G;
+	u8 band = chan->band_type;
 	u8 path;
 
 	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
@@ -1816,10 +1853,10 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 			path = RF_PATH_A;
 		else
 			path = RF_PATH_B;
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 1, path);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 1, path);
 	} else {
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_A);
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_B);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 2, RF_PATH_A);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 2, RF_PATH_B);
 	}
 }
 
-- 
2.51.0


