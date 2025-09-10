Return-Path: <linux-wireless+bounces-27199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E1B50C52
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 05:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C2A1BC6F7E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660FE261B8F;
	Wed, 10 Sep 2025 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0FRnO+a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57D261B93
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475007; cv=none; b=fA39iaxx6cvptrsxLP23Nm8FwxBbOcJ07F/KZlFODV7oGHNMGWl4CKYBzndkem7S2wHzJIhtRQGlZNaIRVHmMNtRVK4IZj3k4S+aIwY9apPqKxb0ktdapH9xQfDZ7W1wsupEtyPqsLf58Ee/GW8CQfb5TetB5rZ/L1JgSysN+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475007; c=relaxed/simple;
	bh=OYwcaDPz55YnWHQQQ/mFaUZUE6AdrwbnzKKNblx+Yh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lajx30G3EdDH2TCjjaNwxeeHtKvkU/mUb1sOxyS8FubZK0o7vu2Oc+V4P1O/Qxyl+Ye8AKqZIfCFqk9QASjgl0blQQUoR9KU9lCYDRewAJfmzVKwV3aL8qL4/4906ZPD0IoFf1jiEzgpW71CfvwG30emIk+Br3BVHqdGltPUoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0FRnO+a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HUoj7029821;
	Wed, 10 Sep 2025 03:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OYwcaDPz55YnWHQQQ/mFaUZUE6AdrwbnzKKNblx+Yh8=; b=C0FRnO+anSdITWWQ
	VveAVQjaDjYeM6j582y/Y1YUJy1Kl4kf3L6aUsmSw1r7FsfFN9XCrv6/ZLI3RZ2z
	KeB7wifcO4ykNwWCakUcH/hTpNak90zTETcsS5fUEXb+ZXUedcI45PblLU8jX21+
	pMXUqbC7GylpeEy52Y8UsbeOAhLT0tQp4GdSm2S2JHRKj/fRvpQ+2FuJZvWbzmvX
	d7NM4bcMVcvQ1ADT4/TKqII3EQcGYNhZmX+XJY8b9oS8Yz91vc6EG/jAVN9o3wle
	i4JFTQT7iesuOHFLhOQdaexRDPWPqHmlRcQiSWFqS/YJav0U5WMSHtFO8RfTKdyU
	UYRfWg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37xx5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 03:30:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58A3U0qx024504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 03:30:00 GMT
Received: from [10.50.41.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 9 Sep
 2025 20:29:58 -0700
Message-ID: <a578f4ac-248b-4a8b-88cb-1317538318cb@quicinc.com>
Date: Wed, 10 Sep 2025 08:59:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/3] wifi: cfg80211: add support to handle
 incumbent signal detected event from mac80211/driver
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>
References: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
 <20250818101947.2464612-2-quic_amitajit@quicinc.com>
 <83b5c2e55c7ad55851b9877c5c085a57b6414ad9.camel@sipsolutions.net>
 <f59d7f7d-6b57-4ffa-9679-de1c32b0c1bd@quicinc.com>
 <2f368979a682e47f1d40d7ac7357c70e9e87f66d.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <2f368979a682e47f1d40d7ac7357c70e9e87f66d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xQ43ZX7fVZwI6H7e-9kW8j74OIBnBzQ8
X-Proofpoint-GUID: xQ43ZX7fVZwI6H7e-9kW8j74OIBnBzQ8
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c0f0b9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=u_FG5kM6mFW_eFUMQ6kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfXwGGvdcLutvw9
 qqTwNuZpKVVZy9m9i17UqEaPsrLVaLBvOgd7PGadtr02Frg440h0Ni25PH03fGOwTR+hF51YDWM
 nNLfGd9QgsrDta0XD34qrSlBRPM0DiG5BOf/rq36dx3MZjng0HPmql3EFWFQJ9NewceNag4N2S+
 d6LPsgBz73a4by93gfqewyV+Y0BjraXbt11uURM4lxi7VvtiKBoecY0JaSgQY+GLuzsN96/jkaW
 cbhpEJv8RmHWK556Gn6T8z3fQzJq4TAZHzhFNfEOCZcp3AbWwlJA3QBgbiMU1f56s2+AkO1SRwb
 XalP1/T+DcKPLClS3XjKDjnQXBcN1JT5pCOxkx8iUfUIkQY4T/vzRijs7sbRJYuK/zBjzgLb9Iz
 pNVRamMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066



On 9/9/2025 5:35 PM, Johannes Berg wrote:
> On Tue, 2025-09-09 at 10:39 +0530, Amith A wrote:
>> Punctured sub-channels are excluded from interference detection logic
>> and are
>> typically not represented in the interference bitmap. Their
>> corresponding bits
>> remain unset (zero).
> So I find "not represented" and "corresponding bits remain unset (zero)"
> to be somewhat conflicting ... if you don't represent something it
> doesn't even _have_ a bit to set to zero?
>
> Anyway ... you can decide either way "not represented" (as in "there are
> no bits") or "those bits must be set to zero", but please just document
> it accordingly. It's obviously easy to convert from one to the other if
> needed. Setting the bits to zero is probably easier in most cases.
>
> johannes
My phrasing could have been more precise. To clarify, punctured
sub-channels are included in the bitmap structure; however, since
interference detection is not performed on these sub-channels, their
corresponding bits are consistently set to zero by the firmware.
I shall document this in the next version.

