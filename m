Return-Path: <linux-wireless+bounces-5765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF7895E67
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DF71C232E0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EFB15DBB5;
	Tue,  2 Apr 2024 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dwJp+tCW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5179DD4
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091955; cv=none; b=RjhFvOyD676Cr/39xYW5lIr1pDRpTKAy+AXIwNhy+srfug4dnsrcYSyiBJuaN68Iz3gpoYlP/v1HcnbqA5VXBX5E6YC/TevZdJI2LDyaxNNRNvUdEm53jL5jBan+cFnvzwfQOGPlkF8fn9Xhmf1fAaQbSxv4TOZNGKaGZEx0YV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091955; c=relaxed/simple;
	bh=tb5h11j5mBpiyRyGBkjSsF/1Oyq80nLKNE2QA7KPOOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8X7Wgukgmf1/hUDKftuZOqE+rbhVjUXfyvT7PP9B5IP6JIailTm1R0qAP7tEyw6aAe3Qg0pIUsnEx+iD8CFuIEFnWB9ycFVo9bwpqJF4YpSRUi05ngnfK+qbbMrytsTtCFh7oHNMTLnD90xk/PyeKHCGCuZROb9bmPeuKASQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dwJp+tCW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432KYYBO012476;
	Tue, 2 Apr 2024 21:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=QM3TW/fjiuQ1ShVfHv4u63kETVk73i4HMowuZTZofK0=; b=dw
	Jp+tCWPzmlvgdGkMrrTLIovxtofGyMNNMLql10r3GFMe4pq5YZMgIIjsD3xtCLuS
	Z6yQ/9OR17aclX1UJFR6Akahe/AGl/TqHpCf0SVWz004WWwvu2uX+9ELljbXf9CB
	OLK0aug5ghmIqCjy6xVawUd/5Be0J+dja2S+EelRrv8MCbu5LACltw3K2zt0gjtb
	HgTs0Xj0qGIFeQbvX3We211azAJvGAYxD2FKa6dOUitxUwJOZcMsolcNSlU8ji5l
	StAlzOxvrLRa1weZGm3A3wxQgCdylUsrEo2D81FulKsVUYvGxuwA7XAZw6vu5Vp7
	ej/8XU+gNXJ3BBFnyOow==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8huwhbtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 21:05:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432L5nZG000711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 21:05:49 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 14:05:49 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 3/9] wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
Date: Tue, 2 Apr 2024 14:05:32 -0700
Message-ID: <20240402210538.7308-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240402210538.7308-1-quic_alokad@quicinc.com>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JfAaVkXg3RED-PeyifHj-5UT5WsDPWYc
X-Proofpoint-ORIG-GUID: JfAaVkXg3RED-PeyifHj-5UT5WsDPWYc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 mlxlogscore=792 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020157

Rename trans_bssid to tx_vdev_bssid to make it similar to vdev_bssid.

Rename profile_num to nontx_profile_cnt, and profile_idx to
nontx_profile_idx which make it clear that these configurations
correspond to nontransmitted MBSSID profiles.

These members are currently unused in the driver.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 29e4aa2710c1..adc72c0f2862 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2745,9 +2745,9 @@ struct wmi_vdev_up_cmd {
 	__le32 vdev_id;
 	__le32 vdev_assoc_id;
 	struct ath12k_wmi_mac_addr_params vdev_bssid;
-	struct ath12k_wmi_mac_addr_params trans_bssid;
-	__le32 profile_idx;
-	__le32 profile_num;
+	struct ath12k_wmi_mac_addr_params tx_vdev_bssid;
+	__le32 nontx_profile_idx;
+	__le32 nontx_profile_cnt;
 } __packed;
 
 struct wmi_vdev_stop_cmd {
-- 
2.39.0


