Return-Path: <linux-wireless+bounces-27208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236FBB51328
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30AF3ACA14
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CED257AF0;
	Wed, 10 Sep 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zpb3u921"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381D1DFF7
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497777; cv=none; b=VHoemutquvB0wLiuxWz4saNfTgfrTEnE+ztziJcQx2j7rGEi6XRd3XnbpAtm2P6Ogsewm5A+UCuH6r+jkYTW9TtvwJXGbnPwm6t0/1bM2Y3yt0MNO87ILPKb3kWK1Aar3p5xPe9M9KfzMz3Mb9V4CIMQs9prYZABj1VgVvOo71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497777; c=relaxed/simple;
	bh=+L2jH/MBEiiDXN4GZpORGpPAp2mz4RxLae5KBurPgOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g03PPCw0tOAsaSDRo8Y3Ow1x5pbW2dfOppHgGNuZhFPFLLSz6/n5iiyyB0FCWBZXdrVRyK3h8nf8IZKgURRrsQH5L2mTBFPFsngznOF0BImL0mJY9oG2PgOT+My8ehuPl//B4YREwISTUGMR6lc4q8NOvgRMVcpXq0hT5CEzTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zpb3u921; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A96xch022731;
	Wed, 10 Sep 2025 09:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G68m/ySBIu6L5lWKY7fRneAs6S6k+NhjBFjB4wONai0=; b=Zpb3u921bupDJC6M
	2nnYppd+gsnUiRBVwB5LAMUYP1FMSGhmF7iWV5bYMxZ15TBU/eamxDVY3hIVrpb0
	59ewaJGl7RbpyxIx484nK1zEuIj5N4uGDHPHdu6dlRcQKgI0L0PFbFoMY+1s1AoZ
	V6Y775p+TdAvXQGq5NcCamMu06s9CZlSdDYYMf4vC3f/GUJPP1ALHy1TWjRzlY7n
	zcPkUUsrJ96pWyvdd/aU3O2YjeP7IbubXZdjCbyeUeq4A/CpOr/nbudSip7+PZMz
	nzjfirDxsIykx/Ma5nbJUQkbn2WYnDEmXe+XhKId2AcQi3dqnn8tWpvR74w3TA7Q
	EF/3dw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc27f5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 09:49:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58A9nVbg031512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 09:49:31 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 10 Sep
 2025 02:49:29 -0700
Message-ID: <85358884-244d-4f4f-ab8d-88b5b33085ec@quicinc.com>
Date: Wed, 10 Sep 2025 15:19:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] wifi: mac80211: fix reporting of all valid
 links in sta_set_sinfo()
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250904104054.790321-1-quic_sarishar@quicinc.com>
 <d7f5ec2d5ffd5af8ddc45f419494d6abdf0f154f.camel@sipsolutions.net>
 <27456d3bf4d8df3d0f15c8617e2f42777b3a2255.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <27456d3bf4d8df3d0f15c8617e2f42777b3a2255.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c149ac cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=AmLhQBzSfJCtqoq4_XEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WWZYpB95KlB2YCStC8XOWHYnxylz5LfR
X-Proofpoint-GUID: WWZYpB95KlB2YCStC8XOWHYnxylz5LfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX0/uKdQZtPD04
 bMv2ZHt596k8E6TUR1f0Cyp0UeTCLyvGTRzZSZi+W/5tBYlCz87dBVSaeRlbJ1/cc0gY28Zhz7D
 rCNfux4a6MEhKt6SEJ5J+aYTtuDO3rdRO/7jxV27weu/0c4IFJA8s+g+BAP0yPjh2l3Sypn+ZUL
 f1yU5N2bOBrDaE98rFap9y2xC/P2ojduEst86Y1X5rP027oWvNDb1W6W9SlsFT7O896x1eP8wFm
 cOE7MKsu+Jmq6tdQwzM1pmFUujlUD1feDiIIsk/MTPOZEkt61eDtaGXMw+EsDY/8y6ePIreuTnm
 wP6cPu4x9nkBIHP0xWqXRyr7tyvPtPgztMF8zjzY5xZ6OEIKMMNS5l1wbgWekrFd5XaioCUdC54
 4MpVCXue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

On 9/10/2025 2:15 PM, Johannes Berg wrote:
> On Wed, 2025-09-10 at 10:42 +0200, Johannes Berg wrote:
>> On Thu, 2025-09-04 at 16:10 +0530, Sarika Sharma wrote:
>>>
>>> +		/* currently assigning all valid links to sinfo in order
>>> +		 * to iterate over all possible links
>>> +		 */
>>> +		sinfo->valid_links = sta->sta.valid_links;
>>>   		ether_addr_copy(sinfo->mld_addr, sta->addr);
>>>   		for_each_valid_link(sinfo, link_id) {
>>
>> To me, "currently" implies this code might change later (as in "the way
>> the code is currently"), not "at this place in the code"? Maybe that's
>> just my understanding of English, but anyway I've changed it to
>>
>>                  ether_addr_copy(sinfo->mld_addr, sta->addr);
>> +
>> +               /* assign valid links first for iteration */
>> +               sinfo->valid_links = sta->sta.valid_links;
>> +
>>                  for_each_valid_link(sinfo, link_id) {
>>
>>
>> which seemed clearer.
> 
> Actually, wait - I'll still want to reword this, but given the whole
> netlink size issues etc. we don't really need this patch on wireless
> anyway.

Okay, sure.

> 
> johannes


