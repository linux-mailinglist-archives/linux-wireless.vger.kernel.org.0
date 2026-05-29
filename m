Return-Path: <linux-wireless+bounces-37117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCpOBoNOGWrzuQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847485FF2EB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5033159AAE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B53AA1A9;
	Fri, 29 May 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jW2G/vh8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243233537F7
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043220; cv=none; b=d04ikK+0TxOas8WYwSZz+/BkrJM6NociMUY3gK0Zuh7Ha0NQooKcnhYOZF9vwu/j6Qamnkto18LhZHKZ/90eVwqDge59nTX8ekpJlqy+ocQ/gdT2EKvdYiHR9FFSgbZy3IivppxToWMovlTs8sP7zVstK8PK/+QvzdIyh98sBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043220; c=relaxed/simple;
	bh=Vt6kK8n/O+YIDYlym46xrf8j056nZcHrjWZwu7ioA6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRoIMV8KHrZf7QEXTJVsS/xQiIcLPa05Jr4HRfb5wMwm2mlUyMPBBubrTr/F9XKHfXTRn2r2GMO0O95rgfpmwOXQMMnPsTrRH8zHC8a2SZAmsEvFU5G+ZbzuAnBrGHw003tZWH3zK63Wtd5l49WMjl2HisL3rxV2Jf5cJ7LTJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jW2G/vh8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XvUo0RTDAWmuk17WElGpdKsCGYSGl4sljRkuX/pb/YU=;
	t=1780043219; x=1781252819; b=jW2G/vh8zBFKG0rrV919nZCvNtk+pVZf6x9bhm+Xaux+tOk
	xitElONCVTkq975zf7nJwHpQd7Ou7omdN0/0gJpXYnzB2ypBGWr2dBuU/RiTc6lu/99meSjj41WvJ
	FK7zNL3aAi9WBrL1MRQTf9FfUbSRZKJNKMU8kZ0Wx86QJK7LJJ0FHTmfBC0V6pWp5Ylc3teEOZtUJ
	xqACUL1vFBKDIaM2EOKfgJgZKJ/HJjglkMJH3l+yG008QQD5m4xMPyGfGpJcXW3x5i8Hg+3+x3Wty
	uDh1SxBY+fTpSZvWlGRIWNL0NAkm7BsHNYQDpVAcaW+OqcGfRK2aCYA38J9h+z2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYS-00000009bVp-2wqA;
	Fri, 29 May 2026 10:26:57 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/16] wifi: Update UHR PHY capabilities to D1.4
Date: Fri, 29 May 2026 10:25:04 +0200
Message-ID: <20260529102644.f146932b21e2.I12bad84157bf809fbe285b79420143b3c456d9d2@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529082644.106145-18-johannes@sipsolutions.net>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37117-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 847485FF2EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

There are new capabilities in D1.4, and some reserved
bits. Update the code accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 10 +++--
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  4 +-
 .../wireless/virtual/mac80211_hwsim_main.c    | 24 +++++------
 include/linux/ieee80211-uhr.h                 | 40 ++++++++++++++-----
 4 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 7027bca249a0..d47b4ae2f486 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -693,8 +693,9 @@ static const struct ieee80211_sband_iftype_data iwl_iftype_cap[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			/* Note: asymmetry is fixed later */
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX |
+					       IEEE80211_UHR_PHY_CAP_ELR_TX),
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
 				      IEEE80211_UHR_MAC_CAP0_DPS_SUPP,
@@ -801,8 +802,9 @@ static const struct ieee80211_sband_iftype_data iwl_iftype_cap[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			/* Note: asymmetry is fixed later */
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX |
+					       IEEE80211_UHR_PHY_CAP_ELR_TX),
 		},
 	},
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index a03834d3ac65..edf9c735dd67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -114,8 +114,8 @@ iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
 	}
 
 	if (uhr_cap && uhr_cap->has_uhr && own_uhr_cap &&
-	    uhr_cap->phy.cap & IEEE80211_UHR_PHY_CAP_ELR_RX &&
-	    own_uhr_cap->phy.cap & IEEE80211_UHR_PHY_CAP_ELR_TX)
+	    uhr_cap->phy.cap & cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX) &&
+	    own_uhr_cap->phy.cap & cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_TX))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_1_5_MBPS_MSK |
 			 IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_3_MBPS_MSK;
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 6ea082157307..543793a39ad0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -4593,8 +4593,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
 			},
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX |
+					       IEEE80211_UHR_PHY_CAP_ELR_TX),
 		},
 	},
 	{
@@ -4709,8 +4709,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
 			},
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX |
+					       IEEE80211_UHR_PHY_CAP_ELR_TX),
 		},
 	},
 #ifdef CONFIG_MAC80211_MESH
@@ -4886,8 +4886,7 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
 			},
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_TX),
 		},
 	},
 	{
@@ -5019,8 +5018,7 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
 			},
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX),
 		},
 	},
 #ifdef CONFIG_MAC80211_MESH
@@ -5220,8 +5218,7 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
 			},
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_TX),
 		},
 	},
 	{
@@ -5374,8 +5371,7 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
 			},
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX),
 		},
 	},
 #ifdef CONFIG_MAC80211_MESH
@@ -5473,8 +5469,8 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
 			},
-			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
-				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.phy.cap = cpu_to_le32(IEEE80211_UHR_PHY_CAP_ELR_RX |
+					       IEEE80211_UHR_PHY_CAP_ELR_TX),
 		},
 	},
 #endif
diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index 71faf4a6825e..120993897490 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -401,17 +401,39 @@ struct ieee80211_uhr_cap_mac {
 	u8 mac_cap[5];
 } __packed;
 
-#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x01
-#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x02
-#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x04
-#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160	0x08
-#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320	0x10
-#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320	0x20
-#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x40
-#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x80
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x00000001
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x00000002
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x00000004
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160	0x00000008
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320	0x00000010
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320	0x00000020
+#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x00000040
+#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x00000080
+#define IEEE80211_UHR_PHY_CAP_PART_BW_DL_MUMIMO		0x00000100
+#define IEEE80211_UHR_PHY_CAP_PART_BW_UL_MUMIMO		0x00000200
+#define IEEE80211_UHR_PHY_CAP_MCS15			0x00000400
+#define IEEE80211_UHR_PHY_CAP_2XLDPC_TX			0x00000800
+#define IEEE80211_UHR_PHY_CAP_2XLDPC_RX			0x00001000
+#define IEEE80211_UHR_PHY_CAP_UEQM_TX_MAX_NSS		0x00006000
+#define IEEE80211_UHR_PHY_CAP_UEQM_RX_MAX_NSS		0x00018000
+#define IEEE80211_UHR_PHY_CAP_CO_BF_JOINT_SOUNDING	0x00040000
+#define IEEE80211_UHR_PHY_CAP_IM_TX			0x00080000
+#define IEEE80211_UHR_PHY_CAP_IM_RX			0x00100000
+#define IEEE80211_UHR_PHY_CAP_CO_SR_MODE_1		0x00200000
+#define IEEE80211_UHR_PHY_CAP_CO_SR_MODE_2		0x00400000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_20_IN_PBW_20	0x00800000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_40_IN_PBW_40	0x01000000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_80_IN_PBW_80	0x02000000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_80_IN_PBW_160	0x04000000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_80_IN_PBW_320	0x08000000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_20_IN_PBW_GE80	0x10000000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_40_IN_PBW_GE80	0x20000000
+#define IEEE80211_UHR_PHY_CAP_DRU_DBW_60_IN_PBW_GE80	0x40000000
+#define IEEE80211_UHR_PHY_CAP_DRU_RRU_HYBRID_MODE	0x80000000
 
 struct ieee80211_uhr_cap_phy {
-	u8 cap;
+	__le32 cap;
+	u8 reserved;
 } __packed;
 
 struct ieee80211_uhr_cap {
-- 
2.53.0


