Return-Path: <linux-wireless+bounces-1595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C648276E6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C1CB2090B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267955760;
	Mon,  8 Jan 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kTViwWJW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904154F98
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408HCDKI019397;
	Mon, 8 Jan 2024 17:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Yi0wb8pfQVrrQyBSCja7QTf1D7sIb71j4N0P9n1V25k=; b=kT
	ViwWJWOMZwaVGJ2IFrEjpQjZlnmCWLIDp9H7lBeOWtCpnsP88pcv7zqqL3tr+wQe
	dkz3mctyd22qcNjDewX7y2AL6Uq66XGlaWESde0sptWT0Y2gVWL4NTYuOhUYmME0
	legINMhVndNrqu1nknn52pPoAqs/+6rJ9HUZM4A6WJ94CYb79olFaGCj/uQRqGRY
	jAj1E/Gb1/nDQR8wZ6xgMs/fpJfauXXVm0DiZGZf5V7gP6IoBJwEBmKCpGgw97Jn
	8P5WMQLIqprL6EEwtJisbna+gU4GI8EXymKfGqYU12lmS4SE01jC9oNybfsu3Nq8
	/HydBL7nyvLfSgj1HPXg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgfwjrw9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 17:59:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408HxT96014605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 17:59:29 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 09:59:28 -0800
Message-ID: <fcea0fbd-0fd1-40bc-a473-b317189c9c2e@quicinc.com>
Date: Mon, 8 Jan 2024 09:59:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] wifi: ath12k: change interface combination for P2P
 mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240108082552.7227-1-quic_kangyang@quicinc.com>
 <20240108082552.7227-2-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240108082552.7227-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OVJ8RmRLCFISmdvo_YAU1HL3xkm2bB8E
X-Proofpoint-GUID: OVJ8RmRLCFISmdvo_YAU1HL3xkm2bB8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=698
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080152

On 1/8/2024 12:25 AM, Kang Yang wrote:
> Current interface combination doesn't support P2P mode. Change the
> combination for P2P mode.
> 
> Also, there is a bug that when mesh is enabled but ap is not enabled.
> In this situation, the mesh's max_interface of interface combination
> won't be set.
> 
> So assign the max_interfaces for mesh directly.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: ed7e818a7b50 ("wifi: ath12k: fix and enable AP mode for WCN7850")
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 23 +++++++++++++++++++----

Qualcomm Innovation Center copyright missing 2024


