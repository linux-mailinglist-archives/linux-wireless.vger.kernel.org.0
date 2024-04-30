Return-Path: <linux-wireless+bounces-7035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C47A8B6DF8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA071F2255B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E3127B66;
	Tue, 30 Apr 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OS3Pj8go"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E03127E25
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468489; cv=none; b=ruzS0Vl87Og1fpPNDehaSxouOy7y4Ih1N44uADgtgFPC9FbIPF+0U2LFFYkHV+A0aiZyOxSywe4jVVXD41HCjjg7YJDaN3VQq+YlNT9LBlAmbyyMUcDN9xE0C4SJ/L1/4MjWXUfDEuPHCuK2Kvf+Qz1O/PKm7FsmbSsqyKq8rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468489; c=relaxed/simple;
	bh=XhUN1zhttgY0oDJkDS+QVNSwPgiuvaM7L1puyDB29TY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EM6TGsD0L+oFpA62AojQ2DX3uJbyqht+yeoptROqGFlPyT71eCPnBpOZeG6UqYkw5rHrK4bnAtDlScHJjfHtGWdZ4ZbOWzD4XcQREDq4BdhOsS5llsTYoBG06SwPiuCcSXuI4hVaQ/B/7+UEFXx9ZBQiLQxrTcSOFNfEFK1DFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OS3Pj8go; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U7BPtN012461;
	Tue, 30 Apr 2024 09:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=lOp5wCh
	RyEtLCvnARP7XxMChFopRXcN5Zvk5HfZkxcI=; b=OS3Pj8goLg9OGtLICqQP8Ha
	z66Kkz9y9TD3XZbQEGxv+D/S/01Rl5/HIkdnCYkiswKjFbXshImYai97RMxe78Ud
	7+iZGCi09L0g/oR3OLWCrXoZHPw55DkD6V4w91Nso9010xpgBrjE88RA4x4EaDdx
	wuD4oLEcrdGQO3ucPvjs8DaTbOp8ylVXhq7tvknSvk7w+T4aVEK33c54E27Plhga
	NF9nwOccM3A+A1vN/PBEUbNCX3zbFCtiXnU47i2arDg3BgOluOD21fQRoivpGvyB
	lbtbvDokwEXutrDKq5n/vfaFTTh4U26CpeCSXzE4pHjyNCiGjFa3ZfuCBzPT+bQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtrep0tx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 09:14:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U9EQcl026630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 09:14:26 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 02:14:24 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv4 0/3] wifi: ath12k: Remove unsupported and unused ring configurations
Date: Tue, 30 Apr 2024 14:44:11 +0530
Message-ID: <20240430091414.2486196-1-quic_tamizhr@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sYENBs-aPv_f0_Bm3g2c0sQwk0jQuHWI
X-Proofpoint-ORIG-GUID: sYENBs-aPv_f0_Bm3g2c0sQwk0jQuHWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=812 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300067

Currently in driver doing memory allocation for tx_monitor,
tcl_cmd_ring and tcl_status ring. Here driver support for
tx_monitor mode is not there and memory for tcl_cmd and tcl_status
rings are allocated by firmware and it uses that memory instead of
host allocated. So avoid these unused ring setup configuration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Tamizh Chelvam Raja (3):
  wifi: ath12k: fix calling correct function for rx monitor mode
  wifi: ath12k: Remove unsupported tx monitor handling
  wifi: ath12k: Remove unused tcl_*_ring configuration

v4:
  * Fixed ath12k-check warnings

v3:
  * Addressed Karthikeyan's review comment of modifying
    ath12k_dp_tx_htt_rx_monitor_mode_ring_config in correct place.

v2:
 * Rebased on top of ToT

 drivers/net/wireless/ath/ath12k/dp.c     | 16 -------
 drivers/net/wireless/ath/ath12k/dp.h     |  2 -
 drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +---------------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 59 +-----------------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 44 +-----------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  3 +-
 6 files changed, 4 insertions(+), 160 deletions(-)


base-commit: 861928281f22a08e3d258ebcfe7159d729ec07d4
-- 
2.34.1


