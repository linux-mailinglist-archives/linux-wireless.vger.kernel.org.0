Return-Path: <linux-wireless+bounces-28257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8581C0992C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E55A74EE8DC
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332330ACE3;
	Sat, 25 Oct 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVSdwaj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DB2FC893;
	Sat, 25 Oct 2025 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409193; cv=none; b=pwEIhbDKNycxB0F5jGLQyYJsv3iFIpPCuKoeNYAihG3jNjR4Q/3aauxQoBm+ivYxaM87KZhWBbyFIydHpnSjIf8RJd8kjxb/35gsPaVJCo2+U4PuarWPrrT4RUf6neiMRoNaGTVRSN4P1QB5elsWH9nPTfL33ZmZi61tTTKfJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409193; c=relaxed/simple;
	bh=DSgj7znKqFNXPi5aWGyyUsGmRujf5oyPa4uzTCW+9TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tryDbXJfYRbzaXTomf6vh2i4y7mFirsoKQ6kNTow5yb/7d/PLWL1oxravK3YUYmxfm8oZMMPgkwNCGKHYYgk6ThCaTukL6/cpcgFbFZQl7AjJf5Wt1B7r0LMFL4kY51tOsrLgnamO0DJLh9GXmMJ4Eergowmn1sv1dHd66k7GHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVSdwaj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050F2C113D0;
	Sat, 25 Oct 2025 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409192;
	bh=DSgj7znKqFNXPi5aWGyyUsGmRujf5oyPa4uzTCW+9TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVSdwaj5YvO6tLCmEKJVuVbkxXsdEAAupFBPMLv8OhXLV9CvzEqjbg28jBXeh0dYj
	 2P7q6f9LC/TrnhxYGoDWsklnswnR12SNWWTN2XkyZ49Zf86vkc8MbL3Q1Tq1oajCWs
	 IlbjMQXp1Otb9jOH8HIAJ6BJ4S/BHqLynCVBOo+Z+8M8T0gx0tShApXMKnGjohG6NE
	 e3FfZ61+dpx/ZmsjUdmHenCzZdcAofZbl8NvxHH6Q2Xj6JEYB/+9yb1TvsQe9c314Z
	 U+UM9J9LlQi2WeGiXQaUpGwFSRzJBh1AQUy4LMOKBySr2yQJSfQ/M91twKtbQ9eT0D
	 9TRWdCwN2+iUw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: mac80211: count reg connection element in the size
Date: Sat, 25 Oct 2025 11:57:48 -0400
Message-ID: <20251025160905.3857885-237-sashal@kernel.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 1373f94148a5adac2f42c8ba9771105624fe4af0 ]

We currently don't count the reg connection length in the per-link
capability length. Fix it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250826202512.b14fc82f736b.I03442382e8a07f6f9836bcdac2e22ce8afbe6a21@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What the change fixes: The size estimator for per-link capability
  elements in association/ML frames failed to account for the 6 GHz
  “regulatory connectivity” element. The patch adds 4 bytes for this
  element when operating on 6 GHz, ensuring the pre-allocation size
  matches what is actually written.
  - Change site: net/mac80211/mlme.c:2125 adds the missing size
    accounting in `ieee80211_link_common_elems_size(...)`, specifically:
    - Adds `size += 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);` and
      now also
    - Adds `size += 4; /* reg connection */` for 6 GHz
      (net/mac80211/mlme.c:2125–2129).
- Why it matters: The element is always emitted for non-AP STAs on 6 GHz
  and has a fixed size of 4 bytes, so not counting it underestimates the
  SKB size and can lead to tailroom underruns.
  - The element writer `ieee80211_put_reg_conn(...)` emits exactly 4
    bytes (Extension IE header + ext ID + 1-octet value):
    net/mac80211/util.c:2569–2573.
  - This writer is called for 6 GHz links in
    `ieee80211_add_link_elems(...)`: net/mac80211/mlme.c:1876–1880.
- Where the size is used: The total buffer for management frames is
  precomputed and passed to `alloc_skb(size, GFP_KERNEL)`.
  Underestimation here risks overrun when later appending IEs.
  - Association request path: `ieee80211_send_assoc(...)` sums
    `ieee80211_link_common_elems_size(...)` into `size` before
    `alloc_skb(size, GFP_KERNEL)` (net/mac80211/mlme.c:2167–2184,
    2217–2219).
  - ML reconfiguration frames also use this helper for their per-link
    STA profiles (net/mac80211/mlme.c:10481–10485).
- User impact: On 6 GHz connections (HE/EHT, especially with MLO), the
  missing 4 bytes can cause:
  - Buffer tailroom underrun during frame construction (possible
    KASAN/BUG/WARN or memory corruption).
  - Malformed frames leading to association or ML reconfiguration
    failures.
- Scope and risk:
  - Small, self-contained fix in mac80211 mgmt path; no API/ABI change;
    no feature addition.
  - Only affects 6 GHz cases where the element is actually sent; over-
    allocation by 4 bytes in other contexts does not occur.
  - Very low regression risk; it corrects a precise accounting bug to
    match already-emitted bytes.

Stable backport criteria:
- Fixes a real bug that can affect users on 6 GHz.
- Minimal, targeted change; no architectural changes.
- Low risk of regressions; strictly improves size correctness.

Conclusion: This should be backported to all stable kernels that include
`ieee80211_put_reg_conn()` and use `ieee80211_link_common_elems_size()`
for SKB sizing in association/ML frames.

 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index dd650a127a317..f38881b927d17 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2112,8 +2112,11 @@ ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
 		sizeof(struct ieee80211_he_mcs_nss_supp) +
 		IEEE80211_HE_PPE_THRES_MAX_LEN;
 
-	if (sband->band == NL80211_BAND_6GHZ)
+	if (sband->band == NL80211_BAND_6GHZ) {
 		size += 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);
+		/* reg connection */
+		size += 4;
+	}
 
 	size += 2 + 1 + sizeof(struct ieee80211_eht_cap_elem) +
 		sizeof(struct ieee80211_eht_mcs_nss_supp) +
-- 
2.51.0


