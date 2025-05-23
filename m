Return-Path: <linux-wireless+bounces-23336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8FAC1ACC
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 05:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5B516BEDA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE3224AE8;
	Fri, 23 May 2025 03:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JOndwHgU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52171221F0E;
	Fri, 23 May 2025 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972168; cv=none; b=PSTomD90NDIimCikGswMRWx9FkQ0A/aLlF2E7SXm1AUsFecTJEL4q4nnOsCRJmuWpl8NnVutWOr1gsCWlvFLTbM7GQ56FEImgxjcD+uZbU0SmWhYANs1PEA08EaXtNqTN971EPPB0Tcq6ObtWzeyyvneXSvtDHdBh7ovv7ogKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972168; c=relaxed/simple;
	bh=/N9Ibj1g9u4oW+wOJnwTR743a1afUrE/gy6QniazbsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y/dBvwlhdK5d0zqqLa78GIefmDPMWXS0efSawM8fek+BxRURDRcwMrQvCTkOEXcMjcCKGGdTMGXi+O6APFYx2w13uel6ZMy0PmLKz5V+OT0CN0gbivC/eC37m5WMbD/ZHLvXiKJ4vCXcTALpf7QLjDITxDMWFki0geucIxXpl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JOndwHgU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MIQFHr027725;
	Fri, 23 May 2025 03:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XwNVOArfi6yagzNOWMVdlGDMKyNdJ81OM8YRIL/zqJc=; b=JOndwHgUan/jNAyF
	fld/0GxFny4XSeeW4D6FNmIeC0yaR3dMt40OviVbeQPsldHA4W+B2OG+nrbfTohV
	j6IG/YtLV7Yp+3k3gLXZ46cOtDzk/zj+kqZNy0YfzLOHop/T0TJiwcwGVY+3wL7v
	3I1cojzHTsM0HoY7SWRA0BD+wkuOXIVw4d4HAaW/9wBHtl0EmQbXO43NLh0fq452
	VJCYTl3R1diyxSD3It3uf+wA6A/qFmVDj5jxFgT8OkROlEtRvQ5Ox9VusvY+chi8
	rU9d8Goq/byKrbxjRS153Vl7gLKvo9O7ZuTasKvnh2m6gL+C8aV2k8UqeScKJSH1
	7p/8xw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9gb8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 03:49:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54N3nK46001321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 03:49:20 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 20:49:18 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 23 May 2025 11:49:01 +0800
Subject: [PATCH ath-next 1/2] wifi: ath12k: avoid bit operation on key
 flags
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250523-ath12k-unicast-key-first-v1-1-f53c3880e6d8@quicinc.com>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
In-Reply-To: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
To: Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zebZ5g__iV2gvVKobA-NVIfQob_A1FfM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAzMiBTYWx0ZWRfX6gWIw+xuLDkX
 xmOaZW8jg5Bg4qtS5yJSoiE34ENjVJw8Kfob0dHn2o3pgGiIoztMoCcbNd6yt0q/zypRQuFickR
 IRyeQZnC1gmvDm8EBYnVHP9+40+4QR2gwp7lyiXoShwpa1lUeyLdyWHNttW6Tk4ADct1WvfCTlK
 9UbLHFarkEbGSE9+A3+OXoqkwVPq7yXOJDjZisphJflFWyOCBX1Gixhm/DPKZ6iucqhNHFNAmci
 rDkCJhSncBKV1CCtacu5xm4e9T/QINKh6defZ9i2cD5HZSxXgNOwJl7nIdXXJChYawF33cj4+ax
 DJbR9+0EQcwPkQEXibMkUtx8jLP5qZbRZSsAHc1smmxWnhKIbKAAhF1LY6BN7fXeg3RyCXb/8kO
 5uWQpDzBYSN83iEsfSyRHfX543Gn6MoNC9BHwb2QiXmlnWrn/tw2peU6dO8sm8KEtFKaBExV
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682ff041 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=TahXmFVQDa20seucTHQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zebZ5g__iV2gvVKobA-NVIfQob_A1FfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=836 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230032

WMI_KEY_PAIRWISE and WMI_KEY_GROUP are not bit fields, change
bit operation to direct assignment to avoid confusion.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00217-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87af8b48cb3fafcd364fd9ced4ff197..eb3c6d10e116b098d44cd94ba8e0257a77b54af8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4881,9 +4881,9 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	}
 
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
-		flags |= WMI_KEY_PAIRWISE;
+		flags = WMI_KEY_PAIRWISE;
 	else
-		flags |= WMI_KEY_GROUP;
+		flags = WMI_KEY_GROUP;
 
 	ret = ath12k_install_key(arvif, key, cmd, peer_addr, flags);
 	if (ret) {

-- 
2.34.1


