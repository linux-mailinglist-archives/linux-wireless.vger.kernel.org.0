Return-Path: <linux-wireless+bounces-27360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FBB7D885
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D54A48106A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D92BDC25;
	Tue, 16 Sep 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="AUuS0S6j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E9284888
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061241; cv=none; b=GHFhCwyeKsfJMuQTvoACkPJVwEyvEIuY9g0gU2YBJPW+HmFyITWgJKXikzu4p9y5I827Ng8YBCn5GHAQ8S8ul+uxSno9xNeKSCHeqBPgKoy/ccvfHHexnB56glys+LQs5Y6tHaoNwvF5LnKv/BcDkWMCWiI42OJFmECisDeDVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061241; c=relaxed/simple;
	bh=mqXHxKWMmJbuxoZqss03dW50wJLi98FKQ8vdYshdmfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/6+76HMrt8Sx78/5kpVCM93cAtnPKNqWSdG3hiiL0ReOeJbqh7xmMDY0MvLAYg3R9vpBr0eavsU08GNc8lppaBfS8s+vxEXPNWu4Xn1WnrcLlfkylkImzxPbD0XS4d56uOiXHR/tCmNtBjBJS/NQX+kSQqNsB+8jA4DrpCk1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=AUuS0S6j; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061240; x=1789597240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqXHxKWMmJbuxoZqss03dW50wJLi98FKQ8vdYshdmfA=;
  b=AUuS0S6jpV4j2Iza+t2o6ZHDoZGfM0dCp2H6vpUyttWHaraRa7cj2qqE
   sWoPhaWSh1CJx0LRHf+2j1tmwWikglTQgupd8SAu/j5ybHgOW9GcXeets
   5BXtUhEXEg1TmgttB5KcrXRoeyXhMcskzpX+ySNx11OEwJuFsGW1Fjq/A
   c=;
X-CSE-ConnectionGUID: ckOPCt80TPaEbQoc0bxXTg==
X-CSE-MsgGUID: 3rzhd8s1S9mjZYqd6w2HxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783319"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783319"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:20:38 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:20:37 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:20:34 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 10/57] wifi: inffmac: add he.c/h
Date: Wed, 17 Sep 2025 03:47:25 +0530
Message-ID: <20250916221821.4387-11-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation to collect the HE capabilities of the Device and then
get it registered as part of the wiphy capabilities in the cfg80211 driver.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/he.c | 239 +++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/he.h |  58 +++++
 2 files changed, 297 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/he.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/he.h

diff --git a/drivers/net/wireless/infineon/inffmac/he.c b/drivers/net/wireless/infineon/inffmac/he.c
new file mode 100644
index 000000000000..e1bb0665c136
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/he.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include "he.h"
+#include "feature.h"
+#include "fwil.h"
+#include "cfg80211.h"
+#include "debug.h"
+#include "xtlv.h"
+
+struct ieee80211_sband_iftype_data sdata[NUM_NL80211_BANDS];
+
+int
+inff_he_get_enable(struct inff_if *ifp, u8 *param, int param_len)
+{
+	s32 ret = 0;
+
+	ret = inff_fil_xtlv_data_get(ifp, "he", INFF_HE_CMD_ENAB, param, param_len);
+	if (unlikely(ret))
+		iphy_err(ifp->drvr, "failed to check if HE is enabled");
+
+	return ret;
+}
+
+int
+inff_he_get_bss_color(struct inff_if *ifp, u8 *param, int param_len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_xtlv *he_tlv;
+	int err = 0;
+
+	he_tlv = (struct inff_xtlv *)param;
+	he_tlv->id = cpu_to_le16(INFF_HE_CMD_BSSCOLOR);
+
+	err = inff_fil_iovar_data_get(ifp, "he", param, param_len);
+	if (err)
+		iphy_err(drvr, "get he bss_color error:%d\n", err);
+
+	return err;
+}
+
+int
+inff_he_set_bss_color(struct inff_if *ifp, u8 color)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_xtlv *he_tlv;
+	u8 param[8] = {0};
+	int err = 0;
+
+	he_tlv = (struct inff_xtlv *)param;
+	he_tlv->id = cpu_to_le16(INFF_HE_CMD_BSSCOLOR);
+	he_tlv->len = cpu_to_le16(1);
+	memcpy(he_tlv->data, &color, sizeof(u8));
+
+	err = inff_fil_iovar_data_set(ifp, "he", param, sizeof(param));
+	if (err)
+		iphy_err(drvr, "set he bss_color error:%d\n", err);
+
+	return err;
+}
+
+int
+inff_he_get_muedca_opt(struct inff_if *ifp, u8 *param, int param_len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_xtlv *he_tlv;
+	int err = 0;
+
+	he_tlv = (struct inff_xtlv *)param;
+	he_tlv->id = cpu_to_le16(INFF_HE_CMD_MUEDCA_OPT);
+
+	err = inff_fil_iovar_data_get(ifp, "he", param, param_len);
+	if (err)
+		iphy_err(drvr, "get he muedca_opt_enable error:%d\n", err);
+
+	return err;
+}
+
+int
+inff_he_set_muedca_opt(struct inff_if *ifp, u8 val)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_xtlv *he_tlv;
+	u8 param[8] = {0};
+	int err = 0;
+
+	he_tlv = (struct inff_xtlv *)param;
+	he_tlv->id = cpu_to_le16(INFF_HE_CMD_BSSCOLOR);
+	he_tlv->len = cpu_to_le16(1);
+	he_tlv->data[0] = val;
+
+	err = inff_fil_iovar_data_set(ifp, "he", param, sizeof(param));
+	if (err)
+		iphy_err(drvr, "set he muedca_opt_enable error:%d\n", err);
+
+	return err;
+}
+
+int
+inff_he_set_bitrate(struct inff_if *ifp, const struct cfg80211_bitrate_mask *mask, u8 band)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	uint hegi;
+	u16 mcs_mask;
+	u32 rspec = 0;
+	s32 ret = 0;
+	u8 mcs = 0;
+
+	mcs_mask = mask->control[band].he_mcs[0];
+	mcs_mask = (mcs_mask ^ ((mcs_mask - 1) & mcs_mask));
+	if (mcs_mask != mask->control[band].he_mcs[0])
+		return ret;
+
+	while (mcs_mask) {
+		mcs++;
+		mcs_mask >>= 1;
+	}
+
+	rspec = WL_RSPEC_ENCODE_HE;     /* 11ax HE */
+	rspec |= (WL_RSPEC_HE_NSS_UNSPECIFIED << WL_RSPEC_HE_NSS_SHIFT) | (mcs - 1);
+	/* set the other rspec fields */
+	hegi = mask->control[band].he_gi + 1;
+	rspec |= ((hegi != 0xFF) ? HE_GI_TO_RSPEC(hegi) : 0);
+
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		ret = inff_fil_iovar_data_set(ifp, "2g_rate", (char *)&rspec, 4);
+		break;
+	case NL80211_BAND_5GHZ:
+		ret = inff_fil_iovar_data_set(ifp, "5g_rate", (char *)&rspec, 4);
+		break;
+	case NL80211_BAND_6GHZ:
+		ret = inff_fil_iovar_data_set(ifp, "6g_rate", (char *)&rspec, 4);
+		break;
+	default:
+		iphy_err(drvr, "Setting bitrate unsupported on band %d\n", band);
+		ret = -EOPNOTSUPP;
+	}
+
+	if (unlikely(ret))
+		iphy_err(drvr, "set rate failed, retcode = %d\n", ret);
+
+	return ret;
+}
+
+void
+inff_he_update_wiphy_cap(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct wiphy *wiphy = drvr->wiphy;
+	struct ieee80211_supported_band *band;
+	struct ieee80211_sband_iftype_data *data;
+	struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_he_cap_elem *he_cap_elem;
+	struct ieee80211_he_mcs_nss_supp *he_mcs;
+	u8 mac_cap_info[HE_MAC_CAP_INFO_SIZE] = { 0 };
+	u8 phy_cap_info[HE_PHY_CAP_INFO_SIZE] = { 0 };
+	u16 capa = 0;
+	u8 hemode = 0;
+	int idx = 1, i = 0, j = 0;
+
+	/* HE mode */
+	inff_he_get_enable(ifp, &hemode, sizeof(hemode));
+	if (!hemode)
+		return;
+
+	inff_dbg(INFO, "HE Enabled\n");
+
+	/* HE MAC Capabilities Information */
+	if (inff_fil_xtlv_data_get(ifp, "he", INFF_HE_CMD_MACCAP, mac_cap_info,
+				   HE_MAC_CAP_INFO_SIZE))
+		iphy_err(drvr, "HE MACCAP error\n");
+
+	/* HE PHY Capabilities Information */
+	if (inff_fil_xtlv_data_get(ifp, "he", INFF_HE_CMD_PHYCAP, phy_cap_info,
+				   HE_PHY_CAP_INFO_SIZE))
+		iphy_err(drvr, "HE PHYCAP error\n");
+
+	/* Update HE Capab for each Band */
+	for (i = 0; i < ARRAY_SIZE(wiphy->bands); i++) {
+		band = wiphy->bands[i];
+		if (!band)
+			continue;
+
+		data = &sdata[band->band];
+		he_cap = &data->he_cap;
+		he_cap_elem = &he_cap->he_cap_elem;
+		he_mcs = &he_cap->he_mcs_nss_supp;
+
+		switch (band->band) {
+		case NL80211_BAND_6GHZ:
+			if (!inff_feat_is_6ghz_enabled(ifp))
+				break;
+
+			/* HE 6 GHz band capabilities */
+			capa = (FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START,
+					   IEEE80211_HT_MPDU_DENSITY_8) |
+				FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP,
+					   IEEE80211_VHT_MAX_AMPDU_1024K) |
+				FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN,
+					   IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454));
+			data->he_6ghz_capa.capa = cpu_to_le16(capa);
+
+			/* Band 6GHz supports HE, so */
+			fallthrough;
+
+		case NL80211_BAND_5GHZ:
+			/* Band 5GHz supports HE, so */
+			fallthrough;
+
+		case NL80211_BAND_2GHZ:
+			/* Band 2GHz supports HE */
+			data->types_mask = BIT(NL80211_IFTYPE_STATION) | BIT(NL80211_IFTYPE_AP);
+			data->he_cap.has_he = true;
+
+			for (j = 0; j < HE_MAC_CAP_INFO_SIZE; j++)
+				he_cap_elem->mac_cap_info[j] = le32_to_cpu(mac_cap_info[j]);
+
+			for (j = 0; j < HE_PHY_CAP_INFO_SIZE; j++)
+				he_cap_elem->phy_cap_info[j] = le32_to_cpu(phy_cap_info[j]);
+
+			/* HE Supported MCS and NSS Set */
+			he_mcs->rx_mcs_80 = cpu_to_le16(0xfffa);
+			he_mcs->tx_mcs_80 = cpu_to_le16(0xfffa);
+
+			band->n_iftype_data = idx;
+			band->iftype_data = data;
+
+			break;
+
+		default:
+			break;
+		}
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/he.h b/drivers/net/wireless/infineon/inffmac/he.h
new file mode 100644
index 000000000000..4b5feb36b4e0
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/he.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_HE_H
+#define INFF_HE_H
+
+#include "core.h"
+
+#define HE_MAC_CAP_INFO_SIZE	6
+#define HE_PHY_CAP_INFO_SIZE	11
+
+/**
+ * enum inff_he_cmd - HE iovar subcmds handled by firmware HE module
+ */
+enum inff_he_cmd {
+	INFF_HE_CMD_ENAB = 0,
+	INFF_HE_CMD_FEATURES = 1,
+	INFF_HE_CMD_TWT_SETUP = 2,
+	INFF_HE_CMD_TWT_TEARDOWN = 3,
+	INFF_HE_CMD_TWT_INFO = 4,
+	INFF_HE_CMD_BSSCOLOR = 5,
+	INFF_HE_CMD_PARTIAL_BSSCOLOR = 6,
+	INFF_HE_CMD_CAP = 7,
+	INFF_HE_CMD_STAID = 8,
+	INFF_HE_CMD_RTSDURTHRESH = 10,
+	INFF_HE_CMD_PEDURATION = 11,
+	INFF_HE_CMD_TESTBED_MODE = 12,
+	INFF_HE_CMD_OMI = 13,
+	INFF_HE_CMD_MAC_PAD_DUR = 14,
+	INFF_HE_CMD_MUEDCA = 15,
+	INFF_HE_CMD_MACCAP = 16,
+	INFF_HE_CMD_PHYCAP = 17,
+	INFF_HE_CMD_DISPLAY = 18,
+	INFF_HE_CMD_ACTION = 19,
+	INFF_HE_CMD_OFDMATX = 20,
+	INFF_HE_CMD_20IN80_MODE = 21,
+	INFF_HE_CMD_SMPS = 22,
+	INFF_HE_CMD_PPETHRESH = 23,
+	INFF_HE_CMD_HTC_OMI_EN = 24,
+	INFF_HE_CMD_ERSU_EN = 25,
+	INFF_HE_CMD_PREPUNCRX_EN = 26,
+	INFF_HE_CMD_MIMOCAP_EN = 27,
+	INFF_HE_CMD_MUEDCA_OPT = 28,
+	INFF_HE_CMD_LAST
+};
+
+int inff_he_get_enable(struct inff_if *ifp, u8 *param, int param_len);
+int inff_he_get_bss_color(struct inff_if *ifp, u8 *param, int param_len);
+int inff_he_set_bss_color(struct inff_if *ifp, u8 color);
+int inff_he_get_muedca_opt(struct inff_if *ifp, u8 *param, int param_len);
+int inff_he_set_muedca_opt(struct inff_if *ifp, u8 val);
+int inff_he_set_bitrate(struct inff_if *ifp, const struct cfg80211_bitrate_mask *mask, u8 band);
+void inff_he_update_wiphy_cap(struct inff_if *ifp);
+
+#endif /* INFF_HE_H */
-- 
2.25.1


