Return-Path: <linux-wireless+bounces-29784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D06CC1194
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85403026B30
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663B344037;
	Tue, 16 Dec 2025 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iWnfwTH9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NdeVbPXu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539034250B
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866466; cv=none; b=NH/xZ8E4puyoS4YkOHWQduNeJ9lOUw/yzltDblmwlB3vnv00RpZ/5VpX7ygR1IfSKnwn1NNMiNzZfmcJIizQL2pwUUKHktN9l9cVhgQwKacspQDFOIwCxeJM/94kGNozQnycRJE+xoqoiGU3KXuYKjY6Etg1IoW8fqPxPhveSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866466; c=relaxed/simple;
	bh=PADovVfNtxJTHvbquLbgCZzeC/Ym2BdWZFaXgujwykg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dh4bg7Ky22Me1dlNOBkiznno5/p92po2DRnabMKBDhSywj3OPJfUtEIfTiGz2qZRh42SVwIsuHfeaDlUAfxNNMcT22dhn57xYiSqMv+fsRdxmzx3oqYLZq+HH80C7CpfLsnQqAeyuVMGPY7J7k4dmCQ+J9ZS2H1Sl0VWxm5evi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iWnfwTH9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NdeVbPXu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG50f9b2282192
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NBhCB7s4WKE
	WOviB1NXWRHeEcGOWYwnKWvYtGU4e01g=; b=iWnfwTH9mOx5GU0qjn8cpUOMOyr
	1avUbh6xS+wimD73H0LFifyGynYbfbpvF5DAestg2G/2VRXEmr/aZq21bj8ygiJg
	ud9XoVFPMi4e1fhXcwiquXdHorkW6N/yJxptQOC9X7WQL9lLAOxsxENIU+i/D5dD
	1GiYZPFhzl244o2Pf8Obld94oJ+Cyxw/eV/iKHKWYg0dUAFuPRW9KI8SiGzKZJhp
	FG05O42hk/MteE0eZ97DBGlQZLcMOFEzbodPJ5zkrTf6l7zF6BU9M/DeLOkCkfOD
	tZEz7pORbc51dIKwDuSrlxvJpcWbgAUmBhwfSCM9aiaCG+DjwkZzhoNbr0w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peractk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0bb1192cbso52885805ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866455; x=1766471255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBhCB7s4WKEWOviB1NXWRHeEcGOWYwnKWvYtGU4e01g=;
        b=NdeVbPXuftIVCtCxt330bWHCJL+v1RvZyOIsNw84zV3+3DmnAs7f/JdM/HZ2tnDSM7
         EyaXoQ50G2FD6+RX2UR5nfBccx9oXRqdQikBhSX9ZWB+nENaxkje4dY+vcNsbTfSS+D1
         ZOD9wJU7c+d+Y8nBDfD0ik3VOHDa5sO9z+8R+aE/BlM+JR9QClUOeZnVUvO4Xu7JUS/B
         Up3TVMEH3E/qbjKTgeOcU5LJNLwu4PG7ZL3i3cdberEIYxUnSAOR0mgz4PoKqq4Y/z4q
         pvrEQj6B55xFm+TfdAdFlspU/9qm7EQtGkRErA1MJ77nWXHB0obZBB64S4lWj7lqMfKo
         KNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866455; x=1766471255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBhCB7s4WKEWOviB1NXWRHeEcGOWYwnKWvYtGU4e01g=;
        b=i6bbl8x3kJKz7a1zR0jO3ds/7BCAYWTdHvbDPzz825XE0nYlhFlDaKoBUivxwXz5KO
         3MK8XrFd2VhQfJ+NOc+Z7p+OkGbFUz2gMoIOS9bCH2awA2VeNU50mRPmWs7uMoqtdCp8
         6m3JJ9U5TtZZb2dGkhfyYlSCtrSxY3h7jcU3sCalurTtl1gKS15hbzwJ7Iy7iDSTKUl1
         2WlWTW7DfChul78OLVobEjyAkrb5YyQDokGJVpSftlJB5zJcvWF3BwVvQpsABFWZtG9c
         AxLJbJUFI5qpVXDZJDZ7jRI4efhJZ3ENkzvQ62mZoDWT0/0NtWGZCuJc7oWHNvuaYZac
         IHJQ==
X-Gm-Message-State: AOJu0YzysMJ3T65cPDzPcHNqTWqTYCwahVnJCHf2lDlgrq3ynnlJb1Qw
	doW4JF/cD6TPr0somXZQF/7utDQo7UCabeoD/SLmFm9meiefzudDjdNHPP6w+WL8hqRtZWi/6e6
	KZPRpgP/4U3ItgSW4usdNzqnC8t/KBn/Wg73WStNI0YAT30D58BFm0A0ma7QRtQkdunYGVQ==
X-Gm-Gg: AY/fxX5scBhpQecesooFJJPXaw8WVFMMmr0qzJQDsj/sU7xdv6vwlIMEkd0cA8dGKFt
	zyhypxVgzFfCRhcbN36gnoiE7lxrKF/b8kfIolCsq1/Z6YYZOOugd0th+v8NhDMq6E8G+E2TW4k
	zNEz4i0aSZFxg9tud5NwxTiSXU5rW61SYwmLeeLC4qciJ8v4TGoETDYQArFkDRmqNX5hUDIcuNw
	kJDm1u96rMPmz+cZDgCy9A+57ImnJgoXTcHhreHTpFJpmMWVjDbZ3InOi5weCOgIp5M+jTCUXXL
	ssPgO7IaKsY7pujV7B26leGXjByuXjl413FsBGtUQD1LiJ0Ope+DQxxNyypVroaw5UqlBsH4Bnq
	VAiCYzBJjZMpWZQvCDrItBUVkWYLFOsOsGzUPYFaRbt6x8rxVtvnuHQ==
X-Received: by 2002:a17:902:d4c8:b0:2a0:b7d3:1bf4 with SMTP id d9443c01a7336-2a0b7d31cfamr92552695ad.5.1765866455473;
        Mon, 15 Dec 2025 22:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqZH6iYwcaldQdNQYAZGmxAtoyN/gjxUw4G4RLqcqa/MoEzy6roczosDmh9VRTzuHUaYQwXw==
X-Received: by 2002:a17:902:d4c8:b0:2a0:b7d3:1bf4 with SMTP id d9443c01a7336-2a0b7d31cfamr92552265ad.5.1765866454946;
        Mon, 15 Dec 2025 22:27:34 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:34 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 10/13] wifi: mac80211: Handle station association response with UHR
Date: Tue, 16 Dec 2025 11:56:53 +0530
Message-Id: <20251216062656.1738022-11-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S6qSet0gh4CIrdHlH8c3Zos9LWlS11PA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX6cpedBWyMNKi
 CDKF3a3GQPq0645b8mESYK4AhelaAmWLSYxj1ypYNzU3Nt7akbfUuQFRZDYqgdyqSC3/SpQmLja
 wUXBHNXrGZod5/HW9zX6levqDHj2ncMABirrlgY0DvwZDPEEBxv6Vdld0PVsrdebZT0k99O6M+W
 9SH9YT3BIpblymS/gKz5EXmlBugWWrhfc/KEKBA5FvC0xY0YxRyNWy/K4Gkx0rVhf6XIXvd1Kbh
 9fKZTvVQqdd+3XzBAF1eEHM6Zagh2gu565cZ84YZZs5VrY8ZWmiu/WdRXyB257Mi1C7F3Iw2ZwF
 4//NJyVG2xXpj2OoSrzGYUGLjg+KHwLzeA5H3bNcljdsM81dt9fThyFurOqEaUwxxVyyrCgZ2j7
 0B7WXmkvUVSkNuvnzINjkzslnNrrWw==
X-Proofpoint-GUID: S6qSet0gh4CIrdHlH8c3Zos9LWlS11PA
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbd8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Y35MOufpxg2b5NnyCd8A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

When the association is an UHR association, parse the UHR
element from the association response and update the
station's UHR capabilities accordingly.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/mac80211.h     |  4 ++++
 net/mac80211/Makefile      |  3 ++-
 net/mac80211/cfg.c         |  6 +++++
 net/mac80211/ieee80211_i.h |  6 +++++
 net/mac80211/uhr.c         | 48 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 net/mac80211/uhr.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f1d2953a074..73bd3331ad5d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -760,6 +760,7 @@ struct ieee80211_parsed_tpe {
  *	(as opposed to hearing its value from another link's beacon).
  * @s1g_long_beacon_period: number of beacon intervals between each long
  *	beacon transmission.
+ * @uhr_support: does this BSS support UHR
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -861,6 +862,7 @@ struct ieee80211_bss_conf {
 	u8 bss_param_ch_cnt_link_id;
 
 	u8 s1g_long_beacon_period;
+	bool uhr_support;
 };
 
 /**
@@ -2442,6 +2444,7 @@ struct ieee80211_sta_aggregates {
  *	notifications and capabilities. The value is only valid after
  *	the station moves to associated state.
  * @txpwr: the station tx power configuration
+ * @uhr_cap: UHR capabilities of this STA
  *
  */
 struct ieee80211_link_sta {
@@ -2464,6 +2467,7 @@ struct ieee80211_link_sta {
 	u8 rx_nss;
 	enum ieee80211_sta_rx_bandwidth bandwidth;
 	struct ieee80211_sta_txpwr txpwr;
+	struct ieee80211_sta_uhr_cap uhr_cap;
 };
 
 /**
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index a33884967f21..33a290787241 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -36,7 +36,8 @@ mac80211-y := \
 	tdls.o \
 	ocb.o \
 	airtime.o \
-	eht.o
+	eht.o \
+	uhr.o
 
 mac80211-$(CONFIG_MAC80211_LEDS) += led.o
 mac80211-$(CONFIG_MAC80211_DEBUGFS) += \
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b51c2c8584ae..94ded4a44c4d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2170,6 +2170,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		ieee80211_s1g_cap_to_sta_s1g_cap(sdata, params->s1g_capa,
 						 link_sta);
 
+	if (params->uhr_capa)
+		ieee80211_uhr_ie_to_sta_uhr(sdata, sband,
+					    params->uhr_capa,
+					    params->uhr_capa_len,
+					    link_sta);
+
 	ieee80211_sta_init_nss(link_sta);
 
 	if (params->opmode_notif_used) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3a61710b1532..4ffdb8f75468 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2846,6 +2846,12 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+void
+ieee80211_uhr_ie_to_sta_uhr(struct ieee80211_sub_if_data *sdata,
+			    struct ieee80211_supported_band *sband,
+			    const struct ieee80211_uhr_cap_elem *uhr_cap_elem,
+			    u8 uhr_cap_len,
+			    struct link_sta_info *link_sta);
 void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_mgmt *mgmt, size_t len);
 void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/uhr.c b/net/mac80211/uhr.c
new file mode 100644
index 000000000000..da68088a4fe6
--- /dev/null
+++ b/net/mac80211/uhr.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UHR handling
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "ieee80211_i.h"
+
+void
+ieee80211_uhr_ie_to_sta_uhr(struct ieee80211_sub_if_data *sdata,
+			    struct ieee80211_supported_band *sband,
+			    const struct ieee80211_uhr_cap_elem *uhr_cap_elem,
+			    u8 uhr_cap_len,
+			    struct link_sta_info *link_sta)
+{
+	struct ieee80211_sta_uhr_cap *uhr_cap = &link_sta->pub->uhr_cap;
+	u8 *pos = (u8 *)uhr_cap_elem;
+	u8 uhr_total_size = sizeof(uhr_cap->uhr_cap_elem) -
+		sizeof(struct ieee80211_dbe_cap);
+
+	memset(uhr_cap, 0, sizeof(*uhr_cap));
+
+	if (!uhr_cap_elem ||
+	    !ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif))
+		return;
+
+	if (uhr_cap_elem->fixed.mac_cap_info[1] &
+	    IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT) {
+		uhr_total_size += 1;
+
+		if (le64_to_cpu(uhr_cap_elem->fixed.dbe_cap.dbe_cap_param) &
+		    IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ_PRES)
+			uhr_total_size += 3;
+
+		if (le64_to_cpu(uhr_cap_elem->fixed.dbe_cap.dbe_cap_param) &
+		    IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ_PRES)
+			uhr_total_size += 3;
+	}
+
+	if (uhr_cap_len < uhr_total_size)
+		return;
+
+	/* Copy the static portion of the UHR capabilities */
+	memcpy(&uhr_cap->uhr_cap_elem, pos, sizeof(uhr_cap->uhr_cap_elem));
+
+	uhr_cap->has_uhr = true;
+}
-- 
2.34.1


