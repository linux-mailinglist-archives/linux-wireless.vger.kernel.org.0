Return-Path: <linux-wireless+bounces-23220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C455CABF0A5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B5B8C1012
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E2325A2C5;
	Wed, 21 May 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AaoTvEsz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2DC25A2AB
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821667; cv=none; b=GHmV1+dYA2hWP10SmTuRjcGS3PXWTQ7sV+yFwTx5XE4266zpGUuoeOMCrqFjvPWmcoN5Lrk8u/nGl/BRJIW/IhxrjpuEd5wXttny6Dc1pTgwnz152jdNuNs4bfMwN8zIKCJQ6FYH4lyHGX0uMwEuLEJoS3YYmA6Cz3WPb94CvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821667; c=relaxed/simple;
	bh=7MvzcT0UqK2Ye+e7duKD+i43op5eRzZzr93JcJQM/FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J5f5uTt+UNlHZ/edm2cv0d+1jA5hwl21h03+F4LSmS6bFNAlOsdedaSfPCkSw+kBgyqowKjGY68jhS14U5TNTQVYOLaNNCZI9wgO3iwppGaf/tRImoSvKkGSsuI6PLvYQ1sr4lx5pz8ToCvyxGTh4712Wnb2cDRSAOVl3pcBtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AaoTvEsz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XMRi000873;
	Wed, 21 May 2025 10:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXRnlinTEZ0FkL2CsOQvWUE1AhXPWIAGfb8cdvlOz1A=; b=AaoTvEszNEeZLCFl
	xkjNuRIaGXSOehtJyzIG5ikOjsSNeO+jBimL4N6+LAr6CaNavOVzchFHgQtA3/TO
	eat4VNOpcVm/PJblFqZUlrP1D+BgbG3YLNQJqOtyHX54J8/2oLAvcSZmCKI8D3V7
	PPwTBJafYITXgdYzaOPgrao6BulLKOcMv8OFZ0v5W0lncm3BHAaFZagELt/xRHP3
	d7g/r2KcYJ9IRpRC9jynbROf4Cv66vBODwXa6BvWLGlMxcpJneQnvGP8xnZrKLEN
	iqYyLnmBX1wTsJKiWjO7erE2oREh0JHHwlMlBE8o4/QxUlwFCLiks1aefbCxuczZ
	1xudlg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6tfqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:00:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LA0wkR011387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:00:58 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 03:00:57 -0700
Message-ID: <8fa02ca2-4a2c-475f-85f5-43ab32dd4f95@quicinc.com>
Date: Wed, 21 May 2025 15:30:54 +0530
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
 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
 <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
 <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
 <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
 <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
 <157dd058a06a2f111c52459610b0de7057a5d557.camel@sipsolutions.net>
 <c2c54fbf-c9d5-4a4c-982c-dfcd5b6d9624@quicinc.com>
 <4c9a74c436bd14b49fc9a15e7f9c68cb446baa84.camel@sipsolutions.net>
 <5ea169b9-8f63-46b7-8f48-40d8caf97ac4@quicinc.com>
 <6341cc8198b7054f9242821d8a7db2d2f12b92eb.camel@sipsolutions.net>
 <beae7cfb-03cf-496d-94b8-45425b1aa44c@quicinc.com>
 <4825b1cf6d59570d9bb3f03b500023bc2574c19d.camel@sipsolutions.net>
 <aab47e6a-7b45-43db-a4ba-f2372e27a946@quicinc.com>
 <b758b8768c508812e786d32289dbbd39e97dacfc.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <b758b8768c508812e786d32289dbbd39e97dacfc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kwf2LgbtNrCat4bMurJhPA8wUu7vfj3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5OCBTYWx0ZWRfXzrGjyOXF/tPi
 qLY54KGCSPQXvBoUyg2gAqWqEyks5I2KndT4lgb3sA0sQZZX8k2cF5eptoZYAEvfkYoWHmUZQmB
 2NNiWML8D9ISjFxXUfmLg3qfgkkb1K2oDxJZ9MVcjkcet4sXvK4oXKclAs/3RaR2glDOF6r1GFT
 BGAkIqeFBa8tjdAkLIgMGYcOvn3Ap/S+7Cf5/dWF7cMgbJ4l+sjTIJKFAdyhI7i5jx80rcUo/DW
 wAtpbITi3TdfEZ0dRT1cMgZwWcEn40k3kri4zYq+bSt0XmJgXmFyVzIPrRAjDq9Cih9rPwBAzMy
 GaPNLP8OZ+1D+gQvyNUl/P03eZuHy3zaVJDVNGBWoaTtrfa1D0njoXfosoHrtmLLjqhBqJCMH2s
 tWgDwLuF8C6+yXvRE5hqdtpx62Odcla2pE6VS1R3KekZoxDTXhgzxRsTVwPGyUAlcty27FrA
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682da45b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=kcBcR6wWsuS0rw7xBOAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Kwf2LgbtNrCat4bMurJhPA8wUu7vfj3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=737
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210098



On 5/21/2025 3:28 PM, Johannes Berg wrote:
> On Wed, 2025-05-21 at 15:27 +0530, Roopni Devanathan wrote:
>>>
>> Okay, understood. If I can directly assign -1 as default value to radio_id,
>> then I can cut down this definition entirely. I can re-write radio_id
>> declaration in nl80211_set_wiphy() as:
>> 	s8 radio_id = -1;
>> instead of 
>> 	u8 radio_id = NL80211_WIPHY_RADIO_ID_DEFAULT;
>>
>> This will solve the whole problem. Is that alright?
> 
> Seems fine, there's probably only one place anyway that does this.
> 
> If there are multiple I guess you can have a function a la
> nl80211_link_id_or_invalid().
> 
Sure, but there's only one place this is needed. So I'll go with directly
assigning -1 as default value to radio_id.

Thank you for a detailed review!

> johannes

