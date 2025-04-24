Return-Path: <linux-wireless+bounces-21948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C00A9A01B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 06:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDD43A52A5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 04:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6C1AAA2C;
	Thu, 24 Apr 2025 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hc67dzGv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB51198A11
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469202; cv=none; b=B2CvDQo8m0C4f3w1DPkrXG5sxnbIlN5LMClmikJt7oSMHYi+4u+eqLf/WcxPJlQBRL/FYlYYO97TB9jd1CH/vUMyOAJ04Of+1LKSWnZ/T8yu7p4kOtd9M8AOL1BnW+oBBQjiJlujwdlyrQB+Qz7a0bOup+S5GilY/31VxTNURoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469202; c=relaxed/simple;
	bh=At+l1hjICY0CIeEfZl/LT+VCpc7Ucs7ZRox1lQYNifE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZOs99Gws2i3mMRNyTdNyEMo4geTqTs5FXGL5F/6ZjiQYCajkAnjG9J6dBygKDDt952wxn0uoHchbHTWESPokavrkRBQoS/ZXT4W0H5AhxAs2jPRBnxu+atyQXwneQPPNbmwadTyingG0H6+xkzviWVphzwDtHAM6obFwJlHts5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hc67dzGv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0GsjD011348;
	Thu, 24 Apr 2025 04:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KXj/jWJiCJovqLCBqfRfnE
	CkYVb7TWjCqx/Wa5xrSxQ=; b=Hc67dzGv01YqdFV4ruz7/Gb5t1/Jc7cL7WJhOp
	/J+dazvLRkKUb3pxa0NIHVKTbmRrJKWAMu/2sJEioMMpOidRt7ejnZyXNJHAvKzC
	p/W820l9BD2xP7WzaA3bmgyZNzpN7gmirBUy6INgL7nv7KPzOPJw093NshCaCMaC
	YvI8nRAcq9K3C2cT3ZxO9PosbUV5XKjTLwAHDRG+VMxCNGYhqBr0oz4ESDMQVc8r
	0OGY8ZA2P1Rd07ZHm8ZGTRJ2GC1YrQlU0LVH7CaZz9tymok3IqWVNu1eMDEEf5+n
	jce6kB4AzBKHwSlERVpXF0zKe7gCqHtHW27Ify/m75OM96Lw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3c671-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 04:33:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O4XFId001085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 04:33:15 GMT
Received: from hu-mkumarg-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Apr 2025 21:33:13 -0700
From: Mohan Kumar G <quic_mkumarg@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Mohan Kumar G
	<quic_mkumarg@quicinc.com>,
        Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
Subject: [PATCH wireless-next] wifi: mac80211: Update MCS15 support in link_conf
Date: Thu, 24 Apr 2025 10:02:56 +0530
Message-ID: <20250424043256.2982345-1-quic_mkumarg@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n8ox9xEoE4GEtnsI5Icb3Q_-YgUNyxlX
X-Proofpoint-GUID: n8ox9xEoE4GEtnsI5Icb3Q_-YgUNyxlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAyNiBTYWx0ZWRfX8m21z2zeHnzU TkQnPcHTn6TEH0NMqpZBCVvp2Fhf1l2stQN2Y+zWxUrpUtlSr+sEBLdAsQZ36ro9tJViP+YONmy DXiRYhk0NRYlAO6PtOnjWYiK26DxPAIBbsYT4Ta/PwsC5JptWCYNmt/xcYYpTBlcKMY2S7fm9Uy
 tSasFAmUe8Kek4qmJA3Xo2dnfkoyc92nIWaZ6f0lUpKB2p3qOobgJWGSeKmoK/JBxby2d99yNjb PiCwuBZwgzo75wMfqU3Y8119YCh5m39SFDd2VKFHuyYuzu6yKksInj3HwzGIMBk7ji05t1bUBss OwH1ZYJuntSM5Mcp1WTbYUnZsOTf9yOeOQ3d4Mp+qFB9iBmoevluONWT1xFVp3lSMG6EhE4aMXP
 i7EnGdU2LeeHEWlVWhhzdnF95iWh9G39Hoh8vDhqqLgZbkdBW4wXp8bD9Bay8h8pl2UTNFAL
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=6809bf0b cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=vrC7S3Cpm9M9vciGCMwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240026

As per IEEE 802.11be-2024 - 9.4.2.321, EHT operation element
contains MCS15 Disable subfield as the sixth bit, which is set when
MCS15 support is not enabled.

Get MCS15 support from EHT operation params and add it in link_conf
so that driver can use this value to know if EHT-MCS 15 reception
is enabled.

Co-developed-by: Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
Signed-off-by: Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
Signed-off-by: Mohan Kumar G <quic_mkumarg@quicinc.com>
---

NOTE: An upcoming ath12k patch will utilize this change.

---
 include/linux/ieee80211.h | 1 +
 include/net/mac80211.h    | 2 ++
 net/mac80211/cfg.c        | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 15a87f522017..fd26930a26f8 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2325,6 +2325,7 @@ struct ieee80211_eht_cap_elem {
 #define IEEE80211_EHT_OPER_EHT_DEF_PE_DURATION	                0x04
 #define IEEE80211_EHT_OPER_GROUP_ADDRESSED_BU_IND_LIMIT         0x08
 #define IEEE80211_EHT_OPER_GROUP_ADDRESSED_BU_IND_EXP_MASK      0x30
+#define IEEE80211_EHT_OPER_MCS15_DISABLE                        0x40
 
 /**
  * struct ieee80211_eht_operation - eht operation element
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index fdafc37d17cc..bdddca284208 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -707,6 +707,7 @@ struct ieee80211_parsed_tpe {
  * @eht_support: does this BSS support EHT
  * @epcs_support: does this BSS support EPCS
  * @csa_active: marks whether a channel switch is going on.
+ * @disable_mcs15: disable EHT-MCS 15 reception capability.
  * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
  *	when it is not assigned. This pointer is RCU-protected due to the TX
@@ -830,6 +831,7 @@ struct ieee80211_bss_conf {
 	bool eht_support;
 	bool epcs_support;
 	bool csa_active;
+	bool disable_mcs15;
 
 	bool mu_mimo_owner;
 	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9017b98fea04..e521eafc69e5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1421,6 +1421,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				(IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
+		link_conf->disable_mcs15 =
+			!!(u8_get_bits(params->eht_oper->params,
+				       IEEE80211_EHT_OPER_MCS15_DISABLE));
 	} else {
 		link_conf->eht_su_beamformer = false;
 		link_conf->eht_su_beamformee = false;

base-commit: f600832794c91d7021d7337104734246b02a2b86
-- 
2.34.1


