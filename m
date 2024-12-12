Return-Path: <linux-wireless+bounces-16303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4539EE40F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 11:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E83162BAA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BB2101AC;
	Thu, 12 Dec 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="loEQeAiP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F37153800
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999156; cv=none; b=BdDtc2J4BM7JLp/a6ofNz/jsQ2rHb/Hq2d5Y3Ci5TB83T5AM3ZQoPR/kpJW/QW3eINMyZGij79b5sW7Chynz1DRvP9KyqB3gnKV+wr3z7PpZ5Mr+p5jP1cUPSxE6mVXp8hXLcfgcaBRd9Atixo6DHeIzUOTmT1b5sQwul7bcjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999156; c=relaxed/simple;
	bh=VKw1eCnh3BE2+ufZCjmUkCiFhapQVwV4SpNoTZceRZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XQ1Lpy+WDZh5bEL2+Fyvd6F7MDHtGORTeyFK2qR2e0qAxmhF7IcbEZvUSKg2Ub1ANL9/77WnmNZoK/v9UQadIY2KXLjxrYrpNpveiDFuOCzEcQ2e2/kCKucLf2jshUEAuEswTssxYF0IfPUnTcoqPT1Q7MJKNxlV/gffndbz3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=loEQeAiP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7F56M029041;
	Thu, 12 Dec 2024 10:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cm14pP88CRhNiTOQ8GYtAJupp2D8aI5rYN6Y/TVNe/o=; b=loEQeAiPjUBybB1O
	DklsttfxYkCNzFkaOBJGw1y7RvHkmonErJiQpF2IzGPBcM2FcapmsvRB+jDMpRp+
	ifEzlQ/tnzN0cSzcdjr/NmKYBisnJqqKxKxEHSRRrDNg7SercAKp13+3NihKy/rf
	ZVvd9FSYCg274dBJF0GhL6ZImF7uQacqMy5vEQXOudTCvP7W4RPqWVWATWnyqZ18
	Hx/Bv5uVDYMwGm7gmdBcP+zYz0OKzz0NkGAmsYsfGGwQY3GLkUBnDqmQfdKxO2E9
	Tev3UzxKA2bJvQgiD8sbOC5kLrm1l5uwPE2Ju0DCa1aRp7QOdHzvzvRucKFGKaii
	RbWwAg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xtj7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:25:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCAPl8K012315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:25:47 GMT
Received: from [10.50.0.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 02:25:45 -0800
Message-ID: <41f9caa8-9ff4-1442-1b74-e9e967245fe0@quicinc.com>
Date: Thu, 12 Dec 2024 15:55:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] wifi: ath12k: Refactor ath12k_get_num_hw() helper
 function argument
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
 <20241212004906.3087425-4-quic_periyasa@quicinc.com>
 <87zfl1pcgs.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87zfl1pcgs.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hs6QDzLpmnXK45EGY_EKBSZvhaSmYndH
X-Proofpoint-GUID: Hs6QDzLpmnXK45EGY_EKBSZvhaSmYndH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=782 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120073



On 12/12/2024 1:19 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> Currently, the ath12k_get_num_hw() helper function takes the device handle
>> as an argument. Here, the number of hardware is retrieved from the group
>> handle. Demanding the device handle from the caller is unnecessary since
>> in some cases the group handle is already available. Therefore, change this
>> helper function argument from the device handle to the group handle. This
>> also fixes the below Smatch static checker warning.
>>
>> Smatch warning:
>> ath12k_mac_destroy() error: we previously assumed 'ab' could be null
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
>> Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
>> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> I don't get how this is any better but of course I might be missing
> something. To me this looks like shuffling code around to shut up a
> smatch warning.
> 

It just remove the dependency of device handle (ab) for using the helper 
function ath12k_get_num_hw(). Now the caller can directly use 
ath12k_hw_group (ag) instead of forcing to use the device handle from 
ag. Because there may be error case where no device present in the ag.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

