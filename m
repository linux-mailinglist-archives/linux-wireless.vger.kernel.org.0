Return-Path: <linux-wireless+bounces-6984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE2F8B573E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 13:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2486B1F21F01
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C994F1E0;
	Mon, 29 Apr 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IIaw46/N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE0611D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391802; cv=none; b=k1mavKF2Q6dwdTw/gz7L5cd7EVBVhyH5XTb4HfGU/xzfdJUE1Oh8NZNQpFBxD471taPdtY3XGfD+v2UmpX9OrimyzbXoHDKAGcEFCEdEf3PWfRqykVz/DaB+V54e3CmQXJ/94F7rwwfWdJSDujCLuJqQaDKK0adxip1vXTAm+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391802; c=relaxed/simple;
	bh=Xoyr4iX0BRNHt+qDn5P9Ko1LS/YyXHYUbOkFO9Y20GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E2YYuSBqFrZ8agABlvAUFNTFOHqEA5Ti8JChxR8uPaIZnxvqf6aEH5JRj7HWE/CnE4fOwjqs9Q7yn9EIV5c6QZsdNSpj+2AdFWIYDrUXBXfabUUFV9QHGtzPHgaFHbEK/MOIWhSUpYxaXjMtLSIeaSXU9ZLfXd4J3Psd4R5ll9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IIaw46/N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T4A3rr028353;
	Mon, 29 Apr 2024 11:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MjJh1Dv9I/CKx9Qt+PkjvrrOsdV3HuBhVQesvmIQnC4=; b=II
	aw46/N0uo7UsBRB8uq9yS0cF3s++CRyab44Fm2IEE2nTnHmJo6qFYn1DCSRGoxf7
	7MQAnOpBNVSpSAYCfj1fPcuIK9yrmW54xtdpqGV0gqkVLqB5hdBkkoFcXYFo51Dv
	y4sZqp1kPPjbFZQpwbikKndxk/1n251DUATg8NO3LKL9ScIFuoBVdNhFXLB8T/QF
	1Ohk27HqdWilwds5VAJRxgPzz8QNRowHYISB7Vmox16ZS7U1goWl0vGff9IQ1HLE
	YZtbEVZzDfSwl3OyMp9Mqq1Petao4brxhAALrMDvMEPxSDHOdNhHv2Kq8fMD5eAj
	jb6Egrp+OwCbvCPu+Q8Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrpqruvqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:52:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TBqqtW010945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:52:52 GMT
Received: from [10.151.40.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 04:52:50 -0700
Message-ID: <2c7b4eb9-9666-4a98-9e43-cc8ffbfc3a8a@quicinc.com>
Date: Mon, 29 Apr 2024 17:22:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: drop failed transmitted frames from metric
 calculation.
To: Kalle Valo <kvalo@kernel.org>
CC: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240419170314.3117623-1-quic_kathirve@quicinc.com>
 <D0QHV8UV73N5.2N5E3MH37JQW7@gmail.com>
 <f4c65f7e-ccc7-4a0b-a6e8-df56d5c19d7f@quicinc.com>
 <874jbsv2hz.fsf@kernel.org>
Content-Language: en-US
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
In-Reply-To: <874jbsv2hz.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WCPJXkBBUyI9BMQyTnyk5qzJhIMJgwC3
X-Proofpoint-ORIG-GUID: WCPJXkBBUyI9BMQyTnyk5qzJhIMJgwC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=823 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404290075



On 4/23/2024 3:12 PM, Kalle Valo wrote:
> Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:
> 
>> On 4/22/2024 1:35 PM, Nicolas Escande wrote:
>>> On Fri Apr 19, 2024 at 7:03 PM CEST, Karthikeyan Kathirvel wrote:
>>>
>>>> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_MPDU:
>>>> +	case HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD:
>>>> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_AGED_FRAMES:
>>>> +		/* The failure status is due to internal firmware tx failure
>>>> +		 * hence drop the frame do not update the status of frame to
>>>> +		 * the upper layer
>>>> +		 */
>>>> +		dev_kfree_skb_any(msdu);
>>>
>>> Shouldn't this be ieee80211_free_txskb ? I'm not clear when to use
>>> which.
>>
>> Yes, there is an internal patch is in pipeline, that will take care of
>> addressing all dev_kfree_skb_any() to ieee80211_free_txskb() in
>> ath12k_dp_tx_complete_msdu(), this patch doesn't take care of that.
> 
> Let's not add new bugs knowingly. Please fix this patch to use
> ieee80211_free_txskb(), that is much more reliable than waiting for some
> other patch.
> 
Have addressed Nicolas comment(replaced dev_kfree_skb_any() with 
ieee80211_free_txskb()) in latest version "[PATCH v3 0/2] wifi: ath12k: 
drop failed transmitted frames from metric calculation"

