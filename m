Return-Path: <linux-wireless+bounces-7293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290588BE789
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4485282B53
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C91649DA;
	Tue,  7 May 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NdOcOwIQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C41635B4
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096146; cv=none; b=ljWGUX8suwbWn2eM0SKiBm/+ch31un+S3dqQEIT57CgQHw9T5RjyAL++snmH+XztnzNNr6Okp3OT5u0PLgBETQTez7ry5JVANJRbTgDifAza0DtIERDZ662eMBRPAOU1sW9slhTqNLB6AFPddVdiAgLlrndxL3DuxHLQOwXmfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096146; c=relaxed/simple;
	bh=DdJlUscjfkKDHBd70hz9KfvMc++xiFOi79NHEYsSlH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r/opBK62dEji9rxJvZYkiTdE6HFckOJiQsxKOa3ew6y/AostQgsMHfQwQe7U5mKc/M7NvixQyQdFnyrNzFp6oej+mK5Aicn8Zk0xFkcWzqNIXpQZ+H5XJvaIUMLycUjWWG3AHQ9thb43zANK0CNkr04JtXViu/dg8eXQ4bPIv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NdOcOwIQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447AhhqS015015;
	Tue, 7 May 2024 15:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7R6rjNwzGiuvFdAewTMFC9E8Qtuv1nnDY7lBgEbiPAw=; b=Nd
	OcOwIQXL45xUBJQq06cCq+SwSMKVSuIJWugx1ZLNs3QG1lyBXldc4PtfE2Wr2E1g
	GdOkUbYyiq/gQm4u9RIGxdOQZVSAibNr/xwF27gjiVl4FKR7NuEksxeCKi2xaeJc
	6oHg6exq6A9/vb26uziljA7lCy+98wjTGTzmcfvPNjemVmb0mMMKoj9QKDOvgGGt
	elh+jeyirUV5vU4QdWfJYMBfMZkTqhQZFdCvYoSEzos6EUbJFrHXytHP9Oq7i+Cz
	lFv26Hc2bnwzf6Bvkr6Fp0IyyCYO/gckMJ8H5hXJyA+FMJL/zHsO9cYofHSSQuJ+
	lFkaI+6LnoUskXpfIBaA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xygjn97es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 15:35:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447FZY8E015774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 15:35:34 GMT
Received: from [10.50.36.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 08:35:32 -0700
Message-ID: <3dfdc7c9-ae1e-c6c4-9018-0b97aa26c37a@quicinc.com>
Date: Tue, 7 May 2024 21:05:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC] wifi: cfg80211: Refactor interface combination input
 parameter
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240427031503.22870-1-quic_periyasa@quicinc.com>
 <3f8e4d6d0f2facde80ad82b5b3060eb0af0958a4.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <3f8e4d6d0f2facde80ad82b5b3060eb0af0958a4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oxLJRNj3_Jz9U2yTSFnO0QxLnk3_FNAn
X-Proofpoint-ORIG-GUID: oxLJRNj3_Jz9U2yTSFnO0QxLnk3_FNAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=921 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070108



On 5/7/2024 3:17 PM, Johannes Berg wrote:
> On Sat, 2024-04-27 at 08:45 +0530, Karthikeyan Periyasamy wrote:
>> Currently, the interface combination input parameter num_different_channels
>> and iftype_num are directly filled in by the caller under the assumption
>> that all channels and interfaces belong to a single hardware device. This
>> assumption is incorrect for multi-device interface combinations because
>> each device supports a different set of channels and interfaces. As
>> discussed in [1], need to refactor the input parameters to encode enough
>> data to handle both single and multiple device interface combinations.
>> This can be achieved by encoding the frequency and interface type under
>> the interface entity itself. With this new input parameter structure, the
>> cfg80211 can classify and construct the device parameters, then verify them
>> against the device specific interface combinations.

...

> 
>> +/**
>> + * struct iface_combination_iface_link - Interface combination link parameter
>> + *
>> + * Used to pass link specific interface combination parameters
>> + *
>> + * @freq: center frequency used for verification against the different channels
>> + */
>> +struct iface_combination_iface_link {
>> +	u32 freq;
>> +};
>> +
>> +/**
>> + * struct iface_combination_interface - Interface parameter for iface combination
>> + *
>> + * Used to pass interface specific parameter for iface combination
>> + *
>> + * @iftype: interface type as specified in &enum nl80211_iftype.
>> + * @links: array with the number of link parameter used for verification
>> + * @num_link: the length of the @links parameter used in this interface
>> + */
>> +struct iface_combination_interface {
>> +	enum nl80211_iftype iftype;
>> +	struct iface_combination_iface_link links[IEEE80211_MLD_MAX_NUM_LINKS];
>> +	u8 num_link;
> 
> Might be simpler (for the producers at least, but not really much more
> difficult for the consumer) to just remove num_link, use the link ID as
> the index, and declare freq==0 means unused?

Previously user able to check the iface combination with the new 
interface/channel creation independently with separate input parameter 
as below without knowing the frequency of the interface.

        params.num_different_channels = 1;

        for_each_vap(...)
              params.iftype_num[iftype]++;


when the user not aware of the channel but still they want to check the 
new channel creation possible scenario, in that case they just fill the 
dummy freq as zero and fill the num_link as 1 for all the interfaces.

So freq=0 is used here.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

