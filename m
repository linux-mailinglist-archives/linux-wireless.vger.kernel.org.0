Return-Path: <linux-wireless+bounces-21695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F29A9302C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5655F8E332C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221D267B14;
	Fri, 18 Apr 2025 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MTZx+gTt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFF24B26;
	Fri, 18 Apr 2025 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944968; cv=none; b=tWOhFQWJo8fGAjEU/fEzSKfhQfxWjurgjPV8odvoE8bKU0mDz0DlvqZy8upPFMU8GyWvF4CVUKk/kGDqYhO0omn0ILBSwZFzdEdu2TDsV6jgiIuLc+BVpqO1zyGT+OTZmAce1+y43gETf2TfjtXhSGYM9I29BE1JuyCwKrsWQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944968; c=relaxed/simple;
	bh=tQnZteQl1pfaBMAgKXndHdLsQoG7aEDY3mRR86O5cj4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=UcURPxLRGdHP6LvovimX0n3B6TboGUa94v1peeUO6aOtbE1fOSRLPE94FquQJ3I+OnfyvndiGSWHchc/CHaXm61Ii7Q6B3aNRi/hV7MhS3meqOY7CborOvvW362cjvyxiT4FdBCbox6zVCo7d6SfYNT4OXyDSir1mCD0fxPqsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MTZx+gTt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HMvAeA013110;
	Fri, 18 Apr 2025 02:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P+I4ipXDKRk9aGZXMixIRi
	cxc8JYFb5j/GIgL6xvM0M=; b=MTZx+gTt+aOj3A1esOTUB1qzlyVbW6v6fjg3/j
	2yhWYIME3dIo635pLqLsOz+KAXG7quQIs1xzx0oRFIqa8wwpK0hDZXnpTs8VBHwc
	i/jrnP2koS2I/VMtsppTkxKTFjxnONj3cPvz0uKOCTiAM51SBMMlAps20bXFh86n
	Js+Z/Af/cycxznXMppM6PSYZlQogt+8fPqxt/Uh0ZJW1vhLRGznqjkhKYGHbSSbi
	SzSIUtuL+8FdFynRyLh5KTRv12ICghH8m7UpI4R+1lwFIbprPkHOlBtPm1ebe/We
	vpELDG1daoMCFQnI7zGHpAtI9W/uJP7KVb1pjxQSDlkm60ag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqh1hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:55:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2ttT4000655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:55:55 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:55:53 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next 00/15] wifi: ath12k: add support for 6 GHz station
 for various modes : LPI, SP and VLP
Date: Fri, 18 Apr 2025 10:55:33 +0800
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACW/AWgC/4XNTQ6CMBAF4KuQrq1ph/LnynsYF2VooVELAjYYw
 t2dEBcaTFzM4mXefDOzwfTODOwQzaw3wQ2u9RTkLmLYaF8b7irKDAQkQgnJ9dhIuPC05teOBxq
 rQZeAGaZJxeis641100qeGLW5N9PIzrRp3DC2/XP9FbJ1/2Zhy4aMCy4tpJDIVOelOt4fDp3HP
 ba3lQv5PyInwlpVlYJKaOMtUXwQMvlBFETESuegEIuq1N/EsiwvaFDuBkIBAAA=
X-Change-ID: 20250401-ath12k-6g-lp-vlp-fa2ab2c7c65d
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5NZudpcb2xx0__Y_sZuGT4uvX6Kpt2gC
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=6801bf3c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=l_BK76kwmV097mJrsh0A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5NZudpcb2xx0__Y_sZuGT4uvX6Kpt2gC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

Currently for 6 GHz reg rules from WMI_REG_CHAN_LIST_CC_EXT_EVENTID event,
host chooses low power indoor type rule regardless of interface type or AP's
power type, which is not correct. This series change to choose proper rule
based on interface type and AP's power type.

When connecting to a 6 GHz AP, currently host sends power settings to firmware
over WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G commands.
Actually there is a new command WMI_VDEV_SET_TPC_POWER_CMDID with which host
can send more detailed parameter than with those two. So add support for this
interface.

Before above changes, some fix and refactor are done to do some preparation
for following patches.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
---
Baochen Qiang (15):
      wifi: ath12k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: refactor ath12k_reg_chan_list_event()
      wifi: ath12k: refactor ath12k_reg_build_regd()
      wifi: ath12k: add support to select 6 GHz regulatory type
      wifi: ath12k: move reg info handling outside
      wifi: ath12k: store reg info for later use
      wifi: ath12k: determine interface mode in _op_add_interface()
      wifi: ath12k: update regulatory rules when interface added
      wifi: ath12k: update regulatory rules when connection established
      wifi: ath12k: save power spectral density(PSD) of regulatory rule
      wifi: ath12k: add parse of transmit power envelope element
      wifi: ath12k: save max transmit power in vdev start response event from firmware
      wifi: ath12k: fill parameters for vdev set TPC power WMI command
      wifi: ath12k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      wifi: ath12k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz

 drivers/net/wireless/ath/ath12k/core.h |   6 +
 drivers/net/wireless/ath/ath12k/mac.c  | 527 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h  |  43 +++
 drivers/net/wireless/ath/ath12k/reg.c  | 209 +++++++++++--
 drivers/net/wireless/ath/ath12k/reg.h  |  18 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 198 +++++++------
 drivers/net/wireless/ath/ath12k/wmi.h  |  62 ++++
 7 files changed, 905 insertions(+), 158 deletions(-)
---
base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
change-id: 20250401-ath12k-6g-lp-vlp-fa2ab2c7c65d

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


