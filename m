Return-Path: <linux-wireless+bounces-31846-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEiOJ2DokGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31846-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AB13D51F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E54301D947
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CA430C60E;
	Sat, 14 Feb 2026 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4xRdAde"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195F28134C;
	Sat, 14 Feb 2026 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104316; cv=none; b=dM+hWhoZjd+W+Q6OIkp6SV+ZA1gAiuK5y8GWX4FosiMIMuZgq9Z0JZ7Ro814iVkdOpHxOhU76A8SDdx05ATQTDxXDhDPc4YAjnpc6tScHWnMnmW40Eob5KUySO5y/WSuZ+iRLhCJw/i/VofuAcu3UMPh6efAnlyJKfrzNl+3BZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104316; c=relaxed/simple;
	bh=MWhNcefrLhC3Rj5lpUlVUCHDE3IjMVQY4NNTvDIKqyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkzP4mnYpucZc/ukxe/TCWdWnL1Noti221JdP+k9Ah5aeAJq7n9pdky9c0JtWEFuhD+G9orF06+mkXrgPuuMyD2+djH2bGm87jYiVneBzmHZt5E4UR5+a/u50r02ne6cNFWSMn6+2VHqYsHIvzign6bqb4NgKAgB4QrOSpJBxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4xRdAde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A46C19423;
	Sat, 14 Feb 2026 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104315;
	bh=MWhNcefrLhC3Rj5lpUlVUCHDE3IjMVQY4NNTvDIKqyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4xRdAdecxoJBDOrws3J/oiJFENuuDp86YX7JpBEAnLV/TUHukRRbQ9wcuLajDfgU
	 LC4tl6pYD1X6kLVfPKHxPs7HG5RMEJA+7N0esTZN/7SaHlpfEnGgARxKPm2VL51Vk8
	 0oifNRn/fBHcRpnPtX+k6qaVYGNQN32jmzDnHTaM31JuIB3Vcur/o8fsvCsIRgRroj
	 41xEjSmR7r7KNUdL+tFUdTrex5YsIZTDkjwz1RfsCXZu6NfgP/yZh3BxkUdnXy1uNZ
	 OzobJrWE4zKoiL9H/eLXSgBz6wq9BcywdZUC33EZnXfNjyj03h8jHx7xMkskLoy6uS
	 WlIt5zzjIe83A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hsiu-Ming Chang <cges30901@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H
Date: Sat, 14 Feb 2026 16:22:36 -0500
Message-ID: <20260214212452.782265-11-sashal@kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31846-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 528AB13D51F
X-Rspamd-Action: no action

From: Hsiu-Ming Chang <cges30901@gmail.com>

[ Upstream commit 77653c327e11c71c5363b18a53fbf2b92ed21da4 ]

Add support for Mercusys MU6H AC650 High Gain Wireless Dual Band USB
Adapter V1.30. It is based on RTL8811CU, usb device ID is 2c4e:0105.

Signed-off-by: Hsiu-Ming Chang <cges30901@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251205003245.5762-1-cges30901@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis: Adding USB Device ID for Mercusys MU6H to rtw8821cu driver

### Commit Message Analysis
The commit adds a USB device ID (vendor: 0x2c4e, product: 0x0105) for
the Mercusys MU6H AC650 High Gain Wireless Dual Band USB Adapter to the
existing rtw8821cu driver. The device is based on the RTL8811CU chipset.

### Code Change Analysis
The change is a **two-line addition** to the USB device ID table in
`drivers/net/wireless/realtek/rtw88/rtw8821cu.c`:
```c
{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0105, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Mercusys */
```

This follows the exact same pattern as every other entry in the table
(D-Link, Edimax, and the various Realtek-branded variants). The entry
uses the same `rtw8821c_hw_spec` hardware specification structure,
meaning the driver already fully supports this chipset — it just needs
to know about this particular vendor/product ID combination.

### Classification
This is a **new device ID addition** to an existing driver — one of the
explicitly listed exceptions that IS appropriate for stable backporting.
From the stable rules:

> **NEW DEVICE IDs (Very Common):** Adding PCI IDs, USB IDs, ACPI IDs,
etc. to existing drivers. These are trivial one-line additions that
enable hardware support. Rule: The driver must already exist in stable;
only the ID is new.

### Risk Assessment
- **Risk: Extremely low.** This is a pure data addition — a new entry in
  a USB ID matching table. It cannot affect any existing functionality.
- **Scope: Minimal.** Two lines added, one file changed, no logic
  changes.
- **Regression potential: Zero.** The new ID only matches a specific USB
  device (0x2c4e:0x0105). No other device is affected.

### User Impact
- Users with this specific Mercusys MU6H adapter cannot use it at all
  without this ID entry. With the entry, the existing (and already
  working) rtw8821cu driver will automatically bind to the device.
- This is a consumer WiFi adapter, so real users on stable kernels would
  benefit from this backport.

### Stability Indicators
- Acked-by the Realtek maintainer (Ping-Ke Shih)
- The pattern is identical to existing entries
- The rtw88 driver and rtw8821cu sub-driver already exist in stable
  trees

### Dependencies
- None. This is a completely self-contained change.

### Conclusion
This is a textbook example of a device ID addition that should be
backported to stable. It enables hardware support for a specific USB
WiFi adapter using an already-existing, well-tested driver. The change
is trivial, zero-risk, and directly benefits users who own this device.

**YES**

 drivers/net/wireless/realtek/rtw88/rtw8821cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a0fffc359e25..8cd09d66655db 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -37,6 +37,8 @@ static const struct usb_device_id rtw_8821cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0105, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Mercusys */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
-- 
2.51.0


