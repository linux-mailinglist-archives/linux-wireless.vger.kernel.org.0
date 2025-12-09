Return-Path: <linux-wireless+bounces-29609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88240CAE841
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 01:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3AB8302218A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 00:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44D285CA4;
	Tue,  9 Dec 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5FIbxKw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7F285C96;
	Tue,  9 Dec 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239471; cv=none; b=dltPutERynzaskgJEovHfnuaSu0C3T+D0TRVxo56MfQsGLRaOyJrv1WIYaRXkiqqxWWoUQyRpVzwmd91xFOlMWKdg/8vV8u6K7coy8F4tD56p2ChOO2fDhMmr/+VappDkQlJgnO3ClbNMTbn3uxieeM53hHdyhTnBrGelN2UIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239471; c=relaxed/simple;
	bh=hSj6yXL7v3dwQ1gzsPlEb+4UPWzryxVTATl+Oe5TMME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtIvvhl+zoWIUzhUCLgPfqPoVCkWtQE7nMQLuKfyNucG/Ksio3puKm71788maspMeRnWybJyzCBkgi7bMsUe+A08MhT0y0Cs1A4v6vMulwBJnCU3Fs+p3JmdxV9Y8s4OXvsF9l+ANDDHHpuEA1hpR+7gxlMrEy288l3EfcmCkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5FIbxKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D5CC19422;
	Tue,  9 Dec 2025 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239471;
	bh=hSj6yXL7v3dwQ1gzsPlEb+4UPWzryxVTATl+Oe5TMME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5FIbxKwK4tJLgWZ6q2gsV0CN60AWp1dH6xU+ICH6RBqQedXXjbydm8grZ0Y1EAXW
	 cc9N+h15fYNEJfUHJGtATb+avhYywFobcHCsx2GMYNLeTdhpfMd+yXRxLvOVy31lN/
	 cUzIcvRV9R8dPz/rutgglpBF2cwADJ1SFApmReONHSWSdByAijwOnRbHC9gwPTMyK9
	 WmLXFq/rBAVHh+82VnrUfIexDgCJ0XnWc7mMIsZwAvQIIrGGAXWGwJcOiqRcPbp+up
	 eOeeg+uQ0IWd9xPSsKeyrvP/gEoADYrPhoLtNi7gRTRBIaAuEXBLLVh5tMDD2Gy2fb
	 rvkZhBxgaLvrw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dan Hamik <dan@hamik.net>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.17] wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO USB Wifi dongle
Date: Mon,  8 Dec 2025 19:15:23 -0500
Message-ID: <20251209001610.611575-31-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dan Hamik <dan@hamik.net>

[ Upstream commit ef42cf705ca32c07a58133817567ac06ef74dc19 ]

Add the USB device ID 0x0b05:0x1cb6 to the rtw8852bu driver to support the
ASUS AX57 Nano WiFi 6 USB adapter.This device uses the same Realtek
RTL8852BU chipset as other supported models.

Tested on: Linux Mint 22 with kernel 6.8.0-87-generic.
The adapter initializes successfully and connects to networks.

Signed-off-by: Dan Hamik <dan@hamik.net>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/010f019a76e1a84b-0a6f5e9f-2a43-4a9d-9c30-de4ae6363011-000000@us-east-2.amazonses.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture of the situation. Let me summarize my
analysis:

## DETAILED ANALYSIS

### 1. COMMIT MESSAGE ANALYSIS

The commit message states:
- **Subject**: "wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO
  USB Wifi dongle"
- **Purpose**: Add USB device ID `0x0b05:0x1cb6` for the ASUS AX57 Nano
  WiFi 6 USB adapter
- **Device**: Uses the Realtek RTL8852BU chipset (same as other
  supported models)
- **Testing**: Tested on Linux Mint 22 with kernel 6.8.0-87-generic

**Notable absences**:
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag
- This is a hardware enablement patch, not a bug fix

### 2. CODE CHANGE ANALYSIS

The diff shows a **trivial 2-line addition**:
```c
+       { USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1cb6, 0xff, 0xff,
0xff),
+         .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
```

This adds a new USB device ID entry to the `rtw_8852bu_id_table[]`
array. The change:
- Uses the standard `USB_DEVICE_AND_INTERFACE_INFO()` macro
- References the existing `rtw89_8852bu_info` driver info structure
- Is identical in pattern to all other entries in the table
- Enables the existing driver to match and bind to the ASUS AX57 Nano
  device

The vendor ID `0x0b05` is ASUS (ASUSTeK Computer Inc.), and `0x1cb6` is
the specific product ID for this adapter. There's already another ASUS
device in the table (`0x0b05, 0x1a62`), confirming ASUS devices work
with this driver.

### 3. CLASSIFICATION

**This is a NEW DEVICE ID addition** - one of the explicitly allowed
exception categories for stable kernel backports.

Per stable kernel rules:
> "Adding PCI IDs, USB IDs, ACPI IDs, etc. to existing drivers. These
are trivial one-line additions that enable hardware support."

The commit:
- Does NOT add new features
- Does NOT change any driver logic
- Does NOT add new APIs
- Simply enables an existing, working driver to bind to a new USB device
- The device uses the same RTL8852BU chipset that the driver already
  supports

### 4. SCOPE AND RISK ASSESSMENT

**Scope**: Extremely minimal
- Lines changed: 2 lines added
- Files touched: 1 file
- Complexity: Trivial (simple array element addition)
- Subsystem: Wireless networking (rtw89 driver)

**Risk**: Extremely LOW
- The change cannot break existing functionality
- It only adds a new USB ID to match
- The driver infrastructure for RTL8852BU already exists and is tested
- The device uses an identical chipset to other supported devices
- Other ASUS devices already work with this driver

### 5. USER IMPACT

**Who benefits**: Users who purchase the ASUS AX57 Nano WiFi 6 USB
adapter
- This is a real, commercially available product
- Without this patch, the device won't be recognized by the kernel
- The commit author tested it and confirmed it works

**Severity**: Moderate for affected users
- The device is completely non-functional without this ID
- With the ID, full WiFi functionality is enabled

### 6. STABILITY INDICATORS

- **Tested by**: Dan Hamik (the patch author)
- **Acked/Signed by**: Ping-Ke Shih (Realtek maintainer)
- **Pattern**: Follows the exact same pattern as all other USB ID
  additions in this driver

### 7. DEPENDENCY CHECK - CRITICAL FINDING

**The rtw8852bu.c driver file only exists starting from v6.17.**

My investigation revealed:
- The `rtw8852bu.c` file was first added in commit `0ed2a8b1a14e9` on
  July 5, 2025
- The rtw89 USB infrastructure (`usb.c`, `usb.h`) was added in commit
  `2135c28be6a84` on June 30, 2025
- Both commits first appeared in v6.17-rc1
- **The driver does NOT exist in v6.16 or any earlier stable trees**
  (confirmed by checking `git show
  v6.16:drivers/net/wireless/realtek/rtw89/rtw8852bu.c` which returns
  "fatal: path does not exist")

Current stable trees and rtw8852bu.c availability:
| Stable Tree | rtw8852bu.c Available? |
|-------------|------------------------|
| 6.12.y (LTS) | ❌ No |
| 6.15.y | ❌ No |
| 6.16.y | ❌ No |
| 6.17.y | ✅ Yes |
| 6.18 | ✅ Yes |

### CONCLUSION

While this commit **meets the typical criteria** for stable backporting
(it's a trivial USB device ID addition that enables hardware support
using existing, tested driver code), there is a **critical dependency
issue**:

**The rtw8852bu.c driver itself was only introduced in Linux 6.17
(v6.17-rc1).** This means:

1. For stable trees 6.17.y and later: The commit would be appropriate to
   backport as it enables new hardware with zero risk.

2. For stable trees earlier than 6.17 (6.16.y, 6.15.y, 6.12.y, 6.6.y,
   6.1.y, etc.): The commit **cannot be backported** because the driver
   file doesn't exist. Backporting would require first backporting the
   entire rtw89 USB infrastructure (usb.c, usb.h) plus the rtw8852bu.c
   driver file, which would be a massive undertaking involving new
   functionality - NOT appropriate for stable.

Given that:
1. The primary purpose of stable backports is to bring fixes to LTS
   kernels (6.12.y, 6.6.y, 6.1.y)
2. This driver doesn't exist in any of those LTS trees
3. For the only stable tree where it exists (6.17.y), this is a very new
   kernel with limited user base compared to LTS
4. The commit lacks explicit `Cc: stable` tag from the maintainer

The practical utility of backporting is very limited. The only stable
tree that could receive this is 6.17.y, which is not an LTS kernel.
Users of actual LTS kernels (6.12, 6.6, 6.1) cannot benefit from this
backport at all since the underlying driver doesn't exist there.

**YES** - This commit **is appropriate for backporting** to stable trees
**where the driver exists (6.17.y only)**. It's a textbook example of a
safe device ID addition - trivial, low-risk, enables hardware support
without any code changes. However, the practical scope is limited to the
6.17.y stable tree only.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 0694272f7ffae..83bdea040f40e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -28,6 +28,8 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1a62, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1cb6, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3327, 0xff, 0xff, 0xff),
-- 
2.51.0


