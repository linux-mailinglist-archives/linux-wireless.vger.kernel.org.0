Return-Path: <linux-wireless+bounces-20889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E1A729CB
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 06:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF273AB3B8
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 05:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6E1B6D11;
	Thu, 27 Mar 2025 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lVxGobz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035A1BD9D0
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743052497; cv=none; b=eIVMxXC9Wm9Lsc9og/EwCuyJr+G+4Vq1aMFE+4LU7I5Sk0vadvFiTmKBWw+v8sUdGjrvGde3O4u2uugCv7gqAX091fYkw73YCmAcBeAEn/Uyve+jQayVvxDEmVm0jOKhENeijDD2UpQEmpFc/VqLVyNZxs/aVgRSfdVXtDEMPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743052497; c=relaxed/simple;
	bh=IXVtdYCfxvBxUHmJNf3pAiT/OfL8z59euIDoIDjjg/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk2Nwk7/WDOWERFZnh6TSniy0CunDNBgg5ypXsgbvJHa68Uua6qUkaxHG9TacM9eSQO5dAI0+0p2M80ktpjMJeFRKN5+SVG7p5wJVi6X1NWFYieaEhsNf0W2pLAu2d+gvKbZV3gpwlyob4Md0Yop1vHfmwz9u7+tKE8aaZUYUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lVxGobz2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R56SWc029695;
	Thu, 27 Mar 2025 05:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Rwu+KoLXssv9dY+W0d9GBiCyxWoroY++DvnAbRIVX8=; b=lVxGobz2WBDL4ITh
	U/2HaB73dNNhXSGAIkxAJm+j7KldB6vXfUDO8MK0M6DP2Cjs0OsXHDfqTgIaEwco
	TtH4q0gn/KcFe1gkQjJMmytxzHZlvtvCnRFlQKVN4XaewYQ/un2WyJGfS3gHy9mt
	HNpFYjJAbePxhukxDNCBNL8zJUh5VWZjtOfp/4FpsRL4bEG1cpQAHDEgA1zWCKSe
	IP18rZilrfknihAE7plKm7P78PyrzWCjEERk0UyNfqXjg7iPCCxiPlqm8n47y+Zb
	x+8R6C/kGHmkIFTW3tphH7n/QMAIXqiDAb2OYFZn70SWjMAZz6/Oadr7qeOJviQA
	WUV+bA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktene5ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 05:14:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R5EKh0024338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 05:14:20 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 22:13:56 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v5 3/4] wifi: ieee80211: Add helpers to fetch EMLSR delay and timeout values
Date: Thu, 27 Mar 2025 10:43:19 +0530
Message-ID: <20250327051320.3253783-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327051320.3253783-1-quic_ramess@quicinc.com>
References: <20250327051320.3253783-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e4dead cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=6a0EW4FuJA1U0GZqRFsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _XpSmx1cJFs-Is23op0fhjppvnGIxfvp
X-Proofpoint-ORIG-GUID: _XpSmx1cJFs-Is23op0fhjppvnGIxfvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270031

Add helpers to get EMLSR transition delay, padding delay and transition
timeout values from EML capabilities field of Multi-link Element.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/linux/ieee80211.h | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 508d466de1cc..0720a9dc1dc8 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5615,6 +5615,80 @@ static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
 	return len >= fixed + elem_len;
 }
 
+/**
+ * ieee80211_emlsr_pad_delay_in_us - Fetch the EMLSR Padding delay
+ *	in microseconds
+ * @eml_cap: EML capabilities field value from common info field of
+ *	the Multi-link element
+ * Return: the EMLSR Padding delay (in microseconds) encoded in the
+ *	EML Capabilities field
+ */
+
+static inline u32 ieee80211_emlsr_pad_delay_in_us(u16 eml_cap)
+{
+	/* IEEE Std 802.11be-2024 Table 9-417i—Encoding of the EMLSR
+	 * Padding Delay subfield.
+	 */
+	u32 pad_delay = u16_get_bits(eml_cap,
+				     IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+
+	if (!pad_delay ||
+	    pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
+		return 0;
+
+	return 32 * (1 << (pad_delay - 1));
+}
+
+/**
+ * ieee80211_emlsr_trans_delay_in_us - Fetch the EMLSR Transition
+ *	delay in microseconds
+ * @eml_cap: EML capabilities field value from common info field of
+ *	the Multi-link element
+ * Return: the EMLSR Transition delay (in microseconds) encoded in the
+ *	EML Capabilities field
+ */
+
+static inline u32 ieee80211_emlsr_trans_delay_in_us(u16 eml_cap)
+{
+	/* IEEE Std 802.11be-2024 Table 9-417j—Encoding of the EMLSR
+	 * Transition Delay subfield.
+	 */
+	u32 trans_delay =
+		u16_get_bits(eml_cap,
+			     IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
+
+	/* invalid values also just use 0 */
+	if (!trans_delay ||
+	    trans_delay > IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
+		return 0;
+
+	return 16 * (1 << (trans_delay - 1));
+}
+
+/**
+ * ieee80211_eml_trans_timeout_in_us - Fetch the EMLSR Transition
+ *	timeout value in microseconds
+ * @eml_cap: EML capabilities field value from common info field of
+ *	the Multi-link element
+ * Return: the EMLSR Transition timeout (in microseconds) encoded in
+ *	the EML Capabilities field
+ */
+
+static inline u32 ieee80211_eml_trans_timeout_in_us(u16 eml_cap)
+{
+	/* IEEE Std 802.11be-2024 Table 9-417m—Encoding of the
+	 * Transition Timeout subfield.
+	 */
+	u8 timeout = u16_get_bits(eml_cap,
+				  IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
+
+	/* invalid values also just use 0 */
+	if (!timeout || timeout > IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU)
+		return 0;
+
+	return 128 * (1 << (timeout - 1));
+}
+
 #define for_each_mle_subelement(_elem, _data, _len)			\
 	if (ieee80211_mle_size_ok(_data, _len))				\
 		for_each_element(_elem,					\
-- 
2.34.1


