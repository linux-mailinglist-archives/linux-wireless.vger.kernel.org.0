Return-Path: <linux-wireless+bounces-1014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDDA818E6D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E34283766
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504A39AF0;
	Tue, 19 Dec 2023 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsgUjeSf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44BD3987A
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007713; x=1734543713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VRK0giCkR9ulxbH5LzeNXKKDkwiBrIwMhe+udXIndFU=;
  b=PsgUjeSfHgu77TCnyPRJ6dLYw3quMtQjpiPzRbKiw/xW70ganf3wH8cI
   WV4h77KLZGi2mv6J5qRWbi2TIsgAHK+XUV0YaLArvZzoZeNv4myTkSN1R
   Q8287w1pgWhUA4CDPkpi3sVgl/+AacK/o5D2BCbV+xi4tFv9mytGhtSyf
   G4X3i7Rknkvods539oZ5dmn59oEYjKRT04xrqWKWFaOhmSNcUjJ+oACn3
   L0Dc3WqCgUPSre+bA88WT2yZCN6bEzmOnx6+gRFVrBSIJm4DiDxqrjGX9
   D9/zX9nvZNRm2h47X3wmnNvCKAC6MYd4+Axx+YBpXCewyKNw3sVlnWXYN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790593"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790593"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894370419"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894370419"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 13/13] wifi: mac80211_hwsim: support HE 40MHz in 2.4Ghz band
Date: Wed, 20 Dec 2023 13:41:46 +0200
Message-Id: <20231220133549.82d9666abb5b.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We are missing the flag that indicates that capability
of 40MHz bandwidth support in HE on the LB.
Add it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
v2: Fix wrong email addresses
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 3816b0d335f0..a84340c2075f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4044,6 +4044,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -4149,6 +4151,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -4252,6 +4256,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
-- 
2.34.1


