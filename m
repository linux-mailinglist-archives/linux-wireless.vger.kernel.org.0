Return-Path: <linux-wireless+bounces-7023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACFE8B6A05
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72A4283083
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 05:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053CC14F;
	Tue, 30 Apr 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mVklaYbl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5E1758C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456107; cv=none; b=umGOEF0ccKS99pcRyRwpjguK+S1ofWOCJ5XzhzfLB+0JqYVOZ+Uar2gtRWLZG459LZfjUPu7HNrq/0IT5H0H9YgeDBWWoZLOzezRTRZN/EFIeQTjO/LJpgRFVCo96+SgUSAPtWfYjAu73sGaW6BEI0X0zKnN4OgGC6pFs8P3JrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456107; c=relaxed/simple;
	bh=qVcgBWjJKrFcdCJFY6Oy3NmAWbgCxSp1CUOagyxrpn0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndBBMVWrhUmnFNTu1lEgHV7u6m9Kd9uFbsbu51rWjmChorJwbGJ0I3/KY1MPryQNt/zPWopQxK+534/AAj4aabIpnnaT8TyE9xQzd+zhYzVvCPAXPZ5DgCEG6iHZUyc4sn5XhE1wOtVtEIN6Lak25IUuhe0kbefKmDCes4lxXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mVklaYbl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U49lIm022193;
	Tue, 30 Apr 2024 05:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=13j3o0w
	pKKEex9/Mpqwhfgs3weNPfKWZt/RNfDqxUCE=; b=mVklaYblJI47dtHgWdrtbsn
	x1SbMNc3DWoTZn8t28+DT9isZaWNf4BW4ax7rw9DqVuHLGE+38Iaip0QJ3kqaq/w
	dUnEH/9hSZ2Samt9B/u7aFa6DdUWodR3Ri38QYFc5wxvDIIkjKSuZUjZ4JDvJgf7
	Qo581nO/CO8vEW1+vyd2CdrOnCvCb+s3HHL7WIZNa/U3Db05+gYyZfHUly9HHwVt
	CqJaWZ0Q0rnUFJY4+pNNoNSL2qu8v3YpokEbUqIz9sS96/ZLjvnCtmMaDBT+JeHc
	DubiQvg6jCEhVH6lzvDX84RN16cgr5N3T6SaMMmlpI4afimHDoIRtdJjQZh9mZw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtrep0cdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U5mFJ4020623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:15 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 22:48:13 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Add multi device support for WBM idle ring buffer setup
Date: Tue, 30 Apr 2024 11:17:55 +0530
Message-ID: <20240430054759.722620-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ezlRTT8Qp8Hd37SBzJY81z88ixpO8_Fs
X-Proofpoint-ORIG-GUID: ezlRTT8Qp8Hd37SBzJY81z88ixpO8_Fs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=674 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300040

Refactor the WBM idle ring buffer setup to scalable for inter device
multi-link operation.

Note: This patchset rebased on top of below patch series
 [PATCH v2 0/8] wifi: ath12k: Introduce device group abstraction
 Link: https://lore.kernel.org/all/20240425055759.1181165-1-quic_hprem@quicinc.com/

Karthikeyan Periyasamy (4):
  wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer
    manager
  wifi: ath12k: Refactor idle ring descriptor setup
  wifi: ath12k: use device index to advertise MLO parameter
  wifi: ath12k: add multi device support for WBM idle ring buffer setup

 drivers/net/wireless/ath/ath12k/core.c  | 10 +++++++++
 drivers/net/wireless/ath/ath12k/dp.c    | 27 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/dp.h    |  1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c |  5 +++--
 drivers/net/wireless/ath/ath12k/hal.c   |  5 +++--
 drivers/net/wireless/ath/ath12k/hal.h   | 21 ++++++++++---------
 drivers/net/wireless/ath/ath12k/qmi.c   |  4 ++--
 7 files changed, 54 insertions(+), 19 deletions(-)


base-commit: 861928281f22a08e3d258ebcfe7159d729ec07d4
prerequisite-patch-id: 4bc84a4f5b10ebc28db60c5167abdaf343a1619d
prerequisite-patch-id: ea87d2f46dbd5e7c82d5df02934906e219aa8388
prerequisite-patch-id: e08d8632dcde9e891d37b538832b4ecfed140d9e
prerequisite-patch-id: bc2c9455c9175c27b8b68f6f41d468b258007478
prerequisite-patch-id: 00966c65589af8a50078fea94630cbe355f0dacf
prerequisite-patch-id: 4bd8ce903cd89ae536109922f65f128ed1d4307c
prerequisite-patch-id: 54fe8eb540a77804c8befeb695b61756c133b56f
prerequisite-patch-id: 06244ca08d9bed3834dc5315470a19d096d749ee
prerequisite-patch-id: 8e7575808b1c498d81b606777153e0e2d4ee99bd
prerequisite-patch-id: 1baa4ce64b2054e82e117cfbe29f85870def37c7
prerequisite-patch-id: 733cb4a1e0d02079820d8306a3da88fe2d35b06c
-- 
2.34.1


