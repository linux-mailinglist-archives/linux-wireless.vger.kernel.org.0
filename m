Return-Path: <linux-wireless+bounces-30346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D3CF238A
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36CA93038332
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF782D7DE2;
	Mon,  5 Jan 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RyUAaajv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ROBkPZwp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8718DB35
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597925; cv=none; b=V2G4d2Ao/wtR0ESVZ0XNHF7WFilkbf7m7uXgtxUMU+HtWCrMOIZvA5qhM6h3wp3hSYyejtDvVcCV9nSsH7S/H5iYo32forSrhoxSoBom2yiVh9IHwmJyMS/O3w3f6LSAkPN9iqe50rCFc00fTEkVndMB3dzwNjuc3P1SDNTr5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597925; c=relaxed/simple;
	bh=oxA+7iVJr+nS9YM4i0bCfkWTxYafVVQ/c+nyGvLKNhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/0CMgUHYXdSwQbL86v32PWVnt3/RPhvE18mc9y/ETvXT1SwhL5cCl6ypZr7IDuujAgaL5eqVT8GBwDfJJJTsVUSEHB4s2oEDaF2LZwE+mKjj6+5+PiNMfhwiSFBYJ8CnxMNX4BknvbUAYzx1xnHZkbrOlU3dln4WJ7R7Isu+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RyUAaajv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ROBkPZwp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6055ZTKv4031715
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tqja4OTXFNT
	3u47pL22RWBPmyTVbsLnCE6ubN6Tn3UY=; b=RyUAaajv8/4XhPUG7fRbwfLkX6D
	Lvtz93gesFTh+Jl7Fj8w3j+5mCWbtyXwC3A2LOEEeA1SDHzNI6Z6tr7kzzTdi3us
	tO1tYCUOoMLjArg2svqFKQrUNgcwXxDyLN5Sc6mw56Iwiub9cvslLSpMab63d7FS
	rsRcBNjM4nBVn1V1y0Hl9Aho4m2594pNXPEcEYaAvggurHTdX15POs056hIv+GFn
	M2DaYUY9i9FYaNTf1F773LUv0fHXtfcpEYUh57XkSid6kkSFQc8C4sz/Zd0DAWX4
	YvsDh3CmNhbMr3MWHjXwUFIom24vB0zCUL9SoPVQ6/SE8KPEjSS2RkYaqOg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg79nga95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a351686c17so198269295ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597915; x=1768202715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqja4OTXFNT3u47pL22RWBPmyTVbsLnCE6ubN6Tn3UY=;
        b=ROBkPZwptvdMsz01s+VQx8ULwppH/yLws0nLWxxBO7bWI4krQf35Ikh3qT5AeZFq1i
         17uJyvVS1ZyTqqol5stIeiR/JmAziqNYTjkg0XAPqPULzVe86Sqrs8ARTjXvt6hOi/yz
         IKbFefHdjRl3tzXtcmJ1tcA3ad+q1IWjdu/iImaJVzV6j7Gdn8EXnixnpe0VKCxRdcZ6
         ZjexU4zQ81QnqJw/64bJWJxYE+cOvwA2I9QaciITt6l8jJw5yMSjM/KRsWO7JPajcP7Q
         vWq0VElp0dKlr3rN7biFL6V2WzBzv8xFcZv0mlbIU31Vj+0AyCSC2bQGio9iywPBtR08
         3AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597915; x=1768202715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tqja4OTXFNT3u47pL22RWBPmyTVbsLnCE6ubN6Tn3UY=;
        b=T9ZHLk0imDA99H3bshnv4CWJUkBhYtGLM83Pb+lkcRpxwHq+SwPjmgLuqTUcToibxp
         9h1Woll3A/PT9fD4Jzg39xZvNPkntZMHTSR/EkcuDqDas3QJHTpTJ1P5bklcdarI7OlH
         sV0U9vToQHIEIdl8mphFg24IAVgpYVinCJyDiQWJeflJjTLutKe4oGYy0is8HvEuKPm5
         Q2E2ZDn5L9Wybki/tZNgBQcCQNwTrcVLUhAj4CkNgfHvppsdK608CwbO7TRlzJMOFBa/
         hiUvATfIqR60ckqDgZDrnkGRKv0HPuJ7opMzP0x/iV1QJEnRDnAR3+TcqQFwohm66jdO
         VGRA==
X-Gm-Message-State: AOJu0Ywt3yP1aarZAb5xXIAW0+KEk5Y1q9wxjoxqKEJoyXxHq6gfiu6I
	IXyLpoQpwCwJh/Ne1jThX3LMLW+b6jdkNJKWNQFXHdlSavcr9A4KiuTFTuz8bENNVw7N1ItShsC
	NxLcQ+uTdj3MDbt1qLOv4oS/hwOyjnjt3WJ+2A1wl64ygpeVOH6Oi+y1nkb+kbYWUVfcVAw==
X-Gm-Gg: AY/fxX5TCTtoQJMNUlEyKtLfblwaa7HZq5RUk37X3C/FQAaO7+fh9AU/GKcTVl4+D8x
	nTIuQBbRtlGPeXyl0x86YTgL4SNRoHc01awVF3mmgPOz8poISe/9OoUm2IiKNXCkCn7mByGntI+
	vnttPS2CoPKYzXH7ApVqfQzla42G29ePqmIOs5nac0NaYssrl1UceE4wy6eFMdmCsDl23sUo3g5
	8lLzKEffpgPMfg56CCH21Ggv6X/ukeCchPqKhh/cSxSU7ddGdCmyaVP5sUT/gUk6QaC3xr1I8Rg
	OFtHmuwS5VGTYEVPY/Oap+uLJewIR+GA3dq66axjZglhPhSl7xYh9J1jGQahMjK2uP5NHj+A4ju
	TRJ5ASiGxuaTWCzMCTFehluYQzSeWtTghUTO6/F8zRg==
X-Received: by 2002:a17:903:1a85:b0:2a0:acca:f3f2 with SMTP id d9443c01a7336-2a2f29370d3mr456824885ad.48.1767597914519;
        Sun, 04 Jan 2026 23:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7GxE2sb8zLeaRhj0M7pigHillcbSZ8s9X7sb86Uy2brO4fMadznxEfPOjbWUiv8kH1sK6AQ==
X-Received: by 2002:a17:903:1a85:b0:2a0:acca:f3f2 with SMTP id d9443c01a7336-2a2f29370d3mr456824565ad.48.1767597913927;
        Sun, 04 Jan 2026 23:25:13 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:13 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 4/9] wifi: nl80211: Add new NL attributes to support (Re)Association frame encryption
Date: Mon,  5 Jan 2026 12:54:10 +0530
Message-Id: <20260105072415.3472165-5-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ejBS90E-vf54XpvVSgfuOo8cEBENAV4y
X-Proofpoint-ORIG-GUID: ejBS90E-vf54XpvVSgfuOo8cEBENAV4y
X-Authority-Analysis: v=2.4 cv=Y8P1cxeN c=1 sm=1 tr=0 ts=695b675b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=jRV2BHI1QgqqTT6Ge1oA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfX0mNgakOUlsL2
 QSa7Up2mj1DMRGu9xF0u4J/Rl3W/+FDUkCPrCboHSecS5JJZOUFfwNHGXWq8/2rx7WF54u6ynhl
 AWwF3jA3PYUe0FOOOpyn7fkUQn3nHonrO6fPzBYZZMTFMdfYWl6+coW5vrnZiYgNJe5AQzfRj87
 FKgVjpSi2ABbcAdW83csKEoNzJf8m3DUAwBDGtj2zKiNd0PkYBWQr3HZHWi9kGIEpJFcri88/aA
 tb2EjfEREw94yc42xWay8V6hutgW/X2468QFC5vH9pAnkRgrqoSCiZm7ZcwLgRZ06PgWbPZCEIi
 x/oAp0h5k4kQ/cCRG3+Jkf9Q7V8bRUnFZfyaLij6AFMeYAn43zVGK6fHoWTmHK8Zw8LdmCWBQV1
 CnHd/c5TAgpSFr4zHl3WPhUr9GpxNwIBVXz7Z/uhZ1EHqUL4OyaYPfF6egxXlZ6Q7dRdwzH0THt
 NzauR1111PfueKoI43A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050065

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


