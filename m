Return-Path: <linux-wireless+bounces-11058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F4949EC9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 06:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED24C1C2122E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 04:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B93C092;
	Wed,  7 Aug 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZZSlSr3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC723CE
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723004426; cv=none; b=DchsSWSHUSWMCB7bAim9KQjbMNEE2cc5njv0W1pDw22aptEYCpUCH3K4cfIBV8d03bx86smEeatWnsNi/pDl+wQomoiTgXKsxP/otTr2hMyL5oy9jopfDzOITmkoJhxZ0oqV1oB0+B6goJ/+UYcizz8i1GfuYepz4tzlDHWyqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723004426; c=relaxed/simple;
	bh=GwR8cej28nfLdJWeqHSxWBp+trjCbN3XizBWPpYTrJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nswq1RrMykqJM3LbOM3VfHKXl3Q/dQ+WBqC6U+p8zCOkBYyOrH02wf2M/aQqUu5ll6xK1FsdzVNI6dVnC60Na5P8NavQYHaSCfzP7UBkmfkkQaUbg2kf6i6JcCwHQUrpjaTHtU3/YUw0bTVEJ0zKUgBYHHdy3tsvFkDRFMsy0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZZSlSr3z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476H6hQM020394;
	Wed, 7 Aug 2024 04:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0PE+e021TlByEaVz1J4iPC
	K4RhY/nzcNfL3PMa6qt0I=; b=ZZSlSr3zVn+ic9bO9rdbmzHtdw3oDqW2Q4s5fY
	WWyL2tcZOki75Q7uBuV5GB7Nk4aIH/mnTW0W9TqCLuGy8yc/gwOj7FbRrPWGZrxD
	n+fWhcPnKtt/mQy3NL34ooRfiOJdUFMQUvQiRgTr6IBdnoufF361E0TJz8yzNz64
	bZMP7PT0paI0Qho/plLivxkGFby8lHghIWh259qsv21zBaH/ZYkqc2JkcgVhXleI
	pxZ0LMGH2DlKXxpvTxx1jNTNRMBBMZlfPganhIq9Kx1sjj6zzCnNnqUCH91sG/DY
	wU6HIX0ObJNiTJF5iR+urnFvCwkZLjvkL8/EomCXs2OyxvYg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scmu1grp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 04:19:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4774JpFa022125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 04:19:51 GMT
Received: from hu-ajithc-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 Aug 2024 21:19:49 -0700
From: Ajith C <quic_ajithc@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Ajith C <quic_ajithc@quicinc.com>
Subject: [PATCH] wifi: mac80211: override HE/EHT capabilities if NSS is zero
Date: Wed, 7 Aug 2024 09:49:33 +0530
Message-ID: <20240807041933.3196761-1-quic_ajithc@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I5gK0ersm8hBjQeb6BaQEzJdklmQ_jG4
X-Proofpoint-GUID: I5gK0ersm8hBjQeb6BaQEzJdklmQ_jG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_01,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070025

Currently, when some stations send association requests
with the "Support for 320 MHz in 6 GHz band" flag enabled
in the EHT PHY Capabilities Information, but the Supported
EHT-MCS And NSS Set for 320 MHz is filled with zeros, or
Support for 160MHz in the 5GHz / Support for 80+80MHz in
the 5GHz band flags enabled in HE PHY Capabilities
Information, but the Supported EHT-MCS And NSS Set for
160 MHz is filled with zeros, Causes the
ieee80211_sta_cap_rx_bw() function to choose a bandwidth
which has Supported NSS value zero.

This leads to obtaining an Rx NSS value of 0 in the drivers
which obtains Rx NSS from the Supported EHT-MCS And NSS Set
corresponding to the selected bandwidth.

Address association requests with conflicts between
capabilities flags and MCS-NSS set by overriding the
station capabilities flags to disable the bandwidth support
which has NSS 0.

Signed-off-by: Ajith C <quic_ajithc@quicinc.com>
---
 net/mac80211/eht.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index ddc7acc68335..ed9a3d492414 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -7,6 +7,46 @@
 
 #include "ieee80211_i.h"
 
+static void
+ieee80211_eht_override_peer_capabilities(u8 *he_info, u8 *eht_info,
+					 const u8 *mcs_set)
+{
+	u8 offset_320mhz_set = 3;
+
+	if (((*he_info) &
+	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G))) {
+		/* for 160 MHz bandwidth, if none of the MCS-NSS set
+		 * has a minimum NSS of 1 for both Rx and Tx, disable
+		 * support for 160 MHz bandwidth by resetting
+		 * corresponding flag bits of HE capabilities IE
+		 */
+		if (((mcs_set[3] & 0x0F) == 0x00 || (mcs_set[3] & 0xF0) == 0x00) &&
+		    ((mcs_set[4] & 0x0F) == 0x00 || (mcs_set[4] & 0xF0) == 0x00) &&
+		    ((mcs_set[5] & 0x0F) == 0x00 || (mcs_set[5] & 0xF0) == 0x00)) {
+			(*he_info) &=
+			    ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+			(*he_info) &=
+			    ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+		}
+		offset_320mhz_set += 3;
+	}
+
+	/* for 320 MHz bandwidth, if none of the MCS-NSS set
+	 * has a minimum NSS of 1 for both Rx and Tx, disable
+	 * support for 320 MHz bandwidth by resetting
+	 * corresponding flag bit of EHT capabilities IE
+	 */
+	if (((*eht_info) & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ) &&
+	    ((mcs_set[offset_320mhz_set] & 0x0F) == 0x00 ||
+	     (mcs_set[offset_320mhz_set] & 0xF0) == 0x00) &&
+	    ((mcs_set[offset_320mhz_set + 1] & 0x0F) == 0x00 ||
+	     (mcs_set[offset_320mhz_set + 1] & 0xF0) == 0x00) &&
+	    ((mcs_set[offset_320mhz_set + 2] & 0x0F) == 0x00 ||
+	     (mcs_set[offset_320mhz_set + 2] & 0xF0) == 0x00))
+		(*eht_info) &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+}
+
 void
 ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
@@ -65,6 +105,13 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 	memset(&eht_cap->eht_mcs_nss_supp, 0,
 	       sizeof(eht_cap->eht_mcs_nss_supp));
 	memcpy(&eht_cap->eht_mcs_nss_supp, pos, mcs_nss_size);
+	/* Override station bandwidth capabilities
+	 * if bandwidth is unsupported in MCS-NSS set
+	 */
+	ieee80211_eht_override_peer_capabilities
+			(&link_sta->pub->he_cap.he_cap_elem.phy_cap_info[0],
+			 &eht_cap->eht_cap_elem.phy_cap_info[0],
+			 eht_cap_ie_elem->optional);
 
 	if (eht_ppe_size)
 		memcpy(eht_cap->eht_ppe_thres,
-- 
2.34.1


