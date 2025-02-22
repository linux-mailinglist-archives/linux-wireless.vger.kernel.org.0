Return-Path: <linux-wireless+bounces-19335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFDA40974
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177DA19C040C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED41C84B9;
	Sat, 22 Feb 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mDQX3uMn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FF1B21BD
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237604; cv=none; b=AXpI5J1PO72wfF2ecbPieUlBFSpRfEX40hqKMNv9QR9dljiMRJtGNLx4oJnotOHugrlUDJ1JmyN8aiP1GgkWr+pyr3NPGNSrQKL3oalinUyinkGSouYmvjEnEMx6+wpbcUzCFbj1I0ews3RTqo8fkdzdrA/q2n0hVh/EwCp8GMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237604; c=relaxed/simple;
	bh=vo7hgctS3W1Z+7SyWEda28v0iGSTkKcOUO6vtvXWmEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsIekfg8oo6jel3VuG5yL4/apM1kBp9i3nqSI4e2PVTKeW0Mib5oDb2Kw0xnWi+cb8bb204VQt5+FRPr0KCgAseRCw1YHQ/TnDARL8hfzl22SAgwWHFihEt7Fsr0TO/xfKk67+F/3K73xvD7xAzRk3oo5LqVEksAaeEWh2cPg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mDQX3uMn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MCa8ri001496;
	Sat, 22 Feb 2025 15:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YpNR83IMknkVOVm37a7DPU9bos+nhUBvXxoWiUPxAEM=; b=mDQX3uMn20NiElOG
	1W6i5tPIYTPXsWXyM5/IqX1h2AlgI3wrw+xFWIZzZueKaq30S8FGNzDc0Pa8rTGt
	hDkLe1IssZJlEL9ABhkZrR4BTGRZvMykKIfBgsw3W3nrD3oJuymGYXmSGsKuc+gi
	4JNcLrcO2JIb9epFdEhbH5Q2Ig69NsgenFPXmqsQLuqiJxtT2ViWj8xbP5ezln6R
	mvbcOtkXG42SlQgVIwJbt0kpEp8Gf4KEI6MkdJWS6UUIaVXSDsF+GtOHBf1hYIxV
	ycxV4L0RTrw8mLCkj/vK9k/j//R5zF2deSCdf4CsTFAYL+/AW/Bkhw71pNSONYN+
	rEq7og==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y3xn93wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 15:20:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51MFJxl5028317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 15:19:59 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 22 Feb 2025 07:19:57 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v8 7/9] wifi: ath12k: fix NULL access in assign channel context handler
Date: Sat, 22 Feb 2025 20:49:24 +0530
Message-ID: <20250222151926.379652-8-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0m7U7J4E_NIZQC3s9ztWPLQazD_QVVg2
X-Proofpoint-GUID: 0m7U7J4E_NIZQC3s9ztWPLQazD_QVVg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=928 bulkscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502220122

Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
(ar) gets accessed fom the link VIF handle (arvif) for debug logging, This
is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
access, avoid radio handle access by moving to the hardware debug logging
helper function (ath12k_hw_warn).

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 90570ba4610b ("wifi: ath12k: do not return invalid link id for scan link")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a2506a7443b6..c0e50cc5c024 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9458,8 +9458,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
 	if (!ar) {
-		ath12k_warn(arvif->ar->ab, "failed to assign chanctx for vif %pM link id %u link vif is already started",
-			    vif->addr, link_id);
+		ath12k_hw_warn(ah, "failed to assign chanctx for vif %pM link id %u link vif is already started",
+			       vif->addr, link_id);
 		return -EINVAL;
 	}
 
-- 
2.34.1


