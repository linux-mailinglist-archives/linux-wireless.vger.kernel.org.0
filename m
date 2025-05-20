Return-Path: <linux-wireless+bounces-23176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918AFABD37C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1ADE3AF4AA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097121772D;
	Tue, 20 May 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CQYOIV1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E6267F55
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733662; cv=none; b=ErXvtSL/2qrmI3g9M87btWWsmUOdO44w4fnge/xSe1msFK3xpaLyxlSOWmta2zSbkLOV976O3+SoIbXSISMnHO4NbQ/591JU1bH6jmnsEPGsuwskYhMztKlhbc5RvVktlhao7dElz1Vr6JpnwUoAaoTNE/ekbHEWzoEIQ4RrwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733662; c=relaxed/simple;
	bh=1jZGzDeo7TBoUbSdW1/wH4l7ws9PZmjzEfzwsR2Qhjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rHc9ek4XTI1GqVLWenvEwXfpoqUvAO7RidMJPS91JXq1R+k4tkDvr1pIB3nG79dpTuQ/2dJL/skHEsHAESUewpTEve+xzkl3AaGYa8PbX+KdrQQxV36zRVi1B+uLiYGcI/LJXONQ3HIyRExindBP4wfvZf5eaTu4G7PwjBnDRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CQYOIV1k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K45HK3010804;
	Tue, 20 May 2025 09:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pugIMDro3e9bqUbW0l+VXU62TNDJ8/keOqblDPiyIFA=; b=CQYOIV1kgrzNeUPb
	RmEijX0K17NaxT+fOSFyl96AZJYD9fAqlBaK4uCyz0Qop7qDkOA3Th5g4TCGExRp
	mM4SD8+nPqqevhr9ln0Rtt43o/mCHLsWq7xdI7lb3XtOgavWCYzMK9hvRIvb27Cp
	ZB6DsFoukGkQ/ycKa0AmewB+gaFNopMAVS/HsfF2UdUSR0MHabDJ26AU1DFEHGkZ
	ZRvampqFFdHVCRuimaxm7fyc8ftmtvd6zBGQ/td/UXeDDBE+RTYwyFiFAhILZadn
	WKQ5RpCvIyR834wIt9OPZz/bfN0ENuCXFU9lCDKUQ/7G0Jtr3743a+dZShbl0IvM
	mm9FfQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4q5c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:34:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54K9Y9Sq027322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:34:09 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 May
 2025 02:34:08 -0700
Message-ID: <c0cb3780-f899-4633-abdf-e253e239ff7c@quicinc.com>
Date: Tue, 20 May 2025 15:04:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
 <52d96a61f56cd37b297e12b7ffb2936a479607ea.camel@sipsolutions.net>
 <f6d6ed3c-54de-4dcb-bea3-8a420f001c9a@quicinc.com>
 <5ab3ec5c2145bcf31084dc1ebd87a40600d1a505.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <5ab3ec5c2145bcf31084dc1ebd87a40600d1a505.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mmEt34XU4qs1cyNyywa2HhmGe3IToZN1
X-Authority-Analysis: v=2.4 cv=C4bpyRP+ c=1 sm=1 tr=0 ts=682c4c92 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=KXajRAVGq2nrHfwbTzwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mmEt34XU4qs1cyNyywa2HhmGe3IToZN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3OCBTYWx0ZWRfXy7aH1Sg9Cjvp
 4JebysivSJXUVzmi4AqIgbnUlZ0QB0gzcHvBkEuSpAqPXXazOTeCxbUWV0EAZS0Kz5fKrV1wx4C
 Vci2IG2OQnwjXGjAvBJCrfZFv4yI1+qcOn9W8b7uZIXe9PJ+vMD1WQqbA880pgBPx/TuKK4jCvC
 YcAOkxwqJXe3GKpOFSt01CRabPptt5JsBOoKm5CF6sOCVYH/mfvuJ3JpEMOxGkDVO1ZEFAUAj6l
 1+oy3rW7hxZ7kJxftlfdeLCGzvKLKpD/JstYZKbTwIK5WC4/g2For1BGW0JRJoZlOMc03/VVD2v
 fFSK3bJXBDVFRz5EjgJQMc3dd34ZhVz51voakz65zAZmd0xuC/t8BZ3zsxiKxhQ0FW3g9QdcRwV
 ZPK9caCy8anGPFv/YEK+VHFWgzYueebaIdXx5XEuLIJz1ESoBJLQXKOD6rIZ4w6nNp5fs8tV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200078

On 5/20/2025 2:08 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 23:05 +0530, Sarika Sharma wrote:
>> On 5/15/2025 5:00 PM, Johannes Berg wrote:
>>> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>>>>
>>>> +void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
>>>> +					     struct station_info *sinfo)
>>>> +{
>>>> +	/* Resetting the MLO statistics for accumulated fields, to
>>>> +	 * avoid duplication.
>>>> +	 */
>>>> +	sinfo->tx_packets = 0;
>>>> +	sinfo->rx_packets = 0;
>>>> +	sinfo->tx_bytes = 0;
>>>> +	sinfo->rx_bytes = 0;
>>>> +	sinfo->tx_retries = 0;
>>>> +	sinfo->tx_failed = 0;
>>>> +	sinfo->rx_dropped_misc = 0;
>>>> +	sinfo->beacon_loss_count = 0;
>>>> +	sinfo->expected_throughput = 0;
>>>> +	sinfo->rx_mpdu_count = 0;
>>>> +	sinfo->fcs_err_count = 0;
>>>> +	sinfo->rx_beacon = 0;
>>>> +	sinfo->rx_duration = 0;
>>>> +	sinfo->tx_duration = 0;
>>>> +
>>>> +	/* Accumulating the removed link statistics. */
>>>> +	sinfo->tx_packets += sta->rem_link_stats.tx_packets;
>>>> +	sinfo->rx_packets += sta->rem_link_stats.rx_packets;
>>>> +	sinfo->tx_bytes += sta->rem_link_stats.tx_bytes;
>>>> +	sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
>>>> +	sinfo->tx_retries += sta->rem_link_stats.tx_retries;
>>>> +	sinfo->tx_failed += sta->rem_link_stats.tx_failed;
>>>> +	sinfo->rx_dropped_misc += sta->rem_link_stats.rx_dropped_misc;
>>>
>>> Setting something to 0 just to += it seems silly?
>>>
>>> However I think it also needs a bit more explanation - it's sinfo, so
>>> it's zeroed at allocation, where would non-zero numbers come from?
>>
>> Currently, the station information for MLO is populated with some values
>> from sta->deflink, as the sta_set_sinfo() call is common for both
>> non-MLO and MLO.
> 
> OK but deflink will not actually _have_ any values. And again, mac80211
> shouldn't be doing work the results of which are then only discarded...
> 
>> When updating the station_info structure in
>> cfg80211_sta_set_mld_sinfo(), the accumulated fields (such as packets,
>> bytes, etc.) will already contain values set by mac80211 (from the
>> deflink fields).
> 
> Which arguably is the problem? But also not because those are zero
> anyway? I still don't think this makes any sense. Either it's not filled
> and remains zero, or it should be filled only with some sensible values
> like the accumulated stats from removed links.

okay, then either changes needed to be done so, some fields way of 
filling data is different for non-ML and MLO station or need to maintain 
all accumulated removed links data for addable fields.

Let me check and add this.

> 
> johannes


