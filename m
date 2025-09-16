Return-Path: <linux-wireless+bounces-27393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840EAB7DC74
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA651C063A0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201F2E4274;
	Tue, 16 Sep 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="QSGuRQ04"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450763294FD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061649; cv=none; b=jNiMWJWparECtPVh9yu1KZDRdZsVfwFmUJeCHWHPBTVJEXp+Igf0CFCA7olow5DOpTcRFrCny4QtpKNpPrybGrkoUWnjxU51ZYXu4q/ilTiBF6OMnfDFSh9uYt6wXmEmXwI6kCQwo6ZFRMXHyarIpl60TLlhRv6nWaKXhtRMdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061649; c=relaxed/simple;
	bh=VnF1uoM+vAiF1lywa/44PlxWavdnTI9FQOCwWMy9rk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhifTl2kZJ0azutT8qNeVWOwmmyAORUmuacyqS/rAnnhtcXlv0u/Ve9nbpRy+2AQXIVDLB8ny6d3RtVDQTsHg/bw/p5sJmkYSaJ0S5DvYfM2Mc/syMwu+qFEoAmmIqAoIeMQCb8bz7bM8HdSwzhizTOh2LiQn3IDs6nSGzgctK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=QSGuRQ04; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061647; x=1789597647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VnF1uoM+vAiF1lywa/44PlxWavdnTI9FQOCwWMy9rk4=;
  b=QSGuRQ04+yr36SLp96Epfh35cbziPOYlFxTrJbV9loe1Xoz7lDRGP1Sf
   f2GZjHWR8VLsMdHI3lXQPZ1qaX6/E7SZomVKWg1cy0iOvcewHRagSBEKL
   v1bHQN7PZnvgpJTscWLI7D1OaCbnzw3DcqNk3M8W5TsfVS9Oyp919bP6s
   U=;
X-CSE-ConnectionGUID: g+Z0qgGPT7Ww6Z3Mx0p4iA==
X-CSE-MsgGUID: Q3AkqiCFSM6PL6zqcP+Azg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918682"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918682"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:27:25 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:27:24 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:27:20 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 38/57] wifi: inffmac: add fwil_types.h
Date: Wed, 17 Sep 2025 03:47:58 +0530
Message-ID: <20250916221821.4387-44-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE827.infineon.com (172.23.29.20)

Driver definitions of the data structures expected by the Device
firmware when the driver sends data as part of the control
commands to the device.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/fwil_types.h    | 1311 +++++++++++++++++
 1 file changed, 1311 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwil_types.h

diff --git a/drivers/net/wireless/infineon/inffmac/fwil_types.h b/drivers/net/wireless/infineon/inffmac/fwil_types.h
new file mode 100644
index 000000000000..335bc86334e6
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/fwil_types.h
@@ -0,0 +1,1311 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_FWIL_TYPES_H
+#define INFF_FWIL_TYPES_H
+
+#include <linux/if_ether.h>
+
+#define INFF_FIL_ACTION_FRAME_SIZE	1800
+
+#define INFF_AF_PARAM_V2_FW_MAJOR 13
+#define INFF_AF_PARAM_V2_FW_MINOR 2
+
+#define INFF_AUTH_STATUS_V2_FW_MAJOR 13
+#define INFF_AUTH_STATUS_V2_FW_MINOR 3
+
+#define	INFF_BSS_INFO_VERSION	109 /* curr ver of inff_bss_info_le struct */
+#define INFF_BSS_RSSI_ON_CHANNEL	0x0004
+
+#define INFF_STA_INF        0x00000001	/* Running a Infineon driver */
+#define INFF_STA_WME        0x00000002	/* WMM association */
+#define INFF_STA_NONERP     0x00000004	/* No ERP */
+#define INFF_STA_AUTHE      0x00000008	/* Authenticated */
+#define INFF_STA_ASSOC      0x00000010	/* Associated */
+#define INFF_STA_AUTHO      0x00000020	/* Authorized */
+#define INFF_STA_WDS        0x00000040	/* Wireless Distribution System */
+#define INFF_STA_WDS_LINKUP 0x00000080	/* WDS traffic/probes flowing properly */
+#define INFF_STA_PS         0x00000100	/* STA is in power save mode from AP's viewpoint */
+#define INFF_STA_APSD_BE    0x00000200	/* APSD delv/trigger for AC_BE is default enabled */
+#define INFF_STA_APSD_BK    0x00000400	/* APSD delv/trigger for AC_BK is default enabled */
+#define INFF_STA_APSD_VI    0x00000800	/* APSD delv/trigger for AC_VI is default enabled */
+#define INFF_STA_APSD_VO    0x00001000	/* APSD delv/trigger for AC_VO is default enabled */
+#define INFF_STA_N_CAP      0x00002000	/* STA 802.11n capable */
+#define INFF_STA_SCBSTATS   0x00004000	/* Per STA debug stats */
+#define INFF_STA_AMPDU_CAP  0x00008000	/* STA AMPDU capable */
+#define INFF_STA_AMSDU_CAP  0x00010000	/* STA AMSDU capable */
+#define INFF_STA_MIMO_PS    0x00020000	/* mimo ps mode is enabled */
+#define INFF_STA_MIMO_RTS   0x00040000	/* send rts in mimo ps mode */
+#define INFF_STA_RIFS_CAP   0x00080000	/* rifs enabled */
+#define INFF_STA_VHT_CAP    0x00100000	/* STA VHT(11ac) capable */
+#define INFF_STA_WPS        0x00200000	/* WPS state */
+#define INFF_STA_DWDS_CAP   0x01000000	/* DWDS CAP */
+#define INFF_STA_DWDS       0x02000000	/* DWDS active */
+
+/* size of inff_scan_params not including variable length array */
+#define INFF_SCAN_PARAMS_FIXED_SIZE	64
+#define INFF_SCAN_PARAMS_V2_FIXED_SIZE	72
+
+/* version of inff_scan_params structure */
+#define INFF_SCAN_PARAMS_VERSION_V2	2
+
+/* masks for channel and ssid count */
+#define INFF_SCAN_PARAMS_COUNT_MASK	0x0000ffff
+#define INFF_SCAN_PARAMS_NSSID_SHIFT	16
+
+/* scan type definitions */
+#define INFF_SCANTYPE_DEFAULT		0xFF
+#define INFF_SCANTYPE_ACTIVE		0
+#define INFF_SCANTYPE_PASSIVE		1
+
+#define INFF_WSEC_MAX_PSK_LEN		32
+#define INFF_WSEC_PMK_LEN_SUITEB_192   48
+#define INFF_WSEC_MAX_PMK_LEN		64	/* SUITE-B-192's PMK is 48 bytes */
+#define	INFF_WSEC_PASSPHRASE		BIT(0)
+
+#define INFF_WSEC_MAX_SAE_PASSWORD_LEN 128
+
+/* primary (ie tx) key */
+#define INFF_PRIMARY_KEY		BIT(1)
+#define DOT11_BSSTYPE_ANY		2
+#define INFF_ESCAN_REQ_VERSION		1
+#define INFF_ESCAN_REQ_VERSION_V2	2
+
+#define INFF_MAXRATES_IN_SET		16	/* max # of rates in rateset */
+
+/* OBSS Coex Auto/On/Off */
+#define INFF_OBSS_COEX_AUTO		(-1)
+#define INFF_OBSS_COEX_OFF		0
+#define INFF_OBSS_COEX_ON		1
+
+/* WOWL bits */
+/* Wakeup on Magic packet: */
+#define INFF_WOWL_MAGIC		BIT(0)
+/* Wakeup on Netpattern */
+#define INFF_WOWL_NET			BIT(1)
+/* Wakeup on loss-of-link due to Disassoc/Deauth: */
+#define INFF_WOWL_DIS			BIT(2)
+/* Wakeup on retrograde TSF: */
+#define INFF_WOWL_RETR			BIT(3)
+/* Wakeup on loss of beacon: */
+#define INFF_WOWL_BCN			BIT(4)
+/* Wakeup after test: */
+#define INFF_WOWL_TST			BIT(5)
+/* Wakeup after PTK refresh: */
+#define INFF_WOWL_M1			BIT(6)
+/* Wakeup after receipt of EAP-Identity Req: */
+#define INFF_WOWL_EAPID		BIT(7)
+/* Wakeind via PME(0) or GPIO(1): */
+#define INFF_WOWL_PME_GPIO		BIT(8)
+/* need tkip phase 1 key to be updated by the driver: */
+#define INFF_WOWL_NEEDTKIP1		BIT(9)
+/* enable wakeup if GTK fails: */
+#define INFF_WOWL_GTK_FAILURE		BIT(10)
+/* support extended magic packets: */
+#define INFF_WOWL_EXTMAGPAT		BIT(11)
+/* support ARP/NS/keepalive offloading: */
+#define INFF_WOWL_ARPOFFLOAD		BIT(12)
+/* read protocol version for EAPOL frames: */
+#define INFF_WOWL_WPA2			BIT(13)
+/* If the bit is set, use key rotaton: */
+#define INFF_WOWL_KEYROT		BIT(14)
+/* If the bit is set, frm received was bcast frame: */
+#define INFF_WOWL_BCAST		BIT(15)
+/* If the bit is set, scan offload is enabled: */
+#define INFF_WOWL_SCANOL		BIT(16)
+/* Wakeup on tcpkeep alive timeout: */
+#define INFF_WOWL_TCPKEEP_TIME		BIT(17)
+/* Wakeup on mDNS Conflict Resolution: */
+#define INFF_WOWL_MDNS_CONFLICT	BIT(18)
+/* Wakeup on mDNS Service Connect: */
+#define INFF_WOWL_MDNS_SERVICE		BIT(19)
+/* tcp keepalive got data: */
+#define INFF_WOWL_TCPKEEP_DATA		BIT(20)
+/* Firmware died in wowl mode: */
+#define INFF_WOWL_FW_HALT		BIT(21)
+/* Enable detection of radio button changes: */
+#define INFF_WOWL_ENAB_HWRADIO		BIT(22)
+/* Offloads detected MIC failure(s): */
+#define INFF_WOWL_MIC_FAIL		BIT(23)
+/* Wakeup in Unassociated state (Net/Magic Pattern): */
+#define INFF_WOWL_UNASSOC		BIT(24)
+/* Wakeup if received matched secured pattern: */
+#define INFF_WOWL_SECURE		BIT(25)
+/* Wakeup on finding preferred network */
+#define INFF_WOWL_PFN_FOUND		BIT(27)
+/* Wakeup on receiving pairwise key EAP packets: */
+#define WIPHY_WOWL_EAP_PK		BIT(28)
+/* Link Down indication in WoWL mode: */
+#define INFF_WOWL_LINKDOWN		BIT(31)
+
+#define INFF_WOWL_MAXPATTERNS		16
+#define INFF_WOWL_MAXPATTERNSIZE	128
+
+/* IPV4 address length */
+#define INFF_IPV4_ADDR_LEN             4
+/* IPV6 address length */
+#define INFF_IPV6_ADDR_LEN             16
+
+enum {
+	INFF_UNICAST_FILTER_NUM = 0,
+	INFF_BROADCAST_FILTER_NUM,
+	INFF_MULTICAST4_FILTER_NUM,
+	INFF_MULTICAST6_FILTER_NUM,
+	INFF_MDNS_FILTER_NUM,
+	INFF_ARP_FILTER_NUM,
+	INFF_BROADCAST_ARP_FILTER_NUM,
+	MAX_PKT_FILTER_COUNT
+};
+
+#define MAX_PKTFILTER_PATTERN_SIZE		16
+#define MAX_PKTFILTER_PATTERN_FILL_SIZE	(MAX_PKTFILTER_PATTERN_SIZE * 2)
+
+#define INFF_COUNTRY_BUF_SZ		4
+#define INFF_ANT_MAX			4
+
+#define INFF_MAX_ASSOCLIST		128
+
+#define INFF_TXBF_SU_BFE_CAP		BIT(0)
+#define INFF_TXBF_MU_BFE_CAP		BIT(1)
+#define INFF_TXBF_SU_BFR_CAP		BIT(0)
+#define INFF_TXBF_MU_BFR_CAP		BIT(1)
+
+#define	INFF_MAXPMKID			16	/* max # PMKID cache entries */
+#define INFF_NUMCHANNELS		64
+
+#define INFF_PFN_MACADDR_CFG_VER	1
+#define INFF_PFN_MAC_OUI_ONLY		BIT(0)
+#define INFF_PFN_SET_MAC_UNASSOC	BIT(1)
+
+#define INFF_MCSSET_LEN		16
+
+#define INFF_RSN_KCK_LENGTH		16
+#define INFF_RSN_KEK_LENGTH		16
+#define INFF_RSN_REPLAY_LEN		8
+
+#define INFF_MFP_NONE			0
+#define INFF_MFP_CAPABLE		1
+#define INFF_MFP_REQUIRED		2
+
+#define INFF_VHT_CAP_MCS_MAP_NSS_MAX	8
+
+#define INFF_HE_CAP_MCS_MAP_NSS_MAX	8
+
+#define INFF_PMKSA_VER_2		2
+#define INFF_PMKSA_VER_3		3
+#define INFF_PMKSA_NO_EXPIRY		0xffffffff
+
+#define INFF_EXTAUTH_START	1
+#define INFF_EXTAUTH_ABORT	2
+#define INFF_EXTAUTH_FAIL	3
+#define INFF_EXTAUTH_SUCCESS	4
+
+/* mchan configuration (ap timeslot : sta timeslot)*/
+#define INFF_MCHAN_CONF_DEFAULT	0 /* mchan_algo=2 (25ms:25ms) */
+#define INFF_MCHAN_CONF_VEDIO 1 /* mchan_algo=5 (29ms:21ms) */
+#define INFF_MCHAN_CONF_AUDIO 2 /* mchan_algo=1, mchan_bw=32 (68ms:32ms) */
+/* mchan algo in dongle */
+#define INFF_MCHAN_DEFAULT_ALGO 0
+#define INFF_MCHAN_BANDWIDTH_ALGO 1
+#define INFF_MCHAN_SI_ALGO 2
+#define INFF_MCHAN_DYNAMIC_BW_ALGO 3
+#define INFF_MCHAN_ALTERNATE_SWITCHING 4
+#define INFF_MCHAN_ASYMMETRIC_SI_ALGO 5
+#define INFF_MCHAN_BANDWIDTH_VAL 32
+
+/* MAX_CHUNK_LEN is the maximum length for data passing to firmware in each
+ * ioctl. It is relatively small because firmware has small maximum size input
+ * playload restriction for ioctls.
+ */
+#define MAX_CHUNK_LEN			1400
+
+#define DLOAD_HANDLER_VER		1	/* Downloader version */
+#define DLOAD_FLAG_VER_MASK		0xf000	/* Downloader version mask */
+#define DLOAD_FLAG_VER_SHIFT		12	/* Downloader version shift */
+
+#define DL_BEGIN			0x0002
+#define DL_END				0x0004
+
+#define DL_TYPE_CLM			2
+
+#define MAX_RSSI_LEVELS			8
+#define WL_RSSI_EVENT_VERSION_OLD	0
+#define WL_RSSI_EVENT_VERSION_NEW	1
+
+/* Offloads profile configuration version */
+#define INFF_OFFLOAD_CFG_VER_1		1
+
+extern unsigned int inff_offload_prof;
+extern unsigned int inff_offload_feat;
+
+/* join preference types for join_pref iovar */
+enum inff_join_pref_types {
+	INFF_JOIN_PREF_RSSI = 1,
+	INFF_JOIN_PREF_WPA,
+	INFF_JOIN_PREF_BAND,
+	INFF_JOIN_PREF_RSSI_DELTA,
+};
+
+enum inff_fil_p2p_if_types {
+	INFF_FIL_P2P_IF_CLIENT,
+	INFF_FIL_P2P_IF_GO,
+	INFF_FIL_P2P_IF_DYNBCN_GO,
+	INFF_FIL_P2P_IF_DEV,
+};
+
+enum inff_wowl_pattern_type {
+	INFF_WOWL_PATTERN_TYPE_BITMAP = 0,
+	INFF_WOWL_PATTERN_TYPE_ARP,
+	INFF_WOWL_PATTERN_TYPE_NA
+};
+
+struct inff_fil_p2p_if_le {
+	u8 addr[ETH_ALEN];
+	__le16 type;
+	__le16 chspec;
+};
+
+struct inff_fil_chan_info_le {
+	__le32 hw_channel;
+	__le32 target_channel;
+	__le32 scan_channel;
+};
+
+struct inff_fil_action_frame_le {
+	u8	da[ETH_ALEN];
+	__le16	len;
+	__le32	packet_id;
+	u8	data[INFF_FIL_ACTION_FRAME_SIZE];
+};
+
+struct inff_fil_af_params_le {
+	__le32					channel;
+	__le32					dwell_time;
+	u8					bssid[ETH_ALEN];
+	u8					pad[2];
+	struct inff_fil_action_frame_le	action_frame;
+};
+
+struct inff_fil_af_params_v2_le {
+	__le16					version;
+	__le16					length;
+	__le32					channel;
+	__le32					dwell_time;
+	u8					bssid[ETH_ALEN];
+	u8					band;
+	u8					pad[1];
+	struct inff_fil_action_frame_le	action_frame;
+};
+
+struct inff_fil_bss_enable_le {
+	__le32 bsscfgidx;
+	__le32 enable;
+};
+
+struct inff_fil_bwcap_le {
+	__le32 band;
+	__le32 bw_cap;
+};
+
+/**
+ * struct tdls_iovar - common structure for tdls iovars.
+ *
+ * @ea: ether address of peer station.
+ * @mode: mode value depending on specific tdls iovar.
+ * @chanspec: channel specification.
+ * @pad: unused (for future use).
+ */
+struct inff_tdls_iovar_le {
+	u8 ea[ETH_ALEN];		/* Station address */
+	u8 mode;			/* mode: depends on iovar */
+	__le16 chanspec;
+	__le32 pad;			/* future */
+};
+
+enum inff_tdls_manual_ep_ops {
+	INFF_TDLS_MANUAL_EP_CREATE = 1,
+	INFF_TDLS_MANUAL_EP_DELETE = 3,
+	INFF_TDLS_MANUAL_EP_DISCOVERY = 6
+};
+
+/* Pattern matching filter. Specifies an offset within received packets to
+ * start matching, the pattern to match, the size of the pattern, and a bitmask
+ * that indicates which bits within the pattern should be matched.
+ */
+struct inff_pkt_filter_pattern_le {
+	/*
+	 * Offset within received packet to start pattern matching.
+	 * Offset '0' is the first byte of the ethernet header.
+	 */
+	__le32 offset;
+	/* Size of the pattern.  Bitmask must be the same size.*/
+	__le32 size_bytes;
+	/*
+	 * Variable length mask and pattern data. mask starts at offset 0.
+	 * Pattern immediately follows mask.
+	 */
+	u8 mask_and_pattern[MAX_PKTFILTER_PATTERN_FILL_SIZE];
+};
+
+/* IOVAR "pkt_filter_add" parameter. Used to install packet filters. */
+struct inff_pkt_filter_le {
+	__le32 id;		/* Unique filter id, specified by app. */
+	__le32 type;		/* Filter type (WL_PKT_FILTER_TYPE_xxx). */
+	__le32 negate_match;	/* Negate the result of filter matches */
+	union {			/* Filter definitions */
+		struct inff_pkt_filter_pattern_le pattern; /* Filter pattern */
+	} u;
+};
+
+/* IOVAR "pkt_filter_enable" parameter. */
+struct inff_pkt_filter_enable_le {
+	__le32 id;		/* Unique filter id */
+	__le32 enable;		/* Enable/disable bool */
+};
+
+/* BSS info structure
+ * Applications MUST CHECK ie_offset field and length field to access IEs and
+ * next bss_info structure in a vector (in struct inff_scan_results)
+ */
+struct inff_bss_info_le {
+	__le32 version;		/* version field */
+	__le32 length;		/* byte length of data in this record,
+				 * starting at version and including IEs
+				 */
+	u8 BSSID[ETH_ALEN];
+	__le16 beacon_period;	/* units are Kusec */
+	__le16 capability;	/* Capability information */
+	u8 SSID_len;
+	u8 SSID[32];
+	struct {
+		__le32 count;   /* # rates in this set */
+		u8 rates[16]; /* rates in 500kbps units w/hi bit set if basic */
+	} rateset;		/* supported rates */
+	__le16 chanspec;	/* chanspec for bss */
+	__le16 atim_window;	/* units are Kusec */
+	u8 dtim_period;	/* DTIM period */
+	__le16 RSSI;		/* receive signal strength (in dBm) */
+	s8 phy_noise;		/* noise (in dBm) */
+
+	u8 n_cap;		/* BSS is 802.11N Capable */
+	/* 802.11N BSS Capabilities (based on HT_CAP_*): */
+	__le32 nbss_cap;
+	u8 ctl_ch;		/* 802.11N BSS control channel number */
+	__le32 reserved32[1];	/* Reserved for expansion of BSS properties */
+	u8 flags;		/* flags */
+	u8 reserved[3];	/* Reserved for expansion of BSS properties */
+	u8 basic_mcs[INFF_MCSSET_LEN];	/* 802.11N BSS required MCS set */
+
+	__le16 ie_offset;	/* offset at which IEs start, from beginning */
+	__le32 ie_length;	/* byte length of Information Elements */
+	__le16 SNR;		/* average SNR of during frame reception */
+	/* Add new fields here */
+	/* variable length Information Elements */
+};
+
+struct inff_rateset_le {
+	/* # rates in this set */
+	__le32 count;
+	/* rates in 500kbps units w/hi bit set if basic */
+	u8 rates[INFF_MAXRATES_IN_SET];
+};
+
+struct inff_ssid_le {
+	__le32 SSID_len;
+	unsigned char SSID[IEEE80211_MAX_SSID_LEN];
+};
+
+struct inff_scan_params_le {
+	struct inff_ssid_le ssid_le;	/* default: {0, ""} */
+	u8 bssid[ETH_ALEN];	/* default: bcast */
+	s8 bss_type;		/* default: any,
+				 * DOT11_BSSTYPE_ANY/INFRASTRUCTURE/INDEPENDENT
+				 */
+	u8 scan_type;	/* flags, 0 use default */
+	__le32 nprobes;	  /* -1 use default, number of probes per channel */
+	__le32 active_time;	/* -1 use default, dwell time per channel for
+				 * active scanning
+				 */
+	__le32 passive_time;	/* -1 use default, dwell time per channel
+				 * for passive scanning
+				 */
+	__le32 home_time;	/* -1 use default, dwell time for the
+				 * home channel between channel scans
+				 */
+	__le32 channel_num;	/* count of channels and ssids that follow
+				 *
+				 * low half is count of channels in
+				 * channel_list, 0 means default (use all
+				 * available channels)
+				 *
+				 * high half is entries in struct inff_ssid
+				 * array that follows channel_list, aligned for
+				 * s32 (4 bytes) meaning an odd channel count
+				 * implies a 2-byte pad between end of
+				 * channel_list and first ssid
+				 *
+				 * if ssid count is zero, single ssid in the
+				 * fixed parameter portion is assumed, otherwise
+				 * ssid in the fixed portion is ignored
+				 */
+	union {
+		__le16 padding;	/* Reserve space for at least 1 entry for abort
+				 * which uses an on stack inff_scan_params_le
+				 */
+		DECLARE_FLEX_ARRAY(__le16, channel_list);	/* chanspecs */
+	};
+};
+
+struct inff_scan_params_v2_le {
+	__le16 version;		/* structure version */
+	__le16 length;		/* structure length */
+	struct inff_ssid_le ssid_le;	/* default: {0, ""} */
+	u8 bssid[ETH_ALEN];	/* default: bcast */
+	s8 bss_type;		/* default: any,
+				 * DOT11_BSSTYPE_ANY/INFRASTRUCTURE/INDEPENDENT
+				 */
+	u8 pad;
+	__le32 scan_type;	/* flags, 0 use default */
+	__le32 nprobes;		/* -1 use default, number of probes per channel */
+	__le32 active_time;	/* -1 use default, dwell time per channel for
+				 * active scanning
+				 */
+	__le32 passive_time;	/* -1 use default, dwell time per channel
+				 * for passive scanning
+				 */
+	__le32 home_time;	/* -1 use default, dwell time for the
+				 * home channel between channel scans
+				 */
+	__le32 channel_num;	/* count of channels and ssids that follow
+				 *
+				 * low half is count of channels in
+				 * channel_list, 0 means default (use all
+				 * available channels)
+				 *
+				 * high half is entries in struct inff_ssid
+				 * array that follows channel_list, aligned for
+				 * s32 (4 bytes) meaning an odd channel count
+				 * implies a 2-byte pad between end of
+				 * channel_list and first ssid
+				 *
+				 * if ssid count is zero, single ssid in the
+				 * fixed parameter portion is assumed, otherwise
+				 * ssid in the fixed portion is ignored
+				 */
+	union {
+		__le16 padding;	/* Reserve space for at least 1 entry for abort
+				 * which uses an on stack inff_scan_params_v2_le
+				 */
+		DECLARE_FLEX_ARRAY(__le16, channel_list);	/* chanspecs */
+	};
+};
+
+struct inff_scan_results {
+	u32 buflen;
+	u32 version;
+	u32 count;
+	struct inff_bss_info_le bss_info_le[];
+};
+
+struct inff_escan_params_le {
+	__le32 version;
+	__le16 action;
+	__le16 sync_id;
+	union {
+		struct inff_scan_params_le params_le;
+		struct inff_scan_params_v2_le params_v2_le;
+	};
+};
+
+struct inff_escan_result_le {
+	__le32 buflen;
+	__le32 version;
+	__le16 sync_id;
+	__le16 bss_count;
+	struct inff_bss_info_le bss_info_le;
+};
+
+#define WL_ESCAN_RESULTS_FIXED_SIZE (sizeof(struct inff_escan_result_le) - \
+	sizeof(struct inff_bss_info_le))
+
+/* used for association with a specific BSSID and chanspec list */
+struct inff_assoc_params_le {
+	/* 00:00:00:00:00:00: broadcast scan */
+	u8 bssid[ETH_ALEN];
+	/* 0: all available channels, otherwise count of chanspecs in
+	 * chanspec_list
+	 */
+	__le32 chanspec_num;
+	/*
+	 * list of chanspecs. Currently, driver only uses 1 chanspec here.
+	 * TODO: Conver this into a flexible array to support multiple
+	 * chanspecs.
+	 */
+	__le16 chanspec_list;
+};
+
+/**
+ * struct join_pref params - parameters for preferred join selection.
+ *
+ * @type: preference type (see enum inff_join_pref_types).
+ * @len: length of bytes following (currently always 2).
+ * @rssi_gain: signal gain for selection (only when @type is RSSI_DELTA).
+ * @band: band to which selection preference applies.
+ *	This is used if @type is BAND or RSSI_DELTA.
+ */
+struct inff_join_pref_params {
+	u8 type;
+	u8 len;
+	u8 rssi_gain;
+	u8 band;
+};
+
+/* used for join with or without a specific bssid and channel list */
+struct inff_join_params {
+	struct inff_ssid_le ssid_le;
+	struct inff_assoc_params_le params_le;
+};
+
+/* scan params for extended join */
+struct inff_join_scan_params_le {
+	u8 scan_type;		/* 0 use default, active or passive scan */
+	__le32 nprobes;		/* -1 use default, nr of probes per channel */
+	__le32 active_time;	/* -1 use default, dwell time per channel for
+				 * active scanning
+				 */
+	__le32 passive_time;	/* -1 use default, dwell time per channel
+				 * for passive scanning
+				 */
+	__le32 home_time;	/* -1 use default, dwell time for the home
+				 * channel between channel scans
+				 */
+};
+
+/* extended join params */
+struct inff_ext_join_params_le {
+	struct inff_ssid_le ssid_le;	/* {0, ""}: wildcard scan */
+	struct inff_join_scan_params_le scan_le;
+	struct inff_assoc_params_le assoc_le;
+};
+
+struct inff_wsec_key {
+	u32 index;		/* key index */
+	u32 len;		/* key length */
+	u8 data[WLAN_MAX_KEY_LEN];	/* key data */
+	u32 pad_1[18];
+	u32 algo;	/* CRYPTO_ALGO_AES_CCM, CRYPTO_ALGO_WEP128, etc */
+	u32 flags;	/* misc flags */
+	u32 pad_2[3];
+	u32 iv_initialized;	/* has IV been initialized already? */
+	u32 pad_3;
+	/* Rx IV */
+	struct {
+		u32 hi;	/* upper 32 bits of IV */
+		u16 lo;	/* lower 16 bits of IV */
+	} rxiv;
+	u32 pad_4[2];
+	u8 ea[ETH_ALEN];	/* per station */
+};
+
+/*
+ * dongle requires same struct as above but with fields in little endian order
+ */
+struct inff_wsec_key_le {
+	__le32 index;		/* key index */
+	__le32 len;		/* key length */
+	u8 data[WLAN_MAX_KEY_LEN];	/* key data */
+	__le32 pad_1[18];
+	__le32 algo;	/* CRYPTO_ALGO_AES_CCM, CRYPTO_ALGO_WEP128, etc */
+	__le32 flags;	/* misc flags */
+	__le32 pad_2[3];
+	__le32 iv_initialized;	/* has IV been initialized already? */
+	__le32 pad_3;
+	/* Rx IV */
+	struct {
+		__le32 hi;	/* upper 32 bits of IV */
+		__le16 lo;	/* lower 16 bits of IV */
+	} rxiv;
+	__le32 pad_4[2];
+	u8 ea[ETH_ALEN];	/* per station */
+};
+
+/**
+ * struct inff_wsec_pmk_le - firmware pmk material.
+ *
+ * @key_len: number of octets in key material.
+ * @flags: key handling qualifiers.
+ * @key: PMK key material.
+ */
+struct inff_wsec_pmk_le {
+	__le16  key_len;
+	__le16  flags;
+	u8 key[INFF_WSEC_MAX_PMK_LEN];
+};
+
+/**
+ * struct inff_wsec_sae_pwd_le - firmware SAE password material.
+ *
+ * @key_len: number of octets in key materials.
+ * @key: SAE password material.
+ */
+struct inff_wsec_sae_pwd_le {
+	__le16 key_len;
+	u8 key[INFF_WSEC_MAX_SAE_PASSWORD_LEN];
+};
+
+/**
+ * struct inff_auth_req_status_le - external auth request and status update
+ *
+ * @flags: flags for external auth status
+ * @peer_mac: peer MAC address
+ * @ssid_len: length of ssid
+ * @ssid: ssid characters
+ */
+struct inff_auth_req_status_le {
+	__le16 flags;
+	u8 peer_mac[ETH_ALEN];
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 pmkid[WLAN_PMKID_LEN];
+};
+
+struct inff_auth_req_status_info_le_v2 {
+	__le16  version;
+	__le16  len;
+	__le16  flags;
+	u8 peer_mac[ETH_ALEN];/* peer mac address */
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 pmkid[WLAN_PMKID_LEN];
+	struct inff_bss_info_le bss_info_le[];
+};
+
+/**
+ * struct inff_mf_params_le - management frame parameters for mgmt_frame iovar
+ *
+ * @version: version of the iovar
+ * @dwell_time: dwell duration in ms
+ * @len: length of frame data
+ * @frame_control: frame control
+ * @channel: channel
+ * @da: peer MAC address
+ * @bssid: BSS network identifier
+ * @packet_id: packet identifier
+ * @data: frame data
+ */
+struct inff_mf_params_le {
+	__le32 version;
+	__le32 dwell_time;
+	__le16 len;
+	__le16 frame_control;
+	__le16 channel;
+	u8 da[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le32 packet_id;
+	u8 data[] __counted_by_le(len);
+};
+
+/* Used to get specific STA parameters */
+struct inff_scb_val_le {
+	__le32 val;
+	u8 ea[ETH_ALEN];
+};
+
+/* channel encoding */
+struct inff_channel_info_le {
+	__le32 hw_channel;
+	__le32 target_channel;
+	__le32 scan_channel;
+};
+
+struct inff_sta_info_le {
+	__le16 ver;		/* version of this struct */
+	__le16 len;		/* length in bytes of this structure */
+	__le16 cap;		/* sta's advertised capabilities */
+	__le32 flags;		/* flags defined below */
+	__le32 idle;		/* time since data pkt rx'd from sta */
+	u8 ea[ETH_ALEN];		/* Station address */
+	__le32 count;			/* # rates in this set */
+	u8 rates[INFF_MAXRATES_IN_SET];	/* rates in 500kbps units */
+						/* w/hi bit set if basic */
+	__le32 in;		/* seconds elapsed since associated */
+	__le32 listen_interval_inms; /* Min Listen interval in ms for STA */
+
+	/* Fields valid for ver >= 3 */
+	__le32 tx_pkts;	/* # of packets transmitted */
+	__le32 tx_failures;	/* # of packets failed */
+	__le32 rx_ucast_pkts;	/* # of unicast packets received */
+	__le32 rx_mcast_pkts;	/* # of multicast packets received */
+	__le32 tx_rate;	/* Rate of last successful tx frame */
+	__le32 rx_rate;	/* Rate of last successful rx frame */
+	__le32 rx_decrypt_succeeds;	/* # of packet decrypted successfully */
+	__le32 rx_decrypt_failures;	/* # of packet decrypted failed */
+
+	/* Fields valid for ver >= 4 */
+	__le32 tx_tot_pkts;    /* # of tx pkts (ucast + mcast) */
+	__le32 rx_tot_pkts;    /* # of data packets recvd (uni + mcast) */
+	__le32 tx_mcast_pkts;  /* # of mcast pkts txed */
+	__le64 tx_tot_bytes;   /* data bytes txed (ucast + mcast) */
+	__le64 rx_tot_bytes;   /* data bytes recvd (ucast + mcast) */
+	__le64 tx_ucast_bytes; /* data bytes txed (ucast) */
+	__le64 tx_mcast_bytes; /* # data bytes txed (mcast) */
+	__le64 rx_ucast_bytes; /* data bytes recvd (ucast) */
+	__le64 rx_mcast_bytes; /* data bytes recvd (mcast) */
+	s8 rssi[INFF_ANT_MAX];   /* per antenna rssi */
+	s8 nf[INFF_ANT_MAX];     /* per antenna noise floor */
+	__le16 aid;                    /* association ID */
+	__le16 ht_capabilities;        /* advertised ht caps */
+	__le16 vht_flags;              /* converted vht flags */
+	__le32 tx_pkts_retry_cnt;      /* # of frames where a retry was
+					* exhausted.
+					*/
+	__le32 tx_pkts_retry_exhausted; /* # of user frames where a retry
+					 * was exhausted
+					 */
+	s8 rx_lastpkt_rssi[INFF_ANT_MAX]; /* Per antenna RSSI of last
+					   * received data frame.
+					   */
+	/* TX WLAN retry/failure statistics:
+	 * Separated for host requested frames and locally generated frames.
+	 * Include unicast frame only where the retries/failures can be counted.
+	 */
+	__le32 tx_pkts_total;          /* # user frames sent successfully */
+	__le32 tx_pkts_retries;        /* # user frames retries */
+	__le32 tx_pkts_fw_total;       /* # FW generated sent successfully */
+	__le32 tx_pkts_fw_retries;     /* # retries for FW generated frames */
+	__le32 tx_pkts_fw_retry_exhausted;     /* # FW generated where a retry
+						* was exhausted
+						*/
+	__le32 rx_pkts_retried;        /* # rx with retry bit set */
+	__le32 tx_rate_fallback;       /* lowest fallback TX rate */
+
+	union {
+		struct {
+			struct {
+				/* # rates in this set */
+				__le32 count;
+				/* rates in 500kbps units w/hi bit set if basic */
+				u8 rates[INFF_MAXRATES_IN_SET];
+				/* supported mcs index bit map */
+				u8 mcs[INFF_MCSSET_LEN];
+				/* supported mcs index bit map per nss */
+				__le16 vht_mcs[INFF_VHT_CAP_MCS_MAP_NSS_MAX];
+			} rateset_adv;
+		} v5;
+
+		struct {
+			__le32 rx_dur_total;	/* total user RX duration (estimated) */
+			__le16 chanspec;	/** chanspec this sta is on */
+			__le16 pad_1;
+			struct {
+				__le16 version;					/* version */
+				__le16 len;					/* length */
+				/* # rates in this set */
+				__le32 count;
+				/* rates in 500kbps units w/hi bit set if basic */
+				u8 rates[INFF_MAXRATES_IN_SET];
+				/* supported mcs index bit map */
+				u8 mcs[INFF_MCSSET_LEN];
+				/* supported mcs index bit map per nss */
+				__le16 vht_mcs[INFF_VHT_CAP_MCS_MAP_NSS_MAX];
+				/* supported he mcs index bit map per nss */
+				__le16 he_mcs[INFF_HE_CAP_MCS_MAP_NSS_MAX];
+			} rateset_adv;		/* rateset along with mcs index bitmap */
+			__le16 wpauth;		/* authentication type */
+			u8 algo;		/* crypto algorithm */
+			u8 pad_2;
+			__le32 tx_rspec;	/* Rate of last successful tx frame */
+			__le32 rx_rspec;	/* Rate of last successful rx frame */
+			__le32 wnm_cap;		/* wnm capabilities */
+		} v7;
+	};
+};
+
+struct inff_chanspec_list {
+	__le32	count;		/* # of entries */
+	__le32  element[];	/* variable length uint32 list */
+};
+
+/*
+ * WLC_E_PROBRESP_MSG
+ * WLC_E_P2P_PROBREQ_MSG
+ * WLC_E_ACTION_FRAME_RX
+ */
+struct inff_rx_mgmt_data {
+	__be16	version;
+	__be16	chanspec;
+	__be32	rssi;
+	__be32	mactime;
+	__be32	rate;
+};
+
+/**
+ * struct inff_fil_wowl_pattern_le - wowl pattern configuration struct.
+ *
+ * @cmd: "add", "del" or "clr".
+ * @masksize: Size of the mask in #of bytes
+ * @offset: Pattern byte offset in packet
+ * @patternoffset: Offset of start of pattern. Starting from field masksize.
+ * @patternsize: Size of the pattern itself in #of bytes
+ * @id: id
+ * @reasonsize: Size of the wakeup reason code
+ * @type: Type of pattern (enum inff_wowl_pattern_type)
+ */
+struct inff_fil_wowl_pattern_le {
+	u8	cmd[4];
+	__le32	masksize;
+	__le32	offset;
+	__le32	patternoffset;
+	__le32	patternsize;
+	__le32	id;
+	__le32	reasonsize;
+	__le32	type;
+	/* u8 mask[] - Mask follows the structure above */
+	/* u8 pattern[] - Pattern follows the mask is at 'patternoffset' */
+};
+
+struct inff_mbss_ssid_le {
+	__le32	bsscfgidx;
+	__le32	SSID_len;
+	unsigned char SSID[32];
+};
+
+/**
+ * struct inff_fil_country_le - country configuration structure.
+ *
+ * @country_abbrev: null-terminated country code used in the country IE.
+ * @rev: revision specifier for ccode. on set, -1 indicates unspecified.
+ * @ccode: null-terminated built-in country code.
+ */
+struct inff_fil_country_le {
+	char country_abbrev[INFF_COUNTRY_BUF_SZ];
+	__le32 rev;
+	char ccode[INFF_COUNTRY_BUF_SZ];
+};
+
+/**
+ * struct inff_rev_info_le - device revision info.
+ *
+ * @vendorid: PCI vendor id.
+ * @deviceid: device id of chip.
+ * @radiorev: radio revision.
+ * @chiprev: chip revision.
+ * @corerev: core revision.
+ * @boardid: board identifier (usu. PCI sub-device id).
+ * @boardvendor: board vendor (usu. PCI sub-vendor id).
+ * @boardrev: board revision.
+ * @driverrev: driver version.
+ * @ucoderev: microcode version.
+ * @bus: bus type.
+ * @chipnum: chip number.
+ * @phytype: phy type.
+ * @phyrev: phy revision.
+ * @anarev: anacore rev.
+ * @chippkg: chip package info.
+ * @nvramrev: nvram revision number.
+ */
+struct inff_rev_info_le {
+	__le32 vendorid;
+	__le32 deviceid;
+	__le32 radiorev;
+	__le32 chiprev;
+	__le32 corerev;
+	__le32 boardid;
+	__le32 boardvendor;
+	__le32 boardrev;
+	__le32 driverrev;
+	__le32 ucoderev;
+	__le32 bus;
+	__le32 chipnum;
+	__le32 phytype;
+	__le32 phyrev;
+	__le32 anarev;
+	__le32 chippkg;
+	__le32 nvramrev;
+};
+
+/**
+ * struct inff_wlc_version_le - firmware revision info.
+ *
+ * @version: structure version.
+ * @length: structure length.
+ * @epi_ver_major: EPI major version
+ * @epi_ver_minor: EPI minor version
+ * @epi_ver_rc: EPI rc version
+ * @epi_ver_incr: EPI increment version
+ * @wlc_ver_major: WLC major version
+ * @wlc_ver_minor: WLC minor version
+ */
+struct inff_wlc_version_le {
+	__le16 version;
+	__le16 length;
+
+	__le16 epi_ver_major;
+	__le16 epi_ver_minor;
+	__le16 epi_ver_rc;
+	__le16 epi_ver_incr;
+
+	__le16 wlc_ver_major;
+	__le16 wlc_ver_minor;
+};
+
+/**
+ * struct inff_assoclist_le - request assoc list.
+ *
+ * @count: indicates number of stations.
+ * @mac: MAC addresses of stations.
+ */
+struct inff_assoclist_le {
+	__le32 count;
+	u8 mac[INFF_MAX_ASSOCLIST][ETH_ALEN];
+};
+
+/**
+ * struct inff_rssi_be - RSSI threshold event format
+ *
+ * @rssi: receive signal strength (in dBm)
+ * @snr: signal-noise ratio
+ * @noise: noise (in dBm)
+ */
+struct inff_rssi_be {
+	__be32 rssi;
+	__be32 snr;
+	__be32 noise;
+};
+
+#define INFF_MAX_RSSI_LEVELS 8
+
+/**
+ * struct inff_rssi_event_le - rssi_event IOVAR format
+ *
+ * @rate_limit_msec: RSSI event rate limit
+ * @rssi_level_num: number of supplied RSSI levels
+ * @rssi_levels: RSSI levels in ascending order
+ */
+struct inff_rssi_event_le {
+	__le32 rate_limit_msec;
+	s8 rssi_level_num;
+	s8 rssi_levels[INFF_MAX_RSSI_LEVELS];
+};
+
+/**
+ * struct inff_wowl_wakeind_le - Wakeup indicators
+ *	Note: note both fields contain same information.
+ *
+ * @pci_wakeind: Whether PCI PMECSR PMEStatus bit was set.
+ * @ucode_wakeind: What wakeup-event indication was set by ucode
+ */
+struct inff_wowl_wakeind_le {
+	__le32 pci_wakeind;
+	__le32 ucode_wakeind;
+};
+
+/**
+ * struct inff_pmksa - PMK Security Association
+ *
+ * @bssid: The AP's BSSID.
+ * @pmkid: he PMK material itself.
+ */
+struct inff_pmksa {
+	u8 bssid[ETH_ALEN];
+	u8 pmkid[WLAN_PMKID_LEN];
+};
+
+/**
+ * struct inff_pmk_list_le - List of pmksa's.
+ *
+ * @npmk: Number of pmksa's.
+ * @pmk: PMK SA information.
+ */
+struct inff_pmk_list_le {
+	__le32 npmk;
+	struct inff_pmksa pmk[INFF_MAXPMKID];
+};
+
+/**
+ * struct inff_pno_param_le - PNO scan configuration parameters
+ *
+ * @version: PNO parameters version.
+ * @scan_freq: scan frequency.
+ * @lost_network_timeout: #sec. to declare discovered network as lost.
+ * @flags: Bit field to control features of PFN such as sort criteria auto
+ *	enable switch and background scan.
+ * @rssi_margin: Margin to avoid jitter for choosing a PFN based on RSSI sort
+ *	criteria.
+ * @bestn: number of best networks in each scan.
+ * @mscan: number of scans recorded.
+ * @repeat: minimum number of scan intervals before scan frequency changes
+ *	in adaptive scan.
+ * @exp: exponent of 2 for maximum scan interval.
+ * @slow_freq: slow scan period.
+ */
+struct inff_pno_param_le {
+	__le32 version;
+	__le32 scan_freq;
+	__le32 lost_network_timeout;
+	__le16 flags;
+	__le16 rssi_margin;
+	u8 bestn;
+	u8 mscan;
+	u8 repeat;
+	u8 exp;
+	__le32 slow_freq;
+};
+
+/**
+ * struct inff_pno_config_le - PNO channel configuration.
+ *
+ * @reporttype: determines what is reported.
+ * @channel_num: number of channels specified in @channel_list.
+ * @channel_list: channels to use in PNO scan.
+ * @flags: reserved.
+ */
+struct inff_pno_config_le {
+	__le32  reporttype;
+	__le32  channel_num;
+	__le16  channel_list[INFF_NUMCHANNELS];
+	__le32  flags;
+};
+
+/**
+ * struct inff_pno_net_param_le - scan parameters per preferred network.
+ *
+ * @ssid: ssid name and its length.
+ * @flags: bit2: hidden.
+ * @infra: BSS vs IBSS.
+ * @auth: Open vs Closed.
+ * @wpa_auth: WPA type.
+ * @wsec: wsec value.
+ */
+struct inff_pno_net_param_le {
+	struct inff_ssid_le ssid;
+	__le32 flags;
+	__le32 infra;
+	__le32 auth;
+	__le32 wpa_auth;
+	__le32 wsec;
+};
+
+/**
+ * struct inff_pno_net_info_le - information per found network.
+ *
+ * @bssid: BSS network identifier.
+ * @channel: channel number only.
+ * @SSID_len: length of ssid.
+ * @SSID: ssid characters.
+ * @RSSI: receive signal strength (in dBm).
+ * @timestamp: age in seconds.
+ */
+struct inff_pno_net_info_le {
+	u8 bssid[ETH_ALEN];
+	u8 channel;
+	u8 SSID_len;
+	u8 SSID[32];
+	__le16	RSSI;
+	__le16	timestamp;
+};
+
+/**
+ * struct inff_pno_scanresults_le - result returned in PNO NET FOUND event.
+ *
+ * @version: PNO version identifier.
+ * @status: indicates completion status of PNO scan.
+ * @count: amount of inff_pno_net_info_le entries appended.
+ */
+struct inff_pno_scanresults_le {
+	__le32 version;
+	__le32 status;
+	__le32 count;
+};
+
+struct inff_pno_scanresults_v2_le {
+	__le32 version;
+	__le32 status;
+	__le32 count;
+	__le32 scan_ch_bucket;
+};
+
+/**
+ * struct inff_pno_macaddr_le - to configure PNO macaddr randomization.
+ *
+ * @version: PNO version identifier.
+ * @flags: Flags defining how mac addrss should be used.
+ * @mac: MAC address.
+ */
+struct inff_pno_macaddr_le {
+	u8 version;
+	u8 flags;
+	u8 mac[ETH_ALEN];
+};
+
+/**
+ * struct inff_dload_data_le - data passing to firmware for downloading
+ * @flag: flags related to download data.
+ * @dload_type: type of download data.
+ * @len: length in bytes of download data.
+ * @crc: crc of download data.
+ * @data: download data.
+ */
+struct inff_dload_data_le {
+	__le16 flag;
+	__le16 dload_type;
+	__le32 len;
+	__le32 crc;
+	u8 data[];
+};
+
+/**
+ * struct inff_pno_bssid_le - bssid configuration for PNO scan.
+ *
+ * @bssid: BSS network identifier.
+ * @flags: flags for this BSSID.
+ */
+struct inff_pno_bssid_le {
+	u8 bssid[ETH_ALEN];
+	__le16 flags;
+};
+
+/**
+ * struct inff_pktcnt_le - packet counters.
+ *
+ * @rx_good_pkt: packets (MSDUs & MMPDUs) received from this station
+ * @rx_bad_pkt: failed rx packets
+ * @tx_good_pkt: packets (MSDUs & MMPDUs) transmitted to this station
+ * @tx_bad_pkt: failed tx packets
+ * @rx_ocast_good_pkt: unicast packets destined for others
+ */
+struct inff_pktcnt_le {
+	__le32 rx_good_pkt;
+	__le32 rx_bad_pkt;
+	__le32 tx_good_pkt;
+	__le32 tx_bad_pkt;
+	__le32 rx_ocast_good_pkt;
+};
+
+/**
+ * struct inff_gtk_keyinfo_le - GTP rekey data
+ *
+ * @kck: key confirmation key.
+ * @kek: key encryption key.
+ * @replay_counter: replay counter.
+ */
+struct inff_gtk_keyinfo_le {
+	u8 kck[INFF_RSN_KCK_LENGTH];
+	u8 kek[INFF_RSN_KEK_LENGTH];
+	u8 replay_counter[INFF_RSN_REPLAY_LEN];
+};
+
+#define INFF_PNO_REPORT_NO_BATCH	BIT(2)
+
+/**
+ * struct inff_gscan_bucket_config - configuration data for channel bucket.
+ *
+ * @bucket_end_index: last channel index in @channel_list in
+ *	@struct inff_pno_config_le.
+ * @bucket_freq_multiple: scan interval expressed in N * @scan_freq.
+ * @flag: channel bucket report flags.
+ * @reserved: for future use.
+ * @repeat: number of scan at interval for exponential scan.
+ * @max_freq_multiple: maximum scan interval for exponential scan.
+ */
+struct inff_gscan_bucket_config {
+	u8 bucket_end_index;
+	u8 bucket_freq_multiple;
+	u8 flag;
+	u8 reserved;
+	__le16 repeat;
+	__le16 max_freq_multiple;
+};
+
+/* version supported which must match firmware */
+#define INFF_GSCAN_CFG_VERSION                     2
+
+/**
+ * enum inff_gscan_cfg_flags - bit values for gscan flags.
+ *
+ * @INFF_GSCAN_CFG_FLAGS_ALL_RESULTS: send probe responses/beacons to host.
+ * @INFF_GSCAN_CFG_ALL_BUCKETS_IN_1ST_SCAN: all buckets will be included in
+ *	first scan cycle.
+ * @INFF_GSCAN_CFG_FLAGS_CHANGE_ONLY: indicated only flags member is changed.
+ */
+enum inff_gscan_cfg_flags {
+	INFF_GSCAN_CFG_FLAGS_ALL_RESULTS = BIT(0),
+	INFF_GSCAN_CFG_ALL_BUCKETS_IN_1ST_SCAN = BIT(3),
+	INFF_GSCAN_CFG_FLAGS_CHANGE_ONLY = BIT(7),
+};
+
+/**
+ * struct inff_gscan_config - configuration data for gscan.
+ *
+ * @version: version of the api to match firmware.
+ * @flags: flags according %enum inff_gscan_cfg_flags.
+ * @buffer_threshold: percentage threshold of buffer to generate an event.
+ * @swc_nbssid_threshold: number of BSSIDs with significant change that
+ *	will generate an event.
+ * @swc_rssi_window_size: size of rssi cache buffer (max=8).
+ * @count_of_channel_buckets: number of array members in @bucket.
+ * @retry_threshold: !unknown!
+ * @lost_ap_window: !unknown!
+ * @bucket: array of channel buckets.
+ */
+struct inff_gscan_config {
+	__le16 version;
+	u8 flags;
+	u8 buffer_threshold;
+	u8 swc_nbssid_threshold;
+	u8 swc_rssi_window_size;
+	u8 count_of_channel_buckets;
+	u8 retry_threshold;
+	__le16  lost_ap_window;
+	struct inff_gscan_bucket_config bucket[] __counted_by(count_of_channel_buckets);
+};
+
+/**
+ * struct inff_mkeep_alive_pkt_le - configuration data for keep-alive frame.
+ *
+ * @version: version for mkeep_alive
+ * @length: length of fixed parameters in the structure.
+ * @period_msec: keep-alive period in milliseconds.
+ * @len_bytes: size of the data.
+ * @keep_alive_id: ID  (0 - 3).
+ * @data: keep-alive frame data.
+ */
+struct inff_mkeep_alive_pkt_le {
+	__le16  version;
+	__le16  length;
+	__le32  period_msec;
+	__le16  len_bytes;
+	u8   keep_alive_id;
+	u8   data[];
+} __packed;
+
+/* INFF_E_RSSI event data */
+struct wl_event_data_rssi {
+	s32 rssi;
+	s32 snr;
+	s32 noise;
+};
+
+/** RSSI event notification configuration. */
+struct wl_rssi_event {
+	u32 rate_limit_msec;
+	u8 num_rssi_levels;
+	s8 rssi_levels[MAX_RSSI_LEVELS];
+	u8 version;
+	s8 pad[2];
+};
+
+struct ipv4_addr {
+	u8 addr[INFF_IPV4_ADDR_LEN];
+};
+
+struct ipv6_addr {
+	u8 addr[INFF_IPV6_ADDR_LEN];
+};
+
+#endif /* INFF_FWIL_TYPES_H */
-- 
2.25.1


