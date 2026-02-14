Return-Path: <linux-wireless+bounces-31857-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBy2AcbokGkMdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31857-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:27:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F613D644
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD1C0302BDDE
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6130DEA2;
	Sat, 14 Feb 2026 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2Y7j8n9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C430DD00;
	Sat, 14 Feb 2026 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104355; cv=none; b=tX0Zu2Oc+h5Ji5dBdieTwAzsVjZm7A2hO6iMWKyJETgaY9xynOlYNYjwwm6eSAU1VxvbjSndj25EjqhD5u+5nYyhnYu7rCmhRll/7JnHODfGtmYZrGGYTt2BkjCXSdpSvCOdhs85hfw1oBYeH74Y7oKzHCafdygEIBaSEm5srfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104355; c=relaxed/simple;
	bh=Q/iOhIELXkdd9/UfRNtfVHKIdxGcEzcu+Bl6wRGa1Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSVIzd3C54bfc6+paXdeTVFSgK6/bivw58c0hm7lExQk4EwO7UEGwHHHEFgwxn2OFLCP2JpGzOAJVDAhpU1gF2t7FT8rPJOM3XGt/Kr7BIJnwgq9oO9ZCReDyy/TWP0+NvCklDnbBEY3j1mmd7FzuG7oyY3azVCEP7Op83oOpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2Y7j8n9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98734C19422;
	Sat, 14 Feb 2026 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104355;
	bh=Q/iOhIELXkdd9/UfRNtfVHKIdxGcEzcu+Bl6wRGa1Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2Y7j8n9q1qyyFsRl82z+W4r/oAJHy1QPeuvwV9OsrardvQStlaBVY5IQhS7gryi4
	 TggfQsA9OOSUTHX+oYzZm/82+nD4LxnA9J4lMGbGwp+/gf7luXguNGghdHFOPGPrCM
	 uX2pqNwtl3TzwWdCwvm/xVrwMFirFHBdo8i7+ZZxzQo+1bt6zJl0LzsIhnAamIFc/I
	 ig13EyI4adp6jI3ThHw0Rqmhy5h4C9a2UIMrU91+Ic3PF0K8lzYDdja1NPdsKvTovu
	 AKoniMYWZQaN+ygl4ACcpNKkTVKKRXlFGBHGezrWQf5gkNeecnfU7Foafaxdys9pXx
	 cJq0EfnQI7xaA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jan Gerber <j@mailb.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] wifi: rtw89: 8852au: add support for TP TX30U Plus
Date: Sat, 14 Feb 2026 16:23:01 -0500
Message-ID: <20260214212452.782265-36-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31857-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 8F3F613D644
X-Rspamd-Action: no action

From: Jan Gerber <j@mailb.org>

[ Upstream commit a2f1fc9ab6fb0d5c9d701a516c342944258fb20e ]

the device shows up like this and everything seams to work:

Bus 004 Device 003: ID 3625:010d Realtek 802.11ax WLAN Adapter

Signed-off-by: Jan Gerber <j@mailb.org>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251212005515.2059533-1-j@mailb.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis: wifi: rtw89: 8852au: add support for TP TX30U Plus

### Commit Message Analysis
This commit adds a new USB device ID (`0x3625:0x010d`) for the TP TX30U
Plus WiFi adapter to the existing `rtw8852au` driver. The commit message
indicates the device was tested and works ("everything seams to work").
It was acked by the Realtek subsystem maintainer (Ping-Ke Shih).

### Code Change Analysis
The change is a **two-line addition** of a single USB device ID entry to
an existing device ID table:

```c
{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010d, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
```

This is inserted in sorted order among existing entries. Notably, the
same vendor (`0x3625`) already has another device (`0x010f`) in the
table, so this vendor's devices are already known to work with this
driver.

### Classification: New Device ID Addition

This falls squarely into the **"NEW DEVICE IDs"** exception category for
stable backports:

1. **The driver already exists** in stable trees - `rtw8852au` is an
   established driver
2. **Only the ID is new** - no driver code changes whatsoever
3. **Same vendor already supported** - `0x3625:0x010f` is already in the
   table, meaning the `0x3625` vendor's devices are known to work
4. **Trivially correct** - it's a mechanical two-line addition following
   the exact same pattern as every other entry in the table

### Risk Assessment
- **Risk: Essentially zero.** Adding a USB device ID to a table cannot
  break existing functionality. It only enables the existing driver to
  bind to a new USB VID:PID combination.
- **Scope: Minimal.** Two lines, one file, one table entry.
- **Dependencies: None.** The driver infrastructure is already in place.

### User Impact
- Users with the TP TX30U Plus WiFi adapter on stable kernels currently
  have **no WiFi support** for this device
- With this backport, their device would be recognized and work with the
  existing driver
- This is the kind of fix that directly enables hardware for real users

### Stability Indicators
- Acked and signed off by Realtek's kernel maintainer (Ping-Ke Shih)
- Tested by the submitter with real hardware
- Same vendor's other device already works with this driver

### Conclusion
This is a textbook device ID addition - the most common and safest type
of stable backport. It enables real hardware for real users with zero
risk of regression. The change is trivially correct, tested, and
acknowledged by the subsystem maintainer.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index ca782469c455d..74a976c984ad8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -60,6 +60,8 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0141, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010f, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{},
-- 
2.51.0


