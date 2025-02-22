Return-Path: <linux-wireless+bounces-19328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C4A4096D
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 16:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E806517AD58
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00A14037F;
	Sat, 22 Feb 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OCccN1Yi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E378F46
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237591; cv=none; b=MqR9qjVnrIKvMORm+h+1VGo04090OEUhprRqP8EOUHSFBbBxgdmATDFC144RwS96kKBb7EU+CAYnB+zWKQ7AUmmUE+cJ/DXFkVvKJ8iRuIq6VvzWWcLPIMJTLar1TcvjyXhg8cX0Nn057CVduSu3ZLyDb504sO9TVV2k7ussK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237591; c=relaxed/simple;
	bh=mEOG8Mns/F62n+HBGXmIjMGRcaeh030ULDySRiibrpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOsavbaldBwr79VUQHcKiKsEUuQFVHjDThd9CJr7h2w8kD8SyjfeOgfhiZZgn9bEatFJr8vRG6DVKoPptsDWyIzkiwOTgcAekDGa4t9RGSzR2xcBq9wHr+4x8LZntFU6/1i2mDd+5G6nm1wwjbqYyHSJPqHNqC09qukyoTqxTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OCccN1Yi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MCBZoJ024810;
	Sat, 22 Feb 2025 15:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pwW+ZpLzfVrv9qfWlB98Eb/CtnETl3ProiOYNHO7FKA=; b=OCccN1Yi8HASH3eE
	t6DaCFxrlOPDkD0M53hvpux7W9OnflC1sAvK8zcyhZICo7qllb/uXiozOnU6GtpE
	K2Xj14baVSHi9C41w8mkrNj1Dz9ehCqLgP5u+KqpKQFseLTpD3z4X8uTORgwzSoc
	L0USv8+9V8Mtjor7vQWUOVbpmUovocN2Q3JtBxk8NB3dxsSPuXi58fPtC1yBF7dX
	NP9GvUQZVnnO820VPU6T6EgxN3u8uxuwPvLgstoAJ7riyy356DofH2XJRbd5GC7A
	ETSwydJq7de/jpOUtMKyfaGqY5EmUgdYL7ruFu2zt8UtJPw1Wojnt9i2NViSFN/X
	yiMRyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5hrrxsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 15:19:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51MFJjO2020872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 15:19:45 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 22 Feb 2025 07:19:42 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v8 1/9] wifi: ath12k: fix link valid field initialization in the monitor Rx
Date: Sat, 22 Feb 2025 20:49:18 +0530
Message-ID: <20250222151926.379652-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222151926.379652-1-quic_periyasa@quicinc.com>
References: <20250222151926.379652-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: bRTSdlFTpJ79a8zNi4-NyyaqhUaxGJ4s
X-Proofpoint-GUID: bRTSdlFTpJ79a8zNi4-NyyaqhUaxGJ4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=802
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220122

From: Hari Chandrakanthan <quic_haric@quicinc.com>

Currently, the link_valid field is not initialized in the monitor Rx path.
This can result in random values for the link_valid and link_id leads to
undefined behaviour in mac80211. Therefore, initialize the link_valid
field in the monitor Rx path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d22800e89485..b1350e60e213 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1970,6 +1970,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
+	status->link_valid = 0;
+
 	if ((status->encoding == RX_ENC_HE) && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
 	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
 		he = skb_push(msdu, sizeof(known));
-- 
2.34.1


