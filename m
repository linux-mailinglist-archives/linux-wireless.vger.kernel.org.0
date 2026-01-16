Return-Path: <linux-wireless+bounces-30897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53788D2C042
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 06:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9FFB300FD7A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 05:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CA2C0268;
	Fri, 16 Jan 2026 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwI5RyyC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fiwL9/cb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A322CBE6
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541752; cv=none; b=qhGIcmEGjyfLybSq83ENf/RVFrefI19UUl18jQcv0yf+Nx8PCfIvh1RUSobzvwBt5O8tBsO84lsbaJUhFsmTm7xhn+w3WJ8ZuUIKujvT+OkOBmJBSSlx7vdgGNzXBFIJlTFVb1P4FWPZQ4EPsD/8ld/z2QbC3DNg8OZMivTOYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541752; c=relaxed/simple;
	bh=RDFsCkBw4ffxZgGxCrdyGZjfEyT6J49DkXMpsG04aFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqAMh3l8EAsqp85W7B4Ylyz3JzYU0YNBELWj5P/cNSpfNWaOUJF/7XWfwsAAMLr/cJI3pD4gmEVe/psrfaQ4LpZ8iNgXHWZ/7dGKG/1K+ThkaWa9h+UfzLo0SewSL4J5/RbRVdpKMgjozgQ8Dsxljf/ulg8KFNO8BMUq7FvA3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwI5RyyC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fiwL9/cb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMd1Qt2615346
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 05:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zc4GU0JhD4P+ys3iMpcjRHxZfyEWSl8TTgK4sP2oY7Y=; b=gwI5RyyCDWavmM4G
	RJTEu/1J6vn+sEOfk8AeeLB8Vj0cybf7f+uN3xjWfkAo/kIVuORRqelAvtNRBLv/
	G+mSxZmG3gxAlupNPAE6FxoH3mRIB7ON3RNo4PESMD0mKSIO/fJfrERxgMBZ+bs1
	TbskeQ1jtrqTBb0KKYv3FB5rsZZPJbF6hU3Fb/czu2eY4brUxmZXCYTHcp9WZhIv
	w/H81XZXoZEyDt/2peDiBmLj5z1niJ+ietgh2BQDtoPs74ynNNU/xioeu9yl1SkL
	7ipsokCnPcDPceyjwPoyrwya18QPdBxfGdrMe7uQM8kbDDoGsDDxtad1RCNyjPHP
	aRUrXg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq977rxtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 05:35:50 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-123840bf029so4013946c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 21:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768541749; x=1769146549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zc4GU0JhD4P+ys3iMpcjRHxZfyEWSl8TTgK4sP2oY7Y=;
        b=fiwL9/cbjaw+NlwO7br0SSMuaom8IhVKIzNYssvkN/3tv0jPvL59v+Aw7IwY9DpvmH
         hA9ArUm3JaeBG0dGZmZKFFcm8uApmVwfG/AfUONXJoI1RuZThq9aVahl11z8tHvhmcMW
         t8dm+4T6syXsLFiJqneZlE0yso/YYTIUsm0e7AcGqrmAmEIJOXjnkTW3ABqop2DWxMyL
         jV+sSyWGv1bL6u5ZHFSgvB5HInBIFzM6D0L8KB5YXf0jZJ2wJ5YJXip6OCYE6lz3QPWU
         PpNMXamWNVeLp9RyWDdtKalLy9mXF770Q5+YM9kWi7Uc66ySdeyOyEPLFfWfgALpn8RE
         rYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768541749; x=1769146549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zc4GU0JhD4P+ys3iMpcjRHxZfyEWSl8TTgK4sP2oY7Y=;
        b=ksehtH/kCdJsdKNqGL8mG48HCM6ZgXtJlZXRaQ3F8dWmtpIj7JjEHz0bBKDCKuasHr
         SYp5iL/CBGWe3//MFHPoNE/xLC18/faraOCLdYcQQj+7sWMq/ny6+3oC3pufQep8zB/B
         4rEBWfHSbTH5LNHY+VUL4fo5v+Smzn1N52bDUPYBntAT3jMryUdZZV47i0D9WP1G04jl
         g+x+dBf4C8Al+CzmZpNTwjsnMpatPJdSnL2YrtRHKjQiXjXeejLCv+kkCM557IgfNNaF
         U6LmygyIm0bIsBafOenlfXyax2I+z4Px/z7EEhhYAA47kggKIeE+oEqdiMO/hmqRvA4I
         7ggw==
X-Gm-Message-State: AOJu0Yzr7FIgsFjurIgZvNTMi8t9yCE7378OpVvbqkQxFVFSOkjyc3lG
	DSeMayVbZ7e9zUQl0OpE/aPjiJ/UCQ90rYDzOnnIsVQPqTxhHl/O0Hvpa8/Xb+l0byvbYYUhuLo
	vdQKce7ikKa7FRtmQ3dScSZx1Zs8EenjgPRXUkM15QdoZQ+hC77r+9b/TnG/0wixvBy6sVQ==
X-Gm-Gg: AY/fxX5EJqLImKzF4ywDiatmhoCHkvrBOXM4VDr0u2E6e/sObG9Sx+gJp2i9nV3JiNT
	ByV9IqkSh+eIwsCwCJdXCY2iJqO9PRZPpxkbrmwZkeA+7BPLRkecIoMk4zj5/QrFPfKUUJDO9mU
	aVNocw1EdjHHLgDHuDZUgb3txkepigPoYrNmfXezdCQj3VLl7BuFDpd0Rej/u32YqAkAx9b7V/D
	XEMoz41TtoHuysdDw+0GFE9IwVCxgdnMB70SBcyXyd6+12xqtT1YRWr/XEGCzbNDG9VT8Sm7N8e
	tWLflWvf92/CCts3bsMsbWRWUe1S1knVDlq+FwfzTgLvyTKeJZHa8qZw38vgsFhZ6h4WFFvceHX
	KH/WNhvrpH8+SCWF6Eo+54cIEdBdiWyAWzmASbRtypdh/DMhjm+k1L8m27vTiNHuem4VgaECSe4
	Pu
X-Received: by 2002:a05:7022:2204:b0:11e:163:be60 with SMTP id a92af1059eb24-1244a75eb15mr1951977c88.31.1768541748999;
        Thu, 15 Jan 2026 21:35:48 -0800 (PST)
X-Received: by 2002:a05:7022:2204:b0:11e:163:be60 with SMTP id a92af1059eb24-1244a75eb15mr1951970c88.31.1768541748488;
        Thu, 15 Jan 2026 21:35:48 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad72063sm1626095c88.6.2026.01.15.21.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 21:35:48 -0800 (PST)
Message-ID: <3037eb6f-d17b-4984-9c12-a3ae5e373595@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 21:35:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: Qian Zhang <qian.zhang@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Yu Zhang <yu.zhang@oss.qualcomm.com>
References: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
 <717658b7-91da-4073-a746-a389319aac2d@oss.qualcomm.com>
 <a7a73ad1-0761-4abc-acc9-fc94a4e77348@oss.qualcomm.com>
 <f0e98751-8fed-4cb8-9cc6-59a691f172b5@oss.qualcomm.com>
 <0f4fa27e-d9b4-4a23-8c8d-53f4a7014167@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <0f4fa27e-d9b4-4a23-8c8d-53f4a7014167@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: d2rpnp3_1UM9E1RFIKsIdV30x5ERRJFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA0MyBTYWx0ZWRfX+90tuA0aS5yK
 wLHOuDu9cttE3qzdmf1v75yblZ2qrCsfAC6VJIIkx5sl584OX9epUSMj8upyk7FtM5jejKhCnKA
 kmBkQNb086M/cURSu8M0Zx4rISRiFGiy1yAUuG8POqLwEhR/JAKKbt4X9uSvPai6sIKNp+y4ZA6
 MHILCVYboGQr24MfqlxPzvRZLLYQf6Ct/OGlhrFHaM9hGcTDrhzewF1H17iMks0ziIVdIrooweT
 3iPMcUVE6QglQbCzhh4QlYLz0RUnfeviJUholRDSh4775ATRP6/u/xcy6YRPULsL5R3M2JTQxq/
 6pinuLQpU25P/eHjvsP5bMOaz3NVYj2IzbciPBhePDfePqalRIXV/bMoe+zzPuj/rYb901R5izV
 XpbN/W7UFGJXw2v26Ppp7vBI4aUMotsk/q4VWcQt9e4Zsoog1OuUz+Uy0bsJCqyNx04rzFY6aYq
 aCgvxV7bS3zIV1B6/Ow==
X-Proofpoint-GUID: d2rpnp3_1UM9E1RFIKsIdV30x5ERRJFK
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6969ce36 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jrv7-BdHtB984KKGQBAA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160043

On 1/15/2026 3:47 PM, Qian Zhang wrote:
> 
> 
> On 1/15/2026 12:55 AM, Jeff Johnson wrote:
>> On 1/5/2026 3:51 AM, Qian Zhang wrote:
>>> On 1/5/2026 10:22 AM, Baochen Qiang wrote:
>>>> On 12/30/2025 4:25 PM, Qian Zhang wrote:
>>>> what are these dependencies? They are not present in old revisions.
>>>>
>>>> BTW, if you indeed has dependencies, in addition to these prerequisite-patch-id's, please
>>>> also list them explicitly in the cover letter above.
>>>>
>>>
>>> These dependency details were added by mistake, and I will remove them.
>>
>> Was that the only known problem with the v5 series?
>>
>> My automation flagged a checkpatch issue in the 6/6 patch:
>> WARNING:LINE_SPACING: Missing a blank line after declarations
>>
>> If there are no other issues with v5 then I can fix this in my pending branch.
>> Or you can submit a v6. Just let me know.
>>
>> /jeff
> 
> This feature is under LX test now.
> Patchset V6 will be submitted when testing is finished.
> Fixes for new issues (if any new issue are found) as well
> as all previous reviewer comments will be included in
> the v6 patchset.
> 
> Qian

I already had this in my pending queue and pushed it to ath-next before I saw
your message. So any fixes would need to be separate patches beyond what has
been merged in ath-next.

/jeff

