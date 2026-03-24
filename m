Return-Path: <linux-wireless+bounces-33772-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCR5OyR0wmmncwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33772-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 12:23:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89593307390
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 12:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E80D530A02F7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA13F166A;
	Tue, 24 Mar 2026 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuJWyZ5h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F03F0AB5;
	Tue, 24 Mar 2026 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351190; cv=none; b=IgJA9UPFTbnr8mG3Tzgoy5Zvnbe7c5FpLFFC+PxlBuWpl7Bd6YHyTFCTO4zoG0aQuZh6vRO/AZ8y9napTZBc2PWyufMwyBnKX+5M3k1fqd226FAROHcFlwFS7RC82NjNvYPWo/N5vkk34dc7uFkckmathOUz7S50lQ+DQnXwY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351190; c=relaxed/simple;
	bh=6ibyUs+SMMYNaaSILv6M3iISyLlRy+whlfy5hBjAgcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J16BuYRbSSBu6E7eUWRSppHW5DA0LFFnniN5cDinDzXAWWh/SYS1jnDyvpuf/iLAF/D5SaLiJoE2LVjJmy3a0m/VYYP/GjTsbcKKrejTmyK17LoQAR0oreRzbxygAkRTLNUetm7mV6pWCNI9plql0MgT9HLVaBlDWTBKZuImlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuJWyZ5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CBEC4AF0B;
	Tue, 24 Mar 2026 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351189;
	bh=6ibyUs+SMMYNaaSILv6M3iISyLlRy+whlfy5hBjAgcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuJWyZ5hhW9TY8e15rg5Zw3UgBnc4/IyVCNxCZ3rcKpLQ0KxkdjJ1lll5Hp3AnliI
	 f6AcxnXt0j4ZRfsimmNSgh+q6NKv37a9swHVXJjJQVK0g0RfTENdcKd6fqPYufXTuq
	 t0ewLeW/x1ajQQHJH3/FaBuG4z3hlNK1IJx+9oUwcmhHqtMQ3f1zSWAb9pwBr63jwm
	 8JXm3YRD1UoG/ro+Z5rBTvJAG/j7PUG0CJNGuin8liZlQroW+Hluuf79mZ3Mlv8sCF
	 EpLYyxCth3/KYCVIoKiDTBjkCewjPHNxXmKoa02vuD3nTq9HFqHaqQAO/bG+7Wwemz
	 H/kfjvAF1i7Yg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Tue, 24 Mar 2026 07:19:21 -0400
Message-ID: <20260324111931.3257972-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324111931.3257972-1-sashal@kernel.org>
References: <20260324111931.3257972-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,sipsolutions.net,intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33772-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,56b6a844a4ea74487b7b];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,syzkaller.appspot.com:url,intel.com:email]
X-Rspamd-Queue-Id: 89593307390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit 7d73872d949c488a1d7c308031d6a9d89b5e0a8b ]

When NL80211_TDLS_ENABLE_LINK is called, the code only checks if the
station exists but not whether it is actually a TDLS station. This
allows the operation to proceed for non-TDLS stations, causing
unintended side effects like modifying channel context and HT
protection before failing.

Add a check for sta->sta.tdls early in the ENABLE_LINK case, before
any side effects occur, to ensure the operation is only allowed for
actual TDLS peers.

Reported-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=56b6a844a4ea74487b7b
Tested-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Link: https://patch.msgid.link/20260313092417.520807-1-kartikey406@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Before commit `076fc8775dafe` (2023), the check was `if (!sta) { ret =
-ENOLINK; break; }`. In older stable trees (5.15, 5.10, 5.4), the fix
would need to be adapted to this older pattern, but it's still trivial:
change `if (!sta)` to `if (!sta || !sta->sta.tdls)`. The logic is
identical.

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: Subsystem Criticality
- **Subsystem**: wifi/mac80211 — core wireless networking stack
- **Criticality**: IMPORTANT — used by all Linux systems with WiFi
  hardware
- TDLS (Tunneled Direct Link Setup) is a standard WiFi feature used for
  direct device-to-device communication

### Step 7.2: Subsystem Activity
mac80211/tdls.c has moderate activity, with both bug fixes and ongoing
development.

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All Linux users with WiFi hardware that supports TDLS (most modern WiFi
devices). Reachable from userspace via netlink.

### Step 8.2: Trigger Conditions
- Triggered via `NL80211_CMD_TDLS_OPER` with `NL80211_TDLS_ENABLE_LINK`
  for a non-TDLS station
- Can be triggered by an **unprivileged local user** with appropriate
  netlink access (or by a local attacker)
- syzbot found and reproduced this reliably

### Step 8.3: Failure Mode Severity
- **WARN_ON_ONCE** triggered at tdls.c:1460 — kernel warning
- **Unintended side effects**: channel context and HT protection
  modified for non-TDLS station — this could corrupt WiFi connection
  state
- Severity: **MEDIUM-HIGH** (WARN + potential state corruption via
  userspace-reachable path)

### Step 8.4: Risk-Benefit
- **Benefit**: HIGH — prevents userspace-triggerable WARN and state
  corruption in WiFi subsystem; affects all stable trees
- **Risk**: VERY LOW — single additional boolean check, obviously
  correct, maintainer-suggested
- **Ratio**: Excellent — minimal risk, clear benefit

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Compilation

**FOR backporting:**
- Fixes a syzbot-reported, reproducible bug reachable from userspace
- Bug exists in ALL active stable trees (since 2014)
- Single-line, obviously correct fix
- Suggested by subsystem maintainer (Johannes Berg)
- Tested by syzbot (confirmed fix)
- Prevents WARN_ON_ONCE and unintended WiFi state modification
- Zero regression risk
- Clean apply expected (trivial adaptation for older trees)

**AGAINST backporting:**
- (None significant)

### Step 9.2: Stable Rules Checklist
1. **Obviously correct and tested?** YES — one additional condition,
   tested by syzbot
2. **Fixes a real bug?** YES — syzbot-reported, WARN + state corruption
3. **Important issue?** YES — userspace-reachable, affects WiFi state
4. **Small and contained?** YES — 1 line changed
5. **No new features/APIs?** Correct — pure validation fix
6. **Can apply to stable?** YES — trivial adaptation needed for pre-6.6
   trees

### Step 9.3: Exception Categories
Not an exception category — this is a straightforward bug fix that meets
standard stable criteria.

### Step 9.4: Decision
Clear YES. This is a textbook stable backport candidate.

## Verification

- **[Phase 1]** Parsed tags: Reported-by syzbot, Tested-by syzbot,
  Suggested-by Johannes Berg (maintainer), Signed-off-by Johannes Berg
- **[Phase 2]** Diff analysis: 1 line modified — added `||
  !sta->sta.tdls` to existing NULL check in `ieee80211_tdls_oper()`
  ENABLE_LINK case
- **[Phase 3]** git blame: buggy code introduced in commit
  `95224fe83e5e78` (2014, v3.16 era), present in all stable trees
- **[Phase 3]** git show `076fc8775dafe`: confirmed older trees have
  slightly different code structure (`if (!sta) { ret = -ENOLINK; break;
  }`) but fix is trivially adaptable
- **[Phase 3]** Related commit `16ecdab5446f1`: another syzbot-reported
  TDLS validation fix, independent of this one
- **[Phase 4]** Syzbot bug report: confirmed affects Linux 5.4, 5.10,
  5.15, 6.1, 6.6; crash is WARN_ON_ONCE in ieee80211_tdls_oper
- **[Phase 4]** Lore: v2 patch, approach suggested by Johannes Berg; no
  NAKs or concerns found
- **[Phase 5]** `ieee80211_tdls_oper` registered via `.tdls_oper` in
  cfg.c:5598, reachable from userspace via NL80211_CMD_TDLS_OPER netlink
- **[Phase 6]** Code exists in all active stable trees (bug from 2014)
- **[Phase 6]** Backport: clean apply on 6.x trees; trivial context
  adaptation needed for 5.x trees
- **[Phase 8]** Failure mode: WARN_ON_ONCE + unintended channel/HT
  protection state modification; severity MEDIUM-HIGH; userspace-
  triggerable

**YES**

 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index dbbfe2d6842fb..1dca2fae05a52 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1449,7 +1449,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 		}
 
 		sta = sta_info_get(sdata, peer);
-		if (!sta)
+		if (!sta || !sta->sta.tdls)
 			return -ENOLINK;
 
 		iee80211_tdls_recalc_chanctx(sdata, sta);
-- 
2.51.0


