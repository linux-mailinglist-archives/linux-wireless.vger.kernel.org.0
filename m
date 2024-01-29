Return-Path: <linux-wireless+bounces-2634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41D83FEB7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145711C20B33
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB94D135;
	Mon, 29 Jan 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="byG0LpU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488B4D11A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511475; cv=none; b=ra7buhoAvK5K/5ArzvN4qUvAVXgWJNveOvSMoOQ9jkX1RlqRC7ANokPOytDSqLvSP1eLmWVZHyYVa3hhxnCrJTy9CpBR4XVb32ayu+omv4B7w/aGiW8rv1Vf6cT9HCXBtyOYg+jrPXHlzt0KfmdwSYDiND6xgZwaHALFj/6uyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511475; c=relaxed/simple;
	bh=ty0k2+KZWUBgdZBflt3WzMt0IFe4hGPnRh/hBBSsuSo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCzbBLXDsOU8IP74IIpgFnwa5RMUrfWILi0ZKulq1J368U4u7B/Dvcx49DDO6aqB8B68arPfIBKxIokoVEigL0g+iQjxp92lWLtgYzEooTB/2epZrXjdSsnHnG3rhs0P8ydiPzyDi7omjhfEgprEC6wgq44GOAR8xwwX4PaPLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=byG0LpU+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T2rAPX012429;
	Mon, 29 Jan 2024 06:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=q0oP/Bu
	YWmMlQ5a/ZTYSjQgCe2azgZBrDPKTDSLQ/3s=; b=byG0LpU+IP4LhgVPik0Gvrd
	p5u9EWKwWYRtVGk5K5xcEVTE2Zkhx46hqp8yg+JU8GdfK6CjsZO9ReW8Ftoq/d9q
	L6Ndd2fgKRQPD7MqPyeiAEbKK6eXvSBxulGBd66very35qw8JpwraTBUBHzuMTLw
	y5MNYAiyeGb0vnT9ehsmPCeem5s5oKmkO5XSwqA8raF2bRrEYYp+uccTn9PKFxMz
	axsghznzNfjlcVIoH1u/b52w6+t59AbcHsnZWj23qaGhEQ17yymUUbd+9+rbdCV/
	kwTTiOnzjhjY4O+1Iig5ygUyxqHRYfiofeLS5mYiGvHtmePXrMPXGucr4mp7R2g=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvrubb0q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6vk9w008606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:46 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:57:45 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 00/13] wifi: ath12k: QCN9274 dualmac bring up
Date: Mon, 29 Jan 2024 12:27:11 +0530
Message-ID: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LONjyhXPD62ayd5TBWugAQKRTha_8657
X-Proofpoint-GUID: LONjyhXPD62ayd5TBWugAQKRTha_8657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=306 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

QCN9274 Ath12k chipset can support single-mac or dualmac architecture.
Currently, Ath12k driver supports only the single-mac QCN9274
architecture.

Hence, add support for dualmac QCN9274 chipset.

Depends-On: [v2] wifi: ath12k: add firmware-2.bin support

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

Raj Kumar Bhagat (4):
  wifi: ath12k: fix fetching MCBC flag for QCN9274
  wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
  wifi: ath12k: remove hal_desc_sz from hw params
  wifi: ath12k: disable QMI PHY capability learn in split-phy QCN9274

Sowmiya Sree Elavalagan (1):
  wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID

Sriram R (1):
  wifi: ath12k: indicate NON MBSSID vdev by default during vdev start

---
v3:
- Added patch "wifi: ath12k: disable QMI PHY capability learn in
  split-phy QCN9274" to avoid firmware crash.
- Tested on WCN7850

v2:
- dropped patch [1/13] - wifi: ath12k: Update enum wmi_direct_buffer_module
  not required with FW version being used.
- defined enum wmi_vdev_mbssid_flags at proper place.
- implemented hal_ops to retrieve the corresponding compact ops.
---
 drivers/net/wireless/ath/ath12k/core.c    |  30 ++
 drivers/net/wireless/ath/ath12k/core.h    |  12 +
 drivers/net/wireless/ath/ath12k/dp.c      |  25 +-
 drivers/net/wireless/ath/ath12k/dp.h      |  17 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c  |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 158 ++++----
 drivers/net/wireless/ath/ath12k/dp_tx.c   |  20 ++
 drivers/net/wireless/ath/ath12k/fw.c      |   7 +
 drivers/net/wireless/ath/ath12k/fw.h      |   6 +
 drivers/net/wireless/ath/ath12k/hal.c     | 415 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal.h     |  20 +-
 drivers/net/wireless/ath/ath12k/hw.c      |  13 +-
 drivers/net/wireless/ath/ath12k/hw.h      |  30 +-
 drivers/net/wireless/ath/ath12k/mac.c     |  12 +-
 drivers/net/wireless/ath/ath12k/mhi.c     |  50 ++-
 drivers/net/wireless/ath/ath12k/pci.c     |  84 +++--
 drivers/net/wireless/ath/ath12k/pci.h     |   6 +-
 drivers/net/wireless/ath/ath12k/qmi.c     |   3 +
 drivers/net/wireless/ath/ath12k/qmi.h     |   1 -
 drivers/net/wireless/ath/ath12k/rx_desc.h | 116 +++++-
 drivers/net/wireless/ath/ath12k/wmi.c     |  31 +-
 drivers/net/wireless/ath/ath12k/wmi.h     |  58 ++-
 22 files changed, 949 insertions(+), 170 deletions(-)


base-commit: 17f4b952f067b1f87d14e6df4c8c216fe7a245d1
prerequisite-patch-id: 20d8782c4835d0a1e32c8cbc6ffca53a71603ed3
-- 
2.34.1


