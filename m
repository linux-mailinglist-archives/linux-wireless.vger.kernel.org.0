Return-Path: <linux-wireless+bounces-14045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE4A9A01E2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69BFAB256A7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B85170A37;
	Wed, 16 Oct 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d3E0HTbp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8A1B6D16
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061857; cv=none; b=Tk8XSjg4pZcf8Xj3XI7bTniOHE/BcAmefMszLqv2cy1xy3GjLW76Kvt6RlBYIRHdK0feCok/Om4HHylMvTJ+MNVMgI9zb0ocHWKFWV0alxs3AdOXhkmOfFTxPKkYghsYZ/MiACph7WpcspEicS8YOqiP3vRzzN8uuvrhavuLcko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061857; c=relaxed/simple;
	bh=WCme+n1vCnHAq8VE8y4Sa7tbsLpfzqFKpFxdqL02zKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ712S/LqaoHrfF5UX16VdNzbHf/bWJvghAKUMXzLVj2sdXKGIs0e/D52RiEtWbalWoDetfOjncmoSlURSQpJGrsQBE876Mx2eAAdj0k9Z5bnPgQBGLVc7DHXeq4ffM8wsJhqkiischQlbqhx6Uzc5YJUDQbGuDekhYsppjjREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d3E0HTbp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G3RLbn029416;
	Wed, 16 Oct 2024 06:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WKBqUj63tavjkglwoL/Kjl9WPNi7CuEMc/z5XCVlc8E=; b=d3E0HTbpJKrih3Oj
	U9Ik0lLmbkibdchd4jSnTGsKBqxqW8qJRYtIUPIJG36KBFB2KNFMpfK0wLRD5ELx
	SmtA5r+Rc7OaVxnE2z27es/B+y4CJx5O8B9nUlPPX/wxs5zP7DU56PqtXc7g2CEY
	8AQ5eLnmWEZyFtb/ysb/YpJCa0bkdTM0Tv/qkbUEiYyaeL7jOWUucfkeoIE5SpSU
	e55+Ui3FFSq7tc/e3y9jrhGst5KsQM2gBI9XFiyLXz0mvEP+mBz2MB0ICU7oWgsq
	Ks7JFnypKon54le+8imcTjpUSG/AsXO8A8Wo/0z1GrkI4DvpyTk2p5da1qt599ba
	9tO1Ew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429k7w3sac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6vQGp028809
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:26 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:57:24 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 01/11] wifi: ath12k: remove unused variable monitor_present
Date: Wed, 16 Oct 2024 14:56:50 +0800
Message-ID: <20241016065700.1090-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241016065700.1090-1-quic_kangyang@quicinc.com>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: On4_JzJpco2_JxGLGxaIxRiNF_SEvm9w
X-Proofpoint-ORIG-GUID: On4_JzJpco2_JxGLGxaIxRiNF_SEvm9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=790 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410160044

Variable monitor_present is never used. So delete it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ebfc1e370acc..cbcace4671cb 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -561,7 +561,6 @@ struct ath12k {
 	u32 chan_tx_pwr;
 	u32 num_stations;
 	u32 max_num_stations;
-	bool monitor_present;
 
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_vif info,
-- 
2.34.1


