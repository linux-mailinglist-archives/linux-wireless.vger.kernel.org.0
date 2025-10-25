Return-Path: <linux-wireless+bounces-28250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A142C09520
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AC01C209D1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7B307ADA;
	Sat, 25 Oct 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n98rt97V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4F3054F9;
	Sat, 25 Oct 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408876; cv=none; b=i1NRSFqt4/U/YsO7hx5A6N0ZUqfxrPOQ7rQPwpUNblRUgTXd8pffGXSBbV4NUVKBE5IWc763j4b+lnchbsu/YqLyXrBNPyDZgXi9UhBCi/JjfkWnZehFS/mJEpPIUKtU+8BFaqrdaiElqJ93cm35MtboYihV+qzZ2jCDL+Yt9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408876; c=relaxed/simple;
	bh=W5QiCdh96TWlhg/ayjzSoL3QDHsdhCmpuocEhXHpLsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hk+Y2DdD1kROS/lu+xYbIrsc2hDNeEWxbbub+Xnu8PJ6HM5lP4Xy5BjHdpM/PYUjkooab2fgEF2YeUQ98Zmlnde//u4yYRA49eOBIcj8Bwx9hwTFNefb2XpUzP1EFxVnCGLvjbS9Z28CtN+OYYYWSNsLxh8VpGQAfYQ0e3mTJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n98rt97V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D80C4CEFF;
	Sat, 25 Oct 2025 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408875;
	bh=W5QiCdh96TWlhg/ayjzSoL3QDHsdhCmpuocEhXHpLsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n98rt97VWxm4bgbTrg4dCCUwKN250CmTneuopBSk3/lS1N/4IH+fFhjZay1DAYbN1
	 Prfh7YaybOAfUHkaBzzcwZxQzw6zY0wUYYgikIu86jZaSLnU2FxvRsQxn/hEhOVxMz
	 fafYTV4bYYwORkabTvD4M+yQd9U5bAFx97b2gGcQQ9qLCj1iaPq/39fzKpBMfoypR1
	 28pP4ykRfoqAAOy+JpXQftJgPLAEB4pLBWhhSX7VCpVvs7cbP/eXrGlH9bYEsMTZJY
	 LVn6YkWcbpMTb9i5JhxJ4xGqhvtfVun/SCUmV/9PgFidXuiGmDjOdErwVJkr2zYQ7H
	 VRCB9NIO/Iy5Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] wifi: mac80211: Fix 6 GHz Band capabilities element advertisement in lower bands
Date: Sat, 25 Oct 2025 11:55:42 -0400
Message-ID: <20251025160905.3857885-111-sashal@kernel.org>
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

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

[ Upstream commit e53f8b12a21c2974b66fa8c706090182da06fff3 ]

Currently, when adding the 6 GHz Band Capabilities element, the channel
list of the wiphy is checked to determine if 6 GHz is supported for a given
virtual interface. However, in a multi-radio wiphy (e.g., one that has
both lower bands and 6 GHz combined), the wiphy advertises support for
all bands. As a result, the 6 GHz Band Capabilities element is incorrectly
included in mesh beacon and station's association request frames of
interfaces operating in lower bands, without verifying whether the
interface is actually operating in a 6 GHz channel.

Fix this by verifying if the interface operates on 6 GHz channel
before adding the element. Note that this check cannot be placed
directly in ieee80211_put_he_6ghz_cap() as the same function is used to
add probe request elements while initiating scan in which case the
interface may not be operating in any band's channel.

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Link: https://patch.msgid.link/20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes: On multi-radio wiphys, mac80211 could incorrectly
  include the HE 6 GHz Band Capabilities element in frames while the
  interface operates on 2.4/5 GHz. This misadvertises capabilities and
  can cause interop issues (e.g., peers misinterpreting the association
  or mesh beacon content).

- Station assoc request gating (mlme.c): The call to add the HE 6 GHz
  Band Capabilities IE is now correctly gated to only when the
  association channel is 6 GHz. This uses the per-link association
  channel to derive `sband` and checks the band before adding the IE:
  - `sband` selection tied to the AP’s channel: net/mac80211/mlme.c:1768
  - Gate before adding the IE: net/mac80211/mlme.c:1862
  - Only add if 6 GHz: net/mac80211/mlme.c:1863

- Mesh beacon gating (mesh.c): The mesh beacon builder now adds the HE 6
  GHz Band Capabilities element only when the mesh interface operates on
  a 6 GHz channel, not merely if the wiphy supports 6 GHz:
  - Get current sband, error if missing: net/mac80211/mesh.c:623
  - Early return if not 6 GHz: net/mac80211/mesh.c:627
  - Only then add the IE: net/mac80211/mesh.c:636
  - This function is used when composing the mesh beacon tail:
    net/mac80211/mesh.c:1119

- Why not move the check into ieee80211_put_he_6ghz_cap(): That helper
  is intentionally band-agnostic and is also used in probe requests
  during scan, where the interface may not be operating on a specific
  band. Probe requests still (correctly) include the 6 GHz capability if
  the device supports it:
  - Probe request builder unconditionally uses the helper:
    net/mac80211/util.c:1368
  - The helper itself checks 6 GHz device/wiphy support, not current
    operating band: net/mac80211/util.c:2585, net/mac80211/util.c:2590

- Risk and scope: The change is small, local, and surgical. It only adds
  band checks at the two call sites that build management frames tied to
  a specific operating channel (association requests and mesh beacons).
  No data structures or driver interfaces change. On 6 GHz operation the
  behavior is unchanged; on lower bands the incorrect element is no
  longer advertised. This reduces interop failures and aligns with
  802.11 requirements.

- Stable suitability: This is a correctness/interop bugfix, not a
  feature; it is minimal and contained to mac80211 management IE
  composition. It follows stable backport guidelines (important bug fix,
  low regression risk, no architectural changes).

 net/mac80211/mesh.c | 3 +++
 net/mac80211/mlme.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index a4a715f6f1c32..f37068a533f4e 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -624,6 +624,9 @@ int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
+	if (sband->band != NL80211_BAND_6GHZ)
+		return 0;
+
 	iftd = ieee80211_get_sband_iftype_data(sband,
 					       NL80211_IFTYPE_MESH_POINT);
 	/* The device doesn't support HE in mesh mode or at all */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b0575604ce71c..0f2d2fec05426 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1850,7 +1850,8 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 		ieee80211_put_he_cap(skb, sdata, sband,
 				     &assoc_data->link[link_id].conn);
 		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_HE_CAPABILITY);
-		ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
+		if (sband->band == NL80211_BAND_6GHZ)
+			ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
 	}
 
 	/*
-- 
2.51.0


