Return-Path: <linux-wireless+bounces-31845-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AChjH4/okGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31845-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D196C13D5D4
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7BEE301A3BC
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059729DB99;
	Sat, 14 Feb 2026 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRtzN4sX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC23081A2;
	Sat, 14 Feb 2026 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104315; cv=none; b=tSBMRJdMr5RsBzQO8Yox3XtZvPvLOfln3me/35962BEKXC+e0T+IXs+7FIL0MOIKCRsPLfwRX7DkW9EIt2bTNkEXzExDFT7g82JYVLVFhhzVnJYZjK0tlBddLpaXEOqB5zWD6i98pvNiIt1jmGU87YrTlXViS39GM6e16RLnN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104315; c=relaxed/simple;
	bh=7Cyb3/2QQxunoxX8HBfiwUUMJVAL7GDCltQ+0BLoYUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kN8jxQkG6htDP+qZvLQqmXpwdYrRJ08J8alczhu2DpJpJa/7l6dvjZ4XhjnpaeJmE5OnHEfy3cKAldVsd1J/rPnRHgmvFyHYmlBa5SkvQQpzKWF1Fg331rzX380zsDNnAT6n7OTj/j3Q8hmlD2U1A5XRgOmnY4JpkwDWNqRgvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRtzN4sX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ED0C2BCAF;
	Sat, 14 Feb 2026 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104314;
	bh=7Cyb3/2QQxunoxX8HBfiwUUMJVAL7GDCltQ+0BLoYUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRtzN4sXvh6IgAa+tsDe0mM66+4LasC8dOVWjKu3q610TmTLNMo57V3OdWnECBUA3
	 4NYUVpQ9b9MhLwJ1uRLtY9W3BvNFArXOut8G++481q2y8+R+VeLqKsGv04BKy1pHc+
	 hoc55I29UiJukE+P67sIOZlc9+0Eux45bM3dAGT9GT15h28HHIB/EXig8iqetwpT5P
	 xGstFK4K/FuC/MLRkNzbG+LtICRsB2XKi/brZPRUNwtRRHFLv8L6SXicmFDuJ6FUQ1
	 3PaVsW1HhZa6QE+e38p1EXJ/4YwMg0+X3avPnct6/LHRXjDwvXKgsEd7n0EL5xVmi4
	 e3qJV+MvuvXYw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] wifi: iwlegacy: add missing mutex protection in il4965_store_tx_power()
Date: Sat, 14 Feb 2026 16:22:35 -0500
Message-ID: <20260214212452.782265-10-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31845-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,wp.pl:email]
X-Rspamd-Queue-Id: D196C13D5D4
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit e31fa691d0b1c07b6094a6cf0cce894192c462b3 ]

il4965_store_tx_power() calls il_set_tx_power() without holding il->mutex.
However, il_set_tx_power() has lockdep_assert_held(&il->mutex) indicating
that callers must hold this lock.

All other callers of il_set_tx_power() properly acquire the mutex:
- il_bg_scan_completed() acquires mutex at common.c:1683
- il_mac_config() acquires mutex at common.c:5006
- il3945_commit_rxon() and il4965_commit_rxon() are called via work
  queues that hold the mutex (like il4965_bg_alive_start)

Add mutex_lock()/mutex_unlock() around the il_set_tx_power() call in
the sysfs store function to fix the missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260125194039.1196488-1-n7l8m4@u.northwestern.edu
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

The commit message is clear and well-documented. It identifies a
specific bug: `il4965_store_tx_power()` calls `il_set_tx_power()`
without holding `il->mutex`, but `il_set_tx_power()` requires this lock
(enforced via `lockdep_assert_held`). The message also documents that
all other callers properly acquire the mutex, making this the only call
site that's missing the protection.

### Code Change Analysis

The fix is minimal and surgical — exactly 2 lines added:
```c
mutex_lock(&il->mutex);
ret = il_set_tx_power(il, val, false);
mutex_unlock(&il->mutex);
```

This is a sysfs store handler (`il4965_store_tx_power`), which can be
triggered from userspace by writing to the `tx_power` sysfs attribute.
Without the mutex:

1. **lockdep warning**: The `lockdep_assert_held(&il->mutex)` in
   `il_set_tx_power()` will fire a warning/splat every time a user
   writes to this sysfs file.
2. **Race condition**: `il_set_tx_power()` modifies driver state that is
   also accessed by other code paths (scan completion, mac80211 config,
   rxon commits) which all hold the mutex. Without the mutex, concurrent
   access from sysfs and these other paths could corrupt driver state,
   potentially leading to firmware errors, crashes, or undefined
   behavior.

### Classification

This is a **synchronization bug fix** — missing mutex protection around
a function that requires it. It falls squarely into the "race condition"
and "missing locking" categories of stable-worthy fixes.

### Scope and Risk Assessment

- **Lines changed**: 2 (adding mutex_lock/unlock)
- **Files touched**: 1
- **Risk**: Extremely low. Adding mutex protection around a single
  function call in a sysfs handler is about as safe as it gets. The
  mutex is already used throughout the driver, and all other callers of
  `il_set_tx_power()` already hold it. There's no risk of deadlock since
  this is a sysfs store handler (not called from any context that
  already holds the mutex).
- **Subsystem**: iwlegacy wireless driver — a mature, legacy Intel WiFi
  driver

### User Impact

- Any user with iwlegacy hardware who writes to the `tx_power` sysfs
  attribute will trigger a lockdep splat (if lockdep is enabled) and
  potentially experience a race condition
- The race could lead to corrupted driver state, firmware errors, or
  crashes
- The sysfs interface is a user-facing control, so this is a realistic
  trigger path

### Stability Indicators

- **Acked-by**: Stanislaw Gruszka (iwlegacy maintainer) — strong signal
- **Committed by**: Johannes Berg (Intel wireless maintainer) — strong
  signal
- The fix pattern (adding mutex around a call that requires it) is well-
  understood and obviously correct

### Dependency Check

This commit is completely self-contained. It adds standard
mutex_lock/unlock calls around an existing function call. No other
patches are needed. The iwlegacy driver and this specific code path have
existed in stable kernels for a very long time.

### Conclusion

This is a textbook stable backport candidate:
- **Obviously correct**: The function requires the mutex (has lockdep
  assertion), all other callers hold it, this one doesn't — the fix adds
  the missing lock
- **Fixes a real bug**: Missing synchronization causing potential races
  and lockdep warnings
- **Small and contained**: 2 lines added, 1 file changed
- **No new features**: Pure bug fix
- **Low risk**: Standard locking pattern, well-tested by maintainer
  review
- **Acked by subsystem maintainer**: Confirms the fix is appropriate

**YES**

 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 3588dec75ebdd..57fa866efd9f8 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -4606,7 +4606,9 @@ il4965_store_tx_power(struct device *d, struct device_attribute *attr,
 	if (ret)
 		IL_INFO("%s is not in decimal form.\n", buf);
 	else {
+		mutex_lock(&il->mutex);
 		ret = il_set_tx_power(il, val, false);
+		mutex_unlock(&il->mutex);
 		if (ret)
 			IL_ERR("failed setting tx power (0x%08x).\n", ret);
 		else
-- 
2.51.0


