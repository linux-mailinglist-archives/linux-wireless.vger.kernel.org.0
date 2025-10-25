Return-Path: <linux-wireless+bounces-28263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98218C09C68
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64971548A98
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5C315D48;
	Sat, 25 Oct 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcwaTDMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F3315D37;
	Sat, 25 Oct 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409475; cv=none; b=b4Yn/otV6t1oy1f8xSvE/2FCEQDarZl2y2AagCgc2jWlP2KucmVNHrGzIUFHfm9QkLwQZU0b5sgfw3z2FeL7ZuVgM9cVvA3PMHFI8sBWQfQsj2HoQK/jCqjzNbqo2LzL0nOYMm93TkvQDf/0Per3TcaUJ0dTlTA1Pdx1AAkNzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409475; c=relaxed/simple;
	bh=OvQd+VHiY14MAkhNDRN8bAjRF+Z9dCF5NNSFzETJ+KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY6S8fBjBiGQYgh6b5h/elu71R210fPWDmjZF4kNYcWARlWBz8U/WnEnFKZggAvre9jCWqDo1bSu7UWOagA9JB8jX/l6FiChnlUTM6OkaqF46MmbhXdd4dpXa2Dd8jKiIQbL0MKGCVqNlHqQ7mOLxEDtqQe2csTX6IqsVa/TIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcwaTDMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8979C4CEFB;
	Sat, 25 Oct 2025 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409475;
	bh=OvQd+VHiY14MAkhNDRN8bAjRF+Z9dCF5NNSFzETJ+KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcwaTDMPtC42PaG7dvom76UH2jUWYNh+319yvvBtWRiY78+oVxDCZ0xZ4v8GxlNZi
	 uRSUDGeUHnWXVFewVkwW9Ff800Qr73rUsLKGdTRj8ScRzc0A2S9PIAlXPz5Y0qYpHN
	 rwbLPrlenIidvP+ujT8cBlU0GJqAsl7LWwpON6xV1Y+PM4fLRQJx2baVtDxD36ObM8
	 Bert2G3JH9jXJH3LjlDi2q7PXnWrklam+GMmtMdhGz2b8FgqawLknsUqgCLrTwymSj
	 v/KLKpZ8BBnZ3Ck4lg95VlMFPui1gdvNP4LtM0yqYXsrbo/D0FdHa22FFHBGiojwYQ
	 4f4cgVeIo05Jg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
Date: Sat, 25 Oct 2025 11:59:30 -0400
Message-ID: <20251025160905.3857885-339-sashal@kernel.org>
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

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 2ffc73cdb8247dc09b6534c4018681a126c1d5f5 ]

Add USB ID 2001:332a for D-Link AX9U rev. A1 which is a RTL8851BU-based
Wi-Fi adapter.

Only managed mode and AP mode are tested and it works in both.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250902035755.1969530-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- Scope of change: Adds a single USB device ID for a new RTL8851BU-based
  adapter; no logic changes. In
  `drivers/net/wireless/realtek/rtw89/rtw8851bu.c:19-21`, the new entry
  `USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff)` is
  added with `.driver_info = (kernel_ulong_t)&rtw89_8851bu_info`,
  matching the existing pattern used for other 8851BU dongles (e.g.,
  `0x3625:0x010b` and `0x7392:0xe611` in the same table at
  `drivers/net/wireless/realtek/rtw89/rtw8851bu.c:22-27`).
- Containment: The id table is used only for device matching via the
  driver’s `usb_driver` definition (`.id_table = rtw_8851bu_id_table` at
  `drivers/net/wireless/realtek/rtw89/rtw8851bu.c:32-36`).
  Probe/disconnect paths remain unchanged and continue to call the
  existing generic handlers `rtw89_usb_probe`/`rtw89_usb_disconnect`.
- Risk assessment: Extremely low. It only expands the alias table so the
  driver binds to a device already supported by the RTL8851B/USB code
  path. The interface match uses `USB_DEVICE_AND_INTERFACE_INFO(...,
  0xff, 0xff, 0xff)`, consistent with other entries, limiting binding to
  the intended vendor-specific interface and avoiding unintended grabs.
- User impact: High practical value. Without the ID, the D-Link AX9U
  rev. A1 (VID:PID 2001:332a) will not bind to the driver, leaving users
  without Wi‑Fi. Adding the ID “fixes” a real-world non-working device
  scenario common to stable policy.
- Architectural impact: None. No new features or behavior changes; no
  changes to `rtw89_usb_probe` implementation or the rtw89 core. The
  probe path remains the same
  (`drivers/net/wireless/realtek/rtw89/usb.c:932` onward).
- Cross-subsystem consistency: The same VID:PID is already recognized on
  the Bluetooth side (`drivers/bluetooth/btusb.c:526` shows
  `USB_DEVICE(0x2001, 0x332a)` under 8851BU Realtek BT), which is
  typical for combo devices. The Wi‑Fi ID addition aligns Wi‑Fi binding
  with the already-supported BT interface.
- Stable criteria fit: This is a minimal, contained enablement/fix with
  negligible regression risk, no architectural changes, and clear user
  benefit. While the commit message has no explicit “Cc: stable”, device
  ID additions like this are routinely accepted for stable when the
  driver exists in the target tree.

Note: Backport applicability depends on the target stable branch having
the rtw89 RTL8851BU driver (`rtw8851bu.c`) and RTL8851B support already
present. If absent, the change is N/A for that branch.

 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index c3722547c6b09..04e1ab13b7535 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -16,6 +16,9 @@ static const struct rtw89_driver_info rtw89_8851bu_info = {
 static const struct usb_device_id rtw_8851bu_id_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb851, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	/* D-Link AX9U rev. A1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	/* TP-Link Archer TX10UB Nano */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
-- 
2.51.0


