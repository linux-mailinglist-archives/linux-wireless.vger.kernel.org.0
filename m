Return-Path: <linux-wireless+bounces-27405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE1B7DE61
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1072A462E3C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE332E2D3;
	Tue, 16 Sep 2025 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="M5+5o7oN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B3276022
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061801; cv=none; b=a3E707elRwvqZxrTq/rnxGjlRgPuSiR+bfXNRRiKblEskfE2uOxQnMRj0aha8cP2OWn8g+dcYFSVm4GuA5O30AALqErSqcqu/z0fv+UYggibnZ9mJ3ltegNOEceScU6o2qz97nMdjYFHnzHZNrUzdI8eT3tm3j3uZh6ChObBEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061801; c=relaxed/simple;
	bh=Hhlc8ARBewvj2BVVC1ZGxJVwu67r8kyjm9t0fCFqvA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNLNSFIwurdrZ4aMXriUKykmjcdYTURjiabtKkinHUMEx5hu+YbL55jdaIf1vSV5QKblXIaHQkrdaHapgelrlA48bvJOv5Bo35drgdUezaiJ9F0pYXcpkUL+iiUK/HKiueok2oY7WDQpTmO/MpdjFWDG+1dyAg3hik8mbgFlUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=M5+5o7oN; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061799; x=1789597799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hhlc8ARBewvj2BVVC1ZGxJVwu67r8kyjm9t0fCFqvA8=;
  b=M5+5o7oNe1DKTuUlU0EOx6uumHyOJH5Gggm+Gi4CVBuAPOUcb2YHhH0i
   MsQmxjJUquJ7sWNSA4vKC/pGQZZTXDZAo7/UfctFalq0JVumcoOAUyJQy
   dY9G8+Z15w7ExWmVzRAvt/8TR2TgUXq4I12MWc/AItgNVsTaYTHuadyxZ
   I=;
X-CSE-ConnectionGUID: EhvmvRuUSMqphx7/gJLT2Q==
X-CSE-MsgGUID: XNkXnNi0T8+idIU2IM5eGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093885"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093885"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:29:57 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:29:56 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:29:53 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 50/57] wifi: inffmac: add security.c/h
Date: Wed, 17 Sep 2025 03:48:10 +0530
Message-ID: <20250916221821.4387-56-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the Wi-Fi Connection security related operations.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/security.c  | 752 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/security.h  | 212 +++++
 2 files changed, 964 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/security.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/security.h

diff --git a/drivers/net/wireless/infineon/inffmac/security.c b/drivers/net/wireless/infineon/inffmac/security.c
new file mode 100644
index 000000000000..52a7d93847fd
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/security.c
@@ -0,0 +1,752 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <net/cfg80211.h>
+#include <net/netlink.h>
+#include <uapi/linux/if_arp.h>
+
+#include "utils.h"
+#include "defs.h"
+#include "chanspec.h"
+#include "hw_ids.h"
+#include "core.h"
+#include "debug.h"
+#include "tracepoint.h"
+#include "fwil_types.h"
+#include "p2p.h"
+#include "btcoex.h"
+#include "pno.h"
+#include "fwsignal.h"
+#include "cfg80211.h"
+#include "feature.h"
+#include "fwil.h"
+#include "proto.h"
+#include "vendor.h"
+#include "vendor_inf.h"
+#include "bus.h"
+#include "common.h"
+#include "he.h"
+#include "eht.h"
+#include "twt.h"
+#include "offload.h"
+#include "pmsr.h"
+
+bool
+inff_has_pmkid(const u8 *parse, u32 len, u32 *offset_in_ie)
+{
+	const struct inff_tlv *rsn_ie;
+	const u8 *ie;
+	u32 ie_len;
+	u32 offset;
+	u16 count;
+
+	rsn_ie = inff_parse_tlvs(parse, len, WLAN_EID_RSN);
+	if (!rsn_ie)
+		goto done;
+	ie = (const u8 *)rsn_ie;
+	ie_len = rsn_ie->len + TLV_HDR_LEN;
+	/* Skip group data cipher suite */
+	offset = TLV_HDR_LEN + WPA_IE_VERSION_LEN + WPA_IE_MIN_OUI_LEN;
+	if (offset + WPA_IE_SUITE_COUNT_LEN >= ie_len)
+		goto done;
+	/* Skip pairwise cipher suite(s) */
+	count = ie[offset] + (ie[offset + 1] << 8);
+	offset += WPA_IE_SUITE_COUNT_LEN + (count * WPA_IE_MIN_OUI_LEN);
+	if (offset + WPA_IE_SUITE_COUNT_LEN >= ie_len)
+		goto done;
+	/* Skip auth key management suite(s) */
+	count = ie[offset] + (ie[offset + 1] << 8);
+	offset += WPA_IE_SUITE_COUNT_LEN + (count * WPA_IE_MIN_OUI_LEN);
+	if (offset + RSN_CAP_LEN >= ie_len)
+		goto done;
+	/* Skip rsn capabilities */
+	offset += RSN_CAP_LEN;
+	if (offset + RSN_PMKID_COUNT_LEN > ie_len)
+		goto done;
+	/* Extract PMKID count */
+	count = ie[offset] + (ie[offset + 1] << 8);
+	if (count) {
+		if (offset_in_ie)
+			*offset_in_ie = offset + RSN_PMKID_COUNT_LEN;
+		return true;
+	}
+
+done:
+	if (offset_in_ie)
+		*offset_in_ie = 0;
+	return false;
+}
+
+int inff_set_pmk(struct inff_if *ifp, const u8 *pmk_data, u16 pmk_len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_wsec_pmk_le pmk;
+	int err;
+
+	memset(&pmk, 0, sizeof(pmk));
+
+	/* pass pmk directly */
+	pmk.key_len = cpu_to_le16(pmk_len);
+	pmk.flags = cpu_to_le16(0);
+	memcpy(pmk.key, pmk_data, pmk_len);
+
+	/* store psk in firmware */
+	err = inff_fil_cmd_data_set(ifp, INFF_C_SET_WSEC_PMK,
+				    &pmk, sizeof(pmk));
+	if (err < 0)
+		iphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
+			 pmk_len);
+
+	return err;
+}
+
+static void convert_key_from_CPU(struct inff_wsec_key *key, struct inff_wsec_key_le *key_le)
+{
+	key_le->index = cpu_to_le32(key->index);
+	key_le->len = cpu_to_le32(key->len);
+	key_le->algo = cpu_to_le32(key->algo);
+	key_le->flags = cpu_to_le32(key->flags);
+	key_le->rxiv.hi = cpu_to_le32(key->rxiv.hi);
+	key_le->rxiv.lo = cpu_to_le16(key->rxiv.lo);
+	key_le->iv_initialized = cpu_to_le32(key->iv_initialized);
+	memcpy(key_le->data, key->data, sizeof(key->data));
+	memcpy(key_le->ea, key->ea, sizeof(key->ea));
+}
+
+int send_key_to_dongle(struct inff_if *ifp, struct inff_wsec_key *key)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int err;
+	struct inff_wsec_key_le key_le;
+
+	convert_key_from_CPU(key, &key_le);
+
+	inff_netdev_wait_pend8021x(ifp);
+
+	err = inff_fil_bsscfg_data_set(ifp, "wsec_key", &key_le,
+				       sizeof(key_le));
+
+	if (err)
+		iphy_err(drvr, "wsec_key error (%d)\n", err);
+	return err;
+}
+
+s32
+wl_set_wsec_info_algos(struct inff_if *ifp, u32 algos, u32 mask)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err = 0;
+	struct wl_wsec_info *wsec_info;
+	struct inff_xtlv *wsec_info_tlv;
+	u16 tlv_data_len;
+	u8 tlv_data[8];
+	u32 param_len;
+	u8 *buf;
+	u32 buf_len;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	buf_len = sizeof(struct wl_wsec_info) + sizeof(tlv_data);
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf) {
+		iphy_err(drvr, "unable to allocate.\n");
+		return -ENOMEM;
+	}
+
+	wsec_info = (struct wl_wsec_info *)buf;
+	wsec_info->version = WL_WSEC_INFO_VERSION;
+	wsec_info_tlv = (struct inff_xtlv *)(buf + offsetof(struct wl_wsec_info, tlvs));
+
+	wsec_info->num_tlvs++;
+	tlv_data_len = sizeof(tlv_data);
+	memcpy(tlv_data, &algos, sizeof(algos));
+	memcpy(tlv_data + sizeof(algos), &mask, sizeof(mask));
+
+	wsec_info_tlv->id = cpu_to_le16(WL_WSEC_INFO_BSS_ALGOS);
+	wsec_info_tlv->len = cpu_to_le16(tlv_data_len);
+	unsafe_memcpy(wsec_info_tlv->data, tlv_data, tlv_data_len,
+		      /* alloc enough buf*/);
+
+	param_len = offsetof(struct wl_wsec_info, tlvs) +
+		    offsetof(struct wl_wsec_info_tlv, data) + tlv_data_len;
+
+	err = inff_fil_bsscfg_data_set(ifp, "wsec_info", buf, param_len);
+	if (err)
+		inff_err("set wsec_info_error:%d\n", err);
+
+	kfree(buf);
+	return err;
+}
+
+void
+inff_cfg80211_reconfigure_wep(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u8 key_idx;
+	struct inff_wsec_key *key;
+	s32 wsec;
+
+	for (key_idx = 0; key_idx < INFF_MAX_DEFAULT_KEYS; key_idx++) {
+		key = &ifp->vif->profile.key[key_idx];
+		if (key->algo == CRYPTO_ALGO_WEP1 ||
+		    key->algo == CRYPTO_ALGO_WEP128)
+			break;
+	}
+	if (key_idx == INFF_MAX_DEFAULT_KEYS)
+		return;
+
+	err = send_key_to_dongle(ifp, key);
+	if (err) {
+		iphy_err(drvr, "Setting WEP key failed (%d)\n", err);
+		return;
+	}
+	err = inff_fil_bsscfg_int_get(ifp, "wsec", &wsec);
+	if (err) {
+		iphy_err(drvr, "get wsec error (%d)\n", err);
+		return;
+	}
+	wsec |= WEP_ENABLED;
+	err = inff_fil_bsscfg_int_set(ifp, "wsec", wsec);
+	if (err)
+		iphy_err(drvr, "set wsec error (%d)\n", err);
+}
+
+s32
+inff_update_pmklist(struct inff_cfg80211_info *cfg, struct inff_if *ifp)
+{
+	struct inff_pmk_list_le *pmk_list;
+	int i;
+	u32 npmk;
+
+	pmk_list = &cfg->pmk_list;
+	npmk = le32_to_cpu(pmk_list->npmk);
+
+	inff_dbg(CONN, "No of elements %d\n", npmk);
+	for (i = 0; i < npmk; i++)
+		inff_dbg(CONN, "PMK[%d]: %pM\n", i, &pmk_list->pmk[i].bssid);
+
+	return inff_fil_iovar_data_set(ifp, "pmkid_info", pmk_list,
+			sizeof(*pmk_list));
+}
+
+s32
+inff_update_pmksa(struct inff_cfg80211_info *cfg,
+		  struct inff_if *ifp,
+		  const u8 *bssid,
+		  const u8 *pmkid,
+		  enum inff_pmksa_action action)
+{
+	struct inff_pmksa *pmk = &cfg->pmk_list.pmk[0];
+	struct inff_pub *drvr = cfg->pub;
+	s32 err;
+	u32 npmk, i;
+
+	if (!check_vif_up(ifp->vif))
+		return -EIO;
+
+	switch (action) {
+	case PMKSA_SET:
+		npmk = le32_to_cpu(cfg->pmk_list.npmk);
+		for (i = 0; i < npmk; i++)
+			if (!memcmp(bssid, pmk[i].bssid, ETH_ALEN))
+				break;
+		if (i < INFF_MAXPMKID) {
+			memcpy(pmk[i].bssid, bssid, ETH_ALEN);
+			memcpy(pmk[i].pmkid, pmkid, WLAN_PMKID_LEN);
+			if (i == npmk) {
+				npmk++;
+				cfg->pmk_list.npmk = cpu_to_le32(npmk);
+			}
+		} else {
+			iphy_err(drvr, "Too many PMKSA entries cached %d\n", npmk);
+			return -EINVAL;
+		}
+
+		inff_dbg(CONN, "set_pmksa - PMK bssid: %pM =\n", pmk[i].bssid);
+		inff_dbg(CONN, "%*ph\n", WLAN_PMKID_LEN, pmk[i].pmkid);
+
+		err = inff_update_pmklist(cfg, ifp);
+		break;
+	case PMKSA_DELETE:
+		npmk = le32_to_cpu(cfg->pmk_list.npmk);
+		for (i = 0; i < npmk; i++)
+			if (!memcmp(bssid, pmk[i].bssid, ETH_ALEN))
+				break;
+
+		if (npmk > 0 && i < npmk) {
+			for (; i < (npmk - 1); i++) {
+				memcpy(&pmk[i].bssid, &pmk[i + 1].bssid, ETH_ALEN);
+				memcpy(&pmk[i].pmkid, &pmk[i + 1].pmkid,
+				       WLAN_PMKID_LEN);
+			}
+			memset(&pmk[i], 0, sizeof(*pmk));
+			cfg->pmk_list.npmk = cpu_to_le32(npmk - 1);
+		} else {
+			iphy_err(drvr, "Cache entry not found\n");
+			return -EINVAL;
+		}
+
+		err = inff_update_pmklist(cfg, ifp);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+s32 inff_configure_opensecurity(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	s32 wpa_val;
+
+	/* set auth */
+	err = inff_fil_bsscfg_int_set(ifp, "auth", 0);
+	if (err < 0) {
+		iphy_err(drvr, "auth error %d\n", err);
+		return err;
+	}
+	/* set wsec */
+	err = inff_fil_bsscfg_int_set(ifp, "wsec", 0);
+	if (err < 0) {
+		iphy_err(drvr, "wsec error %d\n", err);
+		return err;
+	}
+	/* set upper-layer auth */
+	if (inff_is_ibssmode(ifp->vif))
+		wpa_val = WPA_AUTH_NONE;
+	else
+		wpa_val = WPA_AUTH_DISABLED;
+	err = inff_fil_bsscfg_int_set(ifp, "wpa_auth", wpa_val);
+	if (err < 0) {
+		iphy_err(drvr, "wpa_auth error %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static s32
+inff_configure_wpaie(struct inff_if *ifp,
+		     const struct inff_vs_tlv *wpa_ie,
+		      bool is_rsn_ie)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	u32 auth = 0; /* d11 open authentication */
+	u16 count;
+	s32 err = 0;
+	s32 len;
+	u32 i;
+	u32 wsec;
+	u32 pval = 0;
+	u32 gval = 0;
+	u32 wpa_auth = 0;
+	u32 offset;
+	u8 *data;
+	u16 rsn_cap;
+	u32 wme_bss_disable;
+	u32 mfp;
+
+	inff_dbg(TRACE, "Enter\n");
+	if (!wpa_ie)
+		goto exit;
+
+	len = wpa_ie->len + TLV_HDR_LEN;
+	data = (u8 *)wpa_ie;
+	offset = TLV_HDR_LEN;
+	if (!is_rsn_ie)
+		offset += VS_IE_FIXED_HDR_LEN;
+	else
+		offset += WPA_IE_VERSION_LEN;
+
+	/* check for multicast cipher suite */
+	if (offset + WPA_IE_MIN_OUI_LEN > len) {
+		err = -EINVAL;
+		iphy_err(drvr, "no multicast cipher suite\n");
+		goto exit;
+	}
+
+	if (!inff_valid_wpa_oui(&data[offset], is_rsn_ie)) {
+		err = -EINVAL;
+		iphy_err(drvr, "invalid OUI\n");
+		goto exit;
+	}
+	offset += TLV_OUI_LEN;
+
+	/* pick up multicast cipher */
+	switch (data[offset]) {
+	case WPA_CIPHER_NONE:
+		gval = 0;
+		break;
+	case WPA_CIPHER_WEP_40:
+	case WPA_CIPHER_WEP_104:
+		gval = WEP_ENABLED;
+		break;
+	case WPA_CIPHER_TKIP:
+		gval = TKIP_ENABLED;
+		break;
+	case WPA_CIPHER_AES_CCM:
+		gval = AES_ENABLED;
+		break;
+	default:
+		err = -EINVAL;
+		iphy_err(drvr, "Invalid multi cast cipher info\n");
+		goto exit;
+	}
+
+	offset++;
+	/* walk thru unicast cipher list and pick up what we recognize */
+	count = data[offset] + (data[offset + 1] << 8);
+	offset += WPA_IE_SUITE_COUNT_LEN;
+	/* Check for unicast suite(s) */
+	if (offset + (WPA_IE_MIN_OUI_LEN * count) > len) {
+		err = -EINVAL;
+		iphy_err(drvr, "no unicast cipher suite\n");
+		goto exit;
+	}
+	for (i = 0; i < count; i++) {
+		if (!inff_valid_wpa_oui(&data[offset], is_rsn_ie)) {
+			err = -EINVAL;
+			iphy_err(drvr, "invalid OUI\n");
+			goto exit;
+		}
+		offset += TLV_OUI_LEN;
+		switch (data[offset]) {
+		case WPA_CIPHER_NONE:
+			break;
+		case WPA_CIPHER_WEP_40:
+		case WPA_CIPHER_WEP_104:
+			pval |= WEP_ENABLED;
+			break;
+		case WPA_CIPHER_TKIP:
+			pval |= TKIP_ENABLED;
+			break;
+		case WPA_CIPHER_AES_CCM:
+			pval |= AES_ENABLED;
+			break;
+		default:
+			iphy_err(drvr, "Invalid unicast security info\n");
+		}
+		offset++;
+	}
+	/* walk thru auth management suite list and pick up what we recognize */
+	count = data[offset] + (data[offset + 1] << 8);
+	offset += WPA_IE_SUITE_COUNT_LEN;
+	/* Check for auth key management suite(s) */
+	if (offset + (WPA_IE_MIN_OUI_LEN * count) > len) {
+		err = -EINVAL;
+		iphy_err(drvr, "no auth key mgmt suite\n");
+		goto exit;
+	}
+	for (i = 0; i < count; i++) {
+		if (inff_valid_dpp_suite(&data[offset])) {
+			wpa_auth |= WFA_AUTH_DPP;
+			offset += TLV_OUI_LEN;
+		} else if (inff_valid_wpa_oui(&data[offset], is_rsn_ie)) {
+			offset += TLV_OUI_LEN;
+			switch (data[offset]) {
+			case RSN_AKM_NONE:
+				inff_dbg(TRACE, "RSN_AKM_NONE\n");
+				wpa_auth |= WPA_AUTH_NONE;
+				break;
+			case RSN_AKM_UNSPECIFIED:
+				inff_dbg(TRACE, "RSN_AKM_UNSPECIFIED\n");
+				is_rsn_ie ? (wpa_auth |= WPA2_AUTH_UNSPECIFIED) :
+					    (wpa_auth |= WPA_AUTH_UNSPECIFIED);
+				break;
+			case RSN_AKM_PSK:
+				inff_dbg(TRACE, "RSN_AKM_PSK\n");
+				is_rsn_ie ? (wpa_auth |= WPA2_AUTH_PSK) :
+					    (wpa_auth |= WPA_AUTH_PSK);
+				break;
+			case RSN_AKM_SHA256_PSK:
+				inff_dbg(TRACE, "RSN_AKM_MFP_PSK\n");
+				wpa_auth |= WPA2_AUTH_PSK_SHA256;
+				break;
+			case RSN_AKM_SHA256_1X:
+				inff_dbg(TRACE, "RSN_AKM_MFP_1X\n");
+				wpa_auth |= WPA2_AUTH_1X_SHA256;
+				break;
+			case RSN_AKM_SAE:
+				inff_dbg(TRACE, "RSN_AKM_SAE\n");
+				wpa_auth |= WPA3_AUTH_SAE_PSK;
+				break;
+			case RSN_AKM_OWE:
+				inff_dbg(TRACE, "RSN_AKM_OWE\n");
+				wpa_auth |= WPA3_AUTH_OWE;
+				break;
+			default:
+				iphy_err(drvr, "Invalid key mgmt info\n");
+			}
+		} else {
+			err = -EINVAL;
+			iphy_err(drvr, "invalid OUI\n");
+			goto exit;
+		}
+		offset++;
+	}
+
+	mfp = INFF_MFP_NONE;
+	if (is_rsn_ie) {
+		wme_bss_disable = 1;
+		if ((offset + RSN_CAP_LEN) <= len) {
+			rsn_cap = data[offset] + (data[offset + 1] << 8);
+			if (rsn_cap & RSN_CAP_PTK_REPLAY_CNTR_MASK)
+				wme_bss_disable = 0;
+			if (rsn_cap & RSN_CAP_MFPR_MASK) {
+				inff_dbg(TRACE, "MFP Required\n");
+				mfp = INFF_MFP_REQUIRED;
+				/* Firmware only supports mfp required in
+				 * combination with WPA2_AUTH_PSK_SHA256,
+				 * WPA2_AUTH_1X_SHA256, or WPA3_AUTH_SAE_PSK.
+				 */
+				if (!(wpa_auth & (WPA2_AUTH_PSK_SHA256 |
+						  WPA2_AUTH_1X_SHA256 |
+						  WFA_AUTH_DPP |
+						  WPA3_AUTH_SAE_PSK |
+						  WPA3_AUTH_OWE))) {
+					err = -EINVAL;
+					goto exit;
+				}
+
+				/* Firmware has requirement that WPA2_AUTH_PSK/
+				 * WPA2_AUTH_UNSPECIFIED be set, if SHA256 OUI
+				 * is to be included in the rsn ie.
+				 */
+				if (wpa_auth & WPA2_AUTH_PSK_SHA256)
+					wpa_auth |= WPA2_AUTH_PSK;
+				else if (wpa_auth & WPA2_AUTH_1X_SHA256)
+					wpa_auth |= WPA2_AUTH_UNSPECIFIED;
+			} else if (rsn_cap & RSN_CAP_MFPC_MASK) {
+				inff_dbg(TRACE, "MFP Capable\n");
+				mfp = INFF_MFP_CAPABLE;
+			}
+		}
+		offset += RSN_CAP_LEN;
+		/* set wme_bss_disable to sync RSN Capabilities */
+		err = inff_fil_bsscfg_int_set(ifp, "wme_bss_disable",
+					      wme_bss_disable);
+		if (err < 0) {
+			iphy_err(drvr, "wme_bss_disable error %d\n", err);
+			goto exit;
+		}
+
+		/* Skip PMKID cnt as it is know to be 0 for AP. */
+		offset += RSN_PMKID_COUNT_LEN;
+
+		/* See if there is BIP wpa suite left for MFP */
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_MFP) &&
+		    ((offset + WPA_IE_MIN_OUI_LEN) <= len)) {
+			err = inff_fil_bsscfg_data_set(ifp, "bip",
+						       &data[offset],
+						       WPA_IE_MIN_OUI_LEN);
+			if (err < 0) {
+				iphy_err(drvr, "bip error %d\n", err);
+				goto exit;
+			}
+		}
+	}
+	/* FOR WPS , set SES_OW_ENABLED */
+	wsec = (pval | gval | SES_OW_ENABLED);
+
+	/* set auth */
+	err = inff_fil_bsscfg_int_set(ifp, "auth", auth);
+	if (err < 0) {
+		iphy_err(drvr, "auth error %d\n", err);
+		goto exit;
+	}
+	/* set wsec */
+	err = inff_fil_bsscfg_int_set(ifp, "wsec", wsec);
+	if (err < 0) {
+		iphy_err(drvr, "wsec error %d\n", err);
+		goto exit;
+	}
+	/* Configure MFP, this needs to go after wsec otherwise the wsec command
+	 * will overwrite the values set by MFP
+	 */
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_MFP)) {
+		err = inff_fil_bsscfg_int_set(ifp, "mfp", mfp);
+		if (err < 0) {
+			iphy_err(drvr, "mfp error %d\n", err);
+			goto exit;
+		}
+	}
+	/* set upper-layer auth */
+	err = inff_fil_bsscfg_int_set(ifp, "wpa_auth", wpa_auth);
+	if (err < 0) {
+		iphy_err(drvr, "wpa_auth error %d\n", err);
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+static s32
+inff_parse_configure_sae_pwe(struct inff_if *ifp,
+			     struct cfg80211_ap_settings *settings)
+{
+	s32 err = 0;
+	const struct inff_tlv *rsnx_ie;
+	const struct inff_tlv *ext_rate_ie;
+	const struct inff_tlv *supp_rate_ie;
+	u8 ie_len, i;
+	bool support_sae_h2e = false, must_sae_h2e = false;
+	u32 wpa_auth = 0;
+
+	/* get configured wpa_auth */
+	err = inff_fil_bsscfg_int_get(ifp, "wpa_auth", &wpa_auth);
+	if ((wpa_auth & WPA3_AUTH_SAE_PSK) == 0) {
+		/* wpa_auth is not SAE, ignore sae_pwe. */
+		inff_dbg(INFO, "wpa_auth is not SAE:0x%x\n", wpa_auth);
+		return 0;
+	}
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_SAE_EXT)) {
+		err = inff_fil_iovar_int_set(ifp, "extsae_pwe", 0);
+		if (err) {
+			inff_err("extsae_pwe iovar is not supported\n");
+			return -EOPNOTSUPP;
+		}
+
+		rsnx_ie = inff_parse_tlvs((u8 *)settings->beacon.tail,
+					  settings->beacon.tail_len,
+					  WLAN_EID_RSNX);
+		if (rsnx_ie) {
+			ie_len = rsnx_ie->len;
+			if (ie_len) {
+				if (rsnx_ie->data[0] & WLAN_RSNX_CAPA_SAE_H2E)
+					support_sae_h2e = true;
+			}
+			inff_dbg(INFO, "found RSNX IE, support_sae_h2e:%d\n",
+				 support_sae_h2e);
+		}
+
+		/* found rsnx_ie with SAE_H2E, check the bss selector to know if it is a H2E only */
+		if (support_sae_h2e) {
+			supp_rate_ie = inff_parse_tlvs((u8 *)settings->beacon.head,
+						       settings->beacon.head_len,
+						       WLAN_EID_SUPP_RATES);
+			ext_rate_ie = inff_parse_tlvs((u8 *)settings->beacon.tail,
+						      settings->beacon.tail_len,
+						      WLAN_EID_EXT_SUPP_RATES);
+			if (ext_rate_ie) {
+				ie_len = ext_rate_ie->len;
+				for (i = 0; i < ie_len; i++) {
+					if (ext_rate_ie->data[i] == SAE_H2E_ONLY_ENABLE) {
+						must_sae_h2e = true;
+						break;
+					}
+				}
+			}
+
+			/* if we cannot found H2E only selector in ext_supp_rate ie.
+			 * traversal supp_rate ie to make sure it really doesn't exist.
+			 */
+			if (!must_sae_h2e && supp_rate_ie) {
+				ie_len = supp_rate_ie->len;
+				for (i = 0; i < ie_len; i++) {
+					if (supp_rate_ie->data[i] == SAE_H2E_ONLY_ENABLE) {
+						must_sae_h2e = true;
+						break;
+					}
+				}
+			}
+			inff_dbg(INFO, "must_sae_h2e:%d\n", must_sae_h2e);
+		}
+
+		if (must_sae_h2e) /* support SAE H2E only */
+			err = inff_fil_iovar_int_set(ifp, "extsae_pwe", 1);
+		else if (support_sae_h2e) /* support SAE P&H and H2E both */
+			err = inff_fil_iovar_int_set(ifp, "extsae_pwe", 2);
+		else /* support SAE P&H only */
+			err = inff_fil_iovar_int_set(ifp, "extsae_pwe", 0);
+	}
+
+	return err;
+}
+
+s32
+inff_parse_configure_security(struct inff_if *ifp,
+			      struct cfg80211_ap_settings *settings,
+			      enum nl80211_iftype dev_role)
+{
+	const struct inff_tlv *rsn_ie;
+	const struct inff_vs_tlv *wpa_ie;
+	s32 err = 0;
+
+	/* find the RSN_IE */
+	rsn_ie = inff_parse_tlvs((u8 *)settings->beacon.tail,
+				 settings->beacon.tail_len, WLAN_EID_RSN);
+
+	/* find the WPA_IE */
+	wpa_ie = inff_find_wpaie((u8 *)settings->beacon.tail,
+				 settings->beacon.tail_len);
+
+	if (wpa_ie || rsn_ie) {
+		inff_dbg(TRACE, "WPA(2) IE is found\n");
+		if (wpa_ie) {
+			/* WPA IE */
+			err = inff_configure_wpaie(ifp, wpa_ie, false);
+			if (err < 0)
+				return err;
+		} else {
+			struct inff_vs_tlv *tmp_ie;
+
+			tmp_ie = (struct inff_vs_tlv *)rsn_ie;
+
+			/* RSN IE */
+			err = inff_configure_wpaie(ifp, tmp_ie, true);
+			if (err < 0)
+				return err;
+
+			err = inff_parse_configure_sae_pwe(ifp, settings);
+			if (err < 0)
+				return err;
+		}
+	} else {
+		inff_dbg(TRACE, "No WPA(2) IEs found\n");
+		inff_configure_opensecurity(ifp);
+	}
+
+	return err;
+}
+
+#ifdef CONFIG_PM
+int
+inff_cfg80211_set_rekey_data(struct wiphy *wiphy, struct net_device *ndev,
+			     struct cfg80211_gtk_rekey_data *gtk)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_gtk_keyinfo_le gtk_le;
+	int ret;
+
+	inff_dbg(TRACE, "Enter, bssidx=%d\n", ifp->bsscfgidx);
+
+	memcpy(gtk_le.kck, gtk->kck, sizeof(gtk_le.kck));
+	memcpy(gtk_le.kek, gtk->kek, sizeof(gtk_le.kek));
+	memcpy(gtk_le.replay_counter, gtk->replay_ctr,
+	       sizeof(gtk_le.replay_counter));
+
+	ret = inff_fil_iovar_data_set(ifp, "gtk_key_info", &gtk_le,
+				      sizeof(gtk_le));
+	if (ret < 0)
+		iphy_err(drvr, "gtk_key_info iovar failed: ret=%d\n", ret);
+
+	return ret;
+}
+#endif
diff --git a/drivers/net/wireless/infineon/inffmac/security.h b/drivers/net/wireless/infineon/inffmac/security.h
new file mode 100644
index 000000000000..ebb70175f4cf
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/security.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_SECURITY_H
+#define INFF_SECURITY_H
+
+/* Enumerate crypto algorithms */
+#define	CRYPTO_ALGO_OFF			0
+#define	CRYPTO_ALGO_WEP1		1
+#define	CRYPTO_ALGO_TKIP		2
+#define	CRYPTO_ALGO_WEP128		3
+#define CRYPTO_ALGO_AES_CCM		4
+#define CRYPTO_ALGO_AES_RESERVED1	5
+#define CRYPTO_ALGO_AES_RESERVED2	6
+#define CRYPTO_ALGO_NALG		7
+
+#define CRYPTO_ALGO_AES_GCM     14  /* 128 bit GCM */
+#define CRYPTO_ALGO_AES_CCM256  15  /* 256 bit CCM */
+#define CRYPTO_ALGO_AES_GCM256  16  /* 256 bit GCM */
+#define CRYPTO_ALGO_BIP_CMAC256 17  /* 256 bit BIP CMAC */
+#define CRYPTO_ALGO_BIP_GMAC    18  /* 128 bit BIP GMAC */
+#define CRYPTO_ALGO_BIP_GMAC256 19  /* 256 bit BIP GMAC */
+
+/* wireless security bitvec */
+
+#define WEP_ENABLED		0x0001
+#define TKIP_ENABLED		0x0002
+#define AES_ENABLED		0x0004
+#define WSEC_SWFLAG		0x0008
+/* to go into transition mode without setting wep */
+#define SES_OW_ENABLED		0x0040
+/* MFP */
+#define MFP_CAPABLE		0x0200
+#define MFP_REQUIRED		0x0400
+
+/* WPA authentication mode bitvec */
+#define WPA_AUTH_DISABLED	0x0000	/* Legacy (i.e., non-WPA) */
+#define WPA_AUTH_NONE		0x0001	/* none (IBSS) */
+#define WPA_AUTH_UNSPECIFIED	0x0002	/* over 802.1x */
+#define WPA_AUTH_PSK		0x0004	/* Pre-shared key */
+#define WPA_AUTH_RESERVED1	0x0008
+#define WPA_AUTH_RESERVED2	0x0010
+
+#define WPA2_AUTH_RESERVED1	0x0020
+#define WPA2_AUTH_UNSPECIFIED	0x0040	/* over 802.1x */
+#define WPA2_AUTH_PSK		0x0080	/* Pre-shared key */
+#define WPA2_AUTH_RESERVED3	0x0200
+#define WPA2_AUTH_RESERVED4	0x0400
+#define WPA2_AUTH_RESERVED5	0x0800
+#define WPA2_AUTH_1X_SHA256	0x1000  /* 1X with SHA256 key derivation */
+#define WPA2_AUTH_FT		0x4000	/* Fast BSS Transition */
+#define WPA2_AUTH_PSK_SHA256	0x8000	/* PSK with SHA256 key derivation */
+
+#define WPA3_AUTH_SAE_PSK	0x40000	/* SAE with 4-way handshake */
+#define WPA3_AUTH_SAE_FBT       0x80000 /* FT authentication over SAE */
+#define WPA3_AUTH_SAE_FT_1X	0x2000000 /* SAE with FT 1X */
+#define WPA3_AUTH_OWE		0x100000 /* OWE */
+#define WFA_AUTH_DPP		0x200000 /* WFA DPP AUTH */
+#define WPA3_AUTH_1X_SUITE_B_SHA384	0x400000 /* Suite B-192 SHA384 */
+
+#define DPP_AKM_SUITE_TYPE		2
+
+/* WPA3 1x with SHA256 key derivation.
+ * Shares the same value as WPA2_AUTH_1X_SHA256 since the value of
+ * akm-suite is the same for both
+ */
+#define WPA3_AUTH_1X_SHA256 WPA2_AUTH_1X_SHA256
+
+#define WFA_OUI			"\x50\x6F\x9A"	/* WFA OUI */
+
+#define DOT11_DEFAULT_RTS_LEN		2347
+#define DOT11_DEFAULT_FRAG_LEN		2346
+
+#define DOT11_ICV_AES_LEN		8
+#define DOT11_QOS_LEN			2
+#define DOT11_IV_MAX_LEN		8
+#define DOT11_A4_HDR_LEN		30
+
+#define HT_CAP_RX_STBC_NO		0x0
+#define HT_CAP_RX_STBC_ONE_STREAM	0x1
+
+#define WPA_PROTO_WPA BIT(0)
+#define WPA_PROTO_RSN BIT(1)
+
+/* algo bit vector */
+#define KEY_ALGO_MASK(_algo)	(1 << (_algo))
+/* version of the wl_wsec_info structure */
+#define WL_WSEC_INFO_VERSION 0x01
+
+/* start enum value for BSS properties */
+#define WL_WSEC_INFO_BSS_BASE 0x0100
+#define WL_WSEC_INFO_BSS_ALGOS (WL_WSEC_INFO_BSS_BASE + 6)
+
+#define BSS_MEMBERSHIP_SELECTOR_SAE_H2E_ONLY 123
+#define BSS_MEMBERSHIP_SELECTOR_SET 0x80
+#define SAE_H2E_ONLY_ENABLE (BSS_MEMBERSHIP_SELECTOR_SAE_H2E_ONLY | \
+				BSS_MEMBERSHIP_SELECTOR_SET)
+
+#define WPA_CIPHER_NONE			0	/* None */
+#define WPA_CIPHER_WEP_40		1	/* WEP (40-bit) */
+#define WPA_CIPHER_TKIP			2	/* TKIP: default for WPA */
+#define WPA_CIPHER_AES_CCM		4	/* AES (CCM) */
+#define WPA_CIPHER_WEP_104		5	/* WEP (104-bit) */
+
+#define RSN_AKM_NONE			0	/* None (IBSS) */
+#define RSN_AKM_UNSPECIFIED		1	/* Over 802.1x */
+#define RSN_AKM_PSK			2	/* Pre-shared Key */
+#define RSN_AKM_SHA256_1X		5	/* SHA256, 802.1X */
+#define RSN_AKM_SHA256_PSK		6	/* SHA256, Pre-shared Key */
+#define RSN_AKM_SAE			8	/* SAE */
+#define RSN_AKM_OWE			18	/* OWE */
+#define RSN_CAP_LEN			2	/* Length of RSN capabilities */
+#define RSN_CAP_PTK_REPLAY_CNTR_MASK	(BIT(2) | BIT(3))
+#define RSN_CAP_MFPR_MASK		BIT(6)
+#define RSN_CAP_MFPC_MASK		BIT(7)
+#define RSN_PMKID_COUNT_LEN		2
+
+#define INFF_KEY_MGMT_ID_WPA			BIT(0)
+#define INFF_KEY_MGMT_ID_WPA2			BIT(1)
+#define INFF_KEY_MGMT_ID_WPA_PSK		BIT(2)
+#define INFF_KEY_MGMT_ID_WPA2_PSK		BIT(3)
+#define INFF_KEY_MGMT_ID_WPA_NONE		BIT(4)
+#define INFF_KEY_MGMT_ID_FT			BIT(5)
+#define INFF_KEY_MGMT_ID_FT_PSK			BIT(6)
+#define INFF_KEY_MGMT_ID_WAPI_PSK		BIT(7)
+#define INFF_KEY_MGMT_ID_SUITE_B		BIT(8)
+#define INFF_KEY_MGMT_ID_SUITE_B_192		BIT(9)
+#define INFF_KEY_MGMT_ID_OWE			BIT(10)
+#define INFF_KEY_MGMT_ID_DPP			BIT(11)
+#define INFF_KEY_MGMT_ID_FILS_SHA256		BIT(12)
+#define INFF_KEY_MGMT_ID_FILS_SHA384		BIT(13)
+#define INFF_KEY_MGMT_ID_FT_FILS_SHA256		BIT(14)
+#define INFF_KEY_MGMT_ID_FT_FILS_SHA384		BIT(15)
+#define INFF_KEY_MGMT_ID_SAE			BIT(16)
+#define INFF_KEY_MGMT_ID_802_1X_SHA256		BIT(17)
+#define INFF_KEY_MGMT_ID_PSK_SHA256		BIT(18)
+#define INFF_KEY_MGMT_ID_TPK_HANDSHAKE		BIT(19)
+#define INFF_KEY_MGMT_ID_FT_SAE			BIT(20)
+#define INFF_KEY_MGMT_ID_FT_802_1X_SHA384	BIT(21)
+#define INFF_KEY_MGMT_ID_CCKM			BIT(22)
+#define INFF_KEY_MGMT_ID_OSEN			BIT(23)
+
+static inline int wpa_akm_ft(int akm)
+{
+	return !!((akm == WLAN_AKM_SUITE_FT_PSK) ||
+		(akm == WLAN_AKM_SUITE_FT_8021X) ||
+		(akm == WLAN_AKM_SUITE_FT_8021X_SHA384) ||
+		(akm == WLAN_AKM_SUITE_FT_OVER_SAE) ||
+		(akm == WLAN_AKM_SUITE_FT_FILS_SHA256) ||
+		(akm == WLAN_AKM_SUITE_FT_FILS_SHA384) ||
+		(akm == WLAN_AKM_SUITE_FT_PSK_SHA384));
+}
+
+enum inff_pmksa_action {
+	PMKSA_SET = 0,
+	PMKSA_DELETE = 1
+};
+
+/* tlv used to return wl_wsec_info properties */
+struct wl_wsec_info_tlv {
+	u16 type;
+	u16 len;	/* data length */
+	u8 data[1];	/* data follows */
+};
+
+/* input/output data type for wsec_info iovar */
+struct wl_wsec_info {
+	u8 version; /* structure version */
+	u8 pad[2];
+	u8 num_tlvs;
+	struct wl_wsec_info_tlv tlvs[1]; /* tlv data follows */
+};
+
+struct inff_owe_info_buf {
+	bool with_pmkid;
+	bool with_ecdh;/* if doing PMK Caching, might not have ECDH IE. */
+	__le16 status_le16;/* hostapd gives status of Assoc Resp */
+	u8 peer_mac[ETH_ALEN];
+	u8 pmkid[WLAN_PMKID_LEN];
+	u8 ecdh_ie_info[];
+};
+
+bool inff_has_pmkid(const u8 *parse, u32 len, u32 *offset_in_ie);
+int inff_set_pmk(struct inff_if *ifp, const u8 *pmk_data, u16 pmk_len);
+int send_key_to_dongle(struct inff_if *ifp, struct inff_wsec_key *key);
+s32 wl_set_wsec_info_algos(struct inff_if *ifp, u32 algos, u32 mask);
+
+void inff_cfg80211_reconfigure_wep(struct inff_if *ifp);
+
+s32 inff_update_pmklist(struct inff_cfg80211_info *cfg, struct inff_if *ifp);
+s32 inff_parse_configure_security(struct inff_if *ifp,
+				  struct cfg80211_ap_settings *settings,
+				  enum nl80211_iftype dev_role);
+s32 inff_configure_opensecurity(struct inff_if *ifp);
+s32 inff_update_pmksa(struct inff_cfg80211_info *cfg,
+		      struct inff_if *ifp,
+		      const u8 *bssid,
+		      const u8 *pmkid,
+		      enum inff_pmksa_action action);
+
+#ifdef CONFIG_PM
+int
+inff_cfg80211_set_rekey_data(struct wiphy *wiphy, struct net_device *ndev,
+			     struct cfg80211_gtk_rekey_data *gtk);
+#endif /* CONFIG_PM*/
+
+#endif /* INFF_SECURITY_H */
-- 
2.25.1


