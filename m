Return-Path: <linux-wireless+bounces-4385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A287234B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42291C221EB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE207128394;
	Tue,  5 Mar 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n8Gso7Tn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FB12838E
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654149; cv=none; b=bj/vQwCoTEvWHHXnU0QrZqnpFsratcCfYgs3NARHbY1e+YHQDzPMHj0UIUgwdc3QdJR3mKcynPetw+6xt/ccc/m1ln3yQOM/bPicWOfZHK/WwgIODJEWU3V7I4rOhdwAcN8ELpm5ZV/YKNluu4zYux6BQ+SkjkKz3k3aaR8gDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654149; c=relaxed/simple;
	bh=xYNumxTpYQR36qb2eSP4j9z45RYREnvdnrSFS4ZSWvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ndL36S9O2keyISmgWt3xck0Ff/94giJR6KZlbQAI0pAvRr5TNMm4nm2fWBVcwXXZFhdV/hp49QAQo09Awrcvy/PtrYd6r2w1n6qA2/WVMxuOrMn3nFdKFpyUk04fSgsQ5w6wsWjIa0OwKH9cRa8C0aGjBo1ibCr6kDS1hnlfplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n8Gso7Tn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425CwUOS012651;
	Tue, 5 Mar 2024 15:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wdc/VGidXgix4Y1bGB+S5eACttvxOj5EwgjpvraGT/U=; b=n8
	Gso7TnSJMocwwFLPRjlRJ5Vex4tJiSjSL27ly2fvpaPwIoevrzb+P573KYHw9SF4
	2Fg6LKwAZ+m7/kWl5mvvNkuinRjulqDkmVQI+DvJkZnurOlAXegk6csgBjoS0cVq
	TOulixainlUw3aejiRBtjsjacOmLs+L8f70QZSuNkL6zZfSZd/x6bE62T6TBJnA9
	mf0nDNBrjxT2FMmdQzyvjYEd3qVbzOhI1Xi6S76vHE8+2PBq81ZnbWSKORhB32qx
	3uYgj4kEd9WiYFu+29M2MrXFILkH1YIQWsIpAyrRSA8R4xqjRnOOs8eV1UlmerUX
	HtkiZE0ELN4t8ouDFlmA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnpxhhxkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 15:55:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425FtgDA015778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 15:55:42 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 07:55:42 -0800
Message-ID: <7eec23f3-5e1d-4787-bba3-6b06549db091@quicinc.com>
Date: Tue, 5 Mar 2024 07:55:41 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Isaev Ruslan
	<legale.legale@gmail.com>,
        <linux-wireless@vger.kernel.org>
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zas650WyGn-sQ_UuRbsqlog4tFykYMPg
X-Proofpoint-GUID: zas650WyGn-sQ_UuRbsqlog4tFykYMPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=997
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403050127

On 3/5/2024 1:41 AM, Johannes Berg wrote:
> On Mon, 2024-03-04 at 23:01 +0300, Isaev Ruslan wrote:
>> v5 changes:
>> 	- add json print to print_ap_channel_report()
>> 	- minor refactor open_json_object()
> 
> Alright, yay, so mechanical submission issues out of the way, this looks
> readable :)


Did the v5 version hit the list? I don't see it, and neither does lore:
<https://lore.kernel.org/all/5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com/>

I received v4 directly, not via the list, and that was addressed to
"Undisclosed Recipients". lore also doesn't have v4:
<https://lore.kernel.org/all/8a0ba4b33aedd96f303db7cfe966b83b.legale.legale@gmail.com/>

So I don't think the mechanical submission issues are out of the way
unless the list rejected the patch due to size, which seems unlikely.

/jeff

