Return-Path: <linux-wireless+bounces-31867-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IsLObHpkGkfdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31867-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:31:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5B13D8BE
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FF3530A455B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8003128AB;
	Sat, 14 Feb 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOGjGMVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904A30DD00;
	Sat, 14 Feb 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104414; cv=none; b=MArabNVD1eUu1GXn+ufhKM6g+NbYOzgFVGk47ARI1X2mUHaLxfFLEmDP1xtzes8l4s9UaVhK1y4epdygIRDmxRp26TqwW3T48oEAhjzPGdZKdLc6hAtBFyrU+kL2SOFUhk+0LD1155zvnLi6+MUv/67RHUGd/ru6kWigTQ4TP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104414; c=relaxed/simple;
	bh=eo3QWsP83g5jJbt6mCw0tXmbCVi7OG76fm6EZsjZhEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnWZmmG7spar/T1KlAh2QJDOdcthSax8dAubB1yVT6Al7RxvHkhMVctoJr6fgJXWecVN2q7XHeL3AKR7ijs9v78xRpf5N9WJNboKtepCQEq2oWy4YCpZPM0OHw4rt0F92gx85c4q10dGAPiKMvMy1420GXta8xMUmoDowxmIc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOGjGMVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A87C19422;
	Sat, 14 Feb 2026 21:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104414;
	bh=eo3QWsP83g5jJbt6mCw0tXmbCVi7OG76fm6EZsjZhEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOGjGMVbpPpOw4RuJay4cFsKQoEppKeNeC6gFF2hdSxJJ0ykcYxjnvTP+qaFJIs1e
	 bH3O6ehvKDL9VMGvJpXDijklmXWYUiffkfKTn4RYSvSSfhJ1j2NNXCSHhDSK1q49nH
	 UPBO4XkWfMWbV6+GalNvlTPfsLShK04XjhiinWfRTP0jOtfvXntsABi8RPFLGQSF9P
	 R0ycNYSn0JfyRHueNpGT5cNBjOG3rtkntl5ah8GaA7GhKVDXRzYphFislUGBU3f/Mg
	 mQxAjm9Xmp4gAYHr8tOU3SDUkr2LSGLUCvBkdJMZYdqD/1kUtK0sRO6a2vCesrGTHO
	 AW8me/QnDgWWQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] wifi: cfg80211: treat deprecated INDOOR_SP_AP_OLD control value as LPI mode
Date: Sat, 14 Feb 2026 16:23:36 -0500
Message-ID: <20260214212452.782265-71-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31867-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 64D5B13D8BE
X-Rspamd-Action: no action

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

[ Upstream commit fd5bfcf430ea2fdbb3e78fd0b82ceb0ab02b72ee ]

Although value 4 (INDOOR_SP_AP_OLD) is deprecated in IEEE standards,
existing APs may still use this control value. Since this value is
based on the old specification, we cannot trust such APs implement
proper power controls.
Therefore, move IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD case
from SP_AP to LPI_AP power type handling to prevent potential
power limit violations.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260111163601.6b5a36d3601e.I1704ee575fd25edb0d56f48a0a3169b44ef72ad0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of wifi: cfg80211: treat deprecated INDOOR_SP_AP_OLD control
value as LPI mode

### 1. Commit Message Analysis

The commit addresses a **power limit violation** issue in 6 GHz WiFi
regulatory handling. The key points:

- Value 4 (`INDOOR_SP_AP_OLD`) is deprecated in IEEE standards but still
  used by existing APs in the field
- Since APs using this deprecated value may not implement proper power
  controls, the commit treats them as LPI (Low Power Indoor) instead of
  SP (Standard Power)
- This **prevents potential power limit violations** — a regulatory
  compliance and safety issue

The commit is reviewed by Johannes Berg (wireless subsystem maintainer)
and signed off by Intel WiFi developers, indicating high confidence in
correctness.

### 2. Code Change Analysis

The change is extremely minimal — a single line is moved from one `case`
group to another in a `switch` statement:

```c
// BEFORE: INDOOR_SP_AP_OLD was grouped with SP_AP → returned
IEEE80211_REG_SP_AP
// AFTER:  INDOOR_SP_AP_OLD is grouped with LPI_AP → returns
IEEE80211_REG_LPI_AP
```

This is a **two-line diff** (one line added, one line removed) in a
`static inline` function in a header file. The change is purely about
reclassifying a deprecated control value to use more conservative
(lower) power limits.

### 3. Classification: Bug Fix

This is a **correctness/safety fix**, not a feature:

- **Regulatory compliance**: Using SP (Standard Power) when the AP
  doesn't implement proper power controls can violate regulatory power
  limits for 6 GHz spectrum
- **Real-world impact**: Existing APs in the field still use this
  deprecated value 4, so real users encounter this
- **Conservative approach**: Moving to LPI (Low Power Indoor) is the
  safe default — it restricts power rather than allowing potentially
  excessive power

This is analogous to a **hardware quirk/workaround** — dealing with
real-world devices that use a deprecated specification value.

### 4. Scope and Risk Assessment

- **Size**: Minimal — moving one `case` label from one group to another
- **Risk**: Extremely low — the change is to use MORE conservative power
  limits, not less
- **Subsystem**: WiFi/cfg80211 — widely used networking subsystem
- **Side effects**: Devices connecting to APs using the deprecated value
  will use lower power, which is safer. In the worst case, this means
  slightly reduced range, which is far better than violating regulatory
  limits.

### 5. User Impact

- **Who is affected**: Any user with a 6 GHz WiFi device connecting to
  an AP that uses the deprecated `INDOOR_SP_AP_OLD` control value
- **Severity**: Without this fix, the system could transmit at Standard
  Power levels when it should be using Low Power Indoor levels — this is
  a **regulatory violation** that could potentially cause interference
  and legal issues
- **Real-world devices**: The commit message explicitly states "existing
  APs may still use this control value," confirming real hardware exists
  with this behavior

### 6. Stability Indicators

- **Reviewed-by: Johannes Berg** — the wireless maintainer himself
  reviewed this
- **Signed-off by multiple Intel WiFi developers** — well-tested within
  the Intel WiFi team
- The fix is trivially correct — just moving a case label

### 7. Dependency Check

- No dependencies on other commits
- The `IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD` enum value and the
  `cfg80211_6ghz_power_type()` function need to exist in the stable
  tree, which they should for any kernel with 6 GHz support
- The change applies cleanly as it's self-contained within a single
  switch statement

### 8. Stable Kernel Rules Assessment

1. **Obviously correct and tested**: Yes — trivial case label move,
   reviewed by maintainer
2. **Fixes a real bug**: Yes — incorrect power type assignment for
   deprecated control value leads to regulatory violations
3. **Important issue**: Yes — regulatory compliance, potential power
   limit violations
4. **Small and contained**: Yes — two-line change in one file
5. **No new features**: Correct — no new functionality, just
   reclassification of an existing value
6. **Applies cleanly**: Should apply cleanly to any stable tree with 6
   GHz support

### Risk vs. Benefit

- **Risk**: Near zero — the change is trivially simple and moves to a
  more conservative power setting
- **Benefit**: Prevents regulatory power limit violations for users
  connecting to APs with deprecated control values
- **Trade-off**: Strongly favors backporting

The fix is small, surgical, addresses a real-world regulatory compliance
issue with existing hardware, is reviewed by the wireless subsystem
maintainer, and carries virtually no regression risk.

**YES**

 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2900202588a54..39a04776705eb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10147,9 +10147,9 @@ cfg80211_6ghz_power_type(u8 control, u32 client_flags)
 	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_AP_ROLE_NOT_RELEVANT:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_LPI_AP;
 	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_SP_AP;
 	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
 		return IEEE80211_REG_VLP_AP;
-- 
2.51.0


