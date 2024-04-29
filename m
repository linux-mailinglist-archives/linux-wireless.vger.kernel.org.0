Return-Path: <linux-wireless+bounces-6963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495658B5233
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B789B21169
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068910971;
	Mon, 29 Apr 2024 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kau8t5yg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EEA13AEE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375258; cv=none; b=H+FsSWVzFJkm3GwvdhDRqAAQlln7cvuLqncA381eIW6a0/5LlYu5OVF8u7XvI1JSv26pNOqMCpVVYYOcVKmNvJIWiHPLNHL7TRDth7bzDeUTw9ZGDJqU9UkFBkUw6F+2ZioV7ApANKyDpJygM6U+vCVgEssDB9XlVff0nceyjBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375258; c=relaxed/simple;
	bh=NdJlpfbaD8kegMgHtOo3uWBZb54ejwPetB4GbtPtBI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txPzHRzEcnhfOHqqukItXSLfGU9VV1QK2lKYnLZGAxgFGt2+Q6jPiUbghQI4YUJuj7rSiTGX6kgjFBd/JtwzDSe77TfkAX6h1pE2zvoz++pGcrnNylqR7W0OC2z2AoDPeR6DePTqbm3b7XjywniJxMamKdIHdoTIfn2aAb56fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kau8t5yg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T4xuqa007939;
	Mon, 29 Apr 2024 07:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=9bJWOgl
	4uRAkLYEDQrQ8xjpRbwqCV/8hnvadikn5g8U=; b=Kau8t5yg7hNNCjUzPAo3/ou
	ZXwY+d0mg8+cMvoGDpOKTXEkNW/qyhapaNX8DNHUACXBtt3JhIH7Tk8sbDeD4D9g
	xVtBZK5is0o4a6AxQq6A6dcpVNEOPHlKIRWa8CTmdJ30ljw6yvcblNgSXhZW7nka
	hQwWq8RvlhmUyVyQG2WgkM2mOvbUI4jWvLHvSljeel9I7VF/z+Mvhpl6vY3gSbwY
	zMo8vAMtvdsGdglz3axRKgdimp2x+ATaIbXz904XIQuOQaC3ezVFvHW97l1Yh382
	TZhEaippuCG2dCK8lwkQUhKN+HSymmRCy6CADvQCy26Zazw/F93V9uj1zQrW2lQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrsk7b0j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:20:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T7Krdj012390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:20:53 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 00:20:51 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv3 0/3] wifi: ath12k: Remove unsupported and unused ring configurations 
Date: Mon, 29 Apr 2024 12:50:36 +0530
Message-ID: <20240429072039.711706-1-quic_tamizhr@quicinc.com>
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
X-Proofpoint-GUID: GxDOEuFsJHg4p7h_yyI-ZmL00myd-tdV
X-Proofpoint-ORIG-GUID: GxDOEuFsJHg4p7h_yyI-ZmL00myd-tdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_04,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=811 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290046

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

v3:
  * Addressed Karthikeyan's review comment of modifying
    ath12k_dp_tx_htt_rx_monitor_mode_ring_config in correct place.

v2:
 * Rebased on top of ToT

 drivers/net/wireless/ath/ath12k/dp.c     | 16 -------
 drivers/net/wireless/ath/ath12k/dp.h     |  2 -
 drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ------------------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 44 +------------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
 6 files changed, 2 insertions(+), 157 deletions(-)


base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df
-- 
2.34.1


