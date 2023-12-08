Return-Path: <linux-wireless+bounces-564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D9809717
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 01:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5A91F211B5
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFD195;
	Fri,  8 Dec 2023 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QSBxxgYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3947D5B
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:23:21 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B80NKhs016933;
	Fri, 8 Dec 2023 00:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MSuQSRoEDnz5UnKJbkJu7npS7t0VbbeajitD/xWZzYU=;
 b=QSBxxgYS2VtB98MQiP+QjrVq8+EKIoM6mGWHfEMx8FQ0dFRxjBy+o9PzmQ+OGvfB5yMD
 m8BNNRLbvCNN52rAwKg89i+vb95dxOfxIx4G+n7xemjAlg13O0EVER3Ygjk0L/oD/Kjw
 AG0WPAVBh3zdiPZMqHJvmIP8/IMiQwjK/sU91J2TBf2mxQRVWWIdhxbRanaEu0zn00dt
 3Df34y5xczTn4tjQ6ROXjoVkzaecTEb+kfHxbEBqOCZfeR7rcn9WRHxe1C3Nyqqb04pu
 jVDQ2Zfo1EGqgnQlTmM+4YeVHoG/GuClAHBZxpNRP9vX/OzpvBp/uUIvnmyD7KXrTq37 5w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu8p0ajef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 00:23:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B80NJ6l019700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 00:23:19 GMT
Received: from [10.110.111.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 16:23:19 -0800
Message-ID: <ac0ba332-8610-4292-bbe3-6f8d0a4d9975@quicinc.com>
Date: Thu, 7 Dec 2023 16:23:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath12k: Refactor MAC un/register helper
 function
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
 <20231206034920.1037449-5-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231206034920.1037449-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BwcgcvhMo95ExA0eMBL_R_fOcucwM6Pn
X-Proofpoint-ORIG-GUID: BwcgcvhMo95ExA0eMBL_R_fOcucwM6Pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_18,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=481 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080001

On 12/5/2023 7:49 PM, Karthikeyan Periyasamy wrote:
> Currently, the mac80211 hw registration procedure is tightly coupled with
> the handling of link/radio (ar). Define a new helper function to separate
> the link/radio handling from the mac80211 hw registration procedure for
> improved code readability. Also, it can be easy to scale these
> functionality to support single/multi link operation in the future.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



