Return-Path: <linux-wireless+bounces-8775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED59A902EE7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 05:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873602831B4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638816F8E0;
	Tue, 11 Jun 2024 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="baClxGrE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41197E782
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718075448; cv=none; b=nwc4dgrYiBbBtgI8GAYa0VY/4Xnx4bDYijRqgEOIPmGfnRZjUZyH4DIYGlhFrCnne0Q5HUDgr+qDlE2L8+OQ6KvrX5vaLNGLDM+f0MOenJSZJAQWIktNg9iJMk3jekRbwkql9ZijmM/d1AoXEIBdrWpfW3UNU+XDYyif4XthnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718075448; c=relaxed/simple;
	bh=qbvuxQwWLH6ZLQXi3QODM9gCU2RKWDZcEQtPlCkEFUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoCpBG9x+vV6h1YA4zqzo4YkDlrrYfP2ZpQREYNRflIaoM0HkGqZ7Ok00lNLq54y+PvJRimSiQT2gsBN/YppXFQoMPJYFd3c4zWbkrm4VicalP74FEo5AiPZ/g+pNpzewQs8IyIEpt2HUfla4lBjJ933SZ7YS9I87CMopiJXEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=baClxGrE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B2VNFF006787;
	Tue, 11 Jun 2024 03:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yxafXVy0xULxTQS2ri4rwhBvND3NL8O7Oa6bvKd4zns=; b=baClxGrE1NBo9EkD
	z+znY+Iy2yFBWLQ1Hw3Y6Wh/wm6AZHmymOFLjyJQTMSwl27zQVAx6G5Et6kz+obg
	spdKKHfnqtQZ1gARpE1Qd+SHuRwq8OutLkIM/EzuuYQT+M/ALh41A50L7If131z4
	Ezf142FWTB2KZhMGGjdh8cUfBZFzl6e1rEuN6cG1VgSj5uIqcWoKeQXfNU2v9rF0
	mY+FNmF+zdp9fEe1+lws5igkK2tdC1q6mnk4XBEhrC0Qd6CQ8PAGzT9w6BWwm3qo
	Oiqxricxe/Y1npPDF6ShQPWczH8NCxtCjnaUBk3zQoH9p/Eo3Nvtjr6NszbhfYv7
	5eE7zA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfh35w57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 03:10:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B3Ab2q030515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 03:10:37 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 20:10:35 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: fix NULL pointer access in ath12k_mac_op_get_survey()
Date: Tue, 11 Jun 2024 08:40:16 +0530
Message-ID: <20240611031017.297927-2-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611031017.297927-1-quic_aarasahu@quicinc.com>
References: <20240611031017.297927-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RtvwAzBidLSv5VaFlUameI8lrYBXDhvn
X-Proofpoint-GUID: RtvwAzBidLSv5VaFlUameI8lrYBXDhvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_08,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110024

Smatch throws below error

drivers/net/wireless/ath/ath12k/mac.c:8318 ath12k_mac_op_get_survey() error: we previously assumed 'sband' could be null

Currently, we access sband inside the null check of the sband
in ath12k_mac_op_get_survey().

Fix this issue by removing the entire if block, because decrement
idx is unnecessary since there are no more band to test.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: 70e3be54bbdd ("wifi: ath12k: fix survey dump collection in 6 GHz")
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 509c02bffdae..4fea411545bc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8314,10 +8314,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
-	if (!sband || idx >= sband->n_channels) {
-		idx -= sband->n_channels;
-		sband = NULL;
-	}
 
 	if (!sband || idx >= sband->n_channels)
 		return -ENOENT;
-- 
2.34.1


