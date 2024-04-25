Return-Path: <linux-wireless+bounces-6857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ADC8B2723
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90CD28629B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B280914D6F1;
	Thu, 25 Apr 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Op/5kuyh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC911DFEA
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064741; cv=none; b=nHOLvuaPVqQI/ajQCMCkwJMq1agKnPzxBGppVT2delT2FzqAginIlJlVyH0PLhLSExBRXQO/En9TkOJ9wR4DRw/6IfUmRkeKNd9vSSA5/g4zJszrw9XWTPWfaYFU0t/CLS90wCcnrB1lilLElV9JdSsSB8jqs+HX3csw1eSHpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064741; c=relaxed/simple;
	bh=FhdrwF0Yb+V1buqzCbwB8eQdBa66xBCBlSpE+jHGtN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y6Ja1nNFgA6kEWjGA4YddJxEEn1tnFj2YgymyURlxhfz5yBI7Ug/wZv1ZEYVMf9XxuPBcLbVSdcO0V8ok8oq5Y1dg2tIwC6J5F4tRaN3enNHgcT4rz8BYOtOtRhICsXc6XtvqHH1fIr7MmSenNpFZzspPFNe0YyVosA2AepqEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Op/5kuyh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PGsonW002704;
	Thu, 25 Apr 2024 17:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=z9x/P0+/Ig4K0cBNCtinHM5rIGhm0lvJfeB8eYbrfA4=; b=Op
	/5kuyhVDPctiuL9AGk5RhLoWO388TyWVJzmt1FR4o0aNWrYdsA5sBkveGNgEb/Tz
	477xIqEbb9BX0+yRKknVQdFB6xQN/50anf+y1U+l2Um+cUCN3E8FVU69IyHB3Ljf
	DtHzh6jNELETnV7sxa9RxmQ4OVy0K/1rgpWSR6wLetB/FdKo48Mt1gzHCiFlKkXA
	fO4rsxs9/EvWk1WZ7oit6Ge+02GOzZBHdh2fc09axxb6+QvimerUI1XEddjS9aa2
	43am5PI9f7RQGzgHbE+Y8CuH+yfTIpAHfRqYr7BkZpa4ZIURRVaVMnaQCXUjalbM
	2VFsb+TfymLNL6RZff7w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhu8wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:05:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PH5YnB030560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:05:34 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 10:05:33 -0700
Message-ID: <28d40f01-ab3a-4f71-b9db-23df480c35c5@quicinc.com>
Date: Thu, 25 Apr 2024 10:05:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: check M3 buffer size as well whey trying to
 reuse it
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425021740.29221-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425021740.29221-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qL0b4q9qUHqWM4o0o67AQOauc0PAtD29
X-Proofpoint-GUID: qL0b4q9qUHqWM4o0o67AQOauc0PAtD29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=825 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250125

On 4/24/2024 7:17 PM, Baochen Qiang wrote:
> Currently in recovery/resume cases, we do not free M3 buffer but
> instead will reuse it. This is done by checking m3_mem->vaddr: if it
> is not NULL we believe M3 buffer is ready and go ahead to reuse it.
> 
> Note that m3_mem->size is not checked. This is safe for now because
> currently M3 reuse logic only gets executed in recovery/resume cases
> and the size keeps unchanged in either of them.
> 
> However ideally the size should be checked as well, to make the code
> safer. So add the check there. Now if that check fails, free old M3
> buffer and reallocate a new one.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: 303c017821d8 ("wifi: ath12k: fix kernel crash during resume")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


