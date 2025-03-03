Return-Path: <linux-wireless+bounces-19728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9FA4CE28
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 23:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F97A94FC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 22:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B625623717D;
	Mon,  3 Mar 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="biCWcaCN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC21F03C0
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040356; cv=none; b=Cjm6qrpCrFD8yGIDfnnZhG3RubqH8NC90Ank2VaSRMfQab7lhi8l9+XZeRdpcnZxbHj3GpnFKz7x9DExEy/V2woyby9nUgYcpDDXRWKMzkpvW8RdQSe/6dBpystYkSPAbB8gE6FBQ9NO5+B3dJCFEG3iT7aFUQqOlG50eYMqSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040356; c=relaxed/simple;
	bh=I8+UTNtDvCyJd6UNjMyPjabdK00jSce3oBVI+c+O2TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSpN8IPYRxAjf2o4+7l+LQxb0DsKQenBQcE9BG6+JKr61zJ4lQqPuS3AGdME8I83koJGvQbMBuUDKisYZmHbuFK6KFLTCSbaKrqgGIo56KZZVTpf4qndcG40bg9RxtkXnRYjOEXJfhVP3Dqn/Hi5AvXxYXSpJZmH37z33m2gOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=biCWcaCN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523ATpf5022253;
	Mon, 3 Mar 2025 22:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EMEKPPsc1mTDR0IkqpRNPt1PS1AHnxmniKqIhhUrOtE=; b=biCWcaCNsIMuEoru
	CU/NeDP7KWhFurbJeF7qhoj0vOiP7j1B8apQ98ubGBX58+ot9I8YppUyM6SUF2qX
	i+r8X0dBoxFcW1iwrDLXe9qJQ+9ibnqCYB7LPYqkJMl4PjMYsbsmHLRWUgBkIhCE
	BT+ENhcTS1lIz7Qy6QlvQLBNbmc1GWRWtiLxtWU3cRruKH0rOkTaHaMpA5xbM5sJ
	jVzOZjAFrkQc1/p1dR8nNLNwH2M3abpG88Y/054f9FqGn5F8HlcWgEyljxZeIrmh
	K4txIRxhrfpjAM2rehku+pDabFoxOqs0jjmGbFLbX6hOVA3jha8g9RMKiNdDdbee
	X5nWjQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9965mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 22:19:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523MJ7dw024128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 22:19:07 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Mar 2025 14:19:05 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v3 3/4] wifi: mac80211: Add helpers to fetch EMLSR delay and timeout values
Date: Tue, 4 Mar 2025 03:48:42 +0530
Message-ID: <20250303221843.1809753-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303221843.1809753-1-quic_ramess@quicinc.com>
References: <20250303221843.1809753-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BY17J26gmmOX96UPKAlv4iy7Fsi2qUHA
X-Proofpoint-GUID: BY17J26gmmOX96UPKAlv4iy7Fsi2qUHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030173

Add helpers to get EMLSR transition delay, padding delay and transition
timeout values from EML capabilities field of Multi-link Element.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/linux/ieee80211.h | 71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 508d466de1cc..baebc2c483f1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5615,6 +5615,77 @@ static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
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
+	u32 pad_delay = u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+
+	if (!pad_delay || pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
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
+	u32 trans_delay = u16_get_bits(eml_cap,
+				       IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
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
+	u8 timeout = u16_get_bits(eml_cap, IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
+
+	/* invalid values also just use 0 */
+	if (!timeout || timeout > IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU)
+		return 0;
+
+	return 128 * (1 << (timeout - 1));
+
+}
+
 #define for_each_mle_subelement(_elem, _data, _len)			\
 	if (ieee80211_mle_size_ok(_data, _len))				\
 		for_each_element(_elem,					\
-- 
2.34.1


