Return-Path: <linux-wireless+bounces-8293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF948D4613
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 09:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7CF1F229A2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 07:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FF174069;
	Thu, 30 May 2024 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="if0UWLht"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA474051
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054059; cv=none; b=VJwo7Jpllkk0HyiyW30+IkTYT8rf4oUrGaDbS+iDB2Lj2vz5p/apu70oN7Za7DAltk+VR6XBaAuAOz2U7J78pVB4bmRiaAudW69xTOjF/M7zhBzYv7DfSl5ogCdEYlqktU0ggyJuNoiiM5y1EMBmMnemmfHYCZ+qk9Fqru4Vhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054059; c=relaxed/simple;
	bh=IcVqUfcudBjIvQlk5BZW6ss8jl092D8FQcP2TiXo+90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfOIjIK8qkakPg72CWlGVCErCOeN7ow+bfpoVr3nhI962qOgxfQxuTog4bp9R/xg5MxKNFS+5tTzjK90o1nX2cW+zwVJ77O+8jjOMH9++SxTuWwdBj8xoGH85WdxX0EoSzQhcsBTKEV2/z89oAo3YZCozt5iVcAiTi1VRmV2s28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=if0UWLht; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TK66kx026099;
	Thu, 30 May 2024 07:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DrHu3j06DgCLg2nx1bEAwBquVdw6JysOGHHw53Gqwvw=; b=if0UWLhtroEoqfNo
	roBofRRjddKyGeoizafnaielmXfD9bLu/mdw37+tN6Eqs5BVNUl6gnflYaTysyYH
	QJGHhRNZzrdJD9wpSNINI9P2szB6LbtZEVOhnyLKwKICqOa24nRrwobcmTsXM3Wz
	tzxuJKpqFveYrpFA8rATpklUjkXvMcS9WfMZXTr3UrW9sr0kMBwrWOVr+RihngbO
	F1S/+G/KaUb/iawr3Wf80SrH7PY2zoSkY0CSFVQfp9zwzddC2oi9PWAJgR9kYuwU
	InHVYM2t09We+uh3wD66ZSDPDYrepBOSqw9hjV9vkiGLomNkoG1NmDzqBBkaaSxU
	kNXEBg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjbda0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 07:27:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44U7RQM5012264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 07:27:26 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 30 May 2024 00:27:24 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v3 1/8] wifi: ath12k: add ATH12K_DBG_WOW log level
Date: Thu, 30 May 2024 15:27:07 +0800
Message-ID: <20240530072714.25671-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240530072714.25671-1-quic_bqiang@quicinc.com>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: udfOMsIuDw8XXbGqkbhDbxfhc1wrSABx
X-Proofpoint-ORIG-GUID: udfOMsIuDw8XXbGqkbhDbxfhc1wrSABx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=888 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300054

Currently there is no dedicated log level for WoW, so create it for future use.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index aa685295f8a4..3855b770772f 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -25,6 +25,7 @@ enum ath12k_debug_mask {
 	ATH12K_DBG_PCI		= 0x00001000,
 	ATH12K_DBG_DP_TX	= 0x00002000,
 	ATH12K_DBG_DP_RX	= 0x00004000,
+	ATH12K_DBG_WOW		= 0x00008000,
 	ATH12K_DBG_ANY		= 0xffffffff,
 };
 
-- 
2.25.1


