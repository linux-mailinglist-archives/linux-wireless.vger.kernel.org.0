Return-Path: <linux-wireless+bounces-1507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122582469D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331AD1C20AB4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372725112;
	Thu,  4 Jan 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ez2k7xAq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CE2511D
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404DLCZL025271;
	Thu, 4 Jan 2024 16:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SUPJi/0x2AaQZGagvItl4HW1clHe+YXjkhaqYMNXDHA=; b=Ez
	2k7xAqfC7mb9hwRdBmnOCnC6PXqQstTaBVXC2ywqMKZaZRFSnsT/j+HeSStlZqsw
	OFfwa0ayhGXOvnYkPzixVUXnHQmTexGEILyi6GnCpiIF7U5V16L6FJe8sBS2Dseh
	Ji6p0weuRHOzXa+/KmRZu+Yavatubn3gVpXlqZfSDOEE7kQl5VJPQGNIvnzsCBlI
	fvi5Rw168T0rnt+dPZPrc+qoQjXS9OwMREvo1bgIqdIWAK3GPsXpnFN3avMxH6Ab
	ZaqRZ0kskQJwq0OL7co0Jke3OZ3T7v1WEUnR+0gNjvQEKiLqwlKD1MFdA2j25Z4W
	1rL/Ct11JAQeLyyY7WFA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd3mb4d2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 16:50:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404Go1mb019417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 16:50:01 GMT
Received: from [10.110.76.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 08:50:00 -0800
Message-ID: <efd81ac0-8b82-43e0-aef3-44313a5187ba@quicinc.com>
Date: Thu, 4 Jan 2024 08:50:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add display tx and rx bitrate for 11be
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240104032202.19472-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240104032202.19472-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V4BdT1PXxSS8T7ZnXI8Kts_r9DybPyeL
X-Proofpoint-ORIG-GUID: V4BdT1PXxSS8T7ZnXI8Kts_r9DybPyeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=577 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040132

On 1/3/2024 7:22 PM, Lingbo Kong wrote:
> When AP is in 11be state, STA's tx/rx bitrate display error value using iw
> dev wlan command.
> 
> In ath12k_dp_tx_update_txcompl() function, not handle the case when
> pkt_type is equal to HAL_TX_RATE_STATS_PKT_TYPE_11BE, so add a else if
> statement to handle this situation.
> 
> In ath12k_dp_rx_h_rate function, not handle the case when pkt_type is equal
> to RX_MSDU_START_PKT_TYPE_11BE, so add a case statement to handle this
> situation.
> 
> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
> tx bitrate: 1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
> rx bitrate: 1441.1 MBit/s 80MHz EHT-MCS 9 EHT-NSS 3 EHT-GI 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


