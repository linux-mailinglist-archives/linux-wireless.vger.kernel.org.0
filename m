Return-Path: <linux-wireless+bounces-17792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07DA17C28
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 11:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475181605B1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D15D1A8409;
	Tue, 21 Jan 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S5VvWEMb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93B1F0E44
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456465; cv=none; b=Za7D/54KWbP+sdqj3Er9ZQBEP2DMkFbv8OqmimwRA2b6duZ1mDDFJuzn9bUvkFfamZbvTZahjoyfS+oIa81+ZWtoxhefi4IhSLJCMZTag2V7DqZFzugZQgi6cxfvH+SwiGWHVLLNlVC+hP8TBpee7kYegEVRcO1eCagMxvWjwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456465; c=relaxed/simple;
	bh=EkeaWKRG548ce4iyEqbLMyZAQ6honRMCZMIH7Q4tW2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hA/8zi8DktmUwtD3ToBVxZLDd74+u3V8GkzAm8fNjGRLnf4H1CUA4tB4y4cQYQ0dtxGIFo1vJAU87XhDbVKFizXpMohI21DaYWD37kdclhQFEW9smh2vqtoez5tpuuMjSyR7GVU9qXTHH2jsgmVtEWB3JX83fSnti7pyJNSdmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S5VvWEMb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L9QgQC031220;
	Tue, 21 Jan 2025 10:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0110w/5hEyoEkseqshvplOtl+V80g2OAplLpO2U9Uv4=; b=S5VvWEMbM1aftGKd
	oAuWS9uaXQPTk8D5/OjybEBLOak6mUKfRLbnHM0Kc8A5KOgtfvSCF6lNWCsoQSKs
	JWvMBA9TXBz+ObvTf6TBLiQRHuqXrwMbyc/sBoPM6b2QerdPafFW13+gBTt0vbaU
	7cYrGQXOr8208Yr+jl26wxRO3jDSV4iSelB4Yw1vwEOLFtHb3vU7UOfHRiRNpj0D
	eWsV1reLGNj3wry1D70zN/lRlB78ymd9bku/i6yqm13k3s9SVgaVGyonYjPbc8u8
	VyNJdTftTPAnLVujGRPDCnWPhtGr7YYq3DWfRUtQFjMzMifbU2HvpI9G0xxdZ0oK
	4IWWBQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a8y2ga9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 10:47:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50LAle5X026027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 10:47:40 GMT
Received: from [10.253.36.159] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 02:47:39 -0800
Message-ID: <f790e71e-9b03-474a-be21-5d9bfa71e593@quicinc.com>
Date: Tue, 21 Jan 2025 18:47:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] wifi: ath12k: store and send country code to
 firmware after recovery
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250121091844.1987-1-quic_kangyang@quicinc.com>
 <20250121091844.1987-5-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20250121091844.1987-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ecHgHlF96YOyg6oZXjU3qVSIg0cx7CTY
X-Proofpoint-ORIG-GUID: ecHgHlF96YOyg6oZXjU3qVSIg0cx7CTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=823 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501210089



On 1/21/2025 5:18 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently ath12k does not send the country code to firmware after device
> recovery. As a result the country code will be the default one which
> is reported from firmware. Country code is important, so ath12k also
> need to restore it to the value which was used before recovery.
> 
> This is only needed for platforms which support the current_cc_support
> hardware parameter.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---

Please ignore this version, review v9.


