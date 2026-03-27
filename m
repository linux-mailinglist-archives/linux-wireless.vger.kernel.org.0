Return-Path: <linux-wireless+bounces-34062-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKIgC6x0xmlFKgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34062-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:14:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A13440AD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7A330F3028
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8563932F2;
	Fri, 27 Mar 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Up21IAxv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fvUxO/VQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF63939C1
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613443; cv=none; b=PcifBVNURPJui48ENsnH4d6msuPQItRypiUCEqnTAxwmzx6TVIbFQLtMqBk2l2ngtg6m8p9eXjWUu807Gntox57rPszNekp0q/Gn93UBvJN991I7+/iosuB8HWXCR0ITy4HspwFHbnjahlHmkiXGXdO4/X9HeVBxWrSOE3PBfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613443; c=relaxed/simple;
	bh=7RB9EZqPtA0omj+QCweCs4rq3RGq8GMapB5Xh18U0eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqUaRP8N0LGcWr8fdLIsdRK0bAB41VK4ywyYjCQUexYNzRmB6n3ugj1wmzSSSMEPsMwo4dzDO1o5+bccOnHQcQGHHkM3+tD+hFG73li29N/hGASNZZi2hxC1oLovM1J18iyl/RCnb8xOTmt/tgnNc3nRjhMPNT3ayNH5kDVsXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Up21IAxv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fvUxO/VQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6w87n3132258
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=; b=Up21IAxvjvhnBku5
	1WEMR0plcKU/8LVRwfLOzTqQcWm/3I+FpNYWTAfJE0dN62SjCAwOLiTXkpyOBmi1
	F03PkTNDHh3WcdrldG8ULdMLmcQ/Oc1kjap8+L8KgAcO8jdGI2IPNhmq6/HEfpLN
	Hx1h95vFsrzsa8PP4bVyXCHqy6IdyUtoYOcjZ9fVYdltJ9tbzr/xQ7sFTf2LHYD/
	4rqENwzKnPuPHAvJD0+JtODzjxU2VRtX1Vdi6PlvOy8X1W+bHnHXA+pCGN1JHGBI
	j58bnigDIr+KkVbhN90OmOsKB0BKxod3uqxB7+n9v3z69FMEDlvgerGGDdh7lqqG
	2Kv71w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59s43cwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 12:10:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358f058973fso2910168a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774613431; x=1775218231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=;
        b=fvUxO/VQvvL/PziZXF+Qs2ai1RD5lOKeDkatgXIzIftSVeQ2vdNNI+soJmTBj2bihq
         DeHHtrDWbfYNIsDl8wHYewXXSZVPvZNpH2pJI8nHh3oPlMeftrguCOzmKsEhBZ7BDKUI
         irLB3Zn5onIMXrQKK/cvScZIApgrL8GDWxt5cyodXEfhbaJDJK/t+E9Le2VBP9s++cE1
         mzxK6Yrsjiob9nVhbCT+z6s6OyyByvQtIvMLFBOr4JYBjaQ3hIPiI+O4N7M+1zeEd1Id
         VG2EA94hQKdyyuVhnP1iXhUc9BCI8/l1RJ3kr7mvzev7FVx7+cl3ThDwWqR7sh/jWLms
         ErGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613431; x=1775218231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=;
        b=I97kVKoajiKTVMBHsexaUxEDO7Z/HHi2Rye0VhNYxcQMuGQDJP2vIkG2Bi6gxfQnRo
         lURnn8odIfgfm2dvf29u/vLoUcd4dJRxJJgSa2diOGJXuFwueWofvIQg385so0J7nhN0
         oTB4AwRWbu30tVSOyHBFPBxlB79GHgfOcVaXs1j16aPFaKKdRqTdlaRA/yLeDLqcEXJY
         lcDm6LBJ3UGzrJIknnxdqxAHadG/yQvJK2eVszdkuV382aAn19qIatsLzZ9WOqQPzVKP
         ylQNeRhCUtQC08QBbP6p0i5iKtZz+SrjmNMue+cN85fNIv0umu99sqJTwIrrjE/orPXu
         Lqgw==
X-Forwarded-Encrypted: i=1; AJvYcCXMBG3CBJaezeNXvGS+FZILuC12/I0AQzPEA7ObgPKfQRZYeZWjzp9XSi2vmJtUyEtmJdDEg/QB3I8ymvzhaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwEWM1z9lwydMViINSYTIwbrjwnEWI8fcrVreL2XupLJ222by
	cjEsTJ6ehrx1Y7mCwBOQR24frP1Xg8gO5+sB+tEyGgHrKFh8qSt13AialzhdJmMfLVSm+wRagEZ
	QpZy/4yEUjH3gNsW8q+d5gNUMJFkdCiGbsy9bO59nuGPZTXhnz3OAHyqaItUAMvSF+38GWQ==
X-Gm-Gg: ATEYQzyoUDYQ2E5iBaq7mi4GOa6RFqFm4iJu6QKBH3+Me1zbFZj+4fa3qFryN2spAlU
	pfWt1+2oZQOlUQl/pR0dvUA9SBQX7r2loJh8UIgcv1iuZwtaveo2JO+lhsK3nj9fySMfXlmqLm7
	Q2j6OKTFVEaetAQ7VcnX76LGuFQvX2Z1Sh5Nh6Q/U6YmBX0LEAq3Wdly660eBHWLb/OPXVi0bpT
	FoE6ZrvG8eFgpx+BTLXgEey8CYUiFrn4/NOnKz62oJVu8GmD+aI89qPyHLQkKi9IIxzlkDPs2Fw
	K0BdTb3hCHFNucKxRwBHSgBFyyMjV5MeSNcXd5AA5DTqCfrfnqSDWLUw1Ta6Ner2lituM3q/5dF
	qs7Enjd/dwdZDJQZBNlVpUZZgW5ShsTKFwhes+Jr25hxEXDG6EAE=
X-Received: by 2002:a17:90b:1e51:b0:35b:e51a:85af with SMTP id 98e67ed59e1d1-35c2fff2c76mr2299334a91.10.1774613430858;
        Fri, 27 Mar 2026 05:10:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1e51:b0:35b:e51a:85af with SMTP id 98e67ed59e1d1-35c2fff2c76mr2299260a91.10.1774613430257;
        Fri, 27 Mar 2026 05:10:30 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a81757sm6204402a91.6.2026.03.27.05.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 05:10:29 -0700 (PDT)
Message-ID: <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 17:40:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
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
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-4-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260312062756.694390-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5zqB6R_iMbcWCgw8rCBaqUHv2wHO5PKy
X-Proofpoint-GUID: 5zqB6R_iMbcWCgw8rCBaqUHv2wHO5PKy
X-Authority-Analysis: v=2.4 cv=CoGys34D c=1 sm=1 tr=0 ts=69c673b7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=j567PbXuXaTzagYqJJIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4MiBTYWx0ZWRfX1EuzRX9/wEDq
 YozcjFp5Cc5mVbM4oCuOtXSJ+pt+oukLXwMKjhfEyPQaZs0OZuv+u61+Oz+vy6zwLOzNRJ/C9J0
 94MwHNUXmFRDn6Wy0NGEKJuEJBBDN2pzzxIAm2sRT/2BQPXSJ55HX3EnFppJ3rLVjw49Bnm9JzR
 cPW/YBS2o/DwBX0rq6IG7yos6mcEcLxdP6B1Dv3sR+SD5f2WZ2VqBPANZgBhhgNT5jEN8ml/7jB
 YhXQXiLfF3kukfnGPmJSOPv8EnZbHiFYDphVKcEH9uYxClK57Pcdeg7w43rTbKCaiYW6kGtU7VR
 zyLQxc57OXErMATORwL5+H3VsodL1q4pQCmuuMbp0zM/z9sKk3XornxZIuWjvPXLdtHTzpD4Sbb
 hxRSi5uQPHmTf0Ev1rjV8qMk5n+Y3WWEgstDOgvthnLeSYJqomeJwsUoIpCgHrcxnvQYIlJQ8Cf
 WMOXeZDgaCuRTEbnhjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270082
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-34062-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshal.dev@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8D6A13440AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/12/2026 11:57 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig    |   1 +
>  drivers/firmware/qcom/qcom_scm.c | 336 ++++++++++++++-----------------
>  2 files changed, 156 insertions(+), 181 deletions(-)
>

[..]

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 8fbc96693a55..2d7937ae7c8f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-mapping.h>

[..]

>  
> -/**
> - * devm_qcom_scm_pas_context_alloc() - Allocate peripheral authentication service
> - *				       context for a given peripheral
> - *
> - * PAS context is device-resource managed, so the caller does not need
> - * to worry about freeing the context memory.
> - *
> - * @dev:	  PAS firmware device
> - * @pas_id:	  peripheral authentication service id
> - * @mem_phys:	  Subsystem reserve memory start address
> - * @mem_size:	  Subsystem reserve memory size
> - *
> - * Returns: The new PAS context, or ERR_PTR() on failure.
> - */

Shouldn't we drop the documentation for the exported functions in this file as part of
patch 14/15? After this patch is applied, the devm_qcom_scm_pas_context_alloc() function
still remains exported and available.

Regards,
Harshal

