Return-Path: <linux-wireless+bounces-5697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD06893566
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 20:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764F4283CCE
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606F146A93;
	Sun, 31 Mar 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L5/MLGRz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C012AE69
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909983; cv=none; b=JaPm/ipksDFYq/a/T8KTJJf4rWSlPhOlBEe/8lWPhxOwF8loY04eURyZ98G1fUHKdUBEc+zFpv26OqwMGI2Jha8AUKrHFIclzFnNrsmq+js1JK54Um35AHamX/tZDyo2YaxA8gkX0IwUpgrW3mERxL/GTklcrCWZI4PiXVCGkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909983; c=relaxed/simple;
	bh=rik1rprSBsq50JvgztvZEDXHlz/D0eHVs91w3yOgPQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IiINEl0BuDApeTAG33WkqC8QwErIfVzNO22Irk2OSxrysh3e7TeZT77lCJJhGhprjryzEJwQq5AMGHOtmHMzhkEHFPiREYlEo7rTGmmu6f7dcv0QrozcRsYL8E5apKPtqhSiCbLkYamLcZ18RmX4sCFMUuJmsFmSiesAS6BQx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L5/MLGRz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42VHTltB021179;
	Sun, 31 Mar 2024 18:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=DdIGN8R
	Brw3P+/YncVg8FhGTkyaHmrwoXoL6ETJBzbk=; b=L5/MLGRzsGB95DheSkPwaXP
	PZEDiumXO4jixP3MZxIGgBJS5YzCnqno8z0SPq7yVHAGtq1tTpC3J8d2aiu5WWRD
	PNE5Kprmbc83j/gpOJX59KSys+P6h4RZtK7p35WHdv6VA7pxXvCNX3i4EEz1QDIY
	AoAdOK3zHhLg1yy7nN6w9yWxacEqBNHgTq5+f9j1iDz1nFGRQIv/ki8NezOoLhEx
	GLQ0E0YsDBAVzvl6mndvoX/DHE0PZHTXVi3hIgrDVfm3DdlxTCZHQZQOU1ilUCm/
	F7X6CWk6cj4rYvf/pCcyf5dsd+9xrD6o37VCBxIRaxQalyzrUYm3qMQ2H6vrc0Q=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6ab3tecw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 18:32:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42VIWncA022043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 18:32:49 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 31 Mar 2024 11:32:47 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: fix BSS chan info request WMI command
Date: Mon, 1 Apr 2024 00:02:30 +0530
Message-ID: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lnIF6sKInrh2LrWcliHDYoJZmI0bjYCc
X-Proofpoint-GUID: lnIF6sKInrh2LrWcliHDYoJZmI0bjYCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=618 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403310142

This series includes the fix for the BSS channel information WMI
command and ensures matching structure between ath12k
wmi_pdev_bss_chan_info_event and its equivalent firmware
structure definition.

P Praneesh (2):
  wifi: ath12k: fix BSS chan info request WMI command
  wifi: ath12k: match WMI BSS chan info structure with firmware
    definition
---
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 drivers/net/wireless/ath/ath12k/wmi.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: 8027a466a77a288eccd2d11868f504e24231f3b7
-- 
2.34.1


