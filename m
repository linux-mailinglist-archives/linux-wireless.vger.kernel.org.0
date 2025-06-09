Return-Path: <linux-wireless+bounces-23833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD8AD163C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CE83AA3DA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5F1FC3;
	Mon,  9 Jun 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkxnfGyo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF120EB
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749427860; cv=none; b=Q+ICIOw8DRKuHaqBcKTFt2ru9zdZkj0FxmnY2/90UDvqUPCohjusoSyIiEn111swHqSliY1iv3btYDE5VbWO2L/tzLA67IJHYy8sxPnOXcAMkch3kG0kvoS/UO9qFMziRW6un9xB4v+zvRKzZylTP/bmPQfgGv4Sfb5451v/lLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749427860; c=relaxed/simple;
	bh=rVG9I1dsmVpODQSlrqbUgX+NU/9gS8va7lNKqH7QDw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGeDlCg8yYBaehZs3+kjBQwf5o5UeeFMoulNJEKvVx5hyB89sTgz6nupiygg+/n7NV+nQTKOoRXGEZuFlaxyX2dhv6IA3lIr8NpXjClRtESDCgzIlsiIaRy8O7xD1VdLpLSPioKNJpPKuLEZcsj3obq7iAe36djUL3/2le9+/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkxnfGyo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558N6HvU000485
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 00:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vU3slacD63F
	XPGwNfK+QHmRo5Ka90SdOVDtxxih8Exk=; b=hkxnfGyo2VMTLjYH3XYXtSssMSZ
	VoTpRcO4UsIHhJruKPsQKdJyG4rjOP7dD5cfTU4o2ATEf8VK/luG3qUq9VZeJOsU
	mXIH7BfMVf2OBn/+mFYiGeL+jhaYuQDbKHhLJYmnpJdHZyryZFz4cB80cF6Kdagj
	QMFujbKLXlgHF3dIlFMBr3XNdtX6gw2uwyFAd6sn0et/htRnSFRsG1bBFLYny453
	hn4e9SS4/4QmWlYPjQDqXA4M+73XzijlVX8S24RPKMx4ehAfWIQPB8qVnkXQnOsH
	UTz+8ak5ZiNQNUs0fxW5pO5AZs0G7PNJGCtHHzdxdkIkVpIk7JlbX76vT5A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474d11ve69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 00:10:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235842baba4so31613645ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 17:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749427856; x=1750032656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU3slacD63FXPGwNfK+QHmRo5Ka90SdOVDtxxih8Exk=;
        b=b4RlvSYBgFAjxvWkFCCmW652ZhVxsO6IcHHY8T6vNRoYikCin/eSXToMt1CsBL4nvk
         gYacs6cw1y/nj0kDpBW2L6tVax9KMFvPQyom1fR6xmO+TZVRpOTwq5Ofxrbok6p84Jhr
         9UDQK8ttsiM7UcwdNkYkqGNC429de3sDGKZq2P8F+rfiKepwSzPKMxqxbvzIuuGaUhCH
         QYxmr5Oi8s1dGVZSlwEWWlYk73OD1kTguXnKqdTk88dPsJqzXGDJqJv3zQKWaQMKfWcX
         vwwK2RnhVnVX1dz4eJYLKnE5LtKCCDmGBmjXAzkdmkNFyIbCNG0URCh2mOrFlk2dQdpN
         MW0g==
X-Gm-Message-State: AOJu0YxURocluhkKogwwUOuAScfFl3HN8t0BZ5I9C3CCmsW52PP9tHdH
	sFVCaMEaHQHX6QVpm6bZFUBcvXJSB6XsB7qNqRkvJ48vPiDFPDkqNd4UPo+ZcvM6AZzA6tK7yTf
	sRJ99Y06QsQt0G2BpUFM9QMmIKAUiR2jduDcbrICEgSoD06XZdg03NmB4bAeX2cLOhpOcXg==
X-Gm-Gg: ASbGncuxTt1ulYzuEb3pAetphxSe8HUNZM9NtJNKcpmoJC/kKBxZvohVP24tuaZ3c9i
	mJaeGTLAs/2JXaA5p8IWZJRUSgM6JbBCWA4dmlasOlk6Qf9nUTBcZazTVCQkyQBL9cvixsdy+XJ
	XLd0S+xL5IGe6UB136K6kbLRsGW0pYuQWV2dRLVKoOkQ9ua+ZMLHTS1CYXoh6LB5eMW4WKX5buB
	2xo1wwrH42U0LIA50r8na8ifsb2TwSKmdxv+qZqUoJOQLWTsNv1wVOWrzVyBxP+J75GSPNn1e9t
	sehwcfPwdiB78nz511MFlBQ2pXltSCTrGvoF82/ZKoDeICyDt7CNuS2w1LhmcupeR1nsiRowTkR
	zIt5aT/oTYNzU2WXCLN6gd1uQHI9UjOQAwA4eqBSSSIt1C4C1ljA=
X-Received: by 2002:a17:902:ce91:b0:234:e7bb:9640 with SMTP id d9443c01a7336-23601ed6329mr169861775ad.44.1749427856544;
        Sun, 08 Jun 2025 17:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZVAjFLgXzEW9psAJQituVfG0bOdTGp7YM9USikP3VuDGuhNs077kH7bFrjiKj/yEte41b/w==
X-Received: by 2002:a17:902:ce91:b0:234:e7bb:9640 with SMTP id d9443c01a7336-23601ed6329mr169861445ad.44.1749427856141;
        Sun, 08 Jun 2025 17:10:56 -0700 (PDT)
Received: from hu-rkaliapp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034059cbsm43731235ad.165.2025.06.08.17.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 17:10:55 -0700 (PDT)
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
To: johannes@sipsolutions.net, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
Subject: [PATCH wireless-next 1/3] wifi: cfg80211: add mesh peer with puncturing bitmap
Date: Mon,  9 Jun 2025 05:40:46 +0530
Message-Id: <20250609001048.2263586-2-ramasamy.kaliappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
References: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WxT38iduxq35EZXfPIg7-tHX0EtnVAjE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAwMCBTYWx0ZWRfX2bgywMHepWqn
 lYRfMFeLAGGRQx6Nal4WsB4s63/3z0PQnHY4Loo56DOflifbd2PtFhLpIhdFPg33/xfaC91gRQ0
 UXSyI25dw5t6MZqT0qjob7s/1cnsa0BHxm5+FRDcx+F9d0ZoMcePozC8WIjj4VI70rfhYzKtR0y
 hlgsJDPBzehaDswKdHSV4JrsAQgXvttRWrJcldtfTSEvwvOG33LiSEWQinFit6D/LpcNORipu6H
 rWGcOybvYCDzyjQV+6RQ/dA/AUeugt011UryjH0T0YRVHCG0yqLBr28NaJobWZBzw3bLJ79RdCi
 iAoEC5m1T6lvLohUCklU6PeGksC9WyF/qdqViD/ao7+ZZb75uiLiXkkP8pqzbKn/EaNJH46r6lw
 eCXenjkQZKV54u21fKfMvGCYUzl+a5TJJLevHOVMqWZnAIqdjSTkdAHIT9dJ9iN18DfuU0ZF
X-Authority-Analysis: v=2.4 cv=GYkXnRXL c=1 sm=1 tr=0 ts=68462691 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=IyDEItP2xcx-QbxgRyMA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: WxT38iduxq35EZXfPIg7-tHX0EtnVAjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090000

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

When a mesh peer has a different disable subchannel bitmap advertised
in mesh beacon's EHT operation element compared to the mesh
peer STA, there is currently no option to send the disable subchannel
bitmap to the driver when adding a new mesh peer station from the
user-space application.

Add the ability to receive the disable subchannel bitmap using the
attribute NL80211_ATTR_PUNCT_BITMAP which userspace can include in
the NL80211_CMD_NEW_STATION command when adding a mesh STA.

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..47cd87541917 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1653,6 +1653,9 @@ struct sta_txpwr {
  * @he_6ghz_capa: HE 6 GHz Band capabilities of station
  * @eht_capa: EHT capabilities of station
  * @eht_capa_len: the length of the EHT capabilities
+ * @punctured: Preamble puncturing bitmap. Each bit represents
+ *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
+ *	Bit set to 1 indicates that the channel is punctured.
  */
 struct link_station_parameters {
 	const u8 *mld_mac;
@@ -1671,6 +1674,7 @@ struct link_station_parameters {
 	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
 	const struct ieee80211_eht_cap_elem *eht_capa;
 	u8 eht_capa_len;
+	u16 punctured;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd5f79266471..3a7bd549363f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7681,6 +7681,17 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			nla_get_u8(info->attrs[NL80211_ATTR_OPMODE_NOTIF]);
 	}
 
+	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
+		if (wdev->iftype != NL80211_IFTYPE_MESH_POINT)
+			return -EINVAL;
+		params.link_sta_params.punctured =
+			nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]);
+		if (params.link_sta_params.punctured &&
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_PUNCT))
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_STA_PLINK_ACTION])
 		params.plink_action =
 			nla_get_u8(info->attrs[NL80211_ATTR_STA_PLINK_ACTION]);
-- 
2.34.1


