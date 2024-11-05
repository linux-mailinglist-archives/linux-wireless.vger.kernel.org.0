Return-Path: <linux-wireless+bounces-14908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021259BC473
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 05:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B07AB2170C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 04:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF018C938;
	Tue,  5 Nov 2024 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lmmowmq+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC929D05
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782470; cv=none; b=cNGKQHybwLEDaX09+L1baOJd8gEObq3eBFCMt7nk2uwVb++c/On+7jS8JVFilQri7tk0mWdHUSFqzDoeCMw0MXGiardsAPgmPL/bEigeyXCxKHBwlNvZTSsPiRVW5pRuh9cVKhdubX/PBE41QRKIrvjOafOiPZZ+JCW6O1l/13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782470; c=relaxed/simple;
	bh=vloVhzTX2+giI0rlV+PTebMUzUcMTBLhpZpcDP72KxA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d8qdxWX6cubuZRCPwUtQI2kVc8argIH79KxhfH7BB2grF4ofsWAlaTGU/gw9Xm6fOoQeJt0SzCaXNZo19xAy+0eRQngLXB8wN0XI+ZznpNIoVdH7M7rBnv53rft1SYOBxoEydGXH8bnNZ3YHdOg1uU+XTYjVcNkgH3Vwnw6ud8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lmmowmq+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LIl5I027226;
	Tue, 5 Nov 2024 04:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8rsLxdD/UWC/xiCKV40bbC
	Tb3qGqfS18MRfNOTvHOGk=; b=lmmowmq+T3H0TQD2+dGq5a9WHmwcB+lYBJI+EO
	E9b3rSmo82JVSEH7RQ28CDVh32TLqew/jgW9vWMnKfo9fBCBETH560s/jFYRQlNV
	JrFCARamYTkxojamVbMbKPpQVxfCZLqNd78plaoS3C2t1ymG5Jf7TuS7bF9Ty+M3
	wTXAcqpcDSi+awK+j1nRe5iEbvIJUJmKdj+1J0yWUz1h0TwfIquy1QQop0nxe5dt
	g2YswX4T5v1kaMPk5rcT7N9Pq7iliJVl5N//fxzlYDFSgmUPp0PK6gPVj+Xq2aXQ
	yUWYttJd96U5HCtPp/ze7ustEq5b6/688z0uTvGl1B8wujWQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd8he9k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 04:54:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A54sPnn022037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 04:54:25 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 20:54:23 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v3 0/4] wifi: ath12k: Support Pager, Counter, SoC, Transmit Rate Stats
Date: Tue, 5 Nov 2024 10:24:02 +0530
Message-ID: <20241105045406.2098436-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2RPKphW8k05blDiInOPbWDeVZbC8w1cK
X-Proofpoint-GUID: 2RPKphW8k05blDiInOPbWDeVZbC8w1cK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=811 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411050033

Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
These stat types give downlink pager stats, counter and TPC stats, SoC
common stats and Transmit PER rate stats, respectively.

v3:
 - Added macros to fix compilation issues.
v2:
 - Removed dependencies. No change in code.

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Downlink Pager Stats
  wifi: ath12k: Support phy counter and TPC stats
  wifi: ath12k: Support SoC Common Stats
  wifi: ath12k: Support Transmit PER Rate Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 627 +++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
 2 files changed, 828 insertions(+), 3 deletions(-)


base-commit: d63fbff74ab1af1573c1dca20cfe1e876f8ffa62
-- 
2.25.1


