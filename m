Return-Path: <linux-wireless+bounces-31852-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLNvETHpkGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31852-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:29:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8C13D78A
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F253304565E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79C2D979F;
	Sat, 14 Feb 2026 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv5HTel7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67F28134C;
	Sat, 14 Feb 2026 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104345; cv=none; b=ujoZbnRlxbAtZRZNVSZGaiph00x+JR00fsHP5AIvzVpXiHOD0VtNoW5KtULqNvWwf+igwdMJ6lRFxM6ERjgBtgRwuJfaCSYFC1Qb8rDQIDGsLFSfucJpywbKwQVI51OieL3IClbAjMxRTTV4IcK7u0S1zfEQG3Za/+mBisnGbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104345; c=relaxed/simple;
	bh=WWRUjv1aa04zQ0r3bnU5uXtUjs+j3wZYFbB5YtLB2aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg+Px9XEi6ot9tGVKJI053G1KhQlgJHQi5PlYGrOqDYsWdGugKqXV37tHGUgQXp3JEcI1ad/3tvkpgfY1smMYWe4kFkbx3Y2xT/kM2kIK1qp2g89aAH8x9VIRvPu5jmv10q7VSAwAHVK4ebyc4FAKCqmIwOlsh9lgC4oQS/MORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv5HTel7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F98C19423;
	Sat, 14 Feb 2026 21:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104345;
	bh=WWRUjv1aa04zQ0r3bnU5uXtUjs+j3wZYFbB5YtLB2aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lv5HTel7qSVFi+jnlCijflUTfs+HzQ7wgF7zgIc/215kZV1jCkIzcD52MnZvP1LGb
	 9WjL9/pwe52x09ku6s7YOcuAL3z+Kv34H0ZFJm4SOKjW0Q83AXFiKisGMmeWExUswz
	 FdW+L/Agtr6ut2i1R2GIVX/V4KUo7be01udC6u5S3yhv1M/X99TpcD3eAGvsLvXws+
	 pJ3U14K0S0uZ1VZ3OxvmgUaKR3Z5OrLIj0kauRPyzPkrYED+rk1Ext+FfmEZZIq5cK
	 WfFE6FT1/5JHadIN3NqWWtWnn8aQee7xclj+9zbvgKVJ6JIYNs068TykAEvR4ZqS1e
	 5f3zV7YpNOWkg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: cfg80211: allow only one NAN interface, also in multi radio
Date: Sat, 14 Feb 2026 16:22:53 -0500
Message-ID: <20260214212452.782265-28-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31852-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: ABA8C13D78A
X-Rspamd-Action: no action

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit e69fda4d07701373354e52b0321bd40311d743d0 ]

According to Wi-Fi Aware (TM) 4.0 specification 2.8, A NAN device can
have one NAN management interface. This applies also to multi radio
devices.
The current code allows a driver to support more than one NAN interface,
if those are not in the same radio.

Fix it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260107135129.fdaecec0fe8a.I246b5ba6e9da3ec1481ff197e47f6ce0793d7118@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### Key Finding: Limited Stable Tree Applicability

The multi-radio interface combination checking (`combined_radio`
parameter) was introduced in commit `bd9813d13be43` which was merged in
the v6.13 cycle. This means:
- The bug being fixed **only exists in kernels 6.13+**
- Older stable trees (6.12.y, 6.6.y, 6.1.y, 5.15.y, etc.) don't have the
  multi-radio combination checking code, so they don't have this bug
- Only 6.13.y and later stable trees would need this fix

### Assessment

**What the fix does**: Removes an incorrect exemption that allowed
multi-radio Wi-Fi devices to declare support for multiple NAN
interfaces, violating the Wi-Fi Aware specification.

**Severity**: Low-to-medium. This is a validation/spec-compliance fix.
The practical impact depends on whether any driver actually tries to
register multiple NAN interfaces across radios. If they do, NAN behavior
could be undefined per spec. The fix prevents such invalid
configurations from being accepted.

**Risk**: Very low. The change is tiny (removes one condition), is in a
validation path, and can only make the kernel *stricter* (reject invalid
configurations that were previously accepted). It cannot introduce new
crashes or regressions.

**Meets stable criteria**:
- Small and contained: Yes (removes ~4 lines)
- Fixes a real bug: Yes (incorrect validation allowing spec-violating
  configurations)
- Obviously correct: Yes (reviewed by the wireless maintainer)
- No new features: Correct, it tightens existing validation

**Concerns**:
- Limited applicability (only 6.13+ stable trees)
- Low severity - this is spec compliance rather than a crash/corruption
  fix
- The practical impact is limited since it only matters if a driver
  declares >1 NAN interface across radios

This is a legitimate, low-risk bug fix that enforces correct Wi-Fi
specification compliance. While the severity is not high (no
crash/corruption), it's a clean, reviewed fix from the subsystem
maintainer that corrects incorrect behavior. It's applicable to recent
stable trees (6.13+) and carries essentially zero regression risk.

**YES**

 net/wireless/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9a420d627d3ce..2028bf5686f2b 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -661,12 +661,8 @@ int wiphy_verify_iface_combinations(struct wiphy *wiphy,
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-			/* Only a single NAN can be allowed, avoid this
-			 * check for multi-radio global combination, since it
-			 * hold the capabilities of all radio combinations.
-			 */
-			if (!combined_radio &&
-			    WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
+			/* Only a single NAN can be allowed */
+			if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-- 
2.51.0


