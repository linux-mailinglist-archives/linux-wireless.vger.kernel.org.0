Return-Path: <linux-wireless+bounces-562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBD809715
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 01:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69CAB20DD3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C8A28;
	Fri,  8 Dec 2023 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="II4cALoC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9119C6
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:22:34 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7NbOkh023114;
	Fri, 8 Dec 2023 00:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ee91lgY33r/Kcp3Dr2HBiHXZerDAjLurHB4AWJjK5J4=;
 b=II4cALoCxj9OYc4gE8jjuSImjOxESPwyCQUS/BieSTb1nAvu69E0HRS+6xFhw213uR0H
 ixqq8PmYMQ64m344bKnzKEM+QGioG+0q6YfxPiV29RlZ7c7S2gqvkSeiqKkIyTH7Psfd
 9ovZ7TZhsW1I+7Jndut69IjWRzlm/A7jcRp/+ChokA9S389CXhqGnbbAE5yDNHuhpqFU
 b2MGC33sxEirlMdWvXyN0d0DA9IltmCBlwfvo4kvSdi6Z/rA1cSXXPgSVlxECgQlINad
 Y6MkP6T62hUzgVr/zijWcLYraAGF6fRldiDT+By4dh1wKDysmKN4azlzYhjnJfqM8bSh ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu928jgbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 00:22:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B80MViX023099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 00:22:31 GMT
Received: from [10.110.111.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 16:22:30 -0800
Message-ID: <69b8277c-9bcb-416d-9fb4-969c084b912f@quicinc.com>
Date: Thu, 7 Dec 2023 16:22:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] wifi: ath12k: Refactor the MAC allocation and destroy
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
 <20231206034920.1037449-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231206034920.1037449-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9y6sXtTGspzOhtq6i06ch_LvOI6O2U5G
X-Proofpoint-GUID: 9y6sXtTGspzOhtq6i06ch_LvOI6O2U5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=531 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080001

On 12/5/2023 7:49 PM, Karthikeyan Periyasamy wrote:
> Currently, the MAC allocation and destroy helper functions are tightly
> coupled with the link/radio (ar) structure. In the future, to support
> single/Multi link operations, need to refactor these helper functions
> across the core and mac sub modules, so that it can be easy to scale
> these functions to support single/Multi link operations.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


