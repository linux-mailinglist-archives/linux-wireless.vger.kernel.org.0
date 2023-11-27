Return-Path: <linux-wireless+bounces-104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F27FA5F3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0081C20DA9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1D35F03;
	Mon, 27 Nov 2023 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Np0dKCne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CB198;
	Mon, 27 Nov 2023 08:14:58 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARDWWgT016256;
	Mon, 27 Nov 2023 16:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=TUJVRQjvVEskKiBUisVR4Gj6ljLGq2tG9U/3HxBNz6E=;
 b=Np0dKCneVCqk6HOXDuOS9pVMt4eHlA86D+PIu4k4H16oqQMwOVCsgu7I3PSks321xW4x
 KOxzCucyVkugT+PjLmA1TdMmucEl37GDmMfFglnn4J8tXmLQEMLRK0GTbF9+VO1Elfuu
 gVy5l2YO3tq4TgljmSvPdlvg3Xs4zyMMgvzl8c4nRJaOTMT+W90axbWjPcy4P0C1zmOa
 N/IVHT0O0JdhV/ctCb52SQwONdI/w0Ct6smSYJb/vMvZmuMOZ/JxA9aMDWW/QOiBtfyR
 LBw8+T9Q9pPsLS9lz6rS4zavkrS0/pz6N8roZ/p/zBFTtTDZ/U2Q51oOAfOFHAG3CMFf 6g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk69ud2bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 16:14:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARGEn9n004637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 16:14:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 08:14:49 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 Nov 2023 08:14:47 -0800
Subject: [PATCH 1/4] wifi: ath10k: remove ath10k_htc_record::pauload[]
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-flexarray-htc_record-v1-1-6be1f36126fd@quicinc.com>
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
In-Reply-To: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xaISCWvNSOWFO6yMQ1OnTios_CBxr7UL
X-Proofpoint-GUID: xaISCWvNSOWFO6yMQ1OnTios_CBxr7UL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=486 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270111

The misspelled pauload member of struct ath10k_htc_record is unused,
so remove it.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index 0d180faf3b77..9cbb901d35e5 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -249,7 +249,6 @@ struct ath10k_htc_record {
 		struct ath10k_htc_credit_report credit_report[0];
 		struct ath10k_htc_lookahead_report lookahead_report[0];
 		struct ath10k_htc_lookahead_bundle lookahead_bundle[0];
-		u8 pauload[0];
 	};
 } __packed __aligned(4);
 

-- 
2.42.0


