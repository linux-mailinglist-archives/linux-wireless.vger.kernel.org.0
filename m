Return-Path: <linux-wireless+bounces-25271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE03B01C6C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2951C28E60
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696A1DFCB;
	Fri, 11 Jul 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U++QESSJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392D3209
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238514; cv=none; b=AZLPqbtJGA5QWsY/3XF2VZ/fyoWsfOWc3TyK8xwXihHoiVpts0DRzjbaWlu5yOxnrQodCoK2/VKkdw5y3HFE6AHSPpiBZEcDtVxUYbBRqS/knfi+adIcVVBLXCwtOr40aW1JiED4+i9T+M7V4/V1XAnuoqfGvnIxcUWQRKmqVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238514; c=relaxed/simple;
	bh=JZe2rgQbdbnZsrrI26ptmYgAGCYj6kAADGCXRBZCvuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MswFFty9hpGayJeWTXtKGvseh/W7DYnDzC+lDWwEI0Moj4qOUfLHfGwxvPKUHFGEBIcmi4Lm/UCOYbtE2ZsQ3PVBZ8+Oicq75mWFS3HpsVemUsDYfpwIIzlrkFl7neBb7HuUUiF2ztmPuB37qj5iTBSz8R8QnvH6It+XENEjd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U++QESSJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BALjec008497
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 12:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1q9Fv4tG0fWETsk1VpsF/yNtAzh6//bIa8M
	6llAcnx8=; b=U++QESSJNLKPPoWz+BbBh2M5kvpGEg9QpfGEabV/47L9te2J0bm
	WCuc7LUfxBMtDjHgfOVGC1Gr1yBXlOAYsmOOtIlh0aGdtTEnVZWLffaa2bIIhvIk
	GuNwa6EjMjC4GImsrDERmUuUDQCgD8r/k1WbYfMUYK0zU+GgeXhXUrTYGC9H0Rxs
	WSUiKbiDjNx+U/c+OmWgEoHhKQhOJ19VAi178RfyipJeRVLtEUaZN0BMdNdfv/jf
	UDF3UYQ0+SkV8KH7+UPO5zAx6meuhVuLwt1DZFXN1XQutGfWIJDuq7kp9wzjGgpU
	VD1zt1MfRYfTX8/TGcUhb4ShamNnA1odxdQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg8kkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 12:55:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235fd69438cso4722325ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238508; x=1752843308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1q9Fv4tG0fWETsk1VpsF/yNtAzh6//bIa8M6llAcnx8=;
        b=qQwEjRWLDMtxtIX7HIsI3yV/g1K5P/Sq90QvCrceH+kvM1pLXXjfXcz/xyJPnGzHUq
         cWaFjWY8P0xXOnc/S8/FVFnFlVcVuXX8mxsbZ1Ux5Oyl/DiHjJMEgVQH8k9vvrrjySrh
         IApzUN355ZCDT0lS9YOvXGEPh2sHz/D7wy0W4luJ9GvNQjECOZ0Eq8eonva22zPkPLyr
         Rk9FcbS6zUchLvrtkbvhR0Xu6QexztLlLzgE2izsv2Xqqo8yBYMWk2tkcpolh16inp46
         iPsw9cM3Nai3DxRweH06xD9SGSPMIjGryv7K18Hz82qHzf8Vgxp7yCMRYOuZHkUbkQ45
         FxFw==
X-Gm-Message-State: AOJu0Yzt7KCeo9R/Uscz1FF82F96hZ0mnh7eY2mBs92gLnc5Hu9x8n2r
	Yao8caPqOPgT/Xgw2FD/PrNjsMSHuwA3PZ3bWmsUn8zrUbYrtIsX7wuJl6AxeBLSr+K6JPRHCe6
	dXDJ/EyVBF4bs+iG+ohombsoE+tb0Eqrhon7IRcIZDqKFX/Xj/wE1KpNdFwf8iogeTwYTBA==
X-Gm-Gg: ASbGncsT+Dw0bY0Hhn9R+Cislt4bSRsIwxMBEDwUMdZ8gOCEFe1zqJDvdxMKL7a95C1
	8K0miKIDBLxtCMyV4eZH3Pr3M+hBUFyG5bf9b92tSL85HpCqVRlFCAbNQRBmIdOvICrHpOtkoX9
	ZKSSOEK2cGSHeP+DysEElEK2aoElpvtYbuDoABsKMwE/Xo65idGhTM+7p0MhItUA8OLSemK+uPv
	/xn2U1IECLrDO+fcxWNWk1gJl+MwrEE3GAVI/kguaLa3W1BpupSQwGQbO+nlPKsKWxFf1PofH2S
	id5KFiMphbjwnjl7Tzr1jGbXDn2kA9tpS5pTOZUXfnU95QdyahgjaFSxkiOfUnYnoIDVbfC5tfG
	/mmUTtB5qG7ejWO2RXWzLW6psBPNoV/nFk9mWNGfxCiR1K52HWChx+d7vXysh9A==
X-Received: by 2002:a17:903:1c9:b0:234:c8f6:1b09 with SMTP id d9443c01a7336-23dede84f28mr15016255ad.9.1752238507804;
        Fri, 11 Jul 2025 05:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXJZulD7GXkrZ8YJrGnWfeNt32cIteJnhhsEZAOeQ4GeCt+0MyuG/l0p1Pm7Nj586ode+JVQ==
X-Received: by 2002:a17:903:1c9:b0:234:c8f6:1b09 with SMTP id d9443c01a7336-23dede84f28mr15016115ad.9.1752238507334;
        Fri, 11 Jul 2025 05:55:07 -0700 (PDT)
Received: from hu-nmaran-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434141fsm46542225ad.168.2025.07.11.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:55:07 -0700 (PDT)
From: Nagarajan Maran <nagarajan.maran@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>,
        Nagarajan Maran <nmaran@qti.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Validate peer_id before searching for peer
Date: Fri, 11 Jul 2025 18:24:54 +0530
Message-Id: <20250711125454.1549124-1-nagarajan.maran@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=687109ae cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=0KvMerAzGZTWNi1JVVAA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qB-RmYX60yfkc2URsoxZconZ0mbUVgEi
X-Proofpoint-GUID: qB-RmYX60yfkc2URsoxZconZ0mbUVgEi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5MSBTYWx0ZWRfX8AwbzPj7G1gV
 FdnLcbthKXJRQBVc9K8ImEWQbhacV3WE/u+Vzag0ARsVUJIwjP7VT+G3AIm9BGfILYYH9iNHcu5
 qg9O8eDJZBJvQRlrbmW25n11JjZ22Dg2dFgw88LqMZl/CCJ9Ju3j8P6D/R8pRGHzu4B0ynHK9nS
 /gE9DdXdjWYSpaLmgT5lHlCtXNQiYEcYFY1/6ZcA627qxM97jAiTpKfV0ONlE5JZHMIzq4mUyfl
 qVtt+49O8TUdExZyPX2/BAWi85yQZvU3RsAAovzfbShVBZrfl+zXdSCnn2wO8ld5oW26F7pE/ts
 DBTdNky6zKKOeNRzAVouVlrskPXE8uyZNjdGIFToRBAxReoi4Z6lNj52tA1q6aq6X4eTBwfD7r+
 PlnQYwya7W4QHf6fRhN0N3aMluy/JOlqQl0zc8QyCOc2OYKtlYFhKzs5N99XNWqLmOlIdeJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 adultscore=0 mlxlogscore=741 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110091

From: Sriram R <quic_srirrama@quicinc.com>

In RX WBM error path, error packet is received with invalid
peer_id (0x3FFF) as there is no peer associated with that packet.
However, this invalid peer_id coincides with the ML peer_id valid
bit mask, causing an unnecessary search in the ML peer list.

Prevent searching the peer list for invalid peer_id and return NULL.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Nagarajan Maran <nmaran@qti.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/peer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index ec7236bbccc0..1a098cb22933 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -100,6 +100,9 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 
 	lockdep_assert_held(&ab->base_lock);
 
+	if (peer_id == HAL_INVALID_PEERID)
+		return NULL;
+
 	if (peer_id & ATH12K_PEER_ML_ID_VALID)
 		return ath12k_peer_find_by_ml_id(ab, peer_id);
 

base-commit: 3a6df1678acc3687d49ce94e23df7b6a289f27f9
-- 
2.34.1


