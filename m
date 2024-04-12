Return-Path: <linux-wireless+bounces-6218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E8F8A2629
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006131C23A35
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC0A3611D;
	Fri, 12 Apr 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V4fREQQV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C51CD10
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902008; cv=none; b=PNjrbZsT6l0oxBY0P39l1ugUjv+9KqTC2UWWhu4DEInEVT8+4T6H3X9LQERc+yIUWEq63zPUw2n720e+8BOzgtRxRfWhBuOUDA615D+b76Hl1y2MzT4kyiVVMfMUfKdfWSGcQXA/dNx75dNmDfQR6mrpiQ+8S9jV2uuKJEtuANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902008; c=relaxed/simple;
	bh=kXD915+45UA/CWDvrWSNNsXHZuxSuO/nxYJ+7RmKkBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=us/Egb76z/JRKBb49+4BDFClqNm8qtRcbju0aq/fLE5c0hZba7gXtHRci182WrM8d4I2tzPqHWbttzR1gLOKmsuziIFnBK2DX7qx68/Co5YrKtzP3lzjPGGm3bk7lf9LNZNjnG++rFL2UUJWsrhon8KrlpjbqwXC0lsVhPLZh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V4fREQQV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C5stR4001439;
	Fri, 12 Apr 2024 06:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=u5Xx4onHe7PXvLmZ4qMLjapzHVbdEEUK4acE+zo8M7M=; b=V4
	fREQQV/R6h2k3Ykd40z8FPjgikJQ7gyOD0cAzR01wfc8W0zyOprpdAVaozcfrl1D
	nQduzsB6PFs0fCodbq/rvewdPkWP95jG3rQsY5otQT+HcJcFYRlk+36yGAawvxfx
	ja9szxqcO31Khj1yIJcRepb1LZdPdMHNaPYeDfhZJ6/0nwgzDroQfj3RfDOF/d/P
	6p8ImEPBmA230AwPT3mdzZnS07Lr2nQdqC7lBRXF3kRhauTTDyZZ/VoNLJyS53kz
	oplLFJu0z/qR4Ls6R/WgJIawHmcaS4bvYO8GkQr/dhcWaiSNkZCHS881ESD9/LTf
	f+0kWWSSA680gaWngxYA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xey6vr0s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C66gbv019955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:42 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 23:06:40 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 04/10] wifi: ath12k: fix warning on DMA ring capabilities event
Date: Fri, 12 Apr 2024 14:06:14 +0800
Message-ID: <20240412060620.27519-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412060620.27519-1-quic_bqiang@quicinc.com>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fp0wOBK8mZ-nczm5L7q4CORg_zO3Y9lI
X-Proofpoint-GUID: Fp0wOBK8mZ-nczm5L7q4CORg_zO3Y9lI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=571
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120042

We are seeing below warning in both reset and suspend/resume scenarios:

[ 4153.776040] ath12k_pci 0000:04:00.0: Already processed, so ignoring dma ring caps

This is because ab->num_db_cap is not cleared in
ath12k_wmi_free_dbring_caps(), so clear it to avoid such
warnings.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a5575ce9eed4..0fb1fdb935e1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4041,6 +4041,7 @@ static void ath12k_wmi_free_dbring_caps(struct ath12k_base *ab)
 {
 	kfree(ab->db_caps);
 	ab->db_caps = NULL;
+	ab->num_db_cap = 0;
 }
 
 static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
-- 
2.25.1


