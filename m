Return-Path: <linux-wireless+bounces-31864-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMKnLV3pkGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31864-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:30:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E76713D818
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 357EA30842A3
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6029ACCD;
	Sat, 14 Feb 2026 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzQTtlzu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2053090F5;
	Sat, 14 Feb 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104395; cv=none; b=TwXnQn7XGdXOsXHUHSfOiCoa/FSVux6NBAwsTkEfT9/tZArb2xWD6qKYd9l73GgNUVir5jdHlQkndYr/bD7G5nutKs0Ujc7jHp3K2JKdniuS/ATDvGTb4ZtDqCjinuyMwI61SxbtDx8uCfXf0twz8K4YqMat6mr5tsiFmD3T6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104395; c=relaxed/simple;
	bh=SfNiciLZoCdsgwu+cuQeIqk99SgFPy8qcvawaJKhokk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9F6tQIaABthO3sZeCdRjhBk2RVHXdp4tJPK6WLBayNi0oz+7buVB7Lrcsfg02jAM4FQCAKqJGIic6e3q7NbAzcbeASH61h63WGKVSG67VQRtFU1ngax02F9/RfmXRBUbUVXcqj0PQvJbdcmUiP3ISazeQF0j0F6ic8YZK3g6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzQTtlzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CDFC19422;
	Sat, 14 Feb 2026 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104394;
	bh=SfNiciLZoCdsgwu+cuQeIqk99SgFPy8qcvawaJKhokk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IzQTtlzucuZ8od72PiRX1nYtKPcseAx2ut8S4z1uyzLuMArs095BQClymhYcTZn81
	 FjNdXz4mXpZHmfQ/3pPa7aRWHl0Z2lo/j6W2ZAK5VnihmFKMvEHZxqxAwYhBVnTa3O
	 gao5nSyEl/QjEgnQrN1ZQwkoZH1O9/Aql6Aep5J6lQ5TwHbzyAQyxfblPJzWmzjBak
	 AXH8Pn0/53KnCIrHqCgrpAjdlFCEzAF8lqC92IDFVJD6Kwra0PZG0LSj/KM7NRur4J
	 agG1g9q80ubgz9SNfuFTwyjggVD4oNLUxi4/HkuAJTn+Xsf/OfueGqYyxRkzg272s5
	 fNUdkZA0mh99Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chin-Yen Lee <timlee@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] wifi: rtw89: wow: add reason codes for disassociation in WoWLAN mode
Date: Sat, 14 Feb 2026 16:23:24 -0500
Message-ID: <20260214212452.782265-59-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31864-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,realtek.com:email]
X-Rspamd-Queue-Id: 6E76713D818
X-Rspamd-Action: no action

From: Chin-Yen Lee <timlee@realtek.com>

[ Upstream commit 2fd8f953f25173d14981d8736b6f5bfcd757e51b ]

Some APs disconnect clients by sending a Disassociation frame
rather than a Deauthentication frame. Since these frames use
different reason codes in WoWLAN mode, this commit adds support
for handling Disassociation to prevent missed disconnection events.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260110022019.2254969-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

The commit adds handling for disassociation frames in WoWLAN (Wake-on-
Wireless-LAN) mode. The problem described is that some APs disconnect
clients by sending a Disassociation frame rather than a Deauthentication
frame. Without this patch, if an AP sends a Disassociation frame while
the system is in WoWLAN suspend, the driver doesn't recognize the wake
reason code (`0x4`), and the disconnection event is missed — the system
either doesn't wake up properly or wakes up without reporting the
correct reason to userspace.

### Code Change Analysis

The change is minimal and surgical:

1. **wow.h**: Adds a new enum value `RTW89_WOW_RSN_RX_DISASSOC = 0x4` to
   the existing `rtw89_wake_reason` enum. This is a firmware-defined
   reason code that the hardware/firmware already produces — the driver
   just wasn't handling it.

2. **wow.c**: Adds a new `case RTW89_WOW_RSN_RX_DISASSOC:` in the switch
   statement in `rtw89_wow_show_wakeup_reason()`, which sets
   `wakeup.disconnect = true` (same as deauth and disconnect cases) and
   logs a debug message.

The pattern is identical to the existing `RTW89_WOW_RSN_RX_DEAUTH` case
— same behavior, just for a different frame type.

### Bug Classification

This fixes a **real functional bug**: missed disconnection events during
WoWLAN suspend. When an AP sends a disassociation frame (which is a
legitimate and common way to disconnect a client per IEEE 802.11), the
driver fails to properly report the wakeup reason. This means:

- The system may not wake up when the user expects it to (missed wake
  event)
- Or if it does wake, the wakeup reason isn't properly communicated to
  cfg80211/userspace
- The unhandled reason code falls through to the `default` case in the
  switch

### Scope and Risk Assessment

- **Size**: ~10 lines added across 2 files
- **Risk**: Extremely low — it's adding a case to a switch statement
  that mirrors existing cases
- **Self-contained**: No dependencies on other commits
- **No new features**: This is handling a firmware-defined reason code
  that the hardware already produces; the driver was simply missing the
  handler
- **No API changes**: No new userspace-visible APIs

### User Impact

This affects any user of rtw89 WiFi hardware who uses WoWLAN.
Disassociation frames are commonly sent by APs (especially enterprise
APs during maintenance, roaming scenarios, or policy enforcement).
Missing these events means WoWLAN doesn't work correctly in real-world
scenarios — which is a functional bug for laptop users relying on wake-
on-disconnect.

### Comparison to Stable Criteria

This is analogous to a **hardware quirk/workaround** — it handles a case
that the firmware already supports but the driver wasn't processing. It:
- Fixes a real bug (missed disconnection events)
- Is obviously correct (mirrors existing deauth handling)
- Is small and contained
- Does not introduce new features
- Applies cleanly

### Concerns

- The code exists in stable trees (rtw89 driver has been in the kernel
  for several versions)
- No dependencies on other commits
- The enum value `0x4` is firmware-defined and presumably has been
  supported by the firmware for some time

### Decision

This is a small, surgical bug fix that prevents missed WoWLAN
disconnection events. It's clearly correct, mirrors existing code
patterns, has negligible risk, and fixes a real-world user-facing issue
with WiFi hardware.

**YES**

 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++++
 drivers/net/wireless/realtek/rtw89/wow.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 46aba4cb2ee9e..534966b4d9c43 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -809,6 +809,10 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 
 	reason = rtw89_read8(rtwdev, wow_reason_reg);
 	switch (reason) {
+	case RTW89_WOW_RSN_RX_DISASSOC:
+		wakeup.disconnect = true;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx disassoc\n");
+		break;
 	case RTW89_WOW_RSN_RX_DEAUTH:
 		wakeup.disconnect = true;
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx deauth\n");
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index d2ba6cebc2a6b..71e07f482174f 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -33,6 +33,7 @@
 enum rtw89_wake_reason {
 	RTW89_WOW_RSN_RX_PTK_REKEY = 0x1,
 	RTW89_WOW_RSN_RX_GTK_REKEY = 0x2,
+	RTW89_WOW_RSN_RX_DISASSOC = 0x4,
 	RTW89_WOW_RSN_RX_DEAUTH = 0x8,
 	RTW89_WOW_RSN_DISCONNECT = 0x10,
 	RTW89_WOW_RSN_RX_MAGIC_PKT = 0x21,
-- 
2.51.0


