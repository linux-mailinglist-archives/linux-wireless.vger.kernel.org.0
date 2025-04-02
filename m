Return-Path: <linux-wireless+bounces-21046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456CA78688
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A657A3409
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB631F5EA;
	Wed,  2 Apr 2025 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YfDLTDrq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E6645;
	Wed,  2 Apr 2025 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743561995; cv=none; b=oLY/bI7hKA451fmbBRQs3BnbFgzluHLoYDcrk2CBrGgjQI6ThVElEFMwLoETNRyNu9wCAS4XXiIbAmGJJakpyyPXGrArQsElkxZPy+r7ZuV03l4uYNmNM7nZoJYxrHl6f6kWnIRRaP0pZWNfhwh+Xl8VGBoAXUmHd0trtZ+Rk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743561995; c=relaxed/simple;
	bh=DFjoPJVa433yUGbfvRkgTxEuOvMLA5uQ2i/pw28UUiw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=F1ZCxxBXho/L0iGnB2uiie1TelyQiDAse1yJZKjQG5zj7yCxGYuaEE300k7OWTvSpyCg5M9PE0RDiae/nnSpP5ZfcPW+RSsuN2UZQE+zF2a/X5LgIJlarsl5saSJrqevgMKHi4koGPT7kCm8o/AdIXghz+PV7phcMDK7bO+D3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YfDLTDrq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532213px031799;
	Wed, 2 Apr 2025 02:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P8+J/WEXHW+N6WiJLt6Gva
	lwDYhhJHWId9EuIpA/f0o=; b=YfDLTDrq3iNhfG703pz4RWXrvxpMz3PuARarBL
	ZnqojapTJasxzku8/bBwL6xePI5imYv8DcbD7RZTKLv3cAo1kaPZS5UdTc7+NM8/
	DhrLf6F6ZIXNPOO8kAHyu27HJGxxCSz9+1298Sm5glUGpzttqegzNFVd7oIQKK29
	i6jloMK9BnIYqHy7oyPKgBx0usu2M1QIqOK86KxT/aYQwZelK9LvxfEiSicih3mC
	7+ilnNuHhCQU7uzwJS48Dl4shvsxdJYNEoGfeCuHT0VVxq5MP93Ql073k9zhyMHb
	mTX+Az73BunmsYJzCFQntmLn0+/b2Z2HB9xCfnDIIe9yA9FA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45qxa7vxcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kClk014104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:12 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:10 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next 0/9] wifi: ath12k: support MLO for WCN7850
Date: Wed, 2 Apr 2025 10:45:39 +0800
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANSk7GcC/43NwRKCIBgE4FdxOPc3CCnaqfdoOgj8JlOBAZKN4
 7vHeOvmcWdnv11IQG8wkHOxEI/JBONsDuWhIGro7B3B6JwJo6yinAno4lCyB3yUFU1F4fV0EKZ
 xdD6C7FFXLdMlbyXJwOixN/OGX0negcU5kltuBhOi89/tNYmt33OQBFCgdc+7lqIQWl7ek1HGq
 qNyrw1OzX6syVjXSn7iAmVZV//Yuq4/Tye5+R0BAAA=
X-Change-ID: 20250327-ath12k-wcn7850-mlo-support-bfed592d139b
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q8zWkXDUcknVGKTAxIoB5Q5Q2XAPtcLG
X-Proofpoint-GUID: Q8zWkXDUcknVGKTAxIoB5Q5Q2XAPtcLG
X-Authority-Analysis: v=2.4 cv=J9Oq7BnS c=1 sm=1 tr=0 ts=67eca4f4 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=S8qQzX23J8qjeTGorjwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=828 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020017

WCN7850 firmware uses API-1 so it can not advertise MLO support via
firmware IE, but instead it uses single_chip_mlo_support flag in QMI
message, the first three patches serve for this purpose.

Currently ml_arg->assoc_link flag is not set in
WMI_VDEV_START_REQUEST_CMDID, this result in WCN7850 firmware crash
in MLO case, so patch [04/9] sets it for assoc link.

Patch [05/9] makes sure we do assoc for assoc link before any other
links, as requested by WCN7850 firmware.

Patch [08/9] change to send REO queue configuration to firmware
for all links including non-primary link. For that purpose, preparation
is done in patch [06,07/9].

The last patch increases number of different channels to 2 for single
pdev device, to avoid failing in bringup the second link.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
Baochen Qiang (9):
      wifi: ath12k: introduce ath12k_fw_feature_supported()
      wifi: ath12k: use fw_features only when it is valid
      wifi: ath12k: support MLO as well if single_chip_mlo_support flag is set
      wifi: ath12k: identify assoc link vif in station mode
      wifi: ath12k: make assoc link associate first
      wifi: ath12k: group REO queue buffer parameters together
      wifi: ath12k: alloc REO queue per station
      wifi: ath12k: don't skip non-primary links for WCN7850
      wifi: ath12k: support 2 channels for single pdev device

 drivers/net/wireless/ath/ath12k/core.c  |  23 ++---
 drivers/net/wireless/ath/ath12k/core.h  |  15 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c | 178 ++++++++++++++++++--------------
 drivers/net/wireless/ath/ath12k/dp_rx.h |   4 +-
 drivers/net/wireless/ath/ath12k/fw.c    |   9 +-
 drivers/net/wireless/ath/ath12k/fw.h    |   3 +-
 drivers/net/wireless/ath/ath12k/hw.c    |   8 ++
 drivers/net/wireless/ath/ath12k/hw.h    |   3 +
 drivers/net/wireless/ath/ath12k/mac.c   |  62 ++++++++++-
 drivers/net/wireless/ath/ath12k/pci.c   |   4 +-
 drivers/net/wireless/ath/ath12k/qmi.c   |   6 +-
 11 files changed, 213 insertions(+), 102 deletions(-)
---
base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
change-id: 20250327-ath12k-wcn7850-mlo-support-bfed592d139b

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


