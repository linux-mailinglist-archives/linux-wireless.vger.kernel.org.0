Return-Path: <linux-wireless+bounces-28554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF200C33160
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 22:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548CA4E1590
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D062AC17;
	Tue,  4 Nov 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ja4j3kZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F58A41
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291941; cv=none; b=XAZQE9o9qsPQvpkMCLks1D53Tk1OqmwS0Vq7GC0SRPJEwaeN68zvnT462iO56wViY8/UuO6qj7pVy/NLCVk9k7HUd73sDC+K658m/XYi/P7+nVTO1lpb+SzWG4SfxEtZSQDUq5WyQcS6cDf9S3xdo6o4atykxEccIOSzRUjHfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291941; c=relaxed/simple;
	bh=l7HF3R39XMJw5AMO6lovGTh0YjjBribed5caVfE0mjw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=To+u+2xYdHXLy0l95Icgbnq+/C0EZJ1VAtYqvKUZ9aI+5Nbx8nMLEC8n0P7LuDCXD7KqfVIVdzGToXicCz1Q11EpeJ+VSw3RBAAj1rWSg4ybY0D9aQnWBiwZDsaWx7jDlk9lW1ROko7RAmlW0sLSEtZhxN8qYQ9kItLaSmdmJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ja4j3kZW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kfpq82904351;
	Tue, 4 Nov 2025 21:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gGDlz82a9ZKVdc1ZBnmN7HuPFGSv4EHnzWlwB4JaRCs=; b=ja4j3kZWZp0WjBCh
	M6dUbV6dFdmEiOu1jFutaFXcTajCd/aVXROaNDzH1v3/dR1YhBnUBY9AzRSWNrf8
	/sOc6ai+F7xthpwjAsUh7wi96y4sRl1wzPdq/uDuDs0hUh+krOdmlpNj0Vl3G6eA
	zREoo6LLVsLpOoBFOLSNlM5d85amgapvw6nUChzb4dGrIW90HR6HAGq2xiNqSRai
	BA8cRKlsx5PGWwRRtH071A5wP7kBGLUYaBzMSjCZfePEKsV5x6IUOzOj00CUMe9L
	nwJQFtn+h0Bpp+ptwWNRT/G+3BUwGaB7MWw93176GxWtdqqKtHd5rMSGsmIwV+i5
	665NtQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbs17g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 21:32:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A4LWBfk011209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Nov 2025 21:32:11 GMT
Received: from [10.110.41.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 4 Nov
 2025 13:31:51 -0800
Message-ID: <793f6c8d-d092-49c8-b34f-8e6db7761750@quicinc.com>
Date: Tue, 4 Nov 2025 13:30:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Aditya Sathish <quic_asathish@quicinc.com>
Subject: Re: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8
 Seamless Mobility Domain (SMD)
To: Benjamin Berg <benjamin@sipsolutions.net>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <hostap@lists.infradead.org>
References: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
 <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
 <30403bb70a2a017c90b1d4a5a1a07514bb670822.camel@sipsolutions.net>
 <fb0a1ddb-af24-47f9-9d75-0a8f2e346d81@quicinc.com>
 <b6a9de98b9b09c73003b89331ba235c3a959c3fd.camel@sipsolutions.net>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <b6a9de98b9b09c73003b89331ba235c3a959c3fd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QaxjB2lytZ_6cWc5c7GNAxPs4K6ea0Q7
X-Proofpoint-GUID: QaxjB2lytZ_6cWc5c7GNAxPs4K6ea0Q7
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690a70dd cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6wSQEUNN4BJYvWVUkWUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE4MSBTYWx0ZWRfXwfXHIx6GfV65
 qhaXyi9HRfgFzFHMpswjqN+2aEhL5npmcmVSK3z+3V0pxLjqtK1H78vrU9ZwbW9yTTP8jIL9/lA
 JAQB6/3SDdW/+7HAoV7Qk91BZ8cFU7ER78riv/uzOVsNiQYEWXMdcqjPltxYDfwFDk1w3JUUsr3
 mwIoSIQb5TYQs8ycBKq4343fLbLmvBPNVJT17N9vowWYMeEdFMLEo4/d2vGel7VVd75fYd6B2Ql
 nzs0rV3daqOREYvCVrpnJeKQvUFipDiW03oy4W47OyBxqGKWwS846VctEQeY/7Lh6ASJ3uLMt6V
 5c7qpxskokFCi+HYvhrfAfJl+8BJ+noYROmNQmpBOlFrtlIkFPRH9JC1pvLpLtuKp2aU/CsdNtW
 QIK82EFWAgQHN84QAiq9VXIXeZk2XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040181

Hi Benjamin,

On 10/30/2025 01:47, Benjamin Berg wrote:
> 
> Do we have a clear picture of what the performance issues might be?
> 
> To me, it seems a bit that talking about threading might be a red
> heering. It could be that the primary issue is the prioritization of
> events when there is a burst of activity.
> 
> We should not need threading as long as each individual event can be
> processed quickly and hostapd is able to keep up overall. In that case,
> we have an event ordering issue which can likely be solved by using
> multiple nl80211 sockets and giving them different priorities in the
> mainloop. By doing that, you can effectively pull all time-critical
> events to the front of the queue and ensure they are processed with
> only a short delay.
> 
> Now, that doesn't invalidate your point at all. If we do have tasks
> that take a long time (crypto?, external requests?), then it can make
> sense to push just the slow part into a separate thread and pick up
> processing in the main thread once it has finished.
To preface our concerns: the longer the context transfer takes, the
less time the serving AP has available to drain its remaining packets
before hitting the SN limit. This can result in a larger gap in
client-perceived latency during roaming depending on when the target
AP is ready to start DL transmission. Efficient handling of the
context transfer (during the ST Execution phase) is therefore key to
minimize client-perceived latency.

You've accurately captured the core performance concerns we intended
to highlight:
1. _Prioritization of Management Frames:_
   Certain management frames - such as SMD - should be able to "skip
   the line" since a roam request typically will indicate degraded
   client link quality and prioritizing immediate transition over
   processing existing management traffic is likely in the client's
   best interest - especially after preparation has already completed.
2. _Additional Threads for Long-Polled Operations:_
   Without multi-threading, long-polled netlink messages or system
   calls can block even the prioritized kernel events. As you noted,
   offloading slow operations that are busy waiting to worker threads
   can allow the main thread to handle time-critical events.

That said, even with multi-threading in hostapd, we still face
overhead from RTNL locks and netlink socket overhead — not only from
hostapd of the serving MLD but also from other hostapd processes tied
to other MLDs on the AP. This is why we initially proposed moving the
ST Execution sequence to mac80211. Doing so could reduce round-trip
latency from ST Execution Request to Response, especially under high
system load and concurrent work across multiple hostapd interfaces.

> 
> Benjamin
>


Regards,
Aditya


