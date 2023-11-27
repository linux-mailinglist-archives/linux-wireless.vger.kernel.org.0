Return-Path: <linux-wireless+bounces-102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B05147FA5F2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41C8B20BCF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039B35F1B;
	Mon, 27 Nov 2023 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HmAwE/z6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA3EA;
	Mon, 27 Nov 2023 08:14:58 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARBvZWK024130;
	Mon, 27 Nov 2023 16:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=IPneewAukTYUoTQJiuNgmFkdLth3CtXmRs8TRhkQu94=;
 b=HmAwE/z6ta2q13KpnrCfqEutnxpPr5plewnurdyVDsreZVlxtjIgdL/pmfkoExke1ecY
 1FgD3xJHH9aNeatbVufUB6q5hQ0hRM4jrNVBP8f1YGCH9tOg/GIAVTBVcxHdDJcSfdOe
 zfKXLi8YUq/58h8SU1prm6zeOI7vjbRQz7AY41+E/8VnXfw3Dtso7y4fAoU1mEWw3oLK
 BhtdomuNzka1sgmiW/U0bYzTnZuQTtzI1Y6J/6N2CZx+CndR0Imn98mpAa76foqtWNbY
 c1ovNbKyYm/OP8wt67jF8g+Ozcl2wwqQbvLM3c4pL6hTsDGd0fAw22twRsI/is1UKC80 1A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk9admsvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 16:14:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARGEnue019950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 16:14:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 08:14:48 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/4] wifi: ath*: use DECLARE_FLEX_ARRAY() for
 ath*_htc_record
Date: Mon, 27 Nov 2023 08:14:46 -0800
Message-ID: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbAZGUC/4WNQQ6CMBBFr0JmbU1bCFFX3sMQU9qpnUQpTpFAS
 O9u5QIu30v++xskZMIEl2oDxpkSxaGAOlRggxkeKMgVBi11rZRqhX/iYpjNKsJk74w2shMGm9b
 L+uya3kOZjoyelj176woHSlPkdX+Z1c/+Cc5KSKHRadn3/oTOX98fsjTYo40v6HLOX+K4z5K6A
 AAA
To: Kalle Valo <kvalo@kernel.org>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook
	<keescook@chromium.org>, <ath10k@lists.infradead.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ymAvPvjB_n62rnvx-BvWc7iUU1Zwodk4
X-Proofpoint-GUID: ymAvPvjB_n62rnvx-BvWc7iUU1Zwodk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 suspectscore=0 mlxscore=1
 clxscore=1011 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=203 adultscore=0 impostorscore=0
 spamscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270111

Fix ath10k_htc_record and ath11k_htc_record to remove an unused (and
misspelled) pauload member and to correctly use DECLARE_FLEX_ARRAY()
for the remaining flexible arrays. This helps with ongoing efforts to
globally enable -Warray-bounds.

---
Jeff Johnson (4):
      wifi: ath10k: remove ath10k_htc_record::pauload[]
      wifi: ath10k: Use DECLARE_FLEX_ARRAY() for ath10k_htc_record
      wifi: ath11k: remove ath11k_htc_record::pauload[]
      wifi: ath11k: Use DECLARE_FLEX_ARRAY() for ath11k_htc_record

 drivers/net/wireless/ath/ath10k/htc.h | 7 +++----
 drivers/net/wireless/ath/ath11k/htc.h | 3 +--
 2 files changed, 4 insertions(+), 6 deletions(-)
---
base-commit: 8f157593689fcffc2d9b18af9472fce764188b43
change-id: 20231116-flexarray-htc_record-ae46f039d4bf


