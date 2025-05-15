Return-Path: <linux-wireless+bounces-23028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9FAB8E01
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70635A05E2C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F9253F1E;
	Thu, 15 May 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HXnADm0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273525C81A
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330836; cv=none; b=iP9JsWZeajwNPmHOSR1HsN2HLoMKj6Lb+9el50EWraCxvyGkZRhXQI+BxvR3BqwrZA6VocY3e7LLtBY9ifnfmtOXY5/Djr8LJn0D6fb7MFnw58qYcls5Cmiw8EBfGMnuQD9szW4Ik1bQ5bnzwdmWBQFYMu2671gDAB+ffGS82zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330836; c=relaxed/simple;
	bh=SMgwYGmrFfP1TjR5ktmZxioleVuy9FQqLchRhA6SQfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loPTdahuWKnClv6RYaUWr7CoAKTATiIlTO260mIuMsd3xXNgJHK2Z+uQraCEl8Fjd+8FPMOYkyklMQvR7I66um2S4ux+xPJ8bFcynxtYHhskKKiWbMXpAeMN91r6OdSB6TdaxT8L5dLifhJcICeLkL43plGvZBWxoKs03V158Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HXnADm0J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFGjt024402;
	Thu, 15 May 2025 17:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zgfG8LcjCaPd7GozNdfHHrifnD1wzRMvlMdj0DNdQfQ=; b=HXnADm0JIVM8ggFV
	8D8YlV19wMAdJhmApW/YZVKEBxXGQAZaD9Q7C40BxQ/VBmb9BAwzyDbjV0xD0HdW
	33CmhlD90xhHGtEIE40oSkOsIRgSrkZu/YPtBxXcQuaW0+aJ+08WEbX+gyhDQOYx
	h3c/ailwDbOwULrivnYFpef2B/A71qub9lRGqun7Vjlc/4og2668prpdA94/oYO6
	jJnay0sfeqGf5+81kweaYZs5258lbF5x4wugNRMOkSHRuOUOZf9HFyTuu4IHxLwX
	no2y3cHAOwWu8hoXbb6wJdlYpGTyxxrOEk/RcmnynO6bGWcFHoDsxZxbN1hd+vn+
	IYf8MQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmy9np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:40:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FHeUmJ022516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:40:30 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:40:29 -0700
Message-ID: <d008e4cc-998b-4773-b1f7-691a599d1e0b@quicinc.com>
Date: Thu, 15 May 2025 23:10:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 09/10] wifi: mac80211: add
 link_sta_statistics ops to fill link station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-10-quic_sarishar@quicinc.com>
 <9e767a04ed838c3b4c2a491ec1ad69e3fc2728be.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <9e767a04ed838c3b4c2a491ec1ad69e3fc2728be.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: azJ8I8MqdyLq1MWXHtXOo-l36Bo3PoCT
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=6826270f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=61TXuddYcoyk82DNiMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: azJ8I8MqdyLq1MWXHtXOo-l36Bo3PoCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NCBTYWx0ZWRfXwgGrLGa22yme
 QhtFWx4UAhxGnhlStlG6mVJmreCgyUsf3ZhKaGu+TASdOBZtLpz5EQ13K+AyHsSXBnvIVsvgjVv
 zLXco5kYWjsvRLM9llf8PbTpxdwoqgeIg89Vjh/yEPJOxrAICXhGWHg/U7k2rSENIlrBt9mn1nl
 sd1hZxUW5txqKzAS2ovTHM2LjJ1kqT0OeDlXMMx2Bt3CattQ0RDlRMpVSBVU9+XnCIegJDr3dEv
 qG5XH3nf4WoVkjG6a7hcLlOPP4fz8kLP1jaqt9olDZDqoO0JRTYBcvLbD/ULNilFoxp3ipWc8vm
 4k21ktOeTLx21tZxnUQgmtJRYty2N4IKWw0G9zt4nUu95c7MNIzJRRyPTQm1xkUISPGaxyhZxRz
 Wxgu/UPgb9RMH/Hu+sTeowaLD+jGiQqeGXHg9ey6Xcsx+zx5klBiIqOBvJG144HqwAoNhKgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=845 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150174

On 5/15/2025 5:08 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>>
>> +	void (*link_sta_statistics)(struct ieee80211_hw *hw,
>> +				    struct ieee80211_vif *vif,
>> +				    struct ieee80211_sta *sta,
>> +				    struct link_station_info *link_sinfo);
> 
> That should pass the link STA, not the STA, not just because I removed
> the link_id from link_sinfo, but also that just generally makes way more
> sense? Looking at this prototype you have no idea how to even do
> anything link related.

Oops! my bad :-(, just took this change from previous design.
missed this to change.

> 
> johannes


