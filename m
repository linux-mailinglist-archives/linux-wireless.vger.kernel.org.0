Return-Path: <linux-wireless+bounces-9493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D734F9146B6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 11:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61AF2B21955
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7B134407;
	Mon, 24 Jun 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oOq08Z2S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691C13213B
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222811; cv=none; b=ZYcbAyrB5GCi8vUcBd+mNKccaObsQurDY/MAx3a5vJ9OQRhgpk4g0mP9QYgo1hVyFWpqDC9C8gXVoaYHV9ufzCgKgy1qtK/A7N+GYmTFnQk/468zILsv29JquU1MSHpVQYDv0S8wrbDxIFBEJMorWaZ2RkA/7ggD5KyciA4lcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222811; c=relaxed/simple;
	bh=tK5EBm7IrR6gZ3K2V+F3iXZ34ni3WpFL1NCCZRHS2wE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CySxRm3d9T864KPwynv17hAI3eL8Bwmv3UJUFUlCH9SrTOHbjyZI83YjcL20wxDgehfbP41O3zkz5PZploNig3gJ8vnejX59LbGCd6zGdjq5BHz50emITrlaV+kJmkzF6cxAov+BNVJ0QHiVEPtScdT3TqcH3XgaNDwP8h5KXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oOq08Z2S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8ZBDc024767;
	Mon, 24 Jun 2024 09:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QvwmRg7k2R+w/utHY+pqd/jehFpbhrNbjJPpFXLrpKU=; b=oOq08Z2S/uTHJOtK
	vjEenk36pWekwsBtcD60rT0VWxMQnXy+ITTztV6zl4A3Q+Wjz6XedJL9K3oflE2g
	e1iqV3as4lJ026UAPdB46S35WF32xz46f2WvDHma4ABFstdPYXJhj73cxAtwD7ix
	DUU1OPocX80nUFGKdC3zTJ0MAb5ZTtKGnhtcrHQu7E9HmQmL8Ch5NXhP1s5RkwOj
	hEX/iGE5ykpUrDbiJujbDfR/t0s3Cj7dmWA592M/0tjeW/ls84mD63Uq6LvZNJV9
	ySMXo0FEda2QTKY4rtlZDK4ZHeVGAnFJt+Nzl9GlwlggxPTV0g8Gv1qGzDK8yepb
	XR1Zaw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshk7bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:53:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O9rQNW002665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:53:26 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 02:53:24 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v5 2/4] wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
Date: Mon, 24 Jun 2024 15:23:03 +0530
Message-ID: <20240624095305.37189-3-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: hNV1wbt7kY1ttNSctBdfnfFaOumyQoYR
X-Proofpoint-GUID: hNV1wbt7kY1ttNSctBdfnfFaOumyQoYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=860 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240079

Export ath12k_wmi_tlv_hdr() to further use in the testmode command
processing.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 drivers/net/wireless/ath/ath12k/wmi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d6e1d1398cdb..7aaa534be32f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -173,7 +173,7 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_p2p_noa_event) },
 };
 
-static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
+__le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
 {
 	return le32_encode_bits(cmd, WMI_TLV_TAG) |
 		le32_encode_bits(len, WMI_TLV_LEN);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c2b86e187a03..ffb9e3fce767 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5027,6 +5027,7 @@ int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
 			    const u8 *buf, size_t buf_len);
 int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table);
 int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table);
+__le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
-- 
2.34.1


