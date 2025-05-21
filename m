Return-Path: <linux-wireless+bounces-23206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4FABEEE9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4845D3B6980
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C4233153;
	Wed, 21 May 2025 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Alv6QJ7P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F405237194
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818074; cv=none; b=WV3bXa1NcudmY8mYbY+S5aZZUaU9RMdqVO3A5LtIN0UL4wtSUKU8QMWkl0QV1hGsNPf4LiYyFVtR/nE9A7PztmpcU2rydd/ze1GRUT2m9lez5uQ+GcU7WrWwkqgN/jFItdc4n6KMqfs9ihpwYPqoAmkhOtXAbtbvRhWp3x9Kwg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818074; c=relaxed/simple;
	bh=uyOZqUEOIqvnwFAzCQBWwsAmkmayMP09kTZlm9b9sQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b88KD1LOwb/JnGqQjQbOGOWqOxGMxR+R35SVHQ861zZp7VWg9cPaw/8e43Ww00iy4g2wsBOhdOUlLnD+6Ntdyz6fUllbB6N5DO5yCTSneZzOFba4heSYFWVRS1O1D81lVKY6yvxMAWqygO9vkdiuHn28nbLrwDeMG4zM/bHxl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Alv6QJ7P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L6QMFj026861;
	Wed, 21 May 2025 09:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lRTrAafg4/XOhFfs4sZKNdG+ERHWR2syWWaD+pKcuZk=; b=Alv6QJ7PSAfZHkmf
	5aSKUxA+JpKLTUX46WI8XGq6YAmZWKNv2Hm6yuvD5onb0L3yjFn2ASN2dRdaC/cZ
	byiKUUZfTmXLe8yXJ+Kcjp8UG1XXd1mFkIzI3sfp55R05qj0Qffavh9yhAxPA11c
	eXzh+cPl+OsUd0yq3xXG89tr2pu33tjOm/bOzsyz6aem8hJCLdUqdyx3EJzk4n4k
	IREKS3zMG2mWgnnQfIfTSfAMJ0LTRHz3cHV43jYj07GDltCK1PQxhugFk5HGwh8W
	j9pWMhZmo8WMedP5GhovET2zAbT6zbBAwJTV6vfh1iQQffvIC7Jd+kN0lVJBDZe2
	sB9YaA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9a95u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:01:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L918J8010085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:01:08 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 02:01:06 -0700
Message-ID: <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
Date: Wed, 21 May 2025 14:30:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold on
 per-radio basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0Shk0CUIlMz9JcbD_ynO49d782tw1txS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4OCBTYWx0ZWRfX/kg3Lu6srvO0
 Vn4I5Vh6W5fbI39+6J3M1KiE1t/oib5MWXpiasyNAYY/SeI0qbAZVK7AC6IfrV6BL5UUaJdyy2i
 Ftv9Gkq0/Xd2zLPm34q9v0KN60EiNe/H6+4NVv0HwZ7QanRqXswvyurnhwOCaaTI8s/2IcqZ945
 2ThovrxzAJ/xFeD9G3obJIOztfHTHJvynN73NdD9SSX79BAL5yQY3Hb1DUiFbjA7JSvyvvzvdtg
 EbWKAe/RBwVuX6wU9TmzkG3YGhv78qP7zXXa4yGCfld/czzdtcIina+Xboo+KoVWUQV/7GrHKhx
 T9DItDOwaKkjiBfZWt9143khZ8XXB05Rz6T5Mnc7t48pEtphbEqBRJVPJR4N5RRnwDmFR1Audm3
 Bkyfs/N3rusAwwqkIgAvXcmXy+6jro94SGood3h5odPAlpqdiwk3Z8yPbVQjn2KEZOL3Mt9G
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682d9655 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=4Mt3-w3Eu43CLoluh6oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0Shk0CUIlMz9JcbD_ynO49d782tw1txS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210088



On 5/21/2025 12:49 PM, Johannes Berg wrote:
> On Tue, 2025-04-29 at 09:30 +0530, Roopni Devanathan wrote:
> 
>> +++ b/include/net/mac80211.h
>> @@ -4569,7 +4569,8 @@ struct ieee80211_ops {
>>  			    struct ieee80211_key_conf *key,
>>  			    struct ieee80211_key_seq *seq);
>>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
>> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
>> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id,
>> +				 u32 value);
> 
> That should probably have documentation updates. And passing a negative
> value to a u8 seems awkward? Maybe that should just be 'int'? For a
> value that's likely passed in a register, u8 will probably require more
> (machine) code anyway.
> 
The following snippet of code tests the value of radio_id in
nl80211_set_wiphy() in net/wireless/nl80211.c:
+		/* Radio idx is not expected for non-multi radio wiphy */
+		if (rdev->wiphy.n_radio <= 0)
+			return -EINVAL;

This snippet returns an error if the radio_id is negative, so radio_id
passed to set_rts_threshold() will always be positive. So can we retain
u8 data type for radio_id?

I'll add documentation update in next version of patch series.

> johannes

