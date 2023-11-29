Return-Path: <linux-wireless+bounces-222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF87FDB95
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 16:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FC5B20B22
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C71B277;
	Wed, 29 Nov 2023 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dJEKtUHa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8DD48
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 07:35:15 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATDXgnq007345;
	Wed, 29 Nov 2023 15:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6tA+4dm3fGfIdvLepGkvqvZVuTtjmjIe5X9Fmhad0fU=;
 b=dJEKtUHaxDHVTiuSr5pY7A4CkeK5y0LEkXw22wW1ofm8ls7C2tNua7+pEXSpYFeL/R2m
 nJ/xZMtLkCNk6XmySwnA303ZRT2nafw50lE2qVqqpb72zS/cnfsLE/M5Qe+H67AoqKGk
 HeS50/3/vg2sAPlNB2XIZQ7Zro7Vg9G5zZ7wCcGunqsWd7suCMQloJ1EhoEm9PQTxscF
 gxjsa798RLND/e+zAG0ZTSW7WPyT4sdbOH4/U7aiK/0qrJAcC6e2akRx7B4p6B3C7mJA
 pb1zAZSLeidp9V4s5NCWQ1VimP0gL6En9Zn++X60WEG9uiOqw131/wvH75NiS16gRsHS HA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unjdtk9qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 15:35:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATFZ9ma020239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 15:35:09 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 07:35:08 -0800
Message-ID: <c1965895-5aa2-49be-a96c-b2aa1d5e5dd3@quicinc.com>
Date: Wed, 29 Nov 2023 07:35:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wifi: ath12k: fix wrong definitions of
 hal_reo_update_rx_queue
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231129020414.56425-1-quic_bqiang@quicinc.com>
 <20231129020414.56425-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231129020414.56425-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RRMxLibsPFVIBRp77UwshfylbBiKmfhZ
X-Proofpoint-ORIG-GUID: RRMxLibsPFVIBRp77UwshfylbBiKmfhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_13,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=551
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290117

On 11/28/2023 6:04 PM, Baochen Qiang wrote:
> Some fields of hal_reo_update_rx_queue structure are wrongly
> defined, so fix it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


