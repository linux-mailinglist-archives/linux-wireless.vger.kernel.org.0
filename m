Return-Path: <linux-wireless+bounces-16390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21A9F1759
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 21:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC22A16814D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4C19004D;
	Fri, 13 Dec 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DpNnludt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F718F2FB
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121539; cv=none; b=bG4ORYVeWjrSi3a+U9tu4zA5jNh9OsmFxIxK8hjPr6m2pSNbemWpn4GvzSHfZPzE2jDcjI79u1OsUXeHgDBlBEc/JfFnJ5/MikYWpfvgnPYVrjb3Zb+lxfHWLu9+YumUj5gDLJAlqGv8NDMgZBkFENgOpTjV6oIAtq8D65b3ikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121539; c=relaxed/simple;
	bh=5ktA0ZT7tz8arwrKfqrsfHc09v9JdaQX1Jxmm7pP0qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PRwJl3yPQ+1tqdMR75GuMIFkfUjuiJSPlsK9xu4vxu5zyyMTvnbNOJiuGDEa8WJ+OsMPd6uhEjBqw9rLQcngl8hpr8zCwElf7KgHgoneT0oz7da5OiPVAvr6jjgHwBfInOE5EoyofsvGUE2lu+2NwQyQP2KeO9hurODq6mO8sOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DpNnludt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD91RM9022816
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 20:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmRFI9gUpRDIogu7JEU+9UOxaWz+Zl66rjDH26k11ps=; b=DpNnludtIQlvtJu3
	CFCyZEqndE28xk/7Cgt4TtjNbfG/nt4Xn4MQapJziLD/7/uxV7Rr8RjqPTw31ogw
	YNhhWPs9MuBfhjsljlt017wnqpval0Qd1AfxfSN7Sawl/N4k9RGVGCEK8FK7uBDg
	3VKC6yUd1Ba15HhltuNhd8UrMAIXMYvQPcOzp6aIroPpZN1KBOwH0u37H3KZVER+
	SKx2vWyiyMnY0Vw3DdsxCn/MLOhlsk6+BQnzTPwXrzDdwwSIqNA03EyCOBB19/WX
	m1djB370M4RLyHXrd4ccGmw6TjHidcpu9bIPL7UyaxGouBL116zE4VQcb8zjJIVV
	2TXaqg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wnbk8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 20:25:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2165433e229so18848635ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734121536; x=1734726336;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmRFI9gUpRDIogu7JEU+9UOxaWz+Zl66rjDH26k11ps=;
        b=wT1RS9wXN+XcycfY1YNCcqpR5e1BEWdNMUFqtVRirJYkoPq1qzPyj+IE2/VxM43Zpk
         DQtRBDvac7V2AYL5MrEf93QzK0l8p0GcJnx+X5g2cOGqxGdzeMLqG9regGaQyDr7CHgP
         lcesCdcWdfxsgUm06TG13f6wnSmBNEidg5MKIZWt7O7gesTo4qKGb0LjOBX/p7TKed84
         Ur4dAcCCNe6MlN7ZqXPlop5f7K3pZMRuNoG99//bnLMt/1qFS5DUSCE1VPjL3CgmD3De
         IRCYzOlTey1OfIUzpwQnwYfozE8o4Dnt/ZxfN2NXWVIsWEHtF2jrunP2K33uYnYf9Fl8
         Ds1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+69heNqrwZX7czNMluyp9wpoAemVMYXcb5BwVCU6WHXHQwcDWYy0aVvvDsJil1OqMh5Fay//k5kiTwEWgpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDqrYJcyadMSMvFHKp8wUmp2c8vfi1MGZifyDdqML0VnPoZCR/
	+/vghWAHWBBFl4tmIQjKQnYAdRDUiWmGrNOgD5LHipy+jIx4R1CxYYXw8INhWHbwHnugX0vWscX
	ofsuIwyiQIu2Qjgz8432qxXPVu2U1kigMiqnpJpGRZwJTF9uvJEDol9j7Liz3X+wDX7Tv1iXqWg
	==
X-Gm-Gg: ASbGncsBc43VX0NLJ7B3fZ6X8ZDlZyUZUz7JCly4qq3/QrGx2kZWmfbQeYn4urGXDOG
	EeGxyS6H5rY4ZcKBVlK58EKODev/8QMGC79HcQwxy6Cic0BtqIV6IxUrAWKMh9yux0p5Yz8X5Ul
	tZPmcuqncuJlJfoBDyzLNONqbKqaYycwwxIk4LqZhkM4tyGT+tql+EUYmqIRSnnQeihZJEJeRvS
	cP2pQ/T5u5z2vY0Wahs6Fb9RePipV7U990vNhUKTKHPEtsNU7H5EhXTZElTlZUYqFdEMfxrfO4I
	XWgxb4jwY3hbVZteQDmInzUarfA5P34DZ5DelCRL0B0IkSfNwQ==
X-Received: by 2002:a17:902:ce05:b0:216:1543:195d with SMTP id d9443c01a7336-218929c3837mr66490835ad.25.1734121536110;
        Fri, 13 Dec 2024 12:25:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUFn4gpvwjn3+Ax9eN3kTAQivr+nZBo80aiHBorFaQVtOfA+e62nW9+q/7SlW7NwVLujCyzw==
X-Received: by 2002:a17:902:ce05:b0:216:1543:195d with SMTP id d9443c01a7336-218929c3837mr66490545ad.25.1734121535714;
        Fri, 13 Dec 2024 12:25:35 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6578fsm1581285ad.248.2024.12.13.12.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 12:25:35 -0800 (PST)
Message-ID: <d2afca1a-7d96-42aa-b755-883a3070edce@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 12:25:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC on per-link stats reporting.
To: Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <ffe9a994-2866-b25a-5aaf-bb5089916c7e@candelatech.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ffe9a994-2866-b25a-5aaf-bb5089916c7e@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qxNS1OAIDJmdrjhTU7oM8kYIrc8ml6dd
X-Proofpoint-GUID: qxNS1OAIDJmdrjhTU7oM8kYIrc8ml6dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=931 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130146

On 12/13/2024 10:51 AM, Ben Greear wrote:
> Hello,
> 
> While trying to better understand how MLO was working, I started
> on some code to gather stats from the driver so that mac80211 has
> visibility into it.
> 
> 
> In particular, I added a small struct to hold per-link stats for up to 3 links
> to the station_info struct.  Then in the driver, I gather the available info
> when mac80211 asks for the station info.
> 
> 
> #define IEEE80211_MAX_STA_INFO_LINK 3
> /**
>   * struct station_info_link -- Link info
>   *
>   * Same definitions as in station_info, but for links.
>   */
> struct station_info_link {
> 	u64 filled;
> 	s8 rx_beacon_signal_avg;
> 	struct rate_info txrate;
> };
> 
> struct station_info {
> ....
> 	struct station_info_link link_info[IEEE80211_MAX_STA_INFO_LINK];
> }
> 
> Is there any interest in this approach for the upstream kernel?
> 
> Thanks,
> Ben
> 

There is definitely interest since Qualcomm is also working on an RFC for this
functionality. You can wait for our proposal, or publish your own.

In addition, Qualcomm is working on an RFC for supporting per-radio attributes
via get/set wiphy for drivers that support multi-radio wiphys.

We hope to have these RFCs out next week...

/jeff

