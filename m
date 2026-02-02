Return-Path: <linux-wireless+bounces-31481-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF6SNl8cgWm0EAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31481-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 22:51:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D6DD1DBC
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A159C307752C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657D33161B8;
	Mon,  2 Feb 2026 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnwqj4Na"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B30314A95;
	Mon,  2 Feb 2026 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068846; cv=none; b=Au33yWLuHd8yq0YSS4Z/XLdhBDUJvmJHl9brFR6ab+9Mk/7/h1LOwFTucOB56psl+sI/FRtm75qKPZZ5D7nG4nHHEGH61TRaUxa3dR3QlUvvS2v/8tz8lZHg0vufrtlzrD1cDlgIvGpB+3JOqpo+wdLuwooAoQL+kXBhAtKs5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068846; c=relaxed/simple;
	bh=Igh4cD88rLtWgMOfnORH/Vs+R3zOyCvczFSHP9CmAgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR1o8lmCQLScKr/4QMaASCPxDnwMYIM9p71q3uoQaK2aFWP8Q6Gl6p/D0XvSpLIRcFG97IpTTTqj5ilbFHNCYPrvQjntR+KgNjNP0TYjRtXb6jfyTor12glyd61tC7q7BG3S8Q5x4pAMMhNEqq29xk9NLWusneHD4dEYXqhbjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnwqj4Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E67C2BC86;
	Mon,  2 Feb 2026 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770068846;
	bh=Igh4cD88rLtWgMOfnORH/Vs+R3zOyCvczFSHP9CmAgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnwqj4NaxcjjQLXMZHQPozOZrZwY0EVYxOXePJChekMCaf8fYjPKYGy1QFa5t0lo1
	 LpOwMUtI7cjpKg6ccqJ1+KPIX5rD+lt/LkZw6j/HqfG1CKilKslQLlsNaK0EJbabKA
	 vDcDldAcNVxNO7Iqmr9Bs9ijHV1DIAQJW6wSAzzhKFsizS1yf9fNAepUgmPm65/Aah
	 h83novl3wN8YO36WTD/R8XYc9wV2keez6Zya2QR3wIj+/q89DQD9RtLUOCkzl1CiiP
	 G/pQ78lEZ48O9ySgRToaXsWyPbfB6kPgVqvmmdyrMqnwAJoXdkcc3XiwGQFVm8bRKe
	 HNs27YXY1F1wg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] wifi: mac80211: correctly check if CSA is active
Date: Mon,  2 Feb 2026 16:46:16 -0500
Message-ID: <20260202214643.212290-21-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202214643.212290-1-sashal@kernel.org>
References: <20260202214643.212290-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31481-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50D6DD1DBC
X-Rspamd-Action: no action

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit db1d0b6ab11f612ea8a327663a578c8946efeee9 ]

We are not adding an interface if an existing one is doing CSA.
But the check won't work for MLO station interfaces, since for those,
vif->bss_conf is zeroed out.
Fix this by checking if any link of the vif has an active CSA.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260111191912.7ceff62fc561.Ia38d27f42684d1cfd82d930d232bd5dea6ab9282@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me analyze this commit
comprehensively.

## Analysis

### 1. COMMIT MESSAGE ANALYSIS

**Subject**: "wifi: mac80211: correctly check if CSA is active"

The commit clearly describes a bug fix - the existing CSA (Channel
Switch Announcement) check doesn't work properly for MLO (Multi-Link
Operation) station interfaces. The message explains:
- The problem: "the check won't work for MLO station interfaces, since
  for those, vif->bss_conf is zeroed out"
- The fix: "checking if any link of the vif has an active CSA"

**Tags present**:
- Reviewed-by: Johannes Berg (mac80211 maintainer) - strong credibility
  signal
- Signed-off-by: Miri Korenblit (Intel wireless developer)
- Link to mailing list

No explicit Fixes: tag, but that's expected for commits we're reviewing.

### 2. CODE CHANGE ANALYSIS

**The Bug:**
The original code at line 379:
```c
if (nsdata->vif.bss_conf.csa_active)
    return -EBUSY;
```

This check is used in `ieee80211_check_concurrent_iface()` to prevent
adding a new interface while an existing interface is performing a
channel switch operation.

**Why it's broken for MLO:**
For MLO (Multi-Link Operation) station interfaces introduced in WiFi 7
(802.11be):
- `vif->bss_conf` is zeroed out by design
- Each link has its own BSS configuration stored in `link_conf[link_id]`
- The CSA state (`csa_active`) is per-link, not per-VIF
- Checking `vif->bss_conf.csa_active` will always return `false` for MLO
  interfaces, even if one of the links is actively switching channels

**The Fix:**
```c
struct ieee80211_link_data *link;
...
for_each_link_data(nsdata, link) {
    if (link->conf->csa_active)
        return -EBUSY;
}
```

This properly iterates through all valid links and checks if ANY link
has an active CSA. The `for_each_link_data` macro:
- For non-MLO interfaces: iterates once with the single (deflink) link
- For MLO interfaces: iterates through all links with bits set in
  `valid_links`

**Technical mechanism**: The fix is correct because it unifies the check
- it works for both MLO and non-MLO interfaces while maintaining the
same semantics.

### 3. CLASSIFICATION

This is clearly a **bug fix**, not a new feature:
- The concurrent interface protection during CSA was always intended to
  work
- It just doesn't work for the newer MLO interface type
- This is a correctness fix for existing functionality

### 4. SCOPE AND RISK ASSESSMENT

**Lines changed**: Small - adds ~6 lines, removes 2 lines (net +4)
**Files touched**: 1 file (net/mac80211/iface.c)
**Complexity**: Low - simple loop iteration replacing a single field
access
**Subsystem**: mac80211 WiFi subsystem - widely used but WiFi-specific

**Risk level**: LOW
- The change is straightforward and the logic is sound
- The `for_each_link_data` macro is designed for exactly this use case
- Reviewed by Johannes Berg, the mac80211 maintainer
- Failure mode: If the fix doesn't work, we're no worse than before
  (still have the bug)

### 5. USER IMPACT

**Who is affected?**: Users with MLO-capable WiFi hardware (WiFi 7 /
802.11be devices)
**Severity**: Medium - Without this fix:
- A new interface could be incorrectly allowed to be added during an
  ongoing channel switch on an MLO interface
- This could cause interference, connectivity issues, or undefined
  behavior
- Channel switches are relatively rare events, so impact is somewhat
  limited

### 6. STABILITY INDICATORS

- **Reviewed-by**: Johannes Berg (mac80211 maintainer) - strong positive
  signal
- Author: Miri Korenblit from Intel - active wireless developer

### 7. DEPENDENCY CHECK

**Critical dependency**: This fix uses the `for_each_link_data` macro
which was introduced in commit f61c7b3d442be ("wifi: mac80211: Add link
iteration macro for link data") in kernel v6.16.

**Backport applicability**:
- **v6.16+**: Can be applied directly - has the macro
- **v6.1-v6.15**: Would require either:
  1. Backporting the `for_each_link_data` macro first, OR
  2. Writing an alternative fix using open-coded link iteration

MLO support was introduced in v6.1, so the bug exists in all kernels
v6.1 through current that have MLO station interface support.

### Summary

| Criteria | Assessment |
|----------|------------|
| Obviously correct | YES - simple iteration fix |
| Fixes real bug | YES - incorrect CSA check for MLO |
| Important issue | MEDIUM - affects interface addition during channel
switch |
| Small and contained | YES - 4 net lines changed |
| No new features | YES - fixes existing feature |
| Applies cleanly | DEPENDS - needs v6.16+ for macro dependency |

### VERDICT

This is a legitimate bug fix for MLO WiFi support:
- It fixes a real, demonstrable bug where CSA detection fails for MLO
  interfaces
- The fix is small, surgical, and well-reviewed
- It doesn't introduce new features or change APIs
- It improves correctness of existing functionality

**However**, there are important caveats:
1. The fix has a dependency on the `for_each_link_data` macro
   (introduced in v6.16)
2. For stable trees before v6.16, a backport would need the macro too or
   use an alternative approach
3. MLO is relatively new technology (WiFi 7), so the affected user base
   is smaller

Given that this fix:
- Is obviously correct and addresses a real bug
- Was reviewed by the subsystem maintainer
- Has low risk of regression
- Affects real user scenarios (channel switching during interface
  operations)

The fix is appropriate for stable backporting to kernels that have both
MLO support and the `for_each_link_data` macro (v6.16+). For older
stable trees (v6.1-v6.15), a modified backport with the macro or open-
coded iteration would be needed.

**YES**

 net/mac80211/iface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 0ca55b9655a7f..72c129478da08 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -350,6 +350,8 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 	/* we hold the RTNL here so can safely walk the list */
 	list_for_each_entry(nsdata, &local->interfaces, list) {
 		if (nsdata != sdata && ieee80211_sdata_running(nsdata)) {
+			struct ieee80211_link_data *link;
+
 			/*
 			 * Only OCB and monitor mode may coexist
 			 */
@@ -376,8 +378,10 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 			 * will not add another interface while any channel
 			 * switch is active.
 			 */
-			if (nsdata->vif.bss_conf.csa_active)
-				return -EBUSY;
+			for_each_link_data(nsdata, link) {
+				if (link->conf->csa_active)
+					return -EBUSY;
+			}
 
 			/*
 			 * The remaining checks are only performed for interfaces
-- 
2.51.0


