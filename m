Return-Path: <linux-wireless+bounces-25087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD3AFE46F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1590A1C4448B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249F285C91;
	Wed,  9 Jul 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jve4vwER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23B284686
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054171; cv=none; b=PhUqfdf8YlalfxWM5aD2Igm+rcyhyg6C4pOoSotxUH3Ci/nFdzsoKPUnQ78bG4qGB5sLciYw6VsW2/UQZIufOqmJBl6ptazT1QagpNj7Xv8yClyf42cML6bBmcMSh2LnP5FdK44yGKH543aiC36ZO7V55O80yI6gu5pu+qsD8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054171; c=relaxed/simple;
	bh=fBagXmBYAaqwTAW0n1oNeRMF4TMz/TXw9Q0TGE8Kogk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HOAVZ6Yi68+G3I75fMS0Fij9V2A0+AVuvsWmZoTTaLHbY9YjTKIFPRYgqIY3c7SlP1rOTT3ZeMR5Ecznc8/MabNPpJxnwgtXq7HzG5HdxOkX8CqBkH0VB6nUn601Ta1/oqiVTP59Me3zaDo6ADridBz0MDMuQ+rUy1umVw7Wklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jve4vwER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697jcRd010288;
	Wed, 9 Jul 2025 09:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RPYvA5vSmHpUV2IK4qsXPlLV4jdUjIeekLEIW4CvMGU=; b=Jve4vwERGPQrQHgf
	dIHxidf80HEjTJjas2aGGy4A46g0qvEwtT+o+FLYEcB60tyWUrJqD6oE8eq46SEx
	A9vZud3Ow1rSmttxQ60mmrlA4WaUAf0IXOUaOUebkyKChQsTpSwnc2Hs7xi8JE2u
	rcATH1kMNAE8cFB7l908mF1/XmLnnkrWCTtIHf7ExVGX7GBP5jfvkud1BL087Ov/
	CejFEdiGqmP2rGtnXgdn/LkhEqk5+Rev3mQ61+opaWSjIe64Zh0CZfPMYO2awLWn
	NAgaa1D/uAPYoJ/BHdbHwdqVEDpzEGCXAcLcDJblSs8rv1hn1G6TFv7XFQBm1/Y5
	Cqolmg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap0ccd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 09:42:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5699gZmJ018467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 09:42:35 GMT
Received: from [10.151.41.2] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 02:42:33 -0700
Message-ID: <b875682f-8645-4aab-8946-78a10fda134f@quicinc.com>
Date: Wed, 9 Jul 2025 15:12:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 1/2] wifi: mac80211: extend beacon
 monitoring for MLO
To: Johannes Berg <johannes@sipsolutions.net>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250626160713.2399707-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <20250626160713.2399707-2-maharaja.kennadyrajan@oss.qualcomm.com>
 <ee3286c8e7d869b066e1f39cf7707f2186cd45cc.camel@sipsolutions.net>
Content-Language: en-US
From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <ee3286c8e7d869b066e1f39cf7707f2186cd45cc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686e398c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=3zBYkr6dedwpUm-ps7kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XSY1m4vjdn12VXRDeqvS_48gkf3YLGYv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA4NiBTYWx0ZWRfX47rnNQ7mSroq
 kDbSQGGgQ8VAfAcWZxwEf7eCvJoAIlanfqPsfD31Tfo8ni0fFT+386fkVpgUZPZWxGsDq7xMHfK
 oaWBgFaQVIZxLwboZaaVNg4zdc+8O7lafrMrox0eonlxZ5h85+SYu/GcobEnEuSx3liLXzav9j9
 /GqD5d5IyNF494Bi/vHxNv22Ov/pjJikv/pLlspB78cDD9GxxArf/JkSqDJyaWUwL4w94f/oe9z
 oteWAYKNg9tXxK8S1OsMn7gjs1WmHbuRGGBBQIKAtTu8Lralxv07DTZ0Ov0DymSy9jEP3BDY8CD
 BzVBKAJUoDd74W5ikqOB2djkPjTKnTzl1bsbwdRsrVOIVMd2E+LddnJpiSKRvuY6QWAfPTfz+5i
 sjyLGNCZmH0WfnaIhZSaKiE598K2e1xCsBYNex6OtWVNKtkAXCDb9exssgVj/EAuDcaGxYoZ
X-Proofpoint-GUID: XSY1m4vjdn12VXRDeqvS_48gkf3YLGYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=784 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090086


On 7/8/2025 4:32 PM, Johannes Berg wrote:
> On Thu, 2025-06-26 at 21:37 +0530, Maharaja Kennadyrajan wrote:
>>   
>> +static bool
>> +ieee80211_is_csa_in_progress(struct ieee80211_sub_if_data *sdata)
>> +{
>> +	/*
>> +	 * In MLO, check the CSA flags 'active' and 'waiting_bcn' for all
>> +	 * the links.
>> +	 */
>> +	unsigned int link_id;
>> +
>> +	guard(rcu)();
>> +
>> +	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link);
>> +	     link_id++) {
>> +		struct ieee80211_link_data *link =
>> +			rcu_dereference(sdata->link[link_id]);
>> +
>> +		if (!link)
>> +			continue;
> We should probably add for_each_link_data_rcu() instead of open-coding
> it here, even if we'd only have a single user for it now.


Thanks for your inputs here. I will add the for_each_link_data_rcu() 
macro and send a patch and will use it here.


>
>> +		if (!(link->conf
>>
> I pointed out elsewhere (possibly multiple times?), that this check is
> useless.


My bad. This hunk got missed here. I will fix in in the next version 
along with the for_each_link_data_rcu() addition.


> johannes
>

