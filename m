Return-Path: <linux-wireless+bounces-14653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C99B4ED7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4223D1C22975
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A056196C7C;
	Tue, 29 Oct 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aiBx4ada"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEF197556
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217879; cv=none; b=p6E5CIYCPjQkKQiQd70MtIQs9KIj0m+z/M77+KY/D7oiDNGyikpeH/z0Igj6NX27WLpkpxgrEQQJoeYTVJUL99KYaFmG/ZXvSbGyt96asZijWXg6i/lt165hZKu9psQE2FEKdv87hdZtGMdMh9xoQv7LciwEtRWK87ZKkEldz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217879; c=relaxed/simple;
	bh=1evhB4HKmzwxeUNRBYtMqLa/8wpno6RIDdNIwk4S2kE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=RHG5/4sLOzgXRUw/7nXSBUSobmHRBc2pST0HC6a4f1Sn/hI78t0X+oP3EVJX5x0YNFj4MV7Xgw+T64+sHVnBS69Z5UhdNkX38Tz1waCVMLGUhcoLtOh92NXwLh7lOKsBgJ505+sAvnBe6GT372L7x1AmU78wnm8iGtV4uB1224M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aiBx4ada; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T8oo0G028890;
	Tue, 29 Oct 2024 16:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aYiJoY8A5pMBR/rhMRuFhjOCgQjdrkdDOjvUWidb9uY=; b=aiBx4adaMtjVQVUg
	N9x2MjqMbn0mZ6c8chSTxutECxx/0zwfkGwV9A8HfGLLinKyPu53XeSJzO+5j5q4
	qENQvUYAqIoNP8AUAk8fqwB19ya3rmUK4Exhb53D8J5uFVxMq/+eZIj+RQTFrddH
	yCGEQhdqJ/rjqfTsxW5L/saHCd0lldEBvbjZ6RTLwH/adpXBozFQSXgK9PfuDV+S
	miUV+EgVSmMFoVqJv61JpC8duU2iic2o92kyCbSTukgN4umJGitAiOXolxCCEX9X
	1xR4dcBJPVc3MTEHI4Tfs5FHnFmr4nKWn0WcPFc5YQRJDKOrOdd9TcTq5smnmXbl
	ViApnw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8gyth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:04:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TG4V3K017410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:04:31 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 09:04:31 -0700
Message-ID: <682c898b-7143-42a4-bca6-07f4d178fc44@quicinc.com>
Date: Tue, 29 Oct 2024 09:04:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create
 command
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-7-kvalo@kernel.org>
 <f8049c99-c7ac-410c-84fd-ac844041f34c@quicinc.com>
 <87wmhqgb0r.fsf@kernel.org>
 <8d4aca1d-e48d-48e2-bacf-fdfe49c8e212@quicinc.com>
Content-Language: en-US
In-Reply-To: <8d4aca1d-e48d-48e2-bacf-fdfe49c8e212@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8diI7z0ZZWcwaOYefqiJC1EaX77M7P6F
X-Proofpoint-ORIG-GUID: 8diI7z0ZZWcwaOYefqiJC1EaX77M7P6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=759 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290123

On 10/29/2024 9:01 AM, Jeff Johnson wrote:
> On 10/29/2024 8:54 AM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>
>>>> @@ -1244,9 +1249,23 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
>>>>  	cmd->peer_type = cpu_to_le32(arg->peer_type);
>>>>  	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>>>>  
>>>> +	ptr = skb->data + sizeof(*cmd);
>>>> +	tlv = ptr;
>>>> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
>>>> +					 sizeof(*ml_param));
>>>
>>> using the same TLV size both here and for the TLV that follows doesn't seem
>>> logical. is this missing + TLV_HDR_SIZE to account for its own TLV header?
>>
>> I have forgotten the details of WMI voodoo so I can't really comment
>> right now :)
>>
>>>> +	ptr += TLV_HDR_SIZE;
>>>> +	ml_param = ptr;
>>>> +	ml_param->tlv_header =
>>>> +			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_CREATE_PARAMS,
>>>> +					       sizeof(*ml_param));
>>
>> But did you notice that here is used ath12k_wmi_tlv_cmd_hdr() and it
>> reduces the header size:
>>
>> static __le32 ath12k_wmi_tlv_cmd_hdr(u32 cmd, u32 len)
>> {
>> 	return ath12k_wmi_tlv_hdr(cmd, len - TLV_HDR_SIZE);
>> }
>>
> 
> Yes, I missed that since that is evil to use the _cmd_ TLV function on
> something that isn't the command TLV.
> 
> Please fix to use the standard function and subtract the thv header size from
the *tlv* header

> the length param

also note there is the existing inconsistency that some WMI params structs
include the tlv header and some do not. IMO that lack of consistency will also
impact maintainability.

again something for the TODO list.


