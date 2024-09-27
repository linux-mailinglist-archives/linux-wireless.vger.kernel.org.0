Return-Path: <linux-wireless+bounces-13259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CEF988210
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 11:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D52287B60
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D41BB686;
	Fri, 27 Sep 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJnQTief"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963815F3FB
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431143; cv=none; b=FkQqojTDFvCgAVOTrj9VR+UAS3wva4SAuYNRU1iYynpvDZRFeRCfMRaGocayW3CCLPiydPpUiKclTPKIJ7CxBQwDjB2wZKEJBNSSmt7FnZlTVRUW+G8EGXWTsfUKAcdWWYOGxfb+9/wKW9FpyrlmnDvKLNnjpC4EB1XzMcuDGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431143; c=relaxed/simple;
	bh=eWuwgO5nfKBnDVGVt2Dlk3LlksIIPdj0I1D96z04ODw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E29CtB3jSgr8ZXUF7WnwJ6Z8gNOiUzU5d/26Sz5VUf1KZTkXTe7kHDfVaNgcRATfnJ0V6vCWfX2Cv4aJyK+zoS185XnuD3QlOvsayRMRGTjB1NclgFZuFntZVVI3mRglNeNVTsnpGtZv+ykN+cdrwvdgewAb5LqvJKucLG0Kz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJnQTief; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6ZkBf000977;
	Fri, 27 Sep 2024 09:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=5d6JzPqE7gzqY+R7mcOMWOu2p5ukRlph0CT314VSWU0=; b=IJ
	nQTiefOi4jk9lZ1BJ3eQ7DxN1Je6flQNKgFMrqWR5F+iSUoaLDHxdGh1qm3RbRTV
	sJR2FVSj1y8t1AMItZW8vowxt8ZM1c/HP4v3tTMkgp01Nqoj6wvHJm4QPjfGFZt0
	GK2NCMkdxS15HiJKUse0LF1JMB4Kvk1MJWR5rQOqPDzyCIBiIeKMtU8OunUYS/t5
	1VU8+kMnEV9ivY160g2ubs79y+EL9R34v4/HWl8D/AJYuV22yltc2yQsQo+xNtMu
	GUmuVsXc/IxfBX2KaXN6DSTkEFA4J18BTYafqg0BmN/5vK9mSu0e1rlciK3Q5/rR
	oWvcH/EaHZh0dQ7V7lpg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3sjg81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 09:58:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48R9wwo6025947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 09:58:58 GMT
Received: from hu-bpothuno-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 02:58:56 -0700
From: Balaji Pothunoori <quic_bpothuno@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balaji Pothunoori
	<quic_bpothuno@quicinc.com>
Subject: [PATCH] wifi: ath11k: Fix CE offset address calculation for WCN6750 in SSR
Date: Fri, 27 Sep 2024 15:28:25 +0530
Message-ID: <20240927095825.22317-1-quic_bpothuno@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RMmcXQuV6ig9KZ-eXzZg1rQMVo29R_9B
X-Proofpoint-ORIG-GUID: RMmcXQuV6ig9KZ-eXzZg1rQMVo29R_9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270070

Currently, mem_ce and mem iomem addresses are used to calculate the
CE offset address. mem_ce is initialized with mem address, and for
targets where ce_remap is needed, mem_ce is remapped to a new address
space during AHB probe.

For targets such as WCN6750 in which CE address space is same as WCSS
address space (i.e. "ce_remap" hw_param is set to false), mem_ce and
mem iomem addresses are same. In the initial SRNG setup for such targets,
the CE offset address and hence CE register base addresses are
calculated correctly in ath11k_hal_srng_init() as both mem and mem_ce
are initialized with same iomem address.

Later, after the firmware download, mem is initialized with BAR address
received in qmi_wlanfw_device_info_resp_msg_v01 QMI message, while mem_ce
is not updated.

After initial setup success, during Subsystem Restart (SSR), as part
of reinitialization, ath11k_hal_srng_init() will be called again,
and CE offset address will be calculated incorrectly this time as mem_ce
address was not updated. Due to the incorrect CE offset address,
APPS accesses an invalid CE register address which leads to improper
behavior in firmware after SSR is triggered.

To fix the above issue, update mem_ce to mem iomem address in
ath11k_qmi_request_device_info() for targets which do not support
ce_remap feature.

Fixes: b42b3678c91f("wifi: ath11k: remap ce register space for IPQ5018")
Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index f477afd325de..7a22483b35cd 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2180,6 +2180,9 @@ static int ath11k_qmi_request_device_info(struct ath11k_base *ab)
 	ab->mem = bar_addr_va;
 	ab->mem_len = resp.bar_size;
 
+	if (!ab->hw_params.ce_remap)
+		ab->mem_ce = ab->mem;
+
 	return 0;
 out:
 	return ret;
-- 
2.17.1


