Return-Path: <linux-wireless+bounces-30405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B26CF9157
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC9DD30B0F44
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199633F8A0;
	Tue,  6 Jan 2026 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E40mX8iS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ca2P4KUc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26E345743
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713127; cv=none; b=HKJ/Js47JvoacbLKa4VioxzDzvxQLgpV784QkhIuoamniEdeZ5qIlEcIJ9Pj+jMaDgvQYttLjDtdcCzSaZXdeW2BLpNitFf9Vw5ao54kt959YiwcbcuCopGrS0pdSV6DTO6Yu/+eRTef2fuOVCR3oKsqEYyc4H5a7yw2TpcQrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713127; c=relaxed/simple;
	bh=oxA+7iVJr+nS9YM4i0bCfkWTxYafVVQ/c+nyGvLKNhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbvWcLd1TZXaNtzWmDn6C9f7k8EjNjz1siiR8RKs0iW/ckUc1luK5vbGW+GjrAeppmawoIiZcoTdEqgJsip9k0ANEuscI6aDHQ2Ijkg+i7b12VovfLP0uW5gaUCZgITIsRCDn74zCzwpZurR1SlF//ltotpGOJVX4f7aarmNVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E40mX8iS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ca2P4KUc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606AgWwk1462298
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tqja4OTXFNT
	3u47pL22RWBPmyTVbsLnCE6ubN6Tn3UY=; b=E40mX8iSmvUEu5Ya/x6mntZQevu
	sd8ihIQnm/AenTiebxbtpOugLl+ZgfPROj5dYyelUy53nGCdz0xmd33sQr3uVpVy
	7KWM+Z6DrdURv8vIAqoo8x4f+ZAWwdG0i6V+I7pemHDkumKKsCRzrBdVkEfNUjZl
	D90W28DrQcCp3TrZxxiMHUJdMuU6uOoiKKxCrc5QtWB9ch0+lFU7M+rt2cnlQd9y
	ANdK5X8oy83osEfIRRYAg522Jstv43V5DEMEWBdafmuld7digARxOUa0ARDuNxB3
	hxFJ7KccoZPfHVGpag5qXNjjoePxu5PGQsDNzh2Yfl8cQFISdf5uqJfhSYQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh0vm0rfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f8e6a5de4so13407585ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713124; x=1768317924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqja4OTXFNT3u47pL22RWBPmyTVbsLnCE6ubN6Tn3UY=;
        b=ca2P4KUc6dXsoYoiU/Z/M5qeer2z1V2iPyFLIwLia87MVKwwcdMyLB9xpiy0ZepE31
         hBRciwoguaMhjKINROtcRj6v16cNzeES6bujkFmJoF2U0V0cRbBejxuuknvW/8jRMJ3K
         Ursx9jR6V7hhwb7YUT7oXZ2X6vUcd7Cy5/nxOWanteJ07QuM+SPge14D3H7POK9gN5Jz
         WZrZOM2BOIsj4aKaH4M3fNW0CDRgv+NcNK3xWQjxsu2vRVxRfbLk/PeKfNawF6Bqhz+X
         zJDwvb3JhVH0WgN3UWjuL8eARMzTyjAUKY9ZZ7cnewa1wyRyX0gNarqWpmiIaaH27+s2
         3w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713124; x=1768317924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tqja4OTXFNT3u47pL22RWBPmyTVbsLnCE6ubN6Tn3UY=;
        b=vBNBGf5mkY2HPLGDCBRLzyC6qOKdZnQMqShzB8VoFJv7hK8uP/lulh8XA4h2RMk0SM
         MyQuHKUt4ek9vp/64UeZeQtdqtO3HzzbR16rYu5qCaGpWEvEx8PSYDGttXzcy+/YArw+
         FSqnbVTLliVD/vaSbfw2+ycDyvmD0JMg6Ym0x009+SlL6UMyIZn54XW7gwelDF3vpXG8
         099x82dcyf0AYLEmRbAY+88mMskFr4HIQYxksCvbhoPsSQDlr27x4y2gQIMGaIF29XCL
         RY+LBhwsGWFWyLVN+zPgtOlfUfIj506lKcPIS2HRKqCezJA8tOrr3i1EZ5eCUaF8Ysed
         QXlQ==
X-Gm-Message-State: AOJu0Yz9VSTTsMEsR8P3NWt1MniukzYv803BzYtPB3AB3kr2sZSw5N+u
	FLsQC9u2sH9Ss4aMQDpxk5uDBxGAmq2dVuMWCrrM+78JaS7MHwTE18k249cMYonKgNhQ4mk4nSX
	yDvIal7u5Klq6mrm1Wx+W7NbhIwnJNIyJ05Yetv8zMDRDVRgQnh8iLrZ9uvMJ2srRejsr6Tc4SP
	BmgQ==
X-Gm-Gg: AY/fxX4OlRuYjYSJvhRiF4KZpA976jcfX7VbIIcKAazAxG3lqZ/60xaJK3ZCIvgVNuG
	31CamaPVmCQR/ZydU3v1VGzveT+3UbHwbl9ytG/XgP8rWEy6Oav3zzl6A64WZgdnF7Xz5I4C9mY
	J/DYSN3Pz2o09o9gRBY4HzfUuOQfpj2fvNfR1rFKejsiOY0b9v3BIqRlIdvJ4ay0jpy7iLTg9ai
	jCiHrR/ajHeKYQ1i6vQ51aukLzGtpnxpCnKHAMBxVfYa8dLYoDTliH/LXYDAIg/h7N/2WR8HSwE
	6FZ0xwE+rIEEeDOa1vD3fkojYxq91YkBSDTfZ1+3vSCCVHLZZOkVSjrnnyWzw0WjnXzLIM74LFs
	6EjQgxWj0CKO7N7RuurL6K3JTzstVR+J8b5M++/NchA==
X-Received: by 2002:a17:902:d4c1:b0:2a0:9b4f:5ebd with SMTP id d9443c01a7336-2a3e2ca308cmr31616235ad.15.1767713124166;
        Tue, 06 Jan 2026 07:25:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb7p4nFroDHu3fY++zBGCrri83HpS56k2BHL+ZiWKLKPlXKvRhWK14CLSacpJjRcoO6PziyQ==
X-Received: by 2002:a17:902:d4c1:b0:2a0:9b4f:5ebd with SMTP id d9443c01a7336-2a3e2ca308cmr31615905ad.15.1767713123542;
        Tue, 06 Jan 2026 07:25:23 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:23 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 4/9] wifi: nl80211: Add new NL attributes to support (Re)Association frame encryption
Date: Tue,  6 Jan 2026 20:54:58 +0530
Message-Id: <20260106152503.223216-5-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Pa3yRyhd c=1 sm=1 tr=0 ts=695d2965 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=jRV2BHI1QgqqTT6Ge1oA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fVeZPa_DqqguGxQvWFj0dUceENoCRWMC
X-Proofpoint-ORIG-GUID: fVeZPa_DqqguGxQvWFj0dUceENoCRWMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX8fBR9GtFuAMj
 r6SCqgT2TXjD1jpUMCOs3MR22ItGsruApl2D02NBtOnljGh8Z0w7ksKBgxsJRlGKNvydUyfRtZv
 oKC4M607wJXYicCPHbjU1mb5N4QqDIahwDGKTtVkzre8OaTmNu/2NOAVNpcs177ipiTZEwbLW9v
 vi11rgNTLebFAnVvEmZ950LW7KTr35m9H8qcsoNT73+0afNoaypE7P+IPkSXlIgvMfx/Pc9YvUr
 7DbTaNl77gfoFIt/vEqcizqQeIH8kOI9H82UHUg/h1i+dNq5sEWIU94cuWeeRPnjR4MIDv9UCmN
 XWawty2JfJ2u7Os80DCwAUwjWpINbp71byTKGovKqmsEZu9Ox0Upr9CAcJLP42vM5JkQWn2XPk5
 haQahVXi0v6Prh6SOMYYr6BvIYI6eeyQKLjPnJgrAfE3IVVpftqq18Lb52qmXcYNmtyE1GHhxGT
 dmL7s99DnJqYcoCMaQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060134

From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>

Introduce new netlink attributes for the userspace to indicate
following to the driver in AP mode:

A new netlink attribute NL80211_ATTR_EPP_PEER for NL80211_CMD_NEW_STA
and NL80211_CMD_ADD_LINK_STA to indicate that it is an
Enhanced Privacy Protection (EPP) peer.

A new netlink attribute NL80211_ATTR_EPP_FLAGS for
NL80211_CMD_SET_STATION to indicate the negotiated EPP capabilities of
an EPP AP and an EPP non-AP STA

The Extended RSN capabilities for EPP that an EPP AP and an EPP
non-AP STA can negotiate are as per "IEEE P802.11bi/D3.0, 9.4.2.240"
(RSNXE), few of which are driver dependent, hence need them to be
communicated from userspace for later use.

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  5 +++++
 include/net/mac80211.h       |  5 +++++
 include/uapi/linux/nl80211.h | 26 ++++++++++++++++++++++++++
 net/mac80211/cfg.c           |  6 ++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 5 files changed, 52 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..c0c1da2b258c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1785,6 +1785,9 @@ struct cfg80211_ttlm_params {
  *	present/updated
  * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
+ * @epp_peer: EPP peer indication
+ * @epp_flags: Negotiated EPP capabilities
+ *	(bitmask of BIT(%NL80211_EPP_FLAG_...))
  */
 struct station_parameters {
 	struct net_device *vlan;
@@ -1811,6 +1814,8 @@ struct station_parameters {
 	bool eml_cap_present;
 	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
+	bool epp_peer;
+	u32 epp_flags;
 };
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c2e49542626c..7cc0625a7116 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2520,6 +2520,9 @@ struct ieee80211_link_sta {
  *	by the AP.
  * @valid_links: bitmap of valid links, or 0 for non-MLO
  * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
+ * @epp_peer: indicates that the peer is an EPP peer.
+ * @epp_flags: Negotiated EPP capabilities
+ *	(bitmask of BIT(%NL80211_EPP_FLAG_...))
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2544,6 +2547,8 @@ struct ieee80211_sta {
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
 	u16 valid_links;
+	bool epp_peer;
+	u32 epp_flags;
 	struct ieee80211_link_sta deflink;
 	struct ieee80211_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5c33486c6380..81ada0c3a7bf 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2973,6 +2973,13 @@ enum nl80211_commands {
  *	primary channel is 2 MHz wide, and the control channel designates
  *	the 1 MHz primary subchannel within that 2 MHz primary.
  *
+ * @NL80211_ATTR_EPP_PEER: A flag attribute to indicate if the peer is an EPP
+ *	STA. Used with %NL80211_CMD_NEW_STA and %NL80211_CMD_ADD_LINK_STA
+ *
+ * @NL80211_ATTR_EPP_FLAGS: A (u32) bitmap attribute to indicate the negotiated
+ *	EPP capabilities of an EPP AP and an EPP non-AP STA. See
+ *	&enum nl80211_epp_flags for details. Used with %NL80211_CMD_SET_STATION
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3541,6 +3548,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
+	NL80211_ATTR_EPP_PEER,
+
+	NL80211_ATTR_EPP_FLAGS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3702,6 +3713,21 @@ enum nl80211_sta_flags {
 	NL80211_STA_FLAG_MAX = __NL80211_STA_FLAG_AFTER_LAST - 1
 };
 
+/**
+ * enum nl80211_epp_flags - EPP Flags
+ *
+ * Negotiated EPP capabilities of an EPP STA
+ *
+ * @NL80211_EPP_FLAG_ASSOC_FRAME_ENCRYPTION: (Re)Association
+ *	Request/Response frame encryption support
+ * @NL80211_EPP_FLAG_1X_UTILIZING_AUTHENTICATION_FRAMES:
+ *	IEEE 802.1X (EAP) Authentication utilizing Authentication frames
+ */
+enum nl80211_epp_flags {
+	NL80211_EPP_FLAG_ASSOC_FRAME_ENCRYPTION = 0,
+	NL80211_EPP_FLAG_1X_UTILIZING_AUTHENTICATION_FRAMES,
+};
+
 /**
  * enum nl80211_sta_p2p_ps_status - station support of P2P PS
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c81091a5cc3a..afc636a31f57 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2199,6 +2199,12 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	mask = params->sta_flags_mask;
 	set = params->sta_flags_set;
 
+	if (params->epp_peer)
+		sta->sta.epp_peer = true;
+
+	if (sta->sta.epp_peer)
+		sta->sta.epp_flags = params->epp_flags;
+
 	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		/*
 		 * In mesh mode, ASSOCIATED isn't part of the nl80211
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c464c449cb0b..93c075c19807 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -932,6 +932,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
+	[NL80211_ATTR_EPP_PEER] = { .type = NLA_FLAG },
+	[NL80211_ATTR_EPP_FLAGS] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -8416,6 +8418,10 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 			nla_len(info->attrs[NL80211_ATTR_STA_EXT_CAPABILITY]);
 	}
 
+	if (info->attrs[NL80211_ATTR_EPP_FLAGS])
+		params.epp_flags =
+			nla_get_u32(info->attrs[NL80211_ATTR_EPP_FLAGS]);
+
 	if (parse_station_flags(info, dev->ieee80211_ptr->iftype, &params))
 		return -EINVAL;
 
@@ -8789,6 +8795,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 	}
+
+	params.epp_peer =
+		nla_get_flag(info->attrs[NL80211_ATTR_EPP_PEER]);
+
 	err = rdev_add_station(rdev, dev, mac_addr, &params);
 out:
 	dev_put(params.vlan);
-- 
2.34.1


