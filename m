Return-Path: <linux-wireless+bounces-1531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6BF825B48
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB981C238AE
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15423609D;
	Fri,  5 Jan 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k0yw+mwp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401836082
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405FRNNg019371;
	Fri, 5 Jan 2024 19:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=qk88lsg
	GU+VdIkidCS8MgwDxZmq2Ur3sWpm/pws8VH4=; b=k0yw+mwpDg43nHKWN1Jh1Gt
	yMt3ekJU17OUVUsZtwGaxRGHbqgaZCXD7x3IsBSy4E0a8OCON5AYodkTZb949GhR
	TYxvC1bV3vBZ9MgudspfF/6cdvU3FBwqAUr9HM0DXdQ7DO4Xq9Vuz3J/6+vuul41
	jzJl7qAquHcnm62HwpN702xcuoWdnTyQ43kvCFjGoXCLs2xy5Lcpp553Bi3OTHjK
	e6tjz4tnoW6UGAHEbUfCzif4jPWvMplGkI9w7ADzU6BOkRncoLRc7OUk+DqU9SBL
	MmTM0mc64Kt4BQe1vBJ2CL7aru5TJ/e5zubuWfRLpqd79M9zlpXHsgS9U0zJ0Fg=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vemdt8sew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405Juwpu032149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:56:58 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:56:56 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 00/12] wifi: ath12k: QCN9274 dualmac bring up
Date: Sat, 6 Jan 2024 01:26:27 +0530
Message-ID: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7gjCcW1wm9WWPhxyswNE-G_HLtsgXpg9
X-Proofpoint-ORIG-GUID: 7gjCcW1wm9WWPhxyswNE-G_HLtsgXpg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=326 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050161

QCN9274 Ath12k chipset can support single-mac or dualmac architecture.
Currently, Ath12k driver supports only the single-mac QCN9274
architecture.

Hence, add support for dualmac QCN9274 chipset.

Depends-On: wifi: ath12k: add firmware-2.bin support

Aaradhana Sahu (1):
  wifi: ath12k: fix firmware assert during insmod in memory segment mode

Ganesh Babu Jothiram (1):
  wifi: ath12k: Read board id to support split-PHY QCN9274

Harshitha Prem (1):
  wifi: ath12k: add support for peer meta data version

Karthikeyan Kathirvel (1):
  wifi: ath12k: subscribe required word mask from rx tlv

Karthikeyan Periyasamy (1):
  wifi: ath12k: add MAC id support in WBM error path

P Praneesh (2):
  wifi: ath12k: Add logic to write QRTR node id to scratch
  wifi: ath12k: fix PCI read and write

Raj Kumar Bhagat (3):
  wifi: ath12k: fix fetching MCBC flag for QCN9274
  wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
  wifi: ath12k: remove hal_desc_sz from hw params

Sowmiya Sree Elavalagan (1):
  wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID

Sriram R (1):
  wifi: ath12k: indicate NON MBSSID vdev by default during vdev start

---
v2:
- dropped patch [1/13] - wifi: ath12k: Update enum wmi_direct_buffer_module
  not required with FW version being used.
- defined enum wmi_vdev_mbssid_flags at proper place.
- implemented hal_ops to retrieve the corresponding compact ops.
---

 drivers/net/wireless/ath/ath12k/core.c    |  29 ++
 drivers/net/wireless/ath/ath12k/core.h    |   7 +
 drivers/net/wireless/ath/ath12k/dp.c      |  25 +-
 drivers/net/wireless/ath/ath12k/dp.h      |  17 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c  |   7 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 161 +++++----
 drivers/net/wireless/ath/ath12k/dp_tx.c   |  22 +-
 drivers/net/wireless/ath/ath12k/fw.c      |   7 +
 drivers/net/wireless/ath/ath12k/fw.h      |   6 +
 drivers/net/wireless/ath/ath12k/hal.c     | 415 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal.h     |  20 +-
 drivers/net/wireless/ath/ath12k/hw.c      |  10 +-
 drivers/net/wireless/ath/ath12k/hw.h      |  30 +-
 drivers/net/wireless/ath/ath12k/mac.c     |  14 +-
 drivers/net/wireless/ath/ath12k/mhi.c     |  49 ++-
 drivers/net/wireless/ath/ath12k/pci.c     |  84 +++--
 drivers/net/wireless/ath/ath12k/pci.h     |   6 +-
 drivers/net/wireless/ath/ath12k/qmi.h     |   3 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h | 116 +++++-
 drivers/net/wireless/ath/ath12k/wmi.c     |  33 +-
 drivers/net/wireless/ath/ath12k/wmi.h     |  58 ++-
 21 files changed, 943 insertions(+), 176 deletions(-)

-- 
2.34.1


