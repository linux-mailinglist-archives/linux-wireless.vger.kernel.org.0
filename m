Return-Path: <linux-wireless+bounces-4935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878958808DD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 02:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99811C21CBE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7DD10FA;
	Wed, 20 Mar 2024 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="flx46Y2r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D0EDB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896799; cv=none; b=WfozUjSTctTOlvMRBLyAlyD+05Xi4Dslz0PYJizK0zNcF0vdIPQqXIpyAv64LnmISCnd06IeJIuQzQNzxQL8raSZXkA1rXZyw3j8FrB5sTAcnj/v58Wl5PUGqWZqaZuyt+oDiT0bGG83vUfCEu+B3rAIXN4RJIni+sNBjLInD8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896799; c=relaxed/simple;
	bh=qbLHKQ8n7lLaFwKGabt0LBfmUm20Ckqya8T5hnb+jHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MT9gO/e76dtqz/M/BdjQv9qNJzoqHpZQTE2u6Bla4hH0+7wsDsrFyGhxTDt1CGquzk1q/VYAP+ObF5tTNLoqTZiIsXu4k0bcxdqxTIh4A91VtOndeYe7E+Z9ALXx3wVjMpIbd64ZTPNqqYwNX/P5OIn25kWKn7BHWMvCLKAZjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=flx46Y2r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K0wcS2021648;
	Wed, 20 Mar 2024 01:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=nEJmj18
	XBa24x5VfgAFgprFQ0bBg/35sYVnmhcBb258=; b=flx46Y2rpx5Ya+DBZbj7ICM
	2qu90fDpw/aanq+O13gAjd6wU+zzfK1LueLBuWp6NFdlK5vMgWiGUhJL0TUfhN7Q
	yZRKUCFNqWEoIeaX5gxEdXSEVcDkSOhYanvirr87CvRqKTzJGOhrfiF9kBVoXzCC
	tnZwqBH7jtnvPyLi18lNfD56S9l0J5w9+5FFLrySKcw0Q10ehAXhkb0Z4tgEAaB/
	gQLVj8lrUhYxJc4ipovi2XG30KMqhGCkUr4MrOQFnr4HnWTBdSsAVHLCpF1MEnml
	PDSk6dyLYtJzBechHzQyRtMjIG4uNBPxJBITgKK57JUFeTeludpTOK3mMuXKOXQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy553jfgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K16WQv025531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 18:06:30 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath12k: Optimize the lock contention in Rx data path
Date: Wed, 20 Mar 2024 06:36:12 +0530
Message-ID: <20240320010615.91331-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: r8b5o8mj1CEcgPIORVIW1sA61POuA2rP
X-Proofpoint-ORIG-GUID: r8b5o8mj1CEcgPIORVIW1sA61POuA2rP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 mlxscore=1 impostorscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 spamscore=1 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=226 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200006

Refactor the Rxdma replenish procedure and avoid the Rx descriptor used
list to reduce the lock contention in Rx data path.

v2:
  - updated the improvement details in the commit message

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor Rxdma buffer replinish argument
  wifi: ath12k: Optimize the lock contention of used list in Rx data
    path
  wifi: ath12k: Refactor error handler of Rxdma replenish

 drivers/net/wireless/ath/ath12k/dp.c    |  31 ++++--
 drivers/net/wireless/ath/ath12k/dp.h    |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 140 +++++++++++++++---------
 drivers/net/wireless/ath/ath12k/dp_rx.h |   1 +
 4 files changed, 113 insertions(+), 64 deletions(-)


base-commit: a2a4cf3541db8066af7e6d4eb6e9e6445f6d9658
-- 
2.34.1


