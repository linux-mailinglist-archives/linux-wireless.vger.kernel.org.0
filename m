Return-Path: <linux-wireless+bounces-10338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FDA934846
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 08:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19861C21603
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 06:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2740D44C7C;
	Thu, 18 Jul 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gN0FJ094"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384312E75
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285244; cv=none; b=Fyk8S/Teb6y5hyn+TukgJJLHbbm2d6p14D+RdywPdtd5R6PPIyCQJ8cYPDJ89rUDsEnpMGmm3MMgM6esphAZlMhVFm7bfOfHh5yAy11KHyCltYKlONoFWYsaqRE8bBWoLnCmMzbCPy1yG5c15C9mYGXSxgci+k8CuWI5sF5cHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285244; c=relaxed/simple;
	bh=ZSyQJJx2W6jwMrwLx1GXb0D28276NaRmEHZ+yP1X6RQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+OZFWPRWDw34IupRWKoURsyA61U5JTj3hCfuZ+CooFvo0ayBE4Dpbkh+lymngMkdDGHfk6BnSNr+Nc6MhOGVHQRnjmgJYaD7uefTyaAPTC6jzgGInRArK+dJj6tJ+kZ1wAcNqzbklj+pr4L1zzIXbgnC1HXXydd64kOZYINyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gN0FJ094; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I2fF5Y023029;
	Thu, 18 Jul 2024 06:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hWf1U7WxD5RKM7M0fAzr2y
	Cmdj2ZDXLgAGSgeg86RhE=; b=gN0FJ094OhjJwXoagmBOBD3Da4ytxsoscKOUEP
	1GfxiSCrPBCw7n8p3WdBJ4hIGRN5BR7tq1SBxrMjrET6GKgSyqwawaeJ0pkZN7Dj
	3x4q2uUxDM/wSHisqtQ2Esh8IKw8/XHTCNMlhYSMc7lrn9R92JodzT+iFd0w2j6c
	lXbAcAoUc33P+8vD6i4um0soyjvvaNnSqZIu5Gs14e17o7P00AC4Cx3iT30rWRqk
	7Qqo13GQhvTUJaGqwabUrRyE/ITvzS6Q7y+i+Ggz4u5qIrbnneFVIcSuw4ZjgLtp
	dozhw4H/jm2bG0XJXR5/Dh1V/K7OC6unxdtNTZgZ3iAyfoJw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfnmnpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:47:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I6lGmU006353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:47:16 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 23:47:15 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath12k: Support dump PDEV transmit and receive rate HTT stats
Date: Thu, 18 Jul 2024 14:46:56 +0800
Message-ID: <20240718064659.109893-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-GUID: dwR7_pj8DAy6zLZksY_wqMOxdnOzbYrY
X-Proofpoint-ORIG-GUID: dwR7_pj8DAy6zLZksY_wqMOxdnOzbYrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_03,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=598 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180045

Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.

v2:
1.use TAB to be consistent with existing code

Lingbo Kong (3):
  wifi: ath12k: Dump PDEV transmit rate HTT stats
  wifi: ath12k: Dump PDEV receive rate HTT stats
  wifi: ath12k: Dump additional PDEV receive rate HTT stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 500 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 182 +++++++
 2 files changed, 682 insertions(+)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.34.1


