Return-Path: <linux-wireless+bounces-23021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F73FAB8D00
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CA83A86BB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FA91D79A6;
	Thu, 15 May 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ffjOmYcM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9106A253F17
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328332; cv=none; b=G5EcJkFBnaScnLUuiZS+cIBFpDPyNiHAUi1LA8JchKGQnPwsY+FKcM3gVFdBE5hBKg+plm+ckht1SbHbH10OFWf0kO9gB8SlYlkvgY7D9Y2ylgo5ms1X/8LWJMujQ8kTLz0Qa7OUA5ve7C2p1/QTsGqPchQWaHqkTkl1YAw74kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328332; c=relaxed/simple;
	bh=eOAIpr3ef/ED0Oknm54NmzOGIaCXGGKGuMq7vrnrW7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s829ZADEjz1MLbq56YwUwdkCHKDyz7GyeeaZa7SMvAq5fGiwybpHg+G+jkOlIZGH9+gJermPGPuFXRsQaQmEG5gVumSELWb/7ZwYhysbfNHukJZRLyLu/Pr43LWz+qVmR61YDstxO+VzImJ//trYiQ1NOW4fdLmap1eJsMo2M7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ffjOmYcM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFCG7020842;
	Thu, 15 May 2025 16:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/Hg/KfcNfN/jWsI1M+J2YiFFmeg37JF2jVuLVoFhQ4=; b=ffjOmYcMg12ybsDo
	4oRZI34PJ+Q7jnh7UGHSQgloj6bjjmKZSBwYMv+brvF/7n31XMm10OaDukzdcB01
	6D0EhIkSHSRtuo6wCZxphZapHQJnK4GS3/CPvSNtKXYpkfKJGyNLyAPxxQnDiazo
	Ir5VzGFR1IEN2vjmJM3UoLsIZ2GPxfZidXU0rX04CdzOx4rsPQkGloVl5aKwo+j5
	0dNY4IrQUStmZB86S/+12VLfsrzpG9AiG1v1FzcbjpenbHdnpkFghsSrYarL1pYv
	mrKv+ltW37vYU0DtnqwSNKehoQtHxLXalXuOWCZZbJmmdbpk8dLrGIMgph2nB7SM
	C7vfAQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew6v86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:58:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FGwjB0010012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:58:45 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 09:58:44 -0700
Message-ID: <999eb0ee-f49b-4ea8-93e6-78e3c2fe5e8c@quicinc.com>
Date: Thu, 15 May 2025 22:28:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-4-quic_sarishar@quicinc.com>
 <16406ee04378160b2f9cc8f4ff5a233c45be2e94.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <16406ee04378160b2f9cc8f4ff5a233c45be2e94.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8wZcxkTFUCSAwDQV3dNtWFtFKet_eprJ
X-Proofpoint-ORIG-GUID: 8wZcxkTFUCSAwDQV3dNtWFtFKet_eprJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2OSBTYWx0ZWRfX/+LH3TiGMTLE
 ZtKRiEBz85EA2NkEtGhdKXmoLnVEqjgnv1fizILJqwMKwdqGov54A5VIkomWgxqxHHedJYY7mo1
 bpjXXu3GA/0JfDXYos9YFPlEpV97PCblHhPVSagTZZyL10YxrBrDQTK5M+N0pwCaWfxQw7taJ7U
 6twk0tk3/Zriit4ajOpxRato2RibVW5Ml4ZAJlaEZ+EeBCgTQXwvtJTTviZN/0tGNBegZqXvKr1
 HAlOearJUEyahBWSb+pHMwaIp5z08h5dJuMKL5AJYOOB6C6r2x0RvVncNUhSd1nHiF9cdA/zNLs
 HtKx09Z+v3IjxLpyAYpCCRyckPz9eN1yamkkxi/fNi4FY4suExQvp3su5CN2N4FUl14ZD7cklZX
 PQRfClfxqhwPPjXO4WiOfEYmDu7mhTKZ76KBqgdLbBS4/TXX7X22MwePIvFdfKMIe60m/lYa
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68261d46 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=DvksfcsVRrX3hVZGHkcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=894 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150169

On 5/15/2025 5:04 PM, Johannes Berg wrote:
> Oh ... missed this one when I sent the other mail. And really this is
> the one that I saw and decided not to continue fixing things up myself.
> 
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>>
>> @@ -6880,7 +7062,8 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
>>   #undef PUT_SINFO
>>   #undef PUT_SINFO_U64
>>   
>> -	if (sinfo->pertid) {
>> +	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_TID_STATS)) &&
>> +	    sinfo->pertid) {
> 
> This breaks mac80211 at this point. You also never even mention it in
> the commit log.

oops! Yes correct with this the pertid will not be reported to user-space.

> 
> Ultimately, I see why you did it, but that's really not how we do
> things. If we cannot get away without this, then it really needs to be
> split out into separate patch that doesn't break mac80211. The change to
> fix mac80211 is also randomly interleaved into a commit that doesn't
> even mention it.

Sure, let me introduce this as a separate patch.

Yes, this is needed when we don't really want to report the pertid at 
MLO level( as currently pertid is one of links data(deflink) for MLO).

or may be we can directly free the pertid memory in case of MLO in 
cfg80211 instead of relying on sinfo->filled bit for tid?

> 
> I would prefer to not do this, but if we really need it then you need to
> split out this API change and do that properly while fixing all the
> users.
> 
> johannes


