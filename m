Return-Path: <linux-wireless+bounces-13083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C710D97E6AF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A4A28165F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD5219FF;
	Mon, 23 Sep 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pQmsgtYa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0838F91
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076896; cv=none; b=lZT+vxLxYxQsA0YOGYFgmJDYt41CVsqmL3Q0kGH1p4ZrAW0t0oBy/9VCDh2o3jzAGhqleqn/unsSqiJt51GK+KSS/EB6HF3LbOzvEtbexXAVyLUBnNlQeKzzmYjb3gWhX80Cfmn4EAntoyaDmK+jIQE44zIM76yLuWAXf2vbLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076896; c=relaxed/simple;
	bh=8H5KGA9ZcBnyudP9CAtPbRihd9xTeSoyPFWoLOszlMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XmDb+2bRslxiCik8FWYaIYj5KPItNHfmj/pnydw1xG/392vFa6a4zZ532FxPmtEgFrkR4DMgLhAJcix8yxj1XW5VTZXWCpzp27KS9aRfYI4DVSxhe89O2YTTv4BX0fRZd+OYzx+95NbeA6VQL0zx2nAmyByBg8AkpdLMuHoDHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pQmsgtYa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MNL9qM027530;
	Mon, 23 Sep 2024 07:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oOBr+iVo7RnaIxJhjjzBg++YS2vASVJSdfGoJvDEfRA=; b=pQmsgtYayfUEq9Q0
	0HWGnwNXuKsSNHggMF4DChLuN54fLcgHYbopVhjynbfUdiH/RDUEH2vbrHZtWRn1
	N9Wmq2WIx8qkMzE2XsuZE3N3Z+csfHfHYJi56+DI/yCYGwUIPxLVR5OgX8RDgsxU
	OTPzWXe3dFoZK2H3fFjULR+Tv2TVy21Pg+LQlUEsREv9RsL8sErcpfJvkwct32w3
	sTzSuF9Cd6m3G05otL8f2c7OLMzmdZnfQGOLhY9O3ckR6hdZj+bCMq96J123han1
	VtxMwZQ6eG/WhReQ75KvS0zyweDHINbBk2b7LH13kel6MlO6QyUbdQKwU0tDoSiM
	n1e8SQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfgv7sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 07:34:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48N7Ye4c029201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 07:34:40 GMT
Received: from [10.253.15.193] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Sep
 2024 00:34:39 -0700
Message-ID: <b60c55c1-5e3a-4d1f-9dac-f0d76610b2a1@quicinc.com>
Date: Mon, 23 Sep 2024 15:34:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RESEND] wifi: cfg80211: Do not create BSS entries for
 unsupported channels
To: Kalle Valo <kvalo@kernel.org>
CC: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20240923021644.12885-1-quic_chenhuan@quicinc.com>
 <87h6a6akvk.fsf@kernel.org>
Content-Language: en-US
From: Chenming Huang <quic_chenhuan@quicinc.com>
In-Reply-To: <87h6a6akvk.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HCVmAxSC4seY6bAzrOG8NeFVOBxf2S7G
X-Proofpoint-GUID: HCVmAxSC4seY6bAzrOG8NeFVOBxf2S7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=783
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230055



On 9/23/2024 3:29 PM, Kalle Valo wrote:
> Chenming Huang <quic_chenhuan@quicinc.com> writes:
> 
>> Currently, in cfg80211_parse_ml_elem_sta_data(), when RNR element
>> indicates a BSS that operates in a channel that current regulatory
>> domain doesn't support, a NULL value is returned by
>> ieee80211_get_channel_khz() and assigned to this BSS entry's channel
>> field. Later in cfg80211_inform_single_bss_data(), the reported
>> BSS entry's channel will be wrongly overridden by transmitted BSS's.
>> This could result in connection failure that when wpa_supplicant
>> tries to select this reported BSS entry while it actually resides in
>> an unsupported channel.
>>
>> Since this channel is not supported, it is reasonable to skip such
>> entries instead of reporting wrong information.
>>
>> Signed-off-by: Chenming Huang <quic_chenhuan@quicinc.com>
> 
> The list of changes from v1 missing. I guess you added the 'wifi:' prefix
> but did you change something else?
> 

Hi Kalle, only added the 'wifi:' prefix. No other change.

