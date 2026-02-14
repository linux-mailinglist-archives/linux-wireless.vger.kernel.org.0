Return-Path: <linux-wireless+bounces-31842-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJg2HFDokGkMdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31842-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58013D511
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6BBD301A3A8
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1028134C;
	Sat, 14 Feb 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoyPguT8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B41283159;
	Sat, 14 Feb 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104300; cv=none; b=amHB/Aa+P5wrPYfa9IgG0caBFiXET33JRafWIC6+ITSBsBO3WBWFBq7RhaGsYGGiascJ6FxQO8lH4dyyjEVkBxmaz/LRrZTVFKPagzSheBC8VbrCf2NN2EN9eEzu/kEhHSg8mnXlQzqNN9A6accgYAy4S8rea7GPOZcZOxqQgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104300; c=relaxed/simple;
	bh=azvUs/xcRBCDkgUMgacWSsuC73kJLhlbX2dn/mO2XqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJcQVw+2eF1PlkgmBONEaAT85g0TP5MPwOpyCgBr067E8Fvzfvir3f7dnajsw3EUZbQZCA2/uNb0VcH2Pg9+xfb3bff1u3SoryOXb3qXxvQqiA6qxaQknD16MjFU1SEj/3vuHkvnmbTH7krfX6X9B0GBF2yvkRMmz10I5bzyxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoyPguT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DD0C19422;
	Sat, 14 Feb 2026 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104300;
	bh=azvUs/xcRBCDkgUMgacWSsuC73kJLhlbX2dn/mO2XqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoyPguT8VwCIRSqHoT2ppi1a2jE8f54kIUH/sDTZksU/olZydgV66ftUgeB6D9dzs
	 gMKuBFOCtoQC4ucIXefTI6JZEln3bIl7LKN+Uz/IvZU6Zr6Vd/RHwjmi/JQ7tZ/xfV
	 rJok8HL9gpjuNo0eTeFe+GEYuhqAUgJ28edMb9Q/O55d773mjuAj4vXZTkSdj5D1kF
	 JxXkonuvKHl6h+jojVno5kAP0RAqSOlIs3UyLBRJxLN2+TjMRZH+jCwdo3V1HRmAp2
	 GsZgD1cobdKxy1xiYFFHk4VSSoPDJJF8AWogNPvQWFCujxHPen7ql54ZeWxwJsIwSJ
	 4b4U8UTMMF9Ww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] wifi: rtw88: 8822b: Avoid WARNING in rtw8822b_config_trx_mode()
Date: Sat, 14 Feb 2026 16:22:29 -0500
Message-ID: <20260214212452.782265-4-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31842-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF58013D511
X-Rspamd-Action: no action

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 44d1f624bbdd2d60319374ba85f7195a28d00c90 ]

rtw8822b_set_antenna() can be called from userspace when the chip is
powered off. In that case a WARNING is triggered in
rtw8822b_config_trx_mode() because trying to read the RF registers
when the chip is powered off returns an unexpected value.

Call rtw8822b_config_trx_mode() in rtw8822b_set_antenna() only when
the chip is powered on.

------------[ cut here ]------------
write RF mode table fail
WARNING: CPU: 0 PID: 7183 at rtw8822b.c:824 rtw8822b_config_trx_mode.constprop.0+0x835/0x840 [rtw88_8822b]
CPU: 0 UID: 0 PID: 7183 Comm: iw Tainted: G        W  OE       6.17.5-arch1-1 #1 PREEMPT(full)  01c39fc421df2af799dd5e9180b572af860b40c1
Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: LENOVO 82KR/LNVNB161216, BIOS HBCN18WW 08/27/2021
RIP: 0010:rtw8822b_config_trx_mode.constprop.0+0x835/0x840 [rtw88_8822b]
Call Trace:
 <TASK>
 rtw8822b_set_antenna+0x57/0x70 [rtw88_8822b 370206f42e5890d8d5f48eb358b759efa37c422b]
 rtw_ops_set_antenna+0x50/0x80 [rtw88_core 711c8fb4f686162be4625b1d0b8e8c6a5ac850fb]
 ieee80211_set_antenna+0x60/0x100 [mac80211 f1845d85d2ecacf3b71867635a050ece90486cf3]
 nl80211_set_wiphy+0x384/0xe00 [cfg80211 296485ee85696d2150309a6d21a7fbca83d3dbda]
 ? netdev_run_todo+0x63/0x550
 genl_family_rcv_msg_doit+0xfc/0x160
 genl_rcv_msg+0x1aa/0x2b0
 ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21a7fbca83d3dbda]
 ? __pfx_nl80211_set_wiphy+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21a7fbca83d3dbda]
 ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21a7fbca83d3dbda]
 ? __pfx_genl_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x59/0x110
 genl_rcv+0x28/0x40
 netlink_unicast+0x285/0x3c0
 ? __alloc_skb+0xdb/0x1a0
 netlink_sendmsg+0x20d/0x430
 ____sys_sendmsg+0x39f/0x3d0
 ? import_iovec+0x2f/0x40
 ___sys_sendmsg+0x99/0xe0
 ? refill_obj_stock+0x12e/0x240
 __sys_sendmsg+0x8a/0xf0
 do_syscall_64+0x81/0x970
 ? do_syscall_64+0x81/0x970
 ? ksys_read+0x73/0xf0
 ? do_syscall_64+0x81/0x970
 ? count_memcg_events+0xc2/0x190
 ? handle_mm_fault+0x1d7/0x2d0
 ? do_user_addr_fault+0x21a/0x690
 ? exc_page_fault+0x7e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
---[ end trace 0000000000000000 ]---

Link: https://github.com/lwfinger/rtw88/issues/366
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/fb9a3444-9319-4aa2-8719-35a6308bf568@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of commit: wifi: rtw88: 8822b: Avoid WARNING in
rtw8822b_config_trx_mode()

### 1. COMMIT MESSAGE ANALYSIS

The commit message is very clear and well-documented:
- **Problem**: `rtw8822b_set_antenna()` can be called from userspace
  (via `iw` tool through nl80211/cfg80211/mac80211 path) when the WiFi
  chip is powered off.
- **Symptom**: A `WARNING` is triggered in `rtw8822b_config_trx_mode()`
  because reading RF registers while the chip is powered off returns
  unexpected values.
- **Solution**: Only call `rtw8822b_config_trx_mode()` when the chip is
  powered on (checked via `RTW_FLAG_POWERON` flag).
- **Evidence**: Full stack trace included showing the WARNING triggered
  from userspace via `iw` command.
- **Link**: Bug report at https://github.com/lwfinger/rtw88/issues/366 —
  real users reported this issue.

### 2. CODE CHANGE ANALYSIS

The change is minimal and surgical — a single conditional check:

```c
- rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
+       if (test_bit(RTW_FLAG_POWERON, rtwdev->flags))
+               rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx,
false);
```

This is a 2-line change (net +1 line) that:
- Wraps the call to `rtw8822b_config_trx_mode()` with a power-on state
  check
- Uses the existing `RTW_FLAG_POWERON` flag — no new infrastructure
  needed
- The antenna_tx/antenna_rx values are still saved to `hal->antenna_tx`
  and `hal->antenna_rx` regardless of power state, so the configuration
  will be applied when the chip powers on

### 3. CLASSIFICATION

- **Bug fix**: YES — fixes a WARNING triggered from userspace
- **Feature addition**: NO
- **Type**: Fixes improper state handling when userspace interacts with
  the driver while hardware is powered off

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: 2 lines (1 removed, 2 added)
- **Files touched**: 1 file
  (`drivers/net/wireless/realtek/rtw88/rtw8822b.c`)
- **Complexity**: Extremely low — trivial conditional guard
- **Risk of regression**: Very low. The only scenario where behavior
  changes is when the chip is powered off, and in that case, trying to
  configure RF registers was already broken (producing the WARNING). The
  antenna settings are saved to HAL state regardless, so they'll be
  applied at power-on.
- **Subsystem**: WiFi driver (rtw88) — a commonly used Realtek WiFi
  driver

### 5. USER IMPACT

- **Who is affected**: Users of rtw88 8822b-based WiFi adapters (common
  in many laptops)
- **Trigger**: Simply running `iw` commands to set antenna configuration
  while the interface is down
- **Severity**: WARNING in kernel log, potentially confusing to users,
  and the WARNING mechanism in the driver indicates an unexpected state
  that could have further consequences
- **Real-world**: Bug was reported by actual users on GitHub issue
  tracker

### 6. STABILITY INDICATORS

- **Acked-by**: Ping-Ke Shih (Realtek maintainer for this driver)
- **Signed-off-by**: Both the author and the subsystem maintainer
- **Bug report link**: Real user-reported issue with reproduction steps

### 7. DEPENDENCY CHECK

- The fix uses `RTW_FLAG_POWERON` and `test_bit()`, both of which have
  been present in the rtw88 driver for a long time (since the driver's
  introduction)
- No dependencies on other commits
- The `rtw8822b_set_antenna()` function and `rtw8822b_config_trx_mode()`
  have been stable for many kernel versions
- This will apply cleanly to any stable tree that has the rtw88 driver

### 8. STABLE KERNEL CRITERIA

1. **Obviously correct and tested**: YES — the logic is trivially
   correct: don't access hardware registers when hardware is off
2. **Fixes a real bug**: YES — a WARNING triggered from userspace
3. **Important issue**: YES — kernel WARNING from userspace interaction,
   reproducible
4. **Small and contained**: YES — 2-line change in 1 file
5. **No new features**: CORRECT — pure bug fix
6. **Applies cleanly**: Very likely — minimal change to stable code

### Summary

This is a textbook stable backport candidate: a tiny, obviously correct
fix for a user-triggered WARNING in a commonly used WiFi driver. The fix
is minimal (2 lines), well-understood, properly reviewed by the
subsystem maintainer, and addresses a real user-reported issue. The risk
of regression is negligible.

**YES**

 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 89b6485b229a8..4d88cc2f41485 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1005,7 +1005,8 @@ static int rtw8822b_set_antenna(struct rtw_dev *rtwdev,
 	hal->antenna_tx = antenna_tx;
 	hal->antenna_rx = antenna_rx;
 
-	rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
+	if (test_bit(RTW_FLAG_POWERON, rtwdev->flags))
+		rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
 
 	return 0;
 }
-- 
2.51.0


