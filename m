Return-Path: <linux-wireless+bounces-4391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19D8725E7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43041F2502F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781117565;
	Tue,  5 Mar 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R8kqbyqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FC17555
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660867; cv=none; b=JgyQdf3j8pTqWyiR8M2jEFRiVFMEyF4FIgpjwBgJ28zbFVbdLDZtLLI6xg9ZABZgA2qTf11LHA1lSVtPgDyX/JfHuqbypi/mz/ULdevP2vPuj/DPLWZj1uDsNG+EHUtMPssrHfCw/r3gMxZtx+/GKuKGml8dB8oIeGDLUsGl9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660867; c=relaxed/simple;
	bh=N7eNh8IZvDMzrE68BCP7HqyvBTrWV32ecvZRFoBqHlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p0i3IrnYraoinC+dbUFIO/okelXjjeszXBxtFDyfcaeSKf4J/mEbAcL1LRLqJy5gG5JpSVH4do1T544peXNttjZVON7kzXOl7+h/OmH5tzIcQsnYGaU1fsJpF27wMXHI8cUBd+EXNsDni0Go8pD1GLLiDkFqF5DBL8WeCcsx7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R8kqbyqC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425EjLNT010847;
	Tue, 5 Mar 2024 17:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/9mjHhrKB+1kPsBqQFfJFnWTDm3FMKxkw2M6ke8le9w=; b=R8
	kqbyqCRK43BS2/b6eKo2b0/199lKb4YtWOvFljSoYtng8g/reMtyPRjB6gs5iLzz
	ff4e2HWZTVZbXG4DlrxxJp6aln+zYQVSSuXsKF1pKnRYwmzS+ejphZZUZBQoY5+1
	tNkZiWHQNf2hz2ujhPTnfnRmbZnhDdNKydG1HsQZL37t0DEhAa39QS97vhDAX/K5
	lTsBqnonIFAJlbMTsf5mK+hOTcHqW7rSWSdJ0jBYq5yP7ncJ/Y4RzRcDAPNIpaiP
	jRGmDApje2wMELFJ+eV7+Gt8JAHiH+mTfJ02cHvw9qDEBmqM72okih6wd19zOwaC
	M/09VxELvBAzBsn6aOBA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnyyb97tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 17:47:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425HldIG019506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 17:47:39 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 09:47:38 -0800
Message-ID: <b59affc6-a88c-471a-9003-f09beb758a71@quicinc.com>
Date: Tue, 5 Mar 2024 09:47:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Isaev Ruslan <legale.legale@gmail.com>,
        <linux-wireless@vger.kernel.org>
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
 <7eec23f3-5e1d-4787-bba3-6b06549db091@quicinc.com>
 <e873f69e-e4b8-4dd0-a54a-191e9826ab56@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e873f69e-e4b8-4dd0-a54a-191e9826ab56@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I_hEnrXb0W7HGF5m9lN-vvegKdWj_734
X-Proofpoint-GUID: I_hEnrXb0W7HGF5m9lN-vvegKdWj_734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050142

On 3/5/2024 8:35 AM, Aditya Kumar Singh wrote:
> On 3/5/24 21:25, Jeff Johnson wrote:
>> On 3/5/2024 1:41 AM, Johannes Berg wrote:
>>> On Mon, 2024-03-04 at 23:01 +0300, Isaev Ruslan wrote:
>>>> v5 changes:
>>>> 	- add json print to print_ap_channel_report()
>>>> 	- minor refactor open_json_object()
>>>
>>> Alright, yay, so mechanical submission issues out of the way, this looks
>>> readable :)
>>
>>
>> Did the v5 version hit the list? I don't see it, and neither does lore:
>> <https://lore.kernel.org/all/5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com/>
>>
>> I received v4 directly, not via the list, and that was addressed to
>> "Undisclosed Recipients". lore also doesn't have v4:
>> <https://lore.kernel.org/all/8a0ba4b33aedd96f303db7cfe966b83b.legale.legale@gmail.com/>
>>
>> So I don't think the mechanical submission issues are out of the way
>> unless the list rejected the patch due to size, which seems unlikely.
>>
> 
> Yes it did -
> https://patchwork.kernel.org/project/linux-wireless/patch/d9739fa6d3dd085587c4f413087dfd6c.legale.legale@gmail.com/
> 
> Looks like the first reply started a separate thread. Probably 
> --in-reply-to was missed.
> 

Very strange. There is obviously still some Message-Id: strangeness
since the patchwork message id (and lore message id)
"d9739fa6d3dd085587c4f413087dfd6c.legale.legale@gmail.com" doesn't match
the In-Reply-To message id in Johannes' reply
"5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com"

Perhaps the patch was sent to Johannes as a separate unicast message
that was separate from the message sent to the list?

/jeff




