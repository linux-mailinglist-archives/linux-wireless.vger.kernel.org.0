Return-Path: <linux-wireless+bounces-32654-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPq7Glozq2n2agEAu9opvQ
	(envelope-from <linux-wireless+bounces-32654-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:04:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E722761F
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA7503103F97
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7872F0C79;
	Fri,  6 Mar 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iolXTHdg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPvRpmXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F530C631
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827240; cv=none; b=UBzGwU0nc0kMQFwGW4KBAZha4s14vaCls1C5avCK+BTdtEznlug/cg1B2K9zGFkqp7BBQHT10/3W3xed+cvIZzvM/Gb8xzUpklyQigTSQ0J/h8hEsvdnGbVO3+sloF+h1g+wXLPzWAiceSebaki9L2DHSod4ofL5iuc7ntC2PXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827240; c=relaxed/simple;
	bh=pbGgSdTnpxkY+2PiBhxk8UbO864vHB/UN+E1PY8xpl0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HCPNhYXw/n0OT/0Q+HJ85J5y5nNvmyD5KW/xGtKYJh2bSrizablQwozpiVkT7BlBgg/HVcenaK5QPR9gPE0r6HMVbKPd60OfcISk9JEi8df7Z/J4Cpcp0147r9gAX+2K7H1gw76xXhpytROHyh2UTMQXj41GThUeJ0jJ8aJSml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iolXTHdg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPvRpmXT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626H1YcV232493
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 20:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EiYJflmZS+8yawIrFdYuvTAy2GFP2luKLW8xrlAeVbY=; b=iolXTHdgTdjfeOyD
	ZD1CaIv9BfKoTip56GVafVAI2pWYzNyMQHZIxdjSM97kmc9JYu7asDOGkKqXqzrG
	D7A6EGYVAir86BPd0Fn5Q7raSMDJWV6EdF1O3A4hsajmSp3swGeGIcffEwCsft2n
	6APlbK6ZVqMBM6cG+C7pk5Kyz9Fnh30veQDKzcgTG1qjkwGPUVXTxVRF9i+aiQDC
	5JqWWkql44Xvn6k9P7HX6IFX1mIcJWe549u1vpndfMKiUifO7bDmCekNyqgD56xS
	T/BL//RE4mKtCpeGpFZaumI8aENVJTpmUafJihIs4uiLWyozER6TEuIr1RntP5wd
	ADUk7w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqgp4484x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 20:00:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2be21f89332so4665718eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 12:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772827237; x=1773432037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EiYJflmZS+8yawIrFdYuvTAy2GFP2luKLW8xrlAeVbY=;
        b=TPvRpmXT6u2Ln6qZQ2ek8YAHuhH1JyGs0Avcw46eKxR3NrsNanP6p/0Ar+LNZ6Lzum
         qrE5JuRAzaIjkmXU/YmGoMC/h2UJ9jSaUXFOLursC0qv6T7Wg6Yme2zGxLRVbuv1gfiA
         1afhCBbgUZBFamPN0N45C1vraSP2PCYNYxJs0J/wvbaj+vfJpLOSxgnFfVUMpzMWkw3S
         oqYbDnFcBSBEB3ikNBiFHJpahOZFPbzBMzOso7NbJLil/OPsqk1BjYl+2GlYI7FOQpm3
         LhqpOrBEdDCaejP+4O2IXnGCRdFO9a58XyUF1I/9XFuM2VjK0taXutu2d7MfyJernxqY
         Tj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827237; x=1773432037;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiYJflmZS+8yawIrFdYuvTAy2GFP2luKLW8xrlAeVbY=;
        b=gTxrjdnPTYDqwjQZ2T5CvGP7AZFqA9TnmTUfkeB2SzdInRCTO0NMJEd2fLI68VfYkR
         NMyVXu0DvBRdugruCy1f0JI+I994IY5jN1LGbm+yczBE3DA7y2/6/4/HAT2ld2CyEJiJ
         2iaUzdeqrJceT4H/iWlAEwrzyyGygxUOTGwkJ638WnSzvhr2dSy5oajKpiWDz+jLe8L9
         COQPL+/ZFbxlJZQ/TA+PUCVvZ3A3GdKVw29vCIrhyzRJ6yo2App9OfWg+aWq4OW0u711
         q/+455qd09kS3/+svn62KjnHP/6I5STLCH+AznA7Fqwp1dQQCzcDTcztM42+I6yRbW50
         h/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXRkoqzlDX3t94POF0yXBV3j5sRVJQBUVBtuo1Ie4rnOrREBS7IGpSos1ALYxN+PxduHsWvj6UCQcnP2Msqog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93KzWGBXU4riU9Lu6z3Dw8FIH6X/VXXClMneANIx4nDzAl+mo
	o/8Dj4P0ykHw0gfubo2Wg+Z4MHYg4DG6F9NV1Wej5MOA0a2qMvJSgIQkLcNDKwGJk02cl1VW7uP
	Q9VFb8xVY0eFKygfYBOoEidXgc850RoDRKY30Avr4mOhLF/ecHI0Dp+a/CYdY3zID9sVsRg==
X-Gm-Gg: ATEYQzzUfUvCLZGkFW40wmdYkgpPZSdY4ISLxEWFCZpb0o0c9wEWoheDmeAKdzx1eP2
	C6rwSGMvcvudtO32CZGm0kH3g1D+fDfWMRycZ/l4RYhLYTcwVKE1uSKi6a4Svnqik3Amit7OVii
	Itv5/IlLszA93UAhEJkifbmoarz6ZlXu+gnTgNm/vOTNqQfHoOW6hnT49Jdz7703QWFN40P7Qds
	gG+8f+RIGMD1+f5bZVz24MdFw8wyrQebzA47uhVif2gYvexZ8YIvTVQg+NMyx+0cQBFJMBXiVVi
	M34kYv3gPxOUaa1fO+aMuStSwdUWCNxuGzVn9+M1EihKbghEAhK4jBa4QiYzuRtzl7pe69sbeua
	1Rqiv9Xp3utKEq2tO0edB9FoRcfqZMUMqusI2j1WP87d/vubQBP0QrEc=
X-Received: by 2002:a05:7300:a887:b0:2ba:7069:686c with SMTP id 5a478bee46e88-2be4e01911emr1342902eec.17.1772827235519;
        Fri, 06 Mar 2026 12:00:35 -0800 (PST)
X-Received: by 2002:a05:7300:a887:b0:2ba:7069:686c with SMTP id 5a478bee46e88-2be4e01911emr1342841eec.17.1772827234438;
        Fri, 06 Mar 2026 12:00:34 -0800 (PST)
Received: from [192.168.86.165] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96aa3fsm1798784eec.24.2026.03.06.12.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:00:33 -0800 (PST)
Message-ID: <973acaab-f2fa-4e2a-81ea-9d7fbebd1ca4@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 12:00:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TqOBC6ko_0joBNT9YmwslBzRUfQTd8EF
X-Authority-Analysis: v=2.4 cv=LegxKzfi c=1 sm=1 tr=0 ts=69ab3266 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Dui5BcQmNnZPeg-S7-oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE4OSBTYWx0ZWRfX518hft2oTB0P
 DJqxcb/IA5zT8BY/jSODY0aaQLeBsO6gxVxQ2eYpOGA9KA9jNOA4a5FOOHaeg3hilA7sh/yLYYk
 OU77E64ObuoUB9XFn8EwP3uv0KQZRFxIZMgOo0ZvHMtu2QrMpNMSjPImbmwI0q/ygToNiAJijA2
 Hg51320r7DYhnXNSSVmXJ2F6iYoL/VTPBOb8YMnt9D0BhVPng6Im4prwve+sZ2WaDBr5QSZaviC
 EUCJK2I0kuvUvCNIGCeIDwzlbItLxipGB/6X1j96qMH4tk4RtSrcETo2L4WZRllQ4q7qWhppFB6
 NV1EvX7SNxT4ofaaV1FNxw2pYPG48elZS53hrQhTbZ4T+VYFVo3pAkJIGzKVFrcev7UIJOUt93K
 bybMaaXAamL0GIa8aYPKHwa32qhT6Zxl0fRFKq5QtOJd/IcpDtN2LhedvR1OlnJNnyBVIg9E3ae
 V4o4dLaxH6CYYowe2VQ==
X-Proofpoint-GUID: TqOBC6ko_0joBNT9YmwslBzRUfQTd8EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060189
X-Rspamd-Queue-Id: D87E722761F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-32654-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilokkumar.soni@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 11:47 AM, Trilok Soni wrote:
>> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
>> new file mode 100644
>> index 000000000000..dc04ff1b6be0
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_pas.c
>> @@ -0,0 +1,295 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/device/devres.h>
>> +#include <linux/firmware/qcom/qcom_pas.h>
>> +#include <linux/of.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
> are you sure you are using functionalities from these header files?
> 
> I couldn't find slab.h usage quickly and also qcom_scm.h. Can you please confirm?


I scrolled this patch too fast. I can see slab.h usage, but not sure about qcom_scm.h. 

