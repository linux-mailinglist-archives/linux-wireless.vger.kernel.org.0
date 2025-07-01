Return-Path: <linux-wireless+bounces-24696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C62AEEBC3
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 03:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1F317FD9D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 01:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF01D54C2;
	Tue,  1 Jul 2025 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kV+qZB0b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BB1B423D
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331870; cv=none; b=E0wTtPF17ciN7+hSYchxXjyNtCfidtC/n2/BgfDKJtmdE+ck9wu0lExqG/h5I4MWvA8KJua8bPEtPyzOxq/tVW0SFWhRBTVyoCLDo7MVPcLBQuoApbkQbfF7YY0YpMDBTgMWlSA2imn5ioGIkupiWjiOSqBU+CwKr7bYdLY25QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331870; c=relaxed/simple;
	bh=MmhND7I1idhsKU0SSuJvK9YXXVdUfYr/01ddKzjcxzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lgx8YtS1vXOZp/OsK1IqTT9CT5H+I0WQXHRlPzvnttmSWYa0AR8TGxlAtrG3ffAA9qjc/kX0eoPxq5pYZT6odbmuRUhSOKPnkVGbNsFL7o3vp8Ik40hk+c04heRgriNx6sFC2x8fjDNbiOcvlfu00JmY3nCnlUgLhl+P11QCllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kV+qZB0b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UG1Uho000442;
	Tue, 1 Jul 2025 01:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+eYC8FGLp5418V7GBNbgy7XtOkof7ftP9knQUufwjM=; b=kV+qZB0b7YlJoE1Z
	4OZ40hkbbZm4gQvT6YMwbXyJiYcIobzaFbuBkZOjF9LkvEw74bBi1fgaF2JRDfr5
	JuGza6IMI2BA3B2dhTkE8jPuiW8g4F084BPziE0cMZdhAjtMkrrHIyjBaHVuEF+O
	2XCZmUPwzePtKu84OknFBGUB668K2s3UDfBn86dY/TLRSXzw75NeXT/3FfvqqjGf
	U+RgKWqmgu2wDvSPGWsW4+f2ZyhXrDTE8pEoa43B3bLCJ/2RaKXqCjmhP77Xb6p9
	FSGxsA4txy72dasw42jlrhc02PH/Mwu3O/ygmujM255hb1/EV8z8eoGe5t5SLaYk
	FTHLow==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qm6hyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 01:04:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56114NT2017236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 01:04:23 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:04:22 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH ath-next V15 3/9] wifi: ath12k: move HE MCS mapper to a separate function
Date: Mon, 30 Jun 2025 18:04:02 -0700
Message-ID: <20250701010408.1257201-4-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=68633418 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=4Pgy4kl5F6fn7-PMLAkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: B9rjQBimOv-5qIEihjYgG85nrMabGMSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwMyBTYWx0ZWRfX+vXHAMPf4pE+
 Nal+Mobk3Uinvq6hEpOyUaZYqlbQSfDoQVHmAI36yd8HzwsmkScQRFvTuBSTheRRSXit0tdm2OY
 g3q4/c7E/969DdWE+QwEKBg/K0o0eYV3UNSpQbf0VRrcZqoAz1CVJRKVM8Iunw/WhX0mFXVauzg
 EKiamkP8H3JuAIr51YAx78JTGWWjvJzKboU5E4olhkHCn9+94egziHw5hEznBcw3hWsozbEL83R
 LsJHyhU6OvoqMAdHcB4GkUjqx534jm+WaxV9QuRfC4UyJ1sfQlflysdh9Eko5HjulFRKGEOUzFd
 qfitS6635246XT13qpTl0MFUlvLTXrAnVxZV6Fr3CqOZ84jMDNTb/0JiKvnD7dJI/9Gxk7iJsuP
 oyVE0xeCr68lNSGD8EEzhdJoCpkQllCOcMhD6pmQW++DP8qTLP4NxsARdeuxPMYtQNtTpQDn
X-Proofpoint-GUID: B9rjQBimOv-5qIEihjYgG85nrMabGMSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010003

Refactor the HE MCS mapper functionality in
ath12k_mac_copy_he_cap() into a new function.

This helps improve readability, extensibility and will be used
when adding support for 160 MHz bandwidth in subsequent patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 811b44c703b4..f3833fa08070 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7537,12 +7537,24 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
 	return cpu_to_le16(bcap->he_6ghz_capa);
 }
 
+static void ath12k_mac_set_hemcsmap(struct ath12k_band_cap *band_cap,
+				    struct ieee80211_sta_he_cap *he_cap)
+{
+	struct ieee80211_he_mcs_nss_supp *mcs_nss = &he_cap->he_mcs_nss_supp;
+
+	mcs_nss->rx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
+	mcs_nss->tx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
+	mcs_nss->rx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	mcs_nss->tx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	mcs_nss->rx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+	mcs_nss->tx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+}
+
 static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 				   int iftype, u8 num_tx_chains,
 				   struct ieee80211_sta_he_cap *he_cap)
 {
 	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap->he_cap_elem;
-	struct ieee80211_he_mcs_nss_supp *mcs_nss = &he_cap->he_mcs_nss_supp;
 
 	he_cap->has_he = true;
 	memcpy(he_cap_elem->mac_cap_info, band_cap->he_cap_info,
@@ -7582,13 +7594,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 		break;
 	}
 
-	mcs_nss->rx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
-	mcs_nss->tx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
-	mcs_nss->rx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-	mcs_nss->tx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-	mcs_nss->rx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-	mcs_nss->tx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
-
+	ath12k_mac_set_hemcsmap(band_cap, he_cap);
 	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 	if (he_cap_elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
-- 
2.43.0


