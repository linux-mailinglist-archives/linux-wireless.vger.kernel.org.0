Return-Path: <linux-wireless+bounces-15228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38489C66F2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9898B1F24B86
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB17082F;
	Wed, 13 Nov 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gXFWiJfl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9F43ABC
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463014; cv=none; b=bMt6q/ONeIhXXn1eFy7BdSLeq4ruwhoxCuaw+l5jsWtFyvtv4pNPoqOLdKffP6Ud9RhtRlN40CUlGaaJDTtfO9o3ijhHcwoSsQo/iuxkonCzdUO+ApAHfBKW42aMMeg10l3TvQ5g2+eTHVpKl3mv+38ZF1UqWiIrrGd+dNXd6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463014; c=relaxed/simple;
	bh=F+WlJVuqHOv/aPzw4AKbwyq5xIJr+HZRQBRdzHiTEo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5mBFOtFw0eKe4Vcq9WbkIgHP6JcivT4SEhazQgeXh4tIQRtzxjjWZYhmXNqlBLWjCv3ucZLsR5C5DWZl/KyhLFv8K8oJzVY43p81+6CLc+EarnoJsUl7DdwwI3pw1PMS58Qk0GdTRsmsqahxxt+FchgGaQYGX4ZgjSyjbPCqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gXFWiJfl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRm33003783;
	Wed, 13 Nov 2024 01:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m/ZD8PCKwOqK9sf7A7yBcLWhWjk8hGcyzE99TN+gbyA=; b=gXFWiJflCC1+LxUm
	XsZn7SDNq/GHKayfoVWin+2DpztnypIJd2GQA+1KGtzBDGHgzWeB8vdtXdvM4h5f
	g635In95favKYZeBhEB3dEjUS4ylCVZwzLPSQfvLlhMrDehFLHBIwgdl05HP9e3S
	hj4iBREwfn290RuRTG3dPYOSA2/vA1VOTCzBE3aTjwN+wttAH0Do8fNj3vh7ZNRS
	X9sIgpMSd7OcPP7Ea2+0I1ezBUDZf17D1TvirpPvNLSi91i5e1K+Q5685oyMLJau
	S0m2p9luSidnXOXJKbvnR8I7Fj960CNw3KXjprJGGvZuT23SHXyQwMZfdMF4UOZn
	F5fRXQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0gm14d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD1unaG025835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:49 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 17:56:47 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 4/6] wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
Date: Wed, 13 Nov 2024 09:56:29 +0800
Message-ID: <20241113015631.3105-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113015631.3105-1-quic_bqiang@quicinc.com>
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cw8PLCcTpxm2K7gVKrXPW3sF2JSvFL46
X-Proofpoint-GUID: Cw8PLCcTpxm2K7gVKrXPW3sF2JSvFL46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130016

Currently RCU lock and ar->data_lock are acquired in a sequence of

	rcu_read_lock()
	spin_lock_bh(&ar->data_lock)

but released in a sequence of

	rcu_read_unlock()
	spin_unlock_bh(&ar->data_lock)

Although there are no apparent issues with this, reorder them to
achieve symmetry.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 641cc979589a..0f7df1fbaed8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8235,8 +8235,8 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 
 complete:
 	complete(&ar->fw_stats_complete);
-	rcu_read_unlock();
 	spin_unlock_bh(&ar->data_lock);
+	rcu_read_unlock();
 
 	/* Since the stats's pdev, vdev and beacon list are spliced and reinitialised
 	 * at this point, no need to free the individual list.
-- 
2.25.1


