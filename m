Return-Path: <linux-wireless+bounces-3429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2AB850DE3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744A92884D4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F00C132;
	Mon, 12 Feb 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MqBtjxrR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F81C13F
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722321; cv=none; b=hwAlXuK9LH3CobVuUvKrRvJ8G9GwyRO5c8iLWke0Bjgk295IvNVVLDhJrqKbopmsH1pL9rOK1eGXoZdg4oWL7UMRNF4KU32a3NW1kT2kRXN8fw9mfhFig2PFDxUB2oSomdjOfKX5QNbR2f8Sz/7cH6B/MzK52DVhIkG5f38sMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722321; c=relaxed/simple;
	bh=aAcW5Qmm3uah+husVzPPf/PN93qPB9PHqLmx7C0MIyI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=OiMzJFRoewO02A4HQ+zkGw2imlzutYYAFlpW8DOP+5xKBZO0+qG9BUNygrHbDZhNDC0XnFTiy08SZ8AkYsv2eaeUeSt3X5oqIpgbNgZrWfAggiMR1bpvXga7iAA0ch7BYPMau+uRhAqUubbgpSQdk3a4r8HbLz9qkf48LDAn/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MqBtjxrR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C777AZ025205;
	Mon, 12 Feb 2024 07:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GnhJthYrmtCTmRBX1GV9j4uq9xdVNcyjg3AVg2HDibk=; b=Mq
	BtjxrRquUtogjKqGuPTtXzEj1VNm9Dy0MKile+P34UMWn60XMIGZzmNtk4o+z6H0
	TMnJUztaffNwqRwSJwZ+HZP6HEFU/do+ri7wrhjqNj/z4y2rk9Gi0N8spereL/23
	nzq4ccruLEWUJN0qKmqYy+SF7137ANTKhhs2JhYSm97jLOJ7uGb9qp0+onj6bnbi
	RUpILZY0pQerVEC4zf6hOq4lHCQRv3XjbjgH64lKkB86ndgZyK0Madyo9Ocj/PIJ
	3yfzptIeyvafC2NFPEzaqJ7ES7QQHB+cKSYIoYYaKCZn6pB+TB+W5WLW0PlLlRrF
	/mk8ckzm5rp5NyQ7fugw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62kt2pqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 07:18:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C7IZfY023680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 07:18:35 GMT
Received: from [10.216.20.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 11 Feb
 2024 23:18:34 -0800
Message-ID: <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
Date: Mon, 12 Feb 2024 12:48:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
In-Reply-To: <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 70ZRcWSNDo60ZSwrUsflsVwvuKjmyb5a
X-Proofpoint-ORIG-GUID: 70ZRcWSNDo60ZSwrUsflsVwvuKjmyb5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120054

On 2/12/24 12:10, Aditya Kumar Singh wrote:
> On 2/8/24 19:35, Johannes Berg wrote:
>> On Thu, 2024-02-08 at 14:48 +0100, Johannes Berg wrote:
>>> On Tue, 2024-01-30 at 19:39 +0530, Aditya Kumar Singh wrote:
>>>> Add changes to start a channel switch as well as finalize it on link 
>>>> basis
>>>> in order to support CSA with MLO as well.
>>>>
>>>
>>> FYI, this had a number of conflicts with my other work - please check
>>> the tree now.
>>>
>>
>> Also here btw, some hostap test with hwsim would be nice - though again
>> don't know how well hostapd supports all this yet.
>>
>> johannes
> 
> Sure, I will rebase on latest ToT and will add some hwsim test cases (if 
> supported well in hostapd) as well.
> 
> 

My bad! I see you have applied the changes. Thanks :)
Looks good to me. Let me see on the hwsim test cases and if possible 
send it soon for review to Jouni.


