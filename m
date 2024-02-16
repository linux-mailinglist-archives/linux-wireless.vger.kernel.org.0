Return-Path: <linux-wireless+bounces-3676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A9857F74
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84206282C8C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1115B1E1;
	Fri, 16 Feb 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UVgABmt6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B912EBC2
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094382; cv=none; b=helnuOPhQjW/T4IptuhDKtt8DUOEoAL7sxvTnNxHQVUWTKhxlUw7ZbcnaaQoLAeuQJstqP/zTq7T+p2sbguFstLPl7FdxWtQibhmvOQl519hWUVFj8tCtkK7uSsUZ3ZJIkG7tOHYvGTKm40xdifsP4eTQX7b9iz9Smptmu3jcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094382; c=relaxed/simple;
	bh=/q3qN3OyXAMpaKOEDmaS1u3lKiVRkrHlQyPP2ZhkPFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qn3ZjY1GnYgI8Ng2yXnicNs1oC/Fc2+cPFFroh2wkQ0AbU7itItp7dQptDSQ6jXkAeoos0sCDFe/X+SO0MFZYt/0xuv50Fru3iKZI7kwfUmfxL6vQ7wBNe+KYN+s7uZiF6tqzr12PRkZuEsMI/D/pXZLD3OWJMMhmSnjG1qac+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UVgABmt6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GEb1vv003662;
	Fri, 16 Feb 2024 14:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=iDSAo3w
	TH29UON1dokt4uvNKSX7l8dcI/cy/9pWJ9jg=; b=UVgABmt6Zg4SwoZe918IVXa
	OC4v1+bELBIQHS+RcZiVLwksyOIoOPreM9t3L5zig0lLYnJTm5aEeiUN7fQ8HvyS
	HvIb8cPMZnFrBHucbDw3EAXVbd70LuZxZ1P2itCpRCdr8B9cruDSf6YP9sNiJ+H+
	lm8PtAeNK+ygKoAAho2V5gS1+oXS0KPYclEbZF1SEAgh4HR3yyNkXl//X4dAl5Dq
	uEVUiy775UsrEQbh9UD1+DJ4fo12NPZ2Ej+9XNR2CK70YKAXEXi5B8NSeurhnNYe
	0C4alKwYA88hnr4qAzens3iYp9PdqT2EriQJGPqgmBAMXHe9aaculY6GdrcYlmA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9bfs47vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:39:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GEdZZC001720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:39:35 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 06:39:33 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 0/2] wifi: mac80211/mac80211_hwsim: support MLO CSA test case
Date: Fri, 16 Feb 2024 20:09:16 +0530
Message-ID: <20240216143918.514140-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: vzyuWP_WIV3m0rFUipl6kpouVLaG2I48
X-Proofpoint-GUID: vzyuWP_WIV3m0rFUipl6kpouVLaG2I48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=956
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160117

Recently MLO CSA is enabled on the stack. Add test infra support in
mac80211_hwsim in order to support basic MLO CSA test case.

Aditya Kumar Singh (2):
  wifi: mac80211: check beacon countdown is complete on per link basis
  wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
---
v2: handled all mode cases of channel contexts in [2/2]

---
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |  2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +--
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c | 35 +++++++++++++++++--
 include/net/mac80211.h                        |  4 ++-
 net/mac80211/tx.c                             | 14 ++++++--
 12 files changed, 58 insertions(+), 15 deletions(-)


base-commit: 42ffccd0a36e099dea3d3272c5d62a0454ded1f0
-- 
2.25.1


