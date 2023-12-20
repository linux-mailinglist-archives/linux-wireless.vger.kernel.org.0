Return-Path: <linux-wireless+bounces-979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A0818398
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30591F250E0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD2134B3;
	Tue, 19 Dec 2023 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kigniWep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF4134A7
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975126; x=1734511126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9AUM4lklycIqxhqvE12OUtQpZjWfft1xXeFrYwU2ttY=;
  b=kigniWepKiIXTM5L2xkiTHWWsJUtk6MwKGCb5IhlIxoMj2gbfPBhUEMA
   qn4x9RHViqxCzNlQtME9N5ddRNsAOcv8pEHsoxQ71fnvJALSggiLZevOE
   P1bHCJb2l84s6svJL2pdyx9SecqiKsvrrzK5XSsW0cIiMXzCg0elTzv1I
   6/ZrRT2U6iOyPbCZZHtdLHaOQLUZuwCXSdlonKNnpsTGinpHFkK57wMqD
   sKaYn10UBXxaOdYiSDR4/m1iEtiM0E5AH6/Wurw7DPJTYC57HpExCRh90
   KR3b0XLuYS1zqGxxUD0ucn+FN+pj/OKX0jTXUcX5VLC622DZBcN6AGDQZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969328"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969328"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266579"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266579"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: mac80211_hwsim: support HE 40MHz in 2.4Ghz band
Date: Wed, 20 Dec 2023 04:38:03 +0200
Message-Id: <20231220043149.56bf8f5cd373.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
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
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
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


