Return-Path: <linux-wireless+bounces-34493-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMQnBNiB1Wlr7AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34493-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 00:14:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 131253B5464
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 00:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D53EC3002D09
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25C37F741;
	Tue,  7 Apr 2026 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OweH0Y2k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Towwi8qC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F0137EFF1
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775600076; cv=none; b=mlVeDT5oB2y+PB3cMrtdtQV6ViZDNw0ixsv4pxwIuyG+yqEcaERBflMlHSyIehqgSrrbhaBAmvsrg+3eQxaTNbLApR+MajOp0r6E4+3gk6llyNpEJm0EBxwaCAktu3aLvZPyBDjoWUM/BUA/+1gB5OCMYiezxgvAZEbvKBv0bKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775600076; c=relaxed/simple;
	bh=O70zG8/vQ7/2/njiFcnoP01VaZrKBSDy6k7ous7SiZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIP4UNER2jruUGsoBORvwBHXRvScuh9XfgxQ8CWfI2sN49wHP3YpxQpTGY2pLgRGzmnNgX/A6zfn4+JdHaIsff2QJ59BqexzGMxI8QiPEShb2wwQFavNtdCaCtc3YrZWyZcHWx9gSmhnq+RdSjKb4/Cb2watK8nXPBnsYYQcST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OweH0Y2k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Towwi8qC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637K7N0B2009220
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 22:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=; b=OweH0Y2kARoYn1W1
	qq3nLdCQrnMusgkFKVH97SH/YIOnMEsAfAZK2KoiG9Gxh/8/n7cU1UsGD3/JY+O+
	TnCC6+QeX8Z0IUKHaUmjTIypZ2H0UfYbyJVOT7JUEat6dMR7LzZBxjoLQJyQmwOz
	hXC6WmTAPgKiCEnt8sayLvxEaf1aQEZ3KVbNm3zDkVgkpsYAgEMpiGSFzicXC+GT
	zLbUcVWQXj925Bce1NoFoyGvgQBlVpoEnadvPpUlxJC/tmR4UarU4h86gc0j8iqn
	9zGvFPUfebfRPl8K/kWd8XSw9wadeBrURZDqQNVSPOk9jaO1/Rspujy1bXSio4MO
	UaKy3Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrvr98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 22:14:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso7903253eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775600066; x=1776204866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=;
        b=Towwi8qCgZfYUflNkOb/McOoIKWL4FXtnHS+61NfoX++L3aMY7rz/hE198FCH4bEr7
         lTERDD6vyUau5niV1ACETaGLJLCGKM8CtQ0iiSxhmTxj+2HO2sINAgOq0BoMpBk9P1YU
         W9md2wZDgOfa20KbSwBg+UV8n0wd523R2GHFLceuS34njkbSagCzY+oSqRTutlOBHC6Z
         e6Q135NmJUVeVXysLPa9h+mTLE1K4lGnxU8vGE6WgQf84h93PCfXW7qpQB3FDz88YPWz
         6xhTGOk4ctF9wQjZs54SKwXMl75pDrM3hj5xPU33fZycNyzpm+gsA1bz8/8rTSIX/0Ll
         hLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775600066; x=1776204866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=;
        b=k5ukd7O2i2ZzjV7VLGqpnPv+pvSCp2jZJ6IUT4GGzQD+VCOIq+bDvtE+GS6DaihmFT
         H4YUk20vo0WQcqkwSHcl3tAJQh6Jf2v5AV/Y1ffmS2EYuYaoku1Jng4+FB73wLVkkLVj
         Jkf2Zwctet+HPWvYW+TvsbY6Mx2HiJGUCKF6dNsk5MPDTYAp77RV7QOmPsD3ALPb+Ta7
         2yG96kLegGrIn96sS7gNAH7CsUyxtWMNAgWSxeRgfdD4rJWKu1mjuJGTAZH9F2yYFk8/
         y58FkM2DoJL0GDV4WRoXUHOGrTwXBGcJXy5G/nGqSuw/rrT4h+KyLujWH8kVMHio5Zjg
         sXYg==
X-Forwarded-Encrypted: i=1; AJvYcCX0xbGxjBcmNJc9z0GcQB78TLDpyU5Hk5Qj90F8yEu0OvYe7lDOOomu0OaDWtLgAHzAkoTQWqlwSS3zxab/qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHIQrSvlvXQVVZ4oKRS96GWntoLPKOUocKCFb8ab/I1z06XoY
	QlrwEhUpz8qwwjhabUGyBVvLO1t+dQnR6op4Ve8mG1FEZikjC7n75TPa08ep/i4sS4mIKX30bL+
	DHxkFk+zb67J0jyTVpDc6zOz3X8GsKN84rUc3ExkZ779nBlPSiaJfeJ+A1jWfPJ5fHIXo2A==
X-Gm-Gg: AeBDiev4vBU8JuNkEkZHzg77GwMmpxLLvjh1x13E160Y91gmJfIbjZm72zcoXUEYpQL
	DZbSSWrio/vFQ5UMHeoivewVcWPmLLoNxO3JhQJG+0QccvPRyJie+PapLZzkKZcmNM0T3QXSfLz
	EnxsfdzDtKzzi5YEL8ZL79IH9hgeds3N2p3l9+EtmYkgdSQCsVeLZPYMV6BUttdTYy+YUJiIzUD
	Paj76nGjjfDrmTeTGVw1RBcnC6m4RmmU1Rxj8KRHD3TUkt7gVNIQ2f3Kcw3P1BtNvdr5jLOPaZ3
	sRUBQiUtstzqEowlGY0otiULY/JCZLReS/avlw6uPHO94kazyyaI5N6HxuzppN82BVFgUyBqKwb
	hvfHbqk+6BNDnImaqYxclgwsV7NHXXaFihpdioolxU/uDfHz5VnPLY/Y7OZiVbXociY2f2b+gBM
	nG9mD6
X-Received: by 2002:a05:7300:880a:b0:2ce:f3d7:20c with SMTP id 5a478bee46e88-2cef3d70bd3mr4324851eec.29.1775600065598;
        Tue, 07 Apr 2026 15:14:25 -0700 (PDT)
X-Received: by 2002:a05:7300:880a:b0:2ce:f3d7:20c with SMTP id 5a478bee46e88-2cef3d70bd3mr4324829eec.29.1775600065017;
        Tue, 07 Apr 2026 15:14:25 -0700 (PDT)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cf2be19f85sm12178552eec.30.2026.04.07.15.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 15:14:24 -0700 (PDT)
Message-ID: <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:14:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>,
        Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        vikash.garodia@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org> <ac-KQ7e8-syph1Zl@trex>
 <adOcMsk8a_Clb4WZ@sumit-xelite>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <adOcMsk8a_Clb4WZ@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwMyBTYWx0ZWRfX6sP3RKkR36ft
 Aw4zLoVPfn8kqh39A4c4FeZx43mLjB4Exp37s27HTLd0emsesh9Qw7DwubEAQcGSEMRT8EYAJ8Y
 TzPUpv1zXBL1i1hvc9gKzeD94d4X6tdvuP0+DIImcF+vEHm8II3jTXK/julRlXVN3Kf15Tqb5tk
 3dsk+TT7i+usQGlOTAUOTtIDIhz3YSXQcBvZR2Zm9dlCOt/L9AirIG/CUjF29oVV8nlFuwXl7UA
 ysfZDKjBQXZ5V+WR++XS6xjMoKeLNDK0aiGaZY3CIGMPKoVZTZ1G1CxFjUPOi2/zxQZp8WYXRrT
 uKNogndKGeVmxGGOW7p3nJom7TQFMkVT5pmGcSaycYhQQcvdazjTPmJ+2G7ILhdcrvKVAbjNzf7
 cB8ddtjduTsgbk+dSjLxhVyaWPooyyZ1pNweD8M/89SzB4XuXVqmHIYQJklRgd2drR/RCEAt61+
 CP38jPq9A9EEiy6mlfQ==
X-Proofpoint-GUID: zagOLQASerRdUBzl-1x22de3dCOW0iAZ
X-Proofpoint-ORIG-GUID: zagOLQASerRdUBzl-1x22de3dCOW0iAZ
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d581c9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=nRfXl0x10UYwF-qtBXkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070203
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-34493-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilokkumar.soni@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 131253B5464
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/2026 4:42 AM, Sumit Garg wrote:
> Hi Jorge,
> 
> On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
>> On 27/03/26 18:40:39, Sumit Garg wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
>>> TZ service allows to support multiple TZ implementation backends like QTEE
>>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
>>> backend service.
>>
>> OP-TEE based PAS service relies on the linux driver to configure the
>> iommu (just as it is done on the no_tz case). This generic patch does
>> not cover that requirement.
> 
> That's exactly the reason why the kodiak EL2 dtso disables venus by
> default in patch #1 due to missing IOMMU configuration.
> 
>>
>> Because of that, it is probably better if the commit message doesnt
>> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
>> implement the same restrictions that QTEE (ie, iommu configuration).
> 
> The scope for this patch is to just adopt the generic PAS layer without
> affecting the client functionality.
> 
>>
>> I can send an RFC for OP-TEE support based on the integration work being
>> carried out here [1]
> 
> @Vikash may know better details about support for IOMMU configuration
> for venus since it's a generic functionality missing when Linux runs in
> EL2 whether it's with QTEE or OP-TEE.
> 
> However, feel free to propose your work to initiate discussions again.

Vikas and team depends on some of the IOMMU patches to get accepted 
before they enable the EL2 venus support. Please reach out to him
and Prakash Gupta at Qualcomm. 

> 
>>
>> [1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507
> 
> -Sumit


