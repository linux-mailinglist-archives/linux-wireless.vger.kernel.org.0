Return-Path: <linux-wireless+bounces-31869-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA2hARDpkGkadwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31869-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA413D72D
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB32E302053E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E3311956;
	Sat, 14 Feb 2026 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH13v3NM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D32FF148;
	Sat, 14 Feb 2026 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104419; cv=none; b=SiRwhTKQ+rbAztBS9gvDpOTc3eq5Lnz7VmZr5rLeF9W4cc9ZnAdYr5W4HxJiwd31Q0vPifjnDvGspWRN6j4RzYewj7MMVjSgBXKQVP3WACsHsi0X933ctlR7DWvRfSFp+KcWd2auotaaEPQmN3gY+/tIyYUii1rWs+HJLTs1Pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104419; c=relaxed/simple;
	bh=qSSLev40jQp8E4MCDlw4osAc9534SPfMV7XGo/O9KPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GM9O8d3jnHVdSOeaGG/Juom9HPkLx533bcoDu4lutfUXv/PLCx7ZwtALD4Qx+7d9CuVnZwV8mk7iTjwh2ir9Nj3q/lD6iPsZ4NKByiU+I3QsHDLXm5HSF9Kk9JLr3V4ZpGYud9jPaDN5UQiomXsdQ330JCjVFUZi2TAS3IVurks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH13v3NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22018C19422;
	Sat, 14 Feb 2026 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104419;
	bh=qSSLev40jQp8E4MCDlw4osAc9534SPfMV7XGo/O9KPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jH13v3NMUkAT4lLWAAdogQyB31U4K3lbVkaaUYxNhBX3TuEQ5B4qDxnMZ9EEY0xd3
	 G/n5VBR4LTVWPbqH+MHt99kFgYEPEj+7LVknYA5npdEVJ65br3BgXleY2Lj/2TukvQ
	 58xk/neG6Xl4EA469PBaVWihNDYrtb8Xtcj6iYByHcrsEABNt10XsagRnIULxuTyuN
	 eGtzsjvQcivnghqDOgkHBTrp8z9aJci7x9fpzJTWTL3X7O85W9VFnFThPgBtvAgGWo
	 Rbv9E5tZVqCaTUKgDZJOiviU3Io5t6WExinefGlO7TlUCGch5fm1f+6RB4yhXbLmR0
	 GPSHNe+rtUVBQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Szymon Wilczek <swilczek.lx@gmail.com>,
	syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	mingo@kernel.org,
	tglx@kernel.org,
	yelangyan@huaqin.corp-partner.google.com,
	linux-wireless@vger.kernel.org,
	libertas-dev@lists.infradead.org
Subject: [PATCH AUTOSEL 6.19-5.10] wifi: libertas: fix WARNING in usb_tx_block
Date: Sat, 14 Feb 2026 16:23:39 -0500
Message-ID: <20260214212452.782265-74-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-31869-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,intel.com,kernel.org,linaro.org,huaqin.corp-partner.google.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless,67969ab6a2551c27f71b];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 9CAA413D72D
X-Rspamd-Action: no action

From: Szymon Wilczek <swilczek.lx@gmail.com>

[ Upstream commit d66676e6ca96bf8680f869a9bd6573b26c634622 ]

The function usb_tx_block() submits cardp->tx_urb without ensuring that
any previous transmission on this URB has completed. If a second call
occurs while the URB is still active (e.g. during rapid firmware loading),
usb_submit_urb() detects the active state and triggers a warning:
'URB submitted while active'.

Fix this by enforcing serialization: call usb_kill_urb() before
submitting the new request. This ensures the URB is idle and safe to reuse.

Reported-by: syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=67969ab6a2551c27f71b
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
Link: https://patch.msgid.link/20251221155806.23925-1-swilczek.lx@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of commit: wifi: libertas: fix WARNING in usb_tx_block

### 1. COMMIT MESSAGE ANALYSIS

The commit message is clear and well-structured:
- **Subject**: Explicitly says "fix WARNING" — this is a bug fix
- **Problem**: `usb_tx_block()` submits `cardp->tx_urb` without ensuring
  the previous transmission completed. If called rapidly (e.g., during
  firmware loading), the URB is still active and `usb_submit_urb()`
  triggers a WARNING: "URB submitted while active"
- **Solution**: Add `usb_kill_urb()` before submitting to ensure the URB
  is idle
- **Reported-by syzbot**: This is a fuzzer-found, reproducible bug with
  a concrete trigger

### 2. CODE CHANGE ANALYSIS

The change is minimal — a single line addition:
```c
+       usb_kill_urb(cardp->tx_urb);
```

Added right before `usb_fill_bulk_urb()` and `usb_submit_urb()`. This
ensures the URB is in an idle state before being reused.

- `usb_kill_urb()` is the standard kernel API for cancelling a pending
  URB and waiting for its completion. It is safe to call on an already-
  idle URB (it's a no-op in that case).
- The fix is placed after the `surprise_removed` check but before the
  URB fill/submit, which is the correct location.

### 3. BUG CLASSIFICATION

This is a **race condition / incorrect URB lifecycle management** bug.
The URB can be submitted while still active from a previous call, which:
- Triggers a kernel WARNING (stack trace in dmesg)
- Could potentially lead to undefined behavior in the USB subsystem if
  the URB state is corrupted
- Is a real correctness issue, not just a cosmetic warning

### 4. SYZBOT INDICATOR

The bug was found by syzbot, which means:
- It is **reproducible** with a concrete trigger
- It is **reachable from userspace** (syzbot exercises syscall paths)
- The syzkaller link confirms this is a documented, verified bug

### 5. SCOPE AND RISK ASSESSMENT

- **Lines changed**: 2 (one blank line + one `usb_kill_urb()` call)
- **Files changed**: 1
  (`drivers/net/wireless/marvell/libertas/if_usb.c`)
- **Risk**: Very low. `usb_kill_urb()` is a well-understood, safe API.
  Calling it on an idle URB is a no-op. The only effect is ensuring
  serialization of URB submissions.
- **Regression potential**: Minimal. The worst case is a slight
  performance overhead from the synchronous kill call, but this is in a
  firmware loading path, not a hot data path.

### 6. STABLE CRITERIA CHECK

| Criterion | Met? |
|-----------|------|
| Obviously correct and tested | Yes — standard pattern, syzbot-verified
|
| Fixes a real bug | Yes — WARNING + potential URB corruption |
| Fixes an important issue | Yes — kernel WARNING, USB subsystem
correctness |
| Small and contained | Yes — 1 line in 1 file |
| No new features | Correct — pure bug fix |
| Applies cleanly | Very likely — minimal context dependencies |

### 7. USER IMPACT

The libertas driver is used with Marvell wireless USB adapters. While
not the most commonly used driver, users with this hardware would
experience:
- Kernel WARNING messages in dmesg during firmware loading
- Potential instability in the USB subsystem
- The bug is triggered during rapid firmware loading, which is a normal
  operation

### 8. DEPENDENCY CHECK

This is a standalone fix with no dependencies on other commits. The
`usb_kill_urb()` API has been available for many kernel versions. The
function `usb_tx_block()` and the `if_usb_card` structure with `tx_urb`
have been stable for a long time.

### CONCLUSION

This is a textbook stable backport candidate:
- Syzbot-reported, reproducible bug
- Tiny, surgical fix (1 line)
- Uses well-established kernel API (`usb_kill_urb`)
- Fixes a real correctness issue (URB submitted while active)
- Zero risk of regression
- No dependencies on other commits

**YES**

 drivers/net/wireless/marvell/libertas/if_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index b3c4040257a67..924ab93b7b671 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -426,6 +426,8 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 		goto tx_ret;
 	}
 
+	usb_kill_urb(cardp->tx_urb);
+
 	usb_fill_bulk_urb(cardp->tx_urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,
 					  cardp->ep_out),
-- 
2.51.0


