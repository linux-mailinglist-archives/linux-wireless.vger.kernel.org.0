Return-Path: <linux-wireless+bounces-16367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB89F0818
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 10:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC20F188A2EC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F314C1B21B9;
	Fri, 13 Dec 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TtRQcYGP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D71B21B5
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082783; cv=none; b=emmcgr918Xjgxkx37wqRVTCujFvxFq8YnaxlN4ueTTEQF2h3K/d8m/myjsjnrIn97hVbXEEjUIaFocbQqClCUbCgbW/kuRVko18h/qUCv8mt0zDa+kyLzRVemr5n2HBmKvKo//cHi9lK/vVQV/PL0nVUn361FrwcZTv49L0GqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082783; c=relaxed/simple;
	bh=AC40zkVUQvcZ3+c16uMAp+EoE8sUOfBkBfeoDOXOPMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sSITBSierIHZ1lLmoRdbXjYG6eDBwhZa3ctfHbybPXEOR148bpIi6J5xG/9o2s/lBLGH7rWulgbXzk5S8hNHWuE8hvbC8/tGICvNh3hQkCj+aeOr83cZpcqnHOhr9EAHxz9MBsIhupHPiYocL5yZGYH+BAZI2BubBzVB59dmAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TtRQcYGP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD81qtE022359;
	Fri, 13 Dec 2024 09:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1r3GqdVafTA/t13G4FL9UV
	9MtMcYgAA01bu/+yGUwc0=; b=TtRQcYGPnkByRp//MOXEOT7Wz8HfBpC8EKVn/i
	Lsv247UjM2KqppJu90Z/4qEU5n00odfNgk5EXgp+uygzliOXz8b84BxlkLnJ25hr
	IBSrM1LbGv/OmLYl39BHeH1C5PHsAS72Is/PqE0BrbYPbOxQ7Li1JLA0LcNAf6KW
	W9ntee0a1K6edVTs6kuXZnmQ5tptyDbxYjniFs3QkLlQxxSgA1JUWaBOrENkv5F3
	gskPdWtENrcHEq4Vz7pMmpomPe7IxGvstTyVZM/G6plRr5v6qOVmI/+nVfP3s6O0
	NcvrqAHI/Nsjbsk/sQjejudFlUtMai33BdNDWdw62OvZy/Eg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gh2709g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:39:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD9dbKg030501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:39:37 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 01:39:35 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 0/2] wifi: ath11k: fix data out of sync for channel list for reg update
Date: Fri, 13 Dec 2024 17:39:07 +0800
Message-ID: <20241213093909.629-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
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
X-Proofpoint-ORIG-GUID: -zwtW7y0qjrlemOi_EO8BS8yferiPYFH
X-Proofpoint-GUID: -zwtW7y0qjrlemOi_EO8BS8yferiPYFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130065

Currently there are two threads to updating/fetch data of channel
list, and there are no synchronization for the data, it leads data out
of sync for channel list when doing reg update.

So change the call flow to make sure the fetch data running after the
update data finished, then data of channel list become synchronization.

Note: This patch-set is an old patch-set in public review written by
Wen Gong. Just continue sending it for him.
Link: https://lore.kernel.org/linux-wireless/20230329091235.19500-1-quic_wgong@quicinc.com/

v4:
    1. rewrite commit message in patch#1, #2.
    2. use list_splice_tail_init() to move list entry.
    3. use data_lock instead of adding a new lock.
v3:
    1. rebase on tag ath-202411251703.
    2. add KASAN BUG report in patch #1.
v2:
    1. rewrite commit message for patch #1 and #2.
    2. use a local list without the spinlock held for patch #2.

Wen Gong (2):
  wifi: ath11k: move update channel list from update reg worker to reg
    notifier
  wifi: ath11k: move update channel list to worker when wait flag is set

 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/core.h |   4 +-
 drivers/net/wireless/ath/ath11k/mac.c  |  14 ++++
 drivers/net/wireless/ath/ath11k/reg.c  | 107 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/reg.h  |   1 +
 drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
 6 files changed, 93 insertions(+), 35 deletions(-)


base-commit: 175616a7658cd5d53389d1f9c1ce22debd4595a5
-- 
2.34.1


