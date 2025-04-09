Return-Path: <linux-wireless+bounces-21301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E55FA81C41
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 07:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41F51BA015E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75D142E7C;
	Wed,  9 Apr 2025 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NmqFvJ/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1031624CC
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744177123; cv=none; b=IW9ZH0inruMEwLrNafTDvMzSLQvZB8nTjjl0M58RjlgmBOtLKOHDgC69c2ZvxKPZc0MPB4xqqzSPDwaNSQ+Swi7K1DMiQIE+3DUQSFYGn/PUVbu1g0ljhMqclnmMOsftS84Wh/dg94T12T7vaPAaId0Vwf3rrnCwj6R3aAbT6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744177123; c=relaxed/simple;
	bh=vKDvSM6gVvUIzdz01HZETqqBjWgM1XxVxu3IAFyrhAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDCk5Ez/N97ap6hKh7lzJ5LGv5YwQdfQXF7ICWa0JxCiTs3VwAjcFxnCgTQPm7FDrsEs+4yHi3YwHoVaw7BXTTSuwt/Y3b67L/1vIYnGEpY46QxP5GaQYOrDOyvAfcDUnKWgakYjXcfcLSyW0ZNbi4V3seX9kw8KH2jgeArGpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NmqFvJ/f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYtLw002264
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 05:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SzTMQY4O7z44F+8FTXEi8JTqBtXQzPRQYGm
	whuvW/Eo=; b=NmqFvJ/f8NcW1ahkUIv24vFGF89B7laIjYpzzxi6820x7hChfK8
	ZwTyBlnx4I1Q2qw0aNNa1zF8T8jkmTcdcrPfVnd8YtoAT1wWTpB2h3w6YMgeHeoa
	0CMH0Nr+WygKnOgc5pGdpKY1oKjgS3N9JdCTni+TkP2ZNPgDCP9ZANuS38hiUh0a
	gRjTmTElThOHJ4lF/a0m6u2LT43niQ+pWXJWnQmgJYtnsCunIz3/uMMQUZ6D8p+K
	a7BtuAU2OOWT3moYqTE+WMJcywBnhhppKIvGv5rAht9suvXFMZ22wtBYXBIxr6ET
	2qzvGwVZNAWWcUj0MohiIssTwFs45780U+Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1j2sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 05:38:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223fd6e9408so2872195ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 22:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744177119; x=1744781919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzTMQY4O7z44F+8FTXEi8JTqBtXQzPRQYGmwhuvW/Eo=;
        b=oz3Z+hIrl5j2ZNTm0VH09gT4POu6qc84aKVRSBwmWs1IY9iN23CWOU2LuYAcTaWCxJ
         B2qDg/Ek5AHETbGctNITUOqx2EFvYSEb3shURL5eawxQRiGVoMkHrgAW4n9WbQLMSHXB
         NLTvwdIrF8uoL8RzzlErgFxFvrjdEbwUtqMyfr89QtM4+RrEuEI1+UcRWGF5p1mo4MOW
         +6GxQQRfp0TK5OLWGpQp/4JOT9KFy5l+TEr7ikSyZW6p5t9GaAet0WtsRzTx/ddie2ho
         jCdqfKkmCznxTpSxTK9oHkjzEcUJ4jssG2pSbb2OQJekHfJdfmmhY0H8f/s/xQiw/QzM
         m4Dg==
X-Gm-Message-State: AOJu0YyntCW0rRdgJDz11FGQk1SoUsMfieTyydxx3Dvv2LcSupKH5PrR
	qVEDmEzpPQNqgJQPsPljBXRF7kanr2p4ihrIzk/uYPbJdEWw94S+OhdV0tz6MsQB2Ky4BHHNKxS
	wjqoCUFO+2tukIKaXzB00NGba+gPfdd8+HgUTI2Xu+RFU4eKyjDT0jhmtnev+wK7Knw==
X-Gm-Gg: ASbGncvJD5MQn+XVLcMgj/wYDUNvSUL1BiPCetq/XSyQ1Dqp9Jgi50OFguMoOUO/lMN
	mHm4JRp5TmslAfTfD/LH6XwhZe8X8pi4eQ4vb/rNIjZAO3bNZV5umOlu7Pt3A/9sjAMdnjJoY44
	OCo9VU2mEez8a6c34HVQBJPF5fD/RXNFk6D27LOGPYD3MGDHSDkrNTU0vf7YgYPizAaHVp4dDRE
	YtLsLUtjiOzgYSD5tEnr4W1pYuscLAx4TmusHL5EhOxJN8IZBF4wKV3ikzdU2Cv5QvBEDT6G4qX
	gMMgEAazWTJk7XPV6sycUHe/5tWHZT3a3xUNEHVrYIWBZ4aM4VLPflC8WeO0ZEUxDippg7akaRV
	kEejqwokewiFDnphWSHj3++t35IHR4OoDqSE7xK8=
X-Received: by 2002:a17:902:e5d0:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-22ac323bcb4mr21527295ad.2.1744177119022;
        Tue, 08 Apr 2025 22:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHImc/bvLBl5TXB3csV4JovkmY4x/QlKTBRiP+rgF0AXYNtVwj5lNeDsXmcP7EhIH575AX/UA==
X-Received: by 2002:a17:902:e5d0:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-22ac323bcb4mr21527065ad.2.1744177118597;
        Tue, 08 Apr 2025 22:38:38 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7caf86csm2988865ad.164.2025.04.08.22.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:38:38 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Thomas Wu <quic_wthomas@quicinc.com>,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Disable broadcast TWT feature in HE MAC capabilities
Date: Wed,  9 Apr 2025 11:08:30 +0530
Message-Id: <20250409053830.4039467-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sv-vlVRJLGfht8W8QZcET0lWJL1YE2eV
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f607e0 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xmVKpWhJFmdleDmdprIA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sv-vlVRJLGfht8W8QZcET0lWJL1YE2eV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090020

From: Thomas Wu <quic_wthomas@quicinc.com>

Currently, the AP does not support the broadcast target wake time (TWT)
feature. Therefore, disable the broadcast TWT feature in the HE MAC
capabilities element field.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thomas Wu <quic_wthomas@quicinc.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
v2:
  -Line wrapped within 80 characters.
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2b6bdc3d2b11..26c0147924a3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6724,6 +6724,8 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 
 	switch (iftype) {
 	case NL80211_IFTYPE_AP:
+		he_cap_elem->mac_cap_info[2] &=
+			~IEEE80211_HE_MAC_CAP2_BCAST_TWT;
 		he_cap_elem->phy_cap_info[3] &=
 			~IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK;
 		he_cap_elem->phy_cap_info[9] |=

base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
-- 
2.34.1


