Return-Path: <linux-wireless+bounces-14450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAD9ADDF0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27752829B5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47151AAE02;
	Thu, 24 Oct 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H3InDzAz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE31A76B0;
	Thu, 24 Oct 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755736; cv=none; b=HJrdxUWyXlWardYCZIWct8+WhZMrhFWx6jtS3/PaeZRS+Oan1EpEVyoVDlM6aQ33ZqW7jbvTQHrUDiX8pEKzMEACtz82tGMhd3Vu/JXgAX9pwJIZNPuxJe+Qo9Jf9Tgx5/ObWhfE2tWAKRqRzNK/JWYfrcCtzFdg8EPfA4Wd7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755736; c=relaxed/simple;
	bh=N50ZQr4UI2FkUci7BJLOsdnNoEBca6hfIAg+HgBIZMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fmfPzCu5KqqHmLAHgRrZvN+VlXI5tD0CfEvgl9GQoiXOzGra85iqbjG+3248TENTfzDZZ9fpao3oUOG912BUbXJqiMw5gfPELNwUjYSoq5Gci83uTbkNIfOCoDPEnoGUohnLI/Rgbp7DAQRXG2UIcaE+a04kwsDoGUYxElxCt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H3InDzAz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NNgStL027468;
	Thu, 24 Oct 2024 07:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Psowjo8/4dp9MRXeqNJ9ul
	yPSJmjyL5Q08XlY52RyAc=; b=H3InDzAzde0XEVeRe/GFGAuCIx2kzVUXxT0Bmh
	+SYA/0JYBXEEQyITB3ZBV2wFZsxuuEst1rhj74f9xDPtgywiM7WkSWTbuJH9E9/E
	rcKyoiWyM25VPvZXeCHpYnC9W78X8oV8KAfSK53i4fLmnWExdoFO3laJoRJh3oyx
	VIC3V3ZV/UtdYrd3EBhzfwMuHiaa95nvaEKc4wZrWBjNTBte6KPQjuJtkLWDaPPX
	BJMFGMvSEPzk/NreTqvRqgYBXaQ7FSANwzrwMQlw5JUiGrj89Bq+73n48EccCwbE
	JL6XC1xXP/PayAlLsJS0LImarj4b/HhbQZ/EdM1hh+DrRbgQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wmus2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 07:42:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49O7g5n9017220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 07:42:05 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Oct 2024 00:42:02 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [RESEND PATCH v2 0/2] wifi: ath11k: support board-specific firmware overrides
Date: Thu, 24 Oct 2024 15:41:42 +0800
Message-ID: <20241024074144.179868-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: QiIimIlAcLvJ3dnngJeM_Bdi7tKAurn3
X-Proofpoint-ORIG-GUID: QiIimIlAcLvJ3dnngJeM_Bdi7tKAurn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=910 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240059

QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
IPA, thermal, RAM size and etc, so new firmware files used. This change
allows board DT files to override the subdir of the firmware directory
used to lookup the amss.bin and m3.bin.

For example:

- ath11k/WCN6855/hw2.1/amss.bin,
  ath11k/WCN6855/hw2.1/m3.bin: main firmware files, used by default

- ath11k/WCN6855/hw2.1/qca6698aq/amss.bin,
  ath11k/WCN6855/hw2.1/qca6698aq/m3.bin

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
v2: follow the approach that has been defined in the commit
5abf259772df ("wifi: ath10k: support board-specific firmware
overrides").
---

Miaoqing Pan (2):
  dt-bindings: net: wireless: ath11k-pci: add firmware-name property
  wifi: ath11k: support board-specific firmware overrides

 .../bindings/net/wireless/qcom,ath11k-pci.yaml   |  7 +++++++
 drivers/net/wireless/ath/ath11k/core.c           | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h           | 11 +++--------
 3 files changed, 26 insertions(+), 8 deletions(-)


base-commit: cd8aa3af7491a1f7a5b81e53dbe62a38433c2d4b
-- 
2.25.1


