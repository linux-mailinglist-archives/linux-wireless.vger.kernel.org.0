Return-Path: <linux-wireless+bounces-31859-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPlRJOnokGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31859-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2DC13D6A6
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62EAD3055B40
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B329DB99;
	Sat, 14 Feb 2026 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7m6qfa0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651F299931;
	Sat, 14 Feb 2026 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104362; cv=none; b=PD+RSvBhOJYIS/po0e10IHJ3X+5XCsfqmQEGIJM8QgLH3iBJvcxhnSqAcIGeSAMuddR0OYhbUInrZT8lRYD7m7O/TU9yT5HkBTWmJDb/Wo9NOGL0BWUryNAqa+tGgKRJ4M4FDa+dqiEgT4+0nHWpZG2hgpoDwHqNo5lT8klJzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104362; c=relaxed/simple;
	bh=jxz8aN0hk2Hn/dUUbJ0K1/ynlTqBgPUSzmZMjVW+I3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmXIXiJQ/LD4XE6J+Acgf+IQet9iIA8dUPa3mKsJfrTwBzL/RQ+qaUfFCKTgK+FNgAFDXSTstVswk4ZUUBXqydSOQl5/5Cg4EeA9Y22Wek9Mp/xcMu+1LkYLI/kJMG7r+w/qv/3awfWc1/ud6nlWal77Shx/rMGH6E2pKOL44ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7m6qfa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A170C16AAE;
	Sat, 14 Feb 2026 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104361;
	bh=jxz8aN0hk2Hn/dUUbJ0K1/ynlTqBgPUSzmZMjVW+I3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7m6qfa0FwJmE8Ux+nNqxJCmXVCAlAe6Fqhvmywq9fqPIS4wXa938AzFUlgICMUpB
	 CfCNjlhTuu6XoitoHfD94+fHPTu0fRerDBF71EDQ80HTwPNvA9bNCtCJ3PJa1dbe/F
	 IhSxWyQnLf9A9SPA7J+edyChi0GjWh+nvdirRbbpr6ddQmeu9ZWstiCQ6qBcCfCSQ4
	 TMeTACfhC05OVnW9v7RA+6eB0IyJm9B3nIW0+RwvENIsUOV9PWTrYamT6ebZWUC5kZ
	 QoTBjoQMMjk6DSGftnIPEM8Pf441FbDDPUZorcu/koLWwgha7+RojG7K8d7Ek2krXq
	 tdkTwNCKjVVhg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shin-Yi Lin <isaiah@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] wifi: rtw89: Add default ID 28de:2432 for RTL8832CU
Date: Sat, 14 Feb 2026 16:23:06 -0500
Message-ID: <20260214212452.782265-41-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31859-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 0A2DC13D6A6
X-Rspamd-Action: no action

From: Shin-Yi Lin <isaiah@realtek.com>

[ Upstream commit 5f65ebf9aaf00c7443252136066138435ec03958 ]

Add 28de:2432 for RTL8832CU-based adapters that use this default ID.

Signed-off-by: Shin-Yi Lin <isaiah@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260114014906.21829-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis: Adding USB Device ID 28de:2432 for RTL8832CU

### Commit Message Analysis

This commit adds a single USB device ID (`28de:2432`) to the existing
`rtw89` wireless driver for RTL8832CU-based USB WiFi adapters. The
vendor ID `0x28de` belongs to Valve Corporation (known for Steam Deck
and other gaming hardware), suggesting this is a WiFi adapter used in a
Valve product.

### Code Change Analysis

The change is minimal and mechanical:
- **One entry added** to the `rtw_8852cu_id_table[]` array in
  `rtw8852cu.c`
- The new entry follows the exact same pattern as all other entries in
  the table
- Uses `USB_DEVICE_AND_INTERFACE_INFO(0x28de, 0x2432, 0xff, 0xff, 0xff)`
  with the same `rtw89_8852cu_info` driver info structure
- The entry is inserted in vendor ID order (between `0x0db0` and
  `0x35b2`), maintaining table organization

### Classification: New Device ID Addition

This is a textbook **new device ID addition** to an existing driver —
one of the explicitly allowed exception categories for stable backports:

1. **The driver already exists** in stable trees (rtw89/rtw8852cu has
   been in the kernel)
2. **Only the USB ID is new** — no new code paths, no new functionality
3. **Enables existing hardware** to be recognized by an already-working
   driver
4. **Zero risk of regression** — the new ID entry only matches devices
   with that specific vendor/product ID; all other devices are
   completely unaffected

### Scope and Risk Assessment

- **Lines changed**: 2 (one USB_DEVICE_AND_INTERFACE_INFO entry)
- **Files touched**: 1
- **Risk**: Essentially zero — adding a device ID to a table cannot
  break existing functionality
- **Complexity**: None — this is a data-only change

### User Impact

- **Without this patch**: Users with RTL8832CU adapters using vendor ID
  `28de:2432` (likely Valve hardware) have no WiFi support — the device
  is simply not recognized
- **With this patch**: The adapter works out of the box with the
  existing rtw89 driver
- **Impact level**: HIGH for affected users (WiFi is essential), ZERO
  for everyone else

### Dependency Check

This commit is fully self-contained. It depends only on:
- The rtw89 driver existing (it does in stable trees)
- The `rtw89_8852cu_info` structure existing (it does, defined in the
  same file)

No other patches are needed.

### Stability Indicators

- Authored by Realtek engineers (Shin-Yi Lin, Ping-Ke Shih) — the chip
  vendor themselves
- The pattern is identical to all other entries in the table, well-
  established and tested

### Conclusion

This is a classic device ID addition — the most straightforward type of
stable backport. It enables WiFi hardware for users who currently have
no support, with zero risk to anyone else. It perfectly matches the "New
Device IDs" exception category in the stable kernel rules.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 2708b523ca141..3b9825c92a0d9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -46,6 +46,8 @@ static const struct usb_device_id rtw_8852cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x991d, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x28de, 0x2432, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35b2, 0x0502, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0101, 0xff, 0xff, 0xff),
-- 
2.51.0


