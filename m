Return-Path: <linux-wireless+bounces-19120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C6A3B0F4
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 06:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138B9172AF1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 05:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35CE18FC86;
	Wed, 19 Feb 2025 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cp2qOnmL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FE25760
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943416; cv=none; b=nX17j9zcqeStNM29i2UIgJICoRaL3mXmN88apWXzw2ct7gMn4nYLNrTMpbkLqWSOvikHzZhJ1pD6tJpD6WkDE6F28XDeYb2q0jvicZui/I5fgSmO1ic77BPJAHLDGohWhimdpihvspNU6uuM8KWonWKb5ixmEBdipuYuVSv/+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943416; c=relaxed/simple;
	bh=fPkd1hYPgDRajJNU3JhtfsS07PB3pK/2oGYyVp00zsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/3XxFWBAookvSFXiFd7VV2Kt0o34+N0cO61eknKZTw1t4oPMMKNjnYx6rSw+e4VYJ+1ocAkd1pB2NDzHeW9bHy+zT4Z7Zl7NazB5s+rc/MHY2CsuIXherm/L+rO0iGr2MFhl9RYvJXhyYAY8pP8HGVezu3ujIEJ0/DoVhz5OKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cp2qOnmL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIwKqu001819
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 05:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+qatjzLJftR5C9+14zG6XcWQr6f2xKe2e15
	fwV/4sFM=; b=cp2qOnmL6qFJGfJG7TVZ1QftDBplw+KukpyYEsyRbSP2rqDAQob
	t+HP3LwD/MTv8xnGEK/VXaA8ySKYbQy6CQfvJ4RE0/dnHE2V0JIOAsx0OJnQ81l8
	S05dXfGa6PeBFqv6eBe6G+kfWz7uyMfIM/MCifDgxu9CMpz28Kt1IZsFIgybBoV8
	bJ/QH6QTMdWkwtGp/4ZR7QwzKFLcpH5E9zSgxZfJ0waa6UYtU0Po+nyrg/LmXApW
	RMgU5gBPM5AAA3mbzh4T6JPQg4xVZDVq7I6nfGNYjDUNLItsmrVYTNrWI2NAdbhw
	APNdpIePzatVW9WBwac8zYq1AacieGvW5bQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy29aue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 05:36:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220c86e46ebso95760415ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 21:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943413; x=1740548213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qatjzLJftR5C9+14zG6XcWQr6f2xKe2e15fwV/4sFM=;
        b=Ii3fGy9OebhZRVtOj+bu+Fo75AVVPVmJGZ4RJGRsLxOebjDN/rt52hn7geAJRtyY5M
         j+lJsp4R6+71nLauy0WDpXiPldgkkzuMxe3OUu4zqgfir3wV25gbLqGL2gdvseZaYFT4
         EYKCRWF3Gcal7LtRr3PyIfZCp7p0ChdHKMmPNOnJAnHGLinzwBJdzwgpi2MHecWmH/fy
         wY0gEFh/6FXuIYu5OOzTFWLQ3QJYvzZ8RYEEKMkdQjr/SFFfGbZmGjweKWnr5wkrKCwb
         Xlb+HYVVbQ9/ya3HLCTruKgdgEJLXdsGIOR/6rGyfwTZx5baz1tSH62SkMqwv0ItTf8q
         GknA==
X-Gm-Message-State: AOJu0YzS69X0dNT7FhSE1vBMcmlJ8q3pGHDqsXEoI1Jj1o5GJHUZ3eUU
	GglYxorzPU6KJoP4yaXXrJWPSThbHY8asr8tHnNkj+cKSa/RBQWa4p0HjSlXkpFIdC7Ti6kkN3l
	XLpkMpFoNtbZSgJXFH2X/WoGaoMtit4KxnZL27ZtvfjlUg8aX+U6t7a0ni23YVABZRQ==
X-Gm-Gg: ASbGncvO0f4dqILKXWEid+b57UeY8plVhdxSoS1kSsauAih4tnVGJbHBoHdMHYqpu1S
	EUjdtim2OLaJL8Y87uzC7au/yzmVJAQY+GwETSTEZ27rEBTNu+Uv7bbT1GxlOx2+9cRqKal0CoS
	lymIPlbfSFC9tCliI/IhJMBjzDpUvxyrJI0SpK8RntKKQZCD221NWsA3364OqlIAYGBI5l20Q2d
	FvrVJi57WoM628Id0LMFmlnfpEAA8h0ic5WptCYdQdctjnD9Y9lRT1NazPosMR2rgTsAhZV5/nX
	iodo57Rpp/0K2M1JJ6bIRV0ui2EK3oiyFNfFY1PbvN8BgxhMPzI1loMqZSpe1vSoUoJSgGhM0cR
	S9m3sfqWpGvfrfsive48OPvI=
X-Received: by 2002:a17:903:3d0c:b0:220:d5a4:3ac with SMTP id d9443c01a7336-221040d7a6fmr253332965ad.45.1739943412662;
        Tue, 18 Feb 2025 21:36:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7vSWOoGuSQ75kPdzGnwwwUhItGPUkLL43lIEutmC6u7bUx5hF8bLSWis78xsuWNKoTSonNQ==
X-Received: by 2002:a17:903:3d0c:b0:220:d5a4:3ac with SMTP id d9443c01a7336-221040d7a6fmr253332695ad.45.1739943412173;
        Tue, 18 Feb 2025 21:36:52 -0800 (PST)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491dfsm97409375ad.3.2025.02.18.21.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:36:51 -0800 (PST)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: remove redundant declaration of ath12k_dp_rx_h_find_peer()
Date: Wed, 19 Feb 2025 11:06:40 +0530
Message-Id: <20250219053640.223734-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zivdih3YqQOqBOFewTDmeyn1Msw8MO6j
X-Proofpoint-GUID: Zivdih3YqQOqBOFewTDmeyn1Msw8MO6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190041

The current code in dp_rx.h declares the ath12k_dp_rx_h_find_peer() twice.
Fix this by removing one of the redundant declarations of
ath12k_dp_rx_h_find_peer() to ensure that the function is declared only
once.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index c0aa965f47e7..88e42365a9d8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -138,9 +138,6 @@ u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc);
 void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 			 struct ieee80211_rx_status *rx_status);
-struct ath12k_peer *
-ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu);
-
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 

base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28
-- 
2.34.1


