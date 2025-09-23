Return-Path: <linux-wireless+bounces-27596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086BEB94440
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 06:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EB7481D88
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 04:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745525A63D;
	Tue, 23 Sep 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NNRPF5lS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912171A9FB6
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603305; cv=none; b=H4CelDmbdvJ7Y/lLSEi2oivPP0HAIFHjtqo0xx1g9CT1iG/nlRIHHOZf2oes/o71AYzz2eJfPygfq/wOJtLaHeney/86Tp5KxZsUG1xUOEW6mizexjOjjl8xfbNHTCYqWRHVe94+XDtESIwTqRlhCv32y4uFHo7I0rVVIhVqaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603305; c=relaxed/simple;
	bh=yzChXf2dT1I7Fz0CHSDM3QE32GULn5d+NZEysY0FD0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GW3Nya9XnfgXawVq1rgJnwmFkjo1WuqhIKItwtSaAuvSQ/uxGoG0TblikDJ3ya/c+TpezjPHolgbRQbYAGPtZapZtGuK0gz4wURVDlQWoFDHeUTx+oY0lZVxq+1DUpcB2jckgr9ryEHzhTIvUUuE2LHFVW7VcMcQns1V0BVMuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NNRPF5lS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N4VmIS012080;
	Tue, 23 Sep 2025 04:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbUsHjislrw6E5bTRmKt8J9HFjRDyhOCB2Op/S1RpMw=; b=NNRPF5lS1S7cmM2/
	w3uuygS0Fa/iyEU2wLtwMoB3b91FBjxhC7qFWounBV/rJwxIokFmPGJul7hcRV/F
	SVeXPGQeXaQjvQA8/8pkWvEDTxo50lT/j1CCePpNZ4sda10cQueGGYbXn3ykosye
	i0ytPz/Ed33q+ySl3cjdcdEspH16GUNPk8HK7nTU9fcC2/lhhdJ1/B16YUb+7pQe
	P7EJlYSDtChJVnq9zjOYV369QDphoOOrzR8W5FB60Cf6M4PdSxhnoe243I0HnpS0
	mce0zhRACqVIYQrPMv3y0x64TEqyKXWR7Dv6qPzxhD0L63D0ProF+JvXwkdzZ3cD
	X9lvOw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0y6yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 04:54:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58N4svW0027059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 04:54:57 GMT
Received: from [10.79.195.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 22 Sep
 2025 21:54:55 -0700
Message-ID: <0319715b-49bb-459c-a594-5f445790c013@quicinc.com>
Date: Tue, 23 Sep 2025 10:24:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
 <20250912032105.714949-3-quic_amitajit@quicinc.com>
 <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
 <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
 <6f1f2a41ff0af4c6bff8199250397fd93ae983f2.camel@sipsolutions.net>
 <e2647512-82cd-44b1-9d1c-941e4df11bd4@quicinc.com>
 <a1ef1d78ab5c790d5fa3b6972a604949e210ccfe.camel@sipsolutions.net>
 <6e8eae56-54f7-4e90-a0a6-d5aed312b783@quicinc.com>
 <40c186606df108c5147173dcb253334a749f2661.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <40c186606df108c5147173dcb253334a749f2661.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I41DX65M_NoY5ILtBnJV5MAlm-6QRHzJ
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d22822 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=nFOOgfmsbus1Tm2c0wQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX2CpVn7f21wmI
 uf1kMztocvl88Bunrvu3co/K7w+Kb5BhCk25Ysrt6L5332mT7wG3b4QFLlf33sMwOOAoCaT0TU8
 zmUimisCubAPmEhjhE6GdUSEhQOc/yBvgkmr9IxSmr03XPujm42E8ifvnXSJmhcotgw260GSOmK
 Y7mnT8NjmxSLm+kv3JlVEwRy6YaHHQSxODRaMYtfSmZFYzN7HFSUW6Nz7iesw+C0p3BqrN8oUnM
 X4MyM+b/QE/Q6L2fzv8oxvfaC0EEr2uBHZUOjINC7Fa8EvEbxAoq7C0tAOzLHkQ5Sobo5vR5I2n
 Gwjyw8A3u1PpxpdDTPlGoU2LdfDxpEZWs/oBM/4zyvOdCJUbnysmPaU8sih7NCoWoFwS7U5kcw5
 RY1f/wmj
X-Proofpoint-ORIG-GUID: I41DX65M_NoY5ILtBnJV5MAlm-6QRHzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025



On 9/22/2025 12:16 PM, Johannes Berg wrote:
> On Mon, 2025-09-22 at 12:14 +0530, Amith A wrote:
>> On 9/22/2025 12:08 PM, Johannes Berg wrote:
>>> On Mon, 2025-09-22 at 12:07 +0530, Amith A wrote:
>>>> On 9/22/2025 11:47 AM, Johannes Berg wrote:
>>>>> On Mon, 2025-09-22 at 11:10 +0530, Amith A wrote:
>>>>>> The workqueue mechanism here can be removed as
>>>>>> ieee80211_incumbent_signal_detected() will be called from process context.
>>>>> That's fair, but somewhat besides the point - it should be OK to call
>>>>> the cfg80211 function from pretty much any context, so even if this
>>>>> weren't the case for your particular driver, there'd be no need?
>>>>>
>>>>> johannes
>>>> You are right. Ideally the cfg80211 API should be safe to call from any
>>>> context. However, in its current implementation, it uses nlmsg_new() and
>>>> genlmsg_multicast_netns() with GFP_KERNEL, which assumes process context
>>>> for memory allocation. That’s why I initially used a workqueue to
>>>> guarantee process context.
>>> Err, no? You actually gave it a gfp_t argument in the current form.
>>>
>>> johannes
>> I was referring to this call in
>> ieee80211_incumbent_signal_detected_work() actually
>>
>> +		cfg80211_incumbent_signal_detect_event(local->hw.wiphy,
>> +						       &conf->def,
>> +						       conf->incumbt_sig_intf_bmap,
>> +						       GFP_KERNEL);
>>
> I guess I'm lost. That doesn't mean anything for whether or not you
> _could_ be calling it from process context. Clearly, you _don't_ in the
> current patchset, but the fact that it's not necessary to do the
> contortions necessary to not do that was exactly what I was pointing
> out?
>
> johannes
Sorry, I got a bit confused about your point earlier. To summarize, I'll
remove the workqueue mechanism, export the cfg80211_ function and call it
directly. I'll also remove the gfp argument. Will send out the next version
with these changes shortly.

