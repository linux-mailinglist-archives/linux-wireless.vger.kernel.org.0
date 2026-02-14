Return-Path: <linux-wireless+bounces-31862-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJNxEazokGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31862-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:27:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ECC13D60D
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29A09301347F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3B3128D9;
	Sat, 14 Feb 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uihJoc2l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4830B538;
	Sat, 14 Feb 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104373; cv=none; b=DFFWyJOsWIDHZgAcHU7s5bojBLSPOYSbNNX0gghmwzS4Z7ejdblT3Q9gGVt1Vr3P29KsQcNCan6cRvs36/MK/MYPm88WumGIrCDRHzPUKdXEMv8WzAmvhxPgKOj6FZ5pyhx4qMdbDovKjNW2IODwNENlHn8NH1tvLM54o9HcYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104373; c=relaxed/simple;
	bh=aHtR4BsyF2l3HR7TsEGG3KivdPRtncTzeKuqIu8cmO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aj7/Oq2/Pe+YeAJ4vV8qYqLarQSuJl5hetxaz+PsOu+HafRAP9RrTtapCXDZPr2iTqLCDBm7TacvyF2+dAO5VUhzezIcFe34gHfR8mEpI9jbXFdEOXpS2AsHjWEs/2+sNrz7RnkGyCAOg28nlJI4epyAX5KPKkEIn0ezM7neYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uihJoc2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CFCC19422;
	Sat, 14 Feb 2026 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104373;
	bh=aHtR4BsyF2l3HR7TsEGG3KivdPRtncTzeKuqIu8cmO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uihJoc2lrAc59pyVN95leA472wiSIEYXaLGczviZ1c7TVAp6YAQtXnu1PxXY28Fvv
	 r7fDsc2IdljRd2KnBLrC3818CkXkw6J//MmAp0eFxh8uBtR3N8hU1KbDOumV5Zxvjj
	 k9QLktNUEX6lT5Oy7AWU275oqXFJ4qIb1uxHBZQY49EeXA9jmyO/hIZWZSiSFEdFGj
	 p3xyDK7FMGRazZxpB0P2dWYwpxzH6avWJZerSF8/HQcMOrqEbZa2lRu1fIlYExUcPq
	 hY2foz2GYBWmGLrn0r09lBBNhUpRnfHyrNEd35076OL0JYr5F0alnabqVLtFwHGgAR
	 JIa81QXrvt9Iw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] wifi: iwlegacy: add missing mutex protection in il3945_store_measurement()
Date: Sat, 14 Feb 2026 16:23:14 -0500
Message-ID: <20260214212452.782265-49-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31862-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[u.northwestern.edu,wp.pl,intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wp.pl:email,northwestern.edu:email]
X-Rspamd-Queue-Id: F3ECC13D60D
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit 4dd1dda65265ecbc9f43ffc08e333684cf715152 ]

il3945_store_measurement() calls il3945_get_measurement() which internally
calls il_send_cmd_sync() without holding il->mutex. However,
il_send_cmd_sync() has lockdep_assert_held(&il->mutex) indicating that
callers must hold this lock.

Other sysfs store functions in the same file properly acquire the mutex:
- il3945_store_flags() acquires mutex at 3945-mac.c:3110
- il3945_store_filter_flags() acquires mutex at 3945-mac.c:3144

Add mutex_lock()/mutex_unlock() around the il3945_get_measurement() call
in the sysfs store function to fix the missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260125193005.1090429-1-n7l8m4@u.northwestern.edu
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

The commit message is clear and well-documented. It identifies:
- **The bug**: `il3945_store_measurement()` calls
  `il3945_get_measurement()` → `il_send_cmd_sync()` without holding
  `il->mutex`
- **The evidence**: `il_send_cmd_sync()` has
  `lockdep_assert_held(&il->mutex)`, meaning this will trigger a lockdep
  warning at runtime
- **The pattern**: Other sysfs store functions in the same file
  (`il3945_store_flags()`, `il3945_store_filter_flags()`) already
  properly acquire the mutex
- **The fix**: Add `mutex_lock()`/`mutex_unlock()` around the call

### Code Change Analysis

The diff is minimal — only 2 lines added:
```c
mutex_lock(&il->mutex);
il3945_get_measurement(il, &params, type);
mutex_unlock(&il->mutex);
```

This is a textbook missing-lock fix. The function is a sysfs store
handler (called from userspace via writing to a sysfs file), which calls
into the driver's command submission path without the required
synchronization.

**Bug mechanism**: Without the mutex, concurrent access to
`il_send_cmd_sync()` from this sysfs path and other paths (e.g., normal
driver operation, other sysfs handlers) can result in:
1. **Data races** on shared driver state
2. **Lockdep warnings** at runtime (guaranteed to fire)
3. Potential **corruption of command submission state** leading to
   firmware communication errors or crashes

### Classification

This is a **synchronization bug fix** — a missing lock acquisition. It
falls squarely into the "race conditions" category of stable-worthy
fixes.

### Scope and Risk Assessment

- **Lines changed**: 2 (extremely minimal)
- **Files touched**: 1
- **Risk**: Very low — adding lock acquisition around a single function
  call, following the exact same pattern as sibling functions in the
  same file
- **Subsystem**: iwlegacy wireless driver (older Intel WiFi),
  mature/stable code
- **Could this break something?**: The mutex is already used throughout
  the driver. The only concern would be deadlock if
  `il3945_get_measurement()` were called with the mutex already held,
  but since this is a sysfs entry point (userspace-initiated), it's a
  fresh call path — no lock is held on entry.

### User Impact

- Users with Intel 3945 WiFi hardware who trigger this sysfs interface
  will hit the lockdep warning
- More critically, the lack of synchronization could lead to corruption
  of the driver's command channel, potentially causing firmware hangs or
  crashes
- The iwlegacy driver, while old, still has active users on older
  hardware

### Stability Indicators

- **Acked-by**: Stanislaw Gruszka (former iwlegacy maintainer)
- **Committed by**: Johannes Berg (WiFi subsystem maintainer)
- The fix follows an existing, well-established pattern in the same file

### Dependency Check

- No dependencies on other commits
- The `il->mutex` and the function being called have existed in the
  driver since its inception
- This code exists in all stable trees that include the iwlegacy driver

### Verdict

This is a small, obviously correct, well-reviewed fix for a real
synchronization bug. It:
- Fixes a lockdep assertion violation (guaranteed to trigger)
- Prevents potential race conditions in command submission
- Is only 2 lines, touching 1 file
- Follows the exact same pattern as adjacent code
- Has maintainer acks
- Has zero risk of regression

This meets all stable kernel criteria perfectly.

**YES**

 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 104748fcdc33e..54991f31c52c5 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3224,7 +3224,9 @@ il3945_store_measurement(struct device *d, struct device_attribute *attr,
 
 	D_INFO("Invoking measurement of type %d on " "channel %d (for '%s')\n",
 	       type, params.channel, buf);
+	mutex_lock(&il->mutex);
 	il3945_get_measurement(il, &params, type);
+	mutex_unlock(&il->mutex);
 
 	return count;
 }
-- 
2.51.0


