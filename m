Return-Path: <linux-wireless+bounces-5696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22C893565
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 20:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5F1283AC1
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 18:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54B4688;
	Sun, 31 Mar 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oz9RfGWc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D162AE69
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909979; cv=none; b=dQXr72Got/mq0FOyZDSFLXfED0P04HYEhvjXdQv73QXZn0cySXAnFkRmUkR74GXMNxQDTgAj/eZ6I5fkqoTNBclH50r0FB0GsEKg02LC+XrIFmuEiGiTumLvOdPkbMYW/PpCn1PjINA1Z6u2oDDQ1bMHKb93B6ICcZ3C2wjH2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909979; c=relaxed/simple;
	bh=DYnp5d/UrENxwU6r1SwoyP4ZmGYJhhn32kI198DD8SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIHznVj2oh/sC1hGw7lZ2ACB0OP36nT+ANEEOc5cpzX4kSccDoPzP3ILnxFLqxKGl1xvv1fiJ2wthb0HBogVrIyTu2iBrVnaqd1XO4pegkIukJystyyZhOAOmHJXmckgagyE9d+r7cficd6EZviOzXc/teTIAD6Yn/S4dl2+Fxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oz9RfGWc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42VIWsmT004760;
	Sun, 31 Mar 2024 18:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=q93c9sBFJCr+/QZpXrD44ARUzrI3QNyDoaClgJ2Gp30=; b=oz
	9RfGWcAEPC/jHYX5d9lUB8QUubds3+ushwZg9Tfx/Aim854FyJJIaN9wDsPZ0F4D
	LSd7zEPP9PXcizcGmU9/QfCeVSSgBCnqGrsO80WOCuFg+SIFW4flLWUlNrEQDsM3
	xtb9/VZlE2THWg1WkdYFyhEqQq3vSjdlqK96Bxe7eC7IpQBfhVe7FrxjBtPBZ2PV
	J5Z5mzl6vD4W1boJRcqzjm1Bnfnf76nJu5ZpLa/+2yYP4fCbtmK3YWsupW/Rzrgk
	Lj/7a0zxYPqm99x3T8QxP+9QjTmzHc001DUwLbm+GkTgUCiQWtez6LQnpgIs/wBG
	kwmSTrnlTNzMn1TKFjeg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6aybadhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 18:32:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42VIWrrN022089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 18:32:53 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 31 Mar 2024 11:32:51 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: match WMI BSS chan info structure with firmware definition
Date: Mon, 1 Apr 2024 00:02:32 +0530
Message-ID: <20240331183232.2158756-3-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
References: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
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
X-Proofpoint-ORIG-GUID: vMg0IO-ZptBn5EVv2M52T1SsOWB7lGtF
X-Proofpoint-GUID: vMg0IO-ZptBn5EVv2M52T1SsOWB7lGtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403310142

From: P Praneesh <quic_ppranees@quicinc.com>

struct wmi_pdev_bss_chan_info_event is not similar to the firmware
struct definition, this will cause some random failures.

Fix by matching the struct wmi_pdev_bss_chan_info_event with the
firmware structure definition.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index f67e355ee202..96e8fb164bd4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4021,7 +4021,6 @@ struct wmi_vdev_stopped_event {
 } __packed;
 
 struct wmi_pdev_bss_chan_info_event {
-	__le32 pdev_id;
 	__le32 freq;	/* Units in MHz */
 	__le32 noise_floor;	/* units are dBm */
 	/* rx clear - how often the channel was unused */
@@ -4039,6 +4038,7 @@ struct wmi_pdev_bss_chan_info_event {
 	/*rx_cycle cnt for my bss in 64bits format */
 	__le32 rx_bss_cycle_count_low;
 	__le32 rx_bss_cycle_count_high;
+	__le32 pdev_id;
 } __packed;
 
 #define WMI_VDEV_INSTALL_KEY_COMPL_STATUS_SUCCESS 0
-- 
2.34.1


