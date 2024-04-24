Return-Path: <linux-wireless+bounces-6777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63208B1347
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A531F22621
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468C61DA20;
	Wed, 24 Apr 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VByxvOsg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613A1CD24
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985921; cv=none; b=Qa47DSO22SYliCO4cVyhzsr+kaAUczTa9tHtuem4naOYvjEru9JTQ9UD7NrgRqwr1dJy37dnuDANpzCOAwp2HHMqHvQq/WzplInDHoF3C0ok3kpTAY9mrmh6bayHq19B4rM0piOUFw1htYyh9fZUu6oGQtf48schTFA+oRoQ5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985921; c=relaxed/simple;
	bh=jQhJGsexElwFK6Sf7sIRc6W4Y6pW36IZeHXEZbfIAXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IVIwQ1hk/Qab1X372MBF+qjqkHL1eoQzJsDJsymucFe29xwZEuu27KmdqS/7R06l/SBzW9t83tax1NgIbtiGRNzBO/Zl+SPMMr3TVDa66y7xDtFebh+lS/GHznXjzduDcH7MlIJekH/QyWSYU06dldLFI12+4EuBlOx/MikseNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VByxvOsg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OImS2R025850;
	Wed, 24 Apr 2024 19:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=vccEm5GZHn7/lUKe1XGobJEtL/5bQw8xLJ8nuKgzCCI=; b=VB
	yxvOsgTgJQLQJDAeNFQ8/+Ig5hx04xJHVR1io6a6wczIR+pTR+XEDcEbVSXkLsHX
	VtF9xdbmAYIWH+6UCksRDA2vK4UzGTe+CEPkCxvdRbrMzQIT5YYSFXe+ojIE4X9B
	9IBEXAczIh3f/t/+1QSoqxrbnqBzfPwsrcfAc3X7nKkuXXG/zOnQ+EslK8OLgbrA
	p4DjSbeN/VOKUZ8Wz5jsgj9Ygij0cbWhQD54NAHRotn9mQ1NSRkthdT18h+MdjD/
	YB7CDmkt+ubgOhUeG8adxbgD4aa3RZ2jhr9wCfOGFjr5XrIPT2tOPQzHQV4/A/Yz
	ZwW2UKbg3ZFvLk07ahjw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9g9yup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OJBp86017523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:51 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 12:11:51 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V3 0/6] bug fixes and enhancements to 6 GHz band support
Date: Wed, 24 Apr 2024 12:11:35 -0700
Message-ID: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MtN1EHjcx7TfURAlRRdxxB5vpWJQyYqC
X-Proofpoint-GUID: MtN1EHjcx7TfURAlRRdxxB5vpWJQyYqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_16,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240091

In 6 GHz band, add support for
1. channel 2.
2. Fix packet drop issues.
3. AMPDU aggregation
4. SMPS configuration

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v3:
 - address review comments for fixing ath12k-check issues.

changes in v2:
 - Disable smps for WCN7850 after review comment from Boachen
 - Added Tested-on tag for WCN7850

Pradeep Kumar Chitrapu (6):
  wifi: ath12k: add channel 2 into 6 GHz channel list
  wifi: ath12k: Correct 6 GHz frequency value in rx status
  wifi: ath12k: fix survey dump collection in 6 GHz
  wifi: ath12k: add 6 GHz params in peer assoc command
  wifi: ath12k: refactor smps configuration
  wifi: ath12k: support SMPS configuration for 6 GHz

 drivers/net/wireless/ath/ath12k/core.h  |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |   9 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 121 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.c   |  10 +-
 4 files changed, 117 insertions(+), 25 deletions(-)


base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717
-- 
2.17.1


