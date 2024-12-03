Return-Path: <linux-wireless+bounces-15850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A19E19CC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 11:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DCB1613B5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6EE1E1C17;
	Tue,  3 Dec 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RR4ARQhm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ACC1E0E06;
	Tue,  3 Dec 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222955; cv=none; b=B67m03DfJzTk597ARjPSqzU9hOSmfb3BzUgCgpW8ArtrXMvbzM9SAOWvvINXusoppkIO/3vAPBlD1OHhZkBXeRGWDAL+uyT4TwjqSvsRCaIsXx8byNu5uau1dp9Nx6asdrZivVeH0tUplb2548mj+FskAYNqwGRafp1asrjcH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222955; c=relaxed/simple;
	bh=5Z4X0EAWcr5p4VVQqtsIZbtRervKtcuPtRuQeOBrjfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OUabxql2ZMYAcS2lhFIfwCwbsh8Q2FHXM7gD8110XRfQKZ8TAtKv75gseu3XELFQhj4HLcKbiUO6fIuESKe2VSyGHr8MLHWvE3C5tHdl8to3eQ0FbVrgpNlJghzv6jzdVDM5qwpSDYIknlc4OeXeqfNcJJmLojniSowM3WwATUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RR4ARQhm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B39qtDA026206;
	Tue, 3 Dec 2024 10:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gg4Lw6AUq6SV1FhaAaFneT1sAjYVNu0Q1HHTBk/S4b8=; b=RR4ARQhmjaixtGDB
	msaXKXL+Cv19LWozbVadj3UmSavjDy0rHqwFvimMvw+GQC3EDsHmBRXgdZW4baZi
	DL/P26LXh7kUspmS5Wdm1BxOcETfWE8eRbxQKD/fCnjaBjy0YgXG2c/3gST9wJVw
	ZIGKkPQLbiSmGWST+Nxts/l9jQt/mHbULXKtYaGPNuuzePPn4tBrH+26x20xU+rC
	ZOzAgcLDx0gviKr+PAcaP8iGnrF4dEZedthJInfi/56/NmBJDEN4oXnkFvMdFZHI
	0ay0c64/6InvyFbpZCnVhBTc1pdhYvGUBOv8QISNf6itPp4GBJxpc9OheJ3qdRJR
	kMwa4g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439yr9g42p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 10:49:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3An4Bk019314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 10:49:04 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 02:49:01 -0800
Message-ID: <99359cc4-2279-4a8a-80a1-d5475fd5208d@quicinc.com>
Date: Tue, 3 Dec 2024 18:48:58 +0800
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
References: <20bf2693-ce53-48e9-8b54-7e3273815033@quicinc.com>
 <20241203094820.106225-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241203094820.106225-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: czjW776TEvtDxPyjodd6NLP1DK-ddMHT
X-Proofpoint-GUID: czjW776TEvtDxPyjodd6NLP1DK-ddMHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030093



On 12/3/2024 5:48 PM, Jose Ignacio Tornos Martinez wrote:
>> Which chip do you use?
> Since I am not totally sure about the useful information, let me show you
> the kernel logs:
> $ dmesg | grep ath11k
> [    3.659388] ath11k_pci 0000:01:00.0: BAR 0 [mem 0x84200000-0x843fffff 64bit]: assigned
> [    3.659405] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> [    3.659649] ath11k_pci 0000:01:00.0: MSI vectors: 32
> [    3.659653] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> [    4.871571] ath11k_pci 0000:01:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id 0x400c0210
> [    4.871586] ath11k_pci 0000:01:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> [    5.241485] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
> 
yes, you also use wcn6855 hw2.1.
> If I try to setup 2 APs with your interface combination I get this:
> # iw list | grep -A6 "valid interface combinations:"
> 	valid interface combinations:
> 		 * #{ managed } <= 2, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
> 		   total <= 16, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 80+80 MHz, 160 MHz }
> 
> 		 * #{ managed } <= 2, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
> 		   total <= 3, #channels <= 2, STA/AP BI must match
> 	HT Capability overrides:
2 combinations are to support DBS and DFS.
Combinations is correct. channels=2, max interfaces=3.

And you want setup sta + sap + sap, right?
When up the second sap will meet error? Could you pls share the error logs?

I'm not very sure if you add all interface with managed type, and do 
"ifconfig xxx up" before running hostapd.

You can try add second and third interface with
"iw dev xx interface add xx type __ap".


> # iw dev
> phy#0
> 	Interface wlp1s0_1
> 		ifindex 6
> 		wdev 0x4
> 		addr a2:42:d2:1e:89:a3
> 		type managed
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 	Interface wlp1s0_0
> 		ifindex 5
> 		wdev 0x3
> 		addr 52:e9:be:33:6a:61
> 		ssid test-qe-wpa2-psk
> 		type AP
> 		channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
> 		txpower 14.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 	Interface wlp1s0
> 		ifindex 3
> 		wdev 0x1
> 		addr c8:94:02:b5:fe:fb
> 		type managed
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> Or even this with no AP up:
> # iw dev
> phy#0
> 	Interface wlp1s0_1
> 		ifindex 6
> 		wdev 0x4
> 		addr ca:e5:84:22:10:ec
> 		type managed
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 	Interface wlp1s0_0
> 		ifindex 5
> 		wdev 0x3
> 		addr 9e:4e:c5:ea:4c:e9
> 		type AP
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 	Interface wlp1s0
> 		ifindex 3
> 		wdev 0x1
> 		addr c8:94:02:b5:fe:fb
> 		type managed
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 
> If I use the parameter to ignore the feature and configure the interface combination as before:
> # iw list | grep -A4 "valid interface combinations:"
> 	valid interface combinations:
> 		 * #{ managed } <= 1, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
> 		   total <= 16, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz }
> 
> 	HT Capability overrides:
> # iw dev
> phy#1
> 	Interface wlp1s0_1
> 		ifindex 7
> 		wdev 0x100000004
> 		addr 82:90:89:90:c1:37
> 		ssid test-qe-wpa3-psk
> 		type AP
> 		channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 	Interface wlp1s0_0
> 		ifindex 6
> 		wdev 0x100000003
> 		addr 6a:ef:d0:db:10:f0
> 		ssid test-qe-wpa2-psk
> 		type AP
> 		channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 	Interface wlp1s0
> 		ifindex 4
> 		wdev 0x100000001
> 		addr c8:94:02:b5:fe:fb
> 		type managed
> 		txpower 16.00 dBm
> 		multicast TXQ:
> 			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
> 			0	0	0	0	0	0	0	0		0
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 


