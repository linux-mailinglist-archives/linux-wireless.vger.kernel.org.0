Return-Path: <linux-wireless+bounces-4997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1688163E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432FD1F21E79
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53869DF4;
	Wed, 20 Mar 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SOzVXRsX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BE69DE8
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954805; cv=none; b=Z6AyhSrR1S3pQgX0EdFAV2YueUSpLydlmo2dEBF/m1+b/q3kr8397PXgSUPA7djUzib+sH8sAEIM/ZCdWLjsV7epPfd3CqP+Ly6lB9mlr+LE8Ias7bA5nwaJpd6cioFqOGLk3dZTVgzTk7oSP/cRCO9vK0pv4DneEUpi5caqwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954805; c=relaxed/simple;
	bh=z3IeR0iaei7ZJ4wKNv1yiEGHGPByBpmFJR4ZaJtEkgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TTXZrFFVbxuDEEm1dLhk7fGrUTXse2+yoPj97BQnh0lqwAlVoDRm2voBM+SokmPlAUTURBLcEubkAUYIF5PTUn5Saz3jYEWb7disYeyMnHlEPHPjX4kqUYOWenxlm7XMIc7HMSA05y15idMcIWFSU8PQGv8kco/eWdRodpjpYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SOzVXRsX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjcfX004878;
	Wed, 20 Mar 2024 17:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=K7kXL+a40eAx0IhBFrh2
	WRCAOiRuFpj3lSiUYKEdKz8=; b=SOzVXRsXQUVzu+9K+ILKFIZQSJqYk3W4VM0I
	kHXtdurNgbM0DKY9ywVNSe7GhgV1ukVqBDg6cy0hCRw6KpROM69GXTOeyWtcoGYZ
	HyDrZfkgWbCxRCn6LbaVW8ss8vPNcQj4hpkHLwX1zbg535GePEA7bzLxz1lCn9bY
	sPm5qwPzg0h2n8eHR2wyAfDUG39K5S+M2cmGqq4mzoaDpEE9ALUDjP/8PPq5eBgk
	VTYeBtZY3nU64XYrS+VktYOtpDnBkd4+Gg0WCmGSgwfvhQ6cZX20KAv0t3TxCzo0
	lLxhJom5R9EMvLx92zEZuBo7fLUIcT7sqlG2u8AI5EusPZ8Cew==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq1u1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42KHDFB2028158;
	Wed, 20 Mar 2024 17:13:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ww4gm7nu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KHDFjQ028152;
	Wed, 20 Mar 2024 17:13:15 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 42KHDFGB028151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:15 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id A3E2341111; Wed, 20 Mar 2024 22:43:14 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Add initial debugfs support in ath12k
Date: Wed, 20 Mar 2024 22:43:03 +0530
Message-Id: <20240320171305.655288-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hY1ttI-sIiqqKk71V8lfj57DYvcLQ9ET
X-Proofpoint-GUID: hY1ttI-sIiqqKk71V8lfj57DYvcLQ9ET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxlogscore=793 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200138

The initial debugfs infra support in ath12k driver and create the
ath12k debugfs and soc-specific directories in /sys/kernel/debug/

Add support to simulate RADAR interference through debugfs 

ath12k
`-- pci-0000:06:00.0
    |-- mac0
        `-- dfs_simulate_radar

Ramasamy Kaliappan (1):
  wifi: ath12k: Add initial debugfs support in ath12k

Ramya Gnanasekar (1):
  wifi: ath12k: Add radar simulation debugfs support

 drivers/net/wireless/ath/ath12k/Kconfig   |  9 +++
 drivers/net/wireless/ath/ath12k/Makefile  |  1 +
 drivers/net/wireless/ath/ath12k/core.c    |  5 ++
 drivers/net/wireless/ath/ath12k/core.h    | 10 +++
 drivers/net/wireless/ath/ath12k/debugfs.c | 89 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h | 30 ++++++++
 drivers/net/wireless/ath/ath12k/mac.c     |  3 +
 7 files changed, 147 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.h

-- 
2.17.1

