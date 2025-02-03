Return-Path: <linux-wireless+bounces-18314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC3A26588
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C487A2594
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC920F09E;
	Mon,  3 Feb 2025 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g4w6eiVS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4420E71F
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618024; cv=none; b=k6zyewxBfqXDFiae5/gT5wjHufjcud3vvod55ZPfNXnQfb0mX+mNqPLQpejpI2QS+WAogC/NNXS1uE2bNFS0F/4CTulJGIwdTKnxzm+cTT8QzhCngGMcnryKAt2MX3GlcH6pSyP/VTHCsH9bBotqTg9IwC1cJCLH0cUZ6U2J7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618024; c=relaxed/simple;
	bh=3APBEcUGR7ZnbmsoGAjFzL9CdFdTsRhvN6ygql3hb70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=apONI+bRihXmBTMdkG8yt3V//wwseU9TxTblb4mznduQl3hSaMiJcSsBnVF1J5ly1hrUc5Ke5TdVcd5iUsNFmunvgAicWMe/fuW4jeYOrJXHMOuf9TRtkKiyVquk06Bat2QdQRDBfCB2EBao2YoAF658wI6UwSvP1hyXESWAayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g4w6eiVS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IaVkK008536;
	Mon, 3 Feb 2025 21:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zWBhqIoDII3hGZreqlqQrv
	/8z2HQniPuVoZV5TGFe2Y=; b=g4w6eiVStAC2hub/2JTmlg6K/HxhL+wQlt3VFB
	59vYUteEEpSbRgpObL46JEhdl6rqWgjhgekc3EBBCc3Or9k+8MljeKK52EHJks5T
	9wwA0ciKrpA+qwha/tQNLyCksygIUOhC828dwnPhpvnhZam5CS3HfPyroa2DI4+k
	ityhJkc/y0K/9GuF2RWPJS9sFwkha8aGwoD9TE2aGiOJEZYJsppkoutKj2kkE12u
	/uDCB07zO1phS1KmHrR+AZKVIW+O9pNZrnVhF1EGCrUFbB6+vztEBYYn9GbwbTpm
	RXN5nN+XHnNCfyNgj9JVCTacKF2U8xFXDT4Lui0+RJQHnUaw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k37u0b35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 21:26:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 513LQwNI002629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 21:26:58 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 13:26:58 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH v4 0/2] wifi: ath12k: Add support for MLO Multicast Handling
Date: Mon, 3 Feb 2025 13:26:45 -0800
Message-ID: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ImfMIiTU9gKlnWr9kGJawpQCtHXzjlPj
X-Proofpoint-GUID: ImfMIiTU9gKlnWr9kGJawpQCtHXzjlPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=758 spamscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030155

Patch 1 updates the HTT TCL metadata version to use the new bit definitions
	of the field to pass additional information from Host to Firmware.

Patch 2 moves the MLO Multicast frame duplication logic to the driver to
	have more flexibility to update the HTT TCL metadata with the global
	sequence and with a special vdev id to indicate Multicast handling

v4:
	Fixed cosmetic comments.

v3: https://patchwork.kernel.org/project/linux-wireless/patch/20250203075538.3982875-2-quic_bmahalin@quicinc.com/
	Updated the code to handle the ARP transmit failure from AP side during secure mode.

v2: https://patchwork.kernel.org/project/linux-wireless/patch/20250203025016.3851279-3-quic_bmahalin@quicinc.com/
	Optimized vdev id arithmetic for more readability based on feedback.
	Updated code documentation on intentional reset of meta_data_flag value.
	Rebased on top of master branch.

v1: https://patchwork.kernel.org/project/linux-wireless/patch/20250109184932.1593157-3-quic_bmahalin@quicinc.com/

Balamurugan Mahalingam (2):
  wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
  wifi: ath12k: Add support for MLO Multicast handling in driver

 drivers/net/wireless/ath/ath12k/core.h  |   1 +
 drivers/net/wireless/ath/ath12k/dp.h    |  27 ++++--
 drivers/net/wireless/ath/ath12k/dp_tx.c |  27 +++++-
 drivers/net/wireless/ath/ath12k/dp_tx.h |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 123 +++++++++++++++++++++++-
 5 files changed, 165 insertions(+), 17 deletions(-)


base-commit: a10b8b584b8bcb7559f068ce247fc27d0c4850ca
-- 
2.34.1


