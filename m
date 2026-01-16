Return-Path: <linux-wireless+bounces-30895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32113D2A6F3
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 03:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C57053026876
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B22342144;
	Fri, 16 Jan 2026 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvtn6roK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idKNgPg6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F28271450
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768532278; cv=none; b=hV9r1vCSrrRN9m/iqa9v8GlIqjn3wgMRHEbXK8LKVd6Y5CkP/qkHX38Tid9O9k9Oa1EF1O/IvMk4TNB75yigVj7YwtBajr1S2QNAGf0Lg5ISbIfORtPgX4QwJyV2cNxTPCbPt6tXWkMHAajlCf/OD0WbmIBdyHRwvbN9ZtGNLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768532278; c=relaxed/simple;
	bh=mHFtDo1b6G4mIW5vvb4D8Xxgfyc5Fbt63oVVDEDFJcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmGSm1zidayuuSeagqS8rOEpfvniZpVB/zUjawyDCb0HgjE1oemJR++Abza4WQDo60B/vQT7BbCSVJke9lQDgIrM2Mggfdybg0d53+M6Vy0N5dqdzejWUgcT02rulr77tcZQuQl8GPKiJX5NfHqHTi+xYPm5NZnvMYLNySvlxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvtn6roK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idKNgPg6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMheah2819336
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 02:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EA0PgA0/LPBITWEYyXie9wh+
	KymQ/5ynEDnlQXiuIHg=; b=hvtn6roKLvsf+MkLAkKGRtN7OwhnbvBf0c+RrLBA
	Y+GIhhSS7dxlconWeSpzFS96+pdf7bqyPS4FyCVZVee5A4fAuhntpHPQCYyomOF+
	l1WhTobjarfja+wJWC+9saFbB7a4GupYMIcqbOrSug8ztV0KWa+3X0Dnl0JbZrA3
	1kYdnGcr2bVnNkjkuheJEPG+qsh+4iXlElaD+4Sp5kjDqlBIBkq7JtMs9TBNqvpG
	jUd/+Kwd98BlGcV8+CI7oGvrVZl3tbGOcpqbxCa0rV2RASQT0r1s0PA42F3M3l32
	DUvlVsp/FEXdYT83Gg9b23XMv7V5fXSAtLxQgYnSpNiAXA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99aghr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 02:57:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a5bc8c43so198925185a.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 18:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768532274; x=1769137074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA0PgA0/LPBITWEYyXie9wh+KymQ/5ynEDnlQXiuIHg=;
        b=idKNgPg6HUfeAX3VOfyPWs83CfVdJnvXqWcgz/i88t7ZBSn2o7u7Y85iOYILsNN/mk
         08d9zPKGIEadLKuGIlOsP6PrmuF1ltcoVPlqTnlthrv/BeQu3Chm40HgSvPTVUUYFr41
         eZWlrvg9jZ0n5VLYv6nqEnIqnI+y/BP6OAAaxEfbh5pxNH9ZE9Ypo5h21rF2YjCwxb2u
         Sz1joaqBCl3B62iCDIspaygH+BkKkp1nupNuV2QVL0DcpZJV5dzogqpelDH/Ede3rwZy
         CHUtvaBcQ8iAQ9b348Nu+uGrKa093RIgKnMSEG9UpQY60Eb5bE8PyXfA1cGkcmWUfVBS
         So8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768532274; x=1769137074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA0PgA0/LPBITWEYyXie9wh+KymQ/5ynEDnlQXiuIHg=;
        b=DFkuhV5cn6TpxSEDcBV1CK4OfYvFpi+0mT5HYHXB9xZWl5dgZYevfyh7lEvp/pwowr
         y/WHQ7WifNEshcXX2jOWToBqOBSI+0EM43APYR5L3aV56oqvSJW0eH4veIMf003VGLjF
         PTUc6FdWHvov22rI5EfI/cjKgzOLBND4lyQzvXgmzwrzq6G96iXEw39CiSiyoxvRE6By
         FONZvo7LG+2lnfPMaGix9AgQWGdLlXvpk5sQPif4FbIRd11QA+Ce7RxUEls1CPKP7j8a
         bDPIv+SaBCHlO2ubQLajpqpNHDgCUnPl60y2NkfzYHlTAkpm0BVND52buA45mQ9wSEK2
         hJLA==
X-Forwarded-Encrypted: i=1; AJvYcCXr/qwZuD16DD831bnzygBHCsDSLUl77uITfVCT3FinGYiP801YzouD/UMJ/ExJ/sysyJgtwsxLFL2ll9GacQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNKiq3C/flrRD3ZefRDxw7Gs7aoBjoOAahmUt6kQe4AEyNK1y
	UJUNUaukIYSthGo1TMlTsJnm5KpPhFCcpZiBJRc4nQTfd7bx9yoRD7nEHFBgbIr6UgPyzkqjE56
	+y1hvnzfEvTBYqiKi66SfA+YMW2yMsS10lbq8gZ35L7Uclr99P2s37vYtJq1lYCcA5JUpYA==
X-Gm-Gg: AY/fxX7EwO/kNLHqWm1z8DgClMCmY6HrVsdvlEimbQpcnqmnq01hws43LelLH+Gfqan
	vLrp3vExUIELe7U2b7Ct04n6gaT1kq4I3sk4AF7JRmhk2YELd2DzRVXObfSfVnZYcSrBJ0umnDC
	CbJPCI6iaHQ4S2JMx9d27Z3HRDpK1SM979zp4/8c0tN1XUb5Q8U/aXDYCqek2SnGcGhegCy+LRr
	usbUswS77GrIHc44Kf3ICBE8IXfPSSQJ3HQ5hdrLQXbZALVPXgq/ANvqnYqH+MpnM0htfHaGarh
	iR0Z4+1QPOWYe5O7ArDl6eeeVR8joPhtqGYWv6oc1UgR1b+1QxMWl54K847ZL1M5oIPjNxthNka
	8C+GY3GnUS+qF9qZrGKlrQirw2PKrXyFdftCEAByxFGcbFLbMnF/bcYz1fGA4e3WV73aV6RA2JG
	zopY5nf+lZs0VSTiyz8UsviPA=
X-Received: by 2002:a05:620a:4544:b0:8c5:2b63:2d21 with SMTP id af79cd13be357-8c6a67bf47bmr235712285a.88.1768532273832;
        Thu, 15 Jan 2026 18:57:53 -0800 (PST)
X-Received: by 2002:a05:620a:4544:b0:8c5:2b63:2d21 with SMTP id af79cd13be357-8c6a67bf47bmr235709585a.88.1768532273306;
        Thu, 15 Jan 2026 18:57:53 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384f85b8csm3334171fa.37.2026.01.15.18.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 18:57:51 -0800 (PST)
Date: Fri, 16 Jan 2026 04:57:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-ID: <jxnfzb442ii2ucbttlcu47emycxeqn2bvu5vi6xjdis77hkes7@tshuuiwv6fte>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
 <6db7a42e-7f12-499b-b36e-687ec93b2e62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db7a42e-7f12-499b-b36e-687ec93b2e62@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 6xAPheK74VpweNZfHTMqQbhs5VB2y8TO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAyMyBTYWx0ZWRfXzaFHpYDEqO2i
 C3Ub1gL6/09sjmVnFk9gO6mLhKZJWf3mqi2j+kbORHFWg9DnHPb1CqxQrGvvtHHGiZyaxkaGwhc
 9YjchHNGoMB3JQwzw/6nez2fkM6yPja+01tYSmBbaYLBLMBahLv87ofebL50RceIHqwgMGtVxFo
 ynOB1p+Trbxyh40PjBBUPA4stEzsHH8a4Ocq4AGoP2JghxRQfjhU9kHG1OxbMaXr7xZZO5x8RH5
 TUEwFctrxTgBiw8fxB4ef3NJVShrQqZb5RhFlT4LFDBGTuwfpnFqu+lHbbVI8TnZpLJTYabiE9I
 2ip/kgEunrKcjcLVwhXj610AawVQiC18iDxecWZRwNqLtKjC0tVNpU3286E3QtS3G5EzfvNiKdA
 FzLr2ed9is3zdhdnZ8pOZ2HcXKQXNHrIM6zWNzo6DYYBDBAilSSg3kQ+KC2RYatg3W8+5PNsSnJ
 4rqvSdwhKP5WMD2pLqg==
X-Proofpoint-GUID: 6xAPheK74VpweNZfHTMqQbhs5VB2y8TO
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=6969a932 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mLrUVEitaDHWRjaOxVAA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160023

On Thu, Jan 15, 2026 at 03:12:19PM -0800, Jeff Johnson wrote:
> On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
> > @@ -1023,9 +1024,15 @@ static int ath10k_hw_power_on(struct ath10k *ar)
> >  
> >  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
> >  
> > +	if (ar_snoc->pwrseq) {
> > +		ret = pwrseq_power_on(ar_snoc->pwrseq);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
> >  	if (ret)
> > -		return ret;
> > +		goto pwrseq_off;
> >  
> >  	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
> >  	if (ret)
> > @@ -1035,18 +1042,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
> >  
> >  vreg_off:
> >  	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> > +pwrseq_off:
> > +	pwrseq_power_off(ar_snoc->pwrseq);
> 
> in this function you conditionally call pwrseq_power_on()
> but on error you unconditionally call pwrseq_power_off()
> 
> in the below function you conditionally call pwrseq_power_off()
> 
> so there is inconsistency.
> 
> note that both pwrseq_power_on() and pwrseq_power_off() handle a NULL
> pwrseq_desc so is there any reason to not just call both both functions
> unconditionally everywhere?

Indeed, it should not be necessary. I'll send a new iteration (and also
update the copyright).

> 
> > +
> >  	return ret;
> >  }
> >  
> >  static int ath10k_hw_power_off(struct ath10k *ar)
> >  {
> >  	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> > +	int ret_seq = 0;
> > +	int ret_vreg;
> >  
> >  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
> >  
> >  	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
> >  
> > -	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> > +	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> > +
> > +	if (ar_snoc->pwrseq)
> > +		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
> > +
> > +	return ret_vreg ? : ret_seq;
> >  }
> >  
> >  static void ath10k_snoc_wlan_disable(struct ath10k *ar)

-- 
With best wishes
Dmitry

