Return-Path: <linux-wireless+bounces-19178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC6A3D31A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03123A3B31
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F81E8345;
	Thu, 20 Feb 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A8yULO4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591B1EB180
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039913; cv=none; b=oADTxTEMVAoJ2A2II2dBF/d/0n0XvVNr3ZVTNNvHhsx79PadbJSIodAcN1AAZaRqR2KoY2pTC9jNfu6hAB6N6766Ldh93ackLSEBtyb0ocCX6Q0ItULqEQNXqQydxmR0velC7RCEKKiyztKeJcT6hnqigLV2Ghx2gW4WOLWHVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039913; c=relaxed/simple;
	bh=+q4gEIzaw9DMFWZ8xEevzlCpGHrYnKsoVG2vyxDDXuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLXCwp16WYQjg/eimyUT/RgrIy/Psu6An+n+Zr7OKMG1nWkQGcpPFNXUf4sThwm6bNReEd7oHZk79k8ICLwVj71QG68srIZLno4vzxrqQYWg2rVpJAP4J23Q5rrbrvtM5PvAf9ZDHRnt2B/gLfUYpYRTTPQxqXxj3n2k5GDti/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A8yULO4F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6LlXk016798;
	Thu, 20 Feb 2025 08:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oz3HgytgUHf7WQWovv4GRdgKGoFgI9OllsigIayTQZk=; b=A8yULO4F2N6aPqKe
	g5leW3dhrUt4WwS9W6JUEdablIpi5JKNoREtw6B6RlhLL2EjXhaQKmn6Gxu+4eS2
	tVlcDlXlX7zuf8Ly5m/18bYZNgxiDR404Ll9zzzWOB9g5Gn79B0BcB1zNNtzDU48
	H2yenr8u53hm8oEZcSfgNiPDNZa3Wh5B0j6pN6zIFHVWywg8W3z+oNy1W0Iz4+3Q
	SXunc1wYNqbOWr7Zb4gISZJxgj52aNIvVf+WilUtkyCOYbP2sWbxhKUlCiatCgtb
	v0jlPt36M0fCncI7ZAizdhuKeOMxqLKWo2S1Xm2WbkDJKGq/sXUItlhcklf85QgW
	e5BfcA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0dc9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8P8OQ012287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:08 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 00:25:06 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 5/7] wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
Date: Thu, 20 Feb 2025 16:24:46 +0800
Message-ID: <20250220082448.31039-6-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220082448.31039-1-quic_bqiang@quicinc.com>
References: <20250220082448.31039-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: nLobVpA6JNqgZ8THVlOnrvU3C3ks4fpz
X-Proofpoint-ORIG-GUID: nLobVpA6JNqgZ8THVlOnrvU3C3ks4fpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200060

Currently RCU lock and ar->data_lock are acquired in a sequence of

	rcu_read_lock()
	spin_lock_bh(&ar->data_lock)

but released in a sequence of

	rcu_read_unlock()
	spin_unlock_bh(&ar->data_lock)

Although there are no apparent issues with this, reorder them to
achieve symmetry.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 98811726d33b..56af2e9634f4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8238,8 +8238,8 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 
 complete:
 	complete(&ar->fw_stats_complete);
-	rcu_read_unlock();
 	spin_unlock_bh(&ar->data_lock);
+	rcu_read_unlock();
 
 	/* Since the stats's pdev, vdev and beacon list are spliced and reinitialised
 	 * at this point, no need to free the individual list.
-- 
2.25.1


