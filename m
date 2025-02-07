Return-Path: <linux-wireless+bounces-18612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B7A2BA79
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 06:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F07A352A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 05:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE446BF;
	Fri,  7 Feb 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p19bcUYI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6201A08AB
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904642; cv=none; b=GL9fHheckL30b6FyIc8aeVb/cgSr2Fs+esNvqI6qfsd3k1h0vyVGmVP+wd6tESyfAvG7GGsAoiG4e2KQL5oEU6zWFTk2DT4pz1laVmKcZFxZkaXdGBOu4R0x+McstziY2wAfFN0MDXFTKF5YbcOwdxLz9olf+vTAQJ9Wn3nzqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904642; c=relaxed/simple;
	bh=ywrvWN8IFFkf2iXaU9SxT/0wDulyA6jhUMZ4hWC97n4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhqCOSLhBORLBpmXyIPdOCIoX131UQA+lfAGuzO5MSsXPFmCXWnkjQkbkCNlIzRS6m4MaI/0QexT6x5gM+5y8/eNSzD07MoUT00z57z7sAraKWMp7cXceon7Eib4VGsiYogMDwaeMD17e3EFa1vEtiAbgmMLa4An2PqycrKHR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p19bcUYI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5174KljH008006;
	Fri, 7 Feb 2025 05:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w1W5rgEA3urFg4KhoIly+1ZaxNtqF9+q43mMl1GEmPA=; b=p19bcUYINRnCNNlB
	+7oS9y3HmzKZOPXd2TEN/nSMiXCxf7/J5o4gswMX0Tp4gEuXTi+dFJhNCT8sLPV3
	Oq5YinXItvzHl9FFMWwerSJ4IEb3j4wxXwnrBC2sdZLGmJYgDMdExgt4+kpsDXwx
	BRfovXm7/8rnAtxKLOkO/i7neJhFoBOtgvu3FKFWTPLtSISFnr91KyzCEq3LmshY
	SR1zFiKLsGmxtLHNekcZhWOpLFbWgKUE2/7gYjSYYEgY/sWzJvUogJOHIHmsMjXU
	X3UJgRNP1eK6zFY6LSIAkWMZg6qtJWp1alV27Y9/Lw5KqAfOswz9XYEb6/Y7zO43
	KwWcag==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nb2m82vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 05:03:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51753ogK009563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 05:03:50 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Feb 2025 21:03:49 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: Remove dependency on single_chip_mlo_support for mlo_capable flag
Date: Fri, 7 Feb 2025 10:33:26 +0530
Message-ID: <20250207050327.360987-3-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
References: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-GUID: 6A9HJHTUZhhrk3KlWqAhW_JNc7HCmyrc
X-Proofpoint-ORIG-GUID: 6A9HJHTUZhhrk3KlWqAhW_JNc7HCmyrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_02,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=936
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502070038

The mlo_capable flag in structure ath12k_hw_group indicate that a device
is capable of operating in multi-link mode. Currently this is enabled
based on single_chip_mlo_support advertised by the firmware within
ath12k_qmi_phy_cap_send().

Since the firmware advertises multi-link operation (MLO) support through
the ATH12K_FW_FEATURE_MLO feature in firmware-2.bin, there is no need to
rely on the QMI phy capability (single_chip_mlo_support). Therefore remove
the dependency on single_chip_mlo_support to set mlo_capable flag.

Below is the impact on single split-phy PCI device with and without this
patch:

Note: This patch does not change the existing behavior of the single
split-phy PCI device.

1. Driver without this patch + firmware with single_chip_mlo_support
    as false: MLO is not enabled.
2. Driver without this patch + firmware with single_chip_mlo_support
    as true: MLO works fine.
3. Driver with this patch + firmware with single_chip_mlo_support as
    false: MLO is not enabled.
4. Driver with this patch + firmware with single_chip_mlo_support as
    true: MLO works fine.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index ef537c6bf0da..fcbe234758e1 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2265,10 +2265,6 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.single_chip_mlo_support_valid &&
-	    resp.single_chip_mlo_support)
-		ab->single_chip_mlo_supp = true;
-
 	if (!resp.num_phy_valid) {
 		ret = -ENODATA;
 		goto out;
@@ -2277,10 +2273,9 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	ab->qmi.num_radios = resp.num_phy;
 
 	ath12k_dbg(ab, ATH12K_DBG_QMI,
-		   "phy capability resp valid %d num_phy %d valid %d board_id %d valid %d single_chip_mlo_support %d\n",
+		   "phy capability resp valid %d num_phy %d valid %d board_id %d\n",
 		   resp.num_phy_valid, resp.num_phy,
-		   resp.board_id_valid, resp.board_id,
-		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support);
+		   resp.board_id_valid, resp.board_id);
 
 	return;
 
-- 
2.34.1


