Return-Path: <linux-wireless+bounces-7060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C938B7E0A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB1F1F24A80
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22A199E9A;
	Tue, 30 Apr 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pBr4TuLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E81802A9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496313; cv=none; b=Vl49QoDHHxDkuccjhnPgufs5esYrE55G172jpVWWi97IeUV1/Vq6oo3T5vQg7aNmBeyAGvc7UfCZkt4c45N9jEbT3KrnsFVbuLzhJDvHEaByjQ6krQOX5rhRgNOa/vrhDqseKvoUw9D6FnA04HFEKsXp3Cu2MjAwXmsg+NUosoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496313; c=relaxed/simple;
	bh=k8Pxxk37mjryNTEBdsrwd8BcD8k+uksUX6dAbAv8Fcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iZGFn8YcpYB5fuR6WYUF0f1+Sie8XpK/o7n31jOX7B/IMMT3hCYadZVI0NPTvkdJANpXYduu7cgL0RcYp9qZVZxeX+7YN+hpvSr2LddR+jlrSz7sMjJb8iSr9Q4Kge86Aj2TSp+DvjiuDhqRbg8sj9M9/HJlp2LokbzN81e/zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pBr4TuLW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UGLR6J024692;
	Tue, 30 Apr 2024 16:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=+NGs/7h
	30n1S2Hq84xfG+4+AXUYE9/JcwfwCDGSmGPw=; b=pBr4TuLWrNx8CPi4AjnqtRm
	xAwp+UOQNpkf7K6D/IN/XbOLMhRQZ+/TYROc30yUPIbk5ubwDS29mqKsVzgHgHVp
	U6Qte6LosNwFwohCzOOfppL3F3MOJ/kx2gc+dmGNYmEU9p5HF3GjLMiPY22OwpXX
	MYtvSnbnxiCURug++vvPNGDW/ddm4HqAOZ52fLlpbIXwjkGORKoxj7evfyE/2mRE
	nussHRkgrQ94se+p0oywcKlK0ZfcgjN8IVJK2pMfCzRKTOnw1l435RRowV9tptYj
	ETAUt0/yrsrhFeNvMPhYe8lpvQn/s8wQUDQNu7v8bReuy6vxJdePbFw+uX9VO7g=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtrep2192-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UGwSH7024699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:28 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 09:58:26 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: Add multi device support for WBM idle ring buffer setup
Date: Tue, 30 Apr 2024 22:28:07 +0530
Message-ID: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pTNY-RseEn253RON9MS8X1gdRtZhuFr7
X-Proofpoint-ORIG-GUID: pTNY-RseEn253RON9MS8X1gdRtZhuFr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=623 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300121

Refactor the WBM idle ring buffer setup to scalable for inter device
multi-link operation.

v2:
 - Removed the dependency of the patch series "device group abstraction"
   and include tha dependent change "introduce the variable device_id" in
   this patch series itself

Karthikeyan Periyasamy (4):
  wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer
    manager
  wifi: ath12k: Refactor idle ring descriptor setup
  wifi: ath12k: Introduce device index
  wifi: ath12k: add multi device support for WBM idle ring buffer setup

 drivers/net/wireless/ath/ath12k/core.c  | 10 +++++++++
 drivers/net/wireless/ath/ath12k/core.h  |  1 +
 drivers/net/wireless/ath/ath12k/dp.c    | 27 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/dp.h    |  1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c |  5 +++--
 drivers/net/wireless/ath/ath12k/hal.c   |  5 +++--
 drivers/net/wireless/ath/ath12k/hal.h   | 21 ++++++++++---------
 drivers/net/wireless/ath/ath12k/qmi.c   |  4 ++--
 8 files changed, 55 insertions(+), 19 deletions(-)


base-commit: ec460f4384ea105f2998ca6b0d014db1cee336de
-- 
2.34.1


