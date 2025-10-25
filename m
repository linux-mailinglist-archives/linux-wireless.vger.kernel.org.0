Return-Path: <linux-wireless+bounces-28256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44AAC097DF
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4961A6713B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC73093C4;
	Sat, 25 Oct 2025 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsM6OrVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E763043D4;
	Sat, 25 Oct 2025 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409134; cv=none; b=PdvU8QpaIIriFVuAm6aTo6WWu+e77VQMXm77jae1nulEJZQ9W02eUNGI66xKNj91r40bRGDgEQ77qeio7Px2nqHA9Mcm4E0LNQS8aAP3tsbgYCCB/C42uZ4OsXmgRN/OZZCFodMa4pSImBveex61DM3pgx526alMcX1RtxhTuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409134; c=relaxed/simple;
	bh=YHIXX4TJphinosFFaiwJz8/1JzRqAdezGn42xVWf6/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHxPwWtBmh0MVplfyQ49EKruos6pTBaR17OIlM+KnXTepLS/YHlT510PIB6SlWf+1Op6N1jdJGxqHRzs9G/uNBAVNdmKvkhevDuDtXgGOxqJasNlYzIFTbL4wJXWy/TEIv/m0iiakoBpcFgUH4UqIjsnB90El+U2X32QTRX1usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsM6OrVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B940C4CEF5;
	Sat, 25 Oct 2025 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409134;
	bh=YHIXX4TJphinosFFaiwJz8/1JzRqAdezGn42xVWf6/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsM6OrVCLc9lqirbcguIEyuyHw+QUCB6zIdVndFWaHifDmMeUEvCGqM+qPllyUu/4
	 nvVT7xJgWYNgivcx2xjTZT8SXM+E6x8ixsJxKjfgNBnROa8ddTXrpoDbAadc4tgtEm
	 shgvSp7GP7l0lI6RCpwOGvBUV/soy0vSCHTHZj3GalZLppiSE+7bz9lSGpaDfWzyKa
	 gyHififw9DSVZ6i+QqU4+SCnM5VbqbZgw0FZ1vA56d8YRKKl81BkkDHY87v+vS5tKn
	 Nfp0STBuv/wxus6fRQ3/G/3kjvJ4y7i/OsDT40XJKXH6emOcCTkcapCk91+qCLRqWu
	 WvBo+mJlHDGYA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] wifi: mac80211: Fix HE capabilities element check
Date: Sat, 25 Oct 2025 11:57:24 -0400
Message-ID: <20251025160905.3857885-213-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit ea928544f3215fdeac24d66bef85e10bb638b8c1 ]

The element data length check did not account for the extra
octet used for the extension ID. Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250907115109.8da0012e2286.I8c0c69a0011f7153c13b365b14dfef48cfe7c3e3@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What the patch changes
  - Tightens the HE capabilities IE length check in
    `ieee80211_max_rx_chains()` to account for the one-byte Extension
    ID:
    - Before: `if (!he_cap_elem || he_cap_elem->datalen <
      sizeof(*he_cap)) return chains;`
    - After:  `if (!he_cap_elem || he_cap_elem->datalen <
      sizeof(*he_cap) + 1) return chains;`
  - Location: `net/mac80211/mlme.c` in `ieee80211_max_rx_chains()`
    around the HE path (`cfg80211_find_ext_elem(...)`), see current tree
    at `net/mac80211/mlme.c:5741` and the nearby “skip one byte
    ext_tag_id” comment at `net/mac80211/mlme.c:5744`.

- Why this is correct
  - For extended IEs, `cfg80211_find_ext_elem()` matches the extended
    EID at offset 0 of the element data (so `data[0]` is the Extension
    ID), see `include/net/cfg80211.h:7282`. The returned `struct
    element` layout is `id`, `datalen`, `data[]` (see
    `include/linux/ieee80211.h:5220`), and for an extended IE the first
    byte of `data[]` is the ext ID.
  - The code immediately “skips” this byte (`he_cap = (void
    *)(he_cap_elem->data + 1)`), so the initial length check must
    require at least `1 + sizeof(struct ieee80211_he_cap_elem)` to
    ensure the entire HE capability fixed fields are present. The
    original check only required `sizeof(*he_cap)`, which is off by one
    and inconsistent with the subsequent “invalid HE IE” check that
    already uses `1 + mcs_nss_size + sizeof(*he_cap)` at
    `net/mac80211/mlme.c:5749`.
  - Consistency with other callers: in `net/wireless/nl80211.c`, the HE
    capability parsing uses the correct “+1” rule (`cap->datalen >=
    sizeof(*params->he_cap) + 1`) before skipping the ext ID
    (`net/wireless/nl80211.c:6402-6408`). This patch aligns mac80211
    with that established pattern.

- Bug impact and risk
  - Impact: Without the “+1”, the parser may treat a truncated HE
    capability (exactly `sizeof(*he_cap)` bytes total, including the
    extension ID) as if it had the full fixed portion after skipping the
    ext ID. This can lead to mis-parse or at minimum unnecessary
    processing of invalid data before bailing at the later check. It
    risks reading fields relative to the HE cap beyond the element’s
    logical bounds, even if still within the overall IE buffer.
  - User-visible effect: `ieee80211_max_rx_chains()` is used to derive
    `link->needed_rx_chains` during association/connection
    (`net/mac80211/mlme.c:6103`). Correctly rejecting invalid/truncated
    HE IEs avoids computing chain counts from malformed data, preventing
    subtle misconfiguration and ensuring safe fallback to HT/VHT-derived
    limits.
  - Scope and risk: One-line guard fix in mac80211 parsing path. No
    API/ABI changes, no architectural refactoring. Behavior for valid
    IEs is unchanged; malformed IEs are handled more robustly.

- Stable backport suitability
  - Fixes a real parsing bug with potential robustness/safety
    implications.
  - Minimal, well-scoped change with very low regression risk.
  - Aligns mac80211 with correct extended IE handling used elsewhere in
    the tree, improving consistency.
  - Touches a contained part of mac80211 and does not introduce new
    features or architectural changes.

Given these points, this is a textbook stable backport candidate.

 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0f2d2fec05426..d0af917a40b34 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5733,7 +5733,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
 					     ies->data, ies->len);
 
-	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap))
+	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap) + 1)
 		return chains;
 
 	/* skip one byte ext_tag_id */
-- 
2.51.0


