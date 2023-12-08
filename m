Return-Path: <linux-wireless+bounces-561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1F809714
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 01:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCEF1C20BA3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 00:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707B627;
	Fri,  8 Dec 2023 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DJYwESEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17CC6
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:22:17 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B80FZuA026120;
	Fri, 8 Dec 2023 00:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v8TUCPdQDY7ZGHUaCv7dyabOubibvDecgaI3RfDhY+w=;
 b=DJYwESEn4eLIBecT4ocrstrR1f+GkBy7S2ySbFKU1/r2b4oWxzNv9DYUwgvgVU7S1Tev
 p8JUfenwyXNBhs2QTwZS7HShRstCeO+t/gFcc9R1xnpokYL9x9H3xZl7RYxUYRWIpHhQ
 td5EZklnjn8vajg9L1UUK5SOTWprMU4N5D48sl1x1WrxMrV8ZQEJvq+aRfgksLDdSrT0
 3zdPzrXHnL+rRk/1tmy1NdOpPqrvIqqF/zHsSdUV8i3b7GoG1yw8pSiJopIKHI+qm9bD
 QhKa+8KdW8Zv5nYRTJFSkGJLfl1Gy3E+qpE5db69HJ/OMr/Ptyv5kzLNeSR/AIQzFQaW iA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uuphg87pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 00:22:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B80MBV6022451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 00:22:11 GMT
Received: from [10.110.111.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 16:22:11 -0800
Message-ID: <1b2d9923-d66e-4df3-af19-b04b7764f504@quicinc.com>
Date: Thu, 7 Dec 2023 16:22:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: ath12k: Refactor the DP pdev pre alloc call
 sequence
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
 <20231206034920.1037449-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231206034920.1037449-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JILNDMJb7canGhbZQ0Ztme4QXkQOWAgJ
X-Proofpoint-GUID: JILNDMJb7canGhbZQ0Ztme4QXkQOWAgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=724 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080001

On 12/5/2023 7:49 PM, Karthikeyan Periyasamy wrote:
> Currently, the data path pdev pre alloc and mac allocate are called
> separately from the core start procedure. The data path pdev pre alloc
> can be called from the mac allocate procedure itself since initialization
> related to pdev happens in the mac allocate procedure. So move the caller
> of DP pdev pre alloc from the core start procedure to the mac allocate
> procedure. This change helps in the future to easily decouple the mac
> allocate procedure from core start handling in order to support MLO in
> multi chip.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


