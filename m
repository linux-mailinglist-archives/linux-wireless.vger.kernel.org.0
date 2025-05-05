Return-Path: <linux-wireless+bounces-22457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32959AA978B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABD516CF50
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CD225D214;
	Mon,  5 May 2025 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XKMa+h6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2024EAAF
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458946; cv=none; b=RvE82eswJ7Ug+i+XIblyuN4hNdX1Zf9YLrVlQF8cU/ymt4NqX8upNy7u0cfX7oE+x0NRP+3lQwiEe7yORs+/ehxE3t5adUJSyg64zd1qSoQNn03guawzC4ZCp++7OgYU3S11Upc45DXPlP+VVmRcXjRyu42kfSma55OpwcyKJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458946; c=relaxed/simple;
	bh=I5QcO4jKVCKqW0OolEg4XiNdNOi+RRzOqTI+RdIjEyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kiHGaw2GxFFsvyq8nFqER+OTSq3PjXYI+WOCtW1EsvE0I2JhIyabSAPdrKMAk6162hpBqso9sUWNTdszIpRV8+hYLh0LEpI33WJuPQS01Y7hSTu/cazw/EngaIaxgp6nIWGjt6peLVMEeL9nO678jXBg/S62dBfQu5FFKK4IEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XKMa+h6M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545B4ILs020157;
	Mon, 5 May 2025 15:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H38pT5Qqroakim3QaYQ/A4
	O/aEKoqS2gIIQj09+XkkU=; b=XKMa+h6Mss9u+kZ25vqsRVjRjRnLEW1K0JHfWF
	amG6Fs6J4DVqT7w/MhtS7S0YISatAZnZtrqppyNhHRUz88PYct5x04L3BSL1hdd3
	ARedGET/i1dZLN4/4lqpIvJtwSTYWDZyN71KWQZfrKp4Knhqgd1Z9dtb96ayu6G6
	BjFQaxUIiecqCu7LUTF+5xKV+IZkLDqNR/Vqx1Jj74e1cPqeCBvMewXycZfdEhVe
	pWpWuUtBbUdrXM22Ziyp2duV7HyQ3HKCq66QRZOceZRLsrgDw82XEZFDnhmyEoWF
	1AKJoYOR9iJN/igVl8kAhEbTTugOao1KI9p9as1MVECPQWCg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46da3rvhgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 15:28:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 545FSrbn020000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 15:28:53 GMT
Received: from hu-mkumarg-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 5 May 2025 08:28:51 -0700
From: Mohan Kumar G <quic_mkumarg@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Mohan Kumar G
	<quic_mkumarg@quicinc.com>,
        Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
Subject: [PATCH wireless-next v2] wifi: mac80211: Update MCS15 support in link_conf
Date: Mon, 5 May 2025 20:58:36 +0530
Message-ID: <20250505152836.3266829-1-quic_mkumarg@quicinc.com>
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
X-Proofpoint-ORIG-GUID: iw_fDqLZeQqLzRY_hBMTfTW9GeCiHGtR
X-Authority-Analysis: v=2.4 cv=cpWbk04i c=1 sm=1 tr=0 ts=6818d936 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=hgypfvcpLBuc_uXBHUwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: iw_fDqLZeQqLzRY_hBMTfTW9GeCiHGtR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE0OCBTYWx0ZWRfX9hxRxhaVUK+L
 cSdjKlANozaAw7QMhYrSEQriwULa9JHJL2EKLqeF3mGAt1x8IsFKl44H4OJyc2bp+YuAREJfCrB
 oU9WSWmeC20Uo64eLQ5j0LIcJbijHCe7wrdfhEqqvXkZohAGBW95iTahNYCbpyTP4VFLF4nIg6x
 stscpobSioxHOYH4Xlqd6Q0rowUeam0zs8sekWgDPxRs1MP3gLnGyH4HyME2lSPDOnk4M2XrHAU
 odcnzOjkCFptUCsqwaLpFf0PeALImcpsOBjKqV6l8yq+gQY72/chKv8CdFTQwWbY8ZuVGCLPMFo
 PTbhzBLVU1KtTK7irEccopY0JVILR9bBVfzzv9YYQRhg4pmdEmttaznzpjtBp+eLBDW27ogPFfd
 fbvqkxDHzqgsLcMOhDYGjjgfgAYSLowQpmgLStknziIcGg++tMqbifmd3HKYUqtYr08LfSZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050148

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

v2:
 - Added eht_ prefix to disable_mcs15

---
 include/linux/ieee80211.h | 1 +
 include/net/mac80211.h    | 3 +++
 net/mac80211/cfg.c        | 3 +++
 3 files changed, 7 insertions(+)

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
index fdafc37d17cc..82617579d910 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -744,6 +744,7 @@ struct ieee80211_parsed_tpe {
  * @eht_80mhz_full_bw_ul_mumimo: in AP-mode, does this BSS support the
  *	reception of an EHT TB PPDU on an RU that spans the entire PPDU
  *	bandwidth
+ * @eht_disable_mcs15: disable EHT-MCS 15 reception capability.
  * @bss_param_ch_cnt: in BSS-mode, the BSS params change count. This
  *	information is the latest known value. It can come from this link's
  *	beacon or from a beacon sent by another link.
@@ -852,6 +853,8 @@ struct ieee80211_bss_conf {
 	bool eht_su_beamformee;
 	bool eht_mu_beamformer;
 	bool eht_80mhz_full_bw_ul_mumimo;
+	bool eht_disable_mcs15;
+
 	u8 bss_param_ch_cnt;
 	u8 bss_param_ch_cnt_link_id;
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9017b98fea04..71f6030e3511 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1421,6 +1421,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				(IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
 				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
+		link_conf->eht_disable_mcs15 =
+			!!(u8_get_bits(params->eht_oper->params,
+				       IEEE80211_EHT_OPER_MCS15_DISABLE));
 	} else {
 		link_conf->eht_su_beamformer = false;
 		link_conf->eht_su_beamformee = false;

base-commit: 885e5cbaa0ee3738fcd99167439459ede2cc102c
-- 
2.34.1


