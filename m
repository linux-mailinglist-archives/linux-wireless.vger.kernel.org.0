Return-Path: <linux-wireless+bounces-1771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612AA82B9AB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780E31C2284A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 02:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB51846;
	Fri, 12 Jan 2024 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OdXQpRpo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3DC1841
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C1F4rD003584;
	Fri, 12 Jan 2024 02:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Vkv3f22
	WwdNMyawAcYNs3uiq3mQ8TRJ/XsgPC/7uhn0=; b=OdXQpRpoQ1hpMnjlWY0RkVK
	Qy3fyXT+fcoqM4DZUsy7B5Hx1omgTxZgsaEwAYtwElRAIll1jFyD8kdfOa2qxpnY
	ur3L7EUmLNOscAzPEfAwiGrwoxrbDPn7G3Geg+VfuP4oGHD8Cumqd4mA02MY+P86
	ZWpBrTAXdrJHHuaZt4jxc3bN7DaHMNP/zKuXxhLs7UQPqdPkAZfs8i3v+bwifWT9
	gWSoJGWJX+WwcexPmvPbIOr049FKjk+pRiXD7s7WIQjthTmZ2i9aBIE1/xPIqq1W
	BGTZ+MSgWZ2ebRzH/JldxmAhDDqAHY/72nWSwLI4Oc+YdO8Pp4NHpn7DF17OQnA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjgtjhmeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:42:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C2gU95025150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:42:30 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 18:42:28 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Introduce hw abstraction
Date: Fri, 12 Jan 2024 08:12:12 +0530
Message-ID: <20240112024214.3481840-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: gHJ20lrYE7-HIVMKfvHKoLdV_IrmmY5U
X-Proofpoint-ORIG-GUID: gHJ20lrYE7-HIVMKfvHKoLdV_IrmmY5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=290 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401120018

To support multi link operation (MLO), need to move from the multi wiphy
model to a single wiphy model. However, the single wiphy model allows
multiple link/radio to be exposed by the same mac80211 hw. So introduce
a new container (ath12k_hw) structure. This approach improves scalability
for future multi link operation support.

v2:
 - Rebased on pending branch as per jeff comments

Note: Raised on top of pending branch

Karthikeyan Periyasamy (2):
  wifi: ath12k: Refactor the mac80211 hw access from link/radio
  wifi: ath12k: Introduce the container for mac80211 hw

 drivers/net/wireless/ath/ath12k/core.c   | 108 +++--
 drivers/net/wireless/ath/ath12k/core.h   |  47 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   6 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 480 +++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h    |  14 +-
 drivers/net/wireless/ath/ath12k/reg.c    |   9 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  17 +-
 9 files changed, 510 insertions(+), 181 deletions(-)


base-commit: a34e613ed3e02337577b26e308067fb6c4700586
-- 
2.34.1


