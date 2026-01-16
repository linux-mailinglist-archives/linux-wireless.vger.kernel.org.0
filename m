Return-Path: <linux-wireless+bounces-30915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CAAD338E5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8672E30AE78F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8889399A51;
	Fri, 16 Jan 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i42Www/N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VWnWp3T3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8733B6EF
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581713; cv=none; b=WamKTJY9pfkDUBZjkGJHXEOUyigLPMfuHmTkPcPfCjfQ5cB/LT28xWZJSspfFuwM8j76uSPTpEvhrT8CRA+v/pzJphzWMQqtngEsWjxpEPXmGEy9G7AUm9M94B3Wqc9++D3phqe2xOJDS7lC1pdtXd+znCq6pzpDQtmi3CsGg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581713; c=relaxed/simple;
	bh=0H54WM5icrDDsHWx0slJii+LQKMQlvrQdSIj++zZk/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5y3Jg9BqY9wlRZf6BcsxktvjgO/TAVzRyWGnkjkmxxgALmh56KAho54VB8G3llFzoTPzvihvTiz5SRbbp73vV1cJetK1OUTKpeGkNvq2jCedtjcgXVOdotWfWiHEwWCOqL658F+NKkOvgkPrii3JJynQjeGMgjaUIiJQr6UNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i42Www/N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VWnWp3T3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GFkjDt3714357
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 16:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iAhjhpP5g5sO71epspZ2mzNR
	fO/LIFwmhQneKuVWClY=; b=i42Www/NdZN6LzItRHhs1lGNrTjUffsxmgdOuTcw
	SwXr0VTXaQvPOZiHg58VQdO49hyLYsnLXM7E+rCHPl4SrIn8z6NQKLMcuOhXkes3
	TSfQqynYD0YJHu+72n2CBiBFnTOsOusQI0IyRrjXjefyGsjDZ1Gi0i9ANX70CBi4
	4JXhaElFc8ikkOrLQUHj6AsmlP6g+5Y76wPEPtc8mDp4Hf2VQHkZWqsjR916DC2d
	D0X8EI+oE4s5NRc9NJ8DORM+sb9ob059Q7n7gdhoL1ohDTQmGuEd4ey0Wyk+HcPb
	mF6dj2VDj1QTQRqU5iEilTmhMRYZyZkxgtbmtrdmpEpoVw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96pawcj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 16:41:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c52f89b415so553606085a.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768581711; x=1769186511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAhjhpP5g5sO71epspZ2mzNRfO/LIFwmhQneKuVWClY=;
        b=VWnWp3T3Wi4p510UfRAQ//b/ctaQa9Fb32R5I4OiyjJLMQWkdLuHj5T2Mk4IuGyToI
         11u72hTyrKXnf8Ed8OxNzH7BoCnr4ckHb9AoAbqDq4Rd8Hr4mPAAVXBcfdp6fbyHctD8
         /mMgbRWWPIuMbA49eF+8wqkiYnvd3ybrw/vnsqQtRllklh6ov2cPNr03FzUnX2QlQeTz
         IDknUWoNScow7tb8RgTpzgOzo0upG2YWvq6B5yvUXBWBBTD0fTjJIgkmdCwJqmBuDS+7
         eX4a4JlHfP3xr+HyWgtutcRZcx6lD5tTUIsLLjCFYXp/CNrYy9t0Sz8XTCcpAQClocUV
         o/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581711; x=1769186511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAhjhpP5g5sO71epspZ2mzNRfO/LIFwmhQneKuVWClY=;
        b=OwN+rH8eQksmCkS1FgKtZOaPPk+lfTlnmEiqFt2fgUufB5TbQ2WCVMTuBDvJt30Hmw
         wigW/rNvJJRuitifiDtUyjn8lzHuIX2VUCvG5tTF/C3zhGLH0mhhVuhJ+FJOuib2DPV2
         CDUhty7G0rEUNRGNPIWI7+VH+fuwAKHXIgJHSgrHB4wRpInUwMqPskxBX3A0j5mSOt/z
         RH9Ki8ElZxglPyYsVY5O1m2IKUkToP1mLys40YVeGV3/aDSk1Hs2du+dbFEqR6ChJ7af
         VaN3EAgh2LwBgpBMASMAty7qAiYsM4+wj5auBhlSteYv1GdWZjDoxh1jIk1T9A9mN4g3
         XAqg==
X-Forwarded-Encrypted: i=1; AJvYcCVrKDMtnlgPy8EtGZX9IZ9rjOSI2sLhbjawQFP6vxR1G4+I/9CqfwFojUF16bs9j17AMbJbqkAE1U2Yd/tJAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJXw18luAc/YxNk4aa2fpsm5TN/bU3YilUuj8/0cw3HHkdByV
	SRPLaMI6pz10zI2WqGkLHitMBkOm9j96yCszfkFVF3rcn/tzUAmso3Il92EbctKixJKu84TQj70
	S0Ju5tF6yJqM9iUYil5DT8doLTvelGUvF6RsK8tZrZPjTzslZkHObJCVt0RU5dalZTUU1tg==
X-Gm-Gg: AY/fxX4zyn0TmHPPuJSuckoylSrYhL/APVeFXcqML98qWnhwrPN0I5N4RGIsf+viYc5
	yuyoA5KaqnGJEzuemesdvZL5lb9b8UzWoKlwrA3Lm8+d05LcdhbpXcGOGPXLMaTxLTMaOIWW1hG
	vbxEnULiY3TjL/ZZ2nP5+zMfrKzykt2rt1ZPpAL4biDscDxiYSauyv5waD/K2Nv2oVsjDiRBpNE
	YwPCXEdeCi8A/zJ6sP6iX92u2W5MrZRTy5MChDtD4XTQ64RWpgrnKfxVUBEs5Odm4vgDJIHB69T
	O8avWMjySRFlqcCC5651In60LnYtPMJXVG9ASV3/ERdTHE0mWLX3QkUvKA612BHL1zypPCx5gg9
	I5TOewBE+ahw10sTy09XS0AYsjP9SJA/nzsmD9PP6U+yPz8hzZJ6UOBVepPwYedPYM3tWSswD6n
	pEL/3BrHqygELNFTwIGtAMbXk=
X-Received: by 2002:a05:620a:f03:b0:8c5:e166:fa14 with SMTP id af79cd13be357-8c6a67a12c4mr475982285a.73.1768581710561;
        Fri, 16 Jan 2026 08:41:50 -0800 (PST)
X-Received: by 2002:a05:620a:f03:b0:8c5:e166:fa14 with SMTP id af79cd13be357-8c6a67a12c4mr475977585a.73.1768581710052;
        Fri, 16 Jan 2026 08:41:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf3a4ccfsm899874e87.99.2026.01.16.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:41:49 -0800 (PST)
Date: Fri, 16 Jan 2026 18:41:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-ID: <d4ttsbhlw4c2fvgpfwgnc5mdh2egc6nwluj5pmkst2sunpn6m7@7b6by2eboob4>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
 <52b2b799-09e6-40a4-bea8-c7e8bf21cf51@oss.qualcomm.com>
 <15470b51-d398-449d-9017-304df5ad7cef@kernel.org>
 <132c34db-07c6-491b-bfda-f3c51462a184@oss.qualcomm.com>
 <f35b1380-b7d4-45e7-94ad-9f76973d3289@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35b1380-b7d4-45e7-94ad-9f76973d3289@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyMSBTYWx0ZWRfXwdw+xDWY5Je7
 ZqyW/zuS7OskWjyiSlcG9Wah4XDd25sXmwNVBKAcKfswZESoo+4FlcHk9WpyAQKxynvG2jWmKDh
 QtGWakCpIX85h6mCMCXtlyAo3usbfKMfNmcVvZqauWK4QmUU1ATLFxfJr4thOKNhkfgQVqHECaw
 KCoXM3oTSktukikwS0ZJ7B4yVnYcowHvCwnG+FABIASV/AEF2C/DNt0JwlgOvu4Ri9KU/7Lb8pW
 LfU3ZBlW5KIBtHUMjHNWvLswKZYuw39c9SyKkwzzQ8l2MAcXOyYtxX4FExFHqtJtCqeDYSaMmey
 X9lgxEcgfA8phv4XMYIbGFb94/oCLxXJksYd/5cwI+LV2bDK+bSGk4i+LFXjzvUZo3COcJjGUrD
 dQVGcQagj6smy9oN8HPe7jgTSDfaVqU2Z1EB1Y8WDXS0c7s7TpQtLU5eHb3w+HDfW0eCCnXYUrF
 uU+f1eKZQdlXYiLvVuA==
X-Authority-Analysis: v=2.4 cv=M7ZA6iws c=1 sm=1 tr=0 ts=696a6a4f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=d62U7F-bSLN4PTEm1scA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: PSesd6xMArWoTU6Xd4eFihObpqtYFEC-
X-Proofpoint-ORIG-GUID: PSesd6xMArWoTU6Xd4eFihObpqtYFEC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160121

On Fri, Jan 16, 2026 at 05:08:58PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2026 16:18, Jeff Johnson wrote:
> > On 1/15/2026 11:48 PM, Krzysztof Kozlowski wrote:
> >> On 15/01/2026 23:30, Jeff Johnson wrote:
> >>> On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
> >>>> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> >>>> voltages over internal rails. Implement support for using powersequencer
> >>>> for this family of ATH10k devices in addition to using regulators.
> >>>>
> >>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>>> ---
> >>>>  drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
> >>>>  drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
> >>>
> >>> My automation flagged:
> >>> * drivers/net/wireless/ath/ath10k/snoc.c has no QTI copyright
> >>> * drivers/net/wireless/ath/ath10k/snoc.h has no QTI copyright
> >>> * 2 copyright issues
> >>>
> >>> I'll add these manually in my 'pending' branch
> >>>
> >>
> >> And why is this a problem? You are not here to impose Qualcomm rules, bu
> >> care about Linux kernel. You cannot add copyrights based on what exactly?
> > 
> > I am a maintainer that is paid by Qualcomm to perform that role, and hence I
> > have a duty to enforce the legal guidance from Qualcomm when it comes to
> > contributions from other Qualcomm employees.
> 
> No, it's not your duty to enforce rules from some other departments or
> business units. Especially not without agreement of that person. You
> cannot just add copyrights to other people's commits just because you
> think that such copyrights should be there. Only the copyright owner -
> which you did not identify here and email address of contributor does
> not imply that (you don't even know what work contract a person has) -
> can add such copyrights.

In this particular usecase Jeff has enough knowledge about me and my
working place. I will have to resend the series anyway, but otherwise it
was perfectly fine for him to correct the copyright.

-- 
With best wishes
Dmitry

