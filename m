Return-Path: <linux-wireless+bounces-31863-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD0kF0DpkGkadwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31863-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:29:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34B13D7AF
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54EA23079A5F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D15311C2C;
	Sat, 14 Feb 2026 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJfnQCfo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AB2D979F;
	Sat, 14 Feb 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104378; cv=none; b=O2n5pIO3kZ1WSKtq9rnwhijkKnOKSaadRvUcddyfm+Z+PDNEk8hU50pxKzI4vockT72NWpP+PSXoFTufWuKbtYP4FHStRsPbBgc1/Fad3/6RNRz0vD+pGGjpC3n+ziS8b/dWkxgy43fQ1gkmJAONSng52nv9vn9YfNM0EXbvSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104378; c=relaxed/simple;
	bh=iYacwj6iOAfDyResFuR1KlgGDj9QDNWwUEi5sSnHolQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqVEQ27RsJlrUq59e2QLKto5ki96v0c0ssYsuaprcDAvomwuWr1NqzCL9A32m+dNi9XZ/crf5ZESac+EqnvH0CF4GDlXzb4FhCHNfRAqn2u4/uQROQ7G5plHVKaJH2W8IR+oPnN89NQvYOLsHuTatnSuKRYGxzZ0FR2GgRDqUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJfnQCfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB017C19422;
	Sat, 14 Feb 2026 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104378;
	bh=iYacwj6iOAfDyResFuR1KlgGDj9QDNWwUEi5sSnHolQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJfnQCfowmIJQb8vkHqwtZOm8c8eCHUqip2I1mrBO5fRyXJ1Turz6BZGEv8dK7Chh
	 wNVp0CRaj9JzNtbkHCjYDTZO8peiqmpc3NmlJYIITY3xYRsl5MbOin6iFlTQWNe1gH
	 VaFXF5QzuhS5ScrcEPsPd0BuT7xSqgfZ2nQ8BGVy64M7TL4k/oEgcChSMJY2WiLCBL
	 NlbbDORgl3e4PuoIDoVZ2rylGnjFyZudBacLnCSEwcKS+CoITCfCooJlIsU4U8zMBd
	 ak7VQYkVzph6umNdtxOWQjjh2jfqCnJenuEZuDngkgPA2snUU9ifFb+2yKKbKS7fDA
	 2QzbSGhIPBEBA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] wifi: rtw89: Add support for D-Link VR Air Bridge (DWA-F18)
Date: Sat, 14 Feb 2026 16:23:17 -0500
Message-ID: <20260214212452.782265-52-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31863-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,realtek.com:email]
X-Rspamd-Queue-Id: CC34B13D7AF
X-Rspamd-Action: no action

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 292c0bc8acb687de7e83fc454bb98af19187b6bf ]

Add the ID 2001:3323 to the table to support an additional RTL8832AU
adapter: D-Link VR Air Bridge (DWA-F18).

Compile tested only.

Link: https://github.com/morrownr/rtw89/pull/44
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260112004759.6028-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis: Adding USB Device ID for D-Link VR Air Bridge (DWA-F18)

### Commit Message Analysis

The commit adds a single USB device ID (2001:3323) to the
`rtw_8852au_id_table` in the rtw89 WiFi driver. This enables an
existing, already-supported RTL8832AU chipset-based adapter — the D-Link
VR Air Bridge (DWA-F18) — to be recognized by the driver.

The commit message is straightforward: "Add the ID 2001:3323 to the
table to support an additional RTL8832AU adapter." It notes "Compile
tested only," which is typical for device ID additions since the
hardware behavior is identical to other already-supported devices with
the same chipset.

### Code Change Analysis

The change is exactly **2 lines added**, inserting a new
`USB_DEVICE_AND_INTERFACE_INFO` entry into the existing device ID table:

```c
{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3323, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
```

This follows the exact same pattern as all other entries in the table.
The vendor ID `0x2001` is D-Link, and other D-Link devices (`0x3321`,
`0x332c`) are already in the table. The `.driver_info` points to the
same `rtw89_8852au_info` structure used by all entries.

### Classification: New Device ID

This falls squarely into the **"New Device IDs"** exception category for
stable backporting:

- The driver (`rtw89/rtw8852au`) already exists in stable trees
- Only a USB device ID is being added — no new code paths, no new logic
- The device uses the same RTL8832AU chipset as other already-supported
  adapters
- The change is trivially correct by inspection

### Risk Assessment

- **Risk: Extremely Low** — A device ID addition cannot break any
  existing functionality. It only affects matching for the specific USB
  VID:PID 2001:3323, which previously had no driver match at all.
- **Scope: Minimal** — 2 lines in a single file, following an
  established pattern.
- **Regression potential: Near zero** — No existing behavior is
  modified.

### User Impact

Without this patch, users with the D-Link DWA-F18 VR Air Bridge cannot
use their WiFi adapter at all with the in-kernel rtw89 driver. With it,
the device is automatically recognized. This has real-world impact for
users of this specific hardware.

### Dependencies

This commit has no dependencies beyond the rtw89 USB driver
infrastructure already being present in the stable tree. The
`rtw8852au.c` driver and the `rtw89_8852au_info` structure are already
defined.

### Stability Indicators

- Signed off by the rtw89 subsystem maintainer (Ping-Ke Shih from
  Realtek)
- Follows established patterns identically
- Community-contributed with a linked PR showing user demand

### Conclusion

This is a textbook example of a device ID addition that is appropriate
for stable backporting. It enables hardware support for a specific USB
WiFi adapter using an existing, well-tested driver. The change is
trivial, risk-free, and provides direct benefit to users with this
hardware.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index 74a976c984ad8..ccdbcc178c2a4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -52,6 +52,8 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3321, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3323, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332c, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x013f, 0xff, 0xff, 0xff),
-- 
2.51.0


