Return-Path: <linux-wireless+bounces-31851-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGUGNyXpkGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31851-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:29:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AFD13D76B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D40D53042B46
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6209529ACFD;
	Sat, 14 Feb 2026 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHgKkXwf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8A3C2D;
	Sat, 14 Feb 2026 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104339; cv=none; b=EWC6Qs2Dpu/uQgUy+SeC2dYuMmiVOdBFVOsDzUBH35RuKAdbJMWGi4KZ39jL5zadFWzny6tGjwv7hT63OSI87+tEWsVDW9g/53w2Cl4Fpnycj6oZ/7SUd/k5Kd/eyPKw13RGbl4mFrDvFS0DJVJEYO7YPaPSUWbm5BZ4pQzHtiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104339; c=relaxed/simple;
	bh=b1LD+Xansm2gIBycBh5imiPFd4gz7SExWM2XaWHP+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7Ed8Sw+73H7fHvVaChq0L6FGHaxFamcFOdr7tznom8Gv4PLMGJwTEl9VZUd4lcBCaR0SZT5tZcAnCGxh2lawUSfDmezBnUeBzdov4rck6b9j+RrF0TgN5hvcjgUMz1d+GxI+sSgjE0xScJpLMPBc9Ijvut8e/1zUBZREW3pEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHgKkXwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36753C16AAE;
	Sat, 14 Feb 2026 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104339;
	bh=b1LD+Xansm2gIBycBh5imiPFd4gz7SExWM2XaWHP+zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHgKkXwfVIUJdlnWOFBjl5fb9J5W2iIGjXEJdCsdZDISFVZoCO2MsCZNT1lMAFa0o
	 71YSxfU2m7W0F+UPOq7C6h4ut7SCmz4bGKKLCwEKveHBdTqC5a3mUYi1PVDZTlu9dT
	 KmVjSKkm+QRq86g/97Ir8O+a+uzyQ5T73SgVn3+qbqaw1cWFzNEeNmGgoT0uevN6k6
	 pLT0dSIu/OIU8UjuN9m1qtNTDlAqBuAAUNb7uCbxgappzDgv7+HaLs2k4Kqr7jJ3vT
	 qFcH9MDtpzzqJka9/6EHs//F4ileZKajiBy69L735cA3yMq3p51+9HQVYsOX/VLN8M
	 rrtDNPxBDR8EA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.19-5.10] wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
Date: Sat, 14 Feb 2026 16:22:51 -0500
Message-ID: <20260214212452.782265-26-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31851-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email,northwestern.edu:email]
X-Rspamd-Queue-Id: 49AFD13D76B
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit 820ba7dd6859ef8b1eaf6014897e7aa4756fc65d ]

ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
assert that ar->data_lock should be held by the caller, but neither
ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
before calling this function.

The field arsta->peer_ps_state is documented as protected by
ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.

Add spin_lock_bh()/spin_unlock_bh() around the peer_ps_state update,
and remove the lockdep_assert_held() to be aligned with new locking,
following the pattern used by other WMI event handlers in the driver.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Link: https://patch.msgid.link/20260123175611.767731-1-n7l8m4@u.northwestern.edu
[removed excess blank line]
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of wifi: ath10k: fix lock protection in
ath10k_wmi_event_peer_sta_ps_state_chg()

### 1. Commit Message Analysis

The commit message is clear and well-structured:
- **Subject**: Explicitly says "fix lock protection" — this is a
  locking/synchronization bug fix
- **Body**: Explains that `lockdep_assert_held()` asserted
  `ar->data_lock` should be held by callers, but **no caller actually
  held it**. This means the assertion was always wrong (or always
  disabled), and the field `arsta->peer_ps_state` was being accessed
  without the required lock protection.
- **Reviewed-by**: Baochen Qiang from Qualcomm reviewed it, lending
  credibility
- The commit references that `core.h` documents `peer_ps_state` as
  protected by `ar->data_lock`, and other accessors properly acquire it
  — meaning this was the only broken path.

### 2. Code Change Analysis

The change is minimal and surgical:

1. **Removes** `lockdep_assert_held(&ar->data_lock)` — the callers never
   held this lock, so the assertion was incorrect (and likely only
   checked with CONFIG_LOCKDEP enabled, which is why it didn't always
   trigger)

2. **Adds** `spin_lock_bh(&ar->data_lock)` /
   `spin_unlock_bh(&ar->data_lock)` around the single line
   `arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state)` — this is
   the actual fix, properly protecting the field with the documented
   lock

The lock scope is minimal — only around the single write to
`peer_ps_state`, placed after the RCU-protected station lookup and
before the RCU read unlock. This is clean and correct.

### 3. Bug Classification

This is a **data race / missing synchronization** bug:
- The field `peer_ps_state` is documented as requiring `ar->data_lock`
  protection
- Other readers/writers of this field properly acquire the lock
- This WMI event handler was the only path that didn't hold the lock
- Without the lock, concurrent reads (from
  `ath10k_dbg_sta_read_peer_ps_state`) and writes could race, leading to
  torn reads or inconsistent state

### 4. Scope and Risk Assessment

- **Lines changed**: ~4 lines effective (remove 2 lines, add 3 lines
  including lock/unlock)
- **Files changed**: 1 file (`drivers/net/wireless/ath/ath10k/wmi.c`)
- **Risk**: Very low. The change adds proper locking around a single
  field access, following the established pattern used by all other
  accessors. The lock is `spin_lock_bh`, which is safe in this softirq
  context.
- **Could it break something?** Extremely unlikely — it adds a lock that
  was already supposed to be held, and uses the same locking pattern as
  other paths in the driver.

### 5. User Impact

- **Affected hardware**: ath10k WiFi devices (Qualcomm 802.11ac chipsets
  — very common in laptops and embedded systems)
- **Trigger**: WMI peer power-save state change events from firmware
- **Consequence of bug**: Data race on `peer_ps_state` field. While this
  is a 32-bit field and the race may not always cause visible corruption
  on most architectures, it violates the documented locking contract and
  could cause issues with lockdep-enabled kernels (warnings/splats). On
  architectures without atomic 32-bit writes, it could cause torn reads.
- **Severity**: Medium — it's a real locking bug in a commonly-used WiFi
  driver

### 6. Stability Indicators

- Reviewed by Qualcomm engineer (Baochen Qiang)
- Accepted by the ath10k maintainer (Jeff Johnson)
- Small, obvious, and following established patterns in the same driver

### 7. Dependency Check

- No dependencies on other commits
- The code being modified has existed in ath10k for a long time (the
  `lockdep_assert_held` suggests the locking was always intended but
  never correctly implemented in this path)
- Should apply cleanly to any stable tree that has the ath10k driver
  with this function

### 8. Stable Kernel Criteria

- **Obviously correct?** Yes — adds the documented lock around a field
  access
- **Fixes a real bug?** Yes — data race / missing synchronization
- **Small and contained?** Yes — 4 lines in 1 file
- **No new features?** Correct — pure bug fix
- **Tested?** Reviewed by subsystem experts, accepted by maintainer

### Conclusion

This is a textbook stable-worthy fix: a small, surgical correction to a
locking bug in a widely-used WiFi driver. It properly adds the lock that
was always documented as required but never acquired in this code path.
The risk is minimal and the fix follows established patterns in the same
driver.

**YES**

 drivers/net/wireless/ath/ath10k/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index b4aad6604d6d9..ce22141e5efd9 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5289,8 +5289,6 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
 	struct ath10k_sta *arsta;
 	u8 peer_addr[ETH_ALEN];
 
-	lockdep_assert_held(&ar->data_lock);
-
 	ev = (struct wmi_peer_sta_ps_state_chg_event *)skb->data;
 	ether_addr_copy(peer_addr, ev->peer_macaddr.addr);
 
@@ -5305,7 +5303,9 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
 	}
 
 	arsta = (struct ath10k_sta *)sta->drv_priv;
+	spin_lock_bh(&ar->data_lock);
 	arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state);
+	spin_unlock_bh(&ar->data_lock);
 
 exit:
 	rcu_read_unlock();
-- 
2.51.0


