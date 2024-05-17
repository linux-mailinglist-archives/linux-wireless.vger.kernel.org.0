Return-Path: <linux-wireless+bounces-7758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232AC8C7FC8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 04:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FBE1C20CA8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 02:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE9186A;
	Fri, 17 May 2024 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XhdPQRM1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B85184D;
	Fri, 17 May 2024 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912064; cv=none; b=ngjp66nHjGXzhbfDlhnWLMIV44vr8ZY9D4rGgoYZeQtcllhLt/0VZhoPe/UnHpxD/dW434J9f09Pv2qrSfVxV0XWj6uN2EE4bh2swNqTEixdSief79Gj63+dTW30o7dxZerQD13AAbwUGp+DTvVKFur/8ShQy2xGcfpRgFR+hKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912064; c=relaxed/simple;
	bh=9kc/oJ+LKGvFKghk8rUdhHMgoRAqtU1J9GB6SBn2TUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=skmfJl/eeZ7GqpYd0Ifik05h79TEFxkhwkEmZ87CaMGFeRScs3o9gz+N2gqCKa8ndMiQHttVF57okMY2A9pjUgu/9R3eJ4HtNkW6AvVeOnzwZfBTEeJhnGBRG6s8EmSl190q6CUj8VyI8yJnMEs2+2vhPPcaX+jigJJzXX9M4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XhdPQRM1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GKMdWD008019;
	Fri, 17 May 2024 02:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AmfpQ67vGkjrHe8EPs4wE3bFehFC+xH1HSH2r5nyTYI=; b=Xh
	dPQRM1xUekLNsI2gzxxXbP0GzBXOT/43NuZqbPe4OenEszKti6iTpyP+6QkehxjA
	y/+EAdkvl72UWs6iltWuTgY1krQ59xQxDmZJHJGE1vfD06pPpN+aAk6Q9KQEX54/
	OEfl/TGJ/UE+OewBVpOyc1BfOR8NQLUGyPGf6+8D8yj8hupyCyW+8AmiIgRZbar0
	fGxbXgKSNOdbv4dUSCbzawKg0c/JjTlm56aNimV96xswFX2GTZ6sKpNl741e0QUt
	349qjUv2yVI1KZQj/tJGadpTddP9TWq+mGcgUClG+wIWDrqGvsfFGTlop7HclCpW
	0i00OwGApDxejwLIxVGw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vbf8ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 02:14:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44H2EB65013676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 02:14:11 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 19:14:10 -0700
Message-ID: <3dc28f34-45cc-4e14-b9ea-1f7b78a6a591@quicinc.com>
Date: Fri, 17 May 2024 10:14:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <regressions@lists.linux.dev>
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
 <87wmo0k71i.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87wmo0k71i.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MwXzAFYCYenCKVLn5BKyi-x9OFRtwa7I
X-Proofpoint-ORIG-GUID: MwXzAFYCYenCKVLn5BKyi-x9OFRtwa7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170016



On 5/11/2024 5:54 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>> ath11k fails to connect to 6 GHz AP.
>>
>> This is because currently ath11k checks AP's power type in
>> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
>> However with above commit power type is not available until ASSOC stage.
>> As a result power type check fails and therefore connection fails.
>>
>> Fix this by moving power type check to ASSOC stage, also move regulatory
>> rules update there because it depends on power type.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
> v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
> need to queue this for v6.10 via wireless tree.
> 
> Adding the regression also to regzbot:
> 
> #regzbot introduced: bc8a0fac8677
> #regzbot title: ath11k: connection to 6 GHz AP fails
> 
Hi Kalle, with an upcoming patch this regression is expected to be fixed:

https://lore.kernel.org/all/20240506214536.310434f55f76.I6aca291ee06265e3f63e0f9024ba19a850b53a33@changeid/#t

So here the ath11k fix would not be needed any more once above patch got merged.

But I don't have time to test this, so suggest keeping it pending. We could drop it once above analysis got verified.

