Return-Path: <linux-wireless+bounces-4606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC98790E9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574691F25B29
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3169C79B62;
	Tue, 12 Mar 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hh8BbXaY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B37994D
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235399; cv=none; b=JlfowJcOFxRal6PLUiaASzWq5FAQIqMLcUed9TaK2MQ7075rQGr5miLdOYxTFIzE7+yo+DVlmg3I8q5S67Weza06V6z78KDgudCuJrw+m4knm4JW+1/EavPZhPk/GnIZpU2H6st4aj/wGaxojhxAHto8cY8GCvqCbDxnjLOaTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235399; c=relaxed/simple;
	bh=DC+YtlnL/Z6qy48ylKxp7c6h9b6EkSgjimDeGp/l+hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jyvAy6JYQTjVzDMOmdtr5tA1RghKZhDm278WGEVuMTelrf2shS8EdR//o5v+XMcRFRrToNE/xv/VyqSNvESJ4wkTMf2b4nZqfqlk5FgYIIam1iQkfArV1PBWBChp4ZXabaHkmT0Nz6csW7k7vWncxLptkkqJazO8Sz/h4ib9iFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hh8BbXaY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C7XMNs023593;
	Tue, 12 Mar 2024 09:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=synPQhheQ7nttk4p7RxsmUA/ZDUQQxQq5beeblx3oTU=; b=Hh
	8BbXaYX9rlWOFgBQL4wGCpg3U2rdpGRUULaAsujVuHHJ0Qkk08aJp8cjC2+q1G3v
	zKHyJOtYTczMf7lom/RiCtH4B722l7ubxlPlWXFllTXSX04WslAS8xJ/FaFxfOIr
	Vd2pnuQVtTXMYq3LCfJVYVeNK9eW4g6nTZgLRZdNnNeuSwo6Br2LnXvCX+ODTXJe
	n4mKog+h5RpfDU9jDBXUxpcqlBLPUErf8ik/4Etcv5JPOzhc56h2WPXPrKUwOSF7
	82GvsXngsJRVDQBxhOwq7/VjXNOEdyZ9b3Noap7TKbBiLxpV1f1VRQfk/c5ppxJ/
	CxrkiEcen/ETZi+N28gw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wt75e9h33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:23:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C9N1PH021151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:23:01 GMT
Received: from [10.253.9.188] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 02:22:59 -0700
Message-ID: <4c1adfca-96aa-4b41-86b0-2fe5ad3e6cfb@quicinc.com>
Date: Tue, 12 Mar 2024 17:22:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mac80211: supplement parsing of puncturing
 bitmap
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240312045947.576231-1-quic_kangyang@quicinc.com>
 <20240312045947.576231-2-quic_kangyang@quicinc.com>
 <8cc7e7f7b2914385b481ecfdd7bc3f67fc4546b3.camel@sipsolutions.net>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <8cc7e7f7b2914385b481ecfdd7bc3f67fc4546b3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M-UDRIE9omzwNjmEBQ68hSYJk6VkVDcD
X-Proofpoint-ORIG-GUID: M-UDRIE9omzwNjmEBQ68hSYJk6VkVDcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120072



On 3/12/2024 4:16 PM, Johannes Berg wrote:
> On Tue, 2024-03-12 at 12:59 +0800, Kang Yang wrote:
>> Current mac80211 won't parsing puncturing bitmap when process EHT
>> Operation element in 6 GHz band or Bandwidth Indication element. This
>> leads to puncturing bitmap cannot be updated in related situations, such
>> as connecting to an EHT AP in 6 GHz band.
>>
>> So supplement parsing of puncturing bitmap for these elements.
> 
> Hah, yes, I just noticed that too and fixed the second part yesterday,
> and was still thinking about how I could test the first part :-)
> 

Should we add validation for puncturing bitmap in 
validate_chandef_by_6ghz_he_eht_oper()?



> johannes
> 
> 

