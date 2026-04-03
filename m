Return-Path: <linux-wireless+bounces-34324-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DnHFamLz2mmxAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34324-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 11:43:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC17392ED9
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BCD330AFA3B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A99346E72;
	Fri,  3 Apr 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isxJvM2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YE6psOem"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4A630DEDD
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209035; cv=none; b=lsnScvd254B7EfIvE37qv0Xl1ao3CTRPJNg3x3uBB/BkPCCyUxQLV99jvU/qMsd7ODkYkGcZaeDQKo3ccPBEg9E+c1nt+qcG2AWOI02OOPMtZXNT8+2RkP4mBgj/x+P3X8NGpgrm9QFz8OWgYgjt5FAku9UDwxpYSMK23HlduUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209035; c=relaxed/simple;
	bh=SocuiM4ILZ9cYRA8mSWtuuuo4+IGmqWsxZXNi9/pB0E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqgV6B6tbqYbsZ13GkcMJMR0I4WbrTHXzOlppNeORxMk4bzmmVZIjMdRVU1pUdvp7AVVf7hxyXCYcRqRMrH22KaDre00I6QvciQJ9zRoXtNya3gSy8HtgJ7vMQDy4yLHBhBwYWDoQqWcUTYyVgCzGReianKXcD8b1Yq5Iq5eg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isxJvM2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YE6psOem; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6332JML42922030
	for <linux-wireless@vger.kernel.org>; Fri, 3 Apr 2026 09:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=H0MsR4PHC7LRNEDJ02SXHtGh
	86o8LwWKhT/z44z5dSo=; b=isxJvM2K/Cv3Pm0NShfaaEwkY51/yH2P37+roCBv
	lYrCcgbdhQHUYJxt9ZaYRXWC20+urqqeQP2i3fq42SxtBdpAbOyHaIPnzRWp93qp
	QhAms5skdcgdocGbuW8EEkhEUxZ3sTcKnETvEuiyk1+Pm3OocQu1n8HzYcRw66t4
	536ts+kxzBAJIVeVFBFgH3T8x2hYC18mMhBZriiWcTHzQDNU9C8b+kQqmV4xadiD
	mTBOHSS2dOrTwiGXGNamY2DF5T1mQ/6TJ4GlxtarDcpWup0gReaWKh75SsJBMArq
	yJ0mRgfT8xA5wWGvPp4wQ33YQwu38eZi/2RiBGwkpqwHTg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw0bwm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 09:37:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b274f94f8so21919751cf.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775209032; x=1775813832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
        b=YE6psOemUfR5HmLsDBfiwAdCvOyheUwag+N+QFNocDs05mVRaKN3hBok3UWv83YzwJ
         5q3X/munSmgPy6tMSN2AIhu9r8q6ebIioemMEws792o7RYJO4M09gddepSUVkxv8A1r0
         95vjY8WpNzZiKy6V0i8CSFppdBoyyw01Gvy9wMGz2OOiVjkwxjeo4bkoR9e7VLVastEM
         78qMsrFC5W5pneWkMJymPpSODFuiSIX+5tZy+M0I5GqFTW/9MxRvbcOpx/6LWWjTnCwB
         4a8DvcOi2oPqcu24m9fryxqNrfkVsqOnbt1z7Zo4ICOptY6cK/G5xkY3eaVTYscuLxOq
         8jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209032; x=1775813832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
        b=aJ6mkvaGeWyq+3oAkdLn+RGPfCSQMvSPS/RGev8NVaEGqlWn/n0KJL69UiavLuJQwx
         Dx3D1fz7PzKMT9V2GYElb97PIZuEpqKHOmANYfCWHa9th9SN2bp3p+er2/cx17QHV1q9
         Sf6XFNs/fX5tT62lRmhgdsbFl1bjcZVRiBkMmF19qkHJ14E96Yymszhb035afZsEnTg6
         hbx/rlL8V7Rvjl79tKe+fBVoOh2eFQWgh0ZyMAxVtA89Y1vf0+0SM/SFYP8Gztm8Sn6H
         BovwZOiWPatAzTyoU3vG/b3PGtzS8Sn25ZBRK8yZUf/eFwGjPKhN1brJ04bzsOQ/+1Li
         FShA==
X-Forwarded-Encrypted: i=1; AJvYcCWcsxQv1+Y88+E2HeAJMw//F8vu+LU+gTboj9Rabwya6bCLWmGpjPMUHTCN4yO4ATm/7UCQjVfLUvbJgscqjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSX5DpzCVjz+upX33o0t5VLApHkbXKZahNl4P22RUVVYyVgG+G
	uJY5YMmZZdUJzCyC4a100iUvbLks+F5exHyH4gxwj3jBKfF9CQhUzDtxktgXQm1RKNltbYByNOF
	pKFb+SV+VGTb6Qu3RlFhWPEsGWjCWWk9p7NTgXCWKXeUZUz7yAQ84+OZX5GF6Hm0LnHIcXA==
X-Gm-Gg: ATEYQzy1THzwMpUDbrOcBA5+yIbA99O4xOY/C7OmnR0thDB/39obyKAvvHzka5jQDyA
	FRFu3TsD8VlmMcgQTIx1ReFpy8USwc0iOutMkBhpR72fnGyrlUqKq4ylJKykCRJVdQ5SYN8yrdE
	N3YNzZoe7naWkeLyIvlcloMaGohqm8rBPpxPlp2A2D5OHiM0E3wA+pfoN6X2baGwK1EzQlt8g2s
	RrqwU13H95KOaDUlmpvXrhThQlsd/8y5cMO9mqTfCjsYl1tJYvpwFOIFSGAe9297iA101Nppx+6
	FV+O4sczkwAWS00ww1wA1id4ki9XwP81PxSrZhT9Y8SLNOJ+yfbh+fKvOtmQSvoIDj6/S6K6LCo
	KMyquAjpQRselDO2X2vVEUt7rK8NMe7hvTknm4aQZQaHH+aw09RM5Rqqu
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id d75a77b69052e-50d4fd24b4dmr66234451cf.38.1775209031709;
        Fri, 03 Apr 2026 02:37:11 -0700 (PDT)
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id d75a77b69052e-50d4fd24b4dmr66234201cf.38.1775209031263;
        Fri, 03 Apr 2026 02:37:11 -0700 (PDT)
Received: from trex (187.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm15010561f8f.3.2026.04.03.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:37:10 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Fri, 3 Apr 2026 11:37:07 +0200
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <ac-KQ7e8-syph1Zl@trex>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327131043.627120-12-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA4NSBTYWx0ZWRfX6DCCgA7IrjG1
 8EvzpiK32+CZy2BwYw8BDU3fXIbZ2rtY7xdQMbzhxH3PFgtC+ONxJ56x6wf5rpJengsygDCgQHV
 FDVCHCJfv4ivr9pTMJnwR4dt6RSM6/Tb+h3eqTDRSjm8Rg9jSDxTKxQwe51eR2WUXCIdY6v8Gwe
 Und154kg1ZnL7xzBZtzy2WrQozq9ZkDy6h0dQ1v1H0UnwlUpumPiftdb1h0+NYzELXAYMGycN3G
 w10GfT2CoGoPmQ9K3mxIABVJKCG3zZot+9URR+VgAP/UytzQyZU9mXVhuRXs+irk94CZUaqyFqR
 0Gg1s8lKREcgObAWtGuJoHvfrEXXlpBP5S2v15xl48ypUGpruvRQDvVOlL2lkSxN32QGaQZa8Ol
 F5mHRiLEyw7Niu0/szJN59Hgm/ReEvuYINiHA6BBlzm0FZdb87/UHmbXBq4RY4QjqpK++d3tZlz
 QAa7Ng01Q4QSiFGiPJg==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69cf8a48 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VPdg2FrOqWfiVCzsz0q0YA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=vWT0tKtjkO2eN-vK3vkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 88JOmLqLNmnL4MzRCJcXB2jcKZ9noWKK
X-Proofpoint-ORIG-GUID: 88JOmLqLNmnL4MzRCJcXB2jcKZ9noWKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030085
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34324-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorge.ramirez@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9FC17392ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/26 18:40:39, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.

OP-TEE based PAS service relies on the linux driver to configure the
iommu (just as it is done on the no_tz case). This generic patch does
not cover that requirement.

Because of that, it is probably better if the commit message doesnt
mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
implement the same restrictions that QTEE (ie, iommu configuration).

I can send an RFC for OP-TEE support based on the integration work being
carried out here [1]

[1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507

> 
> Along with that pass proper PAS ID to set_remote_state API. As per testing
> the SCM backend just ignores it while OP-TEE makes use of it to for proper
> book keeping purpose.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 

