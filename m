Return-Path: <linux-wireless+bounces-15882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAAA9E365D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3040166CF7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A324193072;
	Wed,  4 Dec 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H/hePZXY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F5BE5E;
	Wed,  4 Dec 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303951; cv=none; b=BmuIXayGBQswvu+/2WCPYXqk/aRFYmdUm61HUmcHadf+FGWFywiNR8gcWPqqHDKCPRJVkPY6KAC2/LYP2FORmoJwhMD1ovv3YRjBxXLfCCBiW5IwLmCzzZTIcJ1bhDFjtJpo6x3qdB407RL3ByQXgeBTm+I2+uAO6Oe/072fiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303951; c=relaxed/simple;
	bh=a/TiQBAn8mB5DG3m5NaKujcwCQeL/Tj7UURK3WB1Av4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HACcnGgRTPS9YvXWX1ewiwAkypGALjM/mixjTW9zS+MlepesylVKRo3eyOL2ghKtijauL1CNiA4vI3OPEKRdzxB8KjIwPZ3CfGu67CwxQQSxmNBjBV0Z75/DHtBjUEJcKAZEoGmRdl2al6MWU3pyTwcOTJ5Q3fTJsMEFoqh8DqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H/hePZXY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B47OxXX031188;
	Wed, 4 Dec 2024 09:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NsQC541Wy2M5AkIUI3XoGDVWyD/Fqu65MZwjqEEUb8E=; b=H/hePZXYezdqQiI5
	s6s8ZCXANi13LiHje+a07LCs/Xaqbr8SCxQOZ6jkExugb8Pnm4o8UJ0Q7/su4ChV
	06Yg5I98VZe9gQ4oQ/c+XStMTmDmQSNm6CuVWjD2JuWBtMb1PeoaFyVVGQXe+FrG
	85eAV0P1kkdm0gQJf8SlXdjVybBYZL1Oqcbk5xBNBwK6JNT5Kmy2cFNqUsHtjFSB
	wjAIqPfmOpUN3rHib3Ct5immVHcLGimkSV709r+fIvqOCxGA7+3nMCrJERuELqr9
	a2FGw4Fyi6msLfscshFlAEi4/LhkUhTZHfuRp1hxT0x9O6lVSoDVfAg0/JcQSk1F
	YjdwlQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w90upym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 09:19:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B49J0L3020539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 09:19:00 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Dec 2024
 01:18:58 -0800
Message-ID: <f75a1655-fa5d-4675-85d0-b9b97dceba6f@quicinc.com>
Date: Wed, 4 Dec 2024 17:18:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <1b09c2c9-53bd-4960-b09c-7468f506b0a3@quicinc.com>
 <20241204075128.5547-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241204075128.5547-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xXpfcqjeULg995snnzaHt5ebHfUuIjp8
X-Proofpoint-GUID: xXpfcqjeULg995snnzaHt5ebHfUuIjp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040072



On 12/4/2024 3:51 PM, Jose Ignacio Tornos Martinez wrote:
>> Pls try add interface with type __ap or directly use hostapd up the ap
>> interfaces that will re-type managed to ap.
> This is what I am doing.
But I see your interfaces all be added with managed， right?
> 
>> f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces") update about
>> interface combination limits.
> My patch by means of a parameter allows to come back to the original
> interface combination (before f019f4dff2e4 and not the current one that
> you comment), so as I commented, this is the interface combination that
> I am finally using to setup the two APs:
> # iw list | grep -A4 "valid interface combinations:"
>   	valid interface combinations:
>   		 * #{ managed } <= 1, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
>   		   total <= 16, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz }
>   
>   	HT Capability overrides:
> And I repeat that with that, my setup is working (no error log).
> 
>> If chip support DBS, station interfaces max is 2 that why you can't up
>> the 3rd managed type interface. You better add interface with ap type.
> Ok, but as I commented this is what I am doing.
> Just to clarify, only with your proposed interface combination I am getting
> problems with a 3rd managed type interface.
> 
>> 2.4GHz works fine also.
> That is great.
> 
> Ok, at this point, as I need my setup, in order to allow me to debug and
> get the differences, could you share how you are configuring the two APs to
> test and debug here?
> 
sure.

apply f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
apply 
https://lore.kernel.org/all/20241127022742.4016870-1-quic_yuzha@quicinc.com/

Test steps:
1. add interface
#iw dev wlan0 interface add wlan1 type __ap
#iw dev wlan0 interface add wlan2 type __ap

2.run hostapd
#hostapd hostapd1.conf &
#hostapd hostapd2.conf &

refer hostapd.conf:
---
interface=wlan1
driver=nl80211
ssid=QSoftAP1
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=12345678
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
rsn_pairwise=CCMP
---
> Thanks
> 
> Best regards
> Jose Ignacio
> 


