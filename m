Return-Path: <linux-wireless+bounces-35635-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE1UHY0R8mmlngEAu9opvQ
	(envelope-from <linux-wireless+bounces-35635-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:11:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB141495685
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1393042240
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737C3F7A9E;
	Wed, 29 Apr 2026 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzklY3pE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oqvqhyyz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFE364E92
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471499; cv=none; b=qYHK6c9Dz8bUEgSJO5KKe8m4diGAaNT0/xo6T1dUXOKbKeahgap2dnh8tu3CgwZES05YnEO1dgh+TDjNFf3BPryKcznxMXQWZi/sRgjTO33AXkHBiwZpLdro6PmLKsm8SH3x/TSFWDpv1GVuXb6w+P8tyzHLeuCaUK9d12zmiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471499; c=relaxed/simple;
	bh=S6wX+gTzPAvcCMKGMzHVKpxGRSVZp3HgiObGvUJwvgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh8ulp+kN599x6zW77AicF510uRb3KJ3WtN6QWYB9rnFcjhrvxZ1bn01W+a5K3V85d4gtmFdDk6Skt4j/ahWVXmLa/KVuJwNz91yV/PljBobhICiZDu1sH0wBjlmQ07yc8mGCNBXHKFEGXZW4G1VzQatvPIRsIdHDMTWGqF2SSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzklY3pE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oqvqhyyz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pnFq901608
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5geFPuppNEw0Na2cpguNPJGL
	4nGh1NRsp1YB6ryaOE8=; b=UzklY3pEYefS+bOkeBxtQUZQD+IPj7gXWaOzbRS4
	WSH7uI1wuHaUtu4VHRYIMvEaC8Ce0Evo+1qCEfaXCuS5ZjOepwbErwHPT64k34un
	SbcLc4hz3Yyoroyb3gjlgim9TtWDtoikFNBW9OgPOx+e2y7su/Kq1/tXmPTWiAYZ
	LKsObFeI2pSfqRgSI6in7sI2towKK+tr48YfWNyZERAuT1Y+/k7VL9nPYI2Rm+MG
	rnEcZGfao2k8+8039tDSPeRRbTv/tEPjbLqp4NrDRL4nlwgeOh464GwL7tyN7NnV
	qY55lUizS1cK2Jl9wXKawsarLCHU2ioQmRBhk/Lcn91pGA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9j0c1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:04:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7ada7b25f0so3965383a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471497; x=1778076297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
        b=OqvqhyyzhU04Ko9ryYHrEnQ8Z7+0PUmnKAj2kURoZH33eCbYTmiWvchFka77Wgrilb
         UIouHcS6aEM/PC/PXWLZnvRJWy2rBjumtOVmY671+wVsy1lZ5a9IPhFxCVJOdV9eqJ/M
         XNOebnfjcjDOk1kztfoz8FK1iWHlkCnFc9g+iVR7Q0JJeJkB8F+524rIE//JVRFk91Na
         VZR2mMbrc4KjSQZ600GIKcO6TS3vVDZ0CBp6oK+4jbJlXTRE7kVhdIyMtLngExXbkDTS
         uCI1rx6RZ5EGbSFNi3mh2STu0Cj+dWH7TA1u5JKEbmNvjGy+0UtEe4petkLFQDaleIqF
         S/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471497; x=1778076297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
        b=aaiA94llKST7UX//UOxR5yPaaKRI83XT9dG6aZtFeJdSm45OEq9+YZ0Qy8KsxGw8uK
         RRl3TDVTha05oTDNVFd3GDQAJRXxjJGBVhL3Kxf+jOOItP+2ZI3V9KF0u9unyO/4dSor
         9hxEcCYW2gcfliDxKYRN+92kLVSjrr7ZyC9NRoec0QXJe5TX1JlROKKCbUdysfclOvz9
         bWlrz0JHs/f0MFKsCbbf1N+hYfSR2qFOkzIE6fMeJV6efHgIGb44dtgkQuXEEj16BteC
         IZ1MqEvHCHHf2si7/zIuRLZF/1kX98ykPle91/23zLQdEYC2TOrV/mEccC+5FkjKXZso
         FMKw==
X-Forwarded-Encrypted: i=1; AFNElJ+qFnbQZSMuiVwbOG3kE4RWFPGJr8Zhfpsgb+2kkPYUpvu5/9+zfLQBRU4dHJjzjEr/V0MgkK1L59qCinteTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTI3Q4SrsCQzZZ8xqrO/wZeR8n+0WEPKz1OHYy6PrnOaCKNtnR
	eum9nqpkSYqfcx+W4T1dVMm13n+K7lNHoba8xv+zNd7Q/yHdndVD6k0mXS0MPP0x9uNmM65SwAD
	5EiqN7RCLes9e2z/NJIA0tVpMxtJcKb+ifjvXHtCyhMRsoNjMaPA/3896FJuUTBCZR5S2M42pT0
	kK/Q==
X-Gm-Gg: AeBDiesOEUFjmQ7jSIbKNZtjCLd0gxcEp4MKlr3RiJoHImcTspOhBiGeg43pNj+NQQ7
	gZ3Ha4M0g6s9lvHhlDMZr2hy123sS78wvC7WAivC47zgTWWnwztn/yTPsxPN/7ZYMt2PjRAz6V1
	0/3Pxsy8ChDyhKgr1f9jFYcv15Mb/HHB4J7ljOHtlo4DcUcPoaozh/y+XmXjgkga4OeX4NWZs9h
	smBZBGONH6kNQX8XRXTvb2RAmUHpOOH0gmCuHlzZj4XQ3dWOvWakhWQUTX0OMDyFizsH6a358MY
	OGswiin8w3tyKw8Jqmg6WCCFO4J9yrNid4TCkmxtJMCKo5SRqIMdqal8apHb5RuLlgiEsno5Mck
	OewD3mhSuZr+q3hoFi53y6yuOZwNT+c2nh1t0BY/6f/KCDP9ORgtEwyjXjJk=
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id adf61e73a8af0-3a39c2722a6mr9041401637.28.1777471496931;
        Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id adf61e73a8af0-3a39c2722a6mr9041274637.28.1777471496127;
        Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd6506af1sm2270618a12.25.2026.04.29.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:04:55 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:34:40 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 14/15] firmware: qcom_scm: Remove SCM PAS wrappers
Message-ID: <20260429140440.ov7x75bikyvs7w5y@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-15-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-15-sumit.garg@kernel.org>
X-Proofpoint-GUID: lPOxyCRrufVbTqr1zrtecy4vBB_CCq48
X-Proofpoint-ORIG-GUID: lPOxyCRrufVbTqr1zrtecy4vBB_CCq48
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f21009 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=n1VOVlC_Xzu4QXtT9DgA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX8NSjPd9mi8io
 LgY9tV9Au+PTvktqdkzb44cGByIHu7CKPO9HU2fQcDO3Ywijb30q+HCZAAMt7ju+v6MeWIy1ugz
 lhhh57gKzmb88IkSusqv+Ya6zDYCFfTl3wagcMS1JiaJna5Nsesxn7455RwU6i+H2rUIAJTM1TB
 TFN7AgpnKGS2ykha8irhTdTHQuywyaZbkTCZ77Dj9GPTP1YNHBItIbHllodPcaTkHac80E4wZT3
 EHts9qcECQbYZgPjHckEx+zeTAOZYONnF5Zm9ndE1G1ukivTGUweDWJIAb0aT+KBvSITscDduEz
 eqfnB9dkn0LFgb0uGpIhRJ5eSp6KHjEfvUSAQuKga56Zyic3WfFpe6xebjYKE1GN01C9dotQw3j
 qNwAduyNuU+DI28EVHFf6vUd5iPpMq4QWfwCJ25uDAXkL9zYeCjtPe/CvZjHX8GmCHWckAD+0Gs
 ZoF//lkMO77Trnm2ReA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290142
X-Rspamd-Queue-Id: EB141495685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35635-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:26:02PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Now since all the Qcom SCM client drivers have been migrated over to
> generic PAS TZ service, let's drop the exported SCM PAS wrappers.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>


-- 
-Mukesh Ojha

