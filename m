Return-Path: <linux-wireless+bounces-23432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA33AC489E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271693AD773
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 06:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D31E2602;
	Tue, 27 May 2025 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iaBVUFyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CEE522A;
	Tue, 27 May 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328568; cv=none; b=NA69Jap0RN781F+kPn0y6bwS6b9FX1ooe/I8WmHIGmnHNpUniWWeYlG8eVRkBPSSGH/2iNOSLQQCBJbWdZF3FYzZ8+LikBqrbh8SS6PJwVLKcvale1ET6AGW2DA6EahGTu9GSSCiIDTKxG9lyKBkoPdV77Up3v0Xpjkz25zqbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328568; c=relaxed/simple;
	bh=mGSN+B/+5OzubQ4m6Xh1VBbrjiPDb5K2kvAa77fXUjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rxi8ZaqxsBlnWYhhVRpBvF33PQQXG6Q4qrt5f3XXn0AF4PqkBi185SwseJQcdBsoSHvrZjzH5zx7KAbLsdfILVvMflCnl9Lgij9R4hSW48b6meQTdC6DPtVluhuEWa1eqEZmpmii6pDKKERZx7E5xwHu8CC5K3ZHCCg7Z/DKE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iaBVUFyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R33QD9022698;
	Tue, 27 May 2025 06:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DG8NBcXdjQr4Uy0/3G5WE9/K86J7nRfauGbc8nQoew0=; b=iaBVUFypawV8VahQ
	UQ4sqFqZhcIlM+kAlj/P8KjA1T4todhI4kDNeYZIhKXAR5KuK+aUzC/uKPYtp95b
	T7HAPb4rGFJo8nT3OvnBEvY5dybT1PEaYEABwSlg3bWuppQq6mT6uSTi4I3lH3UG
	UpAmVTrFBioud1INiln/Bnu2wc1h99816Wew3fw+h5xw+FT2AN5Oa7/Q5n6dI5Al
	hRXwo7HZvZyr/uEjCM3cRUePuMSBv0ZDW2aVCzyF+8LB6N0iwVg2CNEMVFgMxZmb
	tfbLm58msLyYkjY6W3p8gPDVVyF6vCyOlHtGPy7EnYPBltcKIaB644feA8Y/PsO9
	299Q/g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6vjnwpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 06:49:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54R6nLmO023228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 06:49:21 GMT
Received: from [10.216.18.168] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 26 May
 2025 23:49:20 -0700
Message-ID: <987b6a9a-4292-466b-b2f2-dc0302dff1f3@quicinc.com>
Date: Tue, 27 May 2025 12:19:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/3] wifi: mac80211: Allow scan on a radio
 while operating on DFS on another radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
 <20250514-mlo-dfs-acs-v1-2-74e42a5583c6@quicinc.com>
 <d23e55879c6d8b6cabcc8357f153ae0622a4c53a.camel@sipsolutions.net>
 <a91c82f1-df99-4938-8f41-ce90e9e08ad8@quicinc.com>
 <f694233ea7378257fbc992bd3d6f10ac7f6d3695.camel@sipsolutions.net>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <f694233ea7378257fbc992bd3d6f10ac7f6d3695.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=UOXdHDfy c=1 sm=1 tr=0 ts=68356072 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=b5xq3f-AXsd8E5YpHnoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DxR0g8i0ila0AlzNcY8VqBwkJI56jKWX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1MyBTYWx0ZWRfX8r+LO6/W7QnU
 TKBdVjYWTxS3v7ysmRcQwZ81x+Nv0sY6p+K3MfjY7z0GAdzpfY6mUc+QHtuj/I6mLf8CgCsAp6P
 6VLOVFz13GcgsJQpXqBncUVUXReimWMLAyM+GsGDTAKASosnhFh/L+/xpn7YLYrWdiAb1nsXrz9
 uXLkXWxCiJyJ+PH1LbWfgCYagpf0rnmi6rHj4DP1Bb/PMr4AkbUTHltTvZEdF0N/XHj7qbhVbw6
 xzCwNc2vd9nZiH3hKNIgptguD7Rmhf7phMdWLbuMZxZV7JcdwjQt/rC2Ge4vZgxu35PlUQCNG5W
 HLUfhYbL6fEXpkMqrPiY8IxIiCzmu5kru8Oy2VNsXlHePhEhtX7KEmJZcHOtSI+VvRHPrAx56lN
 CGsKMZFBjOvh/S+hXpbelQhRMZi4YubyVUTCQiVugOo7a7gQ9u40J+eifXPI57srfBzufGSO
X-Proofpoint-GUID: DxR0g8i0ila0AlzNcY8VqBwkJI56jKWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=949 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270053

On 5/22/2025 4:53 PM, Johannes Berg wrote:
>>>> +	for (i = 0; i < scan_req->n_channels; i++) {
>>>> +		chan = scan_req->channels[i];
>>>> +		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
>>>> +		/*
>>>> +		 * Skip channels with an invalid radio index and continue
>>>> +		 * checking. If any channel in the scan request matches the
>>>> +		 * given radio index, return true.
>>>> +		 */
>>>> +		if (chan_radio_idx < 0)
>>>> +			continue;
>>> This seems ... wrong? If there's a channel in the scan request that
>>> didn't map to _any_ radio then how are we even scanning there? And the
>>> comment seems even stranger, why would we _want_ to ignore it (which it
>>> conveniently doesn't answer)?
>>>
>> It seems, (chan_radio_idx < 0) should never be true because the chan is
>> taken from the valid scan request. I should remove this check in next version?
> I'm not sure, why did you add it? Maybe it should be a WARN_ON and abort
> the whole function? It just doesn't seem right to _ignore_.

I initially added the check as a precautionary measure.

In the next version, I’ll replace it with a WARN_ON() to flag the unexpected
condition. As a conservative approach, will return true in that case, assuming
the scan request might use the specified radio_idx to safely abort the function.

