Return-Path: <linux-wireless+bounces-26186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF3AB1CC49
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 21:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299F87B0CEC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25329C335;
	Wed,  6 Aug 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JeWbuwM7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD628C5C6
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507232; cv=none; b=PBfXHwAZjkV3LuLpANbXC2TKdfV/uNjHUluPztne2EZ+r7WvsSRe4vXQYMZxEP/RiiD9gBxXs5wbzJaYFVy9/N3VktH/AkROg1EUkKPHrATpHHjSzbHat/HSmnuVXx/URiIsHiDIzkC3tGbmRgzsWBaUOJGlyPnbpVXxv/qWDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507232; c=relaxed/simple;
	bh=D2fRxsjumskahvRxe7m7fBnGGGqxjZOKk26cSPbI7OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXOM65ATPyq50eWS8cnhYNS9sHFOdMwfarHuLfxHjUNMkklHH2IwZqWzbGXGnC9T0TrTSTfJMSlzN1/pmraHsAc9CkH790aIsq/JRzn3eU+TZ19o65y2n1RRqSsZ2FBS+6iCWaR8bc0awhmgy/pk/oxEkzjBfb5qoT2D6ay8fNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JeWbuwM7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576C1wrp020382
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 19:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLFDFgtgIMICdEJ792w168OyKixfYM5BYvfWCMHrn0A=; b=JeWbuwM7PL0zAmGW
	+VETreTAUCzm2n053JSNWrko8eWL6LoLI1ezrYAhMJtsVrM+wRZeh3pnIl5k8OV0
	IdE5Y4F2MyaevZLKAcQ5sd9PyxGj8JmMvTgHFxoCGMdr6uUrLo2EfuBT6qdkmKYn
	k3+ifV38vlVJr9NPx6atLCZtMVPbTRo4uzBIFc5v56+rn5NAkjd8IoUV+x4CjQJy
	3baZtNqsShLgsD5rEk8GJMOSGW/wvI4FMys+cNtla66buSDnWRjtmeOMbIKleOfw
	k7X1v0BMLkW/ynYrT1WYBtUCTdbD+D157ShPCNbrdk71zyvtHVbk19hHLzU9mLHs
	4P91jg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1bt3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 19:07:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-242aa2e4887so3763975ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 12:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754507228; x=1755112028;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLFDFgtgIMICdEJ792w168OyKixfYM5BYvfWCMHrn0A=;
        b=sBp0rEnQCBUK8/zJKkXLOfK3lDC0POtJevebtBlx8hfKJXAjMTbNDc09FeZrab1mA2
         S+pkTwr2Bbn6quMPOZA1SZqEybi5eCg/ASxr9joDOOqk0bAkHZ3gVxsj8HMXTtwH7V92
         Irw3kKU9v/ppsbdEdG9EMIISDbiTOJoncCb6koYDp+u9DumMAvjTC18Bm2nqUPfumqfm
         4fNZbvaqYUd3cZpO7ikhIZM2TCm3WUvGTfDvrVyPjyVfjsfDVPcLvUX5ylxXPQ8/G/GA
         geTmv3+BVTvXChJ+I/eCCa6I476cIa4JP19n6ipPr7naQX8b6J7lEDhvx9VZT8y4QeRx
         uCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9DfVl1ZFZE+bG4luqZ2S+gnm2uZgJjReyWZ5Y5EtaxAP7H4lks4Yj/t65SY8ZzP4xK5ZR0l6xLM2dC+nsmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwXZDJCw2p3Rod73mrnajLgD1i5m9uaPnh6URaZby5qThvPBe
	daOWM6mXaEsoz69xYxfszYkZegWWSHI4wEV7dIGhd34RYMEVg9Qw4ZvFxnobT22nf121OUSKaim
	OvyYIsUKFlgqA9VCMGBj57M3OOeAon7ckd3VgKVglPtrcSbtS3P5wsiAuGOHa/Ga890DfzQ==
X-Gm-Gg: ASbGncu7xwxv0I6IANa80Ey0B3LfnDwRNPixkL8gQxQjkaonjC7vzveBhyKH6x0oe5d
	7VrZsKsVxVi3GKjPDxN0gycfGxI1aaCALWl7VhlHUqJ2pqFpFrgvY56/kb0IEMCZZUdGNzRyPJG
	ivJpLwryZPDHw+G11/aBXFk49T/DA0E35eJgH2WW4ZyzScuGI/BSvDSBAnIRqpscjBetHrSKMZ/
	EZmIkvwo6T5Qto5S41OcYJ9QAi1cPKFm+p0UVArroHpuZ9oFj8sSQ4UgAx/+wwvHX9xslw78vFC
	A+lf44rWVf4sOZHgp6TotPlJ4oNXqqgKpWrdWa7Pi/3M9R4eogYvBHz3IuulKkux3qwCUGz0QqB
	xZOSxmmgtBtNk+MnMd0am9y2yTzAuiRmj
X-Received: by 2002:a17:902:f612:b0:240:469d:beb0 with SMTP id d9443c01a7336-242a0b6fc4cmr58557415ad.31.1754507228310;
        Wed, 06 Aug 2025 12:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw/V0KLHuGmmP97g4XfNxYYUiYQuA+Las853A79Nu5Cd7FLuHDuerRqAPRejldbNHXAC6rXA==
X-Received: by 2002:a17:902:f612:b0:240:469d:beb0 with SMTP id d9443c01a7336-242a0b6fc4cmr58556965ad.31.1754507227919;
        Wed, 06 Aug 2025 12:07:07 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef75bdsm164814515ad.11.2025.08.06.12.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 12:07:07 -0700 (PDT)
Message-ID: <c9d761a2-7121-4ce6-84c7-232a6c4ce976@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 12:07:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
 <20250806172531.1865088-3-mukesh.ojha@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250806172531.1865088-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX2/Nsw+PECmZz
 6+pE0NTtQqkZ1XmWO1Fsok5/Rel/fua5nlsv1W8XHecIGDHo1EGTisZv3fVzloMRT2lgIpgAfr2
 ZxC1ArlIDHXGuk89YFtPHw7820WwwBvGID6BUjYhdNvf9SOm47Dtdp/18DVBkMueo0JGFxH1Phm
 FL+/06H2P6wL3tnIr7dofk6kzgmEPJ0wQjl/I/pWELarVt5z1rmcLxJxHPsvqjyaWLkVuRihVl4
 MFbFrwceX91EIsJZrcD84ll6tQ1qO+9rZQGD/tNIAb0rRMyv9JGQQMfgUwGAGRLVTkpHMAuz84N
 Tf/oIQpH9Zh5ndjH0K4rptVPdKDJVPf2WxAHQxC8Q85eJsmG0tYf+NPTtYyayHO+stim3SiSMxl
 ZtgOesky
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6893a7dd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=IDvrs2r2PCma8_SM7s4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: U9tb3-rVqEQcdCniYVkBOBFItcC59zcP
X-Proofpoint-GUID: U9tb3-rVqEQcdCniYVkBOBFItcC59zcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/2025 10:25 AM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
...> @@ -353,7 +353,7 @@ static int __qcom_mdt_load(struct device *dev, const
struct firmware *fw,
>  	if (!mdt_header_valid(fw))
>  		return -EINVAL;
>  
> -	is_split = qcom_mdt_bins_are_split(fw, fw_name);
> +	is_split = qcom_mdt_bins_are_split(fw);

this should be in the 4/4 patch


