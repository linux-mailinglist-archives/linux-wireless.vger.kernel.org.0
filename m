Return-Path: <linux-wireless+bounces-25843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE2B0D694
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2997418948E7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A813FFD;
	Tue, 22 Jul 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l377SriC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086122E266E
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178388; cv=none; b=fHKx0ac3ZLOLof1w4Ua7TKTahFghOl8NTf/wu2bR/syL9YLuZhmodFi5nY+qjsi8YkYHbKuaAt3laGvkeBPVmXKSWve+ddeHac/7pYx2BQ2vYqmJ4ekhBei9F20OpxHFNLs5pIoh0+dTghcRZeOb6e39JYvO27j0NZTdWbgMEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178388; c=relaxed/simple;
	bh=g4zcYHDGfE8dhSMfeyd9ZluXD+fgzxxg5s74+j+EIFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vk9iXF2r24B6wNXncLdQ+W/EvCER8MgnQitqXcsVZ4QLb/Nz3igfRuthTSJzS+bDMCicbZJy7992ERsNQV/EpVa/NgNPKKv4WQT/3TVnL9JjlJZrBXW0Xzl5ozNxZn8NM/9u5FZjWQjeIqjUTYEKRBzQsqjivCY78zlY/Bi7OTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l377SriC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7NKgd012287
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1ZMDuKP7h3626TyycBatNbgqTtgdtOYqWeL
	oCfMOJHo=; b=l377SriCwrrn2xwlVhYH/PfxqioUxL/H72SmZpOI6rdyPBY0u77
	hlrJPD2Jul0aPQEWvGUffMK4mGmN58hRLEO6q+S14geQxLEDloWYWNqVyjombP0j
	aLtcxf06hPU7oH7ZYlBd4NtzjSKW3ulqTnoPAMQJJ/mXVvIUsgJUkIRKu4OUBPqY
	lbbW9eApAMqQK7gAx27dQlCoW/+bVHnPWpQOAK3lpidm5MnZxarjOFBU9gVXbr2L
	VpAiw4pe/l7RNwGe7Pd0A1T3dHVDdsDEyTiO2Q8Jkn0x+Nx7fyG8wJMdae2J9ncr
	nHBcbqErVqrzjixatGwQ2eDdj5Ma5byhgqQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480459qgpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75494e5417bso5005545b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178385; x=1753783185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZMDuKP7h3626TyycBatNbgqTtgdtOYqWeLoCfMOJHo=;
        b=hxkCJmYTttOPfglTrqqiPYnXkZfLCJGrusMcXg/VES8ojkcryKWVeX4NK6y0J5fYD1
         A/dLk4r24mbRjALUkejekZ3jYLhe3zPl0wkCNfEUPWf3cOH81POwJEGNuLHngAEHz3Hn
         B9A7nkgOyGDC0whNepDv9vMSklsd0WzPo0636KiAPdzT63/6cfUSV/h68XZ4u7vD7aCU
         iHIDFgQ9apLPNLTDorrdfCxO9q0iLgsE9N2uPQ3dn9tG1zh3OEU20eevdxfs8RXG7lZp
         X19fvrNpLoRjYzkNBLhWSmFTfhNhsPTZnZQIQEdeL72UXgoHYnJXqk1LLcEbJ6SJxQW6
         ry1w==
X-Gm-Message-State: AOJu0YxcVnLFAAXn41R+2FjUxx+L7xpLGqVp/ziwDAwml4rNFqsVeEaZ
	QHb+bgXdCct0ocZByti5hXl6Pc0zOykn9MCNnfhcuCo2Ts//g1c/i/QUJ/FpF+wOdAnusR2+Aw9
	ZrYFoHRf56W/tWVWonV70grIlBsqDk9y88YfOHelexOBOOan+3FGkZMHx1gNpWSVw5LaZeK3FfC
	JLeA==
X-Gm-Gg: ASbGncsO1Hr6ADjperE1XfjAxqYncpnN4X2yjuZ+wiJ8ZWc7lJNs6iTy+yAD8mQPa7U
	6NWABySlOC/t7EjVgWVW2bByF9qdcgsvSFo9HsVLMDsqEP1wCDW8uywhodEELwmsOXk3S6AEpLb
	ZnGhUJvKG4s1cC42jw4w1xZnklDP87gGewQsg4yXKzc8x+efIBcZiyCvE+DhaWPqnW4XSQvajoq
	u7GJQcRr8xzYTqkKuHJG0T4OcQUYuE8u1e9OyTP8NN2tsDd6/wWKu3YPrI1TRGh38K+odYE4nYW
	MbsnCYPU/0slCUTafpT1QwhB/pHbYIUv646Hi8tdarosWU9CHLl6m/s0S5Up9AMApWxR7TJJrsR
	vhM7P0QFgBPCsGJU0QAMDsDeUT1KWIEtk2q6acQHiBsBPR8LW6oYt5Q==
X-Received: by 2002:a05:6a00:399a:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-75ed0ab2986mr4076292b3a.3.1753178385077;
        Tue, 22 Jul 2025 02:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGrni+EObt9NBsaW6z39B8SXXX060AJ5RE0lVvSp3vfwVB0UxwL9lzaqRR0yY0KJSTSxJB7g==
X-Received: by 2002:a05:6a00:399a:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-75ed0ab2986mr4076264b3a.3.1753178384623;
        Tue, 22 Jul 2025 02:59:44 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d6bf2sm6851065b3a.53.2025.07.22.02.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:59:44 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 0/3] wifi: ath12k: monitor mode fixes
Date: Tue, 22 Jul 2025 17:59:31 +0800
Message-ID: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aqU39eLLtDBM8imwujDczgzAXGO67n3o
X-Authority-Analysis: v=2.4 cv=fdyty1QF c=1 sm=1 tr=0 ts=687f6112 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=yHWqMfdfMdZBZPA-_MsA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: aqU39eLLtDBM8imwujDczgzAXGO67n3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MiBTYWx0ZWRfXyTjKo7GlsaOd
 ov+gJUm1nryg5DSlISLaLxeJR8EQ8wjNOYyVUH6GinpY8gZ2A3+RXWjmsDJuX9695QiH4tefia4
 mtrH0/JBbb3q9UyfhMbxhMvrAa/LL9XjCuPcMuZ4wEX+kqvX5+gnJPBTjCQKHznoFoV8Ne2pxqQ
 zPYBpXLwKs0bchhFPwfQONng6DLMZWc6+mFfuhNqfgx12ANG+qx43sOhlIB3j3er5bqhC0EG55/
 betNOTCgIA5I3HrTFTEcWENZSxw5QmudhOu57uB8BBv0lS7mmcL8tV31yn9IAUiilNo1gzzjCSH
 19ybnDjeLg5wbl/mKuOXGjsGp+W3FaTUbJ1Ny47aKzRo6xDn+PsiqBpIiw+v5jdf3lcOBu6E8js
 5q5Whurd+hkplTewHqkZwqqWfAu/c76WsChW7A0DWvym7RK1hgUtHmBLkOYhshrdiouFpCIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=714 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220082

This patch-set includes three nit fixes for monitor mode.

Kang Yang (3):
  wifi: ath12k: fix signal in radiotap for WCN7850
  wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
  wifi: ath12k: fix the fetching of combined rssi

 drivers/net/wireless/ath/ath12k/dp_mon.c | 49 +++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/hal_rx.h | 12 +++---
 2 files changed, 46 insertions(+), 15 deletions(-)


base-commit: e4f11ae0c4b29ca0c133f891412afd5dcddc68ff
-- 
2.34.1


