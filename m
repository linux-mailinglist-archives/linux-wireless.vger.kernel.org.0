Return-Path: <linux-wireless+bounces-24900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5013AFC196
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 06:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB5317D250
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C681E4AB;
	Tue,  8 Jul 2025 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="debLavC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32242058
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947335; cv=none; b=jgN6RzyVanbm+JkYoTL9gwZo+a62gSOyyR05QWmnhun0jIJjYmm3JrYk+/4P4V7r8u3A4YXXtNO9xLdJxe4zkXZw7lKYhNtPpTDEDYgqGywDRATEXldugkM7led/S2L+tdmPlpsAuou3K6Y90J6jXDQZ2gsAdGgjRLrxz0hsX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947335; c=relaxed/simple;
	bh=R7jsYXxS5CmqaGKMO5JAW7Yh+5tLIrxdWpIRnykh22M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cGrWrJVBWBqBLJ1Y7SZSWO8dxlqB6NJbsi9a2u62DHeGhTp6bspmCnvXMKpvGf/zeNO/7qfDDK1/MuuPr9AyZU8ErgOuKGSNGssgkWdOG5jcjOvmp56KZ8LPuQys9QZt2xI9JvBmsjKX2LeM+CtF1VdlQOChQiYQMYprXWKoRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=debLavC1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567IN530018796;
	Tue, 8 Jul 2025 04:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bpPlKRq8193mV3AfX/u5+oxTuYEiQDX3fHG8euZJBos=; b=debLavC1IH5S1lhp
	98Ja5JReDWXDbiDMvcHhV7Q646kNzdJ2QcGWaV4FmJfMPr2oQT268e4N86rwO0Pl
	xEf0b1paNud/eqQvqyju0DvYp20oi59yhgMHYqX2VNMAxWEx8qjoq3KLbySm+DPc
	jU1CjGtoQUJiLrOrQ5HVcL/SDjQABvUK+ij50H9pUnngfa3EmNVf/B0LBbL87cR7
	ayNyrioBvOR75DpORn+lvO3FnlwBhIlGYkt3OEADtYqgGr37bjew+9x+GHA4KkXp
	23G6K16osT5mk0FOofNtBbj7z5pAYnhLomY0XAac88mNORWBcynPrf9aDL4gROJS
	Y+VK7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wackx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 04:02:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56842AFe006925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Jul 2025 04:02:10 GMT
Received: from [10.216.52.3] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 21:02:08 -0700
Message-ID: <0b80a915-ea84-4537-b716-a9b2b9b90d21@quicinc.com>
Date: Tue, 8 Jul 2025 09:32:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: set RX_FLAG_SKIP_MONITOR in WBM
 error path
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250605050135.1802902-1-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250605050135.1802902-1-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B5Q5saZOCwm_18Y-frNSgOwkwPYrmVG-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAyOCBTYWx0ZWRfX3H3RRV1mmCVy
 UCG6RGE7Ba6GEc1gHmJFnfUWtQ+W/O0K6q9ZQL3+KvddWJiPcUPHhictvBwb996eG9h4F0qW0PZ
 eOfnT0DCxdCQ34yWobz0VMeex0FPbPaB5ekrzBoeti/h3BNBMbVt+nJh50NylQwPQyNg+R8dbFV
 o7zjknWlDQi5ndd09sB0RL3iPS8SsjywVy03AVzLnY46jmEJzPSMX2tFoIFgaV3XHOledkNw982
 LH8wGd6mBletYdsewR2/6J3tAWF6XSE0emW/oHlIBzl1ad9SBQfqE+frg42Gp+i52cNGbUtUBNR
 h30r1uDMf0bwJhTSFmUNCjc46f6xS9usEBEHb35dtC/oq7uMVfdsYOVqcxgCFyb03qlYIeZX814
 QAr7xuLI5oV6eTs19yiQ7HOa+YD7a2i/pGSjKTrKsSOpX9qEa6mMT5BRPlbxB0banbuKRzb6
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686c9843 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=5Ws8dH_KWFtnXDiRp8IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: B5Q5saZOCwm_18Y-frNSgOwkwPYrmVG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=704 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080028



On 6/5/2025 10:31 AM, P Praneesh wrote:
> Packets delivered to mac80211 from the WBM error path currently do not
> have the RX_FLAG_SKIP_MONITOR flag set in status->flag. As a result,
> mac80211 performs unnecessary monitor mode checks on each packet, even
> though these packets are not intended for monitor mode processing.
> In regular rx path, this flag is explicitly set to avoid such overhead.
> Align the WBM error path behavior by setting RX_FLAG_SKIP_MONITOR to
> prevent redundant per-packet checks in mac80211.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

