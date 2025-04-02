Return-Path: <linux-wireless+bounces-21103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B1DA794E1
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C8A3A83EB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4845C96;
	Wed,  2 Apr 2025 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ylfd5r8v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3C86353
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617708; cv=none; b=aur7MQ1ceKvKl8KQaFAqDtKnXje0EJ9eY4cfQ+u8zccbSC+5RO+sIw8fvWq7U/on2AyQ7opmtOqChqF3zhFvD/k89vqLOynZCWtHVRL4N53vVxrdpbGzEDCIrp2VobkgyPWV9kE7fvt2u4Q4g/G05T9XfDMkbUNJgDzngZA/nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617708; c=relaxed/simple;
	bh=1O9x21V+CiltOvr7uzcdwBQfuRhfcJDBb+awYRXyJrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DCbgDxeyu+6tlu7tIkUnwNpykOwJ17fZzYR2h+UJ5oYUVjSAliEsmlIZlLDCSNzxem12BtSKZEY+LuRBOmAOXSEdURD3BrTz+JctH3sGgKO674Bo3B1rWI4AgdiE6X5bdCY0xPmqUhfQ/7lqvTB42zvXgS/uZqFYdjbPm350DQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ylfd5r8v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5329kNU7031196
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MzctXm2pVCVvfVuhRtPIU0FYoMWF3ecX6jF
	4IOuaQsE=; b=Ylfd5r8vXKpIHvathagqiBdXVr7fwwvA8rbRMsM8rEldVhI1ogr
	OKpxBaurPnAEjBfzwYfhMnK66Nw3IjO/WGixrD9Q8LZnWEvfVXtut2J9WuREf8D4
	N6DtbLamhiuGHlPe26cRQqol0pkFVBFzR+You3Px9tinbzLjGhPOfsaFmPZ1y3zh
	Swuo8t0H9mrOck8qQcIwCIi6lTzkHiNSCPt2H7sHfMt6NYqHb7uASEInz7tpvNlK
	Nvtp9gpYdB8gaQWKb2GNkvhFg5kx7TaM9YvkrgNVjmt5repVdt5FIhSlo5KwpK3s
	fdeBMLoyJtnhDgY8g55nkECQg/gKxxNMqvA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45recpmqkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:15:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so109242a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617704; x=1744222504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzctXm2pVCVvfVuhRtPIU0FYoMWF3ecX6jF4IOuaQsE=;
        b=h/FHQ4Dn9sZb3XvFD4hWlGcxE5XeQDQlI2ZuCAYBq/ghcBC0BaEBMM10lp8swX50ox
         Z0B0+FCePLGaVHbXy4fJhidbNrbTDocYt/mUFBKXE/L2/eiVcRfbk5h3PoRynWV+dXne
         EyTOybKfJTvA4IHsm+pdSuJ2a95pDogVQF2YM/ZKc0mEK0tFNdaBgVF/PfmCkaV8M11f
         kcM4ZYmUJjmLLC0uGvTAEV2MGtgrAhBTISUifs8YgvFxkzU1ybPQvvPze+gCmuK15xt2
         vwgkd2mS3mzVJUrwFvjJsFNKr79Me/WCkeXX1T9+mQKr393F89A06W1EorkjJ2NMNNyV
         T2xg==
X-Gm-Message-State: AOJu0Yz8PRzlHkLeJQc0zXAjd9x//uXdmhjrGVdTmNGwxh4bsw2lXgDT
	gI4KmbX8hGYM8JULdKFuMVNjTijUfXrGDAxOM18U0VSsJqtIokf+K7kRuDl9UEQXLLwe0Bm7zkZ
	41gKE7XaYjs0tRC0z0EEtDoDX1bO3TmSayvoluoU7QiGbeEf2nKQA3UET+a4541tMDg==
X-Gm-Gg: ASbGncu79rHv2fFFzEnjKk9uk1YGQyX+mR23Dc99ciyf1IStcwgnccxLx+lUn9FMM/6
	sTCR2lWPSmA9sN6+fmdGNcSCHCVs3YPd6j3DUDLBj8GknnxnukjiJC8aQY6sCyH8fZRtfzEqalM
	AJgHKRPUPk1gGe5ewCiZ+/JqDA/DLLkSJgxUYIj/9aAHbBmyRWHykm5+4R+veZDsOaSb1oH+rOz
	YCXR/8FzIK+eBwVt5AO6jlsOERw2EKPzz2z/sTq+/GEYR0S0iXxIYP1C1Qs0BApgDtSe7A2mtNT
	q4ZKA4pFmyCanfVqRtMGZtNvruXvSleAm8qG0T8cmt26nGMxqU6nJsLDVWGseovSvXDOeRk1n3x
	moABjcchQSofFI2lNCaXmdt3cI09SQcOYSg==
X-Received: by 2002:a17:90b:2552:b0:2fe:8fc4:6f4b with SMTP id 98e67ed59e1d1-3056ee35a49mr4475553a91.8.1743617703847;
        Wed, 02 Apr 2025 11:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLtNUircSwJy2Kv1ng4tGpsp3VVaTfOgEFJsVObtNuHMkdUAnc1B5xl1gXgBc0/A+LBaVu3Q==
X-Received: by 2002:a17:90b:2552:b0:2fe:8fc4:6f4b with SMTP id 98e67ed59e1d1-3056ee35a49mr4475528a91.8.1743617703473;
        Wed, 02 Apr 2025 11:15:03 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf14csm111689675ad.137.2025.04.02.11.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:15:03 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 0/4] wifi: ath12k: Fix multicast memory leak in tx path
Date: Wed,  2 Apr 2025 23:44:50 +0530
Message-Id: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7rl4mH_o53_BNiV31QgpEz1B5zPP4-wQ
X-Proofpoint-ORIG-GUID: 7rl4mH_o53_BNiV31QgpEz1B5zPP4-wQ
X-Authority-Analysis: v=2.4 cv=J4Sq7BnS c=1 sm=1 tr=0 ts=67ed7ea8 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=O8uiHmLsffw2fOifbccA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=1 mlxlogscore=668 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=1
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020116

Address the memory leak caused by extended skb allocation observed during
multicast transmission in this series.

P Praneesh (4):
  wifi: ath12k: Handle error cases during extended skb allocation
  wifi: ath12k: Refactor tx descriptor handling in tx completion handler
  wifi: ath12k: Fix memory leak during extended skb allocation
  wifi: ath12k: Use skb->len for dma_unmap_single() length parameter

 drivers/net/wireless/ath/ath12k/dp.c    | 10 ++-
 drivers/net/wireless/ath/ath12k/dp.h    |  7 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c | 87 ++++++++++++++-----------
 3 files changed, 64 insertions(+), 40 deletions(-)


base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
-- 
2.34.1


