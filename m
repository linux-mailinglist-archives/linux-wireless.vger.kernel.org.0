Return-Path: <linux-wireless+bounces-14954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B239BDE0E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 05:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69361F22CAA
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 04:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22718FDD5;
	Wed,  6 Nov 2024 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="awlWKKHr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9918F2DD
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868390; cv=none; b=jo3Jk9r98hQmkYBDdwiwkHlOpO7QbeRufh+raItsAbgO5iYqtY/f0pErjvxlAyvqppPK8waKzLComYJeG/E9XzskM+ElDRhdt9ZALlgvzfKW49ucSkrTl+Ff/KY2hxmmu1ZDY4054H4z6X0l7+kYTOCHsu+1JQMJyo4gh9jE1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868390; c=relaxed/simple;
	bh=m5m9BrIQcKLysinvTQt54wLWI8xP2rrGvzEGOES7pqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RUrRFe3pmKhrY4uYZaWElJingzDYCa0TLX7gwdlqXzIBi6VqaFrPkkRgw3sIYcJ1OfF9x3lOUy0B5eKmmECtKasY67AJ+uqWkJ1ZBK0saTel0006KnpFJ7MMmWSfISCFA8WvecZdZJywk+Cod5ILUAlprsmjzBMbDOq6JBKsWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=awlWKKHr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5L8JLr003791;
	Wed, 6 Nov 2024 04:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gjkNU4wTwFwl9vDQfQeBk8
	Aeh5B8MObiOwYs66DoJ4k=; b=awlWKKHrDsR3fWvy55AniEw8FDdrNxhLx7O+NY
	sxudq5CCZCW+GciBI2CKuUSpwJ3HKCAIXrjhnB3UOiBg7GJ6YFMWSfE5cy6OHin8
	4cBJL1K3u7aGb1Ig2W6Y5SmgikBs2PTEyf2oszKD86dAXQNP57IAwr5pKAl17H36
	TI3qWIJXmTS9GsQI9SBJrcZQJ7XSrqG35bfmWITf5B6RzuEP/gwRXI95cZxyWes7
	OaHRNVJjnUVkMA0JJX97aCmELNYLV0EbkrAS6tFiS+nPgb79tPrAdFvE13aIy+gh
	PZAPY1SffrP0gOXok/NJqC0Fhsonn9umPN73o0WvMufdrFKg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qhbuannx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 04:46:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A64k5ph000307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 04:46:05 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 5 Nov 2024 20:46:03 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v4 0/4] wifi: ath12k: Support Pager, Counter, SoC, Transmit Rate Stats
Date: Wed, 6 Nov 2024 10:15:44 +0530
Message-ID: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2hQ32pbinloDf_MXUnP74_noPM6c2GnL
X-Proofpoint-GUID: 2hQ32pbinloDf_MXUnP74_noPM6c2GnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=897 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060036

Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
These stat types give downlink pager stats, counter and TPC stats, SoC
common stats and Transmit PER rate stats, respectively.

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

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 630 +++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
 2 files changed, 831 insertions(+), 3 deletions(-)


base-commit: d63fbff74ab1af1573c1dca20cfe1e876f8ffa62
-- 
2.25.1


