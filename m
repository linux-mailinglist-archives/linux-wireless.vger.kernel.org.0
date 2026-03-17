Return-Path: <linux-wireless+bounces-33360-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJlsJOXFuWmcNQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33360-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 22:21:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F25142B2998
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 22:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5755E30A10B7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE62342CA7;
	Tue, 17 Mar 2026 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4A9jp91";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRwgM337"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AC32E121
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782393; cv=none; b=VKHSQeiD5bpHVRjnDNGU0sdoKb2oPDJx7K5OEJgkm0Jo12FuLHoVXw3aQXfD6QCI+DXK6g/de/DKHlKr6P/MWSUA4k+UTuk07lCXn8a8b8htthtzRYj9JP29lPhvKCBxOV+fMntTbXqDyHVkZFgJg/SyuCfM6gnbbfSk2/ff960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782393; c=relaxed/simple;
	bh=oJ8yQqeiKOP/lh3EeDfrnyoGpZqcfrZf4uZDwrwhiM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGT/84dlmwsYPzbl8IV5xuRH434GDFoK23s0PepchCVvqTvNsW9t2jOnRl/uavxIua+ixK8Fsl+AkU4Y48igurNPUynlNLuC74IlCKRjzxifcW4v5bN5eV/gPuJFVYAtKY6DrT0tnIbRZoa6pMEDu+L+NsmVOC8n18f6Jr/r53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4A9jp91; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CRwgM337; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJgta1260880
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 21:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SOYCN0tONcfJvluP728bJ+1kuPqknVLKkQyFyIQc07M=; b=U4A9jp91jXJEnARF
	xCpT5KTWmJbVolgd+qrizSi+kJ5qDiVJzVlHKEGnkxmAco3RI4KWwCNOAvZdQ6Ie
	cjyhcAZyXT8naCLLpw61q6p7124mSHr8fqJdPoMxHfAgShfjWbQgO/TZMFZo/jaE
	otu1XjhAVA2zXzlOCKOve4Y21ywKl/xrs1OSNX3GjxXH4bW0agSyTr9zFtFx4OsD
	De0eIfsSdoBo63SgVRRtSgrFtt8czC6XfJChbfHBF5Z6v0PLGYJSKELp+xKmx6j2
	uTpm/3arTwpKuCAIoYSOBozeWGU7sdqZSq6whf2C/77SG0N272ziuhOA73kebwOW
	oth4rA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8j9sw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 21:19:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0cd2e4aa6so10223167eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773782390; x=1774387190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOYCN0tONcfJvluP728bJ+1kuPqknVLKkQyFyIQc07M=;
        b=CRwgM337ebvWafCP+L0dvzOe7DgGWdBTCmogEqI0KquWDRWR2W6xxQ50UsWS7HhCv/
         Q6QivF0yyRDHMPrOMXCOkmukDWSrmRhRPojS3AAIGoKYzV6Eib8+npi9drODOTtyzBlk
         uVuKmLVK7Xu2weyrrNJwooPnTDVh1K16D74za3ksy2jUgU2O6XDoAiaDe4S+D3a1lyEZ
         2UKCZraXD8DOOtVcqYP0vpcgMz04H9cTaKR2dADGs/7kAJz2XSTlhXEULPZ+7WYanpeN
         Eh+PwprshqnshK14mIufZIKsHWeYVixC7F9J5c+J7hNehURKdFbknpCu7eFBr1Ex2In7
         1H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773782390; x=1774387190;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOYCN0tONcfJvluP728bJ+1kuPqknVLKkQyFyIQc07M=;
        b=SGyJAMjryT/KHwAF8QLOpJD2sZNIjOxVFPdW55gGGSABIbjtiyEkArRBUyIjCXW3gE
         hfEgc9vIHrylMGsnKLLpAWWHx66FiEk/kbOaBWFV5BJ2TcVjgh5wZXsRLooR1AVubu5c
         B8SDXCAVST+b2yCUpBKQcBrKommjq/pjxPW5fRFmIZOt0yE+s9ID2RtuNd8J1pM0CBQd
         1uTPjvXLyq3gfpOTYVIuIgP5fmwVa3yMbkeS0wGfC/+gQx7PvLvUeu07wUY041ifwblw
         Nns2YiPm7gnwfdc4I9RY6wyWXdr4WavY+lt75e79m2+dsaswkHVSckzKacCZ62AGV5Gs
         DKNA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8uONBmYBkZ4/TcFb0aaPz1FoouKymmq7IFpxiiC7BXgk2GZnJawb5Bt3A5EHFACxotuTnrCRgp+k+v+qIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJmBCBxYf5cMRQ+ob1D7dnY2auLy+isBWdxRlLmDusKDxfSEb
	3m/YfbC7letC2CSSEVAakuf6KXatAQEIZ7r7pYCg0vT6Y+tkDPikRMUqsQ3O2CxyB4+UsIR2daQ
	xfCevjlrVMl7r/3TH6KyPuUVaEm3SDcTyzw0w1jcie4IzfJnoe+wZ64IU0JX/nchHAXxkH8xgDw
	LKmA==
X-Gm-Gg: ATEYQzxZc/1Dy2jXHIixIl8A46AMmdeoCj9Q1p0aKEqyuhF6ij/zv7XG9Ru8iMmD/Lz
	aGXXEyL0Sm2RfoWvCJwB+5nzUdi54LNIbFK90UM0zepIdWveA2am75Bj6mZJTDoEswaUBc0wFNO
	dh2YQEWBpyk+elZ+oP+kEi+4cb3lIl5wgG5XeiuikSoTn0GH2xUQ4aTBN1+Xgu3SfddmfZPnjto
	JbptH2eG9iaHF3gi5mhJ9dynpEmQ+wB20vtgJGnci09UUfGthb02vLPQAlcGAiIsc5jFhAuVBgB
	opZ3nqADbiRso12GoIQg+fQKi/mfOZ/A0/T1+0miGLX/Qf2kX8D0WolVRpol/PfYA5MeOHjrMtP
	LTxXwsvpa/N2chjTRQ498oToZPYhifHv5uJmoRO9ob+4niSAUZWdut3SsUDW3yAkMQFkRrlyd+q
	sMrJ6znRhPAVFGpw==
X-Received: by 2002:a05:7300:fb97:b0:2be:9886:d4cc with SMTP id 5a478bee46e88-2c0e4feaf75mr548371eec.3.1773782390467;
        Tue, 17 Mar 2026 14:19:50 -0700 (PDT)
X-Received: by 2002:a05:7300:fb97:b0:2be:9886:d4cc with SMTP id 5a478bee46e88-2c0e4feaf75mr548358eec.3.1773782389960;
        Tue, 17 Mar 2026 14:19:49 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e56062e4sm970898eec.30.2026.03.17.14.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 14:19:49 -0700 (PDT)
Message-ID: <e22e4dc4-a98a-417c-9b18-8836ec56ff56@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 14:19:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260317
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <3ff94227-db20-429b-9872-75faf39daec2@oss.qualcomm.com>
 <sxyottdaf2tu7swtvs46cziq4s7vraebrgclia3i625lnczf3x@bo7ssgih5mjk>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <sxyottdaf2tu7swtvs46cziq4s7vraebrgclia3i625lnczf3x@bo7ssgih5mjk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vJVNSYlKmBLwgaEicN8yN8iK04YdtUnS
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69b9c577 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=Lpt2Xbyv4YudqlJ1IEcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: vJVNSYlKmBLwgaEicN8yN8iK04YdtUnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE4NyBTYWx0ZWRfX80ja2VP3+0Ik
 fegqJ+sT+myDgmH7TKQ9W/FV5NyctwUiUiI/uxENY7CSlyH+eFonHlNaRReZmZ3P9vskCKyFcch
 kmxN9FxKQRJCYL8Tq0FwcJFd4uW+ePpkB0zShx1wFFHoLcuiZ1IWqvAVB/bn2DLynMHO+kf7euS
 9eHVyYM0Rekab0lXw3TShudNUHbLTZpFXp1rzkApaxfDPBzvFNNWIssJ7dDnVHN8MgmJ2SQFmO8
 rhd/qm/aFgAiwe4KlDT6Ef4TirUSOIhx59dYirOaOH4Q5ji8FGFsegXg/iQgNxk+Vh/gMosJyZ2
 p3/fJuf1Ch68Wn9lrpsVooBl9BdWffrkcgF6F6teir3n9uIeg3BjyjU2MviekUnOzKFrybiyLxk
 dlRv0ZiU4aHT4j1aqdjumEHWWdicLlsHvmV6ZFSmGcAildPjHZxwqj0/+u/z2XwMkJdHhZwx78T
 wW3Wo4FJ2+ZTlrj9KWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170187
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33360-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F25142B2998
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/2026 1:58 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 17, 2026 at 01:18:59PM -0700, Jeff Johnson wrote:
>> The following changes since commit 81f761d1b5fd51469d87d1633a959dbff4785f58:
>>
>>   Merge branch 'mt792x-bt' into 'main' (2026-03-17 17:33:37 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260317
>>
>> for you to fetch changes up to 6fb33265936075ee1bb5a31786a4fe1b30fdd001:
>>
>>   ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3 (2026-03-17 13:07:48 -0700)
>>
>> ----------------------------------------------------------------
>> Hi,
>> Here's a new pull request for ath10k, ath11k and ath12k.
>>
>> No updates for ath10k or ath11k
>>
>> For ath12k:
>> Update WCN7850 firmware a new unified firmware supporting Mobile, IoT,
>> and Automotive.
> 
> Thanks, updated and pushed out.
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/962
> 
> In future, could you please include similar information into the commit
> message too?

ACK

