Return-Path: <linux-wireless+bounces-2114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB20830ACD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 17:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4945EB265DA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5F22327;
	Wed, 17 Jan 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fHYyFIeG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BC23759
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508115; cv=none; b=lNV5TsqGDI1aaeGVRNrdLKb2Dv2XZSJvmuJp+7m9dyTBh++/YUjsFhIgTcufKjhS63Tjz24r2xRvM+NBJmrVBeqTOkLBjfKmZ39qF+I+UKB65Xgb37RoT+C7kVsGZRIacaqEwvIjcnji7jTvfQRTEWPoqVLtfxdRlnd7TOBHQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508115; c=relaxed/simple;
	bh=m5FYNQenOal+k+ZU6/yocokInaKymnFci2xpuexzBow=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=t2ot7QCQQVnHNkFc+NqgfbDQT0ZfvGPQ60tsHGGDaHq3c6wrz6PnCgvoNTyMywS8izVybOvQwFAL4rZ/Lz6/Y4ncvDuWCjva3HC4qCR4tJ2kkdTA0MKB/k6YQKAm+/XK3oi/dt5jj/OTkuIuGiWVEmdOIRxriDmPGPTcpnK/lNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fHYyFIeG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H6ruSu008994;
	Wed, 17 Jan 2024 16:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=3jNSHEb
	HDuB8mX0lfnbxG1riGiObzzJD/w3kWjmhqi0=; b=fHYyFIeGPGY8bmVNLLRrRne
	m4w+QuRkYzv6UtRirda6D0qXtzuwv55xDjaC4JRUOUEF9vGo6Vn0+jQkS7xNK7+z
	dzcDbD0rQCRafkHBZGhpBun8/CzEDnVmWzJHTkDY/g4Tmg50+8ZppjZkkUUkPDBu
	oAQbSlQbYtWy8RFb2ca1kK7MHcIQo/lN+LHFj///DncXZEMlmQPGoso2SqW7e/tr
	37gvJw9gH/EKrsCpMfXRmSsluxSD68LPATtpvvD2fU6F75yjLg1zdv6U+/DL1WX3
	RpYiL+wTILghEgreLC2pkaViNPkWjsR1eoO7sxZoPUQ5dGfko+MJUBSrBRuBQxA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpa1es63v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 16:15:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HGF7sO009856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 16:15:07 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 08:15:06 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath12k: Introduce hw abstraction
Date: Wed, 17 Jan 2024 21:44:49 +0530
Message-ID: <20240117161451.3385227-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 0ffJanL2cLcTlwcKCMgB2qQBDffgIjv8
X-Proofpoint-ORIG-GUID: 0ffJanL2cLcTlwcKCMgB2qQBDffgIjv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=329 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170117

To support multi link operation (MLO), need to move from the multi wiphy
model to a single wiphy model. However, the single wiphy model allows
multiple link/radio to be exposed by the same mac80211 hw. So introduce
a new container (ath12k_hw) structure. This approach improves scalability
for future multi link operation support.

v3:
 - Removed (struct ath12k_hw::conf_mutex) as per kalle comment
 - Rebased on master branch
v2:
 - Rebased on pending branch as per jeff comments

Karthikeyan Periyasamy (2):
  wifi: ath12k: Refactor the mac80211 hw access from link/radio
  wifi: ath12k: Introduce the container for mac80211 hw

 drivers/net/wireless/ath/ath12k/core.c   |  18 +-
 drivers/net/wireless/ath/ath12k/core.h   |  42 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   6 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 460 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h    |   4 +-
 drivers/net/wireless/ath/ath12k/reg.c    |   9 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  17 +-
 9 files changed, 391 insertions(+), 175 deletions(-)


base-commit: 03a67f8046dadb966950a0a6acbac2839cddfeb1
-- 
2.34.1


