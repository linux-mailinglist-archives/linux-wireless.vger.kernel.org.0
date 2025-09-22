Return-Path: <linux-wireless+bounces-27557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396DB8F07C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134231896AEC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D41607A4;
	Mon, 22 Sep 2025 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DxUGWfae"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8FE5464E
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519665; cv=none; b=k2MxE83LDGFn1hSfSjZHZLDGVXR2eF8JdIw7M+IfGtDn+KFIU3GmEtdjNP5NqGdFci03OS9q+Hkwa8hfuI1UR475n6DE0nj17ZA+BCyPREzQFaUllU/CP64MRE1IU+UYocrcliUqooYq1vSylRIEAttHJ0mjMwBLvlbZv5bChPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519665; c=relaxed/simple;
	bh=YHKjklrIGri95CjW97RpAHAAJOhrL4mNx9cFZvPyxjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rcOk4zlt7oQTePmtrorP6iJmGR+DRYan/9lHsiQ+bk8/KP/9/6IZ56meyp1KAdQdLveKhApGMZ6Vo2g275/cgQqM7KFJ8W76o7UXujL/yE0TtnuwCGuRW7fhUykhv7Dbf0XIuZBdF2LrKq+cgcyvlKqIc7iZklk3a145X9q2qJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DxUGWfae; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M0PVdW002772;
	Mon, 22 Sep 2025 05:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UE3KmgtLBX0vy2Q4WlPECqe6GgUvUMt9jI3GcdeBBLE=; b=DxUGWfae9fNzvwxZ
	leOyWL61B1TfEYs0DInmOS1Dh6KwCp5VTcgqxW/LZr9sfFiUGD03jebjsbvlrLh4
	KCBl8/zRjxVKXAT6//Mcj8r/8mext13Uw1Y7tftU1Str2vYfRLCFzGeJHr7dzUYZ
	/LRgMyu339MaBD+f6QpXAlF0BFkl20W21M2FvILpTG/Ttn2oKBXgjAeelBjY6owu
	ytD0ut/Fw/TwZ8KdV8gv/Rsit9YSJ62gWwWj4Jj1z3M55GDKgD0hoJpfP4/4Aq6z
	wVvYZKFsWZGRScAlKdJY9J33AxfzAnJ/NmAxDIIf60v+nIee3vrEDDb3rL0LNoZD
	lYHqAQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98bh6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:40:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58M5esZa024838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:40:54 GMT
Received: from [10.50.2.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Sun, 21 Sep
 2025 22:40:52 -0700
Message-ID: <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
Date: Mon, 22 Sep 2025 11:10:49 +0530
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
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XVGS7wenZsamnJXHNq6KC4hvTSlY5Y59
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX4+9i1jehZTgE
 PnjdABnq0LYgnb9tevkg/Amx5fa95l+6cnc6tlYdpbr/H6mdv6OHBni1mgAxuinaeHOaUzszrfc
 AAh3yrimT0J5sUijUSZKjU57NACx55UCXN4pk+V0fvJ4WkODrROlYIhUaM6HXk/QgXCv9AB8/6m
 wto1HufHInsYd+o0AU7JNrqIn0eA7IgFUaGWMel2p/wl1miceq7peihN424ux5clUT8Bgp1KIAW
 UBydMVVs6xcP54wEEpXYWFDZcuwt2uKfvTFrjSN9NJg6n1N/XfksGwQ4m9iIwurmZaP0UBsqNp6
 izDo6qohKDm7DcSR2hrD9fPBw9AvoQ7x+L8nLYIu+OaP8vp4xemmHPjNHCID3uwwUdhddIFXtD2
 CapwWBgY
X-Proofpoint-ORIG-GUID: XVGS7wenZsamnJXHNq6KC4hvTSlY5Y59
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d0e167 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=RnuLt5CFyc2cFHiVG0kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018



On 9/19/2025 3:17 PM, Johannes Berg wrote:
> On Fri, 2025-09-12 at 08:51 +0530, Amith A wrote:
>>   
>> +void ieee80211_incumbent_signal_detected_work(struct wiphy *wiphy,
>> +					      struct wiphy_work *work)
>> +{
>> +	struct ieee80211_local *local =
>> +		container_of(work, struct ieee80211_local,
>> +			     incumbent_signal_detected_work);
>> +	struct ieee80211_chanctx_conf *conf;
>> +	struct ieee80211_chanctx *ctx;
>> +
>> +	lockdep_assert_wiphy(local->hw.wiphy);
>> +
>> +	list_for_each_entry(ctx, &local->chanctx_list, list) {
>> +		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
>> +			continue;
>> +
>> +		if (!ctx->conf.incumbt_sig_intf_bmap)
>> +			continue;
>> +
>> +		conf = &ctx->conf;
>> +		cfg80211_incumbent_signal_detect_event(local->hw.wiphy,
>> +						       &conf->def,
>> +						       conf->incumbt_sig_intf_bmap,
>> +						       GFP_KERNEL);
>> +	}
>> +}
>> +
>>   void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
>>   				       struct wiphy_work *work)
>>   {
>> @@ -3592,6 +3618,19 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw,
>>   }
>>   EXPORT_SYMBOL(ieee80211_radar_detected);
>>   
>> +void ieee80211_incumbent_signal_detected(struct ieee80211_hw *hw,
>> +					 struct ieee80211_chanctx_conf *chanctx_conf,
>> +					 u32 incumbt_sig_intf_bmap)
>> +{
>> +	struct ieee80211_local *local = hw_to_local(hw);
>> +
>> +	chanctx_conf->incumbt_sig_intf_bmap = incumbt_sig_intf_bmap;
>> +
>> +	trace_api_incumbent_signal_detected(local, chanctx_conf);
>> +	wiphy_work_queue(hw->wiphy, &local->incumbent_signal_detected_work);
>> +}
>> +EXPORT_SYMBOL(ieee80211_incumbent_signal_detected);
> I don't understand why you need the massive complexity here to jump
> through the workqueue, if you have everything right here in hand to call
> the cfg80211 API?
>
> And if I'm missing why it's needed and it indeed _is_ needed, then you
> don't need the gfp argument for the cfg80211 API, at least at this point
> (until some other driver shows up using it) but as I said, why?
>
> johannes
The workqueue mechanism here can be removed as
ieee80211_incumbent_signal_detected() will be called from process context.
Will call the cfg80211 API directly from here.
As the GFP argument is not strictly required at this point, I will get
that removed too. Will send out the next version updating these.

