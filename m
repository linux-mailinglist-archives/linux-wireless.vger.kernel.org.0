Return-Path: <linux-wireless+bounces-15235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A74C9C69EF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 08:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525FA1F2193E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 07:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6D175D5D;
	Wed, 13 Nov 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EYfQhEdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD47230987
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482850; cv=none; b=WWAvX7OLxsN70HS8tlAD2bbuo3Op4ZkE0nTiHQ19Z9skJY7SLno1NeOEqkP15+aq0qF+LJj7Y/kLl+Zxe5xyYisUW9cx1ZlT3/e5KcXt0vtCdeXvIWweyEQ8QgIeZSEV1M0rr1DR5bXq6j8mHfD/dpKuIxZhYvEL/Sut5frnrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482850; c=relaxed/simple;
	bh=1bcSqU4S7wOjkrW6aRt5t6MJWyGJPy3PjdKbbNw+HUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sOz80rImUOXLRD0B2ip22b1z5SzDESuEvdK9KL4gOvcuuKpI2k5+QZ5cMl+vevMn4bvueLVYlD/UALV6PJontKPbJpyFZS8O3YjDl5pJKKDLSkLB4ivHPtviRfnmMmZGKBe/4uSeWwBAHNcqklorWkaxAPWyC0hS9j9t4gTFNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EYfQhEdU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD70hPr019458;
	Wed, 13 Nov 2024 07:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KZAyG11EdJUGSuhGLQvC3o
	1xwxtgEsFxh4H3x1gsxlM=; b=EYfQhEdUl1NQEUHG6elzbcMVpldsEX1nFOFe8Q
	T8o7zE/XgUw33JKliILrKQiU8gPXZoSU2IQYKmIIAtFsuIK+NXzwFNJizu+yJoaV
	/fwWJlW7rzJE7ukhBLEaruiO8O6sxTbLzZyVkTNnUXsddqwqRzymKCx8jZsfB9D9
	jBlBrCqD8ok+DzcHr3voWtNqWEb2rEoFzdQYllNHNzcdfdQVGEqXjcksCAjoz/wM
	Ax7+GiZBHHPjTi7B583PuiBAXsj2R4E4DIAptEv+Fpl//Be+PD5LEHbc1VfYuDow
	vzT5r9aoBnpUGqrqz3z7YS+2Xk+YweFp5NVAvh4G45PSaBEQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vqbm027k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 07:27:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD7ROXc018012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 07:27:24 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 23:27:22 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v5 0/4] wifi: ath12k: Support Pager, Counter, SoC, Transmit Rate Stats
Date: Wed, 13 Nov 2024 12:57:03 +0530
Message-ID: <20241113072707.3377341-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4knHXkPX3By8L99I0G1D_L6r-mLPNelZ
X-Proofpoint-GUID: 4knHXkPX3By8L99I0G1D_L6r-mLPNelZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=995
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130064

Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
These stat types give downlink pager stats, counter and TPC stats, SoC
common stats and Transmit PER rate stats, respectively.

v5:
 - Addressed Kalle's comments pertaining to variable declaration order.
v4:
 - Addressed Jeff's comments pertaining to data type conversions.
v3:
 - Added macros to fix compilation issues.
v2:
 - Removed dependencies. No change in code.

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Downlink Pager Stats
  wifi: ath12k: Support phy counter and TPC stats
  wifi: ath12k: Support SoC Common Stats
  wifi: ath12k: Support Transmit PER Rate Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 629 +++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
 2 files changed, 830 insertions(+), 3 deletions(-)


base-commit: fc6f018eda7f9054e427f731db1e8b200f22873c
-- 
2.25.1


