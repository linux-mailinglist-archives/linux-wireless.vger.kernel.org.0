Return-Path: <linux-wireless+bounces-15312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D79CD521
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 02:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52059283DB4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6F6664C6;
	Fri, 15 Nov 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IqesY7QK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DF43156
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635176; cv=none; b=sYMkBeGG1Rmf0Z8twr1ekg7pWKnVGc8qp+S8jHzKCXNQfjxOjqrt9EwvVxES51xcWqg1fNMlqLoFirwWZSK5RnyGuoRwme6Q0TI9Esy3w21j6AgRsnCgafNkWRnSY3F7mbRhJr1PbD+RkyC/dEEB8ywp6fPvFYOl98EpaOhCDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635176; c=relaxed/simple;
	bh=uKKH38c6OAZAjp3wFCPJmR1ZHz74eKuw8ZtKLUAWcUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H6LhT2LlbmGvJgfSkgworoFWL0ehJZMbMyMbLSMie3+M0CpYuxyLBOViD0REYq46EsebPw6NI+5xL0C1vOhZvEyqeG7HXz5ycTCi3Gc5PBQZ5UXa0YhDhA2CK1fYvyFvx5WoP7jzeM5yMRZu9htUqTYAheaQXRyQ9YiC5zBZx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IqesY7QK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF1hwNp017656;
	Fri, 15 Nov 2024 01:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q9Fz3HBPIyx05z4I6SuREAeYSEoayi9WTKBak/CTD9A=; b=IqesY7QKswFXwAms
	uxf29/Z6h8BYV2LXrM2sy8Tz/xXWHX4MFCM+F/qCnJVYHqixlzwoKSjhXAtwXMsJ
	lCRzZmvjFWSfg9EMsLtrvwfCPYCOh7nbkSnmW9nMyCiqtj1xiCZX4IO/xbyrXYLq
	lDqq+bQdkAUUuElmnARprUlb2tnoWy22Yb5mBbGUKzuqaDtFX3SPUy3ze9NGFA3H
	cWhVPliSSH0pd8wIAIr5+tKoFWlHPP6rON9z7Mk4YCXn9nZg+wa2nrOY93+haEfY
	o52RksvxbAIvZFsVMTABizcY5H4qiw/EaNZtYQJRHTXFkwf9iJsDVr7W2bLX5bi8
	AHx8mw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wvw2g0db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 01:46:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AF1k8Sm017830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 01:46:08 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 14 Nov
 2024 17:46:07 -0800
Message-ID: <b64fdc5d-3c58-4976-b9e8-a51870f89e4c@quicinc.com>
Date: Fri, 15 Nov 2024 09:46:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] wifi: ath11k: move some firmware stats related
 functions outside of debugfs
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
 <20241113015631.3105-4-quic_bqiang@quicinc.com> <8734jv2xnd.fsf@kernel.org>
 <7917a344-82aa-4ef8-9558-554743c5dd15@quicinc.com>
 <878qtm1236.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <878qtm1236.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -moXrxo143oR4Ohtf3HD70tc9FkfdSPy
X-Proofpoint-GUID: -moXrxo143oR4Ohtf3HD70tc9FkfdSPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=872
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150013



On 11/14/2024 7:34 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 11/13/2024 7:14 PM, Kalle Valo wrote:
>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>
>>>> Commit b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
>>>> and commit c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")
>>>> call debugfs functions in mac ops. Those functions are no-ops if CONFIG_ATH11K_DEBUGFS is
>>>> not enabled, thus cause wrong status reported.
>>>
>>> What do you mean exactly with wrong status reported?
>>
>> ah, thanks for pointing that. actually no wrong values reported, since
>> we are not even reporting anything in that case. will be accurate.
>>
>>>
>>> mac.c is quite large already, making it even bigger is something I would
>>> like to avoid.
>>
>> then can you suggest any other place?
> 
> I first need to understand the issue we are fixing. Is it ath11k does
> not report rssi and signal via ath11k_mac_op_sta_statistics() when
> CONFIG_ATH11K_DEBUGFS is disabled?
Yes, Kalle. If CONFIG_ATH11K_DEBUGFS is disabled, ath11k_debugfs_get_fw_stats() is a no-ops, so no WMI command sent to firmware, thus no WMI event and therefore ath11k does not report them.

> 


