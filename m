Return-Path: <linux-wireless+bounces-30511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CFCFF64F
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E49C3026F16
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283013A89D4;
	Wed,  7 Jan 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9RdXJ7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4F3A1CF4;
	Wed,  7 Jan 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801221; cv=none; b=D2fm5fyJoVwfrQWoPVOBnQqtNWsI1roTeGLP2lIpmiaIGs+l70w278tg7JW5QOJt0iZVNJJrFn8snhyZW8avlbl8GvBDIvJ3RyYL1Tpitpn4zJE2FoaxXYrkboRecTS+HuMTzabg3RyPyk5g5QpemI8qVXd7abLDhfOzWBoJxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801221; c=relaxed/simple;
	bh=CO5+tSdOQc0WuSROBg3qtnQEPnHZ8ivRvTUTNMMwSTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIjTb03ztTYyeoABnCK/aq24cYPGA/1AqWkXhEZzlDUgg2E78pUlIggnjfbke5wVQJ5yOpPg9fO+wwwpTQpYXqricIQDaRsSe51VEx8w9AQqgSJSd/WU88nP0lyHEXFDpIj54hSLPwG28soYMPVIFlVEumjbWtXgmdHADxUJs+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9RdXJ7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6D5C4CEF7;
	Wed,  7 Jan 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767801218;
	bh=CO5+tSdOQc0WuSROBg3qtnQEPnHZ8ivRvTUTNMMwSTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9RdXJ7/PYTDjlYtYoFRlHcnJW6xSn38hZZgW+RIXlhYcG7KdtO9Potmyi4ZCDH+r
	 Y+ttzlCx5Ib14ZIwYfu/Zl3MvlUDENzR3L3jw/K7Oz2583vGtWp2ndIIBsneh79Myr
	 OSZEYjagZ2wPNtu+ckxLhhvZRkm8moqDV0bZc3Yi+t2juuk/iY9gg8WHV9OMaUy1U3
	 bpLyGXdGbbqFr+d32F9Dvy6zrP3N9km6AphYlJ3frEosXEFnDNC2rwI2C+h2wiW3/h
	 es/a5sLDuYF2JjcSPgfGfNVi4Sn50XFIkQY6vFGqM/KicLqUUbBz7Q/qh086Hyl57I
	 LzbgHe8gfcuYg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Moon Hee Lee <moonhee.lee.ca@gmail.com>,
	syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] wifi: mac80211: ocb: skip rx_no_sta when interface is not joined
Date: Wed,  7 Jan 2026 10:53:08 -0500
Message-ID: <20260107155329.4063936-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107155329.4063936-1-sashal@kernel.org>
References: <20260107155329.4063936-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.3
Content-Transfer-Encoding: 8bit

From: Moon Hee Lee <moonhee.lee.ca@gmail.com>

[ Upstream commit ff4071c60018a668249dc6a2df7d16330543540e ]

ieee80211_ocb_rx_no_sta() assumes a valid channel context, which is only
present after JOIN_OCB.

RX may run before JOIN_OCB is executed, in which case the OCB interface
is not operational. Skip RX peer handling when the interface is not
joined to avoid warnings in the RX path.

Reported-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b364457b2d1d4e4a3054
Tested-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Link: https://patch.msgid.link/20251216035932.18332-1-moonhee.lee.ca@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

OCB support has been in the kernel since 2014 - it exists in all
supported stable trees.

## 3. CLASSIFICATION

- **Type:** Bug fix - fixes kernel warnings triggered by a race
  condition
- **Category:** Not an exception category - straightforward bug fix
- **Security:** Not directly security-related, but the WARN_ON_ONCE
  could trigger panic on systems with `panic_on_warn=1`

## 4. SCOPE AND RISK ASSESSMENT

- **Size:** Minimal - 3 lines added (one check + early return)
- **Files:** 1 file (net/mac80211/ocb.c)
- **Complexity:** Very low - simple flag check before proceeding
- **Risk:** Extremely low
  - Uses existing `joined` flag already used elsewhere in the same file
  - Follows established pattern (identical check exists at line 126)
  - Cannot break existing functionality - before join, nothing should
    happen anyway

## 5. USER IMPACT

- **Affected users:** OCB mode users (vehicle-to-vehicle communications,
  IEEE 802.11p)
- **Severity:** Medium - causes kernel warnings in RX path
- **Systems with `panic_on_warn=1`:** This could cause system crashes
- **Reproducibility:** Confirmed reproducible by syzkaller

## 6. STABILITY INDICATORS

- **Tested-by: syzbot** - Fix verified by the same fuzzer that found the
  bug
- **Maintainer sign-off:** Johannes Berg (mac80211 maintainer)
- **Pattern established:** Same check pattern already used in
  `ieee80211_ocb_work()`

## 7. DEPENDENCY CHECK

- No dependencies on other commits
- Uses existing `joined` flag (in kernel since 2014)
- Will apply cleanly to any stable tree with OCB support

## SUMMARY

This is an ideal stable backport candidate:

1. **Obviously correct:** Simple early-return check using existing flag,
   follows pattern already in the code
2. **Fixes real bug:** Syzbot-reported, reproducible kernel warnings
3. **Small and contained:** 3 lines, single file, no side effects
4. **No new features:** Just adds a defensive check
5. **Low risk:** Cannot break anything - OCB shouldn't process RX before
   joining anyway
6. **Tested:** Verified by syzbot

The fix prevents kernel warnings (and potential crashes on
`panic_on_warn` systems) when RX frames arrive on an OCB interface
before it has finished the join operation. It's a simple, surgical fix
with no risk of regression.

**YES**

 net/mac80211/ocb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index a5d4358f122a..ebb4f4d88c23 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -47,6 +47,9 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	int band;
 
+	if (!ifocb->joined)
+		return;
+
 	/* XXX: Consider removing the least recently used entry and
 	 *      allow new one to be added.
 	 */
-- 
2.51.0


