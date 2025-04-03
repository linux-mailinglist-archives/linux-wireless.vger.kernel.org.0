Return-Path: <linux-wireless+bounces-21118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20555A79DF0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 10:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425293B62EE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5778241676;
	Thu,  3 Apr 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pmv/4Z0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F824169D
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668539; cv=none; b=ccFbKHorlsC1b+XFS1yAok+C+CLqz1b19/PgqveeR8g4EeI7+Rbl41fGnUEFbIBmsVlN/GFFKJ0iW3Sa5QsnGna6TWK0IttYtmnFbTxZL+8chXqXQEHxhuc7PgB4y8Lmvdhj28VW6L1de6L97fXA/K2a9hvmEYdCbxDxhPdv+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668539; c=relaxed/simple;
	bh=v6KJAC6jxqzwQSOjxmqXVUCyPRT7O+IOJwa0ixVeCxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NayWqOwFm3+I9PT2v0qJcN1adG+y1yEVam1bRvZDXXbegL5Wr6hBuV2guQMiUp1GYN//cNSZubq1ucte40GTneBe4x751IlBpVGuqnhxz3+HxQzJthBv/pfa57Xb+ktMfeZkK1drnauFa6UifDWm51FOhxsnFj8TrKlyRQ7FU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pmv/4Z0U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53382kS8008845
	for <linux-wireless@vger.kernel.org>; Thu, 3 Apr 2025 08:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gFDh7FLlCD2oGYiapfu55+XPBan0+1amH56
	RwhTihCk=; b=Pmv/4Z0UgraRyhI+8BUz4wo/OAOmZwHm1XkPsZD7nSERCw9gr27
	co3dJpvK8jL2FNZ7NVrpeUsd49PTNFfDOoCrB/xPOKG7NfGf07HhMorErlHu9H4Z
	o3Dsm+ZhM4BJW2sBDTu6VG7KhcuiGVSBK6zrmw/bYvneXg0qM+1jOxALHh2U+QgO
	6KXTiX6KelggDTkaDWB32RSDe81fei1BlYs4Bqp78F8d/ZTPZ8WCrZD4Tdq6fft2
	29Q5G8CIdcyemPSkZdOcA0C/xzis5ovM1URduZBkQGQM5B2XiKjrx6CmEmUNuybq
	Dc5LdKjmBBsfX7FsjKg0rOKBLK61posB47Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45sbxy1daj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 08:22:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-73009f59215so894975b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 01:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743668535; x=1744273335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFDh7FLlCD2oGYiapfu55+XPBan0+1amH56RwhTihCk=;
        b=s61mRzyerwQiWzAooD9IBTY5OX1om+W02qVc3Z6CqYS5MuZ4v40bo1xx5G/Bwt+22z
         Sa3stzLMo0cg/QmxYIzBLzTw24XQwfLk3kIA1ttyaP3qavEmDTuO9D2ysl+42kTBxoGq
         uDmPSi9FvFprBQByhz9Fxfd8AIo7GrZ2bLZi3+r1Kc9BbqjQT8hpPEePQBouIlBYmlhf
         IWrUc1VADVKDjdEkAuUMG5NgivmEvPLwmoCaT16ysKoEOR/APZzULeql4F424pzBkSyK
         Yi6ejeee5YqozFG/kQx/F5xYkD+kO2mTI6OKQFqjhamMVv8LgT1O4lfN1JUfu33h/P8e
         cQdg==
X-Gm-Message-State: AOJu0YwMib+q/eew2Q+f+YT3kCCtq5F1yixAxxsOmt8sEDz59ruwllyf
	A7Frh+c5olzKSLGHBoEUZwtS3h9i7R2SK2yqTOVIzWlGxomgpe3tUM9+h+HlGJiR6t8GCh//094
	zyArunAmouWQmEmAv88+yB4psuua0mjKheQH3L1DekpwiWkqtUGU8TF5AXdquBT9/pA==
X-Gm-Gg: ASbGncvQcrP5pSz8Zkbik7C0OBAMgCsQehDHvGniYA5kDJzDNExOJofOXPCw6HYhqSD
	aXQrLT3TGs3sW5Mr0JWdWlknHdsgXj3dSrqkDd/fJz0Ih2jw/ew+ZykZZKYSE+3SldxyRueqXKS
	coFqPU76nNxMdmEPSAeOQglft53RVFCDP3ouljiYfXnleB0GT0DPQZEiG9/WUQNsofruCoaI9Sr
	oCAQojspopAt95WFx3FjM4MbKnKUlLC7vEFXXPM0T5wx+yH283x9LYcq7/9mef+cWQh2j5b5ARf
	6iC2KqRYS2Tt/Dr1JTTGzXVoUzLu9VZRLjOnRO4rAB7RKnWywYa7Umf+yWVCcwju02BYRwqZnFQ
	OcpLB70ErLC2Igw7ezDucs0UQXJRmvJr29CJ/quk=
X-Received: by 2002:a05:6a00:3392:b0:736:a7e3:d4ab with SMTP id d2e1a72fcca58-7398033f56emr23962633b3a.5.1743668535074;
        Thu, 03 Apr 2025 01:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5SE5ineQ9nDIgZdwea03Xg6Iituu2oOp0LLHnkqT9edWih06WmeTKizWXRgiTUm3g1TlqZg==
X-Received: by 2002:a05:6a00:3392:b0:736:a7e3:d4ab with SMTP id d2e1a72fcca58-7398033f56emr23962595b3a.5.1743668534604;
        Thu, 03 Apr 2025 01:22:14 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea080esm900381b3a.108.2025.04.03.01.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:22:14 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Handle of key_cipher in MLD AP
Date: Thu,  3 Apr 2025 13:52:05 +0530
Message-Id: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i_XG8Q-DatlQ0GTVUuNFVmlS5P083XtM
X-Proofpoint-ORIG-GUID: i_XG8Q-DatlQ0GTVUuNFVmlS5P083XtM
X-Authority-Analysis: v=2.4 cv=PNAP+eqC c=1 sm=1 tr=0 ts=67ee4538 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=JoBvbwHCwcdsu1lL9X8A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_03,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=648 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030033

This patch series ensures the correct handling of key_cipher, which
represents the group cipher of the MLD AP.

Aaradhana Sahu (2):
  wifi: ath12k: Resolve multicast packet drop by populating key_cipher
    in ath12k_install_key()
  wifi: ath12k: Introduce check against zero for ahvif->key_cipher in
    ath12k_mac_op_tx()

 drivers/net/wireless/ath/ath12k/mac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: c0d45354abf5763f3de37d0c59fd863d193c7275
-- 
2.34.1


