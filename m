Return-Path: <linux-wireless+bounces-21779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BFA94B12
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1347A188B4D7
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDDC2566ED;
	Mon, 21 Apr 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EvDEmt6o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9C25743F
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202947; cv=none; b=rK7uWqzHj+R6vwL0Qu+pfq8zObgatbZ/Lql0h/i/1rcUmW6TIK8/Kp0cE2DhHWn1vN5VO7lnyoSY+Mpu9je8vkHYpSVocJTTU/SzyUjG3Iw5UYEtqmi75kAWPnVs6hAY65YrIl/K8gt+h0eSuUP0V5qidcYRsVU40t1Ims9xYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202947; c=relaxed/simple;
	bh=rLpO7Y8954n3j1upUWUFmlRfbkdQGCH4q0s1m7xa+5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfIlJGJKWq7VcRm2vcPhwwg/4nIY3o7b7dGw6OvXHhf9on0CQPaVheDoT8J8KaAkaQq41kfgg1cKfNemTS5/JcpYTX7zGgQACCg+DU8jeqtBZvDxKyhRh8JN7zS1gxIgAYIoBMZPiQTuDIgEI6iSMfanfwsqXOfb1tqp+upOGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EvDEmt6o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L0kIne011539
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Yfl978/6DVA
	zdrvKcsOLE0Dq28H4fccwkP87PFt/Ov4=; b=EvDEmt6oUkzko+S1fMV3gzZktTX
	a3AwTarE3VioM6083GmPUVafCqzJ8njkBrR1qpVn80GzI2rtJ+DQXM8pjbcNkPud
	f+POAiwAZB7Lq51Mx7JfzlxzX0/lOKPVofdhiMGFzx/qzZavh1qoVLapTP4315xd
	jbv18FnTWw8h9UE8XpAQf1XdMwsD0tbXPwzQFcKLJEgL7Yfwd2duVuy7Lf7+/Kg5
	bGpcmJ4yVOMhL0MMUkJvWeny+Inakh0yzt9+IOmU8bBehv9ZdK+w+e9L8nHpnxYq
	9QxP1aKVMnZc93a6KEUd+MOyg2uP1cHCT46ekRxVYRY7KduL9Nc/JiJNatA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46435jatpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso2882867a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202932; x=1745807732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yfl978/6DVAzdrvKcsOLE0Dq28H4fccwkP87PFt/Ov4=;
        b=Krmus6XES/vSARxmPglTsFKp/OkogOP/iH7PqB7o26FocI3ZDYEcT63wHdLo+w2GoE
         tPY1VbFIeUceGkOI3rmcTSn8baD3YeYMFVytoSkKIhdslwxHDTbXfmIQFfZi/0N59jgu
         RMAGsB5boP13DMYKgQRBZ6r7vQVfFEAEP2j65X8TCE/1aU1azQIoJm2QRaautPjC3QoR
         7fAYiFCNhS/QHntN4eixNcI7YFAsKhpemtA3GfFOO7fGR9yH133kKRbWZBJJIm1/fu+q
         RUY/qCACA0TBplnzWf5/ZoUMBJLfi4yA9nbgkfq/AVRkAk3DTNeAni6Y1J+nOLgqMs2u
         VKrw==
X-Gm-Message-State: AOJu0Yy4UxqTOeZzKGaPZ8aY4UGmMH+IjFsW1SFSuLnXFmS+WJVzEtBM
	YdQo56qu0mfgXCJWdUpTcNeds/hV2wz00971zBkxAUdBivcQxbqLcB3t7adS/aQeYGZzzQxoyRP
	hDwhVMxgFA4WuX8t8JLjhIN86M8Ikk9Uhi7U4R1WYU93wbVFyt0Xi7ZoM0t+fXsgRAw+Ud/eBPU
	32
X-Gm-Gg: ASbGncuvQnemIOdO0aOTV/m/3uHimbSNZfW9oJAwzdFdHvgr0hMuat+PGrJ3VDzu6I7
	uHxRToxMbNNgvTpfJQOvd+F5pv4OgTwkIKkDV3IHR2I1ozkx6qHip8Y4ngh7LNnhU7EoOsWkI2Y
	P9ZIsvYxdT4qDsy8dhwHLCpnJ8XZ3y80xCmCfSkTeEzjLY6AhHZds/0YRAF9w/YPlcPK9cfqeyw
	QX1RK3RTwtw1hTxiLcgpLubWwrIcTmfDQUsvkgWGa9GyRd0i6xLuHbqZQufusytDFtat476AzgM
	8Q96cFIcnP4lmFZrhesW2n7YxMZuh+eXU3aJm7a155+IM+y3Z8RMZp+LBMqPo9qIPJ/GDoMX4Zw
	g6y8ZbOPcDfs=
X-Received: by 2002:a17:90a:fc44:b0:2ff:5a9d:9390 with SMTP id 98e67ed59e1d1-3087bb4763bmr14940766a91.8.1745202932103;
        Sun, 20 Apr 2025 19:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWr31nrrw0P6zwG32PyGdkDtAxQr1SHu7NB4egaaypIx3/fAo+01+CCetoDxkqeJo7ekzaA==
X-Received: by 2002:a17:90a:fc44:b0:2ff:5a9d:9390 with SMTP id 98e67ed59e1d1-3087bb4763bmr14940748a91.8.1745202931688;
        Sun, 20 Apr 2025 19:35:31 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:31 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 08/13] wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
Date: Mon, 21 Apr 2025 10:34:39 +0800
Message-Id: <20250421023444.1778-9-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOYG00ZC c=1 sm=1 tr=0 ts=6805af01 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=kP4Qih6RMaO1GLBjTmAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: SQachWrUilBgkMggTVPRx4kCrauzWZs7
X-Proofpoint-ORIG-GUID: SQachWrUilBgkMggTVPRx4kCrauzWZs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=846 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Currently, HAL_RX_MSDU_PKT_LENGTH_GET uses u32_get_bits to obtain the
MSDU length from the MSDU description.

This is not right. Because all halphy descriptions are little endian.

So use le32_get_bits for HAL_RX_MSDU_PKT_LENGTH_GET.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal_desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 49eededbfa9d..c7a8b26d38a7 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -707,7 +707,7 @@ enum hal_rx_msdu_desc_reo_dest_ind {
 #define RX_MSDU_DESC_INFO0_DECAP_FORMAT		GENMASK(30, 29)
 
 #define HAL_RX_MSDU_PKT_LENGTH_GET(val)		\
-	(u32_get_bits((val), RX_MSDU_DESC_INFO0_MSDU_LENGTH))
+	(le32_get_bits((val), RX_MSDU_DESC_INFO0_MSDU_LENGTH))
 
 struct rx_msdu_desc {
 	__le32 info0;
-- 
2.34.1


