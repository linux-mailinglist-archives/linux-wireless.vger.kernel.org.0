Return-Path: <linux-wireless+bounces-19732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EECCA4D042
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 01:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778107A86A8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 00:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE219005D;
	Tue,  4 Mar 2025 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pyuF4SvD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83769156886
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048783; cv=none; b=CTeP3RQWvvWlcKMeJazBx0nrQDa/WIDpF1oCSlxXynszsTmIWKqIoQ4fkzCKwOPIfllumnOpBcRWLWmX40cxkuPCguSGtZkORSldKdubh6RJlE49SLpJh8MZw8kbrUllYZuYc791fxqXr2Az+T5Y5ExXDimHzJe0R1lXyPWqNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048783; c=relaxed/simple;
	bh=/hAlStDO55Q3DQARbK3ZZ7M0IwnAq3giWsAx8qPaUlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t/9lNO50bW/NnotvdT1d9+du34AYK4MbWXld10AT6cUQZOmfrFJ4r3E9J5m1LbAeGbWQkGi+n2SfoyWIj2/6JeZJOdQUK2aMfJvMQqJbQKHp/P7y9ZgriJLmu37xOBTenzUHZ5Kf0eglFb6x+QTzMnnnwmREG//gGKu4BoMGQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pyuF4SvD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NXSkX006765;
	Tue, 4 Mar 2025 00:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U7DbHjqKNRXjGTrqpA/bSALW6+Ball2Agi5PKn4Cw8k=; b=pyuF4SvDje836hAf
	WWfiAPdpwWCbLqDPRqXx95E8wxodlsxAdGg4bJw/WKZVOjYWNRWJzI6M/DIv5eyn
	UE6CKTBfY3UkZJJq2M+iy6fmNTr1jsBLK6OPY+5h5RIfHToDT6Vd7rITmItkocpW
	9FDD03NAEBjdo+EpmjsdhqOlWcPrwUrTZcLG7gLEgCWTx29D2oxYAxGHYO/c5UFK
	AOmtlCdAerpyG6oswT0r64WrcuufdwlHb3FcKC7a+LF/yiAdrBeE/XERxX8o+FMF
	x8YdVLUiCiBjdXzzWT8q5vra4ky2gSt1wVo0HGh/KBVF4LnOeo+Udwj1V9GFoDkQ
	fn0Hyg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tg3j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 00:39:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5240dZJm000982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Mar 2025 00:39:35 GMT
Received: from [10.227.106.66] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 16:39:34 -0800
Message-ID: <10aa25c3-293d-41e3-8140-52e6dae26fa4@quicinc.com>
Date: Mon, 3 Mar 2025 16:39:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mac80211: Create separate links for VLAN
 interfaces
Content-Language: en-GB
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250118015400.1919688-1-quic_msinada@quicinc.com>
 <20250118015400.1919688-2-quic_msinada@quicinc.com>
 <a5c7e7a5160c11c93052bb3f862a8089b0617bec.camel@sipsolutions.net>
From: Muna Sinada <quic_msinada@quicinc.com>
In-Reply-To: <a5c7e7a5160c11c93052bb3f862a8089b0617bec.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c64bc8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=k_xDEjxOtJk6ogS88m0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LmU79wKfAUt_UiwpwssOMn2h0ceZ_f31
X-Proofpoint-ORIG-GUID: LmU79wKfAUt_UiwpwssOMn2h0ceZ_f31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=552 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040003



On 2/28/2025 4:46 AM, Johannes Berg wrote:
> On Fri, 2025-01-17 at 17:53 -0800, Muna Sinada wrote:
>> +static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *sdata)
>> +{
>> +	struct ieee80211_sub_if_data *vlan;
>> +	struct ieee80211_link_data *link;
>> +	u16 master_links = sdata->vif.valid_links;
>> +	u16 new_links, vlan_links;
>> +	unsigned long add;
>> +
>> +	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
>> +		int link_id;
>> +
>> +		if (!vlan)
>> +			continue;
>> +
>> +		/* No support for 4addr with MLO yet */
>> +		if (vlan->wdev.use_4addr)
>> +			return;
> 
> That's weird, how would it happen that the vlan has 4-addr but you
> cannot check the main 'sdata' value? We don't even let you set that, I
> believe?
>
The AP_VLAN interface type is utilized by two features currently:
Dynamic VLAN and WDS (4addr). I am extending the AP_VLAN MLO link
handling when utilizing Dynamic VLAN. MLO 4addr feature will also
utilize this link handling but since the feature itself has not been
supported yet, I am checking for it and highlighting that the feature
is not supported yet. 
 

