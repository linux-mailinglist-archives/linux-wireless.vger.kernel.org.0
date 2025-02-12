Return-Path: <linux-wireless+bounces-18865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09DA3317F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 22:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F3188584F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 21:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279BE1FF5EB;
	Wed, 12 Feb 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NZsDzPCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A811FBC81
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396037; cv=none; b=cBNCL0uLI1p3wcInlusZUmvps4ckoU8CVnZoeQO1X0GiXAXNSN9s4DYsjNHQOhZdhmMjYgPPcVG7/9h0l1Wc5uswul8mRNNbzo34kEon7GwTCIQNYXR5lVYr1los4q39HihFKJ89nS42TeDJVAXRHn3kWkAhlFAkWt883JfKrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396037; c=relaxed/simple;
	bh=2vdpP3QXl1jjyzqLmhko4HuqP/zghkVbOvmFs9ha83s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cpH/MaM4kyjPTvxggcAaVvxIcVtpe656B6a7YaA7RmvkKO/DQyK9wi8hDK3UKH24NUoitMLoY3znObmpzu3EqCwsCY3aPaknzMgoWYijQLsg0wT7YC9ZMTUhjW61IYTwOl8wnqhSYTzbEEyoaN0ZDTOwVlkbgtKi0PK5HeSsZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NZsDzPCH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CL8NMn014045;
	Wed, 12 Feb 2025 21:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Ryu3ptL+EMDBx+GUb3VpsVV5oHbM8w70U5KImMU56w=; b=NZsDzPCHSfq+O/Hm
	jCsO06u8BG0Gy1np1rzQ+J34HJNx1Oyo8qqr2OSwswjjb3dO70WUdlA3HRZMiClg
	IAzTB9JF7XGAQm2iZq+PylKEBAtyRfmxuo9f8Ab7bDsoRJUtv/UYmVM57jOanG1d
	8uiPY59bdSnnqGN+F2O4zi/fGW5UekSB4VNtsqsV7teBIPNSGkoalONAl9eWgqHO
	nVMiuSv7AFpqYEMCFsINWmdT2DDtUZR4pjazW2hrhCCo1iCuMeaoPlHyDPuefjm3
	GvCLgXveBlHnKA0gqxftRpV9YHPK5VcGzra2LJJ+gIkDzLzW/KQv1y0HGQQOF3iA
	K2dJrg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rsd7sptb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:33:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51CLXoqq001350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:33:50 GMT
Received: from [10.110.103.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Feb
 2025 13:33:50 -0800
Message-ID: <0fba46da-0ff8-4fc4-ba69-eaeb2e25f109@quicinc.com>
Date: Wed, 12 Feb 2025 13:33:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/9] wifi: ath12k: clean up 80P80 support
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
 <20250114003813.2783550-8-quic_pradeepc@quicinc.com>
 <bddeb2c0867139e801845c65a78fd415460bd398.camel@freebox.fr>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <bddeb2c0867139e801845c65a78fd415460bd398.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tSSuGZ0JB8s8PVpHu3nkSlpxj6ST-sQq
X-Proofpoint-GUID: tSSuGZ0JB8s8PVpHu3nkSlpxj6ST-sQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=949 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120153



On 2/3/2025 2:28 AM, Maxime Bizon wrote:
> 
> On Mon, 2025-01-13 at 16:38 -0800, Pradeep Kumar Chitrapu wrote:
> 
> Hello,
> 
>> @@ -2859,16 +2848,11 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
>>                                                      struct ieee80211_link_sta *link_sta)
>>   {
>>          if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
>> -               switch (link_sta->vht_cap.cap &
>> -                       IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
>> -               case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
>> -                       return MODE_11AC_VHT160;
>> -               case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
>> -                       return MODE_11AC_VHT80_80;
>> -               default:
>> -                       /* not sure if this is a valid case? */
>> +               if (link_sta->vht_cap.cap &
>> +                   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
>>                          return MODE_11AC_VHT160;
>> -               }
>> +
>> +               return MODE_UNKNOWN;
> 
> 
> This breaks VHT 160Mhz for STA with NSS restriction.
> 
> Those don't set VHT_CAP_SUPP_CHAN_WIDTH_160MHZ (see
> IEEE80211_VHT_EXT_NSS_BW_CAPABLE)
> 
Thanks Maxime..will fix this in 7/9 and 8/9 patches

