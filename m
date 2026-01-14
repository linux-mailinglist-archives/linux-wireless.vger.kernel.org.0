Return-Path: <linux-wireless+bounces-30825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF31D20594
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 17:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FDE730024C5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810193A4AD3;
	Wed, 14 Jan 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PnTbokQL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A6/U+mCj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C73A4F2E
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409719; cv=none; b=EfiRHEucNYg5AV4IfL+y+nPuFWR2mTnc5HU6ywUxUXxO+BYdqfDLuEGOJHJlgeGxERe+nkUjIdZl5lXZ4VkKdUhnE5Q4POYe/VsmN/wmLLOwfrThhzbGOJC+O2alZL8myeMJhah27/pJkw870xsxMLxFHBTrw61LOxiM2rh3KY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409719; c=relaxed/simple;
	bh=ofRj3J/8GrZNHCcN9p/wSfw4MM76t6mZjsGTzvo3WWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvFIG+acib/hGpCG4wMcPfnl7DnM9BJA9Se8llqOHh79HQKUW84ZxZRteVo08KqPqGqGY812cs3EXFzdx658yz6y+yWCIkKoqfTQFSAl/5YnBc9wNEMFUlOW/Zzk7HZ4YeWeHjL4WKoBuLsbdzqmyDSTsRwHjpUknblYlVyMUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PnTbokQL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A6/U+mCj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EChXI93925489
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 16:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r7vEmRLElt6V1C5YVL+pvrB1XgE2fASQ2T+9V1RoiNk=; b=PnTbokQLttZcTYSd
	UmL/tKfspJzRl710nhcoucam/bYB59yopFNQE45yn+RHwg+smQiImyoN1VF+MmLc
	HmMXzHndzAKYGnj/HyQiu/clolpu0ZUPoGHKd6uvVTtZf61+P/jiQtxL6+U86ElR
	F2Mo/1rY3sCeiRW1sCfbv9MoPCKCYWXDmOCCa1u7behGuKWRUPU9wD8n9lh4eYwR
	Vbe956iTORFgjjZnep2qFbqmbOiVABeLrfoPW0OEyOzHq+5d5xhu8QZXUFruow1B
	E9O/q97CQIkb7nyykqohjJ45t0tKGQbznNNbJBKPJ+jaMIOMszy7cfz1EMH4Ujvm
	j9KP+w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpbdbruvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 16:55:16 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-11b94abc09dso11966041c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 08:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768409716; x=1769014516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7vEmRLElt6V1C5YVL+pvrB1XgE2fASQ2T+9V1RoiNk=;
        b=A6/U+mCj0dopOPgRA4La9g7PfI2PIIEnjEwDt2fAwfgU+ICRGXB2ZcsO23lxLQFYhx
         s8qe239dTpwj5n05Xwbgp/jXh+9KZlbOj5pe+yhziD9MZz8VYAUE9wd1+NycwrjCXs5j
         /PPjQ8bF8vV7ncem74oaxXyniY8fPN711oNMqwzJVK+u+1nGx3U3SyGFTZO90Dn+ZoCI
         vDw+eX4TRCTPUtSKuIbt2AJxc4NtotB7ZUG9NbgxzJApJDbwHzj1yDLu5WlATgDcKR2g
         AGNDi70UAr+F90IMzy5Fe4PpdqeYmoQqXRv+iGCO+TWwjBXbGOhtFEc/oCNoiEQ6g3dJ
         o41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409716; x=1769014516;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7vEmRLElt6V1C5YVL+pvrB1XgE2fASQ2T+9V1RoiNk=;
        b=VBW905/7kyv6Lyw3EJSHD50Bsjr7kYb883dOuiZ/t9x30N9OcaS1BrN669TjEW59lJ
         om6GAdDRa/6Z7q6SC4wxp1p2U3N8Bb1h3RVhx5jg2FFQkHthxpguohZDzNeGcSILiIY4
         yDo56oZrmLQvff6rJ23PFoTQ5BnPOQ4KylRlnzCOdGGY7KIUnHvuMsQ9XrHaR6jwoYfV
         OkuqThS1gXJRjtTglVYhqWFwisg1nT+MRcFUy+Xd5PRMidDVV5I00YKv1+F8l3HPPwcr
         z1fTUZmzHKbvrcBTM3kcHOxoIrWD3jwhMy5jduq4VqYPexHu0rRnGwfcRN/GEy+VBssh
         3OlA==
X-Gm-Message-State: AOJu0YzK6rmhILPrN7IbE/OeaMSrrto8s3Ao1glcqEUbfJcuK3EC6vt2
	okw8GJpTvK/MiQ62n+zlsYKpy1oINiXt044+4R+oo16PNin7x/ortDoUy4OkEnsZkS5/bBmUHul
	sqGG1cffHHqsC8QhFIRyUbtiM2Tp2KcGjd0EDMRllODigkzZBx5u+q9R04ryhR4HpfsIg0A==
X-Gm-Gg: AY/fxX7rEnucFU/FDDD+o4jkXuvgUPKHP7tC3XbvbQSAf86Z4mDT5nRYSKDD0oWsGqT
	lGToFWYK+agDwdG/H7Mwi7yFTJsFYTMc/LdfaPfBQ03QgigTTBBqEo2oDaSDRShdWmcNl07nVy5
	lE0x0GdeAPyP0J1OK7TC1DcEspIGlbkcnv9k8klQj4+Jzjg6qxPwkr2wU83B7X5fXX2tnfMDmjq
	zBTCie0YcnY3iTLy6kNlvkaHgIzzTWs2+sjfqQv++FktrjygVVSWBS180itOwu+LRVRDoTRlMXN
	JbnF9B8LpfXG7/BlPPUg9NONYYawrNdML2vvHIKEraAUXSFr/fpnZm1BR5rjuUhX89lG64VMs+N
	sBkvwQVQBpo4+pbpfC6vChrelvCNBXBJusTcT/U83foh6twg9heIJ77bUPQ6PRo+ppc6dHw==
X-Received: by 2002:a05:7022:458f:b0:11b:78e6:8323 with SMTP id a92af1059eb24-123377561f6mr3636469c88.37.1768409715827;
        Wed, 14 Jan 2026 08:55:15 -0800 (PST)
X-Received: by 2002:a05:7022:458f:b0:11b:78e6:8323 with SMTP id a92af1059eb24-123377561f6mr3636418c88.37.1768409715016;
        Wed, 14 Jan 2026 08:55:15 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24984a3sm31963299c88.13.2026.01.14.08.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 08:55:14 -0800 (PST)
Message-ID: <f0e98751-8fed-4cb8-9cc6-59a691f172b5@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 08:55:13 -0800
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
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a7a73ad1-0761-4abc-acc9-fc94a4e77348@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NvncssdJ c=1 sm=1 tr=0 ts=6967ca75 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6sVShl-GBsVrLMKkQ7sA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: HhZ9OOyK2RiEuoPYpzlotNLeiVLkrKtq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE0MSBTYWx0ZWRfX2BecRg3PHDig
 /+67Hjdo9yNVAGykFHaRwglGEpILbLH6B8na4uuWYeTgDTxExL1w/4PVszTEDW6Bp68XcRN2uhe
 hPn2TGSe0IwAxS+uiBuFuZmMUaIjzeTw8RnZKPEqSuUzxrbf9SmbxprxFQBW24eCTEzfNH48kAg
 U1MfkxH7kDwrxRxfRD4p5re+2BzVOvJAruQfJj5zgP0cGN/rBA9WQd6h19s2elPs0WF1BHcHVKS
 YixvkQj4o/tNeHsekN4nAFCMSmvMWt3jY9DWF9IUYDBgeQF1Zveq2LcewyAbYQ2JmBwnjJofIiB
 Fv99dzHughTCGc6dJBT1HDLwXo3kjRGt48IPlDEX50m1wUircmCsNNR4gq4v+EkJ+KO+zspEa4F
 6m0yD21kbg245SbMq7iyh00Al/iLYm5DumYVnDRPJRJz2M67dK59IjHBNbIY4XWTMh7TxEF4MtN
 pNaPzOagIqwHmLLU7oQ==
X-Proofpoint-GUID: HhZ9OOyK2RiEuoPYpzlotNLeiVLkrKtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140141

On 1/5/2026 3:51 AM, Qian Zhang wrote:
> On 1/5/2026 10:22 AM, Baochen Qiang wrote:
>> On 12/30/2025 4:25 PM, Qian Zhang wrote:
>> what are these dependencies? They are not present in old revisions.
>>
>> BTW, if you indeed has dependencies, in addition to these prerequisite-patch-id's, please
>> also list them explicitly in the cover letter above.
>>
> 
> These dependency details were added by mistake, and I will remove them.

Was that the only known problem with the v5 series?

My automation flagged a checkpatch issue in the 6/6 patch:
WARNING:LINE_SPACING: Missing a blank line after declarations

If there are no other issues with v5 then I can fix this in my pending branch.
Or you can submit a v6. Just let me know.

/jeff

