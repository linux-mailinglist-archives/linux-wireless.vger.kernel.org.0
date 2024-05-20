Return-Path: <linux-wireless+bounces-7831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE018C9825
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 05:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E755B21F23
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 03:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B44A33;
	Mon, 20 May 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BzWFP5+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABBBA40
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716174596; cv=none; b=ugE6mxEt33/t2HWQoQN8+MyRefvZajhyn0sbKWzRBV5qMoiaLLBdAzBwQhAXz8vbWJaush0zbybBwqXXJ3U0rL+gfvGOMPOlmzYniFeyd8frhSp1Ce0zZpwAA8R54O9xUK9yqjDnYKVP8qZP3yWcsyOrCm8eZA8iBQw9fCFa4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716174596; c=relaxed/simple;
	bh=MPzvSCkrlwi7blf5nQRTpmspvDwvrDEgbSnqgUemdrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLW84rGex1aCJBe3tzvyjG53xmFjETL3GTFkGAYlNEUSgXrwHs9g6xJcfMPVGTLSIloRaD3pJx7mad9mmWVdCRwK28TcAhWjDa1asBvYz4eanl18v5FC0+ie2NGc0El9oBkEP5werxU39/QCdO+3lT0G0but+U7m3kHPTcdg6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BzWFP5+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K0A2kN009478;
	Mon, 20 May 2024 03:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=HBDNyLU
	C5BbQl+a+IJBLUi+IwVvWRYFQM5eZSzyoeeE=; b=BzWFP5+1/X1ifM1i6hNt97B
	cyBmFTYGMLPMw3ywaaGLijWA+WL3GSLWOrc8brzOmi7VwvcQL5hz3JVufqqUHlEn
	dNzxnysiBCSj/3xmBkIl4LcFXuxzq+OsfBEMNJUGstGa6vDV4IoenAbDeE0u3pyU
	qf7acba8VhWBCIKNa0jMZHWmaaBDkZyeFyHvTxXCGii0vowXHrrmIQMeih1t2zFr
	LR9cJ4gnLgwlRGaIBaiciv9knnrWkb7UxT3RbX4ulTmi4WmMFZdJgw2QsMGjP9Dx
	2JXMJ8T+lSVMycw3Pvc034OQXnarE0dEqIcqlBGeMI0tjlU4Cp0SFUWpjM782EQ=
	=
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n45j9tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 03:09:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K39EfT008392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 03:09:14 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 May 2024 20:09:13 -0700
From: Carl Huang <quic_cjhuang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs
Date: Mon, 20 May 2024 11:07:57 +0800
Message-ID: <20240520030757.2209395-1-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3C9nJNkxytrRBVMVY54HyB2tIbu9gBmY
X-Proofpoint-ORIG-GUID: 3C9nJNkxytrRBVMVY54HyB2tIbu9gBmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_01,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200025

WCN6750 firmware crashes because of num_vdevs changed from 4 to 17
in ath11k_init_wmi_config_qca6390() as the ab->hw_params.num_vdevs
is 17. This is caused by commit f019f4dff2e4("wifi: ath11k: support
2 station interfaces") which assigns ab->hw_params.num_vdevs directly
to config->num_vdevs in ath11k_init_wmi_config_qca6390(), therefore
WCN6750 firmware crashes as it can't support such a big num_vdevs.

Fix it by assign 3 to num_vdevs in hw_params for WCN6750 as 3 is
sufficient too.

Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Closes: https://lore.kernel.org/r/D15TIIDIIESY.D1EKKJLZINMA@fairphone.com/
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3cc817a3b4a4..b82e8fb28541 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -604,7 +604,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.coldboot_cal_ftm = true,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 16 + 1,
+		.num_vdevs = 3,
 		.num_peers = 512,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),

base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
-- 
2.34.1


