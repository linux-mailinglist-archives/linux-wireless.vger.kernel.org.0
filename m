Return-Path: <linux-wireless+bounces-2750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B578418B9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63ADF1C22F9F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C4733CD0;
	Tue, 30 Jan 2024 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SkhRhStb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45A36AE3
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579681; cv=none; b=fOzkBddW/y7+8hPZYmOuevUmH5dcriyyRlktAnMdx8dTDMdbKewoGal9QcF22tidC1mye8TbS69CbYvYqELbpw1JUEC7wKS0XWKFJrbVTqC66OUh6GlGdXtVninf7cvH6UOeYs9tZvttftFs6dKzFaTW/xI8Jq98/JFIB4MjUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579681; c=relaxed/simple;
	bh=vv7M4+jr+0HxU42MCr/if5Ve5uAzBtZTHlTg0eo8qX0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=RjEoQ6nCFyeYOzYvZq91p9LML84rfeO4lMxyrqs/0hPo8rO82gUI5j7SxHuKnootlZn687tmOv0WPETYH5uGPmSwRmIasCx/0IGTPNd8sIDm/vgLr2HaRt2y/IZFUO2MnmZsKWSUh7zSljEOonypvGCU2ICyVbXFqoMu+rcX5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SkhRhStb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U1FbQK025534;
	Tue, 30 Jan 2024 01:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=teQ+3XzGq2EeqqQV54f5osFw36Cmaa7CP1XRveAhSO0=; b=Sk
	hRhStbhPQpw7Lm24cHnHTAGLbmeHi2IjrkdZkOew6qInR7NE6iV0c2yV3SuNHKNw
	1s6XD/eKpLUbPnZpQ+izec7m2kNqmeshnqDsqIqPWr+qRgGNX5AcvQUYZHO3W4xg
	Cld3Jhta6VloXuT9ZIat9hswatVPLWGvHZsDICME8aMeAvDf2tCz5tHuThccUwha
	Q02QTe+8rJ+F21m76ix/LuvVSbrTSSz2+jHhR5ZAtIDkv7PD7QbKxLD0pRNJNe6W
	XFCCGw72dDg/xEJgA2HoHG+QwARnTHHH4Jf5LrQSYciEoVeqjW2jlhtvFK1YvV3l
	A5IHrtgF3XRUld4WJ4Lw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx86htckb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:54:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1sZ3e002719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:54:35 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:54:35 -0800
Message-ID: <f03b0e3d-c4fe-442d-a8b6-d84deeed4337@quicinc.com>
Date: Mon, 29 Jan 2024 17:54:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] wifi: mac80211: add support to call csa_finish on
 a link
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-6-quic_adisi@quicinc.com>
 <a20310f8-bf6a-4823-8302-e45944f06f74@quicinc.com>
In-Reply-To: <a20310f8-bf6a-4823-8302-e45944f06f74@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qyKikIjBVcoPR0TCp0H7jxBDOe7aSVUO
X-Proofpoint-GUID: qyKikIjBVcoPR0TCp0H7jxBDOe7aSVUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=937
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300011

On 1/29/2024 5:31 PM, Jeff Johnson wrote:
> On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>> index 4427259154e2..a1a4f100d128 100644
>> --- a/net/mac80211/cfg.c
>> +++ b/net/mac80211/cfg.c
>> @@ -3543,13 +3543,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
>>  	return new_beacon;
>>  }
>>  
>> -void ieee80211_csa_finish(struct ieee80211_vif *vif)
>> +void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
>>  {
>>  	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>>  	struct ieee80211_local *local = sdata->local;
>> +	struct ieee80211_link_data *link_data;
>> +
>> +	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))

let's try that again, shouldn't the test be > = ??

>> +		return;
>>  
>>  	rcu_read_lock();
>>  
>> +	link_data = rcu_dereference(sdata->link[link_id]);
>> +	if (WARN_ON(!link_data)) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	/* TODO: MBSSID with MLO changes */
>>  	if (vif->mbssid_tx_vif == vif) {
>>  		/* Trigger ieee80211_csa_finish() on the non-transmitting
>>  		 * interfaces when channel switch is received on
> 
> 


