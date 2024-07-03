Return-Path: <linux-wireless+bounces-9931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD29262D7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB6F1F231F5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4317B42D;
	Wed,  3 Jul 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LlD9TU8r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C117BB2F
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015635; cv=none; b=mraJxSKh5RWnJoW5ZJ3hvB6cCuw0dJDA1Mawb/MT9c8Pvzsn2SVDnE6xG3httBL3zW+T5Vi9B0JADrfxBvk/1amlGUvbsA8yKeAdIweRdaQqLSHdjD3O4/TFNwhDEQf+7V15onTLAlUe3T+2o1HN4m7R4rRKhOB80XuIPF0yIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015635; c=relaxed/simple;
	bh=Fbe+Q503Q8G3W0/OPxPOOeYBDmH9P4rtzM1eQkclAVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=de4GjgJkBMpM+6X1zsWTXRhgoD7uKAxDPrxaqEnycPhUPGsQ0jUWteXv2+FfkCu7ykZ2Z3eabWCf2mVsC9jgKSv2hJUiFsAQHh+oWbPBXPcQNPMIv8s1qehlz0sgd2wOGb2xjeOkaHu/SwAFp8ePJJ617n5XYIY7E4FwqSPnQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LlD9TU8r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637aobv007719;
	Wed, 3 Jul 2024 14:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g1gVsWunLdgoqO2JzetC81lzY+BhT+JSy73ahh5P2LI=; b=LlD9TU8rBySQpyt3
	MIV79xXlqa2vOz8o9eNoXrfIGnazPZd65t6YKE7EcleW6GYHR3Ip1xbF6J3A/Fd9
	xTPTaFJ/Edg3+bVcJvjc6pjw53VSAUEk78gOtLbLAlbFBcAeAS8aLut4XQsPauTj
	YSzyI48crHHeOHwzefmiHkjhg8HFQqvYWXpfuzlJtPD2Xlj+hQfg43OQxF4GejHs
	u/kLb7Ru8zk4842sZnwjENtTzAIpjqkq8ugufRbpwqmQQ62gGklRDm+cMqtHaqtr
	Fh/+GqxjnIId8M4xQ8VvNyT+7Zn0i9ia9Mk2KccVzP3UdPjimdnpf5pF2bSFDfUC
	3AouaQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402996s1vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 14:07:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 463E6xxk028788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:06:59 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 07:06:58 -0700
Message-ID: <5b98e939-bfea-4a16-a116-5a00d3497190@quicinc.com>
Date: Wed, 3 Jul 2024 07:06:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-next-20240702
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
        <quic_kvalo@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com>
 <87zfqzdkgh.fsf@kernel.org> <87v81ndk13.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87v81ndk13.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SdNsNH-RwkiiEX3lIFFpa_UHykK6-Akp
X-Proofpoint-ORIG-GUID: SdNsNH-RwkiiEX3lIFFpa_UHykK6-Akp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_09,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=2 lowpriorityscore=0
 impostorscore=0 mlxscore=2 malwarescore=0 clxscore=1015 mlxlogscore=175
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030104

On 7/3/2024 12:14 AM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
>> I see a weird warning from gpg which I have never seen before:
>>
>> merged tag 'ath-next-20240702'
>> gpg: Signature made Tue 02 Jul 2024 05:55:42 PM EEST
>> gpg:                using EDDSA key 3F9AD487CCF522D7A21F0C492C15BBA0898CCB7B
>> gpg:                issuer "jjohnson@kernel.org"
>> gpg: Good signature from "Jeff Johnson <quic_jjohnson@quicinc.com>" [full]
>> gpg: WARNING: We do NOT trust this key!
>> gpg:          The signature is probably a FORGERY.
>>
>> It first says that the signature is good and then claims it's a forgery,
>> odd. Is this a problem between using different email addresses or what?
> 
> I did 'gpg --refresh-keys', now your key contains your kernel.org
> address and I don't see the warning anymore.
> 

There had to be at least one issue with my first PR. Glad you sorted it out.
Key management is still a mystery to me...

/jeff

