Return-Path: <linux-wireless+bounces-1605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903E827CC8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 03:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485502855AF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 02:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1B211C;
	Tue,  9 Jan 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YncPHkE0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488B20FB
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4092473j030580;
	Tue, 9 Jan 2024 02:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=bXBT6LK
	yOjU8UAIM6kN4eCIly0FIoAPgd+wsnhgPL9A=; b=YncPHkE0AbbgCDM7tovS8sC
	REyeCjM0M6ROMy1TGk9B2UleMiSFLL6nGe6dVXHU7c7Vk6RDvJTHbzGd6Fm4khxz
	ocIosshPopNCGEb1s2q3uT0mYTpoKV7SkJfn2QjmiQ3xSXW5g5m/qSJUBgOGw8ow
	aFldcoew1/X1Bo1wB9AK8cRN/4qtzakhbDPFMcccdKGCoMLhbyYJE1iGK1y4MlZx
	drvuk6tKjqRvoE3CKSpEahrbnYicze3JKV8g+PvdAYtxVgTJ5qSb2lm87uTcV4q6
	BuMv1sovmE2U3Nr7YuVUjQ/Xni19HepWo2WJJOik6r5GFXGus6qm9tvlFRtjW8A=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgw1k00e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 02:13:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4092DtGq032025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 02:13:55 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 18:13:54 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath11k: add support for QCA2066
Date: Tue, 9 Jan 2024 10:13:34 +0800
Message-ID: <20240109021336.4143-1-quic_bqiang@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NasNqLoOIWpsx3mT7G7YsvgWq46AgreP
X-Proofpoint-ORIG-GUID: NasNqLoOIWpsx3mT7G7YsvgWq46AgreP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=690
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090011

QCA2066 is a PCI based DBS device. It is very similar to WCN6855
overall: they share the same PCI device ID, the same major and
minor version numbers, the same register address, and same HAL
descriptors etc. The most significant difference is that QCA2066
supports 3-antenna configuration while WCN6855 doesn't. To
differentiate them, subversion numbers are used. Currently four
numbers are used by QCA2066: 0x1019A0E1, 0x1019B0E1, 0x1019C0E1
and 0x1019D0E1.

In order to read subversion register, pci.ops needs to be ready
at that time, this change is done in the first patch.

The second patch enables support for QCA2066.

v2:
 - Rebased on ToT.

Depends on:
Carl Huang: public review
  wifi: ath11k: supports 2 station interfaces

Baochen Qiang (2):
  wifi: ath11k: move pci.ops registration ahead
  wifi: ath11k: add support for QCA2066

 drivers/net/wireless/ath/ath11k/core.c | 86 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 43 +++++++++----
 drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
 5 files changed, 131 insertions(+), 11 deletions(-)


base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9
prerequisite-patch-id: 640366721125b1adea0eeabd5cdfca5e91476e7c
-- 
2.25.1


