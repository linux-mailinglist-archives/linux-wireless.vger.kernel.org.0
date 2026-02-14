Return-Path: <linux-wireless+bounces-31847-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHSUIEPokGkMdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31847-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AA13D4E3
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C6CC300B466
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1933309DB1;
	Sat, 14 Feb 2026 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCShpOMM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB873081A2;
	Sat, 14 Feb 2026 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104320; cv=none; b=CY7nLB5zJstJyoaAdw9Q2+CmtXEqCLSLKKPlPkhfBjM62iT3Fxns9NN9KJ1McaeTm8NL64WSICghati/vtMzBdqQAB6hrOC88Ou0di2495eSQq5aO4UnjgjW3HYtV8ktKoeq1y5mXms0+dJA+4C/Qjlsmd60TXtn8yEEW2WezU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104320; c=relaxed/simple;
	bh=k75XIAZOC75bHLfIRpDsTkg09bZTCCXEMDg9b4ASfsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGkSDjjC6GNlGAWAdAaBszdr2N8zdMm5PdFvMO3ejp9U/MrPYR3G/twPV5x+khShka5JLQSXL/nHuoSKXN4kB8eZI3KLgmpx6D4zx5bwB1f5dUW2FWqtqrrNm+nl2JlWRNu6rnoTbWy9ajV2MLWkF/Rh0TgVzFzCt2eJHnQDjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCShpOMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E0C16AAE;
	Sat, 14 Feb 2026 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104320;
	bh=k75XIAZOC75bHLfIRpDsTkg09bZTCCXEMDg9b4ASfsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCShpOMMmK+IP49/iLYCyl5Pfq1+1an6tARZyspEceIP04j4qcMpipkzYXlPiuQ5s
	 H3/+fGILmLSwdeEi628C8HShDvpF8d54tg3mRy2fQqCPVDfVPbCbINMiDLOB/IZf7T
	 egX93BHMhiJZ9+OF9yxnERsV7TcX7g92j+sJ8r+s7Hn6sW0TNxUNTDUSVM1HJ8ZnPH
	 klZtV1U9oeyY6n5c0/dA+A6nINJ1fqik2cMu6vaSETBoyGe9K7DXukdVFu3n32IE53
	 idJID3MDSBzX5Rc/4YWDCMhgp/SnBLxWrcvQMReuEPZAI+XsVvr9jHPxMD8TCy3dLB
	 PVN+IT0ambrwg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: Add support for MSI AX1800 Nano (GUAX18N)
Date: Sat, 14 Feb 2026 16:22:40 -0500
Message-ID: <20260214212452.782265-15-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31847-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F7AA13D4E3
X-Rspamd-Action: no action

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 3116f287b81fe777a00b93ab07ec3c270093b185 ]

Add the ID 0db0:f0c8 to the table to support an additional RTL8832BU
adapter: MSI AX1800 Nano (GUAX18N).

Compile tested only.

Link: https://github.com/morrownr/rtl8852bu-20250826/pull/2
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260112004358.5516-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Overview
This commit adds a single USB device ID (`0x0db0:0xf0c8`) to the
`rtw_8852bu_id_table` in the rtw89 wireless driver to support the MSI
AX1800 Nano (GUAX18N) USB WiFi adapter, which uses the RTL8832BU
chipset.

### Classification: New Device ID Addition
This falls squarely into the **"NEW DEVICE IDs"** exception category for
stable backports:
- It adds a USB device ID to an **existing, already-supported driver**
  (rtw89/rtw8852bu)
- The driver infrastructure is already in place; only the ID mapping is
  new
- The same `rtw89_8852bu_info` driver_info structure is used, identical
  to all other entries in the table

### Code Change Analysis
- **Size**: +2 lines (one `USB_DEVICE_AND_INTERFACE_INFO` entry)
- **Scope**: Single file, single table entry addition
- **Pattern**: Identical to every other entry in the table — `{
  USB_DEVICE_AND_INTERFACE_INFO(vendor, product, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info }`
- **Risk**: Essentially zero. The new entry only matches when the
  specific USB device (`0x0db0:0xf0c8`) is present. It cannot affect any
  other hardware or code path.

### User Impact
- Without this ID, users with the MSI AX1800 Nano adapter cannot use it
  with the in-kernel rtw89 driver on stable kernels
- WiFi adapter support is a common and important need for end users
- The vendor (MSI, vendor ID `0x0db0`) already has another device
  (`0x6931`) in the same table, confirming this is a known hardware
  vendor for this chipset

### Risk Assessment
- **Risk**: Negligible — a device ID table addition cannot cause
  regressions for existing users
- **Benefit**: Enables hardware support for a real commercial WiFi
  adapter
- **Dependencies**: None — requires only that the rtw8852bu driver
  exists in the stable tree

### Stability Considerations
- The commit note says "Compile tested only," which is typical for
  device ID additions where the submitter may not have all test
  infrastructure but the change is trivially correct by inspection
- The patch was accepted by the subsystem maintainer (Ping-Ke Shih from
  Realtek)

### Dependency Check
The rtw8852bu USB driver needs to exist in the target stable tree. This
driver was added relatively recently, so this backport is only
applicable to stable branches that already contain the rtw89 USB
support.

### Conclusion
This is a textbook device ID addition — the most common and least risky
type of stable backport. It's a trivial 2-line addition that enables
real hardware for real users with zero regression risk.

**YES**

 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 980d17ef68d0a..84cd3ec971f98 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -54,6 +54,8 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0xf0c8, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3327, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6121, 0xff, 0xff, 0xff),
-- 
2.51.0


