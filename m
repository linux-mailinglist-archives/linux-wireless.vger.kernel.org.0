Return-Path: <linux-wireless+bounces-14650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A59B4EC5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48694B240E7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95D3234;
	Tue, 29 Oct 2024 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TXlHvbMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E5802
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217701; cv=none; b=LAHcR8xjfKOcBzOuTBTq6bsA4ymhztvUeBSHh/kHLbaeqUmUio9vd1c+UecnAIhS97xZ2MB+M89hgbXYvzvB5eTTDMW4pkn+jnpDIydeYnP4e+QmUNVbcT2B9yfOunlNP6IRTPSWXPrTqJ8q6bIpM8jqYR2YwfYMU5LK2B7iTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217701; c=relaxed/simple;
	bh=FFHYqRJfsVj+MRlemLxqBLhgXSlh2n//xukTPG71Ct8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cmTlc3rivli3EDNgdC2Qebvb3qT7YybbXBJ2U5LP8MQfYV/UM9OZCxSz05k4TaR3PVUayoJhYjhJYpefyXH2Sl0rE8mh/JT2x/e138j2sbXmdw6XpIxso09ChuXSve9RyJVUFYXJEgNHhx/PZbpoHgHxoMP8rUy1soJzGwkuAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TXlHvbMs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAB17e027417;
	Tue, 29 Oct 2024 16:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hZ+OJTs2nsTDS/krlxYK9xQhV6/636e0n2W/f26Gq+0=; b=TXlHvbMsIg/x3qV0
	r2bc2ecNp178MWM8YqAyCrZaun5NAD2iXle08mTjCNriMv7E4ZNgSkuQpS/8uD9x
	EZHGVvXMq9ErHZsPN+nUhJCZz9fVPgmRptXsTEZXWkAxVN8QMw1vmi1k9mopbwi9
	xpARmURXoR6bGWR+IgQexzdH9wguubXVAFo8L+eCczAFtqmxRkMWxL1L4+ytgA/m
	xHCrIBnKrljoePu/WAUewWIUKbIHm8aOCIO31RIWAWzrYWRSBgjCFQ7GTQhtVfBD
	ArRJQSM6Hw8+rIfrgDZlDTvdOeS35/XPoiQG1skfl9etJwGbCKHnX/X9V30PSnpM
	epuC5w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gr0x8xma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:01:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TG1IiL011216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 16:01:18 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 09:01:18 -0700
Message-ID: <8d4aca1d-e48d-48e2-bacf-fdfe49c8e212@quicinc.com>
Date: Tue, 29 Oct 2024 09:01:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create
 command
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-7-kvalo@kernel.org>
 <f8049c99-c7ac-410c-84fd-ac844041f34c@quicinc.com>
 <87wmhqgb0r.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <87wmhqgb0r.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GDeTszg1gB2OEeKn2HDCLXv92KZNNdsy
X-Proofpoint-GUID: GDeTszg1gB2OEeKn2HDCLXv92KZNNdsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=696 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290123

On 10/29/2024 8:54 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>>> @@ -1244,9 +1249,23 @@ int ath12k_wmi_send_peer_create_cmd(struct ath12k *ar,
>>>  	cmd->peer_type = cpu_to_le32(arg->peer_type);
>>>  	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>>>  
>>> +	ptr = skb->data + sizeof(*cmd);
>>> +	tlv = ptr;
>>> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
>>> +					 sizeof(*ml_param));
>>
>> using the same TLV size both here and for the TLV that follows doesn't seem
>> logical. is this missing + TLV_HDR_SIZE to account for its own TLV header?
> 
> I have forgotten the details of WMI voodoo so I can't really comment
> right now :)
> 
>>> +	ptr += TLV_HDR_SIZE;
>>> +	ml_param = ptr;
>>> +	ml_param->tlv_header =
>>> +			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_CREATE_PARAMS,
>>> +					       sizeof(*ml_param));
> 
> But did you notice that here is used ath12k_wmi_tlv_cmd_hdr() and it
> reduces the header size:
> 
> static __le32 ath12k_wmi_tlv_cmd_hdr(u32 cmd, u32 len)
> {
> 	return ath12k_wmi_tlv_hdr(cmd, len - TLV_HDR_SIZE);
> }
> 

Yes, I missed that since that is evil to use the _cmd_ TLV function on
something that isn't the command TLV.

Please fix to use the standard function and subtract the thv header size from
the length param



