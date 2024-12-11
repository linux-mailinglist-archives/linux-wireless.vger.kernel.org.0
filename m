Return-Path: <linux-wireless+bounces-16227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4CD9EC1FB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2375166C52
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452A1FBCA0;
	Wed, 11 Dec 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eLXwuQ6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3844384;
	Wed, 11 Dec 2024 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883038; cv=none; b=Pf1jQwZunvQw3uV76ZgBH4RbHJi2OTnB8b8d5NrmyhIe3iPaAzdlYIK2Pp1WNVEvHao0JElTl2UTP5A9Y47dSb2H4NcdjpcUOW7IgGZZS1EPe1Y63Y0PF9l/O8SDF9dkabntMj93z4QDZUXhVglBdKuC/XLQ8LtsXZwgiRjqXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883038; c=relaxed/simple;
	bh=ZISjs/hvsWRiKqvIS7x5BMxM+Zp47/6dBZVjntsLtK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qfSJN/MjeCPqMEG7FuJtFqtMaudEOrs5OTABrTMfrhO/3uOKCV70N0xb2+WoYDie+PnExk3pWAL9DF1t1Z9l+WWDCa0LvRYECqBxyvFDR7ePQA0HucGHxAYTgh0xRLJCz/VrXrqxnxQi8GvV89G1orR9v/PMPT57Edgmn1zSDx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eLXwuQ6Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB1fJx3014853;
	Wed, 11 Dec 2024 02:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2amnVrhJyNTdPfi+li73e2jRRi7A5M0l5Intio2miik=; b=eLXwuQ6QUjWrJptK
	y7bblKBipQLusBt1tKkuU8Fjj7z8VDgS/XD6HED6lfGBRZE79xsUMV/dpodLMJHM
	0WjhpsSGrYufAfz836cmLiGP2NpLRST3LAXGAM04JiI3xpKrcArRiviIyykqKXh4
	xE/tcmtDh8mA+bhshpFheRt9CiGLP59U8nE40hTjITYSU535OQxb65qlshdxk0Bw
	MU81bYRgw0QwbjNcYQm9O0i3ItP7xvY91iU05rRAXOk8b+pzoGZOPkhE1VO2Mkd5
	h8TJXQFx3U6cFGaxn97OXy/G9lnvxkF7XLwSaQBHyWI59ZetSLQOKDkFShMhVpeK
	41mhsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ee3nbcwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 02:10:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BB2ASJZ012332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 02:10:28 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 18:10:25 -0800
Message-ID: <d8705140-e335-47e0-ac70-47d8592fb18c@quicinc.com>
Date: Wed, 11 Dec 2024 10:10:23 +0800
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
References: <db61f998-2524-4623-8b0f-143661507e38@quicinc.com>
 <20241210084419.126723-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241210084419.126723-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D2iBK7HZnT67Bwi170oWgKBPTAmm2BtO
X-Proofpoint-ORIG-GUID: D2iBK7HZnT67Bwi170oWgKBPTAmm2BtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110015



On 12/10/2024 4:44 PM, Jose Ignacio Tornos Martinez wrote:
>> Yes, Can you pls share the complete steps and commands?
> Sure, I offered it before.
> 
> You need NetworkManager and of course NetworkManager-wifi packages installed
> and working.
> We are using Fedora/rhel with the default configuration and you can configure,
> before the next steps, the wifi interface as sta from NetworkManager or not
> (with no wifi configuration the same result happens) because it is going to
> be unmanaged.
> 
> After booting (wlp1s0 is the wifi interface for ath11k and there are no other
> wifi cards in the system), here the necessary steps with our network
> configuration:
> # nmcli  device set wlp1s0 managed off
> # ip link set wlp1s0 up
> # ip link add name wifi_br0 type bridge
> # ip addr add 192.168.254.1/24 dev wifi_br0
> # ip link set wifi_br0 up
> # iw dev wlp1s0 interface add wlp1s0_0 type __ap
> # iw dev wlp1s0 interface add wlp1s0_1 type __ap
> # systemd-run --unit hostapd1 hostapd -dd /tmp/hostapd1.conf
> # systemd-run --unit hostapd2 hostapd -dd /tmp/hostapd2.conf
> # dnsmasq \
>      --pid-file=/tmp/dnsmasq_wireless.pid \
>      --port=63 \
>      --no-hosts \
>      --interface=wifi_br0 \
>      --bind-interfaces \
>      --dhcp-range=192.168.254.2,192.168.254.205,60m \
>      --dhcp-option=option:router,192.168.254.1 \
>      --dhcp-leasefile=/var/lib/dnsmasq/hostapd.leases \
>      --dhcp-lease-max=200
> 
> After booting I get the same issue just doing:
> # nmcli  device set wlp1s0 managed off
> # ip link set wlp1s0 up
> And the step that you commented in a previous answer:
> # iw dev wlp1s0 interface add wlp1s0_0 type __ap
> # iw dev wlp1s0 interface add wlp1s0_1 type __ap
> # hostapd hostapd1.conf &
> # hostapd hostapd2.conf &
> 
Got it, you use Networkmanager, so that the add interface type will 
always be managed. But it's still work fine in my device that I use 
"hostapd hostapd2.conf" to up the second ap.

So could you share your log about it? Enable debug and tracer about 
ath11k and mac80211, and share the the recorded trace?

> You can use whatever hostapd configuration (with the suitable interface name).
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 


