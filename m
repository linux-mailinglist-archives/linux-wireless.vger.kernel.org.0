Return-Path: <linux-wireless+bounces-2574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291183E13A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F121F259DF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A720DC3;
	Fri, 26 Jan 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XjpzQyjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443C20DC1
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293428; cv=none; b=k/5s4it5dDI+rjKCPQ4uDSNAAIYZLHkv+FZMa4TlRd6RFyQ8pyjMf2FL3VExbf6LNQYm1cCrLqinZ9MWBgvvUrZ80yX5nU418baJhh2L7MF0zjnu0JjbMCbfjId1JW9JQVR9sfayb8SbzTaMQcdzMsw0XtTG7eAAqQhNrgBTTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293428; c=relaxed/simple;
	bh=ZJHmzrMcHcCDi6lqliEoFVrDivV/fte73NjMF4HmHP8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=o/HjD1RL+reODp9C4+oXgrOhGDumUqhSk5nSi7HSvMOrGxMLx5W5j5BndnFIw5AIuiQ6ma40yrs7+O+/+zSBlzd40OrkqtvLQX+qcsxLbM9CSjJ8of+lkMKoV4cqPE9YLo+mF54kJRS8wad0vgsJVhvWr+tsAwaYGVdyUFlt00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XjpzQyjm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QIFoK2005792;
	Fri, 26 Jan 2024 18:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wqdyPrn/JdAnj8YX7PnHtZen28/a1siiw/QSDu52HvU=; b=Xj
	pzQyjmGTbmOJA3K8tOPp4GV0PIFCQlm4X0XCoclv6y2YBCxyUGq9uGg38KE0GJTq
	SyVp2qyZeEuY+gS5qdXT5tCJhHmEgyMpdJWKb2p5CRTWkATlJyFjmkdHZU7h4trO
	9xLkwqOX41bNokY9o08Utw6pUdECC6UpQA2VBq8aK+zw5jTy3HcI6qc5Y9IB52Pk
	2chHFD/DQzZIat0rTqBoqE/wp1Xv5+TCC08jGJADyIHTu0H6QEtOmDNlpR9uZP8c
	DQDLBDgUiwsW9NPsK3XUzyRrgBpCUGVx46tiQWoItnsFud3DPVsD6DmNgFN8XeON
	cgUxWUqy2U6UtrPK6eYQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvgp2g6xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 18:23:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QINgMJ010837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 18:23:42 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 10:23:41 -0800
Message-ID: <bf9e79e9-2b49-48dc-984e-b6e9e6723f5f@quicinc.com>
Date: Fri, 26 Jan 2024 10:23:41 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] wifi: ath12k: fix incorrect logic of calculating
 vdev_stats_id
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-11-quic_kangyang@quicinc.com>
 <0dd4948b-e967-4562-b98e-2f4643205ca4@quicinc.com>
In-Reply-To: <0dd4948b-e967-4562-b98e-2f4643205ca4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uTQOuBcx0KoVJvdtO3maGNjvNIPuNeDE
X-Proofpoint-ORIG-GUID: uTQOuBcx0KoVJvdtO3maGNjvNIPuNeDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260135

On 1/26/2024 8:56 AM, Jeff Johnson wrote:
> but why isn't this instead using ATH12K_MAX_VDEV_STATS_ID (which is
> currently unused)
> 
> But even the current value for that seems wrong based upon the firmware
> documentation:
>     /**
>      * vdev_stats_id indicates the ID for the REO Rx stats collection
>      * For Beryllium: 0-47 is the valid range and >=48 is invalid
>      * This vdev_stats_id field should be ignored unless the
>      * vdev_stats_id_valid field is non-zero.
>      */

After sending this I realized the value of ATH12K_MAX_VDEV_STATS_ID is
correct, and IMO should be used by the current logic. Use of hex in the
macro vs decimal in the firmware documentation confused me...


