Return-Path: <linux-wireless+bounces-13370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B94398B927
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60331C20970
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167F2192D74;
	Tue,  1 Oct 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aFjxoIq2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7203209
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777992; cv=none; b=Zu0yy6/ngfRcXO/h1spAEp6zerV7f1WY6juI1tKTRGapQ2BZ9k4qJFxQjSLUXJyO6/9TuLWUEWdsWun4iwUcPpCLcIXZS86XV868Dv0oMx/dvkM/FGyCMCEMSLe778CTOMjo5ey9js+EBo/UQ1ATm4hPW2LZZ3FncVpp5OWK1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777992; c=relaxed/simple;
	bh=GgAVkS7xzOhrsrMTEEYFTv7AtNFqdb8yQrt1hqTHTwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fYP6HPNyzSaGpC6wdZ6n1upDJeaRe6BwSJTRT7DjJ/2TZNsMZ+9iciyCHreZmvFVUcELc6+ee6LqTYUYBss7lKl9fPKUQjtIHf4VB1E6rfqPrkzts09jXG5cv4OwXoU4E9haBLoknRuujg2xscwUA0aPh8o8/wHmoFlm11wl07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aFjxoIq2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4910xvvW007005;
	Tue, 1 Oct 2024 10:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GysN16ZrVCbTXlibSYQpK3+5Q7D+Y4qUkimj6BuQZQ0=; b=aFjxoIq2UM8x7E0M
	x4sIPNZRIpo1N7EekhYSurlHh+iSJ7boIMDZ5WRXDjj5OCVHS6zFho6PnWnrnwoi
	2RIFxnl/Ke0XMgmOmoUdmYCC6PquqCU9YJvbmX2lMEtmvO/Rl6pdgfa8fCb5k/UJ
	bnCdIe6UXUAsgbD1pJ8DMt7Wf9Z84yBkvvD6T/qINShoGWZGeCAnqGL5hSB9CxjZ
	wfcCzeOV/+TNEGwkbwEN09Dv2ctvm1QZI0Vqgb9+aJQLtw6F/syX01rUZtajynG3
	lKhVI9WbYKC/EhVnLRhncajKR3gSM1WGvnY2hoktJT+9e4Tx/2W61BmgTyJ/HeEO
	ts6QRw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9vu7v0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 10:19:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 491AJIlk019627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 10:19:18 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 03:19:17 -0700
Message-ID: <6504caf7-e9d5-49ff-983e-73335f8ee3a1@quicinc.com>
Date: Tue, 1 Oct 2024 15:49:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: re-order assigning channel in activate
 links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20241001085034.2745669-1-quic_adisi@quicinc.com>
 <93df47a867ee1f8d84cabdbc953707eab2ea3704.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <93df47a867ee1f8d84cabdbc953707eab2ea3704.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wR3G7j3XeXT6qn8MSO-4iewg5H2RlxH1
X-Proofpoint-ORIG-GUID: wR3G7j3XeXT6qn8MSO-4iewg5H2RlxH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010066

On 10/1/24 15:29, Johannes Berg wrote:
> On Tue, 2024-10-01 at 14:20 +0530, Aditya Kumar Singh wrote:
>> The current flow in _ieee80211_set_active_links() does not align with the
>> operational requirements of drivers that groups multiple hardware
>> under a single wiphy. These drivers (e.g ath12k) rely on channel
>> assignment to determine the appropriate hardware for each link. Without
>> this, the drivers cannot correctly establish the link interface.
>>
>> Currently in _ieee80211_set_active_links(), after calling
>> drv_change_vif_links() on the driver, the state of all connected stations
>> is updated via drv_change_sta_links(). This is followed by handling keys
>> in the links, and finally, assigning the channel to the links.
>> Consequently, drv_change_sta_links() prompts drivers to create the station
>> entry at their level and within their firmware. However, since channels
>> have not yet been assigned to links at this stage, drivers have not
>> created the necessary link interface for establishing link stations,
>> leading to failures in activating the links.
>>
>> Therefore, re-order the logic so that after drv_change_vif_links() and
>> removing the old links, channels are assigned to newly added links.
>> Following this, the flow proceeds to station handling.
>>
> 
> I tried this again but I fear it fundamentally cannot work with iwlwifi.
> 
> We have this comment:
> 
>          /* Initialize rate control for the AP station, since we might be
>           * doing a link switch here - we cannot initialize it before since
>           * this needs the phy context assigned (and in FW?), and we cannot
>           * do it later because it needs to be initialized as soon as we're
>           * able to TX on the link, i.e. when active.
>           */
> 
> which sort of indicates that we're working around it, but it also
> correctly says that we cannot activate a link before we have the (link)
> station.
> 
> In the flow as you changed it we'd activate the link in firmware before
> the stations are added, but that isn't allowed. There's not really a

Is this a generic expectation? And that too only for ML STA? Since at 
least for ML AP, we could have links in firmware active and later when 
station connects, we create link stations.

> good place to hook into after the station is added, unless we somehow
> want to activate the link from the station change, but that seems ...
> odd to say the least? Though I guess it's already somewhat odd to init
> rate control here as written now...
> 
> Maybe we can hook into the later link info change. This seems to
> initially work, but still doing more tests:
> 

sure, hoping that it passes all ;)

-- 
Aditya


