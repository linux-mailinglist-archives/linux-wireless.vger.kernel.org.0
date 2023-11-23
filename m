Return-Path: <linux-wireless+bounces-11-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0687F6901
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51A42819CC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02405405FD;
	Thu, 23 Nov 2023 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WvlOZtZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D1D69
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j8YqGfwVDHBkZbNh9kwvwhuVLvovZTwX+d5lnt5oR6U=;
	t=1700778478; x=1701988078; b=WvlOZtZMcfWt9cPv4BhIDfj+12UY6tJ8EzxHyLwYIz3QX1N
	wEmsUCNgVT/Mruk7fIyWiOHwnIZz8qx0OGt0KQ149ABRnhVG7dEwGwSBwAAnQ9GTatx1C9mhaN7iQ
	5zR+vAQQ8HbGcrwM9P3dKbBpItF2QmKEJUafoQomzKrKDyDRh0wVjl3O2rN5fK1lVj8Y57jGJVAxz
	tUjkqYyomalwO+Qni0UKtbIO6PnyUdbNbKojb6P+mizMdMWAk7Oo9fYXcWNsU0Z1GwXhRxm21iIX4
	sGSjBVcKY7PwNEGryX+s8wjXblnYWaA5JSjXrTfXF3vRrGQDFLgZLw19TQGkqKNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAt-00000001Y53-2ibI;
	Thu, 23 Nov 2023 23:27:55 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 05/13] wifi: mac80211_hwsim: support HE 40 MHz
Date: Thu, 23 Nov 2023 23:14:42 +0100
Message-ID: <20231123231436.02fd03dadd5b.I196ad0d80bbe37cf2574458418a9dcb2661a8ee6@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add support for 40 MHz in HE to hwsim, it has support
for it in HT and appears to be the only driver that
has lower bandwidth in HE than HT.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Note: this breaks two hwsim tests in hostap, but that's
due to the wpa_supplicant code to estimate throughput
being broken in HE/EHT cases by not taking into account
the operating bandwidth, only the capabilities.
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index c7b4414cc6c3..84f417b0d8c6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4029,6 +4029,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -4134,6 +4136,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -4237,6 +4241,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
-- 
2.42.0


