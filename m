Return-Path: <linux-wireless+bounces-6582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D68AB128
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D771F1F21EA4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245312F386;
	Fri, 19 Apr 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e2zyYOon"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A912DD9A
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538674; cv=none; b=bajEBlf06ZfIT9IBkuKAT41S4sb3Qg+B6MDl418RyI0tNbrkQZKQ76A4dm1EmC/cI8i9SloK99FJaUm/i6HFYxghaIt+oS8Aa0/gGoUrqq5iD4nuCNIuiI6+RloEuiHJlf86Vdjtg4Co3JdvdnAfnwdjsBaePvg4M/UfLEznCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538674; c=relaxed/simple;
	bh=v03FxfuNoCBiemBB6eoJRmlnZoU4QlwOdwedvVcXOyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uJQGi2qpnR6+IoodyEd8e7q72V4NaJWsuGqhKrGShh0dCfzVbkYu4fFpyCqSBbKLHZFZ2XV7oExa4oZRMLAMOfD2PLyhlkG11Gf94aHoYXswcWiO7qA9VBVnwuwgk/3rXlp3BvOcdOeuilP3ApqFc10CJME5xk4bLU7QbQ7nuCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e2zyYOon; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J2Gv0Y016749;
	Fri, 19 Apr 2024 14:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6F7NHhVAe9nbmFfYRVj8WYErLoLaeRk5UKxOpWra3bY=; b=e2
	zyYOon+lncyHvQkcdXmYSD16GK+rPidLgDmcyojiDERDCMjLv4ORpIm+mVIWQTaH
	DRrpGh4BZ5ZIk8HxoQelT8ccrt6RsZ3dQgZOdgDuzjfX15pZPu7MsfeABrYu4tKR
	2PIL5jFEDA0zmWv533LPQreHY3ZAYB7ktuHVaYFp99Bd+ToBJy9Fo3taGS+GOY5e
	ajcOKWZ4GtYRYt0E0tKVPX6O40iIDjbjB6EyeAUt1OBXFdD1M/jXLBlZAkfGjVDV
	xspgxygJcJ54YRyM92uQCfGsJH8fHMdOdnt97JBBOBdj03I3B9z6dwKwZaPrA/VH
	+4gDPFeM3kev/Aahh3LA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk9s7a3yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:57:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JEvnKh011159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:57:49 GMT
Received: from [10.110.91.89] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 07:57:47 -0700
Message-ID: <316bae34-617a-4db3-8a55-7045d657adda@quicinc.com>
Date: Fri, 19 Apr 2024 22:57:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
 <71414c51-26b2-4ce7-898c-5df0e8e31825@quicinc.com>
 <87h6fyhtrs.fsf@kernel.org>
 <a24666f5-503e-46fa-9232-df4748f824bf@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <a24666f5-503e-46fa-9232-df4748f824bf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wLtRpB1-MUz-Fs4zkW01jnSBJsuArOcE
X-Proofpoint-ORIG-GUID: wLtRpB1-MUz-Fs4zkW01jnSBJsuArOcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 mlxlogscore=679 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190112



On 2024/4/19 22:51, Jeff Johnson wrote:
> On 4/18/2024 9:16 PM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>> I can verify this doesn't crash my system, but apparently my ACPI doesn't have
>>> the underlying settings, so cannot verify actual functionality
>>
>> Thanks for testing. I hope Lingbo has a device with proper ACPI settings.
>>
>>> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi_evaluate_dsm() failed
>>> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: failed to get ACPI DSM data: -2
>>> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi failed: -2
>>
>> I just want to verify that these are debug messages, right? Normal users
>> shouldn't see any ACPI errors if there are no ACPI settings in the system.
> 
> Yes, those were debug messages (I've added ath12k.debug_mask=0xffffeffa to my
> boot command)
> 
> Also note my Qualcomm Innovation Center copyright checker reports that the two
> new files are missing 2024 copyright, so please update
> 
> /jeff
> 

thx jeff, i'll update the copyright.

best regards
Lingbo Kong


