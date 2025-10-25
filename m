Return-Path: <linux-wireless+bounces-28258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1748CC099DA
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F920505BAE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91930AD04;
	Sat, 25 Oct 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4LZOdgf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367E305E24;
	Sat, 25 Oct 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409228; cv=none; b=iWIUjtkGi/3nOqHG8eJV6Wiy2eLjil/Nfu/MDUKJXvgQ0YYza4GfTxDwuyP9o7cDLdInQA7x2bct2Z5c7VuQ2CMmaKayue0WdrukqrQzyvn7mDWNT59Iqosws7wljaHsSh58zOpF2lb4wJNNrmIHhUIg/82pZmmacLcLj1xcfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409228; c=relaxed/simple;
	bh=2VI7w7ZUTHKRPuKx+Dn9sflj/cNOG32E4pMS/L2KDK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbRHIqZKXfe/Kh5sX+4nG8KJ6C3673kpz0ieAEG6z9x62FovZlHQq243FA9r92cFVAb6LG4H1Q5sX99iScRMa0FuH9vWdj9xW9v+sB2Qg9hDAllZ4LhjcpbLusHpxYiKGZC44+BahuagiODCxJlDrPaqCOXjdydT5PIn3gMD/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4LZOdgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E8C116D0;
	Sat, 25 Oct 2025 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409228;
	bh=2VI7w7ZUTHKRPuKx+Dn9sflj/cNOG32E4pMS/L2KDK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4LZOdgflwy7zKrb5K9k8CoE8NsdpLK7jMVA8IQ8GhJf83I5FOyXGJbZkBRQj/m0F
	 kGSt0XMYYU20B4SXuWLnKn6JXEuxlDV8Hw5MzGNyCobg6Ltf6PvO2hWcAVToCFX8HS
	 tQ93GCPydZ0fUbG17Rte3FMkaz+YSGRRFpvwVqNu5OMvrxZC8rUVzWL6jxiMCMfED6
	 u7Tu58i3Uv+XVdBVLD7VlCnkSaNPMLi0WOvGoN0FJ5Z44DynEYlD0I4Kts3jveLodz
	 tiP+FF7AIIo2kfsa38HW//DoOwBKtcEBshQEpJgVpc4WZgp/wATswp8OcyDcjMa+fi
	 jXXKPh431PsIA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1
Date: Sat, 25 Oct 2025 11:58:01 -0400
Message-ID: <20251025160905.3857885-250-sashal@kernel.org>
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

[ Upstream commit 17002412a82feb21be040bd5577789049dfeebe2 ]

Add USB ID 2001:3327 for D-Link AX18U rev. A1 which is a RTL8832BU-based
Wi-Fi adapter.

Link: https://github.com/morrownr/rtw89/pull/17
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250903223100.3031-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What changed
  - Adds a new USB device ID entry for D-Link AX18U rev. A1 (vendor
    0x2001, product 0x3327) to the rtw8852bu driver’s ID table so the
    device binds to this driver:
    drivers/net/wireless/realtek/rtw89/rtw8852bu.c:33–34.
  - The entry maps to `rtw89_8852bu_info`, identical to existing 8852BU-
    based devices in the same table:
    drivers/net/wireless/realtek/rtw89/rtw8852bu.c:10–14,16–44.

- Effect and correctness
  - With this ID present, usbcore will match the device and call the
    driver’s probe with the associated `driver_info`. The probe uses
    `id->driver_info` to select the chip info and bring the device up:
    drivers/net/wireless/realtek/rtw89/usb.c:940–945, and registers the
    hw stack via the standard rtw89 USB path:
    drivers/net/wireless/realtek/rtw89/usb.c:956–999.
  - The new entry uses the same matching macro and interface class
    triplet (`USB_DEVICE_AND_INTERFACE_INFO(..., 0xff, 0xff, 0xff)`) as
    the existing entries, minimizing false positives and aligning with
    vendor-specific Realtek interfaces:
    drivers/net/wireless/realtek/rtw89/rtw8852bu.c:16–44.

- Scope and risk
  - Purely additive, one-line functional change confined to a device ID
    table; no logic, control flow, or data structure changes.
  - No architectural impact; does not touch critical subsystems beyond
    enabling auto-binding for this ID.
  - Low regression risk for existing users; only affects systems that
    plug in this specific device. If the device is indeed
    RTL8832BU/8852B-family (as stated in the commit) the mapping to
    `rtw89_8852bu_info` is correct and consistent with the rest of the
    table.

- Stable backport criteria
  - Fixes a real-world usability gap: without this ID, the adapter is
    not recognized and cannot be used, which is treated as a practical
    bug for end users.
  - Minimal patch size and risk; typical “add device ID” enablement
    often accepted for stable.
  - No new features or behavioral changes to existing devices.

Recommendation: Backport to any stable trees that already contain the
rtw89 USB support and `rtw8852bu.c`. This provides immediate hardware
enablement with negligible risk.

 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index b315cb997758a..0694272f7ffae 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -30,6 +30,8 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3327, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6121, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0100, 0xff, 0xff, 0xff),
-- 
2.51.0


