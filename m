Return-Path: <linux-wireless+bounces-28254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33530C097E2
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542964E79B4
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE83064A9;
	Sat, 25 Oct 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLLZMvJT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B51305053;
	Sat, 25 Oct 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409082; cv=none; b=XZHXGNqU3iYJkfwRPIWj89yWO5I3ZWd2nvUTmIoB0XMU3/M+PihkPMLVcU2KAKN94gtfQKvzY18TEgEt5nSeDgCirWxRWGsBeWeHA9gdlQerCQROXMf15Mwc6Crarr0JmlzIj3A6VEhbuHihQniKYH/uqCMMCB+Ydn7wSgC5iYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409082; c=relaxed/simple;
	bh=Jml9uvd05nACuQWqNyHadMfowCjE73TRBnUi4iABmQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+8pshmHckrfcgYuFkfO7KpTuyH0KmnwzrJBqbICUikpbzE77p1nKY6mstG/egjD/eSBlQT+ZP+ksXqFPbnWAUh3PKvIXqhidlQkx7sCxwsClUn3qdFzPbNS8gW68LWpeFRVcF5m7NrUnAkoX6+/0cDSiLVIcfUYvVeN+MYrxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLLZMvJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CE1C4CEF5;
	Sat, 25 Oct 2025 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409079;
	bh=Jml9uvd05nACuQWqNyHadMfowCjE73TRBnUi4iABmQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLLZMvJTfBxdPTLgWmv1cCXuC396fpwhY8UIhmDGj4U3njD2Fm5RBOFYaUOl7dMQG
	 Zoog5T3TSpR11mr3/B1K8L9or8TiGGA72UW/8YxGtfcOpZ7GxqbsqfYKDfUDNtOvXS
	 yl72CV5wezFpmXRtxvh2aeV6wE8wY9e2EAyuZpOIPYkVJzIv5NoW7dV1Xvf1yZ2wmX
	 5Sz0FLivFVe77UpvVMU6BJJRfYr8O73rWNHl3yurGvLdzCi7rQCCeYTwbTJNx98LZZ
	 GSZiefutb7gSH4XA1WuKVh3t5TBFF0p++NHwjZTcc6KmSER3ld+qcOYnQMj41C6ciy
	 WG27ILUcoDhgg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: rtw89: coex: Limit Wi-Fi scan slot cost to avoid A2DP glitch
Date: Sat, 25 Oct 2025 11:57:05 -0400
Message-ID: <20251025160905.3857885-194-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ching-Te Ku <ku920601@realtek.com>

[ Upstream commit ebea22c7f1b2f06f4ff0719d76bd19830cf25c9f ]

When Wi-Fi is scanning at 2.4GHz, PTA will abort almost all the BT request.
Once the Wi-Fi slot stay too long, BT audio device can not get enough data,
audio glitch will happened. This patch limit 2.4Ghz Wi-Fi slot to 80ms
while Wi-Fi is scanning to avoid audio glitch.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250819034428.26307-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my thorough analysis of this commit, I can now provide my
recommendation:

## BACKPORT RECOMMENDATION

**YES**

## DETAILED ANALYSIS

### What the Commit Changes

The commit makes two types of modifications to the Wi-Fi/Bluetooth
coexistence (coex) subsystem in the rtw89 driver:

1. **CXST_ENULL Slot Configuration Change**
   (drivers/net/wireless/realtek/rtw89/coex.c:96):
   - **Before**: `CXST_ENULL = (5ms, 0xaaaaaaaa, SLOT_ISO)`
   - **After**: `CXST_ENULL = (5ms, 0x55555555, SLOT_MIX)`
   - **Impact**: Changes the slot from SLOT_ISO (isolates Wi-Fi, rejects
     BT low-priority requests) to SLOT_MIX (allows mixing, accepts BT
     low-priority requests). The PTA control bitmask changes from
     0xaaaaaaaa to 0x55555555 (inverse bit pattern).

2. **Duration Limiting for CXST_EBT Slot**
   (drivers/net/wireless/realtek/rtw89/coex.c:4156, 4166, 4175):
   - Adds `_slot_set_dur(btc, CXST_EBT, dur_2)` to three coexistence
     policy cases:
     - `BTC_CXP_OFFE_DEF` - Default off-extended policy
     - `BTC_CXP_OFFE_DEF2` - Alternative default policy
     - `BTC_CXP_OFFE_2GBWMIXB` - 2.4GHz bandwidth mixed-BT policy
   - `dur_2` is set to `dm->e2g_slot_limit` which equals
     `BTC_E2G_LIMIT_DEF` (80ms)

### Problem Being Solved

This commit addresses a **real user-facing bug** affecting Bluetooth
A2DP audio quality:

- When Wi-Fi is scanning at 2.4GHz, the PTA (Packet Traffic Arbitration)
  mechanism aborts almost all BT requests
- If the Wi-Fi slot duration exceeds reasonable limits, BT audio devices
  cannot receive enough data in time
- This causes **audible audio glitches and stuttering** during Wi-Fi
  scanning operations
- The issue affects users with Bluetooth headphones/speakers while their
  device scans for Wi-Fi networks

### Technical Merit

**Why This Fix Works:**

1. **Slot Type Change (SLOT_ISO → SLOT_MIX)**: Makes the CXST_ENULL slot
   more cooperative with Bluetooth by accepting BT low-priority
   transmission/reception requests, giving BT more opportunities to
   transmit audio data.

2. **Duration Limiting (80ms)**: Caps the Wi-Fi slot duration at 80ms to
   ensure BT gets regular opportunities to transmit. The 80ms limit is
   already defined and used consistently throughout the driver
   (`BTC_E2G_LIMIT_DEF`).

3. **Targeted Scope**: The changes only affect specific coexistence
   policies that are active during 2.4GHz Wi-Fi scanning, not normal
   operation.

### Safety and Risk Assessment

**Low Risk for the following reasons:**

1. **No Reverts or Follow-up Fixes**: Extensive git history search shows
   no reverts, fixes, or related issues after this commit (checked all
   commits since 2025-08-19).

2. **Small and Contained**: Only 5 lines changed in a single file, all
   within the coexistence policy subsystem.

3. **Well-Understood Pattern**: The 80ms slot limit is already used
   elsewhere in the driver and is a known-good value.

4. **Subsystem-Specific**: Changes are isolated to the rtw89 driver's
   coexistence mechanism, affecting only Realtek RTL8852x/RTL8922x
   series Wi-Fi chips.

5. **No Architectural Changes**: This is a configuration tuning, not a
   structural change.

6. **Tested by Vendor**: Comes from Realtek engineers who develop and
   test this hardware.

### Affected Hardware

The rtw89 driver supports:
- RTL8852A, RTL8852B, RTL8852C, RTL8852BT
- RTL8922A

These are recent Realtek Wi-Fi 6/6E/7 chipsets commonly found in laptops
and PCIe cards.

### Backporting Criteria Assessment

| Criterion | Assessment | Notes |
|-----------|------------|-------|
| Fixes user-facing bug? | ✅ YES | A2DP audio glitches during Wi-Fi
scanning |
| Small and contained? | ✅ YES | 5-line change in single file |
| Clear side effects? | ✅ NO | No unexpected side effects |
| Architectural changes? | ✅ NO | Configuration tuning only |
| Critical subsystem? | ⚠️ MODERATE | Coex is important but isolated |
| Stable tree mention? | ❌ NO | No explicit Cc: stable tag |
| Minimal regression risk? | ✅ YES | No reverts or fixes found |
| Subsystem-confined? | ✅ YES | rtw89 driver only |

### Recommendation Rationale

This commit **should be backported** because:

1. **Important User Experience Fix**: Audio glitches are highly
   noticeable and frustrating to users
2. **Low Risk**: Small, targeted change with no known issues
3. **Vendor-Tested**: Comes from hardware vendor with domain expertise
4. **Mature Subsystem**: The coex mechanism is well-established with
   clear patterns
5. **No Dependencies**: Standalone fix requiring no other patches
6. **Stable Track Record**: No problems reported in upstream since
   August 2025

The lack of an explicit `Cc: stable@vger.kernel.org` tag appears to be
an oversight rather than intentional exclusion. The commit clearly meets
the stable tree criteria for important bug fixes with minimal risk.

 drivers/net/wireless/realtek/rtw89/coex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e4e6daf51a1ba..0f7ae572ef915 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -93,7 +93,7 @@ static const struct rtw89_btc_fbtc_slot s_def[] = {
 	[CXST_E2G]	= __DEF_FBTC_SLOT(5,   0xea5a5a5a, SLOT_MIX),
 	[CXST_E5G]	= __DEF_FBTC_SLOT(5,   0xffffffff, SLOT_ISO),
 	[CXST_EBT]	= __DEF_FBTC_SLOT(5,   0xe5555555, SLOT_MIX),
-	[CXST_ENULL]	= __DEF_FBTC_SLOT(5,   0xaaaaaaaa, SLOT_ISO),
+	[CXST_ENULL]	= __DEF_FBTC_SLOT(5,   0x55555555, SLOT_MIX),
 	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0xea5a5a5a, SLOT_MIX),
 	[CXST_W1FDD]	= __DEF_FBTC_SLOT(50,  0xffffffff, SLOT_ISO),
 	[CXST_B1FDD]	= __DEF_FBTC_SLOT(50,  0xffffdfff, SLOT_ISO),
@@ -4153,6 +4153,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_le(btc, CXST_ENULL, s_def[CXST_ENULL].dur,
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_DEF2:
 			_slot_set(btc, CXST_E2G, 20, cxtbl[1], SLOT_ISO);
@@ -4162,6 +4163,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_le(btc, CXST_ENULL, s_def[CXST_ENULL].dur,
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_2GBWMIXB:
 			if (a2dp->exist)
@@ -4170,6 +4172,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				_slot_set(btc, CXST_E2G, 5, tbl_w1, SLOT_MIX);
 			_slot_set_le(btc, CXST_EBT, cpu_to_le16(40),
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_WL: /* for 4-way */
 			_slot_set(btc, CXST_E2G, 5, cxtbl[1], SLOT_MIX);
-- 
2.51.0


