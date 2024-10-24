Return-Path: <linux-wireless+bounces-14437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700069AD8ED
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 02:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2615C1F22692
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC649848C;
	Thu, 24 Oct 2024 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aJCxys0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA079CD;
	Thu, 24 Oct 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729591; cv=none; b=ilY3dtenK7Y2z8Rq6gIhkYl5PrJr58I7kzzNm+q0vkMmuwTfngQceqXsNnIq6jYeO6jkX8hwe32GsOengMw2CB6OwxnB5r1I7jzFPmfCvFM0swuw2Zjm4drNezYYBYF3E1egyCEqI14jiDrNST4Ly7+K6wGeUHbz3gpzdqGEwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729591; c=relaxed/simple;
	bh=N50ZQr4UI2FkUci7BJLOsdnNoEBca6hfIAg+HgBIZMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aVpVT6mWyYnBGLn3HmX9y9LLOM8bjEVbcbnydZ+36gVjzSZuLjqs0T/VDufikv1+R4NPR4HdjAWoAHBwrOp+Jw94PwQSiLcFevUtco4MUZBnAdGfaw+gyJNDEFFSd48eDOOWfYCvRakl3USupegs7Mz9YiVXfyXiI9y1rHOBjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aJCxys0g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKGKPJ016165;
	Thu, 24 Oct 2024 00:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Psowjo8/4dp9MRXeqNJ9ul
	yPSJmjyL5Q08XlY52RyAc=; b=aJCxys0g8mF/5N1//6KmHz9BOdXV/Ho+zLdGzb
	wCz0/io1IePpJMpOLmJ3zCj0Oram77D1YNTOzwC45QNgiFlVk5XRFKhcGn89aHqa
	X59LCBvwipXY9dmBFkQHs6OmDwzG2xpmqqmY3mS2fO8kj0lF6pC9f00LaDaz2NS5
	vbF/uGqG1xrl9XnkEGDFyDV0Fjr4kMqdQ5tWMs4RFHLS9FthFPQdMhmxvXah+8jA
	iWWldcpdKDZxTUk78pjz2n1MId+r1sNzIjpGGXrnOTS0wLnXNR75KPdIOxXKf24z
	MIM2n8eYFcIsRdpQ1UY9Sq3/A2MiZ+fg2HZ86Kwe8nYiE0iA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3xkuhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 00:26:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49O0QMpp007695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 00:26:22 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 17:26:20 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath11k: support board-specific firmware overrides
Date: Thu, 24 Oct 2024 08:25:12 +0800
Message-ID: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: jr6hqZDUCg8WCYMd0s60UBj7R6yoImY0
X-Proofpoint-ORIG-GUID: jr6hqZDUCg8WCYMd0s60UBj7R6yoImY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=809 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240000

QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
IPA, thermal, RAM size and etc, so new firmware files used. This change
allows board DT files to override the subdir of the firmware directory
used to lookup the amss.bin and m3.bin.

For example:

- ath11k/WCN6855/hw2.1/amss.bin,
  ath11k/WCN6855/hw2.1/m3.bin: main firmware files, used by default

- ath11k/WCN6855/hw2.1/qca6698aq/amss.bin,
  ath11k/WCN6855/hw2.1/qca6698aq/m3.bin

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
v2: follow the approach that has been defined in the commit
5abf259772df ("wifi: ath10k: support board-specific firmware
overrides").
---

Miaoqing Pan (2):
  dt-bindings: net: wireless: ath11k-pci: add firmware-name property
  wifi: ath11k: support board-specific firmware overrides

 .../bindings/net/wireless/qcom,ath11k-pci.yaml   |  7 +++++++
 drivers/net/wireless/ath/ath11k/core.c           | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h           | 11 +++--------
 3 files changed, 26 insertions(+), 8 deletions(-)


base-commit: cd8aa3af7491a1f7a5b81e53dbe62a38433c2d4b
-- 
2.25.1


