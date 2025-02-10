Return-Path: <linux-wireless+bounces-18723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D8A2F6FC
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26921883E78
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299125B690;
	Mon, 10 Feb 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9SRFCHx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915725B668
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212045; cv=none; b=NN+pBw/q+wyXg6riuwlFiatNBYF/tErcpE14MlBYYI87nFI98qOnG6eXAwRKi4Hi1qbQlzpCok8+dccrHJrM0G+BgEPy7mktQnO1RmW/pGukDvCiwB4c71FQt4EOetwcqA4wt0g5xDbct9WhfazEe9aQjRrpeWTLFgseMsI5iDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212045; c=relaxed/simple;
	bh=qqAGJ0kL5x96w4uFcixdmbLngkE30fvHV+uGe09hISA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSdr7dDCM/WESb+lXbX6us3KUHYXR0VtEhTdsshOW7QCwi6+vBiDeUDD9vSdsICrC/th5vFhrh1qeFjptoNnfUxc6xn25tj7xc8Jv3A5HrtagQF02upugtd/5XmWqpXtMkYpqzV6xxQMYkVUuUH9teEwkk/8XxwUsRM9/qodTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9SRFCHx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9Vgq1018694
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Gjew95/V5NgXtpzaCazVN4ozklSBnkqrhwT
	SJOZZ9N8=; b=l9SRFCHx4pR1Z5GE9YMfbgbC/CF3IeBeLGIUaZh2eU74+BhgC49
	632AQsMVgAUT+v8rKJYQnv7tPnzOrvLI4BAors9EZLZTunu9ehQa6pHihAlr8kSc
	Vh7x86zb953NhcceiAdundKauAxyyfLCml++cy4SyizmNZVjqUltLLfZBuL0BRoP
	gJB0S9uvy96QX4pbWiH2gbEF+VoqTBf5vicmdWThmcau+exkdUzeZX2IRmbkNLO5
	ENNlicQ+/qIBx8B4FP+PAvS2aoW0jIGzXm2LO4ZtS1mNaq38aX+Iq8VNXKCD/Khe
	F4CTv1HyhwaVnlhYQcEOTBPUPl1gu0ENRgw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0esdads-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 18:27:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f9c02f54f2so9742824a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 10:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212041; x=1739816841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gjew95/V5NgXtpzaCazVN4ozklSBnkqrhwTSJOZZ9N8=;
        b=uZtfP2o6S9wtq/ZT7XpNiFlS9D6xM5XgXWyRTZJ/CLBed5PT/CfdlwV9Sosb3KP1Wy
         8kZ9g5go9J6WZdHfSyg1NeJAHqmvrVPRPwYzPD8Abi/nwuXostjtsLyXBjEEPizN/cEn
         RGrTviZuuFHPbFOJuNdwWUxK7idVsfWdeeptAXpwLKoLb2Ds/HoyFjmWpM41Y/0bPukw
         0KenCNJx5LeG6oXUkg84yOEGb1xMJCMRFqYlCWsU1wf1GyTaM5oE1a1IcNxYvKyc5GrR
         9zKouo0Z4gucYDcc6btnqFewkxyDF3Xc7S513N/WWIqPaVOHWX0GuvRNNkaiQxtRVude
         EL6A==
X-Forwarded-Encrypted: i=1; AJvYcCUSC5YwTFbRQ2Jv48VcARAAdusIWmdkoPk6rHXJoKqvhsccOMdOCOHp4+ztz9NPNO75IKbOa0B2mUHJVMOLOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxMDbmImBgpORTP/QX3rtPXzMRoScMGy9Xq5GcMMRIfy+wrvU
	5nTNcHxrBDQgkiU+B0HlPjnQsb6JrrxxnjyJAtSrUFYrjweXFkozE8fUqMHE/HCdg6PNbPiOvel
	gCtiVZSe58QZP+DM/3pIGqYv3PeNI+/VMyTDZXHS5GQ+1k5Lz/XCgdkMBHwBjl2szhA==
X-Gm-Gg: ASbGncuGXEVw3QHLJdlNlGmEjZIAeqhgJjpbCFjkfRlwMGzAO2rGa7FrCjv/qsF7FDc
	reFSjReqbNT9WCK8Yculrhb88MsriyVkyYfoJK1cs8r2S45w8vLL8BLTuSay57Zt075hNF+2jEl
	fwBTSKhMB1OP4Fhjq0cYWCHJ50YZvYkJVZ5j+WYc3XFoMtRbKm/Y9k84PtAefylzsPXRRc67YtV
	xQDGfMKx/FyiNf9mnDqMAVHFbkbWojtKJtVXYN/8Q51Npa3kcQAs9OZNW8x9qZpXsoePVy3PkR+
	UTzmW++bv5g/gou74VlGhjsDGlZdQeeJQMsFg1rvcF+zlzQlCohpUEqjOLPi
X-Received: by 2002:a05:6a00:2289:b0:725:460e:6bc0 with SMTP id d2e1a72fcca58-7305d2ac0admr25649698b3a.0.1739212041119;
        Mon, 10 Feb 2025 10:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPXrpGR0BvSH58Ju3d8FrcHnAh2KNvN/0WuaoCUw7XmsBPUZo/Z3DUS+E2PBVelTjibLdOTQ==
X-Received: by 2002:a05:6a00:2289:b0:725:460e:6bc0 with SMTP id d2e1a72fcca58-7305d2ac0admr25649634b3a.0.1739212040605;
        Mon, 10 Feb 2025 10:27:20 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae8e83sm7948372b3a.84.2025.02.10.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:27:20 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 0/5] wifi:ath11k/ath12k: refactor tx_arvif retrieval
Date: Mon, 10 Feb 2025 10:27:13 -0800
Message-Id: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BduHVxSPpn9wxYAEm8u_vX6EnCleENZg
X-Proofpoint-ORIG-GUID: BduHVxSPpn9wxYAEm8u_vX6EnCleENZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100149

MLO MBSSID series for cfg80211/mac80211, which is in review here 
https://patchwork.kernel.org/project/linux-wireless/list/?series=902914&state=%2A&archive=both,
changes the way transmitted profile data is stored for each link.
As drivers currently retrieve 'arvif' for transmitted profile at
multiple places, MLO MBSSID changes will becomes unnecessarily
bloated with RCU operations for every retrieval. Refactor 'tx_arvif'
to avoid this.

Additionally, fix an issue in ath11k_mac_update_vif_chan() where
tx_arvif is not reset to NULL inside 'for' loop during each
iteration.

v4: Added "compile tested only" in commit descriptions for ath11k.

v3: addressed comment from v2 and removed NULL check for
vif->mbssid_tx_vif from patch #1.

v2: fixed kernel test robot error in patch 1/5 for tx_vif.
https://lore.kernel.org/oe-kbuild-all/202501160626.Jbb3GHnk-lkp@intel.com

Aloka Dixit (5):
  wifi: ath11k: refactor transmitted arvif retrieval
  wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
  wifi: ath12k: refactor transmitted arvif retrieval
  wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
  wifi: ath12k: pass BSSID index as input for EMA

 drivers/net/wireless/ath/ath11k/mac.c | 73 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/mac.c | 81 +++++++++++++--------------
 2 files changed, 75 insertions(+), 79 deletions(-)

-- 
2.34.1


