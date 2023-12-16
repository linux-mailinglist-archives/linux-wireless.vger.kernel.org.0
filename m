Return-Path: <linux-wireless+bounces-864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A131E815B3E
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 20:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB58E1C20E3F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335330FBF;
	Sat, 16 Dec 2023 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XcKKf6W/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0792FE0E
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGJK9AN031469;
	Sat, 16 Dec 2023 19:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d+1dIMCJhetZu7A1JplteXqHjZw3T02zteJa8LbmnfY=; b=Xc
	KKf6W/TzBM0g5M+OykCxf6miE24ZrnGLnBP7ogPpiTpy8WMZNxq/fM+GSrT8RP64
	Hxg2qudIbNIZFVvz55dbbWoXqyqlQCKKIWNe5nM1DSlAXUdp+QF+W8ACmQQlYaBj
	weIfPVBEiSLYk8QvZ9o3Uxb/+nC2n/cFuiLtHhUkHj0l/VROvFopHaIwy07+LPYS
	xUDIIqsukuSdB+Vd+q7H4UzuuUeu45N9zNAI5ry0vVI/Dc6t4/K+GzHufuYllpTq
	jprMzwWShsDz6ddfzDSkbJ2vxW1/bUPHXuHomIiWFYJ3iWUzgZJUW1P7hOg9NvXL
	1EUqybd81NtU6irlHcGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v1531s1jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:20:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BGJK8ll021865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:20:08 GMT
Received: from [10.110.36.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 11:20:07 -0800
Message-ID: <b9fa390c-1d34-4bc8-9214-e6393303a070@quicinc.com>
Date: Sat, 16 Dec 2023 11:20:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] wifi: ath12k: add support to search regdb data in
 board-2.bin for WCN7850
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231216060140.30611-1-quic_bqiang@quicinc.com>
 <20231216060140.30611-5-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231216060140.30611-5-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zneXI4Uea3ET0swSQYPh2pJIcnGROhEE
X-Proofpoint-ORIG-GUID: zneXI4Uea3ET0swSQYPh2pJIcnGROhEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=973
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160148

On 12/15/2023 10:01 PM, Baochen Qiang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently ath12k only downloads the same regdb.bin file for all WCN7850
> chips, actually ath12k needs to distinguish all different WCN7850 chips.
> 
> This is to re-use the string type which includes bus, chip id, board id,
> vendor, device, subsystem-vendor, subsystem-device and variant for
> WCN7850 to distinguish different regdb in board-2.bin.
> 
> ath12k will first load board-2.bin and search in it for the regdb data
> with the above parameters. If matched with one regdb data, download it
> to firmware. And if not, download regdb.bin instead.
> 
> Add enum value ATH12K_BD_IE_REGDB and enum type ath12k_bd_ie_regdb_type
> to distinguish regdb data and board data since they are in the same file
> board-2.bin.
> 
> Test log:
<snipped>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


