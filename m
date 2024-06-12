Return-Path: <linux-wireless+bounces-8905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787AF905F5D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 01:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BE81C218F8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 23:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371EC12D748;
	Wed, 12 Jun 2024 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IchG10Ui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386212D742
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235754; cv=none; b=n2zMc0lef2KsrOvKJ2G/D/TAgEd0i3+scQYwdtu7XE8NLy6TQ6bE+Gz5BlAF3ixKNEguuIPj+Nv2gqzdNIQYv3RyZyEV9JtuIRA1SeGDPfThykch/Ggp2B1zK2+8VjNn7zXjmjwQBSY1mpntupcFLwl98wfCHt3eiqFt6lsspas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235754; c=relaxed/simple;
	bh=Nyi0DLo0fDXprtffUx3+1A4xkU3GKC1TekyK4UxIpEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZJYL/tSSdPfL0gD+W0dya1/9NpasNMI+kjtzlgeEyr74tNsjsLKVmgiJmstmWXPY4PytGlvp9oPpdM3yhaxQi60R3zzJuyViLscmmSwnn1LCLUXtEM5JJEsBM9f3dUF9yO5upV9zvIBRkGZSR1jXEoNK/XNwAL2NtDowL/cyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IchG10Ui; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKnYBM028951;
	Wed, 12 Jun 2024 23:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XUbBpj+nMSusS3awk418CB
	s8tejBc5bXh122jjYbmbg=; b=IchG10Ui2GFMyiGyB5cY2TpfkW9aXuCNXnvMZG
	WTFVwTJf/SKsQXI6JRGDEhUfgacOnajZbWuruY2eQOtOkrI3YDHX/wWtkMdfYGAF
	6Tvgo/PLe2lH5SY8jugEbKVma8fQAsDAez4GfieaoXBuDUwneyKCce4p/VrVt20g
	zzYHiDW3pSc6pPZlOow4k4U1Yqt+AfrLk36RLpBr3XfazxOiLc/V+jni6BOVQLyY
	1yWWl0swa48Vw8ppOF/YypZS4ZSrdAFfAcwJWQPLWMIGqvzzjiTq4UFsabXxdyn4
	4d51Jqc6+j9aeY3+HI+83HAXy4WKX7udDXjEkAoTRKSyOVKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yq83whpj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 23:42:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CNgKbu032243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 23:42:20 GMT
Received: from pradeepc-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 16:42:20 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V7 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Wed, 12 Jun 2024 16:42:00 -0700
Message-ID: <20240612234209.2324181-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: EenoHkbUA-URoWnfwk7IAawZfnfTR91H
X-Proofpoint-ORIG-GUID: EenoHkbUA-URoWnfwk7IAawZfnfTR91H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_11,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120169

Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v7:
 - rebase and remove patch 01/10 which was merged already.

changes in v6:
 - Change comment in patch 01/10 to represent only AP mode
   implementation.

changes in v5:
 - Fix column length to 80 in patch 01/10
 - Fix advertises spelling in patch 09/10
 - Fix choosing spelling in patch 10/10

changes in v4:
 - Fix ath12k-check warnings in patch 2/10 and 7/10
 - remove "hostapd" reference in patches 2/10 and 3/10
 - remove redundant prerequisite-patch-id's in cover letter

changes in v3:
 - address review comments for fixing ath12k-check issues.

changes in v2:
 - Amend mac80211 patch description as the patch is not specific
   to AP mode.
 - Amend EHT MU-MIMO patch description to specify future support
   for STA mode.

Pradeep Kumar Chitrapu (9):
  wifi: ath12k: push HE MU-MIMO params to hardware
  wifi: ath12k: push EHT MU-MIMO params to hardware
  wifi: ath12k: move HE MCS mapper to a separate function
  wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
  wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
  wifi: ath12k: add support for setting fixed HE rate/GI/LTF
  wifi: ath12k: clean up 80P80 support
  wifi: ath12k: add support for 160 MHz bandwidth
  wifi: ath12k: add extended NSS bandwidth support for 160 MHz

 drivers/net/wireless/ath/ath12k/core.h |    2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 1052 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
 5 files changed, 985 insertions(+), 208 deletions(-)


base-commit: e72048809ec7355a947415ae6836d2eb7fdcda39
-- 
2.34.1


