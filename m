Return-Path: <linux-wireless+bounces-5611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF058922E7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000C51F27975
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D953E28;
	Fri, 29 Mar 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pJeoqz2a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDA12FB27
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734026; cv=none; b=DuD/3peTXKQh0FQLzLZ2A6Wxizy65czWzby0AajpyT9wFLDdlUnmn0n1EnRX3SlI77AdgJKKTFMOlzfAnP60/tn8/0kxsR4oEDtg1igVrHbPLciaBO1A9H5gOX/zX3aZJz/7Lft9VFrjC6B071rik7QaG/6lHFlgw65YinYVHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734026; c=relaxed/simple;
	bh=Gnec7uNQdoCYeDnszzbIEWBE6iS4S9k/POBnypDQzZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA7eb18Fd+VnuO5BVdztXpow945mf4JuXJ5yp1S2u+DmSj84Uwqem0blhQLfwqh0GSdoeMZVMoZx9eAZ2nYYu/6UdT5TLCYrd89CVwJ6begYyqGFx4fG5YFBAnCsZ8QPfyZyTjiIfUBrIYKY5WjGeBpL/uQdxe6s5mGbKFVGcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pJeoqz2a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THeKcb018011;
	Fri, 29 Mar 2024 17:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=zHHhocOpqjPnDdHPeMG3
	McXCVuNvcM650SHyLS7EA1c=; b=pJeoqz2aHeUPWIe2mIBKZccYhSowHSzQKdn5
	ff8HM02ogrNUmoCThFOnQxinEsrxqNeYkBF76+jaULWontxqqcpRteJCY8ib7zQN
	mpF5Jrd9abZXNyHa2df9PyWkh549HvfONQAI+7wdJRTA/7g28iu0ChVrAE+lFknL
	fsXDZXZ3sBUbXs45xfE2WHElQ9fzobRuNDwYYFoElAqlUJruRn0UvvvdK9Q8zWHb
	27sR2iOXOVszcpRXPfRecsY1SXhl6NNgMkiZaee6/2JAzHsd7Zoiy1DfqtYhb1aZ
	TjCrxX3byKrQ1iwUZI8cMrjW7DmfLTy4Z62alakIYNzeg+OmRg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x60wd8608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:40:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THdcV6025587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:39:38 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 10:39:37 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v2 3/6] wifi: ath12k: fix survey dump collection in 6 GHz
Date: Fri, 29 Mar 2024 10:39:23 -0700
Message-ID: <20240329173926.17741-4-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fxc0fkMt4NQegTnZN32VvVm_eN5Hnu12
X-Proofpoint-ORIG-GUID: fxc0fkMt4NQegTnZN32VvVm_eN5Hnu12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=808
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290157

When ath12k receives survey request, choose the 6 GHz band
when enabled. Without this, survey requests do not include
any 6 GHz band results, leading to failures in auto channel
selection.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b91d34b602dd..6d7df18ec424 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7419,7 +7419,13 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_5GHZ];
+	if (sband && idx >= sband->n_channels) {
+		idx -= sband->n_channels;
+		sband = NULL;
+	}
 
+	if (!sband)
+		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
 	if (!sband || idx >= sband->n_channels) {
 		ret = -ENOENT;
 		goto exit;
-- 
2.17.1


