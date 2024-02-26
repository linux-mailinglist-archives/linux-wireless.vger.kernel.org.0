Return-Path: <linux-wireless+bounces-3989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB18669D5
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 07:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE431C21052
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB181BC31;
	Mon, 26 Feb 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DM22J6t/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053071BC2A
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927369; cv=none; b=Uz6D2NYaFclus9qIiTkCa0FHOukOhfxpcVidwzuyoNKW+36Q3VEq2TCTosGF5mZJOhvRTvX6jngvF0ceGC4OrQTqT903B1mZBzpbvkGPC8aM3/kSHepQQJKkUrmJmGH20ZKN9lL5TCvwSTGmNGHAD4RDWM+Y12lPBH6/urfIvzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927369; c=relaxed/simple;
	bh=aV50oWH+AmU0TnuYTcFwc56wPXDi4TMgr0UR6kU4MnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONQyBWYGm/gdv5YaY/mUCSUG8KN2eksga4RCkyggkQdwuH52iq8rJZit6sSPwDd8zloWVRb/dhpr8BXQilWzcSjx9cnZwAwGmvHHusQ02+sBsGuqo2C9j7nauQ2UiI+ZNwvX5JW9wf4dIIvJplwf48dVHFAVnYAezgrDMM06rmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DM22J6t/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5dMrB010485;
	Mon, 26 Feb 2024 06:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=/n4Vmu7yqI31H537t7ME1ZRnjFAAroMBD5CJY+scAus=; b=DM
	22J6t/WkzbKkFti+K8CCq/HfkhJngLpmkbVGbm5u2yEBEjSaUx4p4LxhC4JVePdW
	6ObEMOlBX/MVPTyFhGbM7UvbZrSwIn9CSsG+3PZTQVo+o64sxCKJ9ft+RSLPsj/M
	waMq4z5ktvzrTI53HiP8fArr6P1sntI80DIhA13xhmleCsiqFyjFcNtqSU9SHMrH
	TZUAQYnaxnKLQj8FRFjtAkfAC82Pr23JMwM/LKF8XC6o+XyLudBsnCJIJJZw0BJo
	9AlMInM5AXLiTOiFiZhRNVKdHuo3Z8n8pj1zo2WBoezPKKAPVGZYEaTbTNBQ6je2
	HoYcBPwFLfSg3umcPQgw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxkr3n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q62REf013429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:27 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 25 Feb 2024 22:02:26 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 5/6] wifi: ath11k: invert scan flag WMI_SCAN_FILTER_PROBE_REQ for QCA6390/WCN6855/QCA2066
Date: Mon, 26 Feb 2024 14:02:02 +0800
Message-ID: <20240226060203.2040444-6-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: aSYOp4UxCZ7MVFuf6AQJpU6BHuL_9UVH
X-Proofpoint-GUID: aSYOp4UxCZ7MVFuf6AQJpU6BHuL_9UVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=798 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260044

Current ROC scan will filter probe request. But probe request is
necessary for P2P mode. A P2P device cannot be discovered by others if
it doesn't respond to others' probe request.

So invert scan flag WMI_SCAN_FILTER_PROBE_REQ for
QCA6390/WCN6855/QCA2066.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index bbccddd7d729..1dd0cbdda199 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2317,6 +2317,9 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	ether_addr_copy(cmd->mac_addr.addr, params->mac_addr.addr);
 	ether_addr_copy(cmd->mac_mask.addr, params->mac_mask.addr);
 
+	if (ar->ab->hw_params.single_pdev_only)
+		cmd->scan_ctrl_flags ^=  WMI_SCAN_FILTER_PROBE_REQ;
+
 	ptr += sizeof(*cmd);
 
 	len = params->num_chan * sizeof(u32);
-- 
2.34.1


